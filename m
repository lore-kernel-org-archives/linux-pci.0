Return-Path: <SRS0=a4ji=XQ=redhat.com=msalter@kernel.org>
Return-Path: <SRS0=a4ji=XQ=redhat.com=msalter@kernel.org>
Message-ID: <1480620053.4751.30.camel@redhat.com>
Subject: Re: [PATCH v3] PCI/ACPI: xgene: Add ECAM quirk for X-Gene PCIe
 controller
From: Mark Salter <msalter@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Duc Dang <dhdang@apm.com>
Cc: Rafael Wysocki <rafael@kernel.org>,
        Lorenzo Pieralisi
 <Lorenzo.Pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-arm
 <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>,
        Jon Masters <jcm@redhat.com>, Tomasz
 Nowicki <tn@semihalf.com>,
        patches <patches@apm.com>
Date: Thu, 01 Dec 2016 14:20:53 -0500
In-Reply-To: <20161201183350.GF30746@bhelgaas-glaptop.roam.corp.google.com>
References: <1480549373-2123-1-git-send-email-dhdang@apm.com>
	 <20161201183350.GF30746@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2016-12-01 at 12:33 -0600, Bjorn Helgaas wrote:
> Hi Duc,
> 
> On Wed, Nov 30, 2016 at 03:42:53PM -0800, Duc Dang wrote:
> > 
> > PCIe controllers in X-Gene SoCs is not ECAM compliant: software
> > needs to configure additional controller's register to address
> > device at bus:dev:function.
> > 
> > The quirk will only be applied for X-Gene PCIe MCFG table with
> > OEM revison 1, 2, 3 or 4 (PCIe controller v1 and v2 on X-Gene SoCs).
> > 
> > The quirk declares the X-Gene PCIe controller register space as 64KB
> > fixed memory resource with name "PCIe CSR". This name will be showed
> > next to the resource range in the output of "cat /proc/iomem".
> > 
> > Signed-off-by: Duc Dang <dhdang@apm.com>
> > ---
> > v3:
> >   - Rebase on top of pci/ecam-v6 tree.
> >   - Use DEFINE_RES_MEM_NAMED to declare controller register space
> >   with name "PCIe CSR"
> > v2:
> >   RFC v2: https://patchwork.ozlabs.org/patch/686846/
> > v1:
> >   RFC v1: https://patchwork.kernel.org/patch/9337115/
> > 
> >  drivers/acpi/pci_mcfg.c      |  31 ++++++++
> >  drivers/pci/host/pci-xgene.c | 165 ++++++++++++++++++++++++++++++++++++++++++-
> >  include/linux/pci-ecam.h     |   7 ++
> >  3 files changed, 200 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> > index ac21db3..eb6125b 100644
> > --- a/drivers/acpi/pci_mcfg.c
> > +++ b/drivers/acpi/pci_mcfg.c
> > @@ -57,6 +57,37 @@ struct mcfg_fixup {
> >  	{ "QCOM  ", "QDF2432 ", 1, 5, MCFG_BUS_ANY, &pci_32b_ops },
> >  	{ "QCOM  ", "QDF2432 ", 1, 6, MCFG_BUS_ANY, &pci_32b_ops },
> >  	{ "QCOM  ", "QDF2432 ", 1, 7, MCFG_BUS_ANY, &pci_32b_ops },
> > +
> > +#ifdef CONFIG_PCI_XGENE
> As you've no doubt noticed, I'm proposing to add these quirks without
> CONFIG_PCI_XGENE, so we don't have to select each device when building
> a generic ACPI kernel.
> 
> I'm also proposing some Kconfig and Makefile changes so we don't build
> the platform driver part in a generic ACPI kernel (unless we *also*
> explicitly select the platform driver).
> 
> Here's an example:
> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/ecam&id=f80edf4d6c05
> 
> > 
> > +#define XGENE_V1_ECAM_MCFG(rev, seg) \
> > +	{"APM   ", "XGENE   ", rev, seg, MCFG_BUS_ANY, \
> > +		&xgene_v1_pcie_ecam_ops }
> > +#define XGENE_V2_1_ECAM_MCFG(rev, seg) \
> > +	{"APM   ", "XGENE   ", rev, seg, MCFG_BUS_ANY, \
> > +		&xgene_v2_1_pcie_ecam_ops }
> > +#define XGENE_V2_2_ECAM_MCFG(rev, seg) \
> > +	{"APM   ", "XGENE   ", rev, seg, MCFG_BUS_ANY, \
> > +		&xgene_v2_2_pcie_ecam_ops }
> > +
> > +	/* X-Gene SoC with v1 PCIe controller */
> > +	XGENE_V1_ECAM_MCFG(1, 0),
> > +	XGENE_V1_ECAM_MCFG(1, 1),
> > 
> > @@ -64,6 +66,7 @@
> >  /* PCIe IP version */
> >  #define XGENE_PCIE_IP_VER_UNKN		0
> >  #define XGENE_PCIE_IP_VER_1		1
> > +#define XGENE_PCIE_IP_VER_2		2
> This isn't used anywhere, which makes me wonder whether it's worth
> keeping it.
> 
> > 
> >  static void __iomem *xgene_pcie_get_cfg_base(struct pci_bus *bus)
> >  {
> > -	struct xgene_pcie_port *port = bus->sysdata;
> > +	struct pci_config_window *cfg;
> > +	struct xgene_pcie_port *port;
> > +
> > +	if (acpi_disabled)
> > +		port = bus->sysdata;
> > +	else {
> > +		cfg = bus->sysdata;
> > +		port = cfg->priv;
> > +	}
> I would really, really like to figure out a way to get rid of these
> "if (acpi_disabled)" checks sprinkled through here.  Is there any way
> we can set up bus->sysdata to be the same, regardless of whether we're
> using this as a platform driver or an ACPI quirk?
> 
> > 
> > +#ifdef CONFIG_ACPI
> You've probably noticed that I've been using
> 
>   #if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
> 
> in this situation, mostly to make it clear that this is part of a
> workaround.  I don't want people to blindly copy this stuff without
> realizing that it's a workaround for a hardware issue.
> 
> > 
> > +static struct resource xgene_v1_csr_res[] = {
> > +	[0] = DEFINE_RES_MEM_NAMED(0x1f2b0000UL, SZ_64K, "PCIe CSR"),
> > +	[1] = DEFINE_RES_MEM_NAMED(0x1f2c0000UL, SZ_64K, "PCIe CSR"),
> > +	[2] = DEFINE_RES_MEM_NAMED(0x1f2d0000UL, SZ_64K, "PCIe CSR"),
> > +	[3] = DEFINE_RES_MEM_NAMED(0x1f500000UL, SZ_64K, "PCIe CSR"),
> > +	[4] = DEFINE_RES_MEM_NAMED(0x1f510000UL, SZ_64K, "PCIe CSR"),
> I assume these ranges are not the actual ECAM space, right?
> If they *were* ECAM, I assume you would have included them in the
> quirk itself in the mcfg_quirks[] table.

These are base addresses for some RC mmio registers.
> 
> > 
> > +static int xgene_v1_pcie_ecam_init(struct pci_config_window *cfg)
> > +{
> > +	struct acpi_device *adev = to_acpi_device(cfg->parent);
> > +	struct acpi_pci_root *root = acpi_driver_data(adev);
> > +	struct device *dev = cfg->parent;
> > +	struct xgene_pcie_port *port;
> > +	struct resource *csr;
> > +
> > +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> > +	if (!port)
> > +		return -ENOMEM;
> > +
> > +	csr = &xgene_v1_csr_res[root->segment];
> This makes me nervous because root->segment comes from the ACPI _SEG,
> and if firmware gives us junk in _SEG, we will reference something in
> the weeds.

The SoC provide some number of RC bridges, each with a different base
for some mmio registers. Even if segment is legitimate in MCFG, there
is still a problem if a platform doesn't use the segment ordering
implied by the code. But the PNP0A03 _CRS does have this base address
as the first memory resource, so we could get it from there and not
have hard-coded addresses and implied ording in the quirk code.

I have tested a modified version of these quirks using this to
get the CSR base and it works on the 3 different platforms I have
access to.

static int xgene_pcie_get_csr(struct device *dev, struct resource *r)
{
	struct acpi_device *adev = to_acpi_device(dev);
	unsigned long flags;
	struct list_head list;
	struct resource_entry *entry;
	int ret;

	INIT_LIST_HEAD(&list);
	flags = IORESOURCE_MEM;
	ret = acpi_dev_get_resources(adev, &list,
				     acpi_dev_filter_resource_type_cb,
				     (void *)flags);
	if (ret < 0) {
		dev_err(dev, "failed to parse _CRS, error: %d\n", ret);
		return ret;
	} else if (ret == 0) {
		dev_err(dev, "no memory resources present in _CRS\n");
		return -EINVAL;
	}

	entry = list_first_entry(&list, struct resource_entry, node);
	*r = *entry->res;
	acpi_dev_free_resource_list(&list);
	return 0;
}

> 
> > 
> > +	port->csr_base = devm_ioremap_resource(dev, csr);
> > +	if (IS_ERR(port->csr_base)) {
> > +		kfree(port);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	port->cfg_base = cfg->win;
> > +	port->version = XGENE_PCIE_IP_VER_1;
> > +
> > +	cfg->priv = port;
> All these init functions are almost identical.  Can we factor this out
> by having wrappers that do nothing more than pass in the table and
> version, and put the kzalloc and ioremap in a shared back-end?
> 
> We're so close I can taste it!  I can't wait to see all this work come
> to fruition.
> 
> Bjorn
