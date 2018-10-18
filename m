Return-Path: <SRS0=PAID=M6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9C8ECDE44
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 15:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2728621473
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 15:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2728621473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbeJRXi5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Oct 2018 19:38:57 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37048 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727598AbeJRXi5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Oct 2018 19:38:57 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6C0072072C; Thu, 18 Oct 2018 17:37:22 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-25-52.w90-88.abo.wanadoo.fr [90.88.145.52])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3F95B20618;
        Thu, 18 Oct 2018 17:37:22 +0200 (CEST)
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Russell King <linux@arm.linux.org.uk>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 2/4] PCI: mvebu: Drop unused PCI express capability code
Date:   Thu, 18 Oct 2018 17:37:17 +0200
Message-Id: <20181018153719.23115-3-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181018153719.23115-1-thomas.petazzoni@bootlin.com>
References: <20181018153719.23115-1-thomas.petazzoni@bootlin.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit dc0352ab0b2a0 ("PCI: mvebu: Add PCI Express root complex
capability block") added support for emulating the PCI Express
capability block. As part of this, the pcie_sltcap, pcie_devctl and
pcie_rtctl fields were added to the mvebu_sw_pci_bridge structure, and
used when reading the corresponding PCI Express capability block
registers.

However, those structure members are never set to any value other than
zero. This makes them unneeded because:

 - pcie_devctl is used to OR *value, so with pcie_devctl always zero,
   it has no effect.

 - for pcie_sltcap and pcie_rtstl, the mvebu_sw_pci_bridge_read()
   function always returns 0 for registers that are not explicitly
   handled.

In preparation for reworking the PCI bridge emulation logic in
pci-mvebu, let's simplify the code by dropping those structure
members.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/pci/controller/pci-mvebu.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 50eb0729385b..beaff9325a09 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -111,11 +111,6 @@ struct mvebu_sw_pci_bridge {
 	u8 intline;
 	u8 intpin;
 	u16 bridgectrl;
-
-	/* PCI express capability */
-	u32 pcie_sltcap;
-	u16 pcie_devctl;
-	u16 pcie_rtctl;
 };
 
 struct mvebu_pcie_port;
@@ -588,7 +583,6 @@ static int mvebu_sw_pci_bridge_read(struct mvebu_pcie_port *port,
 		*value = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_DEVCTL) &
 				 ~(PCI_EXP_DEVCTL_URRE | PCI_EXP_DEVCTL_FERE |
 				   PCI_EXP_DEVCTL_NFERE | PCI_EXP_DEVCTL_CERE);
-		*value |= bridge->pcie_devctl;
 		break;
 
 	case PCISWCAP_EXP_LNKCAP:
@@ -604,18 +598,10 @@ static int mvebu_sw_pci_bridge_read(struct mvebu_pcie_port *port,
 		*value = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL);
 		break;
 
-	case PCISWCAP_EXP_SLTCAP:
-		*value = bridge->pcie_sltcap;
-		break;
-
 	case PCISWCAP_EXP_SLTCTL:
 		*value = PCI_EXP_SLTSTA_PDS << 16;
 		break;
 
-	case PCISWCAP_EXP_RTCTL:
-		*value = bridge->pcie_rtctl;
-		break;
-
 	case PCISWCAP_EXP_RTSTA:
 		*value = mvebu_readl(port, PCIE_RC_RTSTA);
 		break;
-- 
2.14.4

