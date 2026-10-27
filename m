Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117205;
	b=GaBzaIesV5mpU3Zic/Bxuw/pXFQUuPK0kbMUmIjo1O+7/azaHBWpp7jP4Nnw5YW1hVIU
	 1mZU/5Kv80uPoXC5WTjCky+b/EK8lW4HaCcukjst/mVGuupowu8flqfKyBmP8QkgfOM12
	 T0Xqz4t1/ZlAV/6MVVnDzrLgec0pCXsskRLHADytHi4VKns3L9PZmE+7C6bCxD+YfGNhw
	 vChgwGD8MW+7hY8SwaKYcKXqTN0fYPloCk6eWcBkuqj0kirLACM8qkRzBltXeKT2zZpx0
	 PaOlIVL0LMSWQGQZbAsFThqVX25M0VVKPg4HPakyBSM9y3wO+3m1LaIEDJc2iqYqsMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117205;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aKubB+kf/el5MySXca2F5ll+U454Gb+RleBdSE/uZc4=;
	b=ZTHtwHnHGCNFPeBELg4U/Gtl3kGFSGP4DFloHcrzTOLhTxPmd+uKII0Jn/rCsevTNrVf
	 i0izndpybbdHmL6tK7mL74pK5vAkI5lMhGQDp+w6WJl7f6+JyULQK+efhrN3YNVCOFbwN
	 4gV5wEixr8g3t+Z+4kJifWyqP58hbTC451YXXnHc+BO1GRSdCsTxc8NgMCiNNZrpTlJso
	 p6G7Ys3oZN322IvD0UTwmIsoppd/iCSJpidepTO22KHB5K2oaBHbGcI7Ju5rLhHCfnhVi
	 Ui0EPppKGo+7dXnyZ/Xjmdx+arVETLkeiRs+2XwG5vcetcXsw3apSBdRl8Bkvyhdj1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UdekMRFq;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AD5606A31A
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 16:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51AD5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UdekMRFq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793117204; x=1824653204;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gpRyyfh4Txq/gD3fpri1VBvGPem0+4EBKKz60rOMcW4=;
  b=UdekMRFqB4yG6zQmOz2WsYJH9KLqa07nUttthGemkK32NKUS9GlXM+Uw
   NKU02dkG86Wuvir7io9GBEAgME5S7rAQbDalFb5RPMH0RZiPEuvMTMTZL
   wEiN8QVeoG0lrYiDU2nK0otP9FqHIg39g4WiIbswWVylbzoHZswUtciAc
   EFgZNwLZckCMQo+pz8vbIyJX9M25HP2INWqY54xRTrSNrmSR2lVcdhmqt
   5nb25aj7e1E+PQNbN8rBGHrEaWywxDjVKCaGqDo1yZri/ECQshiHPhNMz
   X325i6yqjTfjob1DZwj8qdXlUTgU6VHoXqKCMvIJn6lLY8biMb4KGfBHj
   g==;
X-CSE-ConnectionGUID: v9lPsjKeQjaCc3BZnUiHTw==
X-CSE-MsgGUID: 6Q4tevqMSIe+C7CE0K7TiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1845799"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1845799"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:06:44 -0700
X-CSE-ConnectionGUID: P0+PCXksT6CKWDoGP30FXw==
X-CSE-MsgGUID: 3Jx/YQJqTC2nH84uiMiqlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4652412"
Received: from dev-150.igk.intel.com (HELO localhost) ([10.91.214.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:06:42 -0700
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
Subject: [PATCH v2 09/13] PCI/TSM: Use generic VF iterators
Date: Tue, 27 Oct 2026 17:04:42 +0100
Message-ID: <20261027160446.858300-10-lukasz.laguna@intel.com>
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

pci_tsm_walk_fns() and pci_tsm_walk_fns_reverse() implement their own VF
iteration logic. Replace it with for_each_pci_vf() and
for_each_pci_vf_reverse().

Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>
---
 drivers/pci/tsm.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index 5fdcd7f2e820..01fa6149e481 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -84,6 +84,7 @@ static void pci_tsm_walk_fns(struct pci_dev *pdev,
 	for (int i = 0; i < 8; i++) {
 		struct pci_dev *pf __free(pci_dev_put) = pci_get_slot(
 			pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->devfn), i));
+		struct pci_dev *vf;
 
 		if (!pf)
 			continue;
@@ -93,18 +94,8 @@ static void pci_tsm_walk_fns(struct pci_dev *pdev,
 			cb(pf, data);
 
 		/* walk virtual functions of each pf */
-		for (int j = 0; j < pci_num_vf(pf); j++) {
-			struct pci_dev *vf __free(pci_dev_put) =
-				pci_get_domain_bus_and_slot(
-					pci_domain_nr(pf->bus),
-					pci_iov_virtfn_bus(pf, j),
-					pci_iov_virtfn_devfn(pf, j));
-
-			if (!vf)
-				continue;
-
+		for_each_pci_vf(pf, vf)
 			cb(vf, data);
-		}
 	}
 
 	/*
@@ -128,22 +119,14 @@ static void pci_tsm_walk_fns_reverse(struct pci_dev *pdev,
 	for (int i = 7; i >= 0; i--) {
 		struct pci_dev *pf __free(pci_dev_put) = pci_get_slot(
 			pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->devfn), i));
+		struct pci_dev *vf;
 
 		if (!pf)
 			continue;
 
 		/* reverse walk virtual functions */
-		for (int j = pci_num_vf(pf) - 1; j >= 0; j--) {
-			struct pci_dev *vf __free(pci_dev_put) =
-				pci_get_domain_bus_and_slot(
-					pci_domain_nr(pf->bus),
-					pci_iov_virtfn_bus(pf, j),
-					pci_iov_virtfn_devfn(pf, j));
-
-			if (!vf)
-				continue;
+		for_each_pci_vf_reverse(pf, vf)
 			cb(vf, data);
-		}
 
 		/* on exit, caller will run @cb on function 0 */
 		if (i > 0)
-- 
2.43.0

