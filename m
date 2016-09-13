Return-Path: <keith.busch@intel.com>
Return-Path: <keith.busch@intel.com>
From: "Busch, Keith" <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, "Derrick, Jonathan"
	<jonathan.derrick@intel.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [RFCv2 0/3] vmd irq list shortening, map allocation
Date: Tue, 13 Sep 2016 22:16:19 +0000
Message-ID: <B58D82457FDA0744A320A2FC5AC253B93D722BF9@fmsmsx104.amr.corp.intel.com>
References: <1472838786-3441-1-git-send-email-jonathan.derrick@intel.com>
 <20160913205745.GF4138@localhost>
In-Reply-To: <20160913205745.GF4138@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Sorry for the delay. I've been looking into these new PCI IRQ API's and fou=
nd an unrelated issue that I stuck myself with working through with Christo=
ph and Thomas. :)

Patches 1/3 and 2/3 look good to me.

I'm not convinced 3/3 is an improvement. At the very least, we don't want t=
o BUG_ON from a failed kmalloc when we can return an appropriate error inst=
ead. I'll take a closer look at 3/3 and get back to Jon with more feedback.



-----Original Message-----=09
From: Bjorn Helgaas [mailto:helgaas@kernel.org]=20
Sent: Tuesday, September 13, 2016 2:58 PM
To: Derrick, Jonathan <jonathan.derrick@intel.com>
Cc: Busch, Keith <keith.busch@intel.com>; linux-pci@vger.kernel.org
Subject: Re: [RFCv2 0/3] vmd irq list shortening, map allocation

On Fri, Sep 02, 2016 at 11:53:03AM -0600, Jon Derrick wrote:
> V2:
> Added a map for vmd irqs to attempt to allocate all vmd irqs within an
> irq list into a single page. Once we start getting many devices
> sharing the irq in an irq list, this may help the list traversal latency.
>=20
> V1:
> Couple of RFC patches here. I don't really notice a positive benefit but
> it does reduce the struct size of vmd_irq_list and hopefully we gain some
> cache benefits from that.
>=20
> Both are based on:
> https://patchwork.kernel.org/patch/9304179/
> https://patchwork.kernel.org/patch/9304181/
>=20
> Jon Derrick (3):
>   vmd: eliminate vmd_vector member from list type
>   vmd: eliminate index member from irq list
>   pci/vmd: Create irq map for irq nodes
>=20
>  arch/x86/pci/vmd.c | 94 ++++++++++++++++++++++++++++++++++++++++++------=
------
>  1 file changed, 73 insertions(+), 21 deletions(-)

These look OK to me, so if Keith acks them I'll merge them.
