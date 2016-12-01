Return-Path: <SRS0=hbVC=XQ=apm.com=dhdang@kernel.org>
Return-Path: <SRS0=hbVC=XQ=apm.com=dhdang@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161201230736.GA17948@bhelgaas-glaptop.roam.corp.google.com>
References: <1480549373-2123-1-git-send-email-dhdang@apm.com>
 <20161201183350.GF30746@bhelgaas-glaptop.roam.corp.google.com>
 <1480620053.4751.30.camel@redhat.com> <20161201194114.GA8263@bhelgaas-glaptop.roam.corp.google.com>
 <CADaLNDkVPRPSg0aU-sxHsiJbVvEn=LxcekDt6gfXBBhc+fzhjw@mail.gmail.com> <20161201230736.GA17948@bhelgaas-glaptop.roam.corp.google.com>
From: Duc Dang <dhdang@apm.com>
Date: Thu, 1 Dec 2016 15:22:16 -0800
Message-ID: <CADaLND=Ss8d-jv7wffbrtytrjj=SUnjDn9bognKUszhKguRV1A@mail.gmail.com>
Subject: Re: [PATCH v3] PCI/ACPI: xgene: Add ECAM quirk for X-Gene PCIe controller
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mark Salter <msalter@redhat.com>, Rafael Wysocki <rafael@kernel.org>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jon Masters <jcm@redhat.com>,
	Tomasz Nowicki <tn@semihalf.com>, patches <patches@apm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 1, 2016 at 3:07 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Thu, Dec 01, 2016 at 02:10:10PM -0800, Duc Dang wrote:
>> On Thu, Dec 1, 2016 at 11:41 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> > On Thu, Dec 01, 2016 at 02:20:53PM -0500, Mark Salter wrote:
>> >> On Thu, 2016-12-01 at 12:33 -0600, Bjorn Helgaas wrote:
>> >> > On Wed, Nov 30, 2016 at 03:42:53PM -0800, Duc Dang wrote:
>> >
>> >> > > +static struct resource xgene_v1_csr_res[] = {
>> >> > > + [0] = DEFINE_RES_MEM_NAMED(0x1f2b0000UL, SZ_64K, "PCIe CSR"),
>> >> > > + [1] = DEFINE_RES_MEM_NAMED(0x1f2c0000UL, SZ_64K, "PCIe CSR"),
>> >> > > + [2] = DEFINE_RES_MEM_NAMED(0x1f2d0000UL, SZ_64K, "PCIe CSR"),
>> >> > > + [3] = DEFINE_RES_MEM_NAMED(0x1f500000UL, SZ_64K, "PCIe CSR"),
>> >> > > + [4] = DEFINE_RES_MEM_NAMED(0x1f510000UL, SZ_64K, "PCIe CSR"),
>> >> > I assume these ranges are not the actual ECAM space, right?
>> >> > If they *were* ECAM, I assume you would have included them in the
>> >> > quirk itself in the mcfg_quirks[] table.
>> >>
>> >> These are base addresses for some RC mmio registers.
>> >> >
>> >> > >
>> >> > > +static int xgene_v1_pcie_ecam_init(struct pci_config_window *cfg)
>> >> > > +{
>> >> > > + struct acpi_device *adev = to_acpi_device(cfg->parent);
>> >> > > + struct acpi_pci_root *root = acpi_driver_data(adev);
>> >> > > + struct device *dev = cfg->parent;
>> >> > > + struct xgene_pcie_port *port;
>> >> > > + struct resource *csr;
>> >> > > +
>> >> > > + port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
>> >> > > + if (!port)
>> >> > > +         return -ENOMEM;
>> >> > > +
>> >> > > + csr = &xgene_v1_csr_res[root->segment];
>> >> > This makes me nervous because root->segment comes from the ACPI _SEG,
>> >> > and if firmware gives us junk in _SEG, we will reference something in
>> >> > the weeds.
>> >>
>> >> The SoC provide some number of RC bridges, each with a different base
>> >> for some mmio registers. Even if segment is legitimate in MCFG, there
>> >> is still a problem if a platform doesn't use the segment ordering
>> >> implied by the code. But the PNP0A03 _CRS does have this base address
>> >> as the first memory resource, so we could get it from there and not
>> >> have hard-coded addresses and implied ording in the quirk code.
>> >
>> > I'm confused.  Doesn't the current code treat every item in PNP0A03
>> > _CRS as a window?  Do you mean the first resource is handled
>> > differently somehow?  The Consumer/Producer bit could allow us to do
>> > this by marking the RC MMIO space as "Consumer", but I didn't think
>> > that strategy was quite working yet.
>>
>> The first resource is defined like below. It was introduced long time
>> ago to use with older version of X-Gene ECAM quirks.
>> Memory32Fixed(ReadWrite, 0x1F2B0000, 0x10000, )
>
>> [    0.822990] pci_bus 0000:00: root bus resource [mem 0x1f2b0000-0x1f2bffff]
>
> I think this is wrong.  The PCI core thinks [mem 0x1f2b0000-0x1f2bffff]
> is available for use by devices on bus 0000:00, but I think you're
> saying it is consumed by the bridge itself, not forwarded down to PCI.
>
> What's in your /proc/iomem?  I see that your quirks do call
> devm_ioremap_resource(), which calls devm_request_mem_region()
> internally, so the driver does at least request that region, which
> should keep us from assigning it to PCI devices.
>
> But it still isn't quite right to tell the PCI core that the region is
> available on the root bus.

This is /proc/iomem output on my Mustang board. The 64K "PCIe CSR"
region is consumed completely.
1f2b0000-1f2bffff : PCI Bus 0000:00
  1f2b0000-1f2bffff : PCIe CSR

e040000000-e07fffffff : PCI Bus 0000:00
  e040000000-e0401fffff : PCI Bus 0000:01
    e040000000-e0400fffff : 0000:01:00.0
      e040000000-e0400fffff : mlx4_core
    e040100000-e0401fffff : 0000:01:00.0
e0d0000000-e0dfffffff : PCI ECAM
f000000000-ffffffffff : PCI Bus 0000:00
  f000000000-f001ffffff : PCI Bus 0000:01
    f000000000-f001ffffff : 0000:01:00.0
      f000000000-f001ffffff : mlx4_core

Using hard-coded resources for mmio space make the quirk rely on the
segment number passing from the firmware. Using Mark's method or
acpi_get_rc_resource can discover the mmio space and consume all of
the space, but as you mentioned, it leaves the defect that PCI core
considers the mmio space as available resource for secondary devices
although it will never allocate the mmio space to secondary devices as
the RC already reserves and consumes all of the space.

>
> Bjorn
>
Regards,
Duc Dang.
