Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117111;
	b=I1yo3TVbRsOAXW0UCJjmoubUcW+XTw1wYVQlIR8KZ1dTSxBB+nLXZzUii2i0pMRhLQ4b
	 S9vHufKx+P/1GBjdBiwZ0F4cGapC+vBgY3xC4iOih7ReZSKERcfRtxdUXStSL5GZ+w42P
	 SriNIJ9BaUAGxrtFEK7pDToLBSEhn+RUZpsh9tZKK6tZ6DCqaLCkE0FzQqe3gS/KbY1nW
	 yC0vMREMxOl6FVwIeTnmvlcf1Tu/quU3vP4lgo/mHztTsX4/CdJUI1TAJ6eG2YLGY9vvg
	 5u/NJUhSLbdlnE/+a8WtnLL164M8NdfW6NIs2RSwAgfol/hzjp4OR0+MDI57bUXrqVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117111;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lIgmPlnBHPZhk8WAj6jp1URSBnz7HdqmLnWGNlMxMOc=;
	b=0amh+pinbOnsVgRs9A2867ZEoIavHaPREF1e78AYRsdeXRxwFH8osdxcALdOyHQTYyaf
	 B4y5QegwvqY/3nJRUgOgxXSn/tdmINzIYae3QMaJdNDo96Pm/RyBx90CHeuZ7FXqu3wTp
	 0VDQ6MOu/QXnB0ix8LnQFOFaqnla3iQyXw8E+NmOv5N6fDS0VPx79kiH6um3f10/sehPb
	 nNwBYeLWN66mGltoOv0DahLgQMFmzZWyae5vl6KnO5aG8ssCx76yPcMP4/BkcZHntd6a9
	 ibmjUpMPPoIE/IVa1YZ8SD4pOVlgihxQgHJzBxMNZGyhJz8zxl5ER3w4YEyBzT+zmrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kBGTpmr7;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C2C60A3834
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 16:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4C2C60A3834
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kBGTpmr7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793117110; x=1824653110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w9WF1UeoEoMkK9KtqcwB6XQ0P0/SFHvF2kCIkzvUuAw=;
  b=kBGTpmr7k38xvpphV4xhqYRy/ezQh1Tgdy4Q5lW04fErJNEra7o4fvYu
   DkAq8aMk8g8W1l2xL8g2MZxQN6R04274xKgyQjii3NI3zmYOpHtkxXnxz
   7HfhcyWHbXZ674JLre+wYJ8UcOq15ykn9RbJK+vxdMrDVewfxdlUxo/cq
   4qcqJAd2QvBx0soxUq5F2TkEczke7tlZULZJQrjLzArRb4Qgdr36sqEdN
   I+K/41aD0aLm37m8CJ7mNibt1KX6N70z4yVZ/NBTtTyYWupBZo0yrBGbH
   85ia1RgshQyzQg+Xc8aQ24eBbZlHVB3JyZmvwWHHrhLEgyHy6lVHwATLe
   w==;
X-CSE-ConnectionGUID: DQZQh22kR1if5HNwtJWjjw==
X-CSE-MsgGUID: Ybasc0bsRqarE7a+kH2m6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1852195"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1852195"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:05:10 -0700
X-CSE-ConnectionGUID: XMt3s23PQtSGi/gbSM+qSw==
X-CSE-MsgGUID: 3H/XhEKpRECBpLLgW2pMMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="5111798"
Received: from dev-150.igk.intel.com (HELO localhost) ([10.91.214.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:05:07 -0700
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
Subject: [PATCH v2 02/13] PCI/IOV: Introduce VF iterators
Date: Tue, 27 Oct 2026 17:04:35 +0100
Message-ID: <20261027160446.858300-3-lukasz.laguna@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027160446.858300-1-lukasz.laguna@intel.com>
References: <20261027160446.858300-1-lukasz.laguna@intel.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
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
index c7d8b5292cc1..f5930cf5b03f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -617,6 +617,53 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus);
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
@@ -2601,6 +2648,8 @@ int pci_iov_virtfn_bus(struct pci_dev *dev, int id);
 int pci_iov_virtfn_devfn(struct pci_dev *dev, int id);
 int pci_iov_vf_id(struct pci_dev *dev);
 struct pci_dev *pci_iov_get_virtfn(struct pci_dev *dev, int id);
+struct pci_dev *pci_get_vf(struct pci_dev *dev, struct pci_dev *from);
+struct pci_dev *pci_get_vf_reverse(struct pci_dev *dev, struct pci_dev *from);
 void *pci_iov_get_pf_drvdata(struct pci_dev *dev, struct pci_driver *pf_driver);
 int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn);
 void pci_disable_sriov(struct pci_dev *dev);
@@ -2641,6 +2690,14 @@ static inline int pci_iov_vf_id(struct pci_dev *dev)
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

