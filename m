Received: from mail-m49231.qiye.163.com (mail-m49231.qiye.163.com [45.254.49.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4536931F980
	for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2026 08:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777018416; cv=none; b=sMnbXoJneBqBE/n4ISr5gAOSAtNmT3xnLvkSW4XnxtbdIJypdpUjmkFXrYaLJOETV+RHK4RH1DUp7ty0hJ7U3fGZNN6rmptkS2PKW8e8Gt+sKkwfpO0HhC1uHGVb4hoPLCA0TvX83cIQ7ediA22wa6zQYqKoJk2AOEWdW3GU030=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777018416; c=relaxed/simple;
	bh=ucvoA6m7JfR3Nj1G2YOXMjpfqrdrg7M+xGv0L82Qp+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=iYCJapfipY95dCO6s7+8HZnPQ39QfEx6mry/WKIWskQYGgwIK4Egbk8sxE+62u3RAHp0eLz7TvWlPwX77OoI4sZMqiVvK/DOBD9GgeS0EEU9BaolzPAt7n+rD6wPivC9XhKqGftF8trNayAFJui5OJft0/xQG2YLZq832sHK9NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=CzhALnD4; arc=none smtp.client-ip=45.254.49.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="CzhALnD4"
Received: from localhost.localdomain (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3c02051e2;
	Fri, 24 Apr 2026 15:58:02 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v4 1/7] PCI/MSI: Split __pci_enable_msi_range() for reuse
Date: Fri, 24 Apr 2026 15:57:34 +0800
Message-Id: <1777017460-243543-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1777017460-243543-1-git-send-email-shawn.lin@rock-chips.com>
References: <1777017460-243543-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9dbe7eed5a09cckunm66d640875e99d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaSElIVhodGElIGU0ZS0JJHVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=CzhALnD46OEmNETyysSV2GQ+TmL3gdEGwFu2vbxv2epSuzPPf1FQnfqmo4CWpblBZkrgzCVuVkSFM5Snc9rWL4vZzxlmFp7UoXUP0THFGfU5FoU3CpRWRNhRJ4mqV5FSvemRO611fDfSFkxRYn2Gt6XXziJY6pREw1yMD+pYKnQ=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=nIkwOBEeQfi7KPrZZjVS6eHLn6sWpJbd//REZco0tWk=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Splits the __pci_enable_msi_range() function into two helper
functions without changing the original behavior. The purpose is to allow
future functions (particularly managed devres variants) to reuse these
components.

The split is as follows:

1. pci_msi_range_alloc(): Handles the allocation logic, including
   parameter validation and vector number calculation. This function returns
   the calculated number of vectors or an error code.

2. pci_msi_range_init(): Handles the initialization of MSI context
   and the actual MSI capability setup. This function takes the pre-calculated
   number of vectors as input.

3. The original __pci_enable_msi_range() is now a wrapper that calls these
   two helper functions in sequence, maintaining exact same behavior.

This is a preparatory step for introducing devres-managed MSI allocation
API that will share the allocation logic while providing automatic cleanup
via devres.

No functional changes intended.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/pci/msi/msi.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 81d24a2..748dba6 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -420,11 +420,9 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 	return __msi_capability_init(dev, nvec, masks);
 }
 
-int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
-			   struct irq_affinity *affd)
+static int pci_msi_range_alloc(struct pci_dev *dev, int minvec, int maxvec)
 {
 	int nvec;
-	int rc;
 
 	if (!pci_msi_supported(dev, minvec) || dev->current_state != PCI_D0)
 		return -EINVAL;
@@ -451,9 +449,13 @@ int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 	if (nvec < minvec)
 		return -ENOSPC;
 
-	rc = pci_setup_msi_context(dev);
-	if (rc)
-		return rc;
+	return nvec;
+}
+
+static int pci_msi_range_init(struct pci_dev *dev, int minvec, int maxvec,
+			      int nvec, struct irq_affinity *affd)
+{
+	int rc;
 
 	if (!pci_setup_msi_device_domain(dev, nvec))
 		return -ENODEV;
@@ -481,6 +483,22 @@ int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 	}
 }
 
+int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
+			   struct irq_affinity *affd)
+{
+	int nvec, rc;
+
+	nvec = pci_msi_range_alloc(dev, minvec, maxvec);
+	if (nvec < 0)
+		return nvec;
+
+	rc = pci_setup_msi_context(dev);
+	if (rc)
+		return rc;
+
+	return pci_msi_range_init(dev, minvec, maxvec, nvec, affd);
+}
+
 /**
  * pci_msi_vec_count - Return the number of MSI vectors a device can send
  * @dev: device to report about
-- 
2.7.4

