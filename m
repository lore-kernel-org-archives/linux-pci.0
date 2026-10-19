Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC9A423E94
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 08:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399021; cv=none; b=qvfJz4GxEacbziNaXwT77Man+C9xFe0T3CvXY1mqLTbrp8azj/vcKA/Un6Q4XDJB+z9CU8GD8jX9jw2QbcIwttAlhiS7RBlRwIwslwSC2ktS5A8qjXwEYVvCmkzPbGvHKWZC+NJHwXpWfeC8rcepbSGcYeT1HMDTvivffNEOV7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399021; c=relaxed/simple;
	bh=BU3m88+ILoRQ5EQWwE6L4FABwi5f6h7C5ClY7ENaW4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTPyjjwGmFpV9UBeadzk3mW4FQb+CC0/ba5iRvwFNzw72h2+kfTzGQBSlBKKzAhY90tNz3vKRAC3+LoGwFqijFl+YrL7MRxcQkGadJ+obYQlLbhJya92uebnFqBoJNlscuzgoi79MZD7jDNL2QZ2ZubaoCSUFBcihhtPCzPrxqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/jzOXcZ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/jzOXcZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792399020; x=1823935020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BU3m88+ILoRQ5EQWwE6L4FABwi5f6h7C5ClY7ENaW4Q=;
  b=g/jzOXcZolGo1OmCh/wYlCZG93qbWrYYrWTtnLwcyY0b1zF2pA6ycuiC
   P2+bEZITsKdwpbzXxoy3LkI0OaNLWRQtC9v5zsFdRyQK9FXnIVByUAlpK
   woBZn62PUKgMBLwEIMJnWbHdQS5fkIk8wng8aP4H2akemVVinC/LYAMSY
   2DAO3G2cpnIZOm8WwrRzXMQ9Q8WM3y5iYOAlZSXrO6UIZwevrVlBHfg1t
   qIOdIN9+Dh2d5IBz8pBAulmvyr+41kri0NvMTBFpcyGQ616XBWeynv67j
   uRHqS263JB8/uSL2muozrgTjS+o+DaJDHVcEX6kthLmJfiZl9pk/a3J7g
   Q==;
X-CSE-ConnectionGUID: LIYQ+bysTaGI2VxLDNOgVg==
X-CSE-MsgGUID: wrlfU6rrS9mgioThR+nL3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1090714"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1090714"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:37:00 -0700
X-CSE-ConnectionGUID: XhqDO7iJTxGiZNNQODaEDg==
X-CSE-MsgGUID: P72yTymNQ7K8ZffbhfRLfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2478519"
Received: from dev-150.igk.intel.com (HELO localhost) ([10.91.214.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:36:58 -0700
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
Subject: [PATCH v1 07/13] i40e: Drop VF MSI state restore from PF reset_done
Date: Mon, 19 Oct 2026 10:35:08 +0200
Message-ID: <20261019083514.838640-8-lukasz.laguna@intel.com>
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

The PCI core now saves and restores the config state of all enabled VFs
around PF reset, including MSI state. Remove the driver-specific
restore, as it's redundant now.

Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  3 ---
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 26 -------------------
 .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |  3 ---
 3 files changed, 32 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 0cd0e5597c90..44258573b07b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -16498,9 +16498,6 @@ static void i40e_pci_error_reset_done(struct pci_dev *pdev)
 		return;
 
 	i40e_reset_and_rebuild(pf, false, false);
-#ifdef CONFIG_PCI_IOV
-	i40e_restore_all_vfs_msi_state(pdev);
-#endif /* CONFIG_PCI_IOV */
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index a26c3d47ec15..f240e6a36887 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -154,32 +154,6 @@ void i40e_vc_notify_reset(struct i40e_pf *pf)
 			     (u8 *)&pfe, sizeof(struct virtchnl_pf_event));
 }
 
-#ifdef CONFIG_PCI_IOV
-void i40e_restore_all_vfs_msi_state(struct pci_dev *pdev)
-{
-	u16 vf_id;
-	u16 pos;
-
-	/* Continue only if this is a PF */
-	if (!pdev->is_physfn)
-		return;
-
-	if (!pci_num_vf(pdev))
-		return;
-
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
-	if (pos) {
-		struct pci_dev *vf_dev = NULL;
-
-		pci_read_config_word(pdev, pos + PCI_SRIOV_VF_DID, &vf_id);
-		while ((vf_dev = pci_get_device(pdev->vendor, vf_id, vf_dev))) {
-			if (vf_dev->is_virtfn && vf_dev->physfn == pdev)
-				pci_restore_msi_state(vf_dev);
-		}
-	}
-}
-#endif /* CONFIG_PCI_IOV */
-
 /**
  * i40e_vc_notify_vf_reset
  * @vf: pointer to the VF structure
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index 4e119c0502f3..b6b11de74de5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -148,9 +148,6 @@ int i40e_ndo_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool enable);
 
 void i40e_vc_notify_link_state(struct i40e_pf *pf);
 void i40e_vc_notify_reset(struct i40e_pf *pf);
-#ifdef CONFIG_PCI_IOV
-void i40e_restore_all_vfs_msi_state(struct pci_dev *pdev);
-#endif /* CONFIG_PCI_IOV */
 int i40e_get_vf_stats(struct net_device *netdev, int vf_id,
 		      struct ifla_vf_stats *vf_stats);
 
-- 
2.43.0

