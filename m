Return-Path: <SRS0=JYfi=M4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DD2C04EBD
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 10:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6685820881
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 10:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6685820881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbeJPSer (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:34:47 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:43234 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726581AbeJPSer (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Oct 2018 14:34:47 -0400
X-UUID: 309a8ec271fa495da4f61707a5ce6737-20181016
X-UUID: 309a8ec271fa495da4f61707a5ce6737-20181016
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2093863655; Tue, 16 Oct 2018 18:44:54 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 16 Oct 2018 18:44:52 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 16 Oct 2018 18:44:51 +0800
From:   <honghui.zhang@mediatek.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ryder.lee@mediatek.com>
CC:     <ulf.hansson@linaro.org>, <marc.zyngier@arm.com>,
        <matthias.bgg@gmail.com>, <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <honghui.zhang@mediatek.com>, <youlin.pei@mediatek.com>,
        <yt.shen@mediatek.com>, <jianjun.wang@mediatek.com>
Subject: [PATCH v9 0/9] PCI: mediatek: fixup find_port, enable_msi and add PM, module support
Date:   Tue, 16 Oct 2018 18:44:41 +0800
Message-ID: <1539686690-24068-1-git-send-email-honghui.zhang@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 056F4A73DB67DE3FF30761804B4E20FF218B66E6966FF4B08E3D16C2E4C0BF012000:8
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

This patchset includes misc patchs:

The patch 1 fixup the mtk_pcie_find_port logic which will cause system
could not touch the EP's configuration space that connected to PCIe slot 1.

The patch fixup the PCI core defect which assign resource base on device's class
type. Logically, the resource assignment should base on PCIe configuration space
layout instead of class type. So this patch using configuration header type for
resource assignment, this patch is suggested by Bjorn.

The patch 6 fixup the enable msi logic, the operation to enable MSI
should be after system clock is enabled. Call mtk_pcie_enable_msi in
mtk_pcie_startup_port_v2 since the clock was all enabled at that time.

The patch 7 was rebased and refactor of the v4 patch[1], changes are:
 -Add PM support for MT7622.
 -Using mtk_pcie_enable_port to re-establish the link when resumed.
 -Rebased on this patchset.

The patch 9 add loadable kernel module support.

[1] https://patchwork.kernel.org/patch/10479079

Change since v8:
 - Remove the patch (PCI: mediatek: Fix class type for MT7622 as PCI_CLASS_BRIDGE_PCI)
 - Add patch 2 (PCI: Using PCI configuration space header type instead of class type
   to assign resource)

Change since v7:
 - Add Acked-by tags from Ryder Lee.
 - Add Fix tags for patch 2(Fix calss type for MT7622 as PCI_CLASS_BRIDGE_PCI)
   and patch 6(Fixup enable MSI logic by enable MSI after clock enabled)

Change since v6:
 - Remove the pci_unmap_iospace when remove the device since the
   devm_pci_remap_iospace is an devm_ version.
 - Commit message changed for patch 2(Fix class type for MT7622 as PCI_CLASS_BRIDGE_PCI).
 - Capitilizing "MSI" and "PM" in the patch title.

Change since v5:
 - A bit improvement of mtk_pcie_find_port suggest by Lorenzo.
   MSI after clock enabled.
 - Add Acked-by tags from Ryder.

Change since v4:
 - Add patch 2 to fixup class type for MT7622.
 - Add patch 3 to remove the redundant dev->pm_domain check
 - Add patch 4 to covert to use pci_host_probe
 - Add patch 5 to re-arrange the function define, this is a prepare patch for
   fixup the enable_msi logic, no functional changed have been made by this one.
 - Add patch 8 to save the GIC IRQ in mtk_pcie_port as a prepare patch for tear
   down the irq when remove the kernel module.
 - Re-arrange the find_port flow suggest by Lorenzo to make the code parse easier
   for the patch 1.
 - Remove the .pm_support in mtk_pcie_soc in patch 7 since if system pm was not
   supported, then those pm callbacks will never be executed for MT7622. So the
   .pm_support is not needed.

Change since v3:
 - Remove pm_runtime_XXX ops in suspend and resume callbacks in the third patch.
 - Rebase to 4.19-rc1.

Change since v2:
 - Fix the list_for_each_entry_safe parameter error.
 - Add Ryder's Acked-by flag.

Change since v1:
 - A bit of code refact of the first patch suggested by Andy Shevchenko, and
   commit message updated.

Honghui Zhang (9):
  PCI: mediatek: Using slot's devfn for compare to fix
    mtk_pcie_find_port logic
  PCI: Using PCI configuration space header type instead of class type
    to assign resource
  PCI: mediatek: Remove the redundant dev->pm_domain check
  PCI: mediatek: Convert to use pci_host_probe()
  PCI: mediatek: Move the mtk_pcie_startup_port_v2 function's define
    after mtk_pcie_setup_irq
  PCI: mediatek: Fixup enable MSI logic by enable MSI after clock
    enabled
  PCI: mediatek: Add system PM support for MT2712 and MT7622
  PCI: mediatek: Save the GIC IRQ in mtk_pcie_port
  PCI: mediatek: Add loadable kernel module support

 drivers/pci/controller/Kconfig         |   2 +-
 drivers/pci/controller/pcie-mediatek.c | 319 +++++++++++++++++++++------------
 drivers/pci/pci.c                      |   3 +-
 drivers/pci/probe.c                    |   3 -
 drivers/pci/setup-bus.c                |  20 +--
 5 files changed, 215 insertions(+), 132 deletions(-)

-- 
2.6.4

