Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117269;
	b=XoWmVH3pHbfV/dIPwZkkksFdDplTGvX/OQYiwOLxP2NMNOq3OdbXFiFYzDJ3+Cxn/Efu
	 fLhV0wxReTlpws5KuRgCuoAswi6/9erZ0dBqRvWdYc7P53ShZI07RtISPvBxqR6cH8lg2
	 W/GSXO69KcYk8zWNFY1i7OAmUtvNGtib7+YfoHgpN/EQQzL7usS4F3W1fVE3hQv0U2IhA
	 lebTjRgCcLe+e1woq3vToukU+fCbxaVTcAF1PLa/Rk1XrcZdh2UTkK4ZbYv4+g94/l+vP
	 Vg6Ycb/Sy/I27QLKmcPWu+5Ky9RISMqoyeBRL9R4IulPwAgbsPxTbL0t5Z0M5GbkmcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117269;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=t2ypmki+NdLAwHEXp6nV8Y7wYHze1EL2gfFZJkvk+UM=;
	b=C7Jnt2d1AzpMXhbHOPq/GV9vWbWwlAq6Pv8LysvmkvDiaVUhEOZ1udRK35I0aYYQgZtD
	 yleIjdy4QcIfBYgjSph7jvydAKGBQvl4SqUjB0kA3a4Rb6HkA5jPZd5uEgdKRA1lB4RdL
	 /545OxbKWmkk8/+qcSV1O+RcD2AVbudtSs+wmQvPfOLnvvJ2kQo6wdYCr17LvBANwPdlu
	 lmHkyiQrY3scCSV9FlOmlUO8RzHHgUb5O8RsAMyeY3QoRiYb2nb9jhvwRkj8kafAs75tP
	 ymkCLawdzXpDK1gpwhMpxKY2TYPKDFdmx7JNwYGm2fcVvOvjZdeg5p/Al3E4A9CJR0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cndSzhXa;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC07606A31D
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 16:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EC07606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cndSzhXa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793117269; x=1824653269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jXKgIYAAjCZ/8Pw0XBf9XfmjdDiqKgnKFtsm3cxbKPk=;
  b=cndSzhXaF82BiG/LINSRfqYLzZweiE0g1LUj8WYY1ZrUtS0FKZLLDzNC
   3ULwfdEkQdhKTYa7O1Ej6ViKr8kfRcoJQ5sRfmTUtXCDGfERxYoXo86Zc
   isLQHu89u0XoUKyS/fDhLrQjha6LU36SQl49LfU/dGjQubRjX7vlaNxXi
   wGfCI/bQ1I6eTbUGxLa/bJg7EtO0srdHMv2GVYESBHfDlAKmb/VvgQEcw
   djYKrPTdEMpXANJe6j54kRo+mcWgGBA6g6L06mVnm/6nwrGhCD/U/oFIb
   Kb3uuYKxSi9KMhED3x5i01hGRQVyriHUwI8QQAahAorj6R1tqfT/gfdU6
   A==;
X-CSE-ConnectionGUID: xYgp/R4fRCu1PKEs1SySSw==
X-CSE-MsgGUID: rCWz05kMSHe1X/FjlGo0Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1699764"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1699764"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:07:49 -0700
X-CSE-ConnectionGUID: G0Ws9bAZQOCKxnfzGmJUzA==
X-CSE-MsgGUID: 94HeuturRbOgGnp1Um77tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="6342552"
Received: from dev-150.igk.intel.com (HELO localhost) ([10.91.214.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:07:45 -0700
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
Subject: [PATCH v2 10/13] ixgbe: Use generic VF iterator
Date: Tue, 27 Oct 2026 17:04:43 +0100
Message-ID: <20261027160446.858300-11-lukasz.laguna@intel.com>
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

