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
Date: Thu, 4 Feb 2016 15:11:18 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1EC9EC12@lhreml503-mbs>
References: <1454585860-60709-1-git-send-email-gabriele.paoloni@huawei.com>
 <2387127.DMZaDnZvEW@wuerfel>
In-Reply-To: <2387127.DMZaDnZvEW@wuerfel>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd

Thanks for looking at this

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: 04 February 2016 13:12
> To: Gabriele Paoloni
> Cc: Guohanjun (Hanjun Guo); Wangzhou (B); liudongdong (C); Linuxarm;
> qiujiang; bhelgaas@google.com; Lorenzo.Pieralisi@arm.com;
> tn@semihalf.com; zhangjukuo; xuwei (O); Liguozhu (Kenneth); linux-
> pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> acpi@vger.kernel.org; linux-kernel@vger.kernel.org; jcm@redhat.com
> Subject: Re: [RFC PATCH 0/4] Add ACPI support for HiSilicon PCIe Host
> Controllers
> 
> On Thursday 04 February 2016 19:37:36 Gabriele Paoloni wrote:
> > From: gabriele paoloni <gabriele.paoloni@huawei.com>
> >
> > This patchset adds ACPI support for the HiSilicon Hip05/Hip06 SoC
> PCIe controllers
> > The four patches respectively:
> >         - rework PCie Designware to be used for ACPI PCI Host
> controllers
> >         - re-architect the current HiSilicon driver to make it
> scalable to the
> >           new ACPI quirks
> >         - rework the current HiSilicon driver to make it ECAM
> compliant
> >         - adds the HiSilicon ACPI specific quirks.
> >
> >    This patchset  is based on
> >    https://github.com/semihalf-nowicki-tomasz/linux.git
> >    branch pci-acpi-v3 + Hip06 support applied on top:
> >    https://patchwork.ozlabs.org/patch/549198/
> >
> 
> ACPI has its own PCI support, and should not need drivers for host
> bridges. I don't think we can really mix the two things, as ACPI
> needs to have access to things like PCI config space way before
> we are probing normal device drivers.
> 
> Please put this in drivers/acpi/pci*.c.

I can put pcie-hisi-acpi.c under drivers/acpi/

However if you look at the driver it is made up of three parts:
pcie-hisi.c --> the DT based driver
pcie-hisi-acpi.c --> the ACPI based hook and ACPI specific init callback
pcie-hisi-common.c --> common functions shared between DT and ACPI versions 
                       of the driver

Now I think that moving pcie-hisi-acpi.c under drivers/acpi/
would make it hard to read as you need to jump across directories
and it seems a bit unnatural...

However it is not a big issue to me...

Cheers

Gab

> 
> 	Arnd
