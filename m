Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117279;
	b=BaGXQeHjod5THJtK0AOnLLgF11dbHLer6PEBH/o+iZHuNykozjoMnXPBPWVXUirl6BsK
	 MZ64jtZwBWmPQDQgmpDm9hO3bY4D05eFZ7wT02ohVSOYPHPDeGBz8q3Mz9wTAL+9nuyxT
	 0CGG4hSClGsTMzANMMfiMQZprBtO5EsXe6vHZQoyrt4fApFIi9e/QS67qZhsmlNbKubj5
	 vXjBUvsBw30Y4rmXtt2QURdivvsBYv40cn+YVn4FhcsPXEfaR3ma7hquoGnHGbXSWBwyc
	 djPwp4orHduy0OCq5iAWMX1xjsEGLFAUTiDZCZXFO7hw6FL9uhp3gqOydMHTjaqXxfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117279;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=v5uR4Z5kHSJcNS0UdZ0tMNPo3LYILfp4vjQ23uyOoJo=;
	b=NP1YVpKzGSIZmqa3BSiwHgHfSxx+NAs1xLP3L+XXLfIYyXTfN47qjQY/SCjLy3BmSDfo
	 a4wNbF3atKyt364ArGp0Ty6e+QIVGlj+4nWTxCWMi456FDaT89KHDlcYFweHYO6wmkmbG
	 Z3IbqJ9gdYtRmOy/L248cFGdj+4AM9OAVYDs+gBdl6EcNaO19sNIdZ3pAnsp7Cm43Yrs5
	 PPeAPN93ZMDl9WXMF2AEeH3VCgETwNpxJoo3MKWC8e/vFU66GJ6Zk850beMmYq9uZYMEI
	 hl4tYHgKOQQNuu9UbSIVDrIRB6kNtoiq7ihMvcHxbUe1fTSL08qUoFTKGJYD+9hDI2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CKf6R9XG;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB7C606A31D
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 16:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDB7C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CKf6R9XG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793117279; x=1824653279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DFF1a3y2zURxZG8SI0oGrTvFK4hHR26SKcevNxfqR1Q=;
  b=CKf6R9XGb/NAW9sCqNKqQJZkB0Z+HdcMisbbZohT67/N3+xonJ3T5lcb
   og0X3Ak0buvj1OgvtDN0cpH44e3G1TbaWKHBVDowGGqEM3EORLg0+cmlz
   jjHMBQRPtnHJiBFN+AKNbY1Xlmq9lMT795nRAJR/jYNZ74ngP6iZpxUxA
   FqxG3bIT+uN03vEXTsPS0/ca8rl5yqxehDR59neBc1QmnsHRWwKYV3Ql1
   Up/+jVzQC6lLoe8GMLRYwPFPiRroc635dXgyzjX7cgnZmdlym1xiKoZx7
   vtMhtNMvxRpH6lyaoV61dHecQTLem1gfnsD7GT2RZyGtMarXj0qNlFvnA
   g==;
X-CSE-ConnectionGUID: SQCA6CytSgyQwHmToZJNMA==
X-CSE-MsgGUID: Bpne/jf7Rwa0CajN4r9fwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1809175"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1809175"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:07:59 -0700
X-CSE-ConnectionGUID: mXZnnI/cRD21fcP7Djh/5Q==
X-CSE-MsgGUID: UvBX6bDtR9+1CmeED/tozg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4982198"
Received: from dev-150.igk.intel.com (HELO localhost) ([10.91.214.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:07:55 -0700
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
Subject: [PATCH v2 12/13] liquidio: Use pci_iov_get_virtfn()
Date: Tue, 27 Oct 2026 17:04:45 +0100
Message-ID: <20261027160446.858300-13-lukasz.laguna@intel.com>
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

lio_vf_pci_dev_by_qno() finds the VF by walking PCI devices with the
CN23XX VF device ID and checking that they belong to the PF and match
the VF ID. Replace it with pci_iov_get_virtfn(), which looks up the VF
directly by its VF ID.

Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>
---
 drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c b/drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c
index 697fcdc41e3c..58f25ddd2f6d 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c
@@ -28,7 +28,6 @@
 
 static struct pci_dev *lio_vf_pci_dev_by_qno(struct octeon_device *oct, u32 q_no)
 {
-	struct pci_dev *vfdev = NULL;
 	int vfidx;
 
 	if (!oct->sriov_info.rings_per_vf)
@@ -41,14 +40,7 @@ static struct pci_dev *lio_vf_pci_dev_by_qno(struct octeon_device *oct, u32 q_no
 	if (vfidx >= oct->sriov_info.num_vfs_alloced)
 		return NULL;
 
-	while ((vfdev = pci_get_device(PCI_VENDOR_ID_CAVIUM,
-				       OCTEON_CN23XX_VF_VID, vfdev))) {
-		if (pci_physfn(vfdev) && pci_physfn(vfdev) == oct->pci_dev &&
-		    pci_iov_vf_id(vfdev) == vfidx)
-			return vfdev;
-	}
-
-	return NULL;
+	return pci_iov_get_virtfn(oct->pci_dev, vfidx);
 }
 
 /**
-- 
2.43.0

