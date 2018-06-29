Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34926 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754825AbeF2OOj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Jun 2018 10:14:39 -0400
Date: Fri, 29 Jun 2018 15:16:26 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/9] PCI: dwc: Drop unnecessary root_bus_nr setting
Message-ID: <20180629141626.GH9643@red-moon>
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

Hi Shawn,

would you mind please rebasing it against v4.18-rc1 and resend with
CC all the controllers maintainers so that we can get ACKs and send it
for v4.19 ?

Thanks a lot for doing this.

Lorenzo

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
> 
> -- 
> 1.9.1
> 
