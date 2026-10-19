Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FA53128DF
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 08:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399109; cv=none; b=FEdaY8//7EwpEgzn0TzHmFzZ7rFLAO2B3jAhtXnq0IaMVmPvXzga3BIylYClsAIfvI7m/pAi9E6jE+CKBl+coD4bLPf0Y/1/60A1rEzemKqx1xohmhmi7HXmgGvkQkKr5D5QDY8X/H6b9Aj2R0ALI66hX/joN7gzGIOrKYbozyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399109; c=relaxed/simple;
	bh=1mtYBNXjl2xAnBJX4iGqCWTtX5I7r0URmIqn8O5ienM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WpjrVW4vYExFXbTQKHpKAzL49PjK2fhb9MDwz1ThpumMJHE4KqAeGp4A6iGhoMtyjJRmrmtqSraF8R4FUfr03zQqSWxnnXGGZLHM2NpMpi3Hu/fzdAKQhlTpx38Oix2yVastY+A3EX1JsMEwz+twlfWsYiF6DajHqBIKSmue5GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vxr1FVs5; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vxr1FVs5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792399108; x=1823935108;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1mtYBNXjl2xAnBJX4iGqCWTtX5I7r0URmIqn8O5ienM=;
  b=Vxr1FVs5l61yagiCy1skJKzAeAuvxkSh5FT9e+WO1YKYv5ebLRThjdBW
   6MismLyfQxRus5RmOskjkM4tTnEAiUETyZwCwvYIjARxDRx8Vv74AO2p6
   9BSnWtG2MFln5UnZuRL8pvKlkptHXGSy3NzwKQDtrvnhSN7iXV5Dzc4z/
   Hx+K3AlHr+t7f04GcBDqbRN+JwGtipChRzpjoM7G012eEW3i0drog4YHj
   668wvnCM/3PTf7+n+88qCYtn2LGE/tT/R3LiXriEXiKxWSUexjxmsIZpl
   Z177U/hsHYDz7euLNoVTzypIBPnhiBYt8Tfjrc2J3Rs3455oZoRLowcpt
   g==;
X-CSE-ConnectionGUID: zQfO8dHkSKyOOcZk1TpPIg==
X-CSE-MsgGUID: xShRTzB8SbiTJGCz0PBQOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="978997"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="978997"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:38:28 -0700
X-CSE-ConnectionGUID: bV6Paw3gQOycg088Y+xZhg==
X-CSE-MsgGUID: zxr+tof0S1iDFW+4YZq4Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="4325208"
Received: from dev-150.igk.intel.com (HELO localhost) ([10.91.214.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:38:25 -0700
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
Subject: [PATCH v1 13/13] drm/xe/pf: Use pci_iov_get_virtfn()
Date: Mon, 19 Oct 2026 10:35:14 +0200
Message-ID: <20261019083514.838640-14-lukasz.laguna@intel.com>
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

xe_pci_sriov_get_vf_pdev() implements its own VF lookup. Replace it with
pci_iov_get_virtfn(), which also takes the VF's bus number into account.
Previously, the VF was assumed to be on the PF's bus, which is not always
true.

Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>
---
 drivers/gpu/drm/xe/xe_pci_sriov.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pci_sriov.c b/drivers/gpu/drm/xe/xe_pci_sriov.c
index 35e6b53e18ce..d5a4e95b3ffb 100644
--- a/drivers/gpu/drm/xe/xe_pci_sriov.c
+++ b/drivers/gpu/drm/xe/xe_pci_sriov.c
@@ -258,7 +258,5 @@ struct pci_dev *xe_pci_sriov_get_vf_pdev(struct pci_dev *pdev, unsigned int vfid
 	xe_assert(xe, vfid);
 	xe_assert(xe, vfid <= pci_sriov_get_totalvfs(pdev));
 
-	return pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
-					   pdev->bus->number,
-					   pci_iov_virtfn_devfn(pdev, vfid - 1));
+	return pci_iov_get_virtfn(pdev, vfid - 1);
 }
-- 
2.43.0

