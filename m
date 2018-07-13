Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35010 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729628AbeGMNdF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Jul 2018 09:33:05 -0400
Date: Fri, 13 Jul 2018 14:20:23 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 0/9] PCI: dwc: Drop unnecessary root_bus_nr setting
Message-ID: <20180713132023.GC18515@red-moon>
References: <1530417291-30495-1-git-send-email-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1530417291-30495-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jul 01, 2018 at 11:54:42AM +0800, Shawn Guo wrote:
> The designware core function dw_pcie_host_init() already initializes
> the root_bus_nr field of 'struct pcie_port', so the -1 assignment prior
> to calling dw_pcie_host_init() in platform specific driver is not really
> needed.  Drop it.
> 
> Changes for v3:
>  - Rebase to v4.18-rc1
>  - Collect ACK from Pratyush on spear13xx driver
> 
> Changes for v2:
>  - Improve commit log a bit per Thomas' suggestion.
>  - Collect ACK from Thomas and Stanimir on armada8k and qcom driver.
> 
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
>  drivers/pci/controller/dwc/pci-exynos.c           | 1 -
>  drivers/pci/controller/dwc/pci-imx6.c             | 1 -
>  drivers/pci/controller/dwc/pci-keystone.c         | 1 -
>  drivers/pci/controller/dwc/pcie-armada8k.c        | 1 -
>  drivers/pci/controller/dwc/pcie-artpec6.c         | 1 -
>  drivers/pci/controller/dwc/pcie-designware-plat.c | 1 -
>  drivers/pci/controller/dwc/pcie-histb.c           | 1 -
>  drivers/pci/controller/dwc/pcie-qcom.c            | 1 -
>  drivers/pci/controller/dwc/pcie-spear13xx.c       | 1 -
>  9 files changed, 9 deletions(-)

Applied to pci/dwc for v4.19, thanks.

Lorenzo
