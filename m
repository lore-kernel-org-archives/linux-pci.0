Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8473DA5AA
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 08:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399105; cv=none; b=VkrEmGxctHiUS6pVZq5xHHmPrn5mpOKBVEoY0qIFDCw8YuCgvQ0LAH47obUVPDOk3KfE0fPYInHM/OPny/bGYsbb29m0QJ2/9TmwGc8D6dDBh5KTGd/J+kjTmIYqfnWbqsG7ftpLwdqpg+kPoM+2G+w6wL04da796EXybAAOgtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399105; c=relaxed/simple;
	bh=DFF1a3y2zURxZG8SI0oGrTvFK4hHR26SKcevNxfqR1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6wbRjfipsLLjwBb9N0dziBPX7vSKavC6h68b7YQKOD0fdaz8lwkFY7bmyOL6wxhg9Dr1jRybyh3oW8C24kYCPs+9BnLrfInWO+LNvXO2ily+nAHHKxVMQFyvNTVOVfS1hOO7k65GQPF7QxoVPG5D85G26fYF+/FrdqZrRy74pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZclMnjQj; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZclMnjQj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792399104; x=1823935104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DFF1a3y2zURxZG8SI0oGrTvFK4hHR26SKcevNxfqR1Q=;
  b=ZclMnjQjRu9WczVGIvfPLqbVz87vvRKoTWnzyZMJ0VpG4qVJTjGCeC5+
   gCI+1CeJLdGUPzME6MBtZI7VedGJ2KsKZKW9M/9TrMXvpAtU0MywAXP6j
   lCRPZdm7798IXR9MSCWHGUdsvDbYUIqcm88G/kO+8cYHG1pTWl8z57LnJ
   YzC1i/nUO8b1Y7zsgeoTpfIp2gbI9q7OaU2v/Yta9CaOd44G/W7Qqd17F
   9LvdspodoKHzW6ELaObHdmmZS2eXKF77e2iz3Xy/u/oLJPa9JfvDgpc+p
   bQFwE2KbssRjnSk3PVIrdeYLv2c4lR73E1iKKPpAle0DWHRGsVEb9ibeD
   w==;
X-CSE-ConnectionGUID: Vo5MjW71S2GVgdAu7O8qVA==
X-CSE-MsgGUID: WPFzo6/oSeGziwEZ7iCpVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="978985"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="978985"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:38:23 -0700
X-CSE-ConnectionGUID: OS3tKtlETkGmBed841tZWg==
X-CSE-MsgGUID: ofjPYTuIT1Ol1ryhTeusMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="4325198"
Received: from dev-150.igk.intel.com (HELO localhost) ([10.91.214.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:38:21 -0700
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
Subject: [PATCH v1 12/13] liquidio: Use pci_iov_get_virtfn()
Date: Mon, 19 Oct 2026 10:35:13 +0200
Message-ID: <20261019083514.838640-13-lukasz.laguna@intel.com>
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

