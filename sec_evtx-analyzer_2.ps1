#Wertet verschiedene Events aus dem Security Log eines Windowssystems aus


# Event 4648 is logged when a process logs on as a different account such as
#when the Scheduled Tasks service starts a task as the specified user. Logged on
#user: specifies the original user account.
#User whose credentials were used: specifies the new user account. Caller
#process ID: the process that performed this action. Look for a prior event 4688
#with the same process id. Target Server Name and Info have always been observed
#as "local host" and source network address and port as empty.


$results_1102 ="The audit log was cleared `n"
$results_4608 ="Windows is starting up `n"
$results_4609 ="Windows is shutting down `n"
$results_4624 ="Ein Konto wurde erfolgreich angemeldet `n"
$results_4625 ="An account failed to log on `n"
$results_4648 ="A logon was attempted using explicit credentials  `n"
$results_4720 ="A user account was created `n"
$results_4722 ="A user account was enabled `n"
$results_4724 ="An attempt was made to reset an accounts password `n"
$results_4740 ="A user account was locked out `n"
$results_4741 ="A computer account was created `n"
$results_4767 ="A user account was unlocked `n"
$results_4776 ="The domain controller attempted to validate the credentials for an account `n"



$date = Get-Date
Echo "Auswertung am: " $date

$startofmonth = Get-Date -day 1 -hour 0 -minute 0 -second 0
$events= Get-EventLog -after $startofmonth -LogName security  
#$events= Get-EventLog -newest 10 -LogName security  
#$events = Get-WinEvent -LogName security |Where-Object {$_.TimeCreated -ge $startofmonth}
$events.Length
$results_4624

foreach ($event in $events){ 
    #echo $event.EventID

    if ($event.EventID -eq "1102"){
        $report = $event | FL TimeGenerated, Message | out-string #-stream #| select-string -pattern ""
        $results_1102 += ($report +"`n")    }

    if ($event.EventID -eq "4608"){
        echo "1"
        $report = $event | FL TimeGenerated, Message | out-string #-stream #| select-string -pattern ""
        $results_4608 += ($report +"`n")
    }

    if ($event.EventID -eq "4609"){
        $report = $event | FL TimeGenerated, Message | out-string #-stream #| select-string -pattern ""
        $results_4609 += ($report +"`n")
    }

    if ($event.EventID -eq "4624"){
        $report = $event | FL TimeGenerated, Message | out-string -stream | select-string -pattern "TimeGenerated", "Kontoname"
        $results_4624 += ($report.Line +"`n")
    }

    if ($event.EventID -eq "4625"){
        $report = $event | FL TimeGenerated, Message | out-string -stream | select-string -pattern "TimeGenerated", "Kontoname"
        $results_4625 += ($report.Line +"`n")
    }

    if ($event.EventID -eq "4648"){
        $report = $event | FL TimeGenerated, Message | out-string #-stream #| select-string -pattern "TimeGenerated", "Kontoname"
        $results_4648 += ($report +"`n")
    }

    if ($event.EventID -eq "4720"){
        $report = $event | FL TimeGenerated, Message | out-string #-stream #| select-string -pattern ""
        $results_4720 += ($report +"`n")
    }
    
    if ($event.EventID -eq "4722"){
        $report = $event | FL TimeGenerated, Message | out-string #-stream #| select-string -pattern ""
        $results_4722 += ($report +"`n")
    }

    if ($event.EventID -eq "4724"){
        $report = $event | FL TimeGenerated, Message | out-string #-stream #| select-string -pattern ""
        $results_4724 += ($report +"`n")
    }

    if ($event.EventID -eq "4740"){
        $report = $event | FL TimeGenerated, Message | out-string #-stream #| select-string -pattern ""
        $results_4740 += ($report +"`n")
    }

    if ($event.EventID -eq "4741"){
        $report = $event | FL TimeGenerated, Message | out-string #-stream #| select-string -pattern ""
        $results_4741 += ($report +"`n")
    }

    if ($event.EventID -eq "4767"){
        $report = $event | FL TimeGenerated, Message | out-string #-stream #| select-string -pattern ""
        $results_4767 += ($report +"`n")
    }

    if ($event.EventID -eq "4776"){
        $report = $event | FL TimeGenerated, Message | out-string #-stream #| select-string -pattern ""
        $results_4776 += ($report +"`n")
    }
}

echo "Ergebnis: " | out-file "./evenlog$(get-date -f yyyy-MM-dd).out"


$results_1102 | out-file "./evenlog$(get-date -f yyyy-MM-dd).out" 
$results_4608 | out-file "./evenlog$(get-date -f yyyy-MM-dd).out" -Append
$results_4609 | out-file "./evenlog$(get-date -f yyyy-MM-dd).out" -Append
$results_4624 | out-file "./evenlog$(get-date -f yyyy-MM-dd).out" -Append
$results_4625 | out-file "./evenlog$(get-date -f yyyy-MM-dd).out" -Append
$results_4648 | out-file "./evenlog$(get-date -f yyyy-MM-dd).out" -Append
$results_4720 | out-file "./evenlog$(get-date -f yyyy-MM-dd).out" -Append
$results_4722 | out-file "./evenlog$(get-date -f yyyy-MM-dd).out" -Append
$results_4724 | out-file "./evenlog$(get-date -f yyyy-MM-dd).out" -Append
$results_4740 | out-file "./evenlog$(get-date -f yyyy-MM-dd).out" -Append
$results_4741 | out-file "./evenlog$(get-date -f yyyy-MM-dd).out" -Append
$results_4767 | out-file "./evenlog$(get-date -f yyyy-MM-dd).out" -Append
$results_4776 | out-file "./evenlog$(get-date -f yyyy-MM-dd).out" -Append
