Received: from mail-m1973176.qiye.163.com (mail-m1973176.qiye.163.com [220.197.31.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5750437F002
	for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2026 08:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777017825; cv=none; b=Qh+9Y0HVzSyCG85oJ0kT1KN74p25m1UOEfyuxK7Cg7OkCdTn9QlBqLzeyA7tfKHh32GoOn8ssntlmfjdUS8Yc7RoHakIgVkF6PrfDgRCGZdEkFmH3VH/yxBLTo47eC3yVpE32/YG1g/aYe8JTO/x6C9/rv/1OGqqOY9e0k1Z+qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777017825; c=relaxed/simple;
	bh=Ciy3SdNgI/j6WKJkjDkrhATHzSZzgly5/myu1Ze4Q2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=M6HkMxcpkiVxnGCoyTgWXwUmWKxT9zn6hFYqFXamQvRQiGPM06sWK+3T/5fLm3ye9U3oSgXhBLY54uqnnJboIXR1WVICt/X4wx/p2iEw8GeJBleJ5/64kCSCWsjW27ohy1F6FZ4CB6JiGRv4gBf53Pqr5rKPPdMHeveP37quDiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=AhwRyhHn; arc=none smtp.client-ip=220.197.31.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="AhwRyhHn"
Received: from localhost.localdomain (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3c0205239;
	Fri, 24 Apr 2026 15:58:15 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v4 2/7] PCI/MSI: Split __pci_enable_msix_range() for reuse
Date: Fri, 24 Apr 2026 15:57:35 +0800
Message-Id: <1777017460-243543-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1777017460-243543-1-git-send-email-shawn.lin@rock-chips.com>
References: <1777017460-243543-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9dbe7f1fe909cckunm66d640875ea13
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZQxhOVh5ISk8eTB1OTU4eQlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0tVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=AhwRyhHnj9DsjTDh67DyDvlCs+z03o1+UP6yPcYihmMs3BpAdAi1U3pkBaQOU8AyPADAoRs2YEI3Fit9RUFgApvI38kpG7vFmoWyUwCv9IwHWNnJt7FCRe6RgjorYz5YaaQOIgEdy0Bg+O6BDwQfAK0fzandnYewo/9WsNlufmw=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=7kjOoOEShdho0LvaXR4AZ8l8XbTuFKa4ZTPV+311oNE=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Splits the __pci_enable_msix_range() function into two helper
functions without changing the original behavior. The purpose is to allow
future functions (particularly managed devres variants) to reuse these
components.

The split is as follows:

1. pci_msix_range_alloc(): Handles the allocation logic, including
   parameter validation, hardware vector count verification, and entry
   validation. This function calculates the actual number of vectors
   to allocate and returns the hardware-supported vector count.

2. pci_msix_range_init(): Handles the initialization of MSI-X context
   and the actual MSI-X capability setup. This function takes the
   pre-determined number of vectors and hardware vector count as inputs.

3. The original __pci_enable_msix_range() is now a wrapper that calls
   these two helper functions in sequence, maintaining exact same
   behavior.

This is a preparatory step for introducing devres-managed MSI-X allocation
API that will share the allocation logic while providing automatic cleanup
via devres.

No functional changes intended.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/pci/msi/msi.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 748dba6..5c196c2 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -820,10 +820,10 @@ static bool pci_msix_validate_entries(struct pci_dev *dev, struct msix_entry *en
 	return true;
 }
 
-int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries, int minvec,
-			    int maxvec, struct irq_affinity *affd, int flags)
+static int pci_msix_range_alloc(struct pci_dev *dev, struct msix_entry *entries,
+				int minvec, int maxvec, int flags, int *nvec_ret)
 {
-	int hwsize, rc, nvec = maxvec;
+	int hwsize, nvec = maxvec;
 
 	if (maxvec < minvec)
 		return -ERANGE;
@@ -858,12 +858,16 @@ int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries, int
 			nvec = hwsize;
 	}
 
-	if (nvec < minvec)
-		return -ENOSPC;
+	*nvec_ret = nvec;
 
-	rc = pci_setup_msi_context(dev);
-	if (rc)
-		return rc;
+	return hwsize;
+}
+
+static int pci_msix_range_init(struct pci_dev *dev, struct msix_entry *entries,
+			       int minvec, int nvec, int hwsize,
+			       struct irq_affinity *affd)
+{
+	int rc;
 
 	if (!pci_setup_msix_device_domain(dev, hwsize))
 		return -ENODEV;
@@ -888,6 +892,24 @@ int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries, int
 	}
 }
 
+int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
+			    int minvec, int maxvec, struct irq_affinity *affd,
+			    int flags)
+{
+	int hwsize, nvec, rc;
+
+	hwsize = pci_msix_range_alloc(dev, entries, minvec,
+				      maxvec, flags, &nvec);
+	if (hwsize < 0)
+		return hwsize;
+
+	rc = pci_setup_msi_context(dev);
+	if (rc)
+		return rc;
+
+	return pci_msix_range_init(dev, entries, minvec, nvec, hwsize, affd);
+}
+
 void __pci_restore_msix_state(struct pci_dev *dev)
 {
 	struct msi_desc *entry;
-- 
2.7.4

