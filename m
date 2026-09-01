Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010033.outbound.protection.outlook.com [52.101.85.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E00D47ACE9;
	Tue,  1 Sep 2026 09:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255244; cv=fail; b=F8HDcuQfPhTfw/+RGmYerF/+xiX7ib8wOogZGKgpG+FOI28rdihEKGYvEMpWt7SmxzyV4fnRAokXtQ724JU2o77+2LJTJOqUK3PFPkMo/+T5HFz+q+WCh6uaux42f8eMH+xBWCmYCrvGZOn6nI5sIrwxO666Vkip+P9DXw5s2as=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255244; c=relaxed/simple;
	bh=Fcd2St04MedTpPfLOqj+akdHwJ/JdWyLbXl2ahjPKDM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aFG/GPc9CV+FSBc8B+50ofYVOH9gaj8ogRFkaFFcXK6/ib42Cx4ZJIa8cAV4opEaaMbcmAJFJ91mIFcL0B9XQGvIUO4yfpY8sVR0HGJorOoN6EZNHppKyLhzstlMOUITKhUvr7P1MjmIgBoyXGaHruJ4F4Alu95UyjixrT44lzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dfPJeB2q; arc=fail smtp.client-ip=52.101.85.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dfPJeB2q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azvBqgORumC/0W63Ca+iWsppkz6joJ+DpVxhhPbY9yQESbT6buDjX19LbXqWfwbDZpBTOMzOnkPTfpvrbN2M7H9/QKw1XTZ3K2HvUjJosEnKAwlyTEcSvYFwGTMU5nK0fuH/2Q5QGLcXazHlC0v96zmsZFlbtgSEmyXnb5/Z0j555NKSJRQ/AFyclfFpOfL5n9hckNFL7jFJaemucPZG6/QqkZA7nxf0W1mYYmw4xD8dmgaGLGBjFft7ZyVOZSvjLMMY0ybIjn2YR8LZ8z4sj15kWvuJFJG3Ru4KMcLUUZ5XXU05tXgX8XHhwmSjdl6SfJ3jy+Yrvh+SkEUUg0E6Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lq7zjeRolvU5bJGzirYTyvOwGz2HoIXIjjGAtlBnHxU=;
 b=JsS1YRiHo88qK+vS6GK16umzrHzFowrl8JVkgXxa+XOA1h+pBol95nHXROV4kd+02Gl3QGw6jmbaHAgxA0oPizWl1y9ZACsf77NmuVY3LoCJKaMq/26TFTO0+AW894p2TbJ7EKHgWWwbVuAUjMK0fphL3vyyLgAoK1HKjeYtuJlaaGXfWJnLqFzH8H3lKsDRHBvUvL895X2fsyIZRwwiJm88AmuUD/k3S6Y/wK2wDJofpCh8mJ8T+9nSrMNQYdd7FkHmmRHx9ZNWAMGI3YIzlY+bIVpuOpVELdLtgDQ8u5Fo4Nh9thRXXoU5CornH1c03V9gQBQrUNt5loY3c6qMVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lq7zjeRolvU5bJGzirYTyvOwGz2HoIXIjjGAtlBnHxU=;
 b=dfPJeB2qMOCLYBHx1JjW/mF5bwuURNDC6Z4lmKHxLuosFLaprQV7asDoLd4UVcQMaU+hgJZ4R446KzNbkKpt9S+jc6KeE84lgQQiSx3JiGyXxFtxbndAyRIrmPlF7S5BX04kjlY6sOionuwC+Hkn/r9pks5QjkNgIAOAwzwSVTiqRqhiWWTso3RpQ77eQlUlkUbMTRXJ9FWyG4gk4v/Ma2AGaG9hNFn1ueVkLmJFDgXLaxoNCxpnScTxY2rh+yt+Ea1crr0yrgw/Iotzngx4nwxVlyOEgq5SAC6JziA40fSfj7IuQ8K0OzX+Qm8Y5mjrjD127sAXlu/MlGDqjLX9Qg==
Received: from CH0PR13CA0047.namprd13.prod.outlook.com (2603:10b6:610:b2::22)
 by BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Tue, 1 Sep
 2026 09:33:51 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::6f) by CH0PR13CA0047.outlook.office365.com
 (2603:10b6:610:b2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 09:33:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 09:33:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:33:36 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:33:33 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <nathanc@nvidia.com>,
	<mochs@nvidia.com>
Subject: [RFC PATCH 06/19] vfio/pci: Serialize ioeventfd writes with recovery
Date: Tue, 1 Sep 2026 10:32:04 +0100
Message-ID: <20260901093217.8539-7-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|BL1PR12MB5754:EE_
X-MS-Office365-Filtering-Correlation-Id: e99b1f56-16bc-49ea-72b1-08df080c2200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Hp0e7//UX0AdPvz6/WLNVrnx4pnptcrI9469IGOAOTsh4nl6ilWn34LGxwgWLbv3WKJclj1kQypafq/ONdHiXFGUMLoqUakFICNE1aSye9ssssYOGZe8nkz6HqQ5GHi/mqFxI8z43x39Hlmtfnc0reBVwSkv0zoST4DpMvSl/yXGlKq59PhloHndPjSBdcG0djOFYqEPJkgi/xApyksnS0xYHg2qh3AULabqp8W6++r/tg0Cdl9WKxKQRKIngbot3bef0/17OHgmtXzvE6ppHJqVXsEGNRe81n89tbbvT89mL00Iig12oQ6y/I2e8bM2KkpMaf6UzxhDei/iZVB93Cp83qIJFKY4/YBiGz4PupYcvjgrdie4zuhktk2PKh0n7W8kdstJGNbq0obd+C75G3LS5RJ5xx5Eb64CDReWl9/HdkufwuZalUPeqA9CCjUmMC6cW66Rjox64wcGHB2f6hWTcPB/r7RGDgyUMKt7lHi19HpoZPJQoRxK0O29qiy6k5mCQwby3De78B31fyvzBGye/TZxgTEdm+ax5aEtyRwMMvkx2kP3q0JRZyGRzDJuui3gAHeGVpg7tygIwWJ+X+axmupZ2Dddb7PhJrdoJpRMzl2X07/hy/j/AqN4QQfT4p/d8DndtOyPGP4Wg1tNgz4FUE+YMrGcaX2xhG7kAfjYcORpaR4oqYVVnBpfphkAugZT2ba9UlMckwjNgl/fFQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	B8H61ERdqEoYtvt1218XKstH3P8Hdlg9aC0Ofv/ZrywimPKN77Kd4k/Qbxah6DyRDs5S5D2I8IdilVUsWa0xhr34/mDVHGvqVTF5EIq8rRMpDi6LABcImgMeD8/BKmmEL/D+gJ0dMfIWDlMu2CTrDj365vg+83c9q2UAYf/PEvzf6sdhXohlyuvz+N4qeUWxTX4iqo04shSuobbqed5j9Z/AR7oWTAJBRlkNqO71AHLuHkhXWRMvkldLBPum4/hpM3Q2TrjqKBeHMGBpsK2V6GMVQkXUPxNW4MClMdVnR+i7RxJ7gerUxQtCBGmpSBTaWEHYMsWCjZxVcpopYOJSd77Rl0Q5STGAWU7G+zRQUkmhQykl0URDhEfd4hBjkY6wx/7BjVeRuS7lTysLL6IydygP5zJHACM+wb/iYf/4MCO2ICKebzuGKeXeN1RbvUEP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:33:51.1408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e99b1f56-16bc-49ea-72b1-08df080c2200
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5754

Share one write helper between the ioeventfd fast path and the threaded
one. It takes memory_lock, checks the recovery state, then writes. The
fast path runs from the virqfd wakeup with a spinlock held, so it
trylocks and hands off to the thread if the lock is busy. The thread can
block.

The ioeventfd write path must not take recovery_lock at all. It is
reached through flush_work() from the virqfd cleanup workqueue, and
VFIO_DEVICE_SET_IRQS later calls vfio_virqfd_disable(), which does that
flush while holding recovery_lock for reading. If the write then blocked
on recovery_lock behind a queued AER writer, all three would be stuck.
The flush waits for the write, the write waits for the AER writer, and
the AER writer waits for the reader driving the flush.

So the recovery state is read lock-free, and the write goes through the
raw vfio_iowrite*() accessors rather than vfio_pci_core_iowrite*(). A
later patch makes those take recovery_lock, which is what this path has
to stay clear of.

memory_lock is still what drains a write already under way, and the
order is what makes it safe. The lock is taken before the flag is read,
so a write which saw the flag clear is already holding the read side,
and recovery waits for it when it takes memory_lock for writing. A write
to an I/O port BAR takes no memory_lock and is not drained. Those are
best effort. So is a write which arrives just after a reset has finished,
since VFIO_DEVICE_RESET releases memory_lock before it retakes
recovery_lock to unblock access.

The check is skipped for drivers which do not advertise support.
pci_recovery_device_open is only ever set when the recovery machinery is
live, so testing it unconditionally would drop every ioeventfd write for
every other vfio-pci-core driver.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_rdwr.c | 91 +++++++++++++++++++++-----------
 1 file changed, 60 insertions(+), 31 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 7f14dd46de17..20362e2f0166 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -349,56 +349,85 @@ ssize_t vfio_pci_vga_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 }
 #endif
 
-static void vfio_pci_ioeventfd_do_write(struct vfio_pci_ioeventfd *ioeventfd,
-					bool test_mem)
+static int vfio_pci_ioeventfd_do_write(struct vfio_pci_ioeventfd *ioeventfd,
+				       bool trylock)
 {
+	struct vfio_pci_core_device *vdev = ioeventfd->vdev;
+
+	if (ioeventfd->test_mem) {
+		if (trylock) {
+			if (!down_read_trylock(&vdev->memory_lock))
+				return 1; /* Lock contended, use thread */
+		} else {
+			down_read(&vdev->memory_lock);
+		}
+	}
+
+	/*
+	 * Read the recovery state lock-free rather than under recovery_lock.
+	 * This path runs from the virqfd cleanup workqueue, which is flushed
+	 * from paths that take recovery_lock for reading, so blocking on it
+	 * here would deadlock behind a queued writer.
+	 *
+	 * For a memory BAR, a blocked device still waits for a write already
+	 * under way, through memory_lock. The lock is taken above before the
+	 * flag is read, so a write which saw the flag clear is already
+	 * holding the read side, and the blocker waits for it when it takes
+	 * memory_lock for writing. An I/O port BAR takes no memory_lock, so
+	 * a write which saw the flag clear can still land afterwards. Port
+	 * writes are best effort here.
+	 *
+	 * A write can also be dropped for a short while after a reset has
+	 * finished, since VFIO_DEVICE_RESET releases memory_lock before it
+	 * retakes recovery_lock to unblock access. Closing that would mean
+	 * taking recovery_lock inside memory_lock, which is the wrong way
+	 * round.
+	 *
+	 * pci_recovery_device_open records that the recovery machinery is
+	 * live, so it is only ever set for drivers which advertise support.
+	 * Testing it unconditionally would drop every write for every other
+	 * driver.
+	 *
+	 * The raw vfio_iowrite*() accessors below are used for the same
+	 * reason. This path must not take recovery_lock.
+	 */
+	if (vdev->pci_recovery_supported &&
+	    (!READ_ONCE(vdev->pci_recovery_device_open) ||
+	     READ_ONCE(vdev->pci_recovery_access_blocked)))
+		goto out_memory;
+
+	if (ioeventfd->test_mem && !__vfio_pci_memory_enabled(vdev))
+		goto out_memory;
+
 	switch (ioeventfd->count) {
 	case 1:
-		vfio_pci_core_iowrite8(ioeventfd->vdev, test_mem,
-				       ioeventfd->data, ioeventfd->addr);
+		vfio_iowrite8(ioeventfd->data, ioeventfd->addr);
 		break;
 	case 2:
-		vfio_pci_core_iowrite16(ioeventfd->vdev, test_mem,
-					ioeventfd->data, ioeventfd->addr);
+		vfio_iowrite16(ioeventfd->data, ioeventfd->addr);
 		break;
 	case 4:
-		vfio_pci_core_iowrite32(ioeventfd->vdev, test_mem,
-					ioeventfd->data, ioeventfd->addr);
+		vfio_iowrite32(ioeventfd->data, ioeventfd->addr);
 		break;
 	case 8:
-		vfio_pci_core_iowrite64(ioeventfd->vdev, test_mem,
-					ioeventfd->data, ioeventfd->addr);
+		vfio_iowrite64(ioeventfd->data, ioeventfd->addr);
 		break;
 	}
-}
-
-static int vfio_pci_ioeventfd_handler(void *opaque, void *unused)
-{
-	struct vfio_pci_ioeventfd *ioeventfd = opaque;
-	struct vfio_pci_core_device *vdev = ioeventfd->vdev;
-
-	if (ioeventfd->test_mem) {
-		if (!down_read_trylock(&vdev->memory_lock))
-			return 1; /* Lock contended, use thread */
-		if (!__vfio_pci_memory_enabled(vdev)) {
-			up_read(&vdev->memory_lock);
-			return 0;
-		}
-	}
-
-	vfio_pci_ioeventfd_do_write(ioeventfd, false);
 
+out_memory:
 	if (ioeventfd->test_mem)
 		up_read(&vdev->memory_lock);
-
 	return 0;
 }
 
-static void vfio_pci_ioeventfd_thread(void *opaque, void *unused)
+static int vfio_pci_ioeventfd_handler(void *opaque, void *unused)
 {
-	struct vfio_pci_ioeventfd *ioeventfd = opaque;
+	return vfio_pci_ioeventfd_do_write(opaque, true);
+}
 
-	vfio_pci_ioeventfd_do_write(ioeventfd, ioeventfd->test_mem);
+static void vfio_pci_ioeventfd_thread(void *opaque, void *unused)
+{
+	vfio_pci_ioeventfd_do_write(opaque, false);
 }
 
 int vfio_pci_ioeventfd(struct vfio_pci_core_device *vdev, loff_t offset,
-- 
2.43.0

