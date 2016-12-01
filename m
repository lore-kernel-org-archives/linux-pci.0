Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 1 Dec 2016 13:41:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH v3] PCI/ACPI: xgene: Add ECAM quirk for X-Gene PCIe
 controller
Message-ID: <20161201194114.GA8263@bhelgaas-glaptop.roam.corp.google.com>
References: <1480549373-2123-1-git-send-email-dhdang@apm.com>
 <20161201183350.GF30746@bhelgaas-glaptop.roam.corp.google.com>
 <1480620053.4751.30.camel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1480620053.4751.30.camel@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Arnd Bergmann <arnd@arndb.de>, Rafael Wysocki <rafael@kernel.org>,
 linux-pci@vger.kernel.org, Duc Dang <dhdang@apm.com>,
 patches <patches@apm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jon Masters <jcm@redhat.com>, Tomasz Nowicki <tn@semihalf.com>,
 linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 01, 2016 at 02:20:53PM -0500, Mark Salter wrote:
> On Thu, 2016-12-01 at 12:33 -0600, Bjorn Helgaas wrote:
> > On Wed, Nov 30, 2016 at 03:42:53PM -0800, Duc Dang wrote:

> > > +static struct resource xgene_v1_csr_res[] =3D {
> > > +	[0] =3D DEFINE_RES_MEM_NAMED(0x1f2b0000UL, SZ_64K, "PCIe CSR"),
> > > +	[1] =3D DEFINE_RES_MEM_NAMED(0x1f2c0000UL, SZ_64K, "PCIe CSR"),
> > > +	[2] =3D DEFINE_RES_MEM_NAMED(0x1f2d0000UL, SZ_64K, "PCIe CSR"),
> > > +	[3] =3D DEFINE_RES_MEM_NAMED(0x1f500000UL, SZ_64K, "PCIe CSR"),
> > > +	[4] =3D DEFINE_RES_MEM_NAMED(0x1f510000UL, SZ_64K, "PCIe CSR"),
> > I assume these ranges are not the actual ECAM space, right?
> > If they *were* ECAM, I assume you would have included them in the
> > quirk itself in the mcfg_quirks[] table.
> =

> These are base addresses for some RC mmio registers.
> > =

> > > =

> > > +static int xgene_v1_pcie_ecam_init(struct pci_config_window *cfg)
> > > +{
> > > +	struct acpi_device *adev =3D to_acpi_device(cfg->parent);
> > > +	struct acpi_pci_root *root =3D acpi_driver_data(adev);
> > > +	struct device *dev =3D cfg->parent;
> > > +	struct xgene_pcie_port *port;
> > > +	struct resource *csr;
> > > +
> > > +	port =3D devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> > > +	if (!port)
> > > +		return -ENOMEM;
> > > +
> > > +	csr =3D &xgene_v1_csr_res[root->segment];
> > This makes me nervous because root->segment comes from the ACPI _SEG,
> > and if firmware gives us junk in _SEG, we will reference something in
> > the weeds.
> =

> The SoC provide some number of RC bridges, each with a different base
> for some mmio registers. Even if segment is legitimate in MCFG, there
> is still a problem if a platform doesn't use the segment ordering
> implied by the code. But the PNP0A03 _CRS does have this base address
> as the first memory resource, so we could get it from there and not
> have hard-coded addresses and implied ording in the quirk code.

I'm confused.  Doesn't the current code treat every item in PNP0A03
_CRS as a window?  Do you mean the first resource is handled
differently somehow?  The Consumer/Producer bit could allow us to do
this by marking the RC MMIO space as "Consumer", but I didn't think
that strategy was quite working yet.

> I have tested a modified version of these quirks using this to
> get the CSR base and it works on the 3 different platforms I have
> access to.
> =

> static int xgene_pcie_get_csr(struct device *dev, struct resource *r)
> {
> 	struct acpi_device *adev =3D to_acpi_device(dev);
> 	unsigned long flags;
> 	struct list_head list;
> 	struct resource_entry *entry;
> 	int ret;
> =

> 	INIT_LIST_HEAD(&list);
> 	flags =3D IORESOURCE_MEM;
> 	ret =3D acpi_dev_get_resources(adev, &list,
> 				=A0=A0=A0=A0=A0acpi_dev_filter_resource_type_cb,
> 				=A0=A0=A0=A0=A0(void *)flags);
> 	if (ret < 0) {
> 		dev_err(dev, "failed to parse _CRS, error: %d\n", ret);
> 		return ret;
> 	} else if (ret =3D=3D 0) {
> 		dev_err(dev, "no memory resources present in _CRS\n");
> 		return -EINVAL;
> 	}
> =

> 	entry =3D list_first_entry(&list, struct resource_entry, node);
> 	*r =3D *entry->res;
> 	acpi_dev_free_resource_list(&list);
> 	return 0;
> }

The code above is identical to acpi_get_rc_addr(), which is used in
the acpi_get_rc_resources() path by the other quirks.  Can you use
that path, too, instead of reimplementing it here?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
