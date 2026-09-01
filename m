Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010071.outbound.protection.outlook.com [52.101.61.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8D036B926;
	Tue,  1 Sep 2026 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255258; cv=fail; b=IVc4wCt1eDzoQB6NrOxTWli6RaH7UqE4FKEL9fd/UBGnVQmIJrxH4QwcopY2mvhmRXSV80zSlF3iuqXkW/AITaZhFdbDbDs7A7Gi+lSdyz5CfAZjyDEz+OOq6+kLuPkbqaqMmUs1zKVdflEvHgy3rCtj9rE9kmeCW7XoI1c6krQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255258; c=relaxed/simple;
	bh=8ivqZZgdMuIQ9V3KKVBrZiAt6qhAD1TqSkvMyRdUbU4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GAsCmsId4OEBhdWzw268gLvlfY9BOd60kGRoMsEmzerrR9RPK37WUEc3vOQ1+Qr2A+3Knbsb/acfrpdxKTqDXcYlrs8JLBYfloUr8vF3U8U81Izk3yd4VvG4rEqFnUtMFIf/P+M3wmLNWygXij40M6PIWZ3HdSqJjaqV6H0Wx8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nv1McUTS; arc=fail smtp.client-ip=52.101.61.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nv1McUTS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGDXLMZKfyIGGfV2/xHvkMLmaM/GLg8uv3IHLvrgOGv6G+WUTUGq1hiRfzcJt6JSIuGCToND5JxZVX61QgbKJbVtkrgkjyQh7W9nitH2isMqFwhgO91YOeiitKvkFNVbCN/ESvv0eT/1SdgM5xQNP4bsd0gvLRQc9Yqe3VeFjz7LPdZ6XpdsNomfyco9IFDHAfG0nUs1KX0RmZ79gxnqYsWILa8mhAkByaPukhMhCHjOelEej7/RgMCS2iBJWnBmWeL7K5vDWeJrUhd/vaDqAE3Uv4Bc5q4oP7P3jbWLHQ/35gMgnTIV5krM9/e8Avq22vaoUx7bUkFCyQTL7B99tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0mF3TibbH4dPDdtyb79PKJtHSTe49D+Js5wVI8oRnI=;
 b=yeoMEZ+/FzE47uFTdinsJdZ5TRtAhOfQduRuLrwePELVdu/pk/aZmLxcF9X8rmhg7u2cEv7YF5yh3pXOEXDVwunXdHDT40iNQSqSSbQ1aBjJL16sWzmpvBH+vMUFbtwPEGjZc4cfT0NKzVO9wvkpsVMzlPsJ669EYbKCqykZP3MW7oPxROQM3UeVPRnKmdUB99fCIhP+N9S/NWk9njXpLx2lDLo3zLHi3s/L/1LKVOhS5TWPBIJ6SMREZoxn2do6b/FdEL732IbxCg4rpe1xr5GKfAfU/6NklddtqbK/RwM92uhrxjIBXEyGARHcXguijbrQlncUQPzfGLvN+jqVNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0mF3TibbH4dPDdtyb79PKJtHSTe49D+Js5wVI8oRnI=;
 b=nv1McUTSQWeStbl0NfMDZhr/ZOWxFKKbb/X0tByVIYyfpPKTZaGfLXqY1zbwhnMhZWQStChnSRDa4JHMG/ma36UG+iCyCGsYk+iW1FNqpY2h6p0J4AfiIq4bbYDjOegioEkriWIlFSzAYACWxXoFUv+A6IYuBdPr2/8D986TFatW3B49jM0Fb5X5Rgmexz9SSrhcJ+juByKqnvZQqRn3lrmU/MnKy/ynOV++k5kkK7pmv/2ir6iUlid2wx1vykKF/12h70/8e24LBbAqQ+BgrYqIdgFghkFyKuGBhLD3eLAn1lMvhp+sh30wEjU2ihsi0tPRbOLHf6cfToCkUGu0ug==
Received: from CH0P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::21)
 by PHXPR12MB999231.namprd12.prod.outlook.com (2603:10b6:510:3ce::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 09:33:59 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::8e) by CH0P221CA0020.outlook.office365.com
 (2603:10b6:610:11c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 09:33:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 09:33:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:33:43 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:33:40 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <nathanc@nvidia.com>,
	<mochs@nvidia.com>
Subject: [RFC PATCH 08/19] vfio/pci: Serialize BAR and ROM access with recovery
Date: Tue, 1 Sep 2026 10:32:06 +0100
Message-ID: <20260901093217.8539-9-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901093217.8539-1-skolothumtho@nvidia.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|PHXPR12MB999231:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f8a0117-30e7-42f8-199a-08df080c2701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/a9U0Y2bZWCg9Zs9Xd4zmCWsFLfL84rKnvGYEV7axBSdOikL9DueObzqAwymw7pSHBKBYfl82JGEp3z98f3OY7kjfXR2e8hpCH9ucU4+q52cHvf1jAWjKOZofd2Cci9UhpYY/Ebrf38DsWuZPlbIZXGW3x6h+qocI7zPFwxhspJA/uqkJRLYu2StzixUIDnTQnthURYGtQducv1zCYexeGBMTfeTw+jcgQQgbxGQJhoR+YZh/Qr4vBNjCpn+A+Hp2SFcVCciYPViRteAq3aKrZNqtl7+i2Crtslt8gDeesLq/jI02RrXMBkqtW+dsQ77psYzjabx63a8pJGc05I6V3tS+9zisX5NdCSWSp4BvKAQ1wTFc7T82EzS44c0hJrSUZfWa8MK1KduCev+IvGn+kTUdDmMiZtUNqnmxfnELJNCH6NYA+L0uh5yJTOG6jNd7OzHBnHmNpqUhZLIZuUYv8mBk/XZ9ljxq+8i7mgFTLPCNVgXi4+RDKx9EJ832nZ+XqqbRkzGuuQkNwVtq4Gy+m9dGE7Ze1vILCMqWRgPxIBpvNYMeMASE46uHTVxRFIvGiI/NDpo6jOtajETeLBp8cCC2gu9QZXIIaGjfLcakUYR27hPej6yhzIaOieUnWAMLYMdeQSWAPqveZM+ouolddeTCReI8hTjfBvQ31i+s5pMXBzVrsYXXY0MyUCffIxWKaB5cxgyS133rAulDPNI7A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WPvYe+5QljtGjBDBNyfl/StKjXqlndxi18iPf+twPUbGu7kvo1Psexug5rP6KnN6fWC+YZuA1zFBryC3qx4+d+dio9Lbq5SxSowxx8dBr8BchUbqq4+TdkfygDZ57yJHR5D2GGRWvn0bMOKpiJpUwnrDJgDfvtrn8BlK2Wi8WsCK6wt0N1CsBZJwLLho7GcS3fLTLow8Lu2mLy9jtIZwp9H5cAzteNepsrFcmNejtuEPtvbmbLRxNahJNN4uIj2aGi4DM22V75ODmJ4ct0pTPOkAnC6xRB2U4Cd6PGmFTHuPVSJox6txq5ukiGwCwG1UowaUcGDVgd8Ed5RV8wU+Bv6tnypMG0tl1rv53yKCFRwTdLYnWoNoTnfE08wtzDzT6GVOAi4taf3CWTxmse+BgNisOqni7pl5Cu6MVS1I6bcpefjOxjJPa/rMlxcxcP2u
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:33:59.5273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8a0117-30e7-42f8-199a-08df080c2701
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR12MB999231

Hold recovery_lock for reading around trapped BAR reads and writes, and
around the ROM mapping, so they do not run while host recovery has access
blocked.

The lock is taken inside the width-specific I/O helpers, one access at a
time, rather than across the whole transfer. copy_to_user() and
copy_from_user() run in the callers of those helpers and so stay outside
it. A user buffer can fault, and with userfaultfd the fault is serviced
by userspace, so holding recovery_lock across the copy would let a user
stall error_detected() for as long as it likes.

VFIO_DEVICE_GET_REGION_INFO probes the ROM the same way, enabling memory
decode and mapping it to see whether the contents are valid, so guard that
too.

Mapping and unmapping the ROM both write config space: pci_map_rom()
enables decode, and assigns the resource first if it has none, and
pci_unmap_rom() disables it again. If recovery has blocked access, do the
iounmap and record the disable in pci_recovery_rom_disable instead.
recovery_lock is held across the decision and the record so recovery
cannot complete in between.

Do the recorded disable from vfio_pci_try_reset_function() once the reset
has finished, and from the resume() handler a later patch adds. Both are
points where whatever blocked access has ended. A closed device is
skipped, since close puts the device back through reset and config
restore without holding recovery_lock.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 32 +++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_rdwr.c | 51 +++++++++++++++++++++++++++++++-
 2 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index d46448662e84..0b1b2398dc88 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1244,6 +1244,9 @@ int vfio_pci_ioctl_get_region_info(struct vfio_device *core_vdev,
 			 * Check ROM content is valid. Need to enable memory
 			 * decode for ROM access in pci_map_rom().
 			 */
+			ret = vfio_pci_core_access_begin(vdev);
+			if (ret)
+				return ret;
 			cmd = vfio_pci_memory_lock_and_enable(vdev);
 			io = pci_map_rom(pdev, &size);
 			if (io) {
@@ -1254,6 +1257,7 @@ int vfio_pci_ioctl_get_region_info(struct vfio_device *core_vdev,
 				pci_unmap_rom(pdev, io);
 			}
 			vfio_pci_memory_unlock_and_restore(vdev, cmd);
+			vfio_pci_core_access_end(vdev);
 		} else if (pdev->rom && pdev->romlen) {
 			info->flags = VFIO_REGION_INFO_FLAG_READ;
 			/* Report BAR size as power of two. */
@@ -1379,6 +1383,30 @@ static int vfio_pci_ioctl_set_irqs(struct vfio_pci_core_device *vdev,
 	return ret;
 }
 
+/*
+ * Complete a ROM unmap which could not disable decode through config space.
+ * Call once whatever blocked access has finished. A closed device is skipped.
+ * It runs without recovery_lock, and close puts the device back through reset
+ * and config restore.
+ *
+ * The IORESOURCE_ROM_ENABLE test is what pci_unmap_rom() would have done.
+ * A ROM which firmware left enabled is not ours to turn off.
+ */
+static void vfio_pci_recovery_rom_disable(struct vfio_pci_core_device *vdev)
+{
+	struct pci_dev *pdev = vdev->pdev;
+
+	lockdep_assert_held_write(&vdev->recovery_lock);
+
+	if (!vdev->pci_recovery_device_open ||
+	    !READ_ONCE(vdev->pci_recovery_rom_disable))
+		return;
+
+	if (!(pdev->resource[PCI_ROM_RESOURCE].flags & IORESOURCE_ROM_ENABLE))
+		pci_disable_rom(pdev);
+	WRITE_ONCE(vdev->pci_recovery_rom_disable, false);
+}
+
 int vfio_pci_try_reset_function(struct vfio_pci_core_device *vdev,
 				bool reset_power_state)
 {
@@ -1455,8 +1483,10 @@ int vfio_pci_try_reset_function(struct vfio_pci_core_device *vdev,
 		 */
 		if (vdev->pci_recovery_device_open &&
 		    !(vdev->pci_recovery_flags & (VFIO_PCI_RECOVERY_IN_PROGRESS |
-						  VFIO_PCI_RECOVERY_FAILED)))
+						  VFIO_PCI_RECOVERY_FAILED))) {
+			vfio_pci_recovery_rom_disable(vdev);
 			WRITE_ONCE(vdev->pci_recovery_access_blocked, false);
+		}
 		up_write(&vdev->recovery_lock);
 		/*
 		 * Access is blocked for the length of the reset, so anything
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 20362e2f0166..86fadc999962 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -42,10 +42,17 @@
 int vfio_pci_core_iowrite##size(struct vfio_pci_core_device *vdev,	\
 			bool test_mem, u##size val, void __iomem *io)	\
 {									\
+	int ret;							\
+									\
+	ret = vfio_pci_core_access_begin(vdev);				\
+	if (ret)							\
+		return ret;						\
+									\
 	if (test_mem) {							\
 		down_read(&vdev->memory_lock);				\
 		if (!__vfio_pci_memory_enabled(vdev)) {			\
 			up_read(&vdev->memory_lock);			\
+			vfio_pci_core_access_end(vdev);			\
 			return -EIO;					\
 		}							\
 	}								\
@@ -54,6 +61,7 @@ int vfio_pci_core_iowrite##size(struct vfio_pci_core_device *vdev,	\
 									\
 	if (test_mem)							\
 		up_read(&vdev->memory_lock);				\
+	vfio_pci_core_access_end(vdev);					\
 									\
 	return 0;							\
 }									\
@@ -68,10 +76,17 @@ VFIO_IOWRITE(64)
 int vfio_pci_core_ioread##size(struct vfio_pci_core_device *vdev,	\
 			bool test_mem, u##size *val, void __iomem *io)	\
 {									\
+	int ret;							\
+									\
+	ret = vfio_pci_core_access_begin(vdev);				\
+	if (ret)							\
+		return ret;						\
+									\
 	if (test_mem) {							\
 		down_read(&vdev->memory_lock);				\
 		if (!__vfio_pci_memory_enabled(vdev)) {			\
 			up_read(&vdev->memory_lock);			\
+			vfio_pci_core_access_end(vdev);			\
 			return -EIO;					\
 		}							\
 	}								\
@@ -80,6 +95,7 @@ int vfio_pci_core_ioread##size(struct vfio_pci_core_device *vdev,	\
 									\
 	if (test_mem)							\
 		up_read(&vdev->memory_lock);				\
+	vfio_pci_core_access_end(vdev);					\
 									\
 	return 0;							\
 }									\
@@ -198,12 +214,41 @@ ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_do_io_rw);
 
+/*
+ * Undo pci_map_rom(). The iounmap is always safe, but pci_disable_rom() is a
+ * config space write. If recovery has blocked access, do the iounmap now and
+ * record the disable, for whichever of resume() or the reset tail unblocks
+ * access again. recovery_lock spans the decision and the record so recovery
+ * cannot complete in between.
+ */
+static void vfio_pci_unmap_rom(struct vfio_pci_core_device *vdev,
+			       void __iomem *io)
+{
+	struct pci_dev *pdev = vdev->pdev;
+
+	if (!vdev->pci_recovery_supported) {
+		pci_unmap_rom(pdev, io);
+		return;
+	}
+
+	down_read(&vdev->recovery_lock);
+	if (vdev->pci_recovery_device_open &&
+	    !vdev->pci_recovery_access_blocked) {
+		pci_unmap_rom(pdev, io);
+	} else {
+		iounmap(io);
+		WRITE_ONCE(vdev->pci_recovery_rom_disable, true);
+	}
+	up_read(&vdev->recovery_lock);
+}
+
 ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite)
 {
 	struct pci_dev *pdev = vdev->pdev;
 	loff_t pos = *ppos & VFIO_PCI_OFFSET_MASK;
 	int bar = VFIO_PCI_OFFSET_TO_INDEX(*ppos);
+	int ret;
 	size_t x_start = 0, x_end = 0;
 	resource_size_t end;
 	void __iomem *io;
@@ -230,7 +275,11 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 		 * filling large ROM BARs much faster.
 		 */
 		if (pci_resource_start(pdev, bar)) {
+			ret = vfio_pci_core_access_begin(vdev);
+			if (ret)
+				return ret;
 			io = pci_map_rom(pdev, &x_start);
+			vfio_pci_core_access_end(vdev);
 		} else {
 			io = ioremap(pdev->rom, pdev->romlen);
 			x_start = pdev->romlen;
@@ -269,7 +318,7 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 
 	if (bar == PCI_ROM_RESOURCE) {
 		if (pci_resource_start(pdev, bar))
-			pci_unmap_rom(pdev, io);
+			vfio_pci_unmap_rom(vdev, io);
 		else
 			iounmap(io);
 	}
-- 
2.43.0

