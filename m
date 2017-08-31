Return-Path: <SRS0=Zfon=AB=gmail.com=oza.pawandeep@kernel.org>
Return-Path: <SRS0=Zfon=AB=gmail.com=oza.pawandeep@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170831133951.GA8154@bhelgaas-glaptop.roam.corp.google.com>
References: <1504155029-24729-1-git-send-email-oza.oza@broadcom.com> <20170831133951.GA8154@bhelgaas-glaptop.roam.corp.google.com>
From: Oza Pawandeep <oza.pawandeep@gmail.com>
Date: Thu, 31 Aug 2017 19:17:34 +0530
Message-ID: <CAK1A=4z8nEOq_0GTrWDSmjR5g=AbQHH+6T_J00ZEHncMKinznQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] PCI hotplug feature
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Andy Gospodarek <gospo@broadcom.com>,
	Oza Pawandeep <oza.oza@broadcom.com>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org, Jon Mason <jonmason@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com
Content-Type: multipart/alternative; boundary="001a11c1806e06148e05580ce362"
List-ID: <linux-pci.vger.kernel.org>

--001a11c1806e06148e05580ce362
Content-Type: text/plain; charset="UTF-8"

My apologies,
It looked to me that v5 went out twice, might be confusing.

Hence sent out v6.

Regards,
Oza.

On 31-Aug-2017 7:09 PM, "Bjorn Helgaas" <helgaas@kernel.org> wrote:

> On Thu, Aug 31, 2017 at 10:20:26AM +0530, Oza Pawandeep wrote:
> > These patches bring in PCI hotplug support for iproc family chipsets.
> >
> > It includes DT binding documentation and, the implementation in
> > iproc pcie RC driver.
> >
> > Changes since v5:
> > [RESEND]
>
> Not sure what the point of resending this as v6 was, since v5 was
> posted 6 minutes earlier and you don't mention any changes in v6?
>
> > Changes since v4:
> > Rebased to pci-next
> > Added; Acked-by: Rob Herring <robh@kernel.org>
> >
> > Changes since v3:
> > Resend. just to be in sync previous in-flight patches.
> >
> > Changes since v2:
> > Addressed Rob Herring's comments.
> > Changed subject to "dt-bindings: PCI:..."
> > Made generic PCI hotplug properties 'slot-pluggable' and 'prsnt-gpios'
> > Rebased the patches on top of Lorenzo's patches.
> >
> > Oza Pawandeep (3):
> >   dt-bindings: PCI: Add PCI hotplug property
> >   dt-bindings: PCI iproc: Implement optional property prsnt-gpios
> >   PCI: iproc: Implement PCI hotplug support
> >
> >  .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |  14 ++
> >  Documentation/devicetree/bindings/pci/pci.txt      |  15 ++
> >  drivers/pci/host/pcie-iproc-platform.c             |   3 +
> >  drivers/pci/host/pcie-iproc.c                      | 166
> ++++++++++++++++++---
> >  drivers/pci/host/pcie-iproc.h                      |   7 +
> >  5 files changed, 187 insertions(+), 18 deletions(-)
> >
> > --
> > 1.9.1
> >
>

--001a11c1806e06148e05580ce362
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">My apologies,=C2=A0<div dir=3D"auto">It looked to me that=
 v5 went out twice, might be confusing.=C2=A0</div><div dir=3D"auto"><br></=
div><div dir=3D"auto">Hence sent out v6.=C2=A0</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">Regards,=C2=A0</div><div dir=3D"auto">Oza.=C2=A0</di=
v></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On 31-Aug=
-2017 7:09 PM, &quot;Bjorn Helgaas&quot; &lt;<a href=3D"mailto:helgaas@kern=
el.org">helgaas@kernel.org</a>&gt; wrote:<br type=3D"attribution"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">On Thu, Aug 31, 2017 at 10:20:26AM +0530, Oza Pawande=
ep wrote:<br>
&gt; These patches bring in PCI hotplug support for iproc family chipsets.<=
br>
&gt;<br>
&gt; It includes DT binding documentation and, the implementation in<br>
&gt; iproc pcie RC driver.<br>
&gt;<br>
&gt; Changes since v5:<br>
&gt; [RESEND]<br>
<br>
Not sure what the point of resending this as v6 was, since v5 was<br>
posted 6 minutes earlier and you don&#39;t mention any changes in v6?<br>
<br>
&gt; Changes since v4:<br>
&gt; Rebased to pci-next<br>
&gt; Added; Acked-by: Rob Herring &lt;<a href=3D"mailto:robh@kernel.org">ro=
bh@kernel.org</a>&gt;<br>
&gt;<br>
&gt; Changes since v3:<br>
&gt; Resend. just to be in sync previous in-flight patches.<br>
&gt;<br>
&gt; Changes since v2:<br>
&gt; Addressed Rob Herring&#39;s comments.<br>
&gt; Changed subject to &quot;dt-bindings: PCI:...&quot;<br>
&gt; Made generic PCI hotplug properties &#39;slot-pluggable&#39; and &#39;=
prsnt-gpios&#39;<br>
&gt; Rebased the patches on top of Lorenzo&#39;s patches.<br>
&gt;<br>
&gt; Oza Pawandeep (3):<br>
&gt;=C2=A0 =C2=A0dt-bindings: PCI: Add PCI hotplug property<br>
&gt;=C2=A0 =C2=A0dt-bindings: PCI iproc: Implement optional property prsnt-=
gpios<br>
&gt;=C2=A0 =C2=A0PCI: iproc: Implement PCI hotplug support<br>
&gt;<br>
&gt;=C2=A0 .../devicetree/bindings/pci/<wbr>brcm,iproc-pcie.txt=C2=A0 =C2=
=A0 |=C2=A0 14 ++<br>
&gt;=C2=A0 Documentation/devicetree/<wbr>bindings/pci/pci.txt=C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 15 ++<br>
&gt;=C2=A0 drivers/pci/host/pcie-iproc-<wbr>platform.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 drivers/pci/host/pcie-iproc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 166 ++++++++++++++++++---<br>
&gt;=C2=A0 drivers/pci/host/pcie-iproc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A07 +<br>
&gt;=C2=A0 5 files changed, 187 insertions(+), 18 deletions(-)<br>
&gt;<br>
&gt; --<br>
&gt; 1.9.1<br>
&gt;<br>
</blockquote></div></div>

--001a11c1806e06148e05580ce362--
