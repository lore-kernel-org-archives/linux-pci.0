Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:39448 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752181AbeGADzH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 Jun 2018 23:55:07 -0400
Received: by mail-pg0-f66.google.com with SMTP id n2-v6so5648245pgq.6
        for <linux-pci@vger.kernel.org>; Sat, 30 Jun 2018 20:55:06 -0700 (PDT)
From: Shawn Guo <shawn.guo@linaro.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 0/9] PCI: dwc: Drop unnecessary root_bus_nr setting
Date: Sun,  1 Jul 2018 11:54:42 +0800
Message-Id: <1530417291-30495-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The designware core function dw_pcie_host_init() already initializes
the root_bus_nr field of 'struct pcie_port', so the -1 assignment prior
to calling dw_pcie_host_init() in platform specific driver is not really
needed.  Drop it.

Changes for v3:
 - Rebase to v4.18-rc1
 - Collect ACK from Pratyush on spear13xx driver

Changes for v2:
 - Improve commit log a bit per Thomas' suggestion.
 - Collect ACK from Thomas and Stanimir on armada8k and qcom driver.


Shawn Guo (9):
  PCI: exynos: Drop unnecessary root_bus_nr setting
  PCI: imx6: Drop unnecessary root_bus_nr setting
  PCI: keystone: Drop unnecessary root_bus_nr setting
  PCI: armada8k: Drop unnecessary root_bus_nr setting
  PCI: artpec6: Drop unnecessary root_bus_nr setting
  PCI: designware-plat: Drop unnecessary root_bus_nr setting
  PCI: histb: Drop unnecessary root_bus_nr setting
  PCI: qcom: Drop unnecessary root_bus_nr setting
  PCI: spear13xx: Drop unnecessary root_bus_nr setting

 drivers/pci/controller/dwc/pci-exynos.c           | 1 -
 drivers/pci/controller/dwc/pci-imx6.c             | 1 -
 drivers/pci/controller/dwc/pci-keystone.c         | 1 -
 drivers/pci/controller/dwc/pcie-armada8k.c        | 1 -
 drivers/pci/controller/dwc/pcie-artpec6.c         | 1 -
 drivers/pci/controller/dwc/pcie-designware-plat.c | 1 -
 drivers/pci/controller/dwc/pcie-histb.c           | 1 -
 drivers/pci/controller/dwc/pcie-qcom.c            | 1 -
 drivers/pci/controller/dwc/pcie-spear13xx.c       | 1 -
 9 files changed, 9 deletions(-)

-- 
1.9.1
