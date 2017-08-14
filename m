Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:53482 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753252AbdHNNEo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2017 09:04:44 -0400
From: <honghui.zhang@mediatek.com>
To: <bhelgaas@google.com>, <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <ryder.lee@mediatek.com>
CC: <honghui.zhang@mediatek.com>, <hongkun.cao@mediatek.com>,
        <youlin.pei@mediatek.com>, <yong.wu@mediatek.com>,
        <yt.shen@mediatek.com>, <sean.wang@mediatek.com>,
        <xinping.qian@mediatek.com>
Subject: [PATCH v2 0/3] PCI: mediatek: Add MSI support for MT2712 and MT7622
Date: Mon, 14 Aug 2017 21:04:25 +0800
Message-ID: <1502715868-17651-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Honghui Zhang <honghui.zhang@mediatek.com>

MT2712 and MT7622's PCIe host controller support MSI, but only 32bit MSI
address are supportted. It connect to GIC with the same IRQ number of INTx
IRQ, so it shares the same IRQ with INTx IRQ.

This patchset add MSI support for MT2712 and MT7622.
Also do some code fixup and cleanups.

Change Since V1:
 - Add the first two patches into this patchset.
 - Using -ENODEV instead of PTR_ERR if msi_domain == NULL
 - Change the error logs with consistency of lower-case
 - Using has_msi instead of support_msi to make the parameter name a bit shorter

Honghui Zhang (3):
  PCI: mediatek: Fix return value in case of error
  PCI: mediatek: take use of bus->sysdata to get host private data
  PCI: mediatek: add msi support for MT2712 and MT7622

 drivers/pci/host/pcie-mediatek.c | 157 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 151 insertions(+), 6 deletions(-)

-- 
2.6.4
