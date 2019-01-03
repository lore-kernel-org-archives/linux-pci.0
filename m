Return-Path: <SRS0=ToWj=PL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F891C43387
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jan 2019 21:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5427721871
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jan 2019 21:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfACVLr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 3 Jan 2019 16:11:47 -0500
Received: from mga02.intel.com ([134.134.136.20]:39360 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbfACVLr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jan 2019 16:11:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2019 13:11:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,436,1539673200"; 
   d="scan'208";a="103738164"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga007.jf.intel.com with ESMTP; 03 Jan 2019 13:11:46 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Keith Busch <keith.busch@intel.com>
Subject: [PATCH 3/4] pci/irq: Handle vector reduce and retry
Date:   Thu,  3 Jan 2019 14:09:53 -0700
Message-Id: <20190103210954.11129-3-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190103210954.11129-1-keith.busch@intel.com>
References: <20190103210954.11129-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adding the nr_sets forced the driver to handle reducing the vector count
on allocation failures because the set distributino counts are driver
specific. The change to this API is very different to use than before,
and introduced new error corner cases that weren't being handled. It
is also less efficient since the driver doesn't actually know what a
proper vector count it should use since it only sees the error code and
can only reduce by one instead of going straight to a possible vector
count like PCI is able to do.

Provide a driver specific callback for managed irq set creation so that
PCI can take a min and max vectors as before to handle the reduce and
retry logic.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/msi.c         | 20 ++++++--------------
 include/linux/interrupt.h |  4 ++++
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 7a1c8a09efa5..b93ac49be18d 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1035,13 +1035,6 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 	if (maxvec < minvec)
 		return -ERANGE;
 
-	/*
-	 * If the caller is passing in sets, we can't support a range of
-	 * vectors. The caller needs to handle that.
-	 */
-	if (affd && affd->nr_sets && minvec != maxvec)
-		return -EINVAL;
-
 	if (WARN_ON_ONCE(dev->msi_enabled))
 		return -EINVAL;
 
@@ -1061,6 +1054,9 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 				return -ENOSPC;
 		}
 
+		if (nvec != maxvec && affd && affd->recalc_sets)
+			affd->recalc_sets((struct irq_affinity *)affd, nvec);
+
 		rc = msi_capability_init(dev, nvec, affd);
 		if (rc == 0)
 			return nvec;
@@ -1093,13 +1089,6 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 	if (maxvec < minvec)
 		return -ERANGE;
 
-	/*
-	 * If the caller is passing in sets, we can't support a range of
-	 * supported vectors. The caller needs to handle that.
-	 */
-	if (affd && affd->nr_sets && minvec != maxvec)
-		return -EINVAL;
-
 	if (WARN_ON_ONCE(dev->msix_enabled))
 		return -EINVAL;
 
@@ -1110,6 +1099,9 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 				return -ENOSPC;
 		}
 
+		if (nvec != maxvec && affd && affd->recalc_sets)
+			affd->recalc_sets((struct irq_affinity *)affd, nvec);
+
 		rc = __pci_enable_msix(dev, entries, nvec, affd);
 		if (rc == 0)
 			return nvec;
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index c672f34235e7..326c9bd05f62 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -249,12 +249,16 @@ struct irq_affinity_notify {
  *			the MSI(-X) vector space
  * @nr_sets:		Length of passed in *sets array
  * @sets:		Number of affinitized sets
+ * @recalc_sets:	Recalculate sets original requested allocation failed
+ * @priv:		Driver private data
  */
 struct irq_affinity {
 	int	pre_vectors;
 	int	post_vectors;
 	int	nr_sets;
 	int	*sets;
+	void	(*recalc_sets)(struct irq_affinity *, unsigned int);
+	void	*priv;
 };
 
 /**
-- 
2.14.4

