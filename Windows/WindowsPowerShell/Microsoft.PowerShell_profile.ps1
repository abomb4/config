New-Alias l dir

function cd_to_up() {
    cd ..
}
New-Alias .. cd_to_up

function Invoke-Admin() {
    param ( [string]$program = $(throw "Please specify a program" ),
            [string]$argumentString = "",
            [switch]$waitForExit )

    $psi = new-object "Diagnostics.ProcessStartInfo"
    $psi.FileName = $program
    $psi.Arguments = $argumentString
    $psi.Verb = "runas"
    $proc = [Diagnostics.Process]::Start($psi)
    if ( $waitForExit ) {
        $proc.WaitForExit();
    }
}

function edit_hosts() {
    Invoke-Admin gvim c:\Windows\System32\drivers\etc\hosts
}

New-Alias hosts edit_hosts

function setjdk() {
    param ( [string]$jdkversion = $(throw "请指定Java版本为6、7、8、11、14、15、16、17、19" ) )
    $avaliable=@('6', '7', '8', '11', '14', '15', '16', '17', '19')
    if (!($avaliable -contains $jdkversion)) {
        throw "请指定Java版本为6、7、8、11、14、15、16、17、19"
    }
    $currentJavaHome=$env:JAVA_HOME
    $full_variable_name='JAVA'+$jdkversion+'_HOME'
    $env:JAVA_HOME=(get-item env:$full_variable_name).Value
    $env:PATH="$env:JAVA_HOME\bin;"+$env:PATH.Replace($currentJavaHome+"\bin;", "")

    echo "本窗口已切换到Java $jdkversion"
    echo ""
}

function base64($s) {
    [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($s))
}

