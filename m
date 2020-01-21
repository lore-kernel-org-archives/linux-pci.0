Return-Path: <SRS0=9+zz=3K=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E71C33CAA
	for <linux-pci@archiver.kernel.org>; Tue, 21 Jan 2020 19:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5475924656
	for <linux-pci@archiver.kernel.org>; Tue, 21 Jan 2020 19:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgAUTlf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 21 Jan 2020 14:41:35 -0500
Received: from mga14.intel.com ([192.55.52.115]:54441 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727360AbgAUTlf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Jan 2020 14:41:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 11:41:35 -0800
X-IronPort-AV: E=Sophos;i="5.70,347,1574150400"; 
   d="scan'208";a="220070691"
Received: from nsgsw-rhel7p6.lm.intel.com ([10.232.116.83])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 11:41:34 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     <iommu@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v5 1/7] x86/PCI: Add a to_pci_sysdata helper
Date:   Tue, 21 Jan 2020 06:37:45 -0700
Message-Id: <1579613871-301529-2-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579613871-301529-1-git-send-email-jonathan.derrick@intel.com>
References: <1579613871-301529-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Various helpers need the pci_sysdata just to dereference a single field
in it.  Add a little helper that returns the properly typed sysdata
pointer to require a little less boilerplate code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
[jonathan.derrick: to_pci_sysdata const argument]
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 arch/x86/include/asm/pci.h | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index 90d0731..a4e09db60 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -35,12 +35,15 @@ struct pci_sysdata {
 
 #ifdef CONFIG_PCI
 
+static inline struct pci_sysdata *to_pci_sysdata(const struct pci_bus *bus)
+{
+	return bus->sysdata;
+}
+
 #ifdef CONFIG_PCI_DOMAINS
 static inline int pci_domain_nr(struct pci_bus *bus)
 {
-	struct pci_sysdata *sd = bus->sysdata;
-
-	return sd->domain;
+	return to_pci_sysdata(bus)->domain;
 }
 
 static inline int pci_proc_domain(struct pci_bus *bus)
@@ -52,24 +55,20 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
 static inline void *_pci_root_bus_fwnode(struct pci_bus *bus)
 {
-	struct pci_sysdata *sd = bus->sysdata;
-
-	return sd->fwnode;
+	return to_pci_sysdata(bus)->fwnode;
 }
 
 #define pci_root_bus_fwnode	_pci_root_bus_fwnode
 #endif
 
+#if IS_ENABLED(CONFIG_VMD)
 static inline bool is_vmd(struct pci_bus *bus)
 {
-#if IS_ENABLED(CONFIG_VMD)
-	struct pci_sysdata *sd = bus->sysdata;
-
-	return sd->vmd_domain;
-#else
-	return false;
-#endif
+	return to_pci_sysdata(bus)->vmd_domain;
 }
+#else
+#define is_vmd(bus)		false
+#endif /* CONFIG_VMD */
 
 /* Can be used to override the logic in pci_scan_bus for skipping
    already-configured bus numbers - to be used for buggy BIOSes
@@ -124,9 +123,7 @@ static inline void early_quirks(void) { }
 /* Returns the node based on pci bus */
 static inline int __pcibus_to_node(const struct pci_bus *bus)
 {
-	const struct pci_sysdata *sd = bus->sysdata;
-
-	return sd->node;
+	return to_pci_sysdata(bus)->node;
 }
 
 static inline const struct cpumask *
-- 
1.8.3.1

