Return-Path: <gabriele.paoloni@huawei.com>
Return-Path: <gabriele.paoloni@huawei.com>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Arnd Bergmann
	<arnd@arndb.de>,
        "liudongdong (C)" <liudongdong3@huawei.com>
CC: "Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>,
        "Chenxin
 (Charles)" <charles.chenxin@huawei.com>,
        "rafael@kernel.org"
	<rafael@kernel.org>,
        "tn@semihalf.com" <tn@semihalf.com>,
        "pratyush.anand@gmail.com" <pratyush.anand@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm
	<linuxarm@huawei.com>,
        "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "jcm@redhat.com"
	<jcm@redhat.com>
Subject: RE: [RFC PATCH 3/3] PCI/ACPI: hisi: Add ACPI support for HiSilicon
	SoCs Host Controllers
Date: Tue, 12 Jul 2016 10:32:33 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F7D730E@lhreml507-mbx>
References: <1468291344-122909-1-git-send-email-liudongdong3@huawei.com>
	<1468291344-122909-4-git-send-email-liudongdong3@huawei.com>
	<3580311.QdyhSxNzVU@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F7D72BF@lhreml507-mbx>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1F7D72BF@lhreml507-mbx>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: linuxarm-bounces@huawei.com [mailto:linuxarm-bounces@huawei.com]
> On Behalf Of Gabriele Paoloni
> Sent: 12 July 2016 18:22
> To: Arnd Bergmann; liudongdong (C)
> Cc: Lorenzo.Pieralisi@arm.com; Chenxin (Charles); rafael@kernel.org;
> tn@semihalf.com; pratyush.anand@gmail.com; linux-kernel@vger.kernel.org;
> Linuxarm; linux-acpi@vger.kernel.org; helgaas@kernel.org; linux-
> pci@vger.kernel.org; jcm@redhat.com
> Subject: RE: [RFC PATCH 3/3] PCI/ACPI: hisi: Add ACPI support for
> HiSilicon SoCs Host Controllers
>=20
> > -----Original Message-----
> > From: Arnd Bergmann [mailto:arnd@arndb.de]
> > Sent: 12 July 2016 16:35
> > To: liudongdong (C)
> > Cc: helgaas@kernel.org; rafael@kernel.org; Lorenzo.Pieralisi@arm.com;
> > tn@semihalf.com; Wangzhou (B); pratyush.anand@gmail.com; linux-
> > pci@vger.kernel.org; linux-acpi@vger.kernel.org; linux-
> > kernel@vger.kernel.org; jcm@redhat.com; Gabriele Paoloni; Chenxin
> > (Charles); Linuxarm
> > Subject: Re: [RFC PATCH 3/3] PCI/ACPI: hisi: Add ACPI support for
> > HiSilicon SoCs Host Controllers
> >
> > On Tuesday, July 12, 2016 10:42:24 AM CEST Dongdong Liu wrote:
> > >  MAINTAINERS                       |   1 +
> > >  drivers/pci/host/Kconfig          |   7 ++
> > >  drivers/pci/host/Makefile         |   1 +
> > >  drivers/pci/host/mcfg-quirks.c    |   8 ++
> > >  drivers/pci/host/mcfg-quirks.h    |   8 ++
> > >  drivers/pci/host/pcie-hisi-acpi.c | 151
> > ++++++++++++++++++++++++++++++++++++++
> > >  drivers/pci/host/pcie-hisi.c      |   2 -
> > >  drivers/pci/host/pcie-hisi.h      |   2 +
> > >  8 files changed, 178 insertions(+), 2 deletions(-)
> > >  create mode 100644 drivers/pci/host/pcie-hisi-acpi.c
> > >
> > >
> >
> > Please keep the quirks separate from the PCI host drivers.
> >
> > The ACPI code includes its own host driver and the only thing
> > you need to override here is the config space access, so just put
> that
> > into drivers/acpi/
>=20
> Hi Arnd, thanks for replying.
>=20
> Basically we just followed what Tomasz has done in
> "[RFC PATCH v4 0/5] ECAM quirks handling for ARM64 platforms"
>=20
> In this case the ThunderX quirks have been defined in
> "drivers/pci/host/pci-thunder-pem.c".
>=20

Also on top of this I think that from
"Re: [RFC PATCH v3 1/2] ACPI/PCI: Check platform specific ECAM quirks"

Lorenzo suggested to add the static array of quirks (and therefore the
respective quirk mechanisms in "drivers/pci/host").

See:
[...]
It should be easier to implement (provided we find a place where
to add this static array of hooks matching MCFG, I suspect it is
going to be a file in drivers/pci/host but Tomasz and I need
input on that) and prevent abuse (since it is a static array of
hooks in a single place, it is easier to manage than section
entries).
[...]
=09
Thanks

Gab

> Cheers
> Gab
>=20
> >
> > 	Arnd
>=20
> _______________________________________________
> linuxarm mailing list
> linuxarm@huawei.com
> http://rnd-openeuler.huawei.com/mailman/listinfo/linuxarm
