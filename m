Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from exprod5og124.obsmtp.com ([64.18.0.212]:43275 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752005AbbDURiN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 21 Apr 2015 13:38:13 -0400
Received: by oift201 with SMTP id t201so160331656oif.3
        for <linux-pci@vger.kernel.org>; Tue, 21 Apr 2015 10:38:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150421154225.GC10164@leverpostej>
References: <55310050.7000003@arm.com> <cover.1429586144.git.dhdang@apm.com>
 <cfdb95a38689836bac693df6edb8c09829ea61cd.1429586144.git.dhdang@apm.com> <20150421154225.GC10164@leverpostej>
From: Duc Dang <dhdang@apm.com>
Date: Tue, 21 Apr 2015 10:37:42 -0700
Message-ID: <CADaLND=GdSK3Swj5meya0hnw7zfObvajkHPt0z_H3p6nsXdgtA@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] documentation: dts: Add the device tree binding
 for APM X-Gene v1 PCIe MSI device tree node
To: Mark Rutland <mark.rutland@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Marc Zyngier <Marc.Zyngier@arm.com>, Feng Kan <fkan@apm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Loc Ho <lho@apm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Tanmay Inamdar <tinamdar@apm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 21, 2015 at 8:42 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Apr 21, 2015 at 05:04:23AM +0100, Duc Dang wrote:
> > The driver for this binding is under 'drivers/pci/host/pci-xgene-msi.c'
>
> Please provide a bit of description of what this device is, and please
> place the binding patch _before_ the driver and DTS patches.

I will add in next version of the patch.
>
>
> > Signed-off-by: Duc Dang <dhdang@apm.com>
> > Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
> > ---
> >  .../devicetree/bindings/pci/xgene-pci-msi.txt      | 63 ++++++++++++++++++++++
> >  1 file changed, 63 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
> >
> > diff --git a/Documentation/devicetree/bindings/pci/xgene-pci-msi.txt b/Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
> > new file mode 100644
> > index 0000000..0ffdcb3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
> > @@ -0,0 +1,63 @@
> > +* AppliedMicro X-Gene PCIe MSI interface
> > +
> > +Required properties:
> > +
> > +- compatible: should contain "apm,xgene1-msi" to identify the core.
>
> What does the core have to do with the MSI controller?

'core' here is the MSI controller block. I will use different word to
avoid confusion with CPU core.
>
> > +- msi-controller: indicates that this is X-Gene1 PCIe MSI controller node
> > +- reg: A list of physical base address and length for each set of controller
> > +       registers.
>
> How many? Which ones? In which order? Do you need reg-names?

I will add these details in next version of the patch.
>
> > +- interrupts: A list of interrupt outputs of the controller.

I will add these details in next version of the patch.
>
> How many? Which ones? In which order? Do you need interrupt-names?

I will add these details in next version of the patch.
>
> You need to define these for *this particular binding*, in order for
> them to actually define the contract. An abstract definition is
> completely useless for writing or parsing a DT, and as such this
> document is just noise.
>
> Please think about the purpose of this document, and write something
> appropriate.
>
> [...]
>
> > +             interrupts = <  0x0 0x10 0x4
> > +                             0x0 0x11 0x4
> > +                             0x0 0x12 0x4
> > +                             0x0 0x13 0x4
> > +                             0x0 0x14 0x4
> > +                             0x0 0x15 0x4
> > +                             0x0 0x16 0x4
> > +                             0x0 0x17 0x4
> > +                             0x0 0x18 0x4
> > +                             0x0 0x19 0x4
> > +                             0x0 0x1a 0x4
> > +                             0x0 0x1b 0x4
> > +                             0x0 0x1c 0x4
> > +                             0x0 0x1d 0x4
> > +                             0x0 0x1e 0x4
> > +                             0x0 0x1f 0x4>;
>
> Nit: please bracket list entries individually.

Thanks for your comment, I will address them on next version of the patch.

>
> Mark.

Regards,
Duc Dang.
