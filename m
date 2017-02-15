Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 15 Feb 2017 15:04:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, krzk@kernel.org,
        linux-kernel@vger.kernel.org, jingoohan1@gmail.com,
        javier@osg.samsung.com, kgene@kernel.org,
        linux-samsung-soc@vger.kernel.org, cpgs@samsung.com,
        niyas.ahmed@samsung.com, alim.akhtar@samsung.com,
        pankaj.dubey@samsung.com, kishon@ti.com,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        vivek.gautam@codeaurora.org, robh+dt@kernel.org
Subject: Re: [PATCH V3 0/4] PCI: exynos: use the PHY generic framework
Message-ID: <20170215210403.GB6981@bhelgaas-glaptop.roam.corp.google.com>
References: <CGME20170213082615epcas5p2f5ecabbd5853a8e27da5f88fcae85158@epcas5p2.samsung.com>
 <20170213082613.19628-1-jh80.chung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170213082613.19628-1-jh80.chung@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 13, 2017 at 05:26:09PM +0900, Jaehoon Chung wrote:
> This patcheset is for using PHY generic framework.
> Current pci-exyns doesn't use the phy framework since there haven't been on
> PHY subsystem when Exynos5440 had bean upstreamed.
> It's making a difficult to upstream the other Exynos variants because of different
> PHY registers.
> 
> This patcheset has the below modifications:
> 1) Introduces the phy-exynos-pcie
> 2) Handles PHY register from PHY framework for pci-exynos
> 3) Modifies the dt-binding of pci-exynos
> 4) Maintains the backward compatibility
> 
> Changelog on V3:
> - Drops "ARM: dts: exynos5440: support the phy-pcie node of pcie"
>   : Will send this patch after applying this patchset.
> - Fixes typo
> - Based on latest PCI git repository (host-exynos branch)
> - Changes commit message
> - Removes the dependency
> 
> Changelog on V2:
> - Keep current codes for backward compatibility
> - Fixes some typos
> - Split the patches for removing the dependency
> - Removes the unnecessary codes
> - Change the patch's sequence
> - Based on latest PCI git repository.(next branch)
> 
> Jaehoon Chung (4):
>   Documetation: samsung-phy: add the exynos-pcie-phy binding
>   phy: phy-exynos-pcie: Add support for Exynos PCIe phy
>   Documetation: binding: modify the exynos5440 pcie binding
>   PCI: exynos: support the using PHY generic framework
> 
>  .../bindings/pci/samsung,exynos5440-pcie.txt       |  29 +++
>  .../devicetree/bindings/phy/samsung-phy.txt        |  17 ++
>  drivers/pci/host/pci-exynos.c                      |  54 +++-
>  drivers/phy/Kconfig                                |   8 +
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/phy-exynos-pcie.c                      | 285 +++++++++++++++++++++
>  6 files changed, 390 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/phy/phy-exynos-pcie.c

Kishon, how do you want to handle this series?  The bulk of the
changes are in drivers/phy.  I acked the drivers/pci patch, so you can
add that and apply the whole series if you want.  Otherwise, if you
ack the PHY part, I can apply the whole thing.  Either is fine with
me; just let me know.
