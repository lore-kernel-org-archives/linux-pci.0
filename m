Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52534 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932221AbeEWKQr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 May 2018 06:16:47 -0400
Date: Wed, 23 May 2018 11:16:41 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/9] PCI: dwc: Drop unnecessary root_bus_nr setting
Message-ID: <20180523101641.GA3048@e107981-ln.cambridge.arm.com>
References: <1525998019-28634-1-git-send-email-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1525998019-28634-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 11, 2018 at 08:20:10AM +0800, Shawn Guo wrote:
> The designware core function dw_pcie_host_init() already initializes
> the root_bus_nr field of 'struct pcie_port', so the -1 assignment prior
> to calling dw_pcie_host_init() in platform specific driver is not really
> needed.  Drop it.
> 
> Changes for v2:
>  - Improve commit log a bit per Thomas' suggestion.
>  - Collect ACK from Thomas and Stanimir on armada8k and qcom driver.
> 
> Shawn Guo (9):
>   PCI: exynos: Drop unnecessary root_bus_nr setting
>   PCI: imx6: Drop unnecessary root_bus_nr setting
>   PCI: keystone: Drop unnecessary root_bus_nr setting
>   PCI: armada8k: Drop unnecessary root_bus_nr setting
>   PCI: artpec6: Drop unnecessary root_bus_nr setting
>   PCI: designware-plat: Drop unnecessary root_bus_nr setting
>   PCI: histb: Drop unnecessary root_bus_nr setting
>   PCI: qcom: Drop unnecessary root_bus_nr setting
>   PCI: spear13xx: Drop unnecessary root_bus_nr setting
> 
>  drivers/pci/dwc/pci-exynos.c           | 1 -
>  drivers/pci/dwc/pci-imx6.c             | 1 -
>  drivers/pci/dwc/pci-keystone.c         | 1 -
>  drivers/pci/dwc/pcie-armada8k.c        | 1 -
>  drivers/pci/dwc/pcie-artpec6.c         | 1 -
>  drivers/pci/dwc/pcie-designware-plat.c | 1 -
>  drivers/pci/dwc/pcie-histb.c           | 1 -
>  drivers/pci/dwc/pcie-qcom.c            | 1 -
>  drivers/pci/dwc/pcie-spear13xx.c       | 1 -
>  9 files changed, 9 deletions(-)

I need ACKs from respective maintainers to merge this series.

Thanks,
Lorenzo
