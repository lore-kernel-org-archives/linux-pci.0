Return-Path: <SRS0=+Q74=Z4=samsung.com=jh80.chung@kernel.org>
Return-Path: <SRS0=+Q74=Z4=samsung.com=jh80.chung@kernel.org>
Subject: Re: [PATCH V3 0/4] PCI: exynos: use the PHY generic framework
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, krzk@kernel.org,
 linux-kernel@vger.kernel.org, jingoohan1@gmail.com, javier@osg.samsung.com,
 kgene@kernel.org, linux-samsung-soc@vger.kernel.org, cpgs@samsung.com,
 niyas.ahmed@samsung.com, alim.akhtar@samsung.com, pankaj.dubey@samsung.com,
 kishon@ti.com, devicetree@vger.kernel.org, mark.rutland@arm.com,
 vivek.gautam@codeaurora.org, robh+dt@kernel.org
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-id: <04b568d2-d85e-9cbd-1379-d657f574f279@samsung.com>
Date: Thu, 16 Feb 2017 07:33:15 +0900
MIME-version: 1.0
In-reply-to: <20170215211120.GC6981@bhelgaas-glaptop.roam.corp.google.com>
Content-type: text/plain; charset=windows-1252
References: 
 <CGME20170213082615epcas5p2f5ecabbd5853a8e27da5f88fcae85158@epcas5p2.samsung.com>
 <20170213082613.19628-1-jh80.chung@samsung.com>
 <20170215211120.GC6981@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

Dear Bjorn,

On 02/16/2017 06:11 AM, Bjorn Helgaas wrote:
> On Mon, Feb 13, 2017 at 05:26:09PM +0900, Jaehoon Chung wrote:
>> This patcheset is for using PHY generic framework.
>> Current pci-exyns doesn't use the phy framework since there haven't been on
>> PHY subsystem when Exynos5440 had bean upstreamed.
>> It's making a difficult to upstream the other Exynos variants because of different
>> PHY registers.
>>
>> This patcheset has the below modifications:
>> 1) Introduces the phy-exynos-pcie
>> 2) Handles PHY register from PHY framework for pci-exynos
>> 3) Modifies the dt-binding of pci-exynos
>> 4) Maintains the backward compatibility
>>
>> Changelog on V3:
>> - Drops "ARM: dts: exynos5440: support the phy-pcie node of pcie"
>>   : Will send this patch after applying this patchset.
>> - Fixes typo
>> - Based on latest PCI git repository (host-exynos branch)
>> - Changes commit message
>> - Removes the dependency
>>
>> Changelog on V2:
>> - Keep current codes for backward compatibility
>> - Fixes some typos
>> - Split the patches for removing the dependency
>> - Removes the unnecessary codes
>> - Change the patch's sequence
>> - Based on latest PCI git repository.(next branch)
>>
>> Jaehoon Chung (4):
>>   Documetation: samsung-phy: add the exynos-pcie-phy binding
>>   phy: phy-exynos-pcie: Add support for Exynos PCIe phy
>>   Documetation: binding: modify the exynos5440 pcie binding
>>   PCI: exynos: support the using PHY generic framework
>>
>>  .../bindings/pci/samsung,exynos5440-pcie.txt       |  29 +++
>>  .../devicetree/bindings/phy/samsung-phy.txt        |  17 ++
>>  drivers/pci/host/pci-exynos.c                      |  54 +++-
>>  drivers/phy/Kconfig                                |   8 +
>>  drivers/phy/Makefile                               |   1 +
>>  drivers/phy/phy-exynos-pcie.c                      | 285 +++++++++++++++++++++
>>  6 files changed, 390 insertions(+), 4 deletions(-)
>>  create mode 100644 drivers/phy/phy-exynos-pcie.c
> 
> I made the updates Vivek suggested and provisionally added these to my
> pci/host-exynos branch to get some build testing.

Thanks!

> 
> Kishon, I guess it probably makes more sense for me to apply this
> because even though the drivers/pci changes are small, I think they
> depend on other pci-exynos.c changes that are on my branch but not in
> Linus' tree yet.

I will send the patches relevant to Exynos5433(TM2) soon..
Thanks a lot.

Best Regards,
Jaehoon Chung

> 
> Bjorn
> 
> 
> 
