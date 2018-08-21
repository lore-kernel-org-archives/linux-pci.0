Return-Path: <SRS0=aCoa=LE=google.com=rajatja@kernel.org>
Return-Path: <SRS0=aCoa=LE=google.com=rajatja@kernel.org>
MIME-Version: 1.0
References: <20180820230624.GB154536@bhelgaas-glaptop.roam.corp.google.com>
 <20180821054704.jlqk5zrlbbsjsd4g@wunner.de> <20180821072541.tcdg5fkk4zrwxahj@wunner.de>
 <20180821165042.GC154536@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180821165042.GC154536@bhelgaas-glaptop.roam.corp.google.com>
From: Rajat Jain <rajatja@google.com>
Date: Tue, 21 Aug 2018 13:19:15 -0700
Message-ID: <CACK8Z6HrNirQ_f0q1HL62H8cH_Q8s8QU61xC6GETa0i1nHedgg@mail.gmail.com>
Subject: Re: Enumeration issue with QCA9005 AR9462
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, linux-pci <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mmyangfl@gmail.com, ashok.raj@intel.com
Content-Type: multipart/alternative; boundary="000000000000977d380573f7bf0c"
List-ID: <linux-pci.vger.kernel.org>

--000000000000977d380573f7bf0c
Content-Type: text/plain; charset="UTF-8"

On Tue, Aug 21, 2018 at 9:50 AM Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Rajat, Ashok]
>
> On Tue, Aug 21, 2018 at 09:25:41AM +0200, Lukas Wunner wrote:
> > On Tue, Aug 21, 2018 at 07:47:04AM +0200, Lukas Wunner wrote:
> > > On Mon, Aug 20, 2018 at 06:06:24PM -0500, Bjorn Helgaas wrote:
> > > > mmyangfl@gmail.com reported a problem [1]: on v4.17, a QCA9005
> AR9462
> > > > wifi device was present at boot, but disappeared after
> suspend/resume.
> > > >
> > > > He also tested a recent kernel (5c60a7389d79, from Thu Aug 16),
> > > > where the suspend/resume problem doesn't seem to happen, but the wifi
> > > > device isn't enumerated correctly at boot-time.
> > > >
> > > > [    0.928714] pciehp 0000:04:00.0:pcie204: Slot #0 AttnBtn-
> PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl-
> LLActRep+
> > > > [    0.928752] pciehp 0000:04:00.0:pcie204: Slot(0-1): Card not
> present
> > > > [    0.928811] pciehp 0000:04:00.0:pcie204: Slot(0-1): Link Up
> > > > [    0.928815] pciehp 0000:04:00.0:pcie204: Slot(0-1): No adapter
> > > >
> > > > [1] https://bugzilla.kernel.org/show_bug.cgi?id=200839
> > > > [2] https://bugzilla.kernel.org/attachment.cgi?id=277923
> > >
> > > The hardware appears to be broken in that the Presence Detect State bit
> > > in the Slot Status register is 0 (Slot Empty) even though the slot is
> > > occupied.
> > [...]
> > > Possible solutions:
> > >
> > > (a) Be lenient towards broken hardware and accept DLActive+ as a proxy
> > >     for PresDet+.
> > >
> > > (b) Add a blacklist to pciehp such that it doesn't bind to [1ae9:0200].
> > >     The bug reporter writes that "it's a single Half Mini PCIe card,
> > >     with two chipsets (Wil6110? + AR9462) combined by a PCIe hub".
> > >     This sounds like it's not really hotpluggable.
> > >     (Is Mini PCIe hotplug capable at all?)
> > >
> > > Let me go through the driver and see if (a) is feasible and how
> intrusive
> > > it would be.
> >
> > So (a) would seem to be feasible, we could add a quirk for devices like
> > this to call pciehp_check_link_active() in pciehp_get_adapter_status().
> >
> > Alternatively, we could generally add a call to
> pciehp_check_link_active()
> > in get_adapter_status(), pciehp_check_presence() and pcie_init() and thus
> > avoid a quirk for this specific device.
> > The existing call in __pciehp_enable_slot() could actually be removed,
> > this code path is only entered if either PDS or DLLLA is set.
> >
> > And the third option would be to add a quirk like quirk_hotplug_bridge()
> > which sets is_hotplug_bridge = 0 on this broken device such that pciehp
> > doesn't bind to it in the first place.
>
> It sounds like with (a), you could make this work without having a
> Wil6110-specific quirk, i.e., if the Link Status says the link is
> active, we assume a device is present.  That seems reasonable to me
> and it sort of fits with these previous changes:
>

I also like idea (a) and think it makes sense. One thing to note is that we
may pass the same confusion ("how is my wifi detected when no card is not
present on the slot") to userspace in case anyone looks in /sysfs (but I
don't think anyone looks that deeply).

Thanks,

Rajat


>
>   385895fef6b5 ("PCI: pciehp: Prioritize data-link event over presence
> detect")
>   e48f1b67f668 ("PCI: pciehp: Use link change notifications for hot-plug
> and removal")
>
> Bjorn
>

--000000000000977d380573f7bf0c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Tue=
, Aug 21, 2018 at 9:50 AM Bjorn Helgaas &lt;<a href=3D"mailto:helgaas@kerne=
l.org">helgaas@kernel.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">[+cc Rajat, Ashok]<br>
<br>
On Tue, Aug 21, 2018 at 09:25:41AM +0200, Lukas Wunner wrote:<br>
&gt; On Tue, Aug 21, 2018 at 07:47:04AM +0200, Lukas Wunner wrote:<br>
&gt; &gt; On Mon, Aug 20, 2018 at 06:06:24PM -0500, Bjorn Helgaas wrote:<br=
>
&gt; &gt; &gt; <a href=3D"mailto:mmyangfl@gmail.com" target=3D"_blank">mmya=
ngfl@gmail.com</a> reported a problem [1]: on v4.17, a QCA9005 AR9462<br>
&gt; &gt; &gt; wifi device was present at boot, but disappeared after suspe=
nd/resume.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; He also tested a recent kernel (5c60a7389d79, from Thu Aug 1=
6),<br>
&gt; &gt; &gt; where the suspend/resume problem doesn&#39;t seem to happen,=
 but the wifi<br>
&gt; &gt; &gt; device isn&#39;t enumerated correctly at boot-time.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; [=C2=A0 =C2=A0 0.928714] pciehp 0000:04:00.0:pcie204: Slot #=
0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoC=
ompl- LLActRep+<br>
&gt; &gt; &gt; [=C2=A0 =C2=A0 0.928752] pciehp 0000:04:00.0:pcie204: Slot(0=
-1): Card not present<br>
&gt; &gt; &gt; [=C2=A0 =C2=A0 0.928811] pciehp 0000:04:00.0:pcie204: Slot(0=
-1): Link Up<br>
&gt; &gt; &gt; [=C2=A0 =C2=A0 0.928815] pciehp 0000:04:00.0:pcie204: Slot(0=
-1): No adapter<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; [1] <a href=3D"https://bugzilla.kernel.org/show_bug.cgi?id=
=3D200839" rel=3D"noreferrer" target=3D"_blank">https://bugzilla.kernel.org=
/show_bug.cgi?id=3D200839</a><br>
&gt; &gt; &gt; [2] <a href=3D"https://bugzilla.kernel.org/attachment.cgi?id=
=3D277923" rel=3D"noreferrer" target=3D"_blank">https://bugzilla.kernel.org=
/attachment.cgi?id=3D277923</a><br>
&gt; &gt; <br>
&gt; &gt; The hardware appears to be broken in that the Presence Detect Sta=
te bit<br>
&gt; &gt; in the Slot Status register is 0 (Slot Empty) even though the slo=
t is<br>
&gt; &gt; occupied.<br>
&gt; [...]<br>
&gt; &gt; Possible solutions:<br>
&gt; &gt; <br>
&gt; &gt; (a) Be lenient towards broken hardware and accept DLActive+ as a =
proxy<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0for PresDet+.<br>
&gt; &gt; <br>
&gt; &gt; (b) Add a blacklist to pciehp such that it doesn&#39;t bind to [1=
ae9:0200].<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0The bug reporter writes that &quot;it&#39;s a =
single Half Mini PCIe card,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0with two chipsets (Wil6110? + AR9462) combined=
 by a PCIe hub&quot;.<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0This sounds like it&#39;s not really hotplugga=
ble.<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0(Is Mini PCIe hotplug capable at all?)<br>
&gt; &gt; <br>
&gt; &gt; Let me go through the driver and see if (a) is feasible and how i=
ntrusive<br>
&gt; &gt; it would be.<br>
&gt; <br>
&gt; So (a) would seem to be feasible, we could add a quirk for devices lik=
e<br>
&gt; this to call pciehp_check_link_active() in pciehp_get_adapter_status()=
.<br>
&gt; <br>
&gt; Alternatively, we could generally add a call to pciehp_check_link_acti=
ve()<br>
&gt; in get_adapter_status(), pciehp_check_presence() and pcie_init() and t=
hus<br>
&gt; avoid a quirk for this specific device.<br>
&gt; The existing call in __pciehp_enable_slot() could actually be removed,=
<br>
&gt; this code path is only entered if either PDS or DLLLA is set.<br>
&gt; <br>
&gt; And the third option would be to add a quirk like quirk_hotplug_bridge=
()<br>
&gt; which sets is_hotplug_bridge =3D 0 on this broken device such that pci=
ehp<br>
&gt; doesn&#39;t bind to it in the first place.<br>
<br>
It sounds like with (a), you could make this work without having a<br>
Wil6110-specific quirk, i.e., if the Link Status says the link is<br>
active, we assume a device is present.=C2=A0 That seems reasonable to me<br=
>
and it sort of fits with these previous changes:<br></blockquote><div><br><=
/div><div>I also like idea (a) and think it makes sense. One thing to note =
is that we may pass the same confusion (&quot;how is my wifi detected when =
no card is not present on the slot&quot;) to userspace in case anyone looks=
 in /sysfs (but I don&#39;t think anyone looks that deeply).</div><div><br>=
</div><div>Thanks,</div><div><br></div><div>Rajat</div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">
<br>
=C2=A0 385895fef6b5 (&quot;PCI: pciehp: Prioritize data-link event over pre=
sence detect&quot;)<br>
=C2=A0 e48f1b67f668 (&quot;PCI: pciehp: Use link change notifications for h=
ot-plug and removal&quot;)<br>
<br>
Bjorn<br>
</blockquote></div></div>

--000000000000977d380573f7bf0c--
