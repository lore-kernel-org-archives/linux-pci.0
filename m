Return-Path: <SRS0=9ZYf=33=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=9ZYf=33=free.fr=slash.tmp@kernel.org>
Subject: Re: [RFC PATCH v0.2] PCI: Add support for tango PCIe host bridge
To: Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 LKML <linux-kernel@vger.kernel.org>
References: <91db1f47-3024-9712-309a-fb4b21e42028@free.fr>
 <e5c0bace-fcbe-de3f-b76f-0fb672562e84@arm.com>
 <310db9dd-7db6-2106-2e53-f0083b2d3758@free.fr>
 <012f7fcb-eaeb-70dd-a1a9-06c213789d30@arm.com>
 <0502e180-5517-12d6-e3a1-bcea0da7e201@free.fr>
 <4edd799a-650c-0189-cd5c-e9fc18c5f8bc@arm.com>
 <30f662a6-5dab-515b-e35a-a312f3c7b509@free.fr>
 <5f81730d-fbe3-1f4c-de34-09bbfb893ee1@arm.com>
 <2b5eef4c-32f2-54f1-ca2f-f9426e68fb2c@free.fr>
 <67014006-a380-9e3b-c9af-a421052cb8e0@arm.com>
 <b59b81ea-bc1b-bff5-4a78-8a69538b0de3@free.fr>
 <bc5bf8ad-69ef-4f14-f450-e162ddb5af7c@arm.com>
 <241b130e-1fb7-ecd4-034e-eb02065ada66@free.fr>
 <37cd6172-b04e-fcad-18fc-4fbb26cc611b@arm.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <87d48d57-5f9f-1b35-99da-ab39de2d3d48@free.fr>
Date: Wed, 19 Apr 2017 13:19:20 +0200
MIME-Version: 1.0
In-Reply-To: <37cd6172-b04e-fcad-18fc-4fbb26cc611b@arm.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 12/04/2017 11:59, Marc Zyngier wrote:

> And that's *wrong*. I've repeatedly said that you only need to deal with
> *your* irqchip. End of story. Nowhere else. Please leave the MSI irqchip
> alone, it is very unlikely that you have to provide anything at all to it.

Hello Marc,

I am hoping you can help me pinpoint what's missing in my code,
to have it behave the way you describe.

As you have stated, I have *two* struct irq_chip:
one is mine (tango_chip), the other not_mine (msi_chip).

static struct irq_chip tango_chip = {
	.name			= "TANGO IRQ_CHIP",
	.irq_compose_msi_msg	= tango_compose_msi_msg,
	.irq_set_affinity	= tango_set_affinity,
	.irq_ack		= tango_ack,
	.irq_mask		= tango_mask,
	.irq_unmask		= tango_unmask,
};

static struct irq_chip msi_chip = {
	.name = "NOT MY IRQ_CHIP",
	.irq_ack = not_mine_ack,
	.irq_mask = not_mine_mask,
	.irq_unmask = not_mine_unmask,
};


A struct msi_domain_info links to the msi_chip.

static struct msi_domain_info msi_dom_info = {
	.flags	= MSI_FLAG_PCI_MSIX | MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS,
	.chip	= &msi_chip,
};

irq_dom = irq_domain_create_linear(fwnode, MSI_COUNT, &irq_dom_ops, pcie);
msi_dom = pci_msi_create_irq_domain(fwnode, &msi_dom_info, irq_dom);


I believe irq_dom and tango_chip are tied together by:

	irq_domain_set_info(dom, virq, pos, &tango_chip, pcie, handle_edge_irq, NULL, NULL);


My biggest problem is that tango_unmask() is never called.


Here is the log of function calls as they happen on my system:

[    0.361586] TANGO irq_chip=c0d10a00 MSI irq_chip=c0d10aa8
[    0.361595] IRQ_DOM=cf9db300 MSI_DOM=cf9b5080

[    0.363214] find_free_msi: dom=cf9db300 virq=30 hwirq=0 chip=c0d10a00 cdata=cfb0a410
[    0.363314] [<c0316e54>] (tango_irq_domain_alloc) from [<c0163468>] (msi_domain_alloc+0x68/0x128)

[    0.363543] ENTER tango_compose_msi_msg
[    0.363552] TANGO IRQ_CHIP: irq_data=cfaf4180 irq=30 hwirq=0 chip=c0d10a00 dom=cf9db300 pdata=  (null) cdata=cfb0a410
[    0.363609] [<c0316ca4>] (tango_compose_msi_msg) from [<c015f654>] (irq_chip_compose_msi_msg+0x48/0x58)

[    0.363928] ENTER not_mine_unmask
[    0.363943] NOT MY IRQ_CHIP: irq_data=cf940110 irq=30 hwirq=0 chip=c0d10aa8 dom=cf9b5080 pdata=cfaf4180 cdata=  (null)
[    0.364012] [<c0316c48>] (not_mine_unmask) from [<c015edc0>] (irq_enable+0x30/0x44)

[    2.475111] find_free_msi: dom=cf9db300 virq=34 hwirq=1 chip=c0d10a00 cdata=cfb0a410
[    2.516895] [<c0316e54>] (tango_irq_domain_alloc) from [<c0163468>] (msi_domain_alloc+0x68/0x128)

[    2.686593] find_free_msi: dom=cf9db300 virq=35 hwirq=2 chip=c0d10a00 cdata=cfb0a410
[    2.728334] [<c0316e54>] (tango_irq_domain_alloc) from [<c0163468>] (msi_domain_alloc+0x68/0x128)

[    2.897946] find_free_msi: dom=cf9db300 virq=36 hwirq=3 chip=c0d10a00 cdata=cfb0a410
[    2.939680] [<c0316e54>] (tango_irq_domain_alloc) from [<c0163468>] (msi_domain_alloc+0x68/0x128)

[    3.109254] ENTER tango_compose_msi_msg
[    3.114603] TANGO IRQ_CHIP: irq_data=cfb4b500 irq=34 hwirq=1 chip=c0d10a00 dom=cf9db300 pdata=  (null) cdata=cfb0a410
[    3.160621] [<c0316ca4>] (tango_compose_msi_msg) from [<c015f654>] (irq_chip_compose_msi_msg+0x48/0x58)

[    3.340161] ENTER tango_compose_msi_msg
[    3.345507] TANGO IRQ_CHIP: irq_data=cfb4b440 irq=35 hwirq=2 chip=c0d10a00 dom=cf9db300 pdata=  (null) cdata=cfb0a410
[    3.391522] [<c0316ca4>] (tango_compose_msi_msg) from [<c015f654>] (irq_chip_compose_msi_msg+0x48/0x58)

[    3.571148] ENTER tango_compose_msi_msg
[    3.576503] TANGO IRQ_CHIP: irq_data=cfb4b380 irq=36 hwirq=3 chip=c0d10a00 dom=cf9db300 pdata=  (null) cdata=cfb0a410
[    3.631966] [<c015f654>] (irq_chip_compose_msi_msg) from [<c016362c>] (msi_domain_activate+0x18/0x40)

[    3.802121] ENTER not_mine_unmask
[    3.806937] NOT MY IRQ_CHIP: irq_data=cf95c210 irq=34 hwirq=524288 chip=c0d10aa8 dom=cf9b5080 pdata=cfb4b500 cdata=  (null)
[    3.852943] [<c0316c48>] (not_mine_unmask) from [<c015edc0>] (irq_enable+0x30/0x44)

[    3.998596] ENTER not_mine_unmask
[    4.003410] NOT MY IRQ_CHIP: irq_data=cf95c010 irq=35 hwirq=524289 chip=c0d10aa8 dom=cf9b5080 pdata=cfb4b440 cdata=  (null)
[    4.049415] [<c0316c48>] (not_mine_unmask) from [<c015edc0>] (irq_enable+0x30/0x44)

[    4.195055] ENTER not_mine_unmask
[    4.199870] NOT MY IRQ_CHIP: irq_data=cf97cf10 irq=36 hwirq=524290 chip=c0d10aa8 dom=cf9b5080 pdata=cfb4b380 cdata=  (null)
[    4.245874] [<c0316c48>] (not_mine_unmask) from [<c015edc0>] (irq_enable+0x30/0x44)



It's driving me nuts. Do you know what might be wrong?

Regards.
