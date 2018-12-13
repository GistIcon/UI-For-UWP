<?xml version="1.0" encoding="utf-8"?>
<Project DefaultTargets="Nuget" xmlns="http://schemas.microsoft.com/developer/msbuild/2003" ToolsVersion="3.5">



    <Import Project="$(MSBuildProjectDirectory)\Config.UWP.proj" />



    <PropertyGroup>

        <NugetDependsOn>

            PrepareNugetProperties;

            BuildFullNugets

        </NugetDependsOn>

    </PropertyGroup>

    

    <Target Name="Nuget" DependsOnTargets="$(NugetDependsOn)"/>



    <Target Name="PrepareNugetProperties">



        <PropertyGroup>

            <Version Condition= " '$(Version)' == '' ">1.0.1.2</Version>

            <FullPathDeployDirectory>$([System.IO.Path]::GetFullPath('$(DeployDirectory)'))</FullPathDeployDirectory>

            <BinariesSubDir>$(BinariesTargetDirectory)</BinariesSubDir>



            <UWPPartialId>UniversalWindowsPlatform</UWPPartialId>

            <UWPPartialTitle>UniversalWindowsPlatform</UWPPartialTitle>



            <UWPId>Telerik.UI.for.$(UWPPartialId)</UWPId>

            <UWPTitle>Telerik UI for $(UWPPartialTitle)</UWPTitle>

                   

            <NuspecUWPDir>$(MsBuildProjectDirectory)\Nuspecs.UWP</NuspecUWPDir>

            <FullOutputDir>$(DeployDirectory)\Nuget</FullOutputDir>



            <DefaultTargetFileName>$(UWPId)</DefaultTargetFileName>

        </PropertyGroup>



    </Target>



    <Target Name="BuildFullNugets" >



        <PropertyGroup>

            <UWPNuspec>$(NuspecUWPDir)\Package.UniversalWindowsPlatform.nuspec</UWPNuspec>

            <UWPProperties>Id=$(UWPId);Title=&quot;$(UWPTitle)&quot;;PartialID=&quot;$(UWPPartialId)&quot;;PartialTitle=&quot;$(UWPPartialTitle)&quot;;DeployDirectory=&quot;$(FullPathDeployDirectory)&quot;;BinariesSubDir=&quot;$(BinariesSubDir)&quot;;NuspecsDir=&quot;$(NuspecUWPDir)&quot;</UWPProperties>

        </PropertyGroup>



        <Message Text="DEBUG INFO: UWPProperties=$(UWPProperties)" />



        <RemoveDir Directories="$(FullOutputDir)" />

        <MakeDir Directories="$(FullOutputDir)" />



        <Copy SourceFiles="$(NuspecUWPDir)\$(DefaultTargetFileName).targets" DestinationFiles="$(NuspecUWPDir)\$(UWPId).targets" />



	<Exec Command="$(PowerShellExe) -NonInteractive -executionpolicy Unrestricted  -command (New-Object System.Net.WebClient).DownloadFile('http://dist.nuget.org/win-x86-commandline/latest/nuget.exe', 'nuget.exe')"/>

        <Exec Command="$(Nuget32ToolPath) pack $(UWPNuspec) -Version $(Version) -OutputDirectory $(FullOutputDir) -Properties $(UWPProperties)"/>

    </Target>
    
