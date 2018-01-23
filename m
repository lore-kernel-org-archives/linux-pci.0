Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42265 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbeAWPp4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jan 2018 10:45:56 -0500
Received: by mail-pg0-f67.google.com with SMTP id q67so538060pga.9
        for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2018 07:45:56 -0800 (PST)
From: Shawn Guo <shawn.guo@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        project-aspen-dev@linaro.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 0/2] Add power control for pcie-histb driver
Date: Tue, 23 Jan 2018 23:45:35 +0800
Message-Id: <1516722337-1533-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The first patch is a small fix which is useful for the second one.
This version basically follows Fabio's suggestion to reimplement the
first version patch, using a regulator that can be backed by GPIO to
control the power to PCIe port.

Shawn Guo (2):
  PCI: histb: fix error path of histb_pcie_host_enable()
  PCI: histb: add an optional regulator for PCIe port power control

 .../bindings/pci/hisilicon-histb-pcie.txt          |  1 +
 drivers/pci/dwc/pcie-histb.c                       | 28 ++++++++++++++++++----
 2 files changed, 25 insertions(+), 4 deletions(-)

-- 
1.9.1
