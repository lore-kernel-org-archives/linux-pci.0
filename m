Return-Path: <SRS0=kJo2=BJ=huawei.com=gabriele.paoloni@kernel.org>
Return-Path: <SRS0=kJo2=BJ=huawei.com=gabriele.paoloni@kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Shameerali Kolothum Thodi
	<shameerali.kolothum.thodi@huawei.com>
CC: Bjorn Helgaas <helgaas@kernel.org>,
        "Guohanjun (Hanjun Guo)"
	<guohanjun@huawei.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "joro@8bytes.org"
	<joro@8bytes.org>,
        John Garry <john.garry@huawei.com>,
        "will.deacon@arm.com"
	<will.deacon@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        "sudeep.holla@arm.com"
	<sudeep.holla@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "devel@acpica.org" <devel@acpica.org>
Subject: RE: [PATCH v9 4/4] PCI: hisi: blacklist hip06/hip07 controllers
 behind SMMUv3
Date: Tue, 10 Oct 2017 10:19:51 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40C5DC1F@FRAEML521-MBX.china.huawei.com>
References: <20171006140450.89652-1-shameerali.kolothum.thodi@huawei.com>
 <20171006140450.89652-5-shameerali.kolothum.thodi@huawei.com>
 <20171009235452.GP25517@bhelgaas-glaptop.roam.corp.google.com>
 <5FC3163CFD30C246ABAA99954A238FA838421875@FRAEML521-MBX.china.huawei.com>
 <20171010100630.GA764@red-moon>
In-Reply-To: <20171010100630.GA764@red-moon>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo

[...]

> > > Does the presence of "iommu-map" tell you this is an SMMUv3?  Could
> it
> > > have a different type of IOMMU?  I can't tell from reading
> > > Documentation/devicetree/bindings/pci/pci-iommu.txt.
> >
> > Only if the SMMUv3 driver is loaded and iommu-map binding property
> present,
> > the pcie devices will use SMMU translated iova for MSI doorbell
> addresses.
>=20
> And the iommu-map property _actually_ points at an OF node with an
> SMMUv3 compatible string - the sheer fact that the SMMUv3 driver
> is compiled in is not sufficient IIUC.

The blacklisted controller can only be present in an SoC that supports
SMMUv3 only.

>From our view checking that SMMUv3 is compiled in and also checking that
the DT contains iommu-map is sufficient to decide to blacklist the controll=
er.

Thanks
Gab=20

>=20
> Lorenzo
>=20

[...]
