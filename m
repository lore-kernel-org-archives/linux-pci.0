Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:36678 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750841AbeDTFZ2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Apr 2018 01:25:28 -0400
From: <honghui.zhang@mediatek.com>
To: <lorenzo.pieralisi@arm.com>, <marc.zyngier@arm.com>,
        <bhelgaas@google.com>, <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <ryder.lee@mediatek.com>
CC: <honghui.zhang@mediatek.com>, <hongkun.cao@mediatek.com>,
        <youlin.pei@mediatek.com>, <yong.wu@mediatek.com>,
        <yt.shen@mediatek.com>, <sean.wang@mediatek.com>,
        <xinping.qian@mediatek.com>
Subject: [PATCH v6 0/2] PCI: mediatek: Fixups for the IRQ handle routine and MT7622's class code
Date: Fri, 20 Apr 2018 13:25:08 +0800
Message-ID: <1524201910-22836-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Honghui Zhang <honghui.zhang@mediatek.com>

Two fixups for mediatek's host bridge:
The first patch fixup class type and vendor ID for MT7622.
The second patch fixup the IRQ handle routine by using irq_chip solution
to avoid IRQ reentry which may exist for both MT2712 and MT7622.

Change since v5:
 - Make the comments consistend with the code modification in the first patch.
 - Using writew to performing a 16-bit write.
 - Using irq_chip solution to fix the IRQ issue.

The v5 patchset could be found in:
 https://patchwork.kernel.org/patch/10133303
 https://patchwork.kernel.org/patch/10133305

Change since v4:
 - Only setup vendor ID for MT7622, igorning the device ID since mediatek's
   host bridge driver does not cares about the device ID.

Change since v3:
 - Setup the class type and vendor ID at the beginning of startup instead
   of in a quirk.
 - Add mediatek's vendor ID, it could be found in:
   https://pcisig.com/membership/member-companies?combine=&page=4

Change since v2:
 - Move the initialize of the iterate before the loop to fix an
   INTx IRQ issue in the first patch

Change since v1:
 - Add the second patch.
 - Make the first patch's commit message more standard.
Honghui Zhang (2):
  PCI: mediatek: Set up vendor ID and class type for MT7622
  PCI: mediatek: Using chained IRQ to setup IRQ handle

 drivers/pci/host/pcie-mediatek.c | 220 +++++++++++++++++++++++----------------
 include/linux/pci_ids.h          |   2 +
 2 files changed, 133 insertions(+), 89 deletions(-)

-- 
2.6.4
