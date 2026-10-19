Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AC5380FF4
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 08:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792398934; cv=none; b=aPLDSTuh0Ai0PYrEhrAJdRGC17eGP+wC0b+PoyN96bj2XQEzWVtR4zxr8Wdm4gP1O53x9D2C0eREJVFP8QMYCQlyv1/EUb/ClO1nZCdVHwjZDLtxYJNti/wdikXIWjRmpVPxf0YHjoyAUswuL2LyiCt3dU0yhJt7CU/kYusW1+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792398934; c=relaxed/simple;
	bh=cywAn/R7yyVX0+SKzN7Pf6AlTAUqVdjZ4LO3yTsxs6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dfDdn6t2hwMyhgHIg8QCopMPNw32QD+goZUHAfWx+4tOBTayxkvE/oZGCCfx4JTYlUHcJjHB0A9+sW/4K8YMHejNfUoDmmwTdKLFb0aJ/TXXgxQhxKcNE7LNkpx7NhrOh2+yg2iD23hcMmbCfk4nWmfYdlD+Orba/ETYfI0av1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gxu28E7j; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gxu28E7j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792398932; x=1823934932;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cywAn/R7yyVX0+SKzN7Pf6AlTAUqVdjZ4LO3yTsxs6M=;
  b=gxu28E7jAVpMPRtIyiTsTV8VmLJHIo+4/GhjmP6r6S30jjqgWAP3hbi4
   5mxq8qFbi/W/nU6wD7SEETOhrkFBeKa+UmSoR9BCKqVXa3HouMxPzG7Hk
   UgoK6SBpPT2YvKloMpZb8qpHpIqP5wC2C69OmL8PBIuOIRilND+6yyzR8
   RSSgrKkFRvqLZjvkMZxgdZeGglYvz21sXxDpkCZRfNU9pgTb5n5Vvynan
   1+8kU3Gwa4w1QVZI2h51ytnOKAp21Ckec1nqhKRZRuFq25bxOmpvZ1rYx
   Seo2ZhpXbz57ayqT/C7UGRyXPQkn14dxCJ4FDOvq1BSCQMjB6yngzJ+Ub
   Q==;
X-CSE-ConnectionGUID: y6+JQJCTTjSltH8CN6RLvA==
X-CSE-MsgGUID: RIqIZ18VQb+o+lDd7UAIhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1061680"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1061680"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:35:32 -0700
X-CSE-ConnectionGUID: HVR1FKMvSJidwNVH1i33wQ==
X-CSE-MsgGUID: m2l9iC7LRpGjl9M/zGIczw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2857721"
Received: from dev-150.igk.intel.com (HELO localhost) ([10.91.214.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:35:30 -0700
From: Lukasz Laguna <lukasz.laguna@intel.com>
To: linux-pci@vger.kernel.org,
	bhelgaas@google.com
Cc: michal.winiarski@intel.com,
	djbw@kernel.org,
	brett.creeley@amd.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org
Subject: [PATCH v1 01/13] PCI/IOV: Introduce pci_iov_get_virtfn()
Date: Mon, 19 Oct 2026 10:35:02 +0200
Message-ID: <20261019083514.838640-2-lukasz.laguna@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019083514.838640-1-lukasz.laguna@intel.com>
References: <20261019083514.838640-1-lukasz.laguna@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add pci_iov_get_virtfn() to look up a VF of a PF by its VF ID. It
returns the matching pci_dev with a reference held, or NULL if no device
is present. The caller must drop the reference with pci_dev_put().

Assisted-by: LLM
Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>
---
 drivers/pci/iov.c   | 25 +++++++++++++++++++++----
 include/linux/pci.h |  4 ++++
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 9185934a900f..eb019201faed 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -51,6 +51,25 @@ int pci_iov_vf_id(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_iov_vf_id);
 
+/**
+ * pci_iov_get_virtfn() - Get the VF of a PF by its VF ID
+ * @dev: PCI PF
+ * @id: VF ID
+ *
+ * Find the VF with ID @id that belongs to PF @dev.
+ *
+ * The caller must drop the reference on the returned VF with pci_dev_put().
+ *
+ * Return: a pointer to the VF with ID @id, or %NULL if no such VF is present.
+ */
+struct pci_dev *pci_iov_get_virtfn(struct pci_dev *dev, int id)
+{
+	return pci_get_domain_bus_and_slot(pci_domain_nr(dev->bus),
+					   pci_iov_virtfn_bus(dev, id),
+					   pci_iov_virtfn_devfn(dev, id));
+}
+EXPORT_SYMBOL_GPL(pci_iov_get_virtfn);
+
 /**
  * pci_iov_get_pf_drvdata - Return the drvdata of a PF
  * @dev: VF pci_dev
@@ -380,9 +399,7 @@ void pci_iov_remove_virtfn(struct pci_dev *dev, int id)
 	char buf[VIRTFN_ID_LEN];
 	struct pci_dev *virtfn;
 
-	virtfn = pci_get_domain_bus_and_slot(pci_domain_nr(dev->bus),
-					     pci_iov_virtfn_bus(dev, id),
-					     pci_iov_virtfn_devfn(dev, id));
+	virtfn = pci_iov_get_virtfn(dev, id);
 	if (!virtfn)
 		return;
 
@@ -399,7 +416,7 @@ void pci_iov_remove_virtfn(struct pci_dev *dev, int id)
 	pci_stop_and_remove_bus_device(virtfn);
 	virtfn_remove_bus(dev->bus, virtfn->bus);
 
-	/* balance pci_get_domain_bus_and_slot() */
+	/* balance pci_iov_get_virtfn() */
 	pci_dev_put(virtfn);
 	pci_dev_put(dev);
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f3e9c6c9c5e0..ac161f9f930c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2599,6 +2599,7 @@ void __iomem *pci_ioremap_wc_bar(struct pci_dev *pdev, int bar);
 int pci_iov_virtfn_bus(struct pci_dev *dev, int id);
 int pci_iov_virtfn_devfn(struct pci_dev *dev, int id);
 int pci_iov_vf_id(struct pci_dev *dev);
+struct pci_dev *pci_iov_get_virtfn(struct pci_dev *dev, int id);
 void *pci_iov_get_pf_drvdata(struct pci_dev *dev, struct pci_driver *pf_driver);
 int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn);
 void pci_disable_sriov(struct pci_dev *dev);
@@ -2636,6 +2637,9 @@ static inline int pci_iov_vf_id(struct pci_dev *dev)
 	return -ENOSYS;
 }
 
+static inline struct pci_dev *pci_iov_get_virtfn(struct pci_dev *dev, int id)
+{ return NULL; }
+
 static inline void *pci_iov_get_pf_drvdata(struct pci_dev *dev,
 					   struct pci_driver *pf_driver)
 {
-- 
2.43.0

