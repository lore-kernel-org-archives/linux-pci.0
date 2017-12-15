Return-Path: <SRS0=oO3l=DL=google.com=rajatja@kernel.org>
Return-Path: <SRS0=oO3l=DL=google.com=rajatja@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171215002155.GR30595@bhelgaas-glaptop.roam.corp.google.com>
References: <20171214184701.GA6322@libmpq.org> <20171215002155.GR30595@bhelgaas-glaptop.roam.corp.google.com>
From: Rajat Jain <rajatja@google.com>
Date: Fri, 15 Dec 2017 09:19:59 -0800
Message-ID: <CACK8Z6F2VJsN0vjAdrWuMfSnHJtPtd=y6zNC+GXDzEZ_ruy=kg@mail.gmail.com>
Subject: Re: ASPM powersupersave change NVMe SSD Samsung 960 PRO capacity to 0
 and read-only
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Maik Broemme <mbroemme@libmpq.org>, linux-pci <linux-pci@vger.kernel.org>,
	Keith Busch <keith.busch@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/alternative; boundary="94eb2c07e5ee35a5df056064384f"
List-ID: <linux-pci.vger.kernel.org>

--94eb2c07e5ee35a5df056064384f
Content-Type: text/plain; charset="UTF-8"

On Thu, Dec 14, 2017 at 4:21 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Rajat, Keith, linux-kernel]
>
> On Thu, Dec 14, 2017 at 07:47:01PM +0100, Maik Broemme wrote:
> > I have a Samsung 960 PRO NVMe SSD (Non-Volatile memory controller:
> > Samsung Electronics Co Ltd NVMe SSD Controller SM961/PM961). It
> > works fine until I enable powersupersave via
> > /sys/module/pcie_aspm/parameters/policy
> >
> > ASPM is enabled in BIOS and works fine for all devices and in
> > powersave mode. I'm able to reproduce this always at any time while
> > the system is up and running via:
> >
> > $> echo powersupersave > /sys/module/pcie_aspm/parameters/policy

>
> > The Linux kernel is 4.14.4 and APST for my device is working with
> > powersave. As soon as I enable powersupersave I get:
> >
> > [11535.142755] dpc 0000:00:10.0:pcie010: DPC containment event,
> status:0x1f09 source:0x0000
> > [11535.142760] dpc 0000:00:10.0:pcie010: DPC unmasked uncorrectable
> error detected, remove downstream devices
> > [11535.159999] nvme0n1: detected capacity change from 1024209543168 to 0
> > ...
>
> Can you start by opening a bug report at https://bugzilla.kernel.org,
> category Drivers/PCI, and attaching the complete "lspci -vv" output
> (as root) and the complete dmesg log?  Make sure you have a new enough
> lspci to decode the ASPM L1 Substates capability and the LTR bits.
> Source is at git://git.kernel.org/pub/scm/utils/pciutils/pciutils.git
>
> powersupersave enables ASPM L1 Substates.  Rajat, do you have any
> ideas about this or how we might debug it?
>

I know Maik mentioned that this is the boot device. Maik, is it possible to
boot off something else so that we can do some more experiments on this
port? If so,
- can you try to see if the device comes back if you switch the ASPM policy
back from "powersupersave" -> powersave, and potentially do a rescan (echo
1 > /sys/bus/pci/rescan)?
- It would be good to get the complete lspci -vv for the root port
(assuming device is connected to root port i.e. no switch).  Specifically
what does the Link status show?
- Also, do you know if your root port provides any debug registers that
could tell the current L1 substate of the link (My system's root port had
such register).
- I had usually resorted to a PCIe analyzer to peak at the packets when I
was debugging it. Not sure if that is an option here.

I don't see any debug prints in aspm.c that we could enable. Even if I
provide a patch, I suspect that the problem will start at the last step of
the pcie_config_aspm_l1ss() i.e. as soon as we really enable it in HW.
Maik, would you be open to take a debug patch that adds some debug prints
and try it out (compile your kernel with that patch)?



>
> Keith, is this really all the information about the event that we can
> get out of DPC?  Is there some AER logging we might be able to get via
> "lspci -vv"?  Sounds like this is the boot disk, so Maik may not be
> able to run lspci after the DPC event.  If there *is* any AER info,
> can we connect up the DPC event so we can print the AER info from the
> kernel?
>
> I wonder if there's some way improper L1 Substate configuration could
> cause a DPC event.  There are lots of knobs there that seem to depend
> on devices, and I'm not sure we have them all correct yet.
>
> There are some recent changes in that area that are in linux-next:
>
>   PCI/ASPM: Enable Latency Tolerance Reporting when supported
>   PCI/ASPM: Calculate LTR_L1.2_THRESHOLD from device characteristics
>   PCI/ASPM: Use correct capability pointer to program LTR_L1.2_THRESHOLD
>   PCI/ASPM: Account for downstream device's Port Common_Mode_Restore_Time
>
> It's conceivable that they could have some bearing on this problem.
> If you could give this a whirl on linux-next, that would be
> interesting.  If you do this, please also collect the "lspci -vv"
> output there so we can compare it with the v4.14 configuration.
>
> > It looks like APST feature cannot be set anymore after enabling
> > powersupersave. Also the PCIe device disappears completely
> > from lspci output.
>
> My guess is this is to be expected after the DPC event.  That
> basically disconnects the PCIe device from the system.
>
> > Any idea why the device is failing with powersupersave and how to avoid
> > it? Especially how to enable it but skip certain broken devices as this
> > is my boot device.
>
> We could conceivably add a quirk if we find that L1SS is broken on
> this particular device.  But L1SS is so new that I'd be more
> suspicious of the Linux code than the device.
>
> Bjorn
>

--94eb2c07e5ee35a5df056064384f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Thu, Dec 14, 2017 at 4:21 PM, Bjorn Helgaas <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:helgaas@kernel.org" target=3D"_blank">helgaas@kernel.org</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">[+cc Rajat, Keith, li=
nux-kernel]<br>
<span class=3D""><br>
On Thu, Dec 14, 2017 at 07:47:01PM +0100, Maik Broemme wrote:<br>
&gt; I have a Samsung 960 PRO NVMe SSD (Non-Volatile memory controller:<br>
&gt; Samsung Electronics Co Ltd NVMe SSD Controller SM961/PM961). It<br>
&gt; works fine until I enable powersupersave via<br>
&gt; /sys/module/pcie_aspm/<wbr>parameters/policy<br>
&gt;<br>
&gt; ASPM is enabled in BIOS and works fine for all devices and in<br>
&gt; powersave mode. I&#39;m able to reproduce this always at any time whil=
e<br>
&gt; the system is up and running via:<br>
&gt;<br>
&gt; $&gt; echo powersupersave &gt; /sys/module/pcie_aspm/<wbr>parameters/p=
olicy</span>=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=
=3D"">
&gt;<br>
&gt; The Linux kernel is 4.14.4 and APST for my device is working with<br>
&gt; powersave. As soon as I enable powersupersave I get:<br>
&gt;<br>
&gt; [11535.142755] dpc 0000:00:10.0:pcie010: DPC containment event, status=
:0x1f09 source:0x0000<br>
&gt; [11535.142760] dpc 0000:00:10.0:pcie010: DPC unmasked uncorrectable er=
ror detected, remove downstream devices<br>
&gt; [11535.159999] nvme0n1: detected capacity change from 1024209543168 to=
 0<br>
</span>&gt; ...<br>
<br>
Can you start by opening a bug report at <a href=3D"https://bugzilla.kernel=
.org" rel=3D"noreferrer" target=3D"_blank">https://bugzilla.kernel.org</a>,=
<br>
category Drivers/PCI, and attaching the complete &quot;lspci -vv&quot; outp=
ut<br>
(as root) and the complete dmesg log?=C2=A0 Make sure you have a new enough=
<br>
lspci to decode the ASPM L1 Substates capability and the LTR bits.<br>
Source is at git://<a href=3D"http://git.kernel.org/pub/scm/utils/pciutils/=
pciutils.git" rel=3D"noreferrer" target=3D"_blank">git.kernel.org/pub/scm/<=
wbr>utils/pciutils/pciutils.git</a><br>
<br>
powersupersave enables ASPM L1 Substates.=C2=A0 Rajat, do you have any<br>
ideas about this or how we might debug it?<br></blockquote><div><br></div><=
div><span style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-si=
ze:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:=
normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0=
px;text-transform:none;white-space:normal;word-spacing:0px;background-color=
:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:initi=
al;float:none;display:inline">I know Maik mentioned that this is the boot d=
evice. Maik, is it possible to boot off something else so that we can do so=
me more experiments on this port? If so,</span></div><div>- can you try to =
see if the device comes back if you switch the ASPM policy back from &quot;=
powersupersave&quot; -&gt; powersave, and potentially do a rescan (echo 1 &=
gt; /sys/bus/pci/rescan)?=C2=A0<br></div><div><div style=3D"color:rgb(34,34=
,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font-va=
riant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spac=
ing:normal;text-align:start;text-indent:0px;text-transform:none;white-space=
:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-=
style:initial;text-decoration-color:initial"><span style=3D"color:rgb(34,34=
,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font-va=
riant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spac=
ing:normal;text-align:start;text-indent:0px;text-transform:none;white-space=
:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-=
style:initial;text-decoration-color:initial;float:none;display:inline">- It=
 would be good to get the complete lspci -vv for the root port (assuming de=
vice is connected to root port i.e. no switch).=C2=A0=C2=A0</span>Specifica=
lly what does the Link status show?</div><div style=3D"color:rgb(34,34,34);=
font-family:arial,sans-serif;font-size:small;font-style:normal;font-variant=
-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:n=
ormal;text-align:start;text-indent:0px;text-transform:none;white-space:norm=
al;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style=
:initial;text-decoration-color:initial">- Also, do you know if your root po=
rt provides any debug registers that could tell the current L1 substate of =
the link (My system&#39;s root port had such register).<br></div></div><div=
>- I had usually resorted to a PCIe analyzer to peak at the packets when I =
was debugging it. Not sure if that is an option here.</div><div><br></div><=
div>I don&#39;t see any debug prints in aspm.c that we could enable. Even i=
f I provide a patch, I suspect that the problem will start at the last step=
 of the pcie_config_aspm_l1ss() i.e. as soon as we really enable it in HW. =
Maik, would you be open to take a debug patch that adds some debug prints a=
nd try it out (compile your kernel with that patch)?=C2=A0</div><div><br></=
div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Keith, is this really all the information about the event that we can<br>
get out of DPC?=C2=A0 Is there some AER logging we might be able to get via=
<br>
&quot;lspci -vv&quot;?=C2=A0 Sounds like this is the boot disk, so Maik may=
 not be<br>
able to run lspci after the DPC event.=C2=A0 If there *is* any AER info,<br=
>
can we connect up the DPC event so we can print the AER info from the<br>
kernel?<br>
<br>
I wonder if there&#39;s some way improper L1 Substate configuration could<b=
r>
cause a DPC event.=C2=A0 There are lots of knobs there that seem to depend<=
br>
on devices, and I&#39;m not sure we have them all correct yet.<br>
<br>
There are some recent changes in that area that are in linux-next:<br>
<br>
=C2=A0 PCI/ASPM: Enable Latency Tolerance Reporting when supported<br>
=C2=A0 PCI/ASPM: Calculate LTR_L1.2_THRESHOLD from device characteristics<b=
r>
=C2=A0 PCI/ASPM: Use correct capability pointer to program LTR_L1.2_THRESHO=
LD<br>
=C2=A0 PCI/ASPM: Account for downstream device&#39;s Port Common_Mode_Resto=
re_Time<br>
<br>
It&#39;s conceivable that they could have some bearing on this problem.<br>
If you could give this a whirl on linux-next, that would be<br>
interesting.=C2=A0 If you do this, please also collect the &quot;lspci -vv&=
quot;<br>
output there so we can compare it with the v4.14 configuration.<br>
<span class=3D""><br>
&gt; It looks like APST feature cannot be set anymore after enabling<br>
&gt; powersupersave. Also the PCIe device disappears completely<br>
&gt; from lspci output.<br>
<br>
</span>My guess is this is to be expected after the DPC event.=C2=A0 That<b=
r>
basically disconnects the PCIe device from the system.<br>
<span class=3D""><br>
&gt; Any idea why the device is failing with powersupersave and how to avoi=
d<br>
&gt; it? Especially how to enable it but skip certain broken devices as thi=
s<br>
&gt; is my boot device.<br>
<br>
</span>We could conceivably add a quirk if we find that L1SS is broken on<b=
r>
this particular device.=C2=A0 But L1SS is so new that I&#39;d be more<br>
suspicious of the Linux code than the device.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Bjorn<br>
</font></span></blockquote></div><br></div></div>

--94eb2c07e5ee35a5df056064384f--
