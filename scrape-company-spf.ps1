function OpAddOutputObj {
    param (
        $Domain,
        $result,
        $spf
    )
    return (New-Object psobject -Property @{Domain=$Domain;result=$result;spf=$spf})
}
$CompanyNames =@("Some Company Name","Another Company Name")

$Domains =@()
ForEach ($Company in $CompanyNames) {
    # You need install/load this -> https://github.com/gfody/PsGoogle
    $domains += (Resolve-DnsName -Name $(([System.Uri](google -o -n 1 $Company).url).Host -replace '^www\.') -Type TXT | Select-Object Name,Strings | Where-Object {$_.Strings -like 'v=spf1*'})
}

$OutputObj =@()
ForEach ($domain in $domains) {
    # Based of https://ficilitydotnet.wordpress.com/2016/02/03/spf-validation-powerdshell-script/
    $y = $domain
    $res = $null
    $res = "" | select domain,result,message,txt
    $res.domain = $($domain.Name)
    $web = Invoke-WebRequest -Uri http://www.kitterman.com/spf/validate.html
    $web.forms[0].fields.domain = "$($y.name)"
    $result = Invoke-RestMethod http://www.kitterman.com/getspf2.py -Body $web.forms[0].fields
    $message = $result.replace("`r`n","--")
    $res.message = $result
    $res.txt = $message
    if ($message -match 'SPF record passed validation test with pySPF') {
        $OutputObj += OpAddOutputObj -Domain $($domain.Name) -result 'passed' -spf $($domain.strings)
    } ELseIf ($message -match 'Results - record processed without error'){
        $OutputObj += OpAddOutputObj -Domain $($domain.Name) -result 'passed' -spf $($domain.strings)
    } ElseIf ($message -match 'Results - PermError SPF Permanent Error: Too many DNS lookups') {
        $OutputObj += OpAddOutputObj -Domain $($domain.Name) -result 'PermError - To many DNS lookups' -spf $($domain.strings)
    }
    ElseIf ($message -match 'Results - TempError SPF Temporary Error: DNS Error: exceeded max query lookup time') {
        $OutputObj += OpAddOutputObj -Domain $($domain.Name) -result 'Results - TempError SPF Temporary Error: DNS Error: exceeded max query lookup time' -spf $($domain.strings)
    } ElseIf ($message -match 'Results - PermError SPF Permanent Error: No valid SPF record for included domain') {
        $OutputObj += OpAddOutputObj -Domain $($domain.Name) -result 'Results - PermError SPF Permanent Error: No valid SPF record for included domain' -spf $($domain.strings)
    }
    Else {
        $("$domain -
         $message")
    }
}
$OutputObj | ft -autosize
