Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41561 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750798AbeEKAUy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 May 2018 20:20:54 -0400
Received: by mail-pf0-f194.google.com with SMTP id v63-v6so1839665pfk.8
        for <linux-pci@vger.kernel.org>; Thu, 10 May 2018 17:20:54 -0700 (PDT)
From: Shawn Guo <shawn.guo@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 0/9] PCI: dwc: Drop unnecessary root_bus_nr setting
Date: Fri, 11 May 2018 08:20:10 +0800
Message-Id: <1525998019-28634-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The designware core function dw_pcie_host_init() already initializes
the root_bus_nr field of 'struct pcie_port', so the -1 assignment prior
to calling dw_pcie_host_init() in platform specific driver is not really
needed.  Drop it.

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

 drivers/pci/dwc/pci-exynos.c           | 1 -
 drivers/pci/dwc/pci-imx6.c             | 1 -
 drivers/pci/dwc/pci-keystone.c         | 1 -
 drivers/pci/dwc/pcie-armada8k.c        | 1 -
 drivers/pci/dwc/pcie-artpec6.c         | 1 -
 drivers/pci/dwc/pcie-designware-plat.c | 1 -
 drivers/pci/dwc/pcie-histb.c           | 1 -
 drivers/pci/dwc/pcie-qcom.c            | 1 -
 drivers/pci/dwc/pcie-spear13xx.c       | 1 -
 9 files changed, 9 deletions(-)

-- 
1.9.1
