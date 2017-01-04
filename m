Return-Path: <SRS0=Xdb0=YS=gmail.com=hjmallon@kernel.org>
Return-Path: <SRS0=Xdb0=YS=gmail.com=hjmallon@kernel.org>
From: Harry Mallon <hjmallon@gmail.com>
Message-Id: <9223E467-AFB5-4A06-B57D-0B2298786B48@gmail.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_114B9B25-CDBD-4C32-9DE0-65DDAA2C7B62"
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: Diagnosing BAR allocation problems with complex bridge structure
Date: Wed, 4 Jan 2017 16:21:14 +0000
In-Reply-To: <20170103180718.GA25398@bhelgaas-glaptop.roam.corp.google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
References: <B56F52C5-7298-4E9D-8AE2-8497527C5D39@gmail.com>
 <20170103180718.GA25398@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>


--Apple-Mail=_114B9B25-CDBD-4C32-9DE0-65DDAA2C7B62
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Bjorn,





> On 3 Jan 2017, at 18:07, Bjorn Helgaas <helgaas@kernel.org> wrote:
>=20
> Hi Harry,
>=20
> On Tue, Jan 03, 2017 at 03:35:13PM +0000, Harry Mallon wrote:
>> Hi,
>>=20
>> In this email I am asking for advice on how to diagnose problems in =
assigning memory for PCI-E devices and bridges. I can reproduce my issue =
on the current mainline kernel but I am not currently planning to target =
any fixes for the mainline kernel (unless they prove to be useful =
outside of this machine). I am planning to target the CentOS 3.10.0 =
based kernel. I understand that I am not owed any help/patches etc from =
anyone here, especially not as I am using a non mainline kernel.
>>=20
>> I am working on a machine with an odd PCI structure, it has 4 =
different PLX bridges and requires hotplug to work on at least 2 of =
these. We were previously using a kernel based on 3.3 and had to add a =
few (hacky, machine specific) patches to that to make it work correctly. =
We also use "pci=3Drealloc,pcie_bus_safe" in the kernel cmdline. I am =
currently using that kernel as a reference to compare to my development =
version.
>>=20
>> On my current setup some devices don't work, using "lspci -vvv" I can =
see that they are not all receiving the memory allocations that they =
need. They report like one of the two following (it changes depending on =
another PCI-E card being in or out):
>>=20
>> 05:00.0 VGA compatible controller: NVIDIA Corporation GP102 [TITAN X] =
(rev a1) (prog-if 00 [VGA controller])
>>        Subsystem: NVIDIA Corporation Device 119a
>>        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- =
ParErr- Stepping- SERR- FastB2B- DisINTx-
>>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast =
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>        Interrupt: pin A routed to IRQ 11
>>        Region 0: Memory at <ignored> (32-bit, non-prefetchable) =
[disabled]
>>        Region 1: Memory at e0000000 (64-bit, prefetchable) [disabled] =
[size=3D256M]
>>        Region 3: Memory at f0000000 (64-bit, prefetchable) [disabled] =
[size=3D32M]
>>        Region 5: I/O ports at 4000 [disabled] [size=3D128]
>>        Expansion ROM at <ignored> [disabled]
>>=20
>> 05:00.0 VGA compatible controller: NVIDIA Corporation GK110B [GeForce =
GTX TITAN Black] (rev ff) (prog-if ff)
>> 	!!! Unknown header type 7f
>>=20
>> What tools and techniques can anyone recommend for diagnosing this =
type of problem? Is there a way to export all the bridge memory ranges =
in a way that can be visualised (maybe the newer kernel cannot allocate =
enough aligned space)? Is there a way to enable extra PCI debug in the =
kernel? Is there a way to make the kernel panic and=20
>> report when it fails to assign memory on boot instead of continuing =
with non-functional hardware?
>=20
> A complete dmesg log from a current kernel and complete "lspci -vv"
> output is the best place to start.  The goal is that all your devices
> should work without requiring any machine-specific patches or
> command-line parameters.  Our resource allocation code is not really
> very robust, so unusual topologies don't always work out of the box.

https://bugzilla.kernel.org/show_bug.cgi?id=3D191921 =
<https://bugzilla.kernel.org/show_bug.cgi?id=3D191921>

I have attached messages log (zipped, wouldn't let me do the whole =
thing) and lspci.

>=20
> You can open a bug report at https://bugzilla.kernel.org =
<https://bugzilla.kernel.org/> in the
> drivers/PCI area, attach the dmesg and lspci output, and respond with
> the URL here.
>=20
> Bjorn


--Apple-Mail=_114B9B25-CDBD-4C32-9DE0-65DDAA2C7B62
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dus-ascii"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><div class=3D"">Hi Bjorn,</div><div class=3D""><br =
class=3D""></div><div class=3D""><br class=3D""></div><div class=3D""><br =
class=3D""></div><div class=3D""><br class=3D""></div><div class=3D""><br =
class=3D""><div><blockquote type=3D"cite" class=3D""><div class=3D"">On =
3 Jan 2017, at 18:07, Bjorn Helgaas &lt;<a =
href=3D"mailto:helgaas@kernel.org" class=3D"">helgaas@kernel.org</a>&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><div class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">Hi Harry,</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">On Tue, Jan 03, 2017 at 03:35:13PM +0000, Harry =
Mallon wrote:</span><br style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D"">Hi,<br class=3D""><br =
class=3D"">In this email I am asking for advice on how to diagnose =
problems in assigning memory for PCI-E devices and bridges. I can =
reproduce my issue on the current mainline kernel but I am not currently =
planning to target any fixes for the mainline kernel (unless they prove =
to be useful outside of this machine). I am planning to target the =
CentOS 3.10.0 based kernel. I understand that I am not owed any =
help/patches etc from anyone here, especially not as I am using a non =
mainline kernel.<br class=3D""><br class=3D"">I am working on a machine =
with an odd PCI structure, it has 4 different PLX bridges and requires =
hotplug to work on at least 2 of these. We were previously using a =
kernel based on 3.3 and had to add a few (hacky, machine specific) =
patches to that to make it work correctly. We also use =
"pci=3Drealloc,pcie_bus_safe" in the kernel cmdline. I am currently =
using that kernel as a reference to compare to my development =
version.<br class=3D""><br class=3D"">On my current setup some devices =
don't work, using "lspci -vvv" I can see that they are not all receiving =
the memory allocations that they need. They report like one of the two =
following (it changes depending on another PCI-E card being in or =
out):<br class=3D""><br class=3D"">05:00.0 VGA compatible controller: =
NVIDIA Corporation GP102 [TITAN X] (rev a1) (prog-if 00 [VGA =
controller])<br =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Subsystem: NVIDIA =
Corporation Device 119a<br =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Control: I/O- Mem- =
BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- =
FastB2B- DisINTx-<br =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Status: Cap+ 66MHz- =
UDF- FastB2B- ParErr- DEVSEL=3Dfast &gt;TAbort- &lt;TAbort- &lt;MAbort- =
&gt;SERR- &lt;PERR- INTx-<br =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Interrupt: pin A =
routed to IRQ 11<br =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Region 0: Memory at =
&lt;ignored&gt; (32-bit, non-prefetchable) [disabled]<br =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Region 1: Memory at =
e0000000 (64-bit, prefetchable) [disabled] [size=3D256M]<br =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Region 3: Memory at =
f0000000 (64-bit, prefetchable) [disabled] [size=3D32M]<br =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Region 5: I/O ports =
at 4000 [disabled] [size=3D128]<br =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Expansion ROM at =
&lt;ignored&gt; [disabled]<br class=3D""><br class=3D"">05:00.0 VGA =
compatible controller: NVIDIA Corporation GK110B [GeForce GTX TITAN =
Black] (rev ff) (prog-if ff)<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>!!! Unknown header type 7f<br =
class=3D""><br class=3D"">What tools and techniques can anyone recommend =
for diagnosing this type of problem? Is there a way to export all the =
bridge memory ranges in a way that can be visualised (maybe the newer =
kernel cannot allocate enough aligned space)? Is there a way to enable =
extra PCI debug in the kernel? Is there a way to make the kernel panic =
and<span class=3D"Apple-converted-space">&nbsp;</span><br =
class=3D"">report when it fails to assign memory on boot instead of =
continuing with non-functional hardware?<br class=3D""></blockquote><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
float: none; display: inline !important;" class=3D"">A complete dmesg =
log from a current kernel and complete "lspci -vv"</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
float: none; display: inline !important;" class=3D"">output is the best =
place to start. &nbsp;The goal is that all your devices</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
float: none; display: inline !important;" class=3D"">should work without =
requiring any machine-specific patches or</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">command-line parameters. &nbsp;Our =
resource allocation code is not really</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">very robust, so unusual topologies don't =
always work out of the box.</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""></div></blockquote><div><br class=3D""></div><div><a =
href=3D"https://bugzilla.kernel.org/show_bug.cgi?id=3D191921" =
class=3D"">https://bugzilla.kernel.org/show_bug.cgi?id=3D191921</a></div><=
div><br class=3D""></div><div>I have attached messages log (zipped, =
wouldn't let me do the whole thing) and lspci.</div><br =
class=3D""><blockquote type=3D"cite" class=3D""><div class=3D""><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
float: none; display: inline !important;" class=3D"">You can open a bug =
report at<span class=3D"Apple-converted-space">&nbsp;</span></span><a =
href=3D"https://bugzilla.kernel.org/" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" =
class=3D"">https://bugzilla.kernel.org</a><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
float: none; display: inline !important;" class=3D""><span =
class=3D"Apple-converted-space">&nbsp;</span>in the</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
float: none; display: inline !important;" class=3D"">drivers/PCI area, =
attach the dmesg and lspci output, and respond with</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
float: none; display: inline !important;" class=3D"">the URL =
here.</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
float: none; display: inline !important;" =
class=3D"">Bjorn</span></div></blockquote></div><br =
class=3D""></div></body></html>=

--Apple-Mail=_114B9B25-CDBD-4C32-9DE0-65DDAA2C7B62--
