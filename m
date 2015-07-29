Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:59619 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbbG2Ixy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jul 2015 04:53:54 -0400
Received: from /spool/local
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Wed, 29 Jul 2015 18:53:52 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 035D2357804F
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2015 18:53:50 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t6T8rfUZ26345702
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2015 18:53:49 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t6T8rHnw017451
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2015 18:53:17 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH v2] PCI: Don't update VF's BAR
Date: Wed, 29 Jul 2015 16:52:58 +0800
Message-Id: <1438159978-32285-1-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <20150714221511.GM24416@google.com>
References: <20150714221511.GM24416@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

VF BARs are RO zero, so updating VF BARs will not take any effect.
See the SR-IOV spec r1.1, sec 3.4.1.11.

Also this patch adds a warning in pci_update_resource() in case someone
really tries to update it.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/pci.c       |    7 +++++++
 drivers/pci/setup-res.c |    5 +++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0008c95..93c0d24 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -483,6 +483,13 @@ static void pci_restore_bars(struct pci_dev *dev)
 {
 	int i;
 
+        /* 
+	 * Per SRIOV SPEC 3.4.1.11, VF BARs are RO zero.
+	 * If this is a VF, just return.
+	 */
+	if (dev->is_virtfn)
+		return;
+
 	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++)
 		pci_update_resource(dev, i);
 }
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 232f925..ebe57db 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -36,6 +36,11 @@ void pci_update_resource(struct pci_dev *dev, int resno)
 	enum pci_bar_type type;
 	struct resource *res = dev->resource + resno;
 
+	if (dev->is_virtfn) {
+		dev_warn(&dev->dev, "Trying to update VF BAR\n");
+		return;
+	}
+
 	/*
 	 * Ignore resources for unimplemented BARs and unused resource slots
 	 * for 64 bit BARs.
-- 
1.7.9.5

