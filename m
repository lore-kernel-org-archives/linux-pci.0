Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D0E4848B4
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399044; cv=none; b=ojYV/NEhFcE8hzdK88hoWud94/QZPGeLldQyybR1NCSyp4ZrJgcF6hVafS/aSxGhCSt+UM2zHjtNJNX1tda6sbVDv3fzzNziW1R58x1vUDHixCpz2ZmgyagYeH6sEmvVESTw+fuTnIHa+FzPCvFPuyKTOGAkDT6KeMuvpWFyblQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399044; c=relaxed/simple;
	bh=gpRyyfh4Txq/gD3fpri1VBvGPem0+4EBKKz60rOMcW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZakRlPMKS0Kg9OTN2vCcOC9068cNIwNXDdAMc4W4WyIjkWoqJAcpOfWEKa/2eSpi70QKSby+L/y1QKz03wCyv28idPFFx2Gr4GUvEJn54TaSJub8Ea6CYzNjB0gK7G08w6L3C+kHFVV/RB4p83zE81MzT39EjNDzlv7PgGrLkQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BReU0o/q; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BReU0o/q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792399043; x=1823935043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gpRyyfh4Txq/gD3fpri1VBvGPem0+4EBKKz60rOMcW4=;
  b=BReU0o/qn6b9LfEQinkE7PZQ5Crhauf5cSq3MQrd1D8Ok+9eOY8O1kON
   qG/3eJWmh8q1MkUAtUsBRjfjRz5p8XoHqB+P+9QKQ97t8SfbnK3ieEdmy
   4ynhk0wjIaYjTLm+lqvmTTAxWvaflZdJO4TptkrIOlALJ+N9pw+rYdiGV
   BCIE6VrMkBSrwi+5Qt4Krr4DzuPIkAd4LAVlVLc+9r70DxuV3s/Ljqlxq
   uRh9YUxgUsGkSPReu+Bpgu4VOz4VIB5YP+KeuA2lJKzIQnfgDIQvu/o8B
   gWxYgEBoxWb5diZIL94EvQZJmVaZvkQr10+R/qHNFmZjvEqBWoIvDkbG7
   g==;
X-CSE-ConnectionGUID: 1cjL36+eTPOWeaOJlkFFwA==
X-CSE-MsgGUID: wD9esol0ShqPYFnxbD1Xhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="978874"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="978874"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:37:09 -0700
X-CSE-ConnectionGUID: K0dIdkhLQqOemJ0+/mrGCQ==
X-CSE-MsgGUID: LLlbNn7eRnWwucKVOtMZog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2477262"
Received: from dev-150.igk.intel.com (HELO localhost) ([10.91.214.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:37:07 -0700
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
Subject: [PATCH v1 09/13] PCI/TSM: Use generic VF iterators
Date: Mon, 19 Oct 2026 10:35:10 +0200
Message-ID: <20261019083514.838640-10-lukasz.laguna@intel.com>
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

