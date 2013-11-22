Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:28689 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163Ab3KVIs4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Nov 2013 03:48:56 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MWN00GWCPT8RHQ0@mailout4.samsung.com> for
 linux-pci@vger.kernel.org; Fri, 22 Nov 2013 17:48:48 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: =?UTF-8?Q?'Bj=C3=B8rn_Erik_Nilsen'?= <ben@datarespons.no>,
	'Marek Vasut' <marex@denx.de>,
	'Pratyush Anand' <pratyush.anand@gmail.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	'Mohit KUMAR DCG' <Mohit.KUMAR@st.com>,
	'Ajay KHANDELWAL' <ajay.khandelwal@st.com>,
	'Tim Harvey' <tharvey@gateworks.com>,
	'Eric Nelson' <Eric.Nelson@boundarydevices.com>,
	'Troy Kisky' <troy.kisky@boundarydevices.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <528a1bb6.6a88700a.28c9.ffff824aSMTPIN_ADDED_MISSING@mx.google.com>
 <201311201302.57210.marex@denx.de>
 <cmu-lmtpd-23243-1384949805-3@frontend1.mail.m-online.net>
 <201311201457.09154.marex@denx.de> <1385036087.3945.28.camel@bnilsen-HP>
 <1385039987.6020.5.camel@bnilsen-HP>
 <16.79.22145.6305E825@epmailin9.samsung.com>
In-reply-to: <16.79.22145.6305E825@epmailin9.samsung.com>
Subject: Re: Kernel oops from pci_disable_msi
Date: Fri, 22 Nov 2013 17:48:47 +0900
Message-id: <000501cee75f$a8ccda70$fa668f50$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, November 22, 2013 3:25 AM, Bjørn Erik Nilsen wrote:
> On Thu, 2013-11-21 at 14:19 +0100, Bjørn Erik Nilsen wrote:
> > On Thu, 2013-11-21 at 13:14 +0100, Bjørn Erik Nilsen wrote:
> > > On Wed, 2013-11-20 at 14:57 +0100, Marek Vasut wrote:
> > > > > On Wed, 2013-11-20 at 13:02 +0100, Marek Vasut wrote:
> > > > > > > On Wed, 2013-11-20 at 11:30 +0100, Marek Vasut wrote:
> > > > > > > > > On Tue, 2013-11-19 at 23:01 +0100, Marek Vasut wrote:
> > > > > > > > > > > On Tue, 2013-11-19 at 12:39 +0100, Bjørn Erik Nilsen wrote:
> > > > > > > > > > > > On Tue, 2013-11-19 at 12:24 +0100, Marek Vasut wrote:
> > > > > > > > > > > > > > On Tuesday, November 19, 2013 6:03 AM, Bjorn Helgaas wrote:
> > > > > > > > > > > > > > > On Mon, Nov 18, 2013 at 2:01 PM, Bjorn Helgaas
> > > > > > > > > > > > > > > <bhelgaas@google.com>
> > > > > > > > > >
> > > > > > > > > > wrote:
> > > > > > > > > > > > > > >> On Mon, Nov 18, 2013 at 6:53 AM, Bjørn Erik Nilsen
> > > > > > > > > > > > > > >> <ben@datarespons.no>
> > > > > > > > > > > > >
> > > > > > > > > > > > > wrote:
> > > > > > > > > > > > > > >>> I just hit an kernel oops related to PCI (in
> > > > > > > > > > > > > > >>> dw_msi_teardown_irq()/clear_irq() (pcie-designware))
> > > > > > > > > > > > > > >>>
> > > > > > > > > > > > > > >>> Linux version 3.12.0-next-20131105 (bnilsen@bnilsen)
> > > > > > > > > > > > > > >>> (gcc version 4.7.2 (GCC) )
> > > > > > > > > > > > > > >>>
> > > > > > > > > > > > > > >>> Problem seem to be dereferencing a null pointer
> > > > > > > > > > > > > > >>> returned from irq_desc_get_msi_desc(desc) (see
> > > > > > > > > > > > > > >>> attached backtrace).
> > > > > > > > > > > > > > >>
> > > > > > > > > > > > > > >> Included oops inline for ease of viewing/searching.
> > > > > > > > > > > > > > >> Jingooo, I assume you'll investigate this.  Let me
> > > > > > > > > > > > > > >> know if otherwise.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > (+cc Marek Vasut, Pratyush Anand, Kishon Vijay Abraham I,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >        Mohit KUMAR DCG, Ajay KHANDELWAL, Tim Harvey)
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Sorry, I will not investigate this.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Bjørn Erik Nilsen,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Would you let us know the ARM platform and LAN card?
> > > > > > > > > > > > > > If you let us know them, one of these pcie-designware
> > > > > > > > > > > > > > related people would reproduce and look at the issue.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Best regards,
> > > > > > > > > > > > > > Jingoo Han
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > >> Unable to handle kernel NULL pointer dereference at
> > > > > > > > > > > > > > >> virtual address 00000020 pgd = 80004000
> > > > > > > > > > > > > > >> [00000020] *pgd=00000000
> > > > > > > > > > > > > > >> Internal error: Oops: 17 [#1] SMP ARM
> > > > > > > > > > > > > > >> Modules linked in: sxdma(O)
> > > > > > > > > > > > > > >> CPU: 1 PID: 569 Comm: i2cipc.B3 Tainted: G           O
> > > > > > > > > > > > > > >> 3.12.0-next-20131105 #8 task: 9efcb600 ti: 9ec8c000
> > > > > > > > > > > > > > >> task.ti: 9ec8c000 PC is at
> > > > > > > > > > > > > > >> dw_msi_teardown_irq+0x40/0x118
> > > > > > > > > > > > >
> > > > > > > > > > > > > see drivers/pci/host/pcie-designware.c :
> > > > > > > > > > > > >
> > > > > > > > > > > > > 336 static void dw_msi_teardown_irq(struct msi_chip *chip,
> > > > > > > > > > > > > unsigned int irq) 337 {
> > > > > > > > > > > > > 338         clear_irq(irq);
> > > > > > > > > > > > > 339 }
> > > > > > > > > > > > >
> > > > > > > > > > > > > So, add such a print before the clear_irq() call:
> > > > > > > > > > > > >
> > > > > > > > > > > > > pr_err("%i %i\n", chip != NULL, irq);
> > > > > > > > > > > > >
> > > > > > > > > > > > > And let us know the result please.
> > > > > > > > > > > >
> > > > > > > > > > > > Here's what I get:
> > > > > > > > > > > >
> > > > > > > > > > > > 1 391
> > > > > > > > > > > > 1 392
> > > > > > > > > > >
> > > > > > > > > > > Also worth to mention is that I trigger this behavior by
> > > > > > > > > > > removing the device:
> > > > > > > > > > >
> > > > > > > > > > > echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove
> > > > > > > > > >
> > > > > > > > > > Just for completeness, is this pure next or something else, like
> > > > > > > > > > the boundarydevices's kernel ?
> > > > > > > > >
> > > > > > > > > It's a boundary device kernel (boundary-imx_3.12.0):
> > > > > > > > >
> > > > > > > > > https://github.com/boundarydevices/linux-imx6/tree/boundary-imx_3.1
> > > > > > > > > 2.0
> > > > > > > >
> > > > > > > > OK, thanks. Jingoo, can you please try if this also happens on
> > > > > > > > Exynos?
> > > > > > >
> > > > > > > Sorry, I need to clarify the steps leading to the oops. It's actually
> > > > > > > not removing the device itself which is the trigger point. The kernel
> > > > > > > module (sxdma) registers a PCI driver and creates a char device
> > > > > > > (/dev/sxdma). When this device is opened pci_enable_msi is called, and
> > > > > > > when it is closed sxdma_dev_release is called (which in turn calls
> > > > > > > pci_disable_msi as shown in the bt).
> > > > > >
> > > > > > Uh, what's this 'sxdma' ?
> > > > >
> > > > > It's the driver for the PCI device:
> > > > >
> > > > > 01:00.0 Memory controller: Barco Graphics NV Device ba01 (rev 01)
> > > > > 	Flags: bus master, fast devsel, latency 0, IRQ 155
> > > > > 	Memory at 01000000 (32-bit, non-prefetchable) [size=2M]
> > > > > 	Capabilities: [50] MSI: Enable- Count=1/4 Maskable- 64bit+
> > > > > 	Capabilities: [78] Power Management version 3
> > > > > 	Capabilities: [80] Express Endpoint, MSI 00
> > > > > 	Capabilities: [100] Virtual Channel
> > > > > 	Capabilities: [200] Vendor Specific Information: ID=1172 Rev=0 Len=044
> > > > > <?>
> > > > > 	Kernel driver in use: sxdma
> > > >
> > > > Sure, I just cannot find such driver anywhere in the kernel tree for some
> > > > reason.
> > >
> > > The sxdma kernel module is developed outside the kernel tree, however I
> > > can give you the source (GPL V2) if you are interested or think it is
> > > important for this issue. Please let me know.
> > >
> > > The background is that a successful call to pci_enable_msi followed by
> > > pci_disable_msi triggers the crash. It used to work just fine before the
> > > pci-imx6/pcie-designware code was upstreamed.
> > >
> > > I guess you already figured this out, but to clarify my findings so far:
> > >
> > > As mentioned earlier, the real hot spot is that irq_desc_get_msi_desc
> > > (called from clear_irq in pcie-designware.c) returns NULL and its return
> > > value is unconditionally dereferenced.
> > >
> > > Judging from the code it looks to me that it should never return NULL in
> > > that case (because there is no check against NULL before dereferencing
> > > it). So the nut to crack is to find out why it returns NULL in this
> > > particular case, and why it used to work before.
> >
> > As far as I can tell, irq_set_msi_desc(irq, desc) is never called which
> > is why irq_desc_get_msi_desc returns NULL. The following patch fixes the
> > problem (I also simplified the retrieval of the msi_desc):
> 
> I jumped on the conclusion a bit too fast with my previous patch as it
> only removes the artifact in one particular case rather than fixing the
> real problem.
> 
> I did more extensive testing and here's my new findings:
> 
> irq_set_msi_desc() is indeed called from dw_msi_setup_irq/assign_irq,
> however when I looked at the implementation of irq_set_msi_desc() I
> noticed how it actually updates the entry's irq. So after four
> consecutive calls to the function, the irq points to the last irq:
> 
> irq_set_msi_desc(388, desc);
>    -> desc->irq = 388
> ...
> irq_set_msi_desc(391, desc);
>    -> desc->irq = 391
> 
> This is an important detail, because from msi.c teardown_msi_irq() the
> desc->irq is used as the base address for the teardown. I.e.:
> 
> for (int i = 0; i < number of irqs; ++i)
>     teardown_msi_irq(desc->irq + i);
> 
> teardown(391)
> teardown(392)
> teardown(393)
> teardown(394)
> 
> Bummer.
> 
> And now you probably understand why my previous patch fixed an artifact,
> because what it really did was updating the desc->irq to point to 388
> (instead of 391):
> 
> irq_set_msi_desc(388, desc);
>     -> desc->irq = 388
> 
> We therefore got somewhat closer to a clean teardown. The next problem
> is that each allocated irq depend on each other as they all share the
> same msi_desc pointer, which means they cannot be freed independently
> (at least so I think). My idea was therefore to allocate all irqs at
> once from setup() and free them all at once from teardown(). My new
> patch makes my system stable again and fixes all the issues (not only
> one particular issue):

Hi Bjørn Erik Nilsen,

Thank you for your effort!
I reproduced this kernel panic on Exynos platform with LAN card.
And then, I tested your patch and checked this kernel panic is
resolved.

Marek Vasut,
Will you test Bjørn Erik Nilsen's patch with your i.MX platform?

Pratyush Anand,
Would you confirm Bjørn Erik Nilsen's patch?

I will do more extensive testing.
Thank you.

Best regards,
Jingoo Han

> 
> --- pcie-designware.c.orig	2013-11-21 14:02:03.656007695 +0100
> +++ pcie-designware.c	2013-11-21 18:24:09.436048776 +0100
> @@ -242,11 +242,12 @@ static int assign_irq(int no_irqs, struc
>  	if (!irq)
>  		goto no_valid_irq;
> 
> +	irq_alloc_descs(irq, irq, no_irqs, 0);
> +
>  	i = 0;
>  	while (i < no_irqs) {
>  		set_bit(pos0 + i, pp->msi_irq_in_use);
> -		irq_alloc_descs((irq + i), (irq + i), 1, 0);
> -		irq_set_msi_desc(irq + i, desc);
> +		irq_set_msi_desc_off(irq + i, i, desc);
>  		/*Enable corresponding interrupt in MSI interrupt controller */
>  		res = ((pos0 + i) / 32) * 12;
>  		bit = (pos0 + i) % 32;
> @@ -267,14 +268,12 @@ no_valid_irq:
>  static void clear_irq(unsigned int irq)
>  {
>  	int res, bit, val, pos;
> -	struct irq_desc *desc;
>  	struct msi_desc *msi;
>  	struct pcie_port *pp;
>  	struct irq_data *data = irq_get_irq_data(irq);
> 
>  	/* get the port structure */
> -	desc = irq_to_desc(irq);
> -	msi = irq_desc_get_msi_desc(desc);
> +	msi = data->msi_desc;
>  	pp = sys_to_pcie(msi->dev->bus->sysdata);
>  	if (!pp) {
>  		BUG();
> @@ -283,7 +282,15 @@ static void clear_irq(unsigned int irq)
> 
>  	pos = data->hwirq;
> 
> -	irq_free_desc(irq);
> +	if (irq == msi->irq) {
> +		/*
> +		 * This is the irq returned from dw_msi_setup_irq where
> +		 * 'nvec' number of desc where allocated. Now it is time
> +		 * to free them all.
> +		 */
> +		unsigned int nvec = 1 << msi->msi_attrib.multiple;
> +		irq_free_descs(irq, nvec);
> +	}
> 
>  	clear_bit(pos, pp->msi_irq_in_use);
> 
> 
> 
> Best regards,
> 
> Bjørn Erik Nilsen
> 


