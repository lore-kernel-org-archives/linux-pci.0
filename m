Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012052.outbound.protection.outlook.com [52.101.53.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CF85519BD;
	Fri, 16 Oct 2026 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167840; cv=fail; b=sOa0IEosb/i3oaMy2KkXlaVuCg4b833ScBSobmem9tePpjCmCIjT+B3Vg2uNet8JBgk+7WAl4sgum2YrJdmOykAh+Enrd+wUi+vYDqouiUL/rWpAyZvOtAb1OZnIq6CQ8/ShCle9Lj0deCNuXosan/XznX+MrxoBq3SiBBoJV6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167840; c=relaxed/simple;
	bh=4huXs+bk1DSj13HVfFl/WcnCYy4t8olSaUgWKFGOnLw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vuw9Sex74YTEtAF+m6V/zYOvz6fCVfo3aDLKUw0fSHUe+Um9dlAYbxzVPe3fbiakdofgEO35Ti7r1eXEojQI/l33P7TI3RTGxqbgXlg+ZTySOZVTp+peU6UlmrWOdHCh69boUOIVpX1ra2O3IQORtrQIJAA9wrzyVjuQQy3oEyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MYi9DXvU; arc=fail smtp.client-ip=52.101.53.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MYi9DXvU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXZ585+tuqjGKo1ZYrLBylfabznIdxjf5P6/Q9pY5i4Xe/9eH+jpp+06Ysy87zdzse7AtBqeqRU+ttscok4/qshHK8U444l/diiC1Oi8KPcuSWE4YkQ0oAWXb7t2G8Hp5RHuQ0NkaHwsOkDJUoiTfAmdT3iPHjD6bhKo6BeXAFWzFXOhAhoHH6iRGZO82bLwl9DKAun9vkfP/NZx5Z+1jE80AGbt6Zn+07PyyqhlHWWLcmPXE/6DLelBEs5MPZNuf8TpMFjM3D+zcEQJwfgA2j1vnJWdLCfI8Laut3iXFlStVnYQ1fGsdtTI3ix80FEv8WtB6nUU1Mo1ZrxeJ9lapw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYrVlgJkARi8rB5GR1kypw99eN6OesdjXDU0ocJpYAU=;
 b=cHXrdH2su70Wd5hpUHNL5org0fOTtipfmX53eT0U5BKXA90f/haqd7absuOxIx770khgHd8lBcnD0g9ZxZ7elUa9I2ER2FFa8IyH8muznzVe+VPdar/JzWAgWHaWA7TsQo0SNYo2S5Gtdf7yD+sRlnxOB3grWqEWuO3AviBXGDIi1cKxmA8Sfa5BbZ8yMN7jci5o8JaAfMH+UiskxHEOuQl0cucHPIYonDaXgpQtoyr3+xmTpAACVY20rpk8nAXbdBiJK/ROsNHkvOr+wGNhz2shRYZgdIQkXl7H5jkfGipCebDsWDwcNHO0Xr8MD/XIMqEPCKa8JQuh9L4my5dAxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYrVlgJkARi8rB5GR1kypw99eN6OesdjXDU0ocJpYAU=;
 b=MYi9DXvUL+n4YsWlZP7Z/x4qCYTXtF9jq3Sl0eMDON4O0P1izwNyerjAgVu2N4j9Ir1+f2K28m9OVU1l7k1yttpz2ibp4fr/vgc0xFD5V+Hxd5R9VhKcoVrh0ICWxgp2Ae+Tx10IpovKn2qmvzHrtwEFY1b4V5I4Skc9mtVCYuR/CURQFJlbT6+2CMhj3gLK9Yz9nhgi0X5PwnQur1jiqLhF77qB+5UJHw5ZKaMnrXg9Ds9g8iNj7HxlWBciThuKppUhPV5zXjKkwbQ8BSnB9EFE52+U2naw0N7hF8Y6oWcKwUnWCNNMEIUhphku6pdDWS7HZqflO3d40OxXEDV9gg==
Received: from DS7PR03CA0283.namprd03.prod.outlook.com (2603:10b6:5:3ad::18)
 by DS4PR12MB9820.namprd12.prod.outlook.com (2603:10b6:8:2a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Fri, 16 Oct
 2026 16:23:50 +0000
Received: from DM3PEPF000265B0.namprd02.prod.outlook.com
 (2603:10b6:5:3ad:cafe::92) by DS7PR03CA0283.outlook.office365.com
 (2603:10b6:5:3ad::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 16
 Oct 2026 16:23:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM3PEPF000265B0.mail.protection.outlook.com (10.167.23.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 16:23:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 09:23:22 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 09:23:13 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <ankita@nvidia.com>,
	<jic23@kernel.org>, <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
	<smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
	<yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
	<bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
	<gustavoars@kernel.org>
CC: <cjia@nvidia.com>, <kjaju@nvidia.com>, <vsethi@nvidia.com>,
	<zhiw@nvidia.com>, <mhonap@nvidia.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: [PATCH v6 29/31] vfio/cxl: Run the CXL reset at the vfio reset points
Date: Fri, 16 Oct 2026 21:48:36 +0530
Message-ID: <20261016161839.2765592-30-mhonap@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016161839.2765592-1-mhonap@nvidia.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265B0:EE_|DS4PR12MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: f0316515-74bf-4a3d-b382-08df2ba1dcfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|7416014|376014|1800799024|22082099003|10067099003|18002099003|921020|261009223027099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	sydpulPzEZ/3Rj23VYAluE06uXT0OGE1dWDgFysDOrdl4sz3rAYU469EXZ2PpN5/vfDxrQZyZgmKCmEkzwKS+X8YE5FsMSk7J+OjNOvRW7m+JFgGGSolyiu5Zm9LiYu25hYzMvTFy/6GY4A0jGMvdBdstYd5weuw9Zf4I4rK6ygcYOPW8v/vkd0cHAwqZ0Gx4a4J1CxvO72xuUiPoz+1/53K6H4fAd8zBrx+VnH64XV5RcQxYJ3g5GsThGuVTu4sHsBkzCisZch36hb3/hUmE+ybu07403Sz1k426KcLbGFKQgOXsRI9Lrc30Hp3e/7ZpY5WyQnueILyR6LLcG1ZyGRyams4i3H061jOlQzznD8Y3NDit1B5TP+gJu7eJx2x2ODXY30frN/Lje+0IDnEW+DzTCQmYrD+Hg8AVLX4T89Ijg02e+uXz/c+Ao5hgnDq2pQlxMc0a19lsl8vsEAGZPnNxnC7WIz0x68EoHePb9XyyzyskjnIwVM3eTtLecP0VlrYbDWqcJaXRmUvKKN1BmDZba8VE8rkIReoEOcfbfAjxo4hQIShns+vEWyKga1cdgietp8chisd1NS6JO80ipzXITfCfAr26YhTyuhfifZxAMPV7q+aeS9XqTt/A8iIhjg3Ge0Qmqnl15AE6YTZio4QqEq06C+rQSDtoLuRPhIst0Aza+UuQqeD3ilgrQ5oWrD7++Qg3tw/2n7in/xuPqMbzs5ucapfpgv5o13Fv8rs9DVWmXbDnNlm0xiTOP6d
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(7416014)(376014)(1800799024)(22082099003)(10067099003)(18002099003)(921020)(261009223027099003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rTVuhloOcnRGdXvXNTuHZEVpu0VnmXEmFLrsw4DX4zPc6rlqPcGF18EjPAaEuWgbFgq2fXNW1xQ3CQJzRUJcLisLFnwpwwtfqHZVgVn0lOeMlUTozhH+TJYC35uhNOi53mQPMnNIfwcEV3A8WTUYWqB6PsV865/mKdEFEs72jzK75bIhQETzldds92MCN7hlJtqSl9srZCm8hEofGPt38Ha0VCITD4xj1XjLIMnRZCdzsKdpxiJJBBZU1kZIZzmAUhmrlzNsrmSNbGegcCFopcyiMSTsFCgNsxN6IwOzl89ya7PIuPphR0WiaVwhoga8Yd/ZTGhMaqDKS15pjme8RLl9+P0H1/QkU4uGBaJGslpzzgiLplNSKuMSpcEOl4id/EJtxrg8NW6OLak7hM25rK5HEGZ5Oln33M5Bbkme+DKL7Oaf7kmS0qsTm66AVXjR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:23:50.5677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0316515-74bf-4a3d-b382-08df2ba1dcfa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265B0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9820

From: Manish Honap <mhonap@nvidia.com>

A CXL Type-2 function must not take an FLR in place of CXL Reset: an FLR
leaves CXL.cache and CXL.mem state, the CXL DVSEC and the HDM contents
untouched (CXL r4.0 sec 9.5), so device memory and cache would carry one
user's data to the next. CXL Reset resets that state as well (sec 9.7).
The PCI core orders cxl_reset ahead of flr in pci_reset_fn_methods[],
but falls through to FLR when cxl_reset returns -ENOTTY.

vfio-pci-core routes its reset points through the provider reset op. In
vfio-cxl that op runs pci_cxl_reset_owned() with the HDM range claim.
The reset resets the function, clearing or randomizing volatile device
memory, and restores the HDM decoder and PCI config state, so it is a
complete replacement for pci_try_reset_function() on a CXL device. The
op runs with memory_lock and the PCI device lock held.

Take the HDM memory region out of use for the duration of the reset, so
a fault cannot insert a PFN into a decoder that is being torn down, and
put it back only once the reset has restored the decoder and the device
reports its memory active again. After CXL Reset with Memory Clear the
device can keep Memory_Active clear for seconds (about 3 s on the device
this was tested on), and a host access to the HDM range in that window
raised an SError. A reset whose memory does not come back within the
Memory_Active_Timeout fails like any other. A failed reset
returns its error and leaves the region out of use until a later CXL
Reset succeeds. Neither a decoder restore after low power nor a hot
reset reopens it in between, since device memory may still hold data the
reset was meant to clear. If a failed reset left CXL.cache or CXL.mem
disabled in the DVSEC Control register, which makes cxl_reset refuse the
device, put back the Control value taken at bind before the next reset.
A failed reset leaves Memory Space disabled; clear vfio-pci-core's
record of it to match. AER recovery does not reopen HDM after a failed
CXL Reset either.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 82 ++++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index 518f0b093652..70794efd517b 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -38,6 +38,8 @@
  *	for Memory_Active before host access reopens after a reset or low power
  * @mem_region_index: vfio region index of the HDM memory region while open, else 0
  * @hdm_open_at_prepare: @hdm_valid as reset_prepare found it; under memory_lock
+ * @hdm_needs_reset: a CXL Reset failed, so only a CXL Reset that succeeds
+ *	reopens host access; under memory_lock
  */
 struct vfio_cxl_state {
 	struct cxl_dev_state cxlds;
@@ -52,6 +54,7 @@ struct vfio_cxl_state {
 	bool await_mem_active;
 	unsigned int mem_region_index;
 	bool hdm_open_at_prepare;
+	bool hdm_needs_reset;
 };
 
 static unsigned long vfio_cxl_mem_pgoff(struct vm_area_struct *vma,
@@ -827,17 +830,75 @@ static void vfio_cxl_sync_mem_enable(struct vfio_pci_core_device *vdev)
 }
 
 /*
- * vfio-cxl holds the HDM range, so the PCI core's cxl_reset method would
- * fail to request it. Run the same CXL Reset with that claim.
+ * cxl_reset refuses a device whose CXL DVSEC Control has Cache_Enable or
+ * Mem_Enable clear (-ENOTTY). A CXL Reset that failed after the device reset
+ * may leave Control at its reset value, so every later reset would refuse and
+ * host access would never reopen. Put back the Control value taken at bind,
+ * when pci_cxl_reset_capable() required both enables, before the reset.
+ */
+static void vfio_cxl_restore_dvsec_ctrl(struct vfio_pci_core_device *vdev)
+{
+	const u16 enables = PCI_DVSEC_CXL_CACHE_ENABLE | PCI_DVSEC_CXL_MEM_ENABLE;
+	const struct cxl_hdm_info *hdm = vdev->cxl->hdm;
+	struct pci_dev *pdev = vdev->pdev;
+	u16 ctrl;
+
+	if (!hdm->dvsec_ctrl_valid || (hdm->dvsec_ctrl & enables) != enables)
+		return;
+
+	if (pci_read_config_word(pdev, hdm->dvsec + PCI_DVSEC_CXL_CTRL, &ctrl) ||
+	    PCI_POSSIBLE_ERROR(ctrl) || (ctrl & enables) == enables)
+		return;
+
+	pci_warn(pdev, "vfio-cxl: restoring CXL DVSEC control %#06x (was %#06x)\n",
+		 hdm->dvsec_ctrl, ctrl);
+	pci_write_config_word(pdev, hdm->dvsec + PCI_DVSEC_CXL_CTRL,
+			      hdm->dvsec_ctrl);
+}
+
+/*
+ * Run CXL Reset in place of a PCI function reset. An FLR leaves CXL.mem
+ * state and HDM contents intact (CXL r4.0 sec 9.5), so the vfio reset points
+ * route here. The reset clears or randomizes volatile device memory and
+ * restores the HDM decoder. The caller holds memory_lock and the PCI device
+ * lock. vfio-cxl holds the HDM range, so the PCI core's cxl_reset method
+ * would fail to request it; run the same CXL Reset with that claim.
  */
 static int vfio_cxl_reset(struct vfio_pci_core_device *vdev)
 {
+	struct pci_dev *pdev = vdev->pdev;
+	int ret;
+
+	/* Host CPU access to the HDM range is unsafe until the decoder is back. */
+	vfio_cxl_revoke_hdm(vdev);
+
+	/* Only after a failure: see vfio_cxl_restore_dvsec_ctrl(). */
+	if (vdev->cxl->hdm_needs_reset)
+		vfio_cxl_restore_dvsec_ctrl(vdev);
+
 	/*
 	 * The reset restores PCI state from the saved copy. The caller provides
 	 * it: the try-reset helper saves the current state, and the close path
 	 * keeps the open-time state that vfio_pci_core_disable() loaded.
 	 */
-	return pci_cxl_reset_owned(vdev->pdev, vdev->cxl->hpa_res);
+	ret = pci_cxl_reset_owned(pdev, vdev->cxl->hpa_res);
+	if (!ret)
+		ret = vfio_cxl_await_mem_active(vdev);
+	if (ret) {
+		/*
+		 * Device memory may hold data the reset was meant to clear. Only
+		 * a later CXL Reset that succeeds reopens host access; a decoder
+		 * restore alone does not.
+		 */
+		vdev->cxl->hdm_needs_reset = true;
+		vfio_cxl_sync_mem_enable(vdev);
+		return ret;
+	}
+
+	vdev->cxl->hdm_needs_reset = false;
+	vfio_cxl_rearm_hdm(vdev);
+
+	return 0;
 }
 
 /*
@@ -881,6 +942,10 @@ static void vfio_cxl_power_up(struct vfio_pci_core_device *vdev)
 
 	lockdep_assert_held_write(&vdev->memory_lock);
 
+	/* After a failed CXL Reset, only a CXL Reset reopens host access. */
+	if (cxl->hdm_needs_reset)
+		return;
+
 	/*
 	 * A D3 request that failed, or a quirk that kept the device in D0,
 	 * lost nothing: reopen without decommitting and recommitting.
@@ -984,6 +1049,10 @@ static int vfio_cxl_reset_done(struct vfio_pci_core_device *vdev)
 		return 0;
 	}
 
+	/* After a failed CXL Reset, only a CXL Reset reopens host access. */
+	if (cxl->hdm_needs_reset)
+		return 0;
+
 	ret = vfio_cxl_await_mem_active(vdev);
 	if (ret)
 		return ret;
@@ -1007,8 +1076,11 @@ static void vfio_cxl_error_resume(struct vfio_pci_core_device *vdev)
 	if (pdev->current_state != PCI_D0)
 		return;
 
-	/* The region was closed before the error; keep it that way. */
-	if (!vdev->cxl->hdm_open_at_prepare)
+	/*
+	 * The region was closed before the error, or a CXL Reset failed while
+	 * recovery ran; keep it closed until a CXL Reset succeeds.
+	 */
+	if (!vdev->cxl->hdm_open_at_prepare || vdev->cxl->hdm_needs_reset)
 		return;
 
 	if (!vfio_cxl_hdm_intact(vdev)) {
-- 
2.53.0

