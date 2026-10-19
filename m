Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75950380FF4
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 08:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792398941; cv=none; b=CvcaoMFukumkSZKSR2gHGbjf96mxJ9Nr9IR5oCh9t/jFjPw8cz9+YD2B5+7XBs5hj2yxnaiMpnaakZ0Ox51Lp6Rs4a7igC0Ohbd3t3WYjYKJKsB4puz9dpIBgWeLlE7QcOqpMrpOvWcxx1WBQtPv/ytnuDGUxnqePzGwI6E1K9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792398941; c=relaxed/simple;
	bh=FgZCB0k1VE4Mfu3T/vFcE/5POedJAES6gbobSvce7Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+TdfqlMOeFCOSBviM+neH6iNwjUPpJaZ0QOPq+L5tCbUcjCtQS3xeK5VbxZM1TJN8M2oryK/vkXMmp8uiw4pDu09O2bwNLjkC5jos5ouExziCCVm8bTsuGTdfm4+HIBIVDsD4XNIP3FLkp8JtodI8T24yPyYaH7R1WCEpf+lds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CNzSPdyg; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CNzSPdyg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792398939; x=1823934939;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FgZCB0k1VE4Mfu3T/vFcE/5POedJAES6gbobSvce7Sg=;
  b=CNzSPdygM1FfHaXwJEPM0oCl5UE79pUeU93Vlx5LTUsEwutNxCsoFGJb
   5TOXjA4DtID94wpeViUv+cd1muxqnaksJm74e8jiKeQUPJTZL6ekqQ22E
   IPjpwjCsaJqd8bTaPKWFdDApAXye5dAeY1Uagx+Gso8Unk0hz48IxwIE4
   RG8LvSSaQzjwKQ2QHGRzMgguLRcW6OltvGmi6AiCq0gk40joOMAetNVpI
   kkvjyEadd0Na994tFJKt6zMALHTVgyA3ye7XKFvF2gFtNFOuYKpHCVsRk
   VHz321va5M01p9Td7keITPr2eo/KyNm/cJEavTCUUXW7gFdlYtjeav490
   g==;
X-CSE-ConnectionGUID: llPsRYLNSW+n/DAsOfqDJw==
X-CSE-MsgGUID: 5ScD4s9YQ9Slus3lacEWVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1061698"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1061698"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:35:39 -0700
X-CSE-ConnectionGUID: VtuLMc8XSxWKp5FWjTlAYA==
X-CSE-MsgGUID: 4DdHXtZ2Sn2fx357uD7jkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2857738"
Received: from dev-150.igk.intel.com (HELO localhost) ([10.91.214.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:35:34 -0700
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
Subject: [PATCH v1 02/13] PCI/IOV: Introduce VF iterators
Date: Mon, 19 Oct 2026 10:35:03 +0200
Message-ID: <20261019083514.838640-3-lukasz.laguna@intel.com>
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

Introduce helpers to iterate over the enabled VFs of a PF. Add
pci_get_vf() and pci_get_vf_reverse() to retrieve the next enabled VF
of a PF in ascending or descending VF ID order, along with
for_each_pci_vf(), for_each_pci_vf_reverse(), and
for_each_pci_vf_continue_reverse() built on top of them. The helpers
return each VF with a reference held, matching existing PCI device
lookup APIs.

This provides a common and convenient way to iterate over a PF's enabled
VFs and avoids duplicating the iteration logic in drivers.

Assisted-by: LLM
Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>
---
 drivers/pci/iov.c   | 63 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h | 57 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index eb019201faed..a437370c4e36 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -70,6 +70,69 @@ struct pci_dev *pci_iov_get_virtfn(struct pci_dev *dev, int id)
 }
 EXPORT_SYMBOL_GPL(pci_iov_get_virtfn);
 
+/**
+ * pci_get_vf() - Return the first or next existing VF of a PF
+ * @dev: PCI PF whose VFs are being iterated
+ * @from: Previous VF returned by this function, or %NULL to return the first VF
+ *
+ * Iterate over existing VFs of @dev in ascending VF ID order, skipping VF IDs
+ * with no device present. If a VF is found, its reference count is incremented.
+ * A new iteration is started by passing %NULL as the @from argument. Otherwise,
+ * iteration continues after @from, and the reference count on @from is
+ * decremented.
+ *
+ * Return: a pointer to the first or next VF, or %NULL if no further VF is found.
+ */
+struct pci_dev *pci_get_vf(struct pci_dev *dev, struct pci_dev *from)
+{
+	int id = 0;
+
+	if (from) {
+		id = pci_iov_vf_id(from) + 1;
+		pci_dev_put(from);
+	}
+
+	for (; id < pci_num_vf(dev); id++) {
+		from = pci_iov_get_virtfn(dev, id);
+		if (from)
+			return from;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(pci_get_vf);
+
+/**
+ * pci_get_vf_reverse() - Return the last or previous existing VF of a PF
+ * @dev: PCI PF whose VFs are being iterated
+ * @from: Previous VF returned by this function, or %NULL to return the last VF
+ *
+ * Same semantics as pci_get_vf(), except iteration proceeds in descending VF
+ * ID order.
+ *
+ * Return: a pointer to the last or previous VF, or %NULL if no further VF is
+ * found.
+ */
+struct pci_dev *pci_get_vf_reverse(struct pci_dev *dev, struct pci_dev *from)
+{
+	int id = pci_num_vf(dev);
+
+	if (from) {
+		id = pci_iov_vf_id(from);
+		pci_dev_put(from);
+	}
+
+	while (id > 0) {
+		id--;
+		from = pci_iov_get_virtfn(dev, id);
+		if (from)
+			return from;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(pci_get_vf_reverse);
+
 /**
  * pci_iov_get_pf_drvdata - Return the drvdata of a PF
  * @dev: VF pci_dev
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ac161f9f930c..03fe10ffa19b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -616,6 +616,53 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus);
 #define for_each_pci_dev_reverse(d) \
 	while ((d = pci_get_device_reverse(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)
 
+/**
+ * for_each_pci_vf - iterate over existing VFs of a PF
+ * @dev: PCI PF whose VFs are being iterated
+ * @vf: struct pci_dev * used as a loop cursor
+ *
+ * Iterate over existing VFs in ascending VF ID order, skipping VF IDs with no
+ * device present.
+ *
+ * During each iteration, @vf is returned with a reference held. That
+ * reference is released automatically only when advancing to the next VF.
+ * If the loop is exited early, the caller must drop the last reference.
+ */
+#define for_each_pci_vf(dev, vf) \
+	for ((vf) = NULL; ((vf) = pci_get_vf((dev), (vf))) != NULL; )
+
+/**
+ * for_each_pci_vf_reverse - iterate backwards over existing VFs of a PF
+ * @dev: PCI PF whose VFs are being iterated
+ * @vf: struct pci_dev * used as a loop cursor
+ *
+ * Iterate over existing VFs in descending VF ID order, skipping VF IDs with no
+ * device present.
+ *
+ * During each iteration, @vf is returned with a reference held. That
+ * reference is released automatically only when advancing to the next VF.
+ * If the loop is exited early, the caller must drop the last reference.
+ */
+#define for_each_pci_vf_reverse(dev, vf) \
+	for ((vf) = NULL; ((vf) = pci_get_vf_reverse((dev), (vf))) != NULL; )
+
+/**
+ * for_each_pci_vf_continue_reverse - iterate backwards from the given VF
+ * @dev: PCI PF whose VFs are being iterated
+ * @vf: struct pci_dev * used as a loop cursor
+ *
+ * Continue iterating in descending VF ID order from the preceding @vf.
+ * Before the first iteration, @vf must point to the current VF with a
+ * reference held.
+ *
+ * During each iteration, @vf is returned with a reference held. That
+ * reference is released automatically only when advancing to the next VF.
+ * If the loop is exited early, the caller must drop the last reference.
+ */
+#define for_each_pci_vf_continue_reverse(dev, vf) \
+	for ((vf) = pci_get_vf_reverse((dev), (vf)); (vf) != NULL; \
+	     (vf) = pci_get_vf_reverse((dev), (vf)))
+
 static inline int pci_channel_offline(struct pci_dev *pdev)
 {
 	return (pdev->error_state != pci_channel_io_normal);
@@ -2600,6 +2647,8 @@ int pci_iov_virtfn_bus(struct pci_dev *dev, int id);
 int pci_iov_virtfn_devfn(struct pci_dev *dev, int id);
 int pci_iov_vf_id(struct pci_dev *dev);
 struct pci_dev *pci_iov_get_virtfn(struct pci_dev *dev, int id);
+struct pci_dev *pci_get_vf(struct pci_dev *dev, struct pci_dev *from);
+struct pci_dev *pci_get_vf_reverse(struct pci_dev *dev, struct pci_dev *from);
 void *pci_iov_get_pf_drvdata(struct pci_dev *dev, struct pci_driver *pf_driver);
 int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn);
 void pci_disable_sriov(struct pci_dev *dev);
@@ -2640,6 +2689,14 @@ static inline int pci_iov_vf_id(struct pci_dev *dev)
 static inline struct pci_dev *pci_iov_get_virtfn(struct pci_dev *dev, int id)
 { return NULL; }
 
+static inline struct pci_dev *pci_get_vf(struct pci_dev *dev,
+					 struct pci_dev *from)
+{ return NULL; }
+
+static inline struct pci_dev *pci_get_vf_reverse(struct pci_dev *dev,
+						 struct pci_dev *from)
+{ return NULL; }
+
 static inline void *pci_iov_get_pf_drvdata(struct pci_dev *dev,
 					   struct pci_driver *pf_driver)
 {
-- 
2.43.0

