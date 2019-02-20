Return-Path: <SRS0=6A7A=Q3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F6DC10F01
	for <linux-pci@archiver.kernel.org>; Wed, 20 Feb 2019 10:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C5E21903
	for <linux-pci@archiver.kernel.org>; Wed, 20 Feb 2019 10:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfBTKAs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:00:48 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:36166 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfBTKAs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Feb 2019 05:00:48 -0500
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 1D7D83A71DA
        for <linux-pci@vger.kernel.org>; Wed, 20 Feb 2019 09:48:56 +0000 (UTC)
Received: from localhost (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 77F8B200012;
        Wed, 20 Feb 2019 09:48:53 +0000 (UTC)
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org
Cc:     Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        =?UTF-8?q?Lu=C3=ADs=20Mendes?= <luis.p.mendes@gmail.com>,
        Leigh Brown <leigh@solinno.co.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 2/2] PCI: pci-bridge-emul: Extend pci_bridge_emul_init() with flags
Date:   Wed, 20 Feb 2019 10:48:41 +0100
Message-Id: <20190220094841.11129-3-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220094841.11129-1-thomas.petazzoni@bootlin.com>
References: <20190220094841.11129-1-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Depending on the capabilities of the PCI controller/platform, the
PCI-to-PCI bridge emulation behavior might need to be different. For
example, on platforms that use the pci-mvebu code, we currently don't
support prefetchable memory BARs, so the corresponding fields in the
PCI-to-PCI bridge configuration space should be read-only.

To implement this, this commit extends pci_bridge_emul_init() to take
a "flags" argument, with currently one flag supported:
PCI_BRIDGE_EMUL_NO_PREFETCHABLE_BAR, that will make the prefetchable
memory base and limit registers read-only.

The pci-mvebu and pci-aardvark drivers are updated accordingly.

Reported-by: Luís Mendes <luis.p.mendes@gmail.com>
Reported-by: Leigh Brown <leigh@solinno.co.uk>
Cc: Luís Mendes <luis.p.mendes@gmail.com>
Cc: Leigh Brown <leigh@solinno.co.uk>
Fixes: 1f08673eef123 ("PCI: mvebu: Convert to PCI emulated bridge config space")
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/pci/controller/pci-aardvark.c | 2 +-
 drivers/pci/controller/pci-mvebu.c    | 2 +-
 drivers/pci/pci-bridge-emul.c         | 8 +++++++-
 drivers/pci/pci-bridge-emul.h         | 7 ++++++-
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 750081c1cb48..6eecae447af3 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -499,7 +499,7 @@ static void advk_sw_pci_bridge_init(struct advk_pcie *pcie)
 	bridge->data = pcie;
 	bridge->ops = &advk_pci_bridge_emul_ops;
 
-	pci_bridge_emul_init(bridge);
+	pci_bridge_emul_init(bridge, 0);
 
 }
 
diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index fa0fc46edb0c..d3a0419e42f2 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -583,7 +583,7 @@ static void mvebu_pci_bridge_emul_init(struct mvebu_pcie_port *port)
 	bridge->data = port;
 	bridge->ops = &mvebu_pci_bridge_emul_ops;
 
-	pci_bridge_emul_init(bridge);
+	pci_bridge_emul_init(bridge, PCI_BRIDGE_EMUL_NO_PREFETCHABLE_BAR);
 }
 
 static inline struct mvebu_pcie *sys_to_pcie(struct pci_sys_data *sys)
diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index dd8d8060317e..83fb077d0b41 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -267,7 +267,8 @@ const static struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
  * (typically at least vendor, device, revision), the ->ops pointer,
  * and optionally ->data and ->has_pcie.
  */
-int pci_bridge_emul_init(struct pci_bridge_emul *bridge)
+int pci_bridge_emul_init(struct pci_bridge_emul *bridge,
+			 unsigned int flags)
 {
 	bridge->conf.class_revision |= PCI_CLASS_BRIDGE_PCI << 16;
 	bridge->conf.header_type = PCI_HEADER_TYPE_BRIDGE;
@@ -295,6 +296,11 @@ int pci_bridge_emul_init(struct pci_bridge_emul *bridge)
 		}
 	}
 
+	if (flags & PCI_BRIDGE_EMUL_NO_PREFETCHABLE_BAR) {
+		bridge->pci_regs_behavior[PCI_PREF_MEMORY_BASE / 4].ro = ~0;
+		bridge->pci_regs_behavior[PCI_PREF_MEMORY_BASE / 4].rw = 0;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/pci/pci-bridge-emul.h b/drivers/pci/pci-bridge-emul.h
index f04637bb3222..e65b1b79899d 100644
--- a/drivers/pci/pci-bridge-emul.h
+++ b/drivers/pci/pci-bridge-emul.h
@@ -119,7 +119,12 @@ struct pci_bridge_emul {
 	bool has_pcie;
 };
 
-int pci_bridge_emul_init(struct pci_bridge_emul *bridge);
+enum {
+	PCI_BRIDGE_EMUL_NO_PREFETCHABLE_BAR = BIT(0),
+};
+
+int pci_bridge_emul_init(struct pci_bridge_emul *bridge,
+			 unsigned int flags);
 void pci_bridge_emul_cleanup(struct pci_bridge_emul *bridge);
 
 int pci_bridge_emul_conf_read(struct pci_bridge_emul *bridge, int where,
-- 
2.20.1

