Return-Path: <SRS0=K8vK=UU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A4FC43613
	for <linux-pci@archiver.kernel.org>; Fri, 21 Jun 2019 23:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34B22089E
	for <linux-pci@archiver.kernel.org>; Fri, 21 Jun 2019 23:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfFUX5j (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Jun 2019 19:57:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:48780 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbfFUX5Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Jun 2019 19:57:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2019 16:57:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,402,1557212400"; 
   d="scan'208";a="359022898"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.162])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jun 2019 16:57:21 -0700
From:   Megha Dey <megha.dey@linux.intel.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, marc.zyngier@arm.com, ashok.raj@intel.com,
        jacob.jun.pan@linux.intel.com, megha.dey@intel.com,
        Megha Dey <megha.dey@linux.intel.com>
Subject: [RFC V1 RESEND 6/6] Documentation: PCI/MSI: Document dynamic MSI-X infrastructure
Date:   Fri, 21 Jun 2019 17:19:38 -0700
Message-Id: <1561162778-12669-7-git-send-email-megha.dey@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561162778-12669-1-git-send-email-megha.dey@linux.intel.com>
References: <1561162778-12669-1-git-send-email-megha.dey@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Documentation for the newly introduced dynamic allocation
and deallocation of MSI-X vectors.

Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Megha Dey <megha.dey@linux.intel.com>
---
 Documentation/PCI/MSI-HOWTO.txt | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/PCI/MSI-HOWTO.txt b/Documentation/PCI/MSI-HOWTO.txt
index 618e13d..5f6daf4 100644
--- a/Documentation/PCI/MSI-HOWTO.txt
+++ b/Documentation/PCI/MSI-HOWTO.txt
@@ -156,6 +156,44 @@ the driver can specify that only MSI or MSI-X is acceptable:
 	if (nvec < 0)
 		goto out_err;
 
+4.2.1 Dynamic MSI-X Allocation:
+
+The pci_alloc_irq_vectors() API is a one-shot method to allocate MSI resources
+i.e. they cannot be called multiple times. In order to allocate MSI-X vectors
+post probe phase, multiple times, use the following API:
+
+  int pci_alloc_irq_vectors_dyn(struct pci_dev *dev, unsigned int min_vecs,
+                unsigned int max_vecs, unsigned int flags, int *group_id);
+
+This API allocates up to max_vecs interrupt vectors for a PCI device. It returns
+the number of vectors allocated or a negative error. If the device has a
+requirement for a minimum number of vectors the driver can pass a min_vecs
+argument set to this limit, and the PCI core will return -ENOSPC if it can't
+meet the minimum number of vectors. This API is only to be used for MSI-X vectors.
+
+A group ID pointer is passed which gets populated by this function. A unique
+group_id will associated with all the MSI-X vectors allocated each time this
+function is called:
+
+	int group_id;
+	nvec = pci_alloc_irq_vectors_dyn(pdev, minvecs, maxvecs,
+					flags | PCI_IRQ_MSIX, &group_id);
+	if (nvec < 0)
+		goto out_err;
+
+To get the Linux IRQ numbers to pass to request_irq() and free_irq(), use the
+following function:
+
+  int pci_irq_vec_grp(struct pci_dev *dev, unsigned int nr, unsigned int group_id);
+
+In order to free the MSI-X resources associated with a particular group, use
+the following function:
+
+  int pci_free_irq_vectors_grp(struct pci_dev *dev, int group_id);
+
+For example, to delete the group allocated with the pci_alloc_irq_vectors_dyn(),
+	nvec = pci_free_irq_vectors_grp(pdev, group_id);
+
 4.3 Legacy APIs
 
 The following old APIs to enable and disable MSI or MSI-X interrupts should
-- 
2.7.4

