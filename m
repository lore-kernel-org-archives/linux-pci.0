Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48403F7AAC
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 08:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399096; cv=none; b=PQ37TY//Qw5Q/O+Ib0yPZoeFaonh7cQmOCxMtYa0fZKB+8B0BnGyqSLmzWofBhUfqFb1tekG24UpPh+3pxtI/aLAMqjTIoqd89xmfLD+wdIB8FypnpDYOiaavAMJDQlvbEWjiPf2d/h3BHc99z94TrsIPtDF/ucG/tOP6e6n2Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399096; c=relaxed/simple;
	bh=jXKgIYAAjCZ/8Pw0XBf9XfmjdDiqKgnKFtsm3cxbKPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYFZyQ32anYBVqX3bHyBEaJJtQKLX3J2Mz7Qqr5apCTy/BTVjbyza5q45kYAql1O7Smgqr2LfgE3f5fLtrZgi1ckE5rcMhvpjnwFkiIaNwkI6gJk5JyPwRZsGZaGozedaD7lvAgldayaRQCk5bZ6hRu1tn68CDQFPiMcDxlOBT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uv75zxVH; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uv75zxVH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792399095; x=1823935095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jXKgIYAAjCZ/8Pw0XBf9XfmjdDiqKgnKFtsm3cxbKPk=;
  b=Uv75zxVHdYJpxY6awmDKBe23H7KGfEI2KGWRZGJDmRRvAsPlyc2Khaid
   0KkzN29Qf8W9x1s6uD7PEY6/OeHXRcpD+rdsOB8doJ9+sbc7v4ifHRT74
   momSF/HuXNL+A5rvOXf7lYWphpLhJLW/W6POJ1U56uPq5oq+MBUA9GpDu
   O0iksM1lEW9i+Q7/gz5Z+k9OOVhCBCk4yO0vFm3tmKUU+rdU13pecghmb
   s0hiPv9Q1AXbHvz5OU1oHGvoRl4MkKUyuug/V+VMkI1tRQ05sox+dFqpu
   qAZgkCpt5TYZMUBSmdLItTYKghS3IzISOtgg+tYNoWQKKGdSkhYslHJ3j
   g==;
X-CSE-ConnectionGUID: z3PWY/+iSYqg66+1CW/ZPw==
X-CSE-MsgGUID: SvEzM9AwRa6wgT+LLZlLCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="975049"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="975049"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:38:14 -0700
X-CSE-ConnectionGUID: I8w08hzLSU6PP7L6fmI88A==
X-CSE-MsgGUID: FIsRUQFFR7mmWU5Pjf+DSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="4261982"
Received: from dev-150.igk.intel.com (HELO localhost) ([10.91.214.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:38:12 -0700
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
Subject: [PATCH v1 10/13] ixgbe: Use generic VF iterator
Date: Mon, 19 Oct 2026 10:35:11 +0200
Message-ID: <20261019083514.838640-11-lukasz.laguna@intel.com>
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

ixgbe_get_vfs() finds the VFs by walking PCI devices with the VF device
ID and checking that they belong to the PF. Replace it with
for_each_pci_vf(), which iterates over the PF's VFs directly in VF ID
order.

Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>
---
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    | 25 +++++--------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 431d77da15a5..67e22dc514f8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -123,28 +123,15 @@ static int __ixgbe_enable_sriov(struct ixgbe_adapter *adapter,
 static void ixgbe_get_vfs(struct ixgbe_adapter *adapter)
 {
 	struct pci_dev *pdev = adapter->pdev;
-	u16 vendor = pdev->vendor;
 	struct pci_dev *vfdev;
 	int vf = 0;
-	u16 vf_id;
-	int pos;
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
-	if (!pos)
-		return;
-	pci_read_config_word(pdev, pos + PCI_SRIOV_VF_DID, &vf_id);
-
-	vfdev = pci_get_device(vendor, vf_id, NULL);
-	for (; vfdev; vfdev = pci_get_device(vendor, vf_id, vfdev)) {
-		if (!vfdev->is_virtfn)
-			continue;
-		if (vfdev->physfn != pdev)
-			continue;
-		if (vf >= adapter->num_vfs)
-			continue;
-		pci_dev_get(vfdev);
-		adapter->vfinfo[vf].vfdev = vfdev;
-		++vf;
+	for_each_pci_vf(pdev, vfdev) {
+		if (vf >= adapter->num_vfs) {
+			pci_dev_put(vfdev);
+			break;
+		}
+		adapter->vfinfo[vf++].vfdev = pci_dev_get(vfdev);
 	}
 }
 
-- 
2.43.0

