Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B714DE721;
	Wed, 16 Sep 2026 18:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584063; cv=fail; b=d2rXIhriPnkZ6PaAe6dccTaSIVZU1mQNViPcaUhAAU00ClmX0Tkcf6yGrncYwF2s8z3oLbWq4vB4KGRzXkpQ+hV0phO8lkJxhcC4bcE0Nlh7cHodx0fylMdgnOFkxZrazsPfkBaEu13JjkekH9T/M94XZ8lqb+0Q1A7jUMIpBhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584063; c=relaxed/simple;
	bh=h5Y6j2kaMT7E+W4EPZojTmPosVmjZKIhRUCgM14mPCE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jYr9R0OgOB7djDZQIOzHD3TA68mIxYMjr8NqK8+DLUlfYc2a46Msv8O6PJTmAIxKTqB59u+XxgEuEu7ndf2dkFL/x9a6tkzq21biW3ypXiYwzYXfeVTFlrGyn8hBvvs7JEc5BLtSLprcFzIk7ZG9SixVBEaIydEj65v16sYpin4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ijk58lP0; arc=fail smtp.client-ip=40.107.208.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ijk58lP0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjiMKa3jzR0YQnM5k3vH1MbrpaUQExW1X2ABFlv3RDhW1R4nV41BVOFRS5hjJlHiD8fkY7zYFZWEqmX+4xeyRCcvUXylgiZvZUrXyiWlPyUYlYdgin7/MH84MRvOp6YGIpjmHyQTvdlsoh10JTV58aLBBZJKSXi1z4AHaHM1tvkSTCTjDfIK/MyJHHWAieg9dgYjj7GJ98LdOiegZA+HyXNeqoUk5ZNI/UJ5r569k5OzXLJmUlkc3W/QkbDO5pna1DOwi9WEpxa0f2/PvE3cSzApMpPBDAC0e6MPkNh1+8jCy4HQvAu+oqHFJplqTL340c1D6/786ABhWGsCx7hzPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dr6J/RxXsn6zpF9uD3gR8nBG5ycf1DtqyecxCTtEvxM=;
 b=vk65zscgXWpljA4CjjL3gBQbkHM7zO2JgzVWnBxBf7kzRJ6eKjVooD1k8hJgIizZRXsrewFmwgiqTifUQS5beeaeFiWigaPuJjpnSv6I2LZmKNCH9QzjL7ktb5ZWqwRMu2gdAQjtqpYF/+lptL94BYL7y8L/BgRXQAyXQ6F/8//KaAi3TNXUw9OzChZehSZVy7vtjAX4qZgGHLp3ayT1G+qKkdKRUyOHAvsvxyqY2qGF892gq0Qk/pEdoz1qS7Asm5OhQsnV6mSQe6sKFNKSmHB17gwh9ymRJn1dpndDGOru/4uqs1ryNvEOfG6qRg0TMbqSnBkuLVUYg4DNA8gp8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dr6J/RxXsn6zpF9uD3gR8nBG5ycf1DtqyecxCTtEvxM=;
 b=Ijk58lP0j87RO0SqQ7j9Pf9HBteG5lLU+d2s1Hm6XgSDEr3zflAygJhBsLXQXtOH0hgRN1weXnUwgEXXN+sT6c5M8758h71dTT7wyHKYqok7m9cMs1AehVgRCWwsfsKd6n5Lzyugg3dBrpfRcZ+8wkZB3kfWdnGr5DBkF8muIGkk5Nb6jwZUgeos2cbwf9BMyNNgEm2g0EGTYHgQG0va/jBoOr9w+wXdQxd8yVzmTl2mm5Fot0njDE3W+cfV4jfrTVgLkTGIpLZ6AX2/vhU4dctLaADwbQ3mMq/ndTgR7kwsONZLPoHdPLXQsqR0LumAH1u00sNCJ+mHtL/j7E95Aw==
Received: from BN0PR03CA0052.namprd03.prod.outlook.com (2603:10b6:408:e7::27)
 by BL1PR12MB5779.namprd12.prod.outlook.com (2603:10b6:208:392::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 18:40:30 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:e7:cafe::42) by BN0PR03CA0052.outlook.office365.com
 (2603:10b6:408:e7::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 18:40:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:40:30 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:39:58 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:39:49 -0700
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
Subject: [PATCH v5 25/27] vfio/cxl: Run the CXL reset at the vfio reset points
Date: Thu, 17 Sep 2026 00:05:38 +0530
Message-ID: <20260916183540.3813685-26-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260916183540.3813685-1-mhonap@nvidia.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|BL1PR12MB5779:EE_
X-MS-Office365-Filtering-Correlation-Id: 7873ce0f-174e-4e94-dc44-08df1421fbec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|7416014|23010399003|36860700016|6133799003|18002099003|22082099003|10067099003|921020|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	wyuqdZ8HgR1k3lJHpyTjAhXuxf9TRi0PNMXPqJ33LJkljYCXxfugFusJyjZDS+yMUsusb4+YCHrfvnUFGlM7w0UfZeY7vSwiStmbsA4V1188M6sIHE+InmihK2r+pWCRNeK64NDFdqmnAUZqQ3glJX+01zKTkVBpfs7nr8+tv9EchcbgThb+XoTKBgHd5D6WUMzbgtH0PcuBL0ejHr4RE8KxFy5zI/J1w1DOQzUihbS3XJ9Daymu9TvSeWrMEU+xnDUczRbSentQaEx7+qhNX1p9dc1+GF/0FvMcIj8bykg5NWaX4p+ecyp3z/vIZws2U5tkNgWqlxclNEZR8Ck7/FElIncYGKXEl0tVapL31fQcywHIyU5/XzPMdVSEnCT3aejJvrSaEzwA2qGGavArE+hhG1RBRlM8HNZbvjDISGUtNhiyad7OqGm72DsGxi59PyxLMXoTxsnId6OadTaYjo0mcYdRnloAHctXIblHrA2Sj/ElS8mHQ1roeQhHKTpK/69dkXJFHeGK3XAHTZ9kk9wDuMft988WCjYV76btvMj5VEj5ijn1OC0I2zzsH86KqY1u+4rldpvLmdHhM34qfkS2wQQoR50viD4EbtDaYJxZiUWYBSgSVNrejZLdedKNF4QpbcmKanTaBYSpzWu8T7UpQSMmWfNPDvyTSnUYffb+eR4Zr56iulzNb/GGuAt1P9WREz6C+rlEI+hxhdFX9RlKfw26jiBrIZpdwra5zX0JlBr0NV3pWeWgFjSuBewc
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(7416014)(23010399003)(36860700016)(6133799003)(18002099003)(22082099003)(10067099003)(921020)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yjqKnaj4mdSjzvQIB9ZSvrfqvdeMWXzPsPFLWDsWQNtVFgLMP83DjvE29Ne3AjPoLspWogJR7s1rNObNidnCa8HcoX48mvHLUoe4OPnuv3UuLfLksUGsEchTIEHBkQijjfOGRpWzOxcXNMUEkAEMSYnKTylhnhNj6oI2ep4Nz8z9yh32tXBr6NJescXWsJqzFUoK4TNJF5Mv6XjIOrRTDbdxWYZN3wtWyUbfO+igZrb5OZb/+kA4caCf2W+AmgrW/RSE9GGFDBS9TtjPsDJrr6JkLHRYR1SbfhINlfr1Bb6tqH4nEnNUozK3YEGKZAWbix/qth5teLdYnBQglcDOT7hWm3u/4hYO85xGzBKzdykwXIT6N3p6bvN+hye5qP8olYj2EtvueaO7offJqXY4xIt8KPFVTXTKKi6CrBQlvLQteiqIvGx3YrsijLpxGw2N
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:40:30.0887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7873ce0f-174e-4e94-dc44-08df1421fbec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5779

From: Manish Honap <mhonap@nvidia.com>

A CXL Type-2 function must not take an FLR: it resets the coherent
CXL.mem state and corrupts the HDM decoder. The PCI core already reflects
this, ordering cxl_reset ahead of flr in pci_reset_fn_methods[], so a
function reset of a CXL device runs the DVSEC reset sequence rather than
FLR.

Route the vfio function-reset points (VFIO_DEVICE_RESET and the
virtualized PCIe/AF FLR writes) through a CXL reset op that runs
cxl_reset_dvsec_sequence(). The sequence resets the function, always
clearing device memory, and restores the HDM decoder and PCI config
state, so it is a complete replacement for pci_try_reset_function() on a
CXL device. The op runs under memory_lock and not the PCI device lock, so
cxl_reset_dvsec_sequence() can take the device lock itself.

Clear hdm_valid for the duration of the reset so a fault cannot insert a
PFN into a decoder that is being torn down, and restore it once the
sequence has put the decoder back.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 41 +++++++++++++++
 drivers/vfio/pci/vfio_pci_config.c   | 49 +++++++++++++++---
 drivers/vfio/pci/vfio_pci_core.c     | 77 +++++++++++++++++++++++-----
 drivers/vfio/pci/vfio_pci_priv.h     |  1 +
 include/linux/vfio_pci_core.h        |  4 ++
 5 files changed, 152 insertions(+), 20 deletions(-)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index 55fa1f86850d..795362aea344 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -632,6 +632,45 @@ static void vfio_cxl_reset_done(struct vfio_pci_core_device *vdev)
 		cxl->hdm_valid = false;
 }
 
+/*
+ * Run the CXL DVSEC reset sequence in place of a PCI function reset. A CXL
+ * Type-2 function must not take an FLR (it would corrupt CXL.mem), so the vfio
+ * reset points route here. The sequence resets the function, always clearing
+ * device memory, and restores the HDM decoder. The caller holds memory_lock,
+ * and this path does not hold the PCI device lock, so cxl_reset_dvsec_sequence()
+ * can take it.
+ */
+static int vfio_cxl_reset(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_cxl_state *cxl = vdev->cxl;
+	int ret;
+
+	lockdep_assert_held_write(&vdev->memory_lock);
+
+	/* Host CPU access to the HDM range is unsafe until the decoder is back. */
+	cxl->hdm_valid = false;
+
+	ret = cxl_reset_dvsec_sequence(vdev->pdev);
+	if (!ret)
+		cxl->hdm_valid = true;
+
+	return ret;
+}
+
+/*
+ * The HDM dma-buf may be armed only while the decoder is valid. After a failed
+ * reset hdm_valid is clear, so the generic memory-enable re-arm must skip the
+ * dma-buf rather than map DMA onto an unrestored decoder.
+ */
+static bool vfio_cxl_hdm_active(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_cxl_state *cxl = vdev->cxl;
+
+	lockdep_assert_held_write(&vdev->memory_lock);
+
+	return cxl->hdm_valid;
+}
+
 static const struct vfio_cxl_ops vfio_cxl_ops = {
 	.init		= vfio_cxl_init_device,
 	.release	= vfio_cxl_release_device,
@@ -639,6 +678,8 @@ static const struct vfio_cxl_ops vfio_cxl_ops = {
 	.close_device	= vfio_cxl_close_device,
 	.reset_prepare	= vfio_cxl_reset_prepare,
 	.reset_done	= vfio_cxl_reset_done,
+	.reset		= vfio_cxl_reset,
+	.hdm_active	= vfio_cxl_hdm_active,
 	.owner		= THIS_MODULE,
 };
 
diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 9a020a768055..8a5a737efa31 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -630,7 +630,14 @@ static int vfio_basic_config_write(struct vfio_pci_core_device *vdev, int pos,
 		*virt_cmd &= cpu_to_le16(~mask);
 		*virt_cmd |= cpu_to_le16(new_cmd & mask);
 
-		if (__vfio_pci_memory_enabled(vdev))
+		/*
+		 * Re-arm the dma-bufs on memory-enable, but keep a CXL device's
+		 * HDM dma-buf revoked while the decoder is unrestored (a failed
+		 * reset leaves hdm_valid clear); re-arming would map DMA onto a
+		 * decoder the fault path still gates. Plain vfio-pci is unchanged.
+		 */
+		if (__vfio_pci_memory_enabled(vdev) &&
+		    (!vdev->cxl_ops || vdev->cxl_ops->hdm_active(vdev)))
 			vfio_pci_dma_buf_move(vdev, false);
 		up_write(&vdev->memory_lock);
 	}
@@ -720,7 +727,8 @@ static void vfio_lock_and_set_power_state(struct vfio_pci_core_device *vdev,
 	}
 
 	vfio_pci_set_power_state(vdev, state);
-	if (__vfio_pci_memory_enabled(vdev))
+	if (__vfio_pci_memory_enabled(vdev) &&
+	    (!vdev->cxl_ops || vdev->cxl_ops->hdm_active(vdev)))
 		vfio_pci_dma_buf_move(vdev, false);
 	up_write(&vdev->memory_lock);
 }
@@ -910,8 +918,14 @@ static int vfio_exp_config_write(struct vfio_pci_core_device *vdev, int pos,
 		if (!ret && (cap & PCI_EXP_DEVCAP_FLR)) {
 			vfio_pci_zap_and_down_write_memory_lock(vdev);
 			vfio_pci_dma_buf_move(vdev, true);
-			pci_try_reset_function(vdev->pdev);
-			if (__vfio_pci_memory_enabled(vdev))
+			ret = vfio_pci_reset_function(vdev);
+			/*
+			 * Keep the HDM dma-buf revoked if a CXL reset
+			 * failed; re-arming would map DMA onto an
+			 * unrestored decoder. Mirrors the reset ioctl.
+			 */
+			if (__vfio_pci_memory_enabled(vdev) &&
+			    (!vdev->cxl_ops || !ret))
 				vfio_pci_dma_buf_move(vdev, false);
 			up_write(&vdev->memory_lock);
 		}
@@ -995,8 +1009,14 @@ static int vfio_af_config_write(struct vfio_pci_core_device *vdev, int pos,
 		if (!ret && (cap & PCI_AF_CAP_FLR) && (cap & PCI_AF_CAP_TP)) {
 			vfio_pci_zap_and_down_write_memory_lock(vdev);
 			vfio_pci_dma_buf_move(vdev, true);
-			pci_try_reset_function(vdev->pdev);
-			if (__vfio_pci_memory_enabled(vdev))
+			ret = vfio_pci_reset_function(vdev);
+			/*
+			 * Keep the HDM dma-buf revoked if a CXL reset
+			 * failed; re-arming would map DMA onto an
+			 * unrestored decoder. Mirrors the reset ioctl.
+			 */
+			if (__vfio_pci_memory_enabled(vdev) &&
+			    (!vdev->cxl_ops || !ret))
 				vfio_pci_dma_buf_move(vdev, false);
 			up_write(&vdev->memory_lock);
 		}
@@ -1781,9 +1801,22 @@ static int vfio_cxl_dvsec_write(struct vfio_pci_core_device *vdev, int pos,
 		status2 |= PCI_DVSEC_CXL_CACHE_INV;
 	}
 	if (ctrl2 & PCI_DVSEC_CXL_INIT_CXL_RST) {
+		int ret = 0;
+
 		ctrl2 &= ~PCI_DVSEC_CXL_INIT_CXL_RST;
-		status2 &= ~PCI_DVSEC_CXL_RST_ERR;
-		status2 |= PCI_DVSEC_CXL_RST_DONE;
+
+		if (vdev->cxl_ops && vdev->cxl_ops->reset) {
+			vfio_pci_zap_and_down_write_memory_lock(vdev);
+			vfio_pci_dma_buf_move(vdev, true);
+			ret = vfio_pci_reset_function(vdev);
+			if (__vfio_pci_memory_enabled(vdev) &&
+			    (!vdev->cxl_ops || !ret))
+				vfio_pci_dma_buf_move(vdev, false);
+			up_write(&vdev->memory_lock);
+		}
+
+		status2 &= ~(PCI_DVSEC_CXL_RST_DONE | PCI_DVSEC_CXL_RST_ERR);
+		status2 |= ret ? PCI_DVSEC_CXL_RST_ERR : PCI_DVSEC_CXL_RST_DONE;
 	}
 
 	*pctrl2 = cpu_to_le16(ctrl2);
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index f02a5240aa71..8bd4db7afefe 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -643,8 +643,27 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 		goto out_power;
 
 	/* If reset fails because of the device lock, fail this path entirely */
-	ret = pci_try_reset_function(pdev);
-	if (ret == -EAGAIN)
+	if (vdev->cxl_ops && vdev->cxl_ops->reset) {
+		/*
+		 * VM power-on resets a CXL Type-2 device through its DVSEC
+		 * sequence. vconfig is not built yet here, so take memory_lock
+		 * and call the op directly rather than the wrapper.
+		 */
+		down_write(&vdev->memory_lock);
+		ret = vdev->cxl_ops->reset(vdev);
+		up_write(&vdev->memory_lock);
+	} else {
+		ret = pci_try_reset_function(pdev);
+	}
+
+	/*
+	 * -EAGAIN means the reset could not run. For a CXL device any reset
+	 * error must also fail the open: a failed DVSEC reset can leave the HDM
+	 * decoder cleared or unrestored, and continuing would expose the HDM
+	 * region for host access through a decoder in an unknown state.
+	 */
+	if (ret == -EAGAIN ||
+	    (vdev->cxl_ops && vdev->cxl_ops->reset && ret))
 		goto out_disable_device;
 
 	vdev->reset_works = !ret;
@@ -845,16 +864,30 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 	 * overwrite the previously restored configuration information.
 	 */
 	if (vdev->reset_works) {
-		bridge = pci_upstream_bridge(pdev);
-		if (bridge && !pci_dev_trylock(bridge))
-			goto out_restore_state;
-		if (pci_dev_trylock(pdev)) {
-			if (!__pci_reset_function_locked(pdev))
+		if (vdev->cxl_ops && vdev->cxl_ops->reset) {
+			/*
+			 * VM power-off resets a CXL Type-2 device through its
+			 * DVSEC sequence. The sequence takes its own device lock,
+			 * so run it outside the lock below.
+			 * vconfig is already freed here, so call the op directly
+			 * under memory_lock rather than the wrapper.
+			 */
+			down_write(&vdev->memory_lock);
+			if (!vdev->cxl_ops->reset(vdev))
 				vdev->needs_reset = false;
-			pci_dev_unlock(pdev);
+			up_write(&vdev->memory_lock);
+		} else {
+			bridge = pci_upstream_bridge(pdev);
+			if (bridge && !pci_dev_trylock(bridge))
+				goto out_restore_state;
+			if (pci_dev_trylock(pdev)) {
+				if (!__pci_reset_function_locked(pdev))
+					vdev->needs_reset = false;
+				pci_dev_unlock(pdev);
+			}
+			if (bridge)
+				pci_dev_unlock(bridge);
 		}
-		if (bridge)
-			pci_dev_unlock(bridge);
 	}
 
 out_restore_state:
@@ -1592,6 +1625,20 @@ static int vfio_pci_ioctl_set_irqs(struct vfio_pci_core_device *vdev,
 	return ret;
 }
 
+/*
+ * Reset the function. A CXL device runs the CXL DVSEC reset sequence in place
+ * of a PCI function reset: it replaces FLR (which would corrupt CXL.mem),
+ * always clears device memory, and restores the HDM decoder. Callers hold
+ * memory_lock for write.
+ */
+int vfio_pci_reset_function(struct vfio_pci_core_device *vdev)
+{
+	if (!vdev->cxl_ops || !vdev->cxl_ops->reset)
+		return pci_try_reset_function(vdev->pdev);
+
+	return vdev->cxl_ops->reset(vdev);
+}
+
 static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
 				void __user *arg)
 {
@@ -1614,8 +1661,14 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
 	vfio_pci_set_power_state(vdev, PCI_D0);
 
 	vfio_pci_dma_buf_move(vdev, true);
-	ret = pci_try_reset_function(vdev->pdev);
-	if (__vfio_pci_memory_enabled(vdev))
+	ret = vfio_pci_reset_function(vdev);
+	/*
+	 * Re-arm the dma-bufs on success. A CXL device whose reset failed leaves
+	 * the HDM decoder unrestored and hdm_valid clear, so re-arming its HDM
+	 * dma-buf would map device DMA onto a decoder the fault path still gates;
+	 * keep it revoked until a reset succeeds. Plain vfio-pci is unchanged.
+	 */
+	if (__vfio_pci_memory_enabled(vdev) && (!vdev->cxl_ops || !ret))
 		vfio_pci_dma_buf_move(vdev, false);
 	up_write(&vdev->memory_lock);
 
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index c268c99aea82..e1ef21806a2f 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -78,6 +78,7 @@ int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev,
 			     pci_power_t state);
 
 void vfio_pci_zap_and_down_write_memory_lock(struct vfio_pci_core_device *vdev);
+int vfio_pci_reset_function(struct vfio_pci_core_device *vdev);
 u16 vfio_pci_memory_lock_and_enable(struct vfio_pci_core_device *vdev);
 void vfio_pci_memory_unlock_and_restore(struct vfio_pci_core_device *vdev,
 					u16 cmd);
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 39a28cc6ae8c..231679dead45 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -74,6 +74,10 @@ struct vfio_cxl_ops {
 	void	(*close_device)(struct vfio_pci_core_device *vdev);
 	void	(*reset_prepare)(struct vfio_pci_core_device *vdev);
 	void	(*reset_done)(struct vfio_pci_core_device *vdev);
+	/* Run the CXL reset (always clears CXL.mem) in place of FLR */
+	int	(*reset)(struct vfio_pci_core_device *vdev);
+	/* True while the HDM range is valid and its dma-buf may be armed */
+	bool	(*hdm_active)(struct vfio_pci_core_device *vdev);
 	/* Pinned per bound CXL device so vfio-cxl cannot unload under usage */
 	struct module *owner;
 };
-- 
2.25.1

