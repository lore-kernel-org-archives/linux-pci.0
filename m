Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756926AbdAKVKX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Jan 2017 16:10:23 -0500
Date: Wed, 11 Jan 2017 15:10:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: Fix typo in MAINTAINERS file
Message-ID: <20170111211018.GL14532@bhelgaas-glaptop.roam.corp.google.com>
References: <80fa36488fb77bda9822a3f8583fb08ff66b428c.1482940922.git.jpinto@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <80fa36488fb77bda9822a3f8583fb08ff66b428c.1482940922.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Joao,

On Wed, Dec 28, 2016 at 04:05:11PM +0000, Joao Pinto wrote:
> This patch fixes a typo in MAINTAINERS file.
> 
> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cfff2c9..1056392 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9512,7 +9512,7 @@ L:	linux-samsung-soc@vger.kernel.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	drivers/pci/host/pci-exynos.c
>  
> -PCI DRIVER FOR SYNOPSIS DESIGNWARE
> +PCI DRIVER FOR SYNOPSYS DESIGNWARE

"git grep -i synopsis" finds several other occurrences in the tree.

Most of them are the English word "synopsis", and those are correct.
But several look like similar typos for the "Synopsys" company name:

  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt:This PCIe host controller is based on the Synopsis Designware PCIe IP
  Documentation/devicetree/bindings/pci/pci-armada8k.txt:This PCIe host controller is based on the Synopsis Designware PCIe IP
  Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt:This PCIe host controller is based on the Synopsis Designware PCIe IP
  Documentation/devicetree/bindings/pci/spear13xx-pcie.txt:SPEAr13XX uses synopsis designware PCIe controller and ST MiPHY as phy
  Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt:DWC3 PHY nodes are defined to describe on-chip Synopsis Physical layer
  Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt:    - "qcom,dwc3-hs-usb-phy" for High Speed Synopsis PHY controller
  Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt:    - "qcom,dwc3-ss-usb-phy" for Super Speed Synopsis PHY controller
  arch/x86/include/asm/apb_timer.h: * apb_timer.h: Driver for Langwell APB timer based on Synopsis DesignWare
  drivers/gpu/drm/bridge/Kconfig: tristate "Synopsis Designware AHB Audio interface"
  drivers/gpu/drm/bridge/Kconfig:   Support the AHB Audio interface which is part of the Synopsis
  drivers/gpu/drm/bridge/Kconfig: tristate "Synopsis Designware I2S Audio interface"
  drivers/gpu/drm/bridge/Kconfig:   Support the I2S Audio interface which is part of the Synopsis
  drivers/gpu/drm/bridge/dw-hdmi-ahb-audio.c:MODULE_DESCRIPTION("Synopsis Designware HDMI AHB ALSA interface");
  drivers/gpu/drm/bridge/dw-hdmi-i2s-audio.c:MODULE_DESCRIPTION("Synopsis Designware HDMI I2S ALSA SoC interface");
  drivers/usb/phy/phy-msm-usb.c: * SNPS_28NM_INTEGRATED_PHY       Synopsis 28nm integrated PHY

Can you take a look at those and fix any others that are typos at the
same time?

>  M:	Jingoo Han <jingoohan1@gmail.com>
>  M:	Joao Pinto <Joao.Pinto@synopsys.com>
>  L:	linux-pci@vger.kernel.org
> -- 
> 2.9.3
> 
