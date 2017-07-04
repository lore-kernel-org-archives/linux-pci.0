Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 4 Jul 2017 10:58:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Subject: Re: [PATCH v9 2/3] PCI: Add tango PCIe host bridge support
Message-ID: <20170704155855.GI13824@bhelgaas-glaptop.roam.corp.google.com>
References: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
 <b32f9e1c-fdde-3064-f935-c817cf707534@sigmadesigns.com>
 <20170702231811.GJ18324@bhelgaas-glaptop.roam.corp.google.com>
 <79382219-c730-da78-3e5f-5abf3173d7ac@sigmadesigns.com>
 <20170703134031.GG13824@bhelgaas-glaptop.roam.corp.google.com>
 <16622817-8ccd-107b-be08-676b576f6e8a@sigmadesigns.com>
MIME-Version: 1.0
In-Reply-To: <16622817-8ccd-107b-be08-676b576f6e8a@sigmadesigns.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, Mason <slash.tmp@free.fr>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-pci <linux-pci@vger.kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 03, 2017 at 04:34:29PM +0200, Marc Gonzalez wrote:
> Bjorn Helgaas wrote:
> 
> > Marc Gonzalez wrote:
> >
> >> On 03/07/2017 01:18, Bjorn Helgaas wrote:
> >>
> >>> On Tue, Jun 20, 2017 at 10:17:40AM +0200, Marc Gonzalez wrote:
> >>>
> >>>> +static int tango_check_pcie_link(void __iomem *test_out)
> >>>
> >>> I think this is checking for link up.  Rename to tango_pcie_link_up()
> >>> to follow the convention of other drivers.  Take a struct tango_pcie *
> >>> instead of an address, if possible.
> >>
> >> Anything's possible. NB: if I pass the struct, then I have to store
> >> the address in the struct, which isn't the case now, since I never
> >> need the address later. If you don't mind adding an unnecessary
> >> field to the struct, I can do it. What do you say?
> > 
> > The benefit of following the same formula as other drivers is pretty
> > large.  Most drivers save the equivalent of "base" in the struct.  If
> > you did that, you wouldn't need an extra pointer; you would just use
> > "base + SMP8759_MUX" in the config accessors and "base + SMP8759_TEST_OUT"
> > in tango_pcie_link_up().
> 
> The problem is that TEST_OUT is at 0x74 on SMP8759, but at 0x138
> on my other chip. In fact, all registers have been "reshuffled",
> and none have the same offsets on the two chips.
> 
> My solution was to define specific registers in the struct.
> 
> In my [RFC PATCH v0.2] posted March 23, I tried illustrating
> the issue:
> 
> +static const struct of_device_id tango_pcie_ids[] = {
> +	{ .compatible = "sigma,smp8759-pcie" },
> +	{ .compatible = "sigma,rev2-pcie" },
> +	{ /* sentinel */ },
> +};
> +
> +static void smp8759_init(struct tango_pcie *pcie, void __iomem *base)
> +{
> +	pcie->mux		= base + 0x48;
> +	pcie->msi_status	= base + 0x80;
> +	pcie->msi_mask		= base + 0xa0;
> +	pcie->msi_doorbell	= 0xa0000000 + 0x2e07c;
> +}
> +
> +static void rev2_init(struct tango_pcie *pcie, void __iomem *base)
> +{
> +	void __iomem *misc_irq	= base + 0x40;
> +	void __iomem *doorbell	= base + 0x8c;
> +
> +	pcie->mux		= base + 0x2c;
> +	pcie->msi_status	= base + 0x4c;
> +	pcie->msi_mask		= base + 0x6c;
> +	pcie->msi_doorbell	= 0x80000000;
> +
> +	writel(lower_32_bits(pcie->msi_doorbell), doorbell + 0);
> +	writel(upper_32_bits(pcie->msi_doorbell), doorbell + 4);
> +
> +	/* Enable legacy PCI interrupts */
> +	writel(BIT(15), misc_irq);
> +	writel(0xf << 4, misc_irq + 4);
> +}
> 
> 
> Do you agree that the 'base + OFFSET' idiom does not work in
> this specific situation? Would you handle it differently?

It's definitely a hassle to support chips with different register
layouts.  Your hardware guys are really making your life hard :)

drivers/pci/host/pcie-iproc.c is one strategy.  It has
iproc_pcie_reg_paxb[] and iproc_pcie_reg_paxb_v2[] with register
offsets for different chip versions.

It saves a table of register offsets per controller, which is similar
to saving a set of pointers per controller.  Saving the pointers as
you suggest above is marginally more storage but probably easier to
read.

If the chips are fundamentally different, i.e., if they *operate*
differently in addition to having a different register layout, you
could make two separate drivers.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
