Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33266 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754522AbcL3P4Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Dec 2016 10:56:24 -0500
Date: Fri, 30 Dec 2016 17:56:13 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        kgene@kernel.org, krzk@kernel.org, kishon@ti.com,
        jingoohan1@gmail.com, vivek.gautam@codeaurora.org,
        pankaj.dubey@samsung.com, alim.akhtar@samsung.com, cpgs@samsung.com
Subject: Re: [PATCH 0/4] PCI: exynos: use the PHY generic framework
Message-ID: <20161230155613.jpwzytnh4osz76c6@kozik-lap>
References: <CGME20161228103455epcas1p1c762bc59add0011beff1d4ff697b5c8d@epcas1p1.samsung.com>
 <20161228103454.26467-1-jh80.chung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20161228103454.26467-1-jh80.chung@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 28, 2016 at 07:34:50PM +0900, Jaehoon Chung wrote:
> This patch is for using PHY generic framework.
> When Exynos5440 had upstreamed, there was no PHY subsytem.
> Now the using PHY framework is mandantory.
> In future, Exynos variant should be supported in pci-exynos.c
> 
> Theses pathces based on the below patches
>

Aren't you breaking DTB ABI here? If yes, then I don't mind but please
put it in the commit message.  Also order the patches in a way
preserving bisectability.

Best regards,
Krzysztof

> - Jaehoon's patches
> http://patchwork.ozlabs.org/patch/706998/
> http://patchwork.ozlabs.org/patch/706997/
> http://patchwork.ozlabs.org/patch/706995/
> http://patchwork.ozlabs.org/patch/706994/
> 
> - Srinivas's patch
> http://patchwork.ozlabs.org/patch/703530/
> 
> - Pankaj's patch
> http://patchwork.ozlabs.org/patch/708414/
> 
> Jaehoon Chung (4):
>   phy: exynos-pcie: Add support for Exynos PCIe phy
>   Documetation: samsung-phy: add the exynos-pcie-phy binding
>   Documetation: binding: modify the exynos5440 pcie binding
>   ARM: dts: exynos5440: support the phy-pcie node for pcie
> 
>  .../bindings/pci/samsung,exynos5440-pcie.txt       |  29 ++-
>  .../devicetree/bindings/phy/samsung-phy.txt        |  23 ++
>  arch/arm/boot/dts/exynos5440.dtsi                  |  44 +++-
>  drivers/pci/host/pci-exynos.c                      | 198 ++------------
>  drivers/phy/Kconfig                                |   9 +
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/phy-exynos-pcie.c                      | 289 +++++++++++++++++++++
>  7 files changed, 395 insertions(+), 198 deletions(-)
>  create mode 100644 drivers/phy/phy-exynos-pcie.c
> 
> -- 
> 2.10.2
> 
