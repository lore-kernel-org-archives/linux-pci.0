Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117282;
	b=od3WXVHb5R2dPe2Z5KT5T8lBtrijXIFfbIsPlNo5k5zrx0m/iLQ8L4xzLwt2dkfjQOTg
	 9rqa4juOrKwPfN++kp2py6hzrzKcC9RG9PEfUyfsa0OkWXYSYvHy5DzGwygfTOmQ855dQ
	 3p2oxWb+h5kUVwj33BPymdVbkXXKorZJVBTf8l+RRqrcNpgBDGkJfTYKQQRudxhavO5dy
	 pJrF1DntRpoYaBKYiTuuuFRRbDcC1vwDGBHDwImQA6Lg4AlQTjHDTzDEC3uszI1Wdp62B
	 4pU3EiHoElbYqbp7qJOXhLOX6qJHB2pZlh2Ofw0jcQfE2oNPtA6ZWtGus8w4MdDk82A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117282;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mfLPrkxSXOT9Qzdp8kSwc23ZitYzs93Xw5g1oZFnxV8=;
	b=yltzH2Tj5lSRsVPvKtMrQdXR33/MRu0e1tNgvoc+6ZZDWsPecgg1U6Vsni/JZWndDjDf
	 rLLnizbpJh7uAmRV/LP5Mkeg3WnMaowVSECB2YUnXEOgdtdQ3SfamVY9QMI+53nyB+x4+
	 x+UPK02HLTDlUXT/1WH9mV+tzyP0zVEs9Jc0pT0E40H458K2HZQbCodjbJMBbFD8yZhYu
	 y1mGy8a+9Vrne4V0MUQoAKTvVOj8cyF2wqG6hZsDArrbfoFvsRTmq/8sQiqPzUtyIOh5i
	 sOTQiS7fCQQ1azoftOlUc2PuaKfuRCjhC5wjjsIpAjOUnlEOTDl0n8HLKhKzyv4FUTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GJ1sYGqz;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF80606A31B
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 16:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BF80606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GJ1sYGqz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793117282; x=1824653282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eT16HeadQGcPbnz43jM/ZZabcXLE7BzYbxj7kIOQnTo=;
  b=GJ1sYGqz0peB5LfWGAlUvsv0pLtPa1BkrJKSnKZXE1VpwQPbsUcHmQdm
   O1CH9Tui1a1HHDLjHkcusOmCN2hU6UnbV/aN92f2NCiYF5KDwmYRjLagr
   EG5kBRoVTy5A8l7W4XBNR9z2nVzm2FyFzm561/mFm02d1OhOC4+GYvnlO
   8WKJvUPdByu1sdMWZ8YZJ9gpImTlRrhdlhWfsgFYvgIO1BuspMPQLXa0j
   TK+pDpbolld1fdIpH7Z8ESA0b0oFwD2dfd/oIHy+m46UqYS+uAZ4SCNiH
   3f0RIugcQcCaFNXvhjfKscXDafC2oi7TIp7SwEjwgNtYYFsToM7lek1Mc
   A==;
X-CSE-ConnectionGUID: W7FVsJgoRg2lH0xNttLQ0Q==
X-CSE-MsgGUID: e/ktlZhBQk+9qxGOjdkjQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1809193"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1809193"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:08:02 -0700
X-CSE-ConnectionGUID: Mr5xac2FT++mz1ZLSUfmkQ==
X-CSE-MsgGUID: 9PKukz3tSB2o8/rqpeLl/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4982210"
Received: from dev-150.igk.intel.com (HELO localhost) ([10.91.214.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:07:59 -0700
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
Subject: [PATCH v2 13/13] drm/xe/pf: Use pci_iov_get_virtfn()
Date: Tue, 27 Oct 2026 17:04:46 +0100
Message-ID: <20261027160446.858300-14-lukasz.laguna@intel.com>
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

xe_pci_sriov_get_vf_pdev() implements its own VF lookup. Replace it with
pci_iov_get_virtfn(), which also takes the VF's bus number into account.
Previously, the VF was assumed to be on the PF's bus, which is not always
true.

Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>
---
 drivers/gpu/drm/xe/xe_pci_sriov.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pci_sriov.c b/drivers/gpu/drm/xe/xe_pci_sriov.c
index 31abcee55211..36d5ff27a2c2 100644
--- a/drivers/gpu/drm/xe/xe_pci_sriov.c
+++ b/drivers/gpu/drm/xe/xe_pci_sriov.c
@@ -274,7 +274,5 @@ struct pci_dev *xe_pci_sriov_get_vf_pdev(struct pci_dev *pdev, unsigned int vfid
 	xe_assert(xe, vfid);
 	xe_assert(xe, vfid <= pci_sriov_get_totalvfs(pdev));
 
-	return pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
-					   pdev->bus->number,
-					   pci_iov_virtfn_devfn(pdev, vfid - 1));
+	return pci_iov_get_virtfn(pdev, vfid - 1);
 }
-- 
2.43.0

