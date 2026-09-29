Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB52F54A7FB;
	Tue, 29 Sep 2026 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703302; cv=fail; b=HDnxY3WTVofuLrdp6FU0vNKK3A7iSybaQO3OI9sQlPX43LHkFNQIBO17J5wY9GFvmJa64+KkgnK3seDMxb/+z5FbOFAbFUsCwam6pA9gBN/OeKcOhfQl88+mrQRGNNqZ1XGiUpbN/K/aObUUgVv4BduLYbjfPOaFr8FS8l9r+Qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703302; c=relaxed/simple;
	bh=sScUg/eed7efwkAJJod9LrHHxtOH7dxPG8Vhs8XY6DU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RuTIhP/2AJsUiIQ79uC8vJu34jk6xRjfEj43eRagd7OuE/20uxltK0Cu/a70WmHI7Db+J/mNYWOtxjlJ0ShRM2DL/KRnMYzZlGgRj7Fcu0G+/fqqlWqvNzAVJXKjBdTUBuOQxgDHWiOKPlbUYeTWZDtLlHHzta/gnkR1Is0hH94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BCqOIrc4; arc=fail smtp.client-ip=52.101.85.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BCqOIrc4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hh5LCCXC7IplJTmnnSmmHmlBwgXD0oX9QsBjdo89HgNlIGKXksM96wTfDGng+ULmymrxRzVfj8tshYAcP3Ugui9EGC24LUnJXA9UF+HX1UOb4qC26/JHtPqlbJVlOsffOZ7kXCR/s4JvsxQuvG7jUfVtYvUQ2hV5U1u/LG6P3bXfMMGJ3Dh5UrvR0P5wfJ1aRzmC4rfy9U9K1jRxoqEIIQNw5R6V9C8bFv0PhvWCTNXKvnh4dvPZTD1aGnlWc5wt6XD+b22PCF7F0HqatEfB9p3bez4HSisFCHhNWdY8yXDCRlb3MMoK556Ysy0zOqPmqVYSRBZX/qZCisSH9ruENQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MMk+7SiexZKDDxcHDMgeJO6e0SPJeCIx6PdWWjFuSU=;
 b=u4rth389rnSq2g/40qV44/iksFY8D3j8Tmpiep60+ymixdk3FLTm8E88CzWiNKIO+/uwU+kIykcuBpkH1qhzq5BAw7LnVkFJ2SFJXkPRBhYwQzwYWgkpY4283gA8Tx1IYukGwS6+Ppldf+qJdgDRcQ8MC6FgK00P6R7L8AQPlHkRpRDCeClp4vyMvKfLGmYUuHBkp1b20kVoV1MT2LBCGc2aRSnwYv1xd8qhSMhdTmQC35s3TmVf/5FD6PppsZxWJqWpKHQ7JxSgYTKGrUZmcQmPauwuC8zilSBrbnY5dXU8okzXQfRy6/oB6gccG9+BP7jfXVt8pg8332ms6aBrqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MMk+7SiexZKDDxcHDMgeJO6e0SPJeCIx6PdWWjFuSU=;
 b=BCqOIrc4g6Oa/HlE309AYprOykUS5z0IamK5FymxoxScX1JYz0HoFU73tPKabrUAhrSM/8CCdEvMWQCUKVrwtocj7ce+HUuVdrbtLlFpXl9/eseIxDpvL1GPz0OLYa8IcfOVMxw9RsDGBmSZJeGt9/YokVezS7yjzwFIhCulzmjBg9M8iURZXFSpiomEr4uyMW7vUbObmzvetqWrywnzPGwFh5tEJzDQ13ipLd2iYPtAc7zKD8GE+/a2hSVNa282Ht7aa3PwfJasW4XM+qvqR+t7gtqLObnKipFCRNWj9gdWfTL8JCAgtyu+PlJdbrXY5yD91RyVeLn2WQK/EbQiFA==
Received: from PH7P220CA0066.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::21)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Tue, 29 Sep
 2026 17:34:51 +0000
Received: from BY1PEPF000264B4.namprd02.prod.outlook.com
 (2603:10b6:510:32c:cafe::9b) by PH7P220CA0066.outlook.office365.com
 (2603:10b6:510:32c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 17:34:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF000264B4.mail.protection.outlook.com (10.167.242.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 17:34:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 10:34:22 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 10:34:19 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v2 15/16] vfio/pci: Add VFIO_DEVICE_FEATURE_PCI_ERROR_RECOVERY
Date: Tue, 29 Sep 2026 18:33:04 +0100
Message-ID: <20260929173305.204856-16-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929173305.204856-1-skolothumtho@nvidia.com>
References: <20260929173305.204856-1-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B4:EE_|DM6PR12MB4356:EE_
X-MS-Office365-Filtering-Correlation-Id: 1247eb71-7e6e-43f7-9564-08df1e4ff74a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|11063799006|56012099006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	va5XfvR+bAFjLUK2NneGWTwJChrBLAK6aYsB185PMguMWTN4DzhQPnySehGHSTAAxbbYVJeAScUxBxQkuh5Dx+kvDAJY9Q+Q8HXG7kUdimVKuUvB3OgeeHKmJBciiNqd6ew+4nkh6vq8Mtz0QHihTdnspmGPWg9kVA1E17AFd3fFMFOOpD3arIAG7hw7iG4NPNgGkjBSrfK3JdWv9Y6DbitO2oVm3sD1zw88ys8u/nQbIkgUPX/EyOUL+uM1d8yzr2V/Gipj75mDhhIsHCBwwBGI0Zlx/xPdaab49b47Vh/GlafRUXXAvNWTir2JRdQOm+yuRyTSwCD1X3dHEsNl7Tl+X4Zv2zMQfriayf1krjFrU9McNvb+V9BlRCE4XM5HeMxCc9bEvyEgqrgO1eoZvUgp5k9e3LyRdMESsQQ3bwS39/zr2sUT38IFkskMM5L3kKRt0jJRZJkEDpxLlqFMxo95XjYx1abdSKXqCVx1VmWahBb8sWHEdvEHCg6fatXGbPEsny4h74ttt7+9BO31lAIs6hdd6d/Kmilr/9xHZR7OxlggWYu+Sgy2T+vfHol4wwPwJV4AldSzBGA2uRyZxcMlQ3u9sAghILYEQXEW8csp3T1PXUqcLhMibpP5km0W/qI4Zt6TwyoC/9UM7lbD9iW+knZrgH5RQ6cso9ju0Sx9kwIjE4wKSLV13Aj+mu89V1bWDnNwSXNlyLHTqJqKoQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	B/KIKk8c9m7l1KLj8PRyYLsULFIhUVpv9Dk9ABKYomMvpOiL0f3TJyJwRSVNMlnQeTvRsEKPOuH0+++zRcrWXuDJb6n5/Bo/XO8RhYYtIIw94EgrncbmbU6aQ2V2D8LaQ7pWIW3wLyfvKRj6JbK00e8aJUAxO5uQA+KOkzRGhm/AmEFjkvV6mzdWf1bzkLlnEWz+5A2EdR8tPOqFWX9y/bbYZjZaTejcYvfghjND+wXiMwg0s2rPdAbzEJ1ORvAvh2JHNboaLjyLpzvD2NAhWimTY6yI0n1bTEeccvuqALPxNu7GpGTNm5PDnA6jYZ7+SER2PvASPGmq/NC1+7PNN10Nfh+oPEbJ5eWWe2xphtqzOTJbEw+UGC9n9Sdx+VUJf5/17veGDgYKYA0H44ekfV0WZxd3Nm3UTdu7m2itYZ5nN5PIGVIzJMjZNZ+2cTsf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:34:50.8766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1247eb71-7e6e-43f7-9564-08df1e4ff74a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4356

Add a device feature to enable host PCI error recovery and query its
status. SET registers an eventfd for start and completion notifications;
eventfd -1 disables recovery. GET returns the status flags and sequence
number, including while recovery is active.

Reject SET while access is blocked or recovery has failed. Reset the
per-open status and sequence when updating the eventfd. Existing
VFIO_PCI_ERR_IRQ_INDEX notifications are unchanged.

Assisted-by: LLM
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/uapi/linux/vfio.h        |  44 +++++++++++++
 drivers/vfio/pci/vfio_pci_core.c | 108 +++++++++++++++++++++++++++++++
 2 files changed, 152 insertions(+)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index e41437fa17ad..b755849fd39b 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1555,6 +1555,50 @@ struct vfio_device_feature_zpci_err {
 
 #define VFIO_DEVICE_FEATURE_ZPCI_ERROR 13
 
+/*
+ * Report host PCI error recovery state for this device.
+ *
+ * VFIO_DEVICE_FEATURE_SET with a valid eventfd enables recovery for this
+ * open and registers notifications for the start and end of each event.
+ * SET with eventfd -1 disables recovery. flags and sequence must be zero.
+ * SET returns -EBUSY during recovery, after recovery failure, or while
+ * device access is blocked, and -ENODEV after close has started.
+ * VFIO_PCI_ERR_IRQ_INDEX notifications are unchanged.
+ *
+ * VFIO_DEVICE_FEATURE_GET returns the current state and eventfd = -1.
+ * GET is allowed during recovery, but may wait for a running callback.
+ *
+ * The sequence number increments for each event and resets to zero when
+ * recovery is enabled. Use it to detect coalesced notifications. Device
+ * accesses return -EIO while IN_PROGRESS is set. Recovery may complete
+ * before userspace reads the notification, so userspace must check the
+ * sequence and status rather than wait to observe IN_PROGRESS.
+ *
+ * CHANNEL_FROZEN records a frozen channel. DEVICE_RESET records a host
+ * reset; userspace must reconfigure interrupts with VFIO_DEVICE_SET_IRQS.
+ * FAILED indicates that recovery failed and access remains blocked until
+ * close and reopen. Status bits persist until the next event or SET.
+ * ENABLED indicates that recovery is enabled.
+ *
+ * Enabling recovery during an existing event does not provide status or
+ * notifications for that event.
+ *
+ * Open returns -EBUSY while a previously recorded host recovery is active,
+ * including events reported while recovery was disabled.
+ */
+struct vfio_device_pci_error_recovery {
+	__u32 flags;
+#define VFIO_PCI_ERROR_RECOVERY_IN_PROGRESS	(1U << 0)
+#define VFIO_PCI_ERROR_RECOVERY_CHANNEL_FROZEN	(1U << 1)
+#define VFIO_PCI_ERROR_RECOVERY_DEVICE_RESET	(1U << 2)
+#define VFIO_PCI_ERROR_RECOVERY_FAILED		(1U << 3)
+#define VFIO_PCI_ERROR_RECOVERY_ENABLED		(1U << 4)
+	__s32 eventfd;
+	__aligned_u64 sequence;
+};
+
+#define VFIO_DEVICE_FEATURE_PCI_ERROR_RECOVERY 14
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 2ec8022e4a69..314d77868803 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1752,6 +1752,111 @@ static int vfio_pci_core_feature_token(struct vfio_pci_core_device *vdev,
 	return 0;
 }
 
+/* Consumes the eventfd reference on both success and failure. */
+static int vfio_pci_recovery_set(struct vfio_pci_core_device *vdev,
+				 struct eventfd_ctx *ctx, bool enable)
+{
+	int ret;
+
+	guard(mutex)(&vdev->access_lock);
+	if (!vdev->device_open) {
+		ret = -ENODEV;
+		goto out_put;
+	}
+	if (vdev->access_blocked) {
+		ret = -EBUSY;
+		goto out_put;
+	}
+	if (!enable &&
+	    (vdev->pci_recovery_flags &
+	     (VFIO_PCI_RECOVERY_IN_PROGRESS | VFIO_PCI_RECOVERY_FAILED))) {
+		ret = -EBUSY;
+		goto out_put;
+	}
+
+	mutex_lock(&vdev->igate);
+	ret = vfio_pci_eventfd_replace_locked(vdev, &vdev->pci_recovery_trigger,
+					      ctx);
+	mutex_unlock(&vdev->igate);
+	if (ret)
+		goto out_put;
+
+	WRITE_ONCE(vdev->pci_recovery_enabled, enable);
+	/*
+	 * Reset the per-open status when updating the recovery eventfd.
+	 * The access block and host transaction state are unchanged.
+	 */
+	WRITE_ONCE(vdev->pci_recovery_flags, 0);
+	vdev->pci_recovery_sequence = 0;
+	vdev->pci_recovery_command_valid = false;
+
+	return 0;
+
+out_put:
+	if (ctx)
+		eventfd_ctx_put(ctx);
+	return ret;
+}
+
+static int
+vfio_pci_core_feature_error_recovery(struct vfio_pci_core_device *vdev, u32 flags,
+				     struct vfio_device_pci_error_recovery __user *arg,
+				     size_t argsz)
+{
+	struct vfio_device_pci_error_recovery state = { .eventfd = -1 };
+	struct eventfd_ctx *ctx = NULL;
+	bool enable;
+	int ret;
+
+	if (!vdev->pci_recovery_supported)
+		return -ENOTTY;
+
+	ret = vfio_check_feature(flags, argsz,
+				 VFIO_DEVICE_FEATURE_GET |
+				 VFIO_DEVICE_FEATURE_SET, sizeof(state));
+	if (ret != 1)
+		return ret;
+
+	if (flags & VFIO_DEVICE_FEATURE_GET) {
+		scoped_guard(mutex, &vdev->access_lock) {
+			u32 rflags = vdev->pci_recovery_flags;
+
+			if (vdev->pci_recovery_enabled)
+				state.flags |= VFIO_PCI_ERROR_RECOVERY_ENABLED;
+			if (rflags & VFIO_PCI_RECOVERY_IN_PROGRESS)
+				state.flags |=
+					VFIO_PCI_ERROR_RECOVERY_IN_PROGRESS;
+			if (rflags & VFIO_PCI_RECOVERY_FROZEN)
+				state.flags |=
+					VFIO_PCI_ERROR_RECOVERY_CHANNEL_FROZEN;
+			if (rflags & VFIO_PCI_RECOVERY_RESET)
+				state.flags |=
+					VFIO_PCI_ERROR_RECOVERY_DEVICE_RESET;
+			if (rflags & VFIO_PCI_RECOVERY_FAILED)
+				state.flags |= VFIO_PCI_ERROR_RECOVERY_FAILED;
+			state.sequence = vdev->pci_recovery_sequence;
+		}
+
+		if (copy_to_user(arg, &state, sizeof(state)))
+			return -EFAULT;
+		return 0;
+	}
+
+	if (copy_from_user(&state, arg, sizeof(state)))
+		return -EFAULT;
+	if (state.flags || state.sequence || state.eventfd < -1)
+		return -EINVAL;
+
+	enable = state.eventfd >= 0;
+	if (enable) {
+		ctx = eventfd_ctx_fdget(state.eventfd);
+		if (IS_ERR(ctx))
+			return PTR_ERR(ctx);
+	}
+
+	return vfio_pci_recovery_set(vdev, ctx, enable);
+}
+
 int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 				void __user *arg, size_t argsz)
 {
@@ -1772,6 +1877,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
 	case VFIO_DEVICE_FEATURE_ZPCI_ERROR:
 		return vfio_pci_zdev_feature_err(device, flags, arg, argsz);
+
+	case VFIO_DEVICE_FEATURE_PCI_ERROR_RECOVERY:
+		return vfio_pci_core_feature_error_recovery(vdev, flags, arg, argsz);
 	default:
 		return -ENOTTY;
 	}
-- 
2.43.0

