Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117106;
	b=i5WL3z+uZCgQZekIe6Zl29hpvcYu9vpaLtbhagzxN0xCJX28ORZE9CXdLKT0rTBn/12A
	 HdtquvN7zzWQW4O/+AhYUeNEBTcYvigCHbE6pdeNfWf9VBdK5gBNzbtA8Qfgh8ox7cPxs
	 4Pnvhsu66VOyuOkXtNv2Xqe64IbTICokWacq7DQo/Rde8Bgzs5RFduXhaPhF3lDrPTIKI
	 e75PkW/4HBNbmjra7GtU+lWK5isoaO6bxfr0qT8DptCIK5Nqzq/Dy88Ak+4s8Cb0SRUez
	 aPt3Ifvf1DDVBWXCJazChKGj/+V/tOKXKW3iPMDERqBPlcbrlrj5o1xZJ3fX0q7SL3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117106;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=q6u5CSCZ9kphvglZcxodRTcZdu4n10OUtD/l5u7EB+w=;
	b=LUd5WUm8UNVCmvq3RKsLG+UCvOrMny1xQFbmP4x9oCprHKeJBOkfCelMVxTSO9xCVgzf
	 p/NKBNjx5Gj8/+KXAKFRkAnrlr6BtII1Yvf+8GG5MgYfiUQAzv3++bVR/640K4tKIzqF9
	 60wZM2MeYaco5FmdwlaJDpfovHNVR+/QJ+k7aRK5emqIxe/F6SBVhYvD+IJ8YSHEv/7e2
	 gqZUhsibXzhRJaa366cIItZk5Z8t4r0ah+9MirkgzG2dGgC1coSwNeRNhh6kMAK26sens
	 VYfEcigncju6I9Q8e2z4KCSvRBjhSKWBp6ENNDFX3aSMqNtzwUss/KnIwuGFXQ33HjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SjhbKxSH;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBC860A2612
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 16:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBBC860A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SjhbKxSH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793117105; x=1824653105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BO7TfNsoRPaWc25mK6Y8UlaHOwo5j0T4+Llq3lczV90=;
  b=SjhbKxSH4adZSKiw1yevDdE/VF4o4oMhzmmTsBHzDKOWSetsovXjNTv5
   MKZSYvINnxjyByGjP9sNSQ8WL50N0IswBXhfnrg6dtEV/ItXu/hIpbDbb
   lQKB0yXhgAQjY2AzQ0f+aHpXHwyOE5AP/n3+EeiugbNos/ui1tCsBIv5F
   rB5y9Y3OkYovPPdJo2AzhQeO9gKtp2kxIEO+gwUR9cTaxkI3SupVFxJl/
   JDOLZQOPbih+5TTMZRQpy4FSfVQIg2cJQeQbfMvKmk+4FexnAyNwpA+HV
   EEZJYsP1PllsL3FaTB1sXi5cOkREHbTq6X99ggx+9vEEKjooIYd6raYU2
   A==;
X-CSE-ConnectionGUID: +HhQTOxsTgKRtdLyuNXO6Q==
X-CSE-MsgGUID: yUZvmjAzQ2ep3aSsozaKNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1852178"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1852178"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:05:05 -0700
X-CSE-ConnectionGUID: TYysI2ixSJuySIb7+kRotA==
X-CSE-MsgGUID: lQKEWM0NTw6ZQbTu3r/umg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="5111770"
Received: from dev-150.igk.intel.com (HELO localhost) ([10.91.214.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:05:02 -0700
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
Subject: [PATCH v2 01/13] PCI/IOV: Introduce pci_iov_get_virtfn()
Date: Tue, 27 Oct 2026 17:04:34 +0100
Message-ID: <20261027160446.858300-2-lukasz.laguna@intel.com>
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
index ef6327205520..c7d8b5292cc1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2600,6 +2600,7 @@ void __iomem *pci_ioremap_wc_bar(struct pci_dev *pdev, int bar);
 int pci_iov_virtfn_bus(struct pci_dev *dev, int id);
 int pci_iov_virtfn_devfn(struct pci_dev *dev, int id);
 int pci_iov_vf_id(struct pci_dev *dev);
+struct pci_dev *pci_iov_get_virtfn(struct pci_dev *dev, int id);
 void *pci_iov_get_pf_drvdata(struct pci_dev *dev, struct pci_driver *pf_driver);
 int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn);
 void pci_disable_sriov(struct pci_dev *dev);
@@ -2637,6 +2638,9 @@ static inline int pci_iov_vf_id(struct pci_dev *dev)
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

