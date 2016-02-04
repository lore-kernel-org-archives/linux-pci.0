Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
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
Subject: Re: [RFC PATCH 0/4] Add ACPI support for HiSilicon PCIe Host Controllers
Date: Thu, 04 Feb 2016 17:07:17 +0100
Message-ID: <76564455.dlc1WHiVY2@wuerfel>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1EC9EC12@lhreml503-mbs>
References: <1454585860-60709-1-git-send-email-gabriele.paoloni@huawei.com> <2387127.DMZaDnZvEW@wuerfel> <EE11001F9E5DDD47B7634E2F8A612F2E1EC9EC12@lhreml503-mbs>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 04 February 2016 15:11:18 Gabriele Paoloni wrote:
> > 
> > ACPI has its own PCI support, and should not need drivers for host
> > bridges. I don't think we can really mix the two things, as ACPI
> > needs to have access to things like PCI config space way before
> > we are probing normal device drivers.
> > 
> > Please put this in drivers/acpi/pci*.c.
> 
> I can put pcie-hisi-acpi.c under drivers/acpi/
> 
> However if you look at the driver it is made up of three parts:
> pcie-hisi.c --> the DT based driver
> pcie-hisi-acpi.c --> the ACPI based hook and ACPI specific init callback
> pcie-hisi-common.c --> common functions shared between DT and ACPI versions 
>                        of the driver
> 
> Now I think that moving pcie-hisi-acpi.c under drivers/acpi/
> would make it hard to read as you need to jump across directories
> and it seems a bit unnatural...
> 
> However it is not a big issue to me...

That's not really what I meant though: the pcie-hisi driver uses the
pcie-designware.c library, most of which makes no sense in an environment
where you have ACPI, e.g. link training, custom MSI support, initial
register setup, platform driver hooks, etc.

You should add a very minimal set of hacks for the parts in this driver
that diverge from a standard SBSA compliant PCIe host that ACPI expects.

	Arnd
