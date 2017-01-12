Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750730AbdALVBa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Jan 2017 16:01:30 -0500
Date: Thu, 12 Jan 2017 15:01:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        kgene@kernel.org, krzk@kernel.org, kishon@ti.com,
        jingoohan1@gmail.com, vivek.gautam@codeaurora.org,
        pankaj.dubey@samsung.com, alim.akhtar@samsung.com, cpgs@samsung.com
Subject: Re: [PATCH V2 0/5] PCI: exynos: use the PHY generic framework
Message-ID: <20170112210126.GD8312@bhelgaas-glaptop.roam.corp.google.com>
References: <CGME20170104123435epcas1p182b241236048160fb81ac473a74540da@epcas1p1.samsung.com>
 <20170104123435.30740-1-jh80.chung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170104123435.30740-1-jh80.chung@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 04, 2017 at 09:34:30PM +0900, Jaehoon Chung wrote:
> This patchset is for using PHY generic framework.
> Current pci-exyons doesn't use the phy framework since there haven't been on
> PHY subsystem when Exynos5440 had been upstremed.
> The not using PHY framework make the difficult to upstream the other
> Exynos SoCs.
> 
> Before upstreaming the other Exynos SoCs, it's goal what make to use the PHY framework.
> 
> This patchset has the below modifications:
> 1) Introduces the phy-pcie-pcie
> 2) Handles Phy controller from PHY framework for pci-exynos
> 3) Modifies the dt-binding of pci-exynos
> - The using the getting configuration space address from ranges is old.
> - Deprecated the old way.
> 4) Maintains the backward compatibility
> 
> NOTE: These patches based on below patches:
> 	http://patchwork.ozlabs.org/patch/706998/
> 	http://patchwork.ozlabs.org/patch/706997/
> 	http://patchwork.ozlabs.org/patch/706995/
> 	http://patchwork.ozlabs.org/patch/706994/
> 	http://patchwork.ozlabs.org/patch/703530/
> 	- This patch should be conflicted. so fixes the manually.
> 	http://patchwork.ozlabs.org/patch/708414/
> 
> Changelog on V2:
> - Keep current codes for backward compatibility
> - Fixes some typos
> - Split the patches for removing the dependency
> - Removes the unnecessary codes
> - Change the patch's sequence
> - Based on latest PCI git repository.(next branch)
> 
> Jaehoon Chung (5):
>   Documetation: samsung-phy: add the exynos-pcie-phy binding
>   phy: phy-exynos-pcie: Add support for Exynos PCIe phy
>   Documetation: binding: modify the exynos5440 pcie binding
>   PCI: exynos: support the using PHY generic framework
>   ARM: dts: exynos5440: support the phy-pcie node for pcie

Since you're going to update this, please fix the typos in the above,
e.g., s/Documetation/Documentation/.

In addition, please run "git log --oneline" on the files you're
changing and make your subject lines consistent in style and
capitalization with previous ones, e.g., use "PCIe" consistently.
"Modify the ..." contains no useful information.  Of course a patch
modifies something -- please tell us what the modification is useful
for.

>  .../bindings/pci/samsung,exynos5440-pcie.txt       |  29 +++
>  .../devicetree/bindings/phy/samsung-phy.txt        |  17 ++
>  arch/arm/boot/dts/exynos5440.dtsi                  |  34 ++-
>  drivers/pci/host/pci-exynos.c                      |  61 ++++-
>  drivers/phy/Kconfig                                |   9 +
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/phy-exynos-pcie.c                      | 280 +++++++++++++++++++++
>  7 files changed, 408 insertions(+), 23 deletions(-)
>  create mode 100644 drivers/phy/phy-exynos-pcie.c
> 
> -- 
> 2.10.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
