Return-Path: <gabriele.paoloni@huawei.com>
Return-Path: <gabriele.paoloni@huawei.com>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Arnd Bergmann <arnd@arndb.de>, "liudongdong (C)" <liudongdong3@huawei.com>
CC: "helgaas@kernel.org" <helgaas@kernel.org>,
        "rafael@kernel.org"
	<rafael@kernel.org>,
        "Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>,
        "tn@semihalf.com" <tn@semihalf.com>,
        "Wangzhou (B)"
	<wangzhou1@hisilicon.com>,
        "pratyush.anand@gmail.com"
	<pratyush.anand@gmail.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "jcm@redhat.com" <jcm@redhat.com>,
        "Chenxin
 (Charles)" <charles.chenxin@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [RFC PATCH 3/3] PCI/ACPI: hisi: Add ACPI support for HiSilicon
 SoCs Host Controllers
Date: Tue, 12 Jul 2016 10:21:30 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F7D72BF@lhreml507-mbx>
References: <1468291344-122909-1-git-send-email-liudongdong3@huawei.com>
 <1468291344-122909-4-git-send-email-liudongdong3@huawei.com>
 <3580311.QdyhSxNzVU@wuerfel>
In-Reply-To: <3580311.QdyhSxNzVU@wuerfel>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: 12 July 2016 16:35
> To: liudongdong (C)
> Cc: helgaas@kernel.org; rafael@kernel.org; Lorenzo.Pieralisi@arm.com;
> tn@semihalf.com; Wangzhou (B); pratyush.anand@gmail.com; linux-
> pci@vger.kernel.org; linux-acpi@vger.kernel.org; linux-
> kernel@vger.kernel.org; jcm@redhat.com; Gabriele Paoloni; Chenxin
> (Charles); Linuxarm
> Subject: Re: [RFC PATCH 3/3] PCI/ACPI: hisi: Add ACPI support for
> HiSilicon SoCs Host Controllers
>=20
> On Tuesday, July 12, 2016 10:42:24 AM CEST Dongdong Liu wrote:
> >  MAINTAINERS                       |   1 +
> >  drivers/pci/host/Kconfig          |   7 ++
> >  drivers/pci/host/Makefile         |   1 +
> >  drivers/pci/host/mcfg-quirks.c    |   8 ++
> >  drivers/pci/host/mcfg-quirks.h    |   8 ++
> >  drivers/pci/host/pcie-hisi-acpi.c | 151
> ++++++++++++++++++++++++++++++++++++++
> >  drivers/pci/host/pcie-hisi.c      |   2 -
> >  drivers/pci/host/pcie-hisi.h      |   2 +
> >  8 files changed, 178 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/pci/host/pcie-hisi-acpi.c
> >
> >
>=20
> Please keep the quirks separate from the PCI host drivers.
>=20
> The ACPI code includes its own host driver and the only thing
> you need to override here is the config space access, so just put that
> into drivers/acpi/

Hi Arnd, thanks for replying.

Basically we just followed what Tomasz has done in
"[RFC PATCH v4 0/5] ECAM quirks handling for ARM64 platforms"

In this case the ThunderX quirks have been defined in
"drivers/pci/host/pci-thunder-pem.c".

Cheers
Gab

>=20
> 	Arnd
