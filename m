Return-Path: <SRS0=puPd=IJ=gigaio.com=dmeyer@kernel.org>
Return-Path: <SRS0=puPd=IJ=gigaio.com=dmeyer@kernel.org>
MIME-Version: 1.0
In-Reply-To: <9dd68ac0-5b9e-b257-49d2-20327c2ab282@deltatee.com>
References: <1526558413-23113-1-git-send-email-dmeyer@gigaio.com>
 <1526558413-23113-3-git-send-email-dmeyer@gigaio.com> <20180517134521.GC19955@bhelgaas-glaptop.roam.corp.google.com>
 <9dd68ac0-5b9e-b257-49d2-20327c2ab282@deltatee.com>
From: Doug Meyer <dmeyer@gigaio.com>
Date: Tue, 22 May 2018 14:09:59 -0700
Message-ID: <CA+GK6en+g+T9H0sOMdVXv-_aD3rRcuzZ1JdfK0moEoTuuJnrqQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] NTB: PCI Quirk to Enable Switchtec NT Functionality
 with IOMMU On
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, kurt.schwemmer@microsemi.com,
	linux-pci@vger.kernel.org, linux-ntb <linux-ntb@googlegroups.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
	"Jiang, Dave" <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000504137056cd1d721"
List-ID: <linux-pci.vger.kernel.org>

--000000000000504137056cd1d721
Content-Type: text/plain; charset="UTF-8"

[resending because I forgot the mailing lists want plain text mode]

Dear Bjorn,

Logan answered the questions quite thoroughly. (Thanks, Logan!)


Don't initialize variables unless there's a path through the
code that would otherwise use an uninitialized value.
> +     struct ntb_info_regs __iomem *mmio_ntb = NULL;
> +     struct ntb_ctrl_regs __iomem *mmio_ctrl = NULL;
> +     struct sys_info_regs __iomem *mmio_sys_info = NULL;
> +
No blank line here.
> +     u64 partition_map;
> +     u8 partition;
> +     int pp;
> +
> +     if (pci_enable_device(pdev)) {
> +             dev_err(&pdev->dev, "Cannot enable Switchtec device\n");
Use "pci_err(pdev, ...)" here and below.
[...]
I think you should probably disable the device here (and in the error
return path) to balance the enable above.

I'll make the changes (above) that you requested.

Blessings,
Doug


On Thu, May 17, 2018 at 9:06 AM, Logan Gunthorpe <logang@deltatee.com>
wrote:

>
>
> On 17/05/18 07:45 AM, Bjorn Helgaas wrote:
> > On Thu, May 17, 2018 at 05:00:13AM -0700, dmeyer@gigaio.com wrote:
> >> From: Doug Meyer <dmeyer@gigaio.com>
> >>
> >> Here we add the PCI quirk for the Microsemi Switchtec parts to allow
> >> non-transparent bridging to work when the IOMMU is turned on.
> >
> > I'm not an NTB expert, but it *sounds* like you're specifically fixing
> > DMA initiated by an NT endpoint.  I assume other aspects of
> > non-transparent bridging, e.g., routing of config accesses,
> > interrupts, doorbells, etc., might work even without this quirk.
>
> Yes, that's correct.
>
> >> When a requestor on one NT endpoint accesses memory on another NT
> >> endpoint, it does this via a devfn proxy ID. Proxy IDs are uniquely
> >> assigned on a per-requestor basis within the NT hardware, and are not
> >> visible via PCI enumeration. As a result, a memory access from a peer
> >> NT endpoint will have an unrecognized requestor ID devfn which the
> >> IOMMU will reject.
> >
> > It would be very helpful if you could include a reference to the
> > relevant section of a publicly available spec.
>
> I'm not aware of any public specs on this. The basic idea is that a peer
> accesses a BAR memory window on it's own side and the NTB translates it
> to a memory request on the local side. This request has it's requester
> ID translated through a LUT seeing the requester ID on the initiating
> side isn't valid on the receiving side. The LUT has multiple entries so
> that multiple requester IDs can be translated and the responses routed
> back to the original requester.
>
> > Who assigns these proxy IDs?  Quirks run before drivers claim the
> > device, so it looks like this assumes the proxy ID assignments are
> > either hard-wired into the device or programmed by firmware.  If the
> > latter, how would they be programmed for hot-added NTBs?
>
> The local side of the requester ID LUT are fixed by the hardware so we
> can determine all the possible IDs coming from the NTB device just by
> reading some registers. The peer's side of the LUT are programmed with
> all possible source requester IDs by the driver but these don't have any
> effect on the ID's on the receiving side.
>
> > I'm wondering if all this could or should be done in the switchtec
> > driver instead of in a quirk.  But I really don't know how that driver
> > works.
>
> We'd like it to be done in the driver too but it seems
> pci_add_dma_alias() must be called before the driver is initialized and
> therefore in a quirk. Presently, it seems nearly all calls to that
> function are in quirks.c for this reason.
>
> Thanks,
>
> Logan
>
>

--000000000000504137056cd1d721
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>[resending because I forgot the mailing lists want pl=
ain text mode]</div><div><br></div>Dear Bjorn,<div><br></div><div><div>Loga=
n answered the questions quite thoroughly. (Thanks, Logan!)</div><div><br><=
/div><div><br></div><div>Don&#39;t initialize variables unless there&#39;s =
a path through the</div><div>code that would otherwise use an uninitialized=
 value.</div><div>&gt; +=C2=A0 =C2=A0 =C2=A0struct ntb_info_regs __iomem *m=
mio_ntb =3D NULL;</div><div>&gt; +=C2=A0 =C2=A0 =C2=A0struct ntb_ctrl_regs =
__iomem *mmio_ctrl =3D NULL;</div><div>&gt; +=C2=A0 =C2=A0 =C2=A0struct sys=
_info_regs __iomem *mmio_sys_info =3D NULL;</div><div>&gt; +</div><div>No b=
lank line here.</div><div>&gt; +=C2=A0 =C2=A0 =C2=A0u64 partition_map;</div=
><div>&gt; +=C2=A0 =C2=A0 =C2=A0u8 partition;</div><div>&gt; +=C2=A0 =C2=A0=
 =C2=A0int pp;</div><div>&gt; +</div><div>&gt; +=C2=A0 =C2=A0 =C2=A0if (pci=
_enable_device(pdev)) {</div><div>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0dev_err(&amp;pdev-&gt;dev, &quot;Cannot enable Switchtec devic=
e\n&quot;);</div><div>Use &quot;pci_err(pdev, ...)&quot; here and below.</d=
iv><div>[...]</div><div>I think you should probably disable the device here=
 (and in the error</div><div>return path) to balance the enable above.</div=
><div><br></div><div>I&#39;ll make the changes (above) that you requested.<=
/div><div><br></div><div>Blessings,</div><div>Doug</div><div><br></div><div=
 class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, May 17, 2018 =
at 9:06 AM, Logan Gunthorpe <span dir=3D"ltr">&lt;<a href=3D"mailto:logang@=
deltatee.com" target=3D"_blank">logang@deltatee.com</a>&gt;</span> wrote:<b=
r><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex"><span class=3D"gmail-">=
<br>
<br>
On 17/05/18 07:45 AM, Bjorn Helgaas wrote:<br>
&gt; On Thu, May 17, 2018 at 05:00:13AM -0700, <a href=3D"mailto:dmeyer@gig=
aio.com">dmeyer@gigaio.com</a> wrote:<br>
&gt;&gt; From: Doug Meyer &lt;<a href=3D"mailto:dmeyer@gigaio.com">dmeyer@g=
igaio.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; Here we add the PCI quirk for the Microsemi Switchtec parts to all=
ow<br>
&gt;&gt; non-transparent bridging to work when the IOMMU is turned on.<br>
&gt; <br>
&gt; I&#39;m not an NTB expert, but it *sounds* like you&#39;re specificall=
y fixing<br>
&gt; DMA initiated by an NT endpoint.=C2=A0 I assume other aspects of<br>
&gt; non-transparent bridging, e.g., routing of config accesses,<br>
&gt; interrupts, doorbells, etc., might work even without this quirk.<br>
<br>
</span>Yes, that&#39;s correct.<br>
<span class=3D"gmail-"><br>
&gt;&gt; When a requestor on one NT endpoint accesses memory on another NT<=
br>
&gt;&gt; endpoint, it does this via a devfn proxy ID. Proxy IDs are uniquel=
y<br>
&gt;&gt; assigned on a per-requestor basis within the NT hardware, and are =
not<br>
&gt;&gt; visible via PCI enumeration. As a result, a memory access from a p=
eer<br>
&gt;&gt; NT endpoint will have an unrecognized requestor ID devfn which the=
<br>
&gt;&gt; IOMMU will reject.<br>
&gt; <br>
&gt; It would be very helpful if you could include a reference to the<br>
&gt; relevant section of a publicly available spec.<br>
<br>
</span>I&#39;m not aware of any public specs on this. The basic idea is tha=
t a peer<br>
accesses a BAR memory window on it&#39;s own side and the NTB translates it=
<br>
to a memory request on the local side. This request has it&#39;s requester<=
br>
ID translated through a LUT seeing the requester ID on the initiating<br>
side isn&#39;t valid on the receiving side. The LUT has multiple entries so=
<br>
that multiple requester IDs can be translated and the responses routed<br>
back to the original requester.<br>
<span class=3D"gmail-"><br>
&gt; Who assigns these proxy IDs?=C2=A0 Quirks run before drivers claim the=
<br>
&gt; device, so it looks like this assumes the proxy ID assignments are<br>
&gt; either hard-wired into the device or programmed by firmware.=C2=A0 If =
the<br>
&gt; latter, how would they be programmed for hot-added NTBs?<br>
<br>
</span>The local side of the requester ID LUT are fixed by the hardware so =
we<br>
can determine all the possible IDs coming from the NTB device just by<br>
reading some registers. The peer&#39;s side of the LUT are programmed with<=
br>
all possible source requester IDs by the driver but these don&#39;t have an=
y<br>
effect on the ID&#39;s on the receiving side.<br>
<span class=3D"gmail-"><br>
&gt; I&#39;m wondering if all this could or should be done in the switchtec=
<br>
&gt; driver instead of in a quirk.=C2=A0 But I really don&#39;t know how th=
at driver<br>
&gt; works.<br>
<br>
</span>We&#39;d like it to be done in the driver too but it seems<br>
pci_add_dma_alias() must be called before the driver is initialized and<br>
therefore in a quirk. Presently, it seems nearly all calls to that<br>
function are in quirks.c for this reason.<br>
<br>
Thanks,<br>
<br>
Logan<br>
<br>
</blockquote></div><br></div></div></div>

--000000000000504137056cd1d721--
