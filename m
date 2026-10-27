Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117195;
	b=ek/1EQfRtHxonUJspUaiyIivzQ4imA8Ua9m2Kz4UtkUMkq9TLwswymiv13nyljSoLH+v
	 jWyXYE3p3CGq1v/l+CmuMqdfDeF8Zg5KX3FnMFEzX1g1lta5P/dNz52vvSPuFwPD26ad+
	 6j7fGukIiE8QsYkvdWhi3urGwdWOBfD5Tp28AFT9LtiujhJ4IXNZ5ZEzW4DqMy8sTyTEC
	 g5ARdhGqELtqWoGbCXvsHfxLrj0AVB3AoH8gpEbpGy3MKFa7sfAhAmbbrHRWd36DyqADc
	 A3t9/qb200FDG05RVkANji/emu/2D1pPK6snZqYgzJS6aGk6KZE7zGR3f18SMMzPvtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117195;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9qcupbO67jarSsG/0+IWcR3/leC01LUupScEjtst6As=;
	b=l5vqHrpyPo8LZzNTvRNV44r0mRwkjNURItYcyEHEqsaOmgUSBUCmzaKfgMQf9GowjIju
	 BDPBkCc9j0M3TCm20VRTItrbCiYf6RAp1Tp/ISNd3oKAvkieYKec0C14TBSQnGoW67vWM
	 n2bmzys5x5sm08DaqVAF7XraOkqX+wkZxNM/3YrjU+GwOBTpUQeINsMtyOgE/d1KzdRcs
	 hqLPjzmBL9O8xD++fxfSHZhlaDtpSyC4cb5jw4kSfn9Pn/X3xoieUTaZ2FPRQJXIswMBV
	 CPBlW8ZWlLPT0QMosI71chaDBaJj82fjcc4YZptjHOdATZ84LjuybHHXNyKNz4Pumqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="EZ9WIqS/";
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9684A606A31B
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 16:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9684A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EZ9WIqS/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793117195; x=1824653195;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J12by6MRFTGDplMLimY25Gcb+wqWQh3Ov+IWaIACyZ8=;
  b=EZ9WIqS/+AT+RrlzbVuJPRIb+BUCewyl2l4CDHO83V9X3nWEuLHbqHAl
   mjnHdHD695trVYR7vEcXJuxaVo62l9taiU1PdwiceT55QNltiqq0/XYM0
   KVxrfgKq27YzmYKF0BT2JKC1qyaUDn+jb4g4Bxrc3VMKYwkCHkFSINIL3
   DrsdkYt7AGhjCVGVGhNSIUmN5Y2ENJkkkB3EmlRe+dZPk26hK4sdtOxsR
   Dcy+2V8fHkCZdFcQ5jqSaO7kwJY3YlksyW0KztkqcDcZOKWV1s8pUVkVq
   WB4M+eBFgk26cTv4BNOrNPPr9WFwKk087EM9uvAkS7OmrFF12yksmE/NV
   g==;
X-CSE-ConnectionGUID: OwHpe1v1S0yNRSa1YJeU8w==
X-CSE-MsgGUID: EfgbSvsBRNusSsKGsj55oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1711589"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1711589"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:06:35 -0700
X-CSE-ConnectionGUID: nRIAkb3pTtuBTTkh5CNl/Q==
X-CSE-MsgGUID: PPDbvwu5ReaVgoETcoBmiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4956127"
Received: from dev-150.igk.intel.com (HELO localhost) ([10.91.214.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:06:32 -0700
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
Subject: [PATCH v2 07/13] i40e: Drop VF MSI state restore from PF reset_done
Date: Tue, 27 Oct 2026 17:04:40 +0100
Message-ID: <20261027160446.858300-8-lukasz.laguna@intel.com>
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
index abbc71e815ae..da214c21bda3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -16550,9 +16550,6 @@ static void i40e_pci_error_reset_done(struct pci_dev *pdev)
 		return;
 
 	i40e_reset_and_rebuild(pf, false, false);
-#ifdef CONFIG_PCI_IOV
-	i40e_restore_all_vfs_msi_state(pdev);
-#endif /* CONFIG_PCI_IOV */
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 74b6c0ed8480..1e0bbf76d17f 100644
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

