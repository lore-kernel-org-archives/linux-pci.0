Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41295 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163289AbeCBBMd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Mar 2018 20:12:33 -0500
Received: by mail-pg0-f66.google.com with SMTP id q27so3076777pgn.8
        for <linux-pci@vger.kernel.org>; Thu, 01 Mar 2018 17:12:32 -0800 (PST)
From: Shawn Guo <shawn.guo@linaro.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 0/2] Add power control for pcie-histb driver
Date: Fri,  2 Mar 2018 09:11:59 +0800
Message-Id: <1519953121-28218-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It adds power control support for pcie-histb driver, by utilizing
regulator infrastructural.

Changes for v3:
 - Incorporate Rob's ACK on bindings doc.
 - Capitalize  the first word of patch subject to match drivers/pci
   convention.
 - Reword vpcie-supply description a bit as per Bjorn's suggestion.

Shawn Guo (2):
  PCI: histb: Fix error path of histb_pcie_host_enable()
  PCI: histb: Add an optional regulator for PCIe port power control

 .../bindings/pci/hisilicon-histb-pcie.txt          |  1 +
 drivers/pci/dwc/pcie-histb.c                       | 28 ++++++++++++++++++----
 2 files changed, 25 insertions(+), 4 deletions(-)

-- 
1.9.1
