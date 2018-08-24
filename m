Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sh2.amlogic.com ([58.32.228.45]:27897 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbeHXLGO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Aug 2018 07:06:14 -0400
From: Hanjie Lin <hanjie.lin@amlogic.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
CC: Hanjie Lin <hanjie.lin@amlogic.com>,
        <linux-amlogic@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 0/2] add the Amlogic Meson PCIe phy driver
Date: Fri, 24 Aug 2018 15:33:24 +0800
Message-ID: <1535096006-152091-1-git-send-email-hanjie.lin@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patcheset add the driver and dt-bindings for
the Meson-PCIE-PHY controller.

Changes since v1: [0]
 - move 'apb' and 'port' reset to ctrl driver
 - format correcting

[0] : https://lkml.org/lkml/2018/8/14/66 

Yue Wang (2):
  dt-bindings: phy: add DT bindings for Amlogic Meson PCIe Phy
    controller
  PCI: meson: add the Amlogic Meson PCIe phy driver

 .../bindings/phy/amlogic,meson-pcie-phy.txt        |  21 ++++
 drivers/phy/amlogic/Kconfig                        |   8 ++
 drivers/phy/amlogic/Makefile                       |   1 +
 drivers/phy/amlogic/phy-meson-axg-pcie.c           | 124 +++++++++++++++++++++
 4 files changed, 154 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-pcie-phy.txt
 create mode 100644 drivers/phy/amlogic/phy-meson-axg-pcie.c

-- 
2.7.4
