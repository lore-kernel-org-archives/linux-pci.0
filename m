Return-Path: <SRS0=2l4j=6X=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8222EC28CBC
	for <linux-pci@archiver.kernel.org>; Sat,  9 May 2020 09:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B9B6217BA
	for <linux-pci@archiver.kernel.org>; Sat,  9 May 2020 09:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgEIJ5Q (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 9 May 2020 05:57:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43238 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726946AbgEIJ5P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 9 May 2020 05:57:15 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 70041F27B3D85A7FDEA2;
        Sat,  9 May 2020 17:57:13 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Sat, 9 May 2020 17:57:04 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <linuxarm@huawei.com>, <yangyicong@hisilicon.com>
Subject: [PATCH] PCI/DPC: print IRQ number used by DPC port
Date:   Sat, 9 May 2020 17:56:54 +0800
Message-ID: <1589018214-52752-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add print of IRQ number used by DPC port, like AER/PME does. It
provides convenience to track DPC interrupts counts of certain
port from /proc/interrupts.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/pci/pcie/dpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 7621704..ae6b553 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -301,6 +301,7 @@ static int dpc_probe(struct pcie_device *dev)

 	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
 	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
+	pci_info(pdev, "enabled with IRQ %d\n", dev->irq);

 	pci_info(pdev, "error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
 		 cap & PCI_EXP_DPC_IRQ, FLAG(cap, PCI_EXP_DPC_CAP_RP_EXT),
--
2.8.1

