Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117275;
	b=gfwBBI3MawOPljn5N1//FTPNLO+FfbSe9elmhmPw4vryk+MC9O+d4TnaNtyuMK/tYGd6
	 Vam/dfCHWUrPVXnYgX9amzmXp7cOFwOqYAbc9iGGJhIK5Nb4aOtInon0uPiKvZBF57uiT
	 atLZwbqRkwRn0n4ytIvNu8Phc2D3pPrMmrkZiJJFYjNV76TgU+jj6Sbj24DyLey+KaFOW
	 Let8CJhK+xVFE4BoHQaZ3jcI4EMN8s6kxZ80TpCqtNX2osl66RvRUQ0Klh+fo67x+L1yS
	 +4OblnCzY5ykstod4nmMhbeXRDufSbrNtjAWCvcujQ2JxOkcwHNoxJvhVYI01h5MLGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117275;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=55R+d3YbC3w7yAObcs10KHpiOS1s4eFHRWwAxdDGaog=;
	b=HATZ0DPWaWbxtQWNzXPlqmxqAF3hWU5j7vNyOnBPe/+G3c2VUcyg4/sBI9+Sc+Eir68e
	 NQxZQdP5A1b7FzPmebg6vNG0tYAw5EPtKSlwz62nrbU5pcSwRVQk454H/pRGrF9eMpQA1
	 4Ux6GZwJC2x6ZRfTwZRsdrFoSh6J+rZgvxflIO9XPK/f7q153TKpX5A4nOJoSF+Ng8aN7
	 f5/41bum5v9nVg/qFqPEeMSiakW+sv0LKBC6QTrQlIEBa4skfV5VGHpIPf0X3A5y6JrhB
	 hkrWoVUU7X0ueqDQNeBmSqrkiAQHWo5upXKft5KxQ9eX1lLGp+JGKS3zsnsfKrtRKMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jIJmQjvr;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE79606A31B
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 16:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AE79606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jIJmQjvr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793117274; x=1824653274;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gVwGeC9+7Ef9ces3jnUbyw0790zCU+uCMm7FgQ2r7tU=;
  b=jIJmQjvrEUL6zxIBmNNWOYvYQG7mNpK8zFB9tHeO6IuCn0GO7RbuO49V
   mJfe1RGgd0jaIlvMj7YY7mlnpS4TbdiFt1OuwYYbM7eXIdzzj1y8uN41r
   O6nF/aTd7bxJFUYlVw8jzCkQtpAvLFC1Bje7UJyWbtuabqKTw0Ffi4/ve
   PugWPM48Lydi/5zBG2dG/+Rw3OX6s46NOE7CZ0AM+UGtogh5pqppNNzn5
   eUcf+hCxICH+/aHtUJTdrVLha33AjaCuYxEBqXPL4deh1oLISBrk7r5+t
   o+a6V5KXho8v7WFYUkBUtrC1YkdRt75n9eN0HeYojSCV604901gBT6RKx
   w==;
X-CSE-ConnectionGUID: gzRs+x/lSt6WayB++ZbOsg==
X-CSE-MsgGUID: ROpZE/kvQr6s3Lpjc1l9EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1809166"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1809166"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:07:53 -0700
X-CSE-ConnectionGUID: ETYj7OiVTbaBb1tkfldAtA==
X-CSE-MsgGUID: yhzv0W9QSlSUgEL1W2HLFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4982190"
Received: from dev-150.igk.intel.com (HELO localhost) ([10.91.214.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:07:50 -0700
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
Subject: [PATCH v2 11/13] ice: Use pci_iov_get_virtfn()
Date: Tue, 27 Oct 2026 17:04:44 +0100
Message-ID: <20261027160446.858300-12-lukasz.laguna@intel.com>
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
index c49f48b5ae38..549991fbe712 100644
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

