Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	"liudongdong (C)" <liudongdong3@huawei.com>,
	Linuxarm <linuxarm@huawei.com>, qiujiang <qiujiang@huawei.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>,
	"tn@semihalf.com" <tn@semihalf.com>,
	zhangjukuo <zhangjukuo@huawei.com>,
	"xuwei (O)" <xuwei5@hisilicon.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jcm@redhat.com" <jcm@redhat.com>
Subject: RE: [RFC PATCH 0/4] Add ACPI support for HiSilicon PCIe Host
 Controllers
Date: Thu, 4 Feb 2016 16:44:12 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1EC9EF4B@lhreml503-mbs>
References: <1454585860-60709-1-git-send-email-gabriele.paoloni@huawei.com>
 <2387127.DMZaDnZvEW@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1EC9EC12@lhreml503-mbs>
 <76564455.dlc1WHiVY2@wuerfel>
In-Reply-To: <76564455.dlc1WHiVY2@wuerfel>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: 04 February 2016 16:07
> To: Gabriele Paoloni
> Cc: Guohanjun (Hanjun Guo); Wangzhou (B); liudongdong (C); Linuxarm;
> qiujiang; bhelgaas@google.com; Lorenzo.Pieralisi@arm.com;
> tn@semihalf.com; zhangjukuo; xuwei (O); Liguozhu (Kenneth); linux-
> pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> acpi@vger.kernel.org; linux-kernel@vger.kernel.org; jcm@redhat.com
> Subject: Re: [RFC PATCH 0/4] Add ACPI support for HiSilicon PCIe Host
> Controllers
> 
> On Thursday 04 February 2016 15:11:18 Gabriele Paoloni wrote:
> > >
> > > ACPI has its own PCI support, and should not need drivers for host
> > > bridges. I don't think we can really mix the two things, as ACPI
> > > needs to have access to things like PCI config space way before
> > > we are probing normal device drivers.
> > >
> > > Please put this in drivers/acpi/pci*.c.
> >
> > I can put pcie-hisi-acpi.c under drivers/acpi/
> >
> > However if you look at the driver it is made up of three parts:
> > pcie-hisi.c --> the DT based driver
> > pcie-hisi-acpi.c --> the ACPI based hook and ACPI specific init
> callback
> > pcie-hisi-common.c --> common functions shared between DT and ACPI
> versions
> >                        of the driver
> >
> > Now I think that moving pcie-hisi-acpi.c under drivers/acpi/
> > would make it hard to read as you need to jump across directories
> > and it seems a bit unnatural...
> >
> > However it is not a big issue to me...
> 
> That's not really what I meant though: the pcie-hisi driver uses the
> pcie-designware.c library, most of which makes no sense in an
> environment
> where you have ACPI, e.g. link training, custom MSI support, initial
> register setup, platform driver hooks, etc.
> 
> You should add a very minimal set of hacks for the parts in this driver
> that diverge from a standard SBSA compliant PCIe host that ACPI expects.

Effectively the ACPI version of the HiSilicon driver does not rely on
Designware as much as the DT version (that calls dw_pcie_host_init());
however in order to do what you suggest I'd need to copy and paste and
modify dw_pcie_rd_conf and dw_pcie_wr_conf.
Also I'd need to declare duplicate version of the functions in
pcie-hisi-common.c (if I do not want to split the object across
different paths "drivers/pci/host" and "drivers/acpi/")

Now I can do it but I thought it was more correct to pass &dw_pcie_ops
as input pointer in DECLARE_ACPI_MCFG_FIXUP(); this is also because maybe in
future other Designware based controllers may need to support ACPI and it
would be easier for them to reuse their DT based driver functions

Honestly I am a bit confused...

Thanks

Gab

> 
> 	Arnd
