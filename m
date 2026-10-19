Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049AA3F7AAC
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 08:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399100; cv=none; b=m7Fc9j7VObI3k2E6+PSB0N3ea/s0+A+ZQSZ+/8KRxwX+OPkwdE9SgUdtc0DiAcaXR8yPVo62c5oLZjGlM6DUU2YWIzhV0u1QBK2LQmbHam9g5B2bCuetPyW++RGER+wTiDkqoZVA4MJNkcn1jPB0jKe3wXQjeywt3Kg/Ua5Gacw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399100; c=relaxed/simple;
	bh=hr5JecPWNMoXIPNelZ0jvtYM3+JTou3HlbAO01mAwhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8inH6/ke6Og/TORUaF4Hajr3jtAMjNCS3O2+jmnZoayg4tep57efVQ5ADz/v1hPYcGPfH3h3K6hWsDlRGATgVpT5L0x6DVY5u0U7oqMSNnAugMpdHhabKpp9LkQm5LgHEkpc5tsFnJgGp+j3FkWGPBLW4oX7dwQ1KrIGQOtiqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fm83UcaL; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fm83UcaL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792399099; x=1823935099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hr5JecPWNMoXIPNelZ0jvtYM3+JTou3HlbAO01mAwhE=;
  b=Fm83UcaL7ynpZcEXbs2qYoybyNSpvYQjU4IPqfm+fw7AWgurq1zqx6WX
   luI9lduPd1IGD9uwEZVn2MnJQ6UaxCpzUOn+6lMHwsoAL6D5vfatQjZNs
   agYzGrl8oluEBmFNEXedrjITIk6zNo4gYQOGTmZFf2BDv0UJvp778RgpJ
   zWvQQ4EhCFFyNRLhfVE7WGLo7gRHY/8/emaacNFWKGxXtxRDHGkf2tRvL
   UiXcyZ64Q/hjRTeibWIYEi5xk3/yLV6WbRoyiI4RGaAtC26DxYjhnOggI
   ocBMWYv+HCH7B+/5b0o1XRtaHgZ76tWNmNvc2JBxf7cBM26N68eMRoOZR
   A==;
X-CSE-ConnectionGUID: 61pFyBRsQnirJXMkBiDE1g==
X-CSE-MsgGUID: puJlVByBR3WGH1OWw/Tn+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="975061"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="975061"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:38:19 -0700
X-CSE-ConnectionGUID: MYB/aw1GTrm3q47TA5jIMA==
X-CSE-MsgGUID: wyRLWah1TvSNvPiRZ0G7FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="4261996"
Received: from dev-150.igk.intel.com (HELO localhost) ([10.91.214.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:38:17 -0700
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
Subject: [PATCH v1 11/13] ice: Use pci_iov_get_virtfn()
Date: Mon, 19 Oct 2026 10:35:12 +0200
Message-ID: <20261019083514.838640-12-lukasz.laguna@intel.com>
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

ice_create_vf_entries() finds the VFs by walking PCI devices with the
VF device ID and checking that they belong to the PF. Replace it with
pci_iov_get_virtfn(), which looks up each VF directly by its VF ID.

This also avoids leaking the reference held by pci_get_device() when VF
entry allocation fails.

Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index e04de0215596..290f07fe2e55 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -686,16 +686,11 @@ static int ice_create_vf_entries(struct ice_pf *pf, u16 num_vfs)
 {
 	struct pci_dev *pdev = pf->pdev;
 	struct ice_vfs *vfs = &pf->vfs;
-	struct pci_dev *vfdev = NULL;
 	struct ice_vf *vf;
-	u16 vf_pdev_id;
-	int err, pos;
+	int err;
 
 	lockdep_assert_held(&vfs->table_lock);
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
-	pci_read_config_word(pdev, pos + PCI_SRIOV_VF_DID, &vf_pdev_id);
-
 	for (u16 vf_id = 0; vf_id < num_vfs; vf_id++) {
 		vf = kzalloc_obj(*vf);
 		if (!vf) {
@@ -712,23 +707,12 @@ static int ice_create_vf_entries(struct ice_pf *pf, u16 num_vfs)
 
 		ice_initialize_vf_entry(vf);
 
-		do {
-			vfdev = pci_get_device(pdev->vendor, vf_pdev_id, vfdev);
-		} while (vfdev && vfdev->physfn != pdev);
-		vf->vfdev = vfdev;
+		vf->vfdev = pci_iov_get_virtfn(pdev, vf_id);
 		vf->vf_sw_id = pf->first_sw;
 
-		pci_dev_get(vfdev);
-
 		hash_add_rcu(vfs->table, &vf->entry, vf_id);
 	}
 
-	/* Decrement of refcount done by pci_get_device() inside the loop does
-	 * not touch the last iteration's vfdev, so it has to be done manually
-	 * to balance pci_dev_get() added within the loop.
-	 */
-	pci_dev_put(vfdev);
-
 	return 0;
 
 err_free_entries:
-- 
2.43.0

