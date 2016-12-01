Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 1 Dec 2016 17:07:36 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Duc Dang <dhdang@apm.com>
Subject: Re: [PATCH v3] PCI/ACPI: xgene: Add ECAM quirk for X-Gene PCIe
 controller
Message-ID: <20161201230736.GA17948@bhelgaas-glaptop.roam.corp.google.com>
References: <1480549373-2123-1-git-send-email-dhdang@apm.com>
 <20161201183350.GF30746@bhelgaas-glaptop.roam.corp.google.com>
 <1480620053.4751.30.camel@redhat.com>
 <20161201194114.GA8263@bhelgaas-glaptop.roam.corp.google.com>
 <CADaLNDkVPRPSg0aU-sxHsiJbVvEn=LxcekDt6gfXBBhc+fzhjw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CADaLNDkVPRPSg0aU-sxHsiJbVvEn=LxcekDt6gfXBBhc+fzhjw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Jon Masters <jcm@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Rafael Wysocki <rafael@kernel.org>,
 linux-pci@vger.kernel.org, patches <patches@apm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mark Salter <msalter@redhat.com>, Tomasz Nowicki <tn@semihalf.com>,
 linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 01, 2016 at 02:10:10PM -0800, Duc Dang wrote:
> On Thu, Dec 1, 2016 at 11:41 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Dec 01, 2016 at 02:20:53PM -0500, Mark Salter wrote:
> >> On Thu, 2016-12-01 at 12:33 -0600, Bjorn Helgaas wrote:
> >> > On Wed, Nov 30, 2016 at 03:42:53PM -0800, Duc Dang wrote:
> >
> >> > > +static struct resource xgene_v1_csr_res[] = {
> >> > > + [0] = DEFINE_RES_MEM_NAMED(0x1f2b0000UL, SZ_64K, "PCIe CSR"),
> >> > > + [1] = DEFINE_RES_MEM_NAMED(0x1f2c0000UL, SZ_64K, "PCIe CSR"),
> >> > > + [2] = DEFINE_RES_MEM_NAMED(0x1f2d0000UL, SZ_64K, "PCIe CSR"),
> >> > > + [3] = DEFINE_RES_MEM_NAMED(0x1f500000UL, SZ_64K, "PCIe CSR"),
> >> > > + [4] = DEFINE_RES_MEM_NAMED(0x1f510000UL, SZ_64K, "PCIe CSR"),
> >> > I assume these ranges are not the actual ECAM space, right?
> >> > If they *were* ECAM, I assume you would have included them in the
> >> > quirk itself in the mcfg_quirks[] table.
> >>
> >> These are base addresses for some RC mmio registers.
> >> >
> >> > >
> >> > > +static int xgene_v1_pcie_ecam_init(struct pci_config_window *cfg)
> >> > > +{
> >> > > + struct acpi_device *adev = to_acpi_device(cfg->parent);
> >> > > + struct acpi_pci_root *root = acpi_driver_data(adev);
> >> > > + struct device *dev = cfg->parent;
> >> > > + struct xgene_pcie_port *port;
> >> > > + struct resource *csr;
> >> > > +
> >> > > + port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> >> > > + if (!port)
> >> > > +         return -ENOMEM;
> >> > > +
> >> > > + csr = &xgene_v1_csr_res[root->segment];
> >> > This makes me nervous because root->segment comes from the ACPI _SEG,
> >> > and if firmware gives us junk in _SEG, we will reference something in
> >> > the weeds.
> >>
> >> The SoC provide some number of RC bridges, each with a different base
> >> for some mmio registers. Even if segment is legitimate in MCFG, there
> >> is still a problem if a platform doesn't use the segment ordering
> >> implied by the code. But the PNP0A03 _CRS does have this base address
> >> as the first memory resource, so we could get it from there and not
> >> have hard-coded addresses and implied ording in the quirk code.
> >
> > I'm confused.  Doesn't the current code treat every item in PNP0A03
> > _CRS as a window?  Do you mean the first resource is handled
> > differently somehow?  The Consumer/Producer bit could allow us to do
> > this by marking the RC MMIO space as "Consumer", but I didn't think
> > that strategy was quite working yet.
> 
> The first resource is defined like below. It was introduced long time
> ago to use with older version of X-Gene ECAM quirks.
> Memory32Fixed(ReadWrite, 0x1F2B0000, 0x10000, )

> [    0.822990] pci_bus 0000:00: root bus resource [mem 0x1f2b0000-0x1f2bffff]

I think this is wrong.  The PCI core thinks [mem 0x1f2b0000-0x1f2bffff]
is available for use by devices on bus 0000:00, but I think you're
saying it is consumed by the bridge itself, not forwarded down to PCI.

What's in your /proc/iomem?  I see that your quirks do call
devm_ioremap_resource(), which calls devm_request_mem_region()
internally, so the driver does at least request that region, which
should keep us from assigning it to PCI devices.

But it still isn't quite right to tell the PCI core that the region is
available on the root bus.

Bjorn


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
