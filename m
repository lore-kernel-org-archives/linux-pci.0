Return-Path: <thomas.petazzoni@free-electrons.com>
Return-Path: <thomas.petazzoni@free-electrons.com>
Date: Thu, 30 Jun 2016 11:26:11 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Nadav
 Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Hanna Hawa
 <hannah@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Jason Cooper
 <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>, Gregory Clement
 <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] PCI: host: new PCI host controller driver for
 Aardvark
Message-ID: <20160630112611.7503f34c@free-electrons.com>
In-Reply-To: <20160622172502.GF25485@localhost>
References: <1465574056-8787-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1465574056-8787-3-git-send-email-thomas.petazzoni@free-electrons.com>
	<20160622172502.GF25485@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

Bjorn,

Thanks a lot for your thorough review! I've addressed the comments, but
I wanted to give some feedback on a few of them. See below.

On Wed, 22 Jun 2016 12:25:02 -0500, Bjorn Helgaas wrote:

> > +config PCI_AARDVARK
> > +	bool "Aardvark PCIe controller"
> > +	depends on ARCH_MVEBU && ARM64
> > +	depends on OF
> > +	select PCI_MSI  
> 
> I'm guessing this should be "depends on PCI_MSI_IRQ_DOMAIN" per Arnd's
> recent patch: http://lkml.kernel.org/r/8531046.3ceRqUA835@wuerfel
> 
> I have merged Arnd's patch, so it will be in v4.8.

OK. I've cherry-picked this patch, and changed the dependency, and
things seems to be alright (I can select my driver, and PCI MSI is
forced enabled). So sounds good.


> > +/* PCIe core registers */
> > +#define PCIE_CORE_CMD_STATUS_REG				0x4
> > +#define     PCIE_CORE_CMD_IO_ACCESS_EN				BIT(0)
> > +#define     PCIE_CORE_CMD_MEM_ACCESS_EN				BIT(1)
> > +#define     PCIE_CORE_CMD_MEM_IO_REQ_EN				BIT(2)
> > +#define PCIE_CORE_DEV_CTRL_STATS_REG				0xC8  
> 
> Please use either upper- or lower-case in hex constants consistently.
> Most of the ones below are lower-case.

Fixed.

> > +#define     OB_PCIE_CONFIG0			0x8
> > +#define     OB_PCIE_CONFIG1			0x9
> > +#define     OB_PCIE_MSG				0xc
> > +#define     OB_PCIE_MSG_VENDOR			0xd  
> 
> Some of these definitions (ISR bits above, these window types,
> probably others) are not actually used.  I usually omit unused ones on
> the theory that they add bulk and opportunities for transcription
> errors.  But if they're useful to you, I'm OK with keeping them.

I've removed a good number of the unused definitions.

> > +#define PIO_TIMEOUT_MS			(1)
> > +#define PCIE_LINKUP_TIMEOUT_MS		(10)  
> 
> Bare numbers do not require parentheses.

Fixed.

> > +static bool advk_pcie_link_up(struct advk_pcie *pcie)
> > +{
> > +	unsigned long timeout;
> > +	u32 ltssm_state;
> > +	u32 val;
> > +
> > +	timeout = jiffies + msecs_to_jiffies(PCIE_LINKUP_TIMEOUT_MS);
> > +
> > +	while (time_before(jiffies, timeout)) {
> > +		val = advk_readl(pcie, CFG_REG);
> > +		ltssm_state = (val >> LTSSM_SHIFT) & LTSSM_MASK;
> > +		if (ltssm_state >= LTSSM_L0)
> > +			return true;
> > +	}  
> 
> To try to improve consistency with other similar drivers, please make
> advk_pcie_link_up() a simple function that contains one register read
> and no loop.
> 
> Then make a second advk_wait_for_link() function with a loop and
> timeout.  Please use the same timeout/usleep structure used in
> dw_pcie_wait_for_link() and nwl_wait_for_link().

I've fixed that. However, notice that the model used by those other
functions is a number of retries, which I was doing originally, but
Arnd suggested to change it to a time_before() based loop.

> > +	/* Point PCIe unit MBUS decode windows to DRAM space. */  
> 
> Tidy up the comments here by making them all one-line (when they fit) 
> and consistently omitting (or keeping) the periods.

Fixed.

> > +static int advk_pcie_wait_pio(struct advk_pcie *pcie)
> > +{
> > +	unsigned long timeout;
> > +	u32 reg, is_done;
> > +
> > +	timeout = jiffies + msecs_to_jiffies(PIO_TIMEOUT_MS);
> > +
> > +	while (time_before(jiffies, timeout)) {
> > +		reg = advk_readl(pcie, PIO_START);
> > +		is_done = advk_readl(pcie, PIO_ISR);
> > +		if ((!reg) && is_done)
> > +			return 0;
> > +	}  
> 
> This busy-loop could use usleep_range() similar to what
> dw_pcie_wait_for_link() does.

No, using usleep_range() is not possible here. This function is called
with the pci_lock held (since it's used when reading/writing the
configuration space), and usleep_range() schedules.

> > +	dev_err(&pcie->pdev->dev, "config read/write timed out\n");
> > +	return -ETIME;
> > +}
> > +
> > +static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
> > +			     int where, int size, u32 *val)
> > +{
> > +	struct advk_pcie *pcie = bus->sysdata;
> > +	u32 reg;
> > +	int ret;
> > +
> > +	if (PCI_SLOT(devfn) != 0) {
> > +		*val = 0xffffffff;
> > +		return PCIBIOS_DEVICE_NOT_FOUND;
> > +	}
> > +
> > +	advk_pcie_enable_axi_addr_gen(pcie, false);  
> 
> This AXI enable/disable requires a mutex to prevent another thread
> from performing a simulataneous config access, so please add a comment
> about which mutex you are relying on.  I think there's a PCI global
> one, but I'd just like to make it explicit that we need it here,
> because many config accessors don't actually require the mutex.
> 
> I assume the AXI enable/disable does not affect MMIO accesses by
> drivers to areas mapped by PCIe device BARs.  If it did, that would be
> a pretty serious problem because it would be hard to ensure the mutual
> exclusion.

The AXI enable/disable was affecting MMIO accesses, so it was in fact
bogus to do this. We've switched to a different mechanism to access the
configuration space, which doesn't involve enabling/disabling AXI.

The configuration space read/write themselves are protected by the
pci_lock spinlock.

> > +	/* Start PIO */
> > +	advk_writel(pcie, 0, PIO_START);
> > +	advk_writel(pcie, 1, PIO_ISR);
> > +
> > +	/* Program the control register */
> > +	if (bus->number ==  0)
> > +		advk_writel(pcie, PCIE_CONFIG_RD_TYPE0, PIO_CTRL);  
> 
> Your DT documentation requires the bus range, and
> of_pci_get_host_bridge_resources() parses it, so you probably should
> save that bus range from the DT in advk_pcie and use it here instead
> of assuming zero.

Good point, fixed.

> > +	if (where % size) {
> > +		advk_pcie_enable_axi_addr_gen(pcie, true);
> > +		return PCIBIOS_SET_FAILED;  
> 
> This could be checked earlier, before fiddling with AXI and touching
> PIO_START.

Ditto, fixed.

> > +static void advk_pcie_free_msi(struct advk_pcie *pcie, int hwirq)
> > +{
> > +	mutex_lock(&pcie->msi_used_lock);
> > +	if (!test_bit(hwirq, pcie->msi_irq_in_use))
> > +		pr_err("trying to free unused MSI#%d\n", hwirq);  
> 
> Use dev_err().

Indeed, fixed.

> > +	pcie->irq_domain =
> > +		irq_domain_add_linear(pcie_intc_node, LEGACY_IRQ_NUM,
> > +				      &advk_pcie_irq_domain_ops, pcie);
> > +	if (!pcie->irq_domain) {
> > +		dev_err(dev, "Failed to get a INTx IRQ domain\n");
> > +		return PTR_ERR(pcie->irq_domain);
> > +	}  
> 
> Can you rename this to advk_pcie_init_irq_domain() and possibly split
> to advk_pcie_init_msi_irq_domain() so it looks more similar to the
> other drivers, e.g., nwl_pcie_init_irq_domain() or
> xilinx_pcie_init_irq_domain()?

I've done two functions:

 advk_pcie_init_irq_domain()
 advk_pcie_init_msi_irq_domain()

Both are called from probe(). In some other drivers, I've noticed that
the function initializing the legacy interrupt irq_domain also calls
the function initializing the MSI irq_domain, but I find this rather
weird since they are really independent. To me, it makes a lot more
sense that probe() calls each of them independently.

Also, while doing this, I noticed we were leaking a device_node
reference count, so I fixed that up as well.


> > +static void advk_pcie_release_of_pci_ranges(struct advk_pcie *pcie)
> > +{
> > +	pci_free_resource_list(&pcie->resources);  
> 
> You can inline this call below; I know other drivers wrap it too, but
> I don't know why.

Done.

> > +static const struct of_device_id advk_pcie_of_match_table[] = {
> > +	{ .compatible = "marvell,armada-3700-pcie", },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, advk_pcie_of_match_table);  
> 
> Since this driver is currently bool in Kconfig, can you omit the
> MODULE_*() uses?  It would be ideal to make this modular, of course,
> but if it's not modular, let's make it so it doesn't *look* like a
> module.

MODULE_DEVICE_TABLE() removed.

> > +static struct platform_driver advk_pcie_driver = {
> > +	.driver = {
> > +		.name = "advk-pcie",
> > +		.of_match_table = advk_pcie_of_match_table,
> > +		/* Driver unloading/unbinding currently not supported */
> > +		.suppress_bind_attrs = true,  
> 
> I see some other drivers (mvebu, rcar, tegra, altera, xilinx) also use
> suppress_bind_attrs = true, but I don't know what's special about
> them.  Do you know?  Do we really need this here?  What would it take
> to change this driver so we could omit it?

My understanding is that for the unbinding to work, you need a
->remove() hook. But the PCI infrastructure doesn't provide any
functionality to "unregister" a PCI controller. It's exactly the same
reason for which we can't make such drivers modules: because there is
no way to implement a ->remove() function that unregisters the PCI host
controller from the PCI core.

Is this a topic that is being worked on in the PCI core?

In any case, I've kept the 'suppress_bind_attrs = true' for now, since
changing the PCI core to support controller unregistration is well
beyond the addition of a single controller driver.

I'm going to send the v3 soonish, which takes into account all your
comments, as mentioned above.

Thanks again for the good review!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
