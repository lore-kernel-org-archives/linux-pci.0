Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010041.outbound.protection.outlook.com [52.101.85.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA02480DFF;
	Tue,  1 Sep 2026 09:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255309; cv=fail; b=CFRQ3Axr4SDwS/YvqduWyPBhNuvQV1nRwpuZqXVjY00aei4EiQaejaKM7uxwnJZ4eaJZDFbttYxFsn4LlntB2GKQveP/q6slHGbnmTDNb2kRu89J3cTq3C9MX+SYxe6M9p2Ijn5JuyJdhnChCb5rkDMt2v3ynAUWxxMgvIE3RXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255309; c=relaxed/simple;
	bh=FKvjy1rkAMcuzC3haH78swvWaCzTUK37/iHh3yhJVKU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X4wCHluo0BCy0BeYyvU339qhMuI7/YKBpfoIyZz4r4RfNiKgEdIQ0KydkJ93v2Z+j+jinkTZ0At/oiwfnALT/G8T5SEeG5UzcaZWcLthDCI3U4wZv/6YTkRbt9T+ibMzgFzwkNg2iH6kryxv3fv08GKYynhcV+ZniP4s4LGJMQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hNvfI8Aq; arc=fail smtp.client-ip=52.101.85.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hNvfI8Aq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r3ncKX2HU87asxeMWgBWdOBkEKMSBO0SsKtA124+Qyw72pHlD7CqC9Odk/zL7VTXHESVPT0vmERIzwyWDIAzjSHc099bkd2bHEiKuiFogZCIbd7GC+sh4EA9tXeaO9uujvLHrMOjSczMJk1NPtIrDLDYHh6c1IWW5i6mfv727lkxOgTtIn0R7LU/66fd/Q8wL4VpHuaQTcXMuIyxdzTh0LSr3WqM3ySOtIHl32OxdO+d8ztd/GuVek4zkHTPcd9XT7F6+8Hydil7JctHvpsZrKBOCDoNpOhdui0v3qeHk1VbpUKmwEeumAerby4jIXW10oUAQNqRVB5CbpMpOEFP9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njwtbRLpn5JR/bgVUvsRTV8LDJL0nncm0P3WMKYkRYY=;
 b=Kxr1jnFCy+VIygChJb1fftrkZqyQwcGVN2XBq8l/H4aec9eXsQaQT5bUDDXQ90R0FQr+QBmL4mQ0Y/1AR3mTw8TxFImUDWSQS3BRi4FeNkK/Al2Yxp0gfYShtYZy269PicKJmp9P+3ypvQQRGwU/jWFZQeIaHufXzGd3kZutLTddI0JezwMH4kWxt2skMjGOj1oovtX9SvkSgywB/tyTgV0SJYI4I2durcKTcmljrh19mTKewpAdRiyzrUBHULZGCDqqKgItJx9CDAnwv/9jF0z+uw3qvO0RyIU5jI0sohkmFwUnUQ5SRGS5gYSBffOKEUuSdgwfYWopvrCBQdB+sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njwtbRLpn5JR/bgVUvsRTV8LDJL0nncm0P3WMKYkRYY=;
 b=hNvfI8Aqr8aTN048nR+y2n8biM3u3WPyqsxO3timWQdQKejBhYQFE/5effo2/0cStUUSxopWmvZOBmvv++sTBVyxLmeWXV7SPdy7srW8etDwr8ezKDTPNVq871lTddOoPxfHaTd7dIVrrnaCWetW4++fx/mWTFdM7hVeSXJmT2SLWVNWSSzD/t3GzRcZknxbrMO9k+ALQ3P+XUalilp9wLKh5G652sPLm3EVdUxyp0ct7yRYlMCtcz6NLVIqaTo2gdmsSj1NSZwoxy/lFrhJDCg8b3VW4TlShQahw+pFHuqysjqimgnSop31g7hJaDGWLFfHOXAAL2RejC8LD/NRoA==
Received: from CH2PR14CA0012.namprd14.prod.outlook.com (2603:10b6:610:60::22)
 by CY8PR12MB7434.namprd12.prod.outlook.com (2603:10b6:930:52::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Tue, 1 Sep
 2026 09:34:45 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::4f) by CH2PR14CA0012.outlook.office365.com
 (2603:10b6:610:60::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 09:34:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 09:34:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:34:28 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:34:25 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <nathanc@nvidia.com>,
	<mochs@nvidia.com>
Subject: [RFC PATCH 19/19] vfio/pci: Expose and enable host PCI error recovery
Date: Tue, 1 Sep 2026 10:32:17 +0100
Message-ID: <20260901093217.8539-20-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|CY8PR12MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: a1638f25-658e-4da7-5f36-08df080c423e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|6133799003|56012099006|10067099003|5023799004|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	V41/9uHQkAkE+Dqr8oxqk+KP0e90dGPkCUNPlDbypC/+Kg4pz13vvVeT3Otx/QF5ny/FbwSkZ0qlww6SCbL0NwMFrguzpKkOjxKHtd+Z5YDk5Jqj6zPJljrd8JKePF9bU3J+KqsX4yaQMzWYccVeS93FzzqSBPQrG6Py4lMDtk/RJVj5Z0pMDOvP3nwsmuYytyvi9+w8nEHD4FpBD1LMyukX2HCHMJpeJBiyfduixdoMqP0iPOcxubZcBQPZWuay9qhrnwG1Gp0D98HQE659U3h+9nGqp5DXZh9f5fKjsSPW3yCJOKy5CyQ2sa7YL0SAQ9tL3RJLZGpPzj4xaBB7TF89LUcYi72zfdp9azLjL4U1TMH3XkESI9BxYtgLuEh8AtpIQ3smoY8ePSlLMFgyYOfWGq52mTskj+BEKGpxPbz7ORf5siev8v6hdmZFjSwg+xV3l6j+CeTL/QutKHr1xsmNBEEzkEaRZULifjbH0tjspfRgz/2NIa0aO4j6dnn9rpYMn5asc/Vo1Hyh0G3CvGtRvQhwv3YSuNN2bq1pNeWXL+U0v/vq3aBz0LNro0AugTFMkccs+WeiVCUQyQMl4HuuKDC48D1SurEVTlUCXorK9IQIpZOq9fuq0vgTTxbTRCFtlHpFBbgOQyjzmuQb7GwbXRsFtwerIwKs4gbhSS+YD7BSimK1bSzvq6R/yRu4LaoE4HxlxSRWevFwTt/wew==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(6133799003)(56012099006)(10067099003)(5023799004)(11063799006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Va0jmcEXq1tA2mqSI35gZrQwC8byxphvKxvQ0qilSjoigvh2YIh8GXMKu5kc7moIzpoTc1ctiltJEi8/lh+h7Urjw2PjZVeBXLfBCqrH/H3yGImIN6p3oIEN0QXiLtDyi6J8vcLHTiUzLcSspPDaM8GCMMu00ZxPQkJSpQZrLFAL/UIc0c1MjqhDIA2IqCyyL6rZxbMguOknvZvjDjkJOGiJIrMUp6kcLwobdnG1+Tn7dN+svBD1mZHqgZ9E5aBREGJT09fmu3+LoyGQ/alDmDl4NEk/TwVgbvV9nYGRtGzHU7hK5Cwt9kLzb6Q3wmqvupjoHaGlzwG1q0Og+9yOxV7fzO2MjRp5vbuzUnIB8nw7yxCJNl8iJz0n18JPxekt6QP0Xj0jvel0dBc97bGR7fR8o8u9CzDgO9V5sSFUKfJasVqqn94ULWbZXe5Jbi+x
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:34:45.2640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1638f25-658e-4da7-5f36-08df080c423e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7434

Add a VFIO device feature that reports whether host PCI recovery is
enabled, whether recovery is in progress, whether the channel was frozen,
whether the host reset the device, and whether recovery failed. A sequence
number lets userspace distinguish events.

Installing a dedicated recovery eventfd enables recovery. The eventfd is
additional to VFIO_PCI_ERR_IRQ_INDEX, which keeps reporting errors as it
does today either way. Recovery can be disabled only when not in progress
and before terminal failure. Reject both enable and disable while device
access is blocked so feature changes cannot race lifecycle teardown or an
explicit reset.

Clear the sequence number and the status bits whichever way the feature is
being changed, so a sequence number always describes an event the eventfd
holding it was notified of. A user which replaces the eventfd would
otherwise read status for an event it never heard about.

Variant drivers return -ENOTTY as they do not advertise recovery support.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/linux/vfio_pci_core.h    |   1 +
 include/uapi/linux/vfio.h        |  69 +++++++++++++++
 drivers/vfio/pci/vfio_pci_core.c | 142 +++++++++++++++++++++++++++++--
 3 files changed, 206 insertions(+), 6 deletions(-)

diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 42a77ed6b93c..fe42089be3fc 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -145,6 +145,7 @@ struct vfio_pci_core_device {
 	int			ioeventfds_nr;
 	struct vfio_pci_eventfd __rcu *err_trigger;
 	struct vfio_pci_eventfd __rcu *req_trigger;
+	struct vfio_pci_eventfd __rcu *pci_recovery_trigger;
 	struct eventfd_ctx	*pm_wake_eventfd_ctx;
 	struct list_head	dummy_resources_list;
 	struct mutex		ioeventfds_lock;
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index e41437fa17ad..ce0cda2dcbbb 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1555,6 +1555,75 @@ struct vfio_device_feature_zpci_err {
 
 #define VFIO_DEVICE_FEATURE_ZPCI_ERROR 13
 
+/*
+ * Report host PCI error recovery state for this device.
+ *
+ * The sequence number is incremented at the start of each event and remains
+ * unchanged for its subsequent state changes. Userspace can therefore
+ * distinguish a new event from completion of the current one and detect
+ * coalesced notifications. It restarts from zero each time recovery is
+ * enabled, so it is only meaningful within one enabled period.
+ *
+ * ENABLED reports that userspace has enabled recovery.
+ * CHANNEL_FROZEN records that recovery started with the PCI channel frozen.
+ * DEVICE_RESET records that the host reset the device. FAILED records that
+ * recovery did not complete successfully. Event status bits remain set after
+ * IN_PROGRESS is cleared. A new event supersedes status from a previous
+ * successful event. FAILED is terminal for the current device open and
+ * remains set until the device is closed and reopened.
+ *
+ * Status bits may also be set while IN_PROGRESS is still set, describing the
+ * event so far. Act on them once IN_PROGRESS is clear. Device access is
+ * refused with -EIO until then.
+ *
+ * When DEVICE_RESET is reported the host reset the device, which tears down
+ * the interrupt configuration the user had established. INTx, MSI and MSI-X
+ * must be re-armed with VFIO_DEVICE_SET_IRQS before interrupts resume.
+ *
+ * VFIO_DEVICE_FEATURE_GET returns the current state and -1 in eventfd. GET is
+ * never refused, including while recovery blocks device access, so that
+ * userspace can read this state during an event. It can wait for a recovery
+ * callback which is already running.
+ *
+ * IN_PROGRESS is not guaranteed to be observable. A recovery which needs no
+ * device reset can complete within microseconds of the notification, before
+ * userspace is scheduled, so a GET which follows the eventfd may already see
+ * IN_PROGRESS clear. Userspace must treat a notification as "an event
+ * occurred" and read the sequence number and the status bits to learn what
+ * happened. It must not wait for IN_PROGRESS to appear set.
+ *
+ * VFIO_DEVICE_FEATURE_SET with a valid eventfd enables recovery
+ * and installs the eventfd as a notification for recovery start and terminal
+ * completion. SET with eventfd -1 disables recovery when none
+ * is in progress and the latest event has not failed. SET returns -EBUSY when
+ * any of those restrictions prevents the requested transition, including while
+ * an explicit VFIO_DEVICE_RESET blocks device access, and -ENODEV if device
+ * close has begun. flags and sequence must be zero for SET.
+ *
+ * This eventfd is separate from VFIO_PCI_ERR_IRQ_INDEX and additional to it.
+ * VFIO_PCI_ERR_IRQ_INDEX keeps reporting errors as it does today whether or
+ * not this feature is enabled, so a user of both receives two notifications
+ * for one event.
+ *
+ * Enabling recovery does not recover an event which is already being handled
+ * for this device. Such an event was declined before it started, so it
+ * completes without notification and without status, even though the host may
+ * reset the device as part of it. Enable recovery before errors occur rather
+ * than in response to one.
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
index 2d757d6a5fe1..c1ea3c868fc5 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -893,6 +893,10 @@ static void vfio_pci_core_finish_close(struct vfio_device *core_vdev)
 	mutex_lock(&vdev->igate);
 	vfio_pci_eventfd_replace_locked(vdev, &vdev->err_trigger, NULL);
 	vfio_pci_eventfd_replace_locked(vdev, &vdev->req_trigger, NULL);
+	if (vdev->pci_recovery_supported)
+		vfio_pci_eventfd_replace_locked(vdev,
+						&vdev->pci_recovery_trigger,
+						NULL);
 	mutex_unlock(&vdev->igate);
 }
 
@@ -1850,6 +1854,106 @@ static int vfio_pci_core_feature_token(struct vfio_pci_core_device *vdev,
 	return 0;
 }
 
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
+		down_read(&vdev->recovery_lock);
+		if (vdev->pci_recovery_enabled)
+			state.flags |= VFIO_PCI_ERROR_RECOVERY_ENABLED;
+		if (vdev->pci_recovery_flags & VFIO_PCI_RECOVERY_IN_PROGRESS)
+			state.flags |= VFIO_PCI_ERROR_RECOVERY_IN_PROGRESS;
+		if (vdev->pci_recovery_flags & VFIO_PCI_RECOVERY_FROZEN)
+			state.flags |=
+				VFIO_PCI_ERROR_RECOVERY_CHANNEL_FROZEN;
+		if (vdev->pci_recovery_flags & VFIO_PCI_RECOVERY_RESET)
+			state.flags |= VFIO_PCI_ERROR_RECOVERY_DEVICE_RESET;
+		if (vdev->pci_recovery_flags & VFIO_PCI_RECOVERY_FAILED)
+			state.flags |= VFIO_PCI_ERROR_RECOVERY_FAILED;
+		state.sequence = vdev->pci_recovery_sequence;
+		up_read(&vdev->recovery_lock);
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
+	down_write(&vdev->recovery_lock);
+	if (!vdev->pci_recovery_device_open) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+	if (vdev->pci_recovery_access_blocked) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	if (!enable &&
+	    (vdev->pci_recovery_flags &
+	     (VFIO_PCI_RECOVERY_IN_PROGRESS | VFIO_PCI_RECOVERY_FAILED))) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	mutex_lock(&vdev->igate);
+	ret = vfio_pci_eventfd_replace_locked(vdev,
+					      &vdev->pci_recovery_trigger,
+					      ctx);
+	mutex_unlock(&vdev->igate);
+	if (ret)
+		goto out_unlock;
+
+	WRITE_ONCE(vdev->pci_recovery_enabled, enable);
+	/*
+	 * Start each enabled period from a clear state, so a sequence number
+	 * and the status bits beside it always describe an event this
+	 * eventfd was notified of. Nothing is in flight to lose. A
+	 * transaction holds access_blocked, which failed this call with
+	 * -EBUSY above.
+	 *
+	 * access_blocked itself is not cleared here, so userspace can never
+	 * disable its way out of a block.
+	 */
+	WRITE_ONCE(vdev->pci_recovery_flags, 0);
+	vdev->pci_recovery_sequence = 0;
+	vdev->pci_recovery_command_valid = false;
+
+out_unlock:
+	up_write(&vdev->recovery_lock);
+	if (ret && ctx)
+		eventfd_ctx_put(ctx);
+
+	return ret;
+}
+
 int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 				void __user *arg, size_t argsz)
 {
@@ -1870,6 +1974,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
 	case VFIO_DEVICE_FEATURE_ZPCI_ERROR:
 		return vfio_pci_zdev_feature_err(device, flags, arg, argsz);
+
+	case VFIO_DEVICE_FEATURE_PCI_ERROR_RECOVERY:
+		return vfio_pci_core_feature_error_recovery(vdev, flags, arg, argsz);
 	default:
 		return -ENOTTY;
 	}
@@ -2741,6 +2848,18 @@ void vfio_pci_core_unregister_device(struct vfio_pci_core_device *vdev)
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_unregister_device);
 
+static void
+vfio_pci_signal_recovery_event(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_pci_eventfd *eventfd;
+
+	rcu_read_lock();
+	eventfd = rcu_dereference(vdev->pci_recovery_trigger);
+	if (eventfd)
+		eventfd_signal(eventfd->ctx);
+	rcu_read_unlock();
+}
+
 pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
 						pci_channel_state_t state)
 {
@@ -2748,6 +2867,7 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
 	struct vfio_pci_eventfd *eventfd;
 	pci_ers_result_t result = PCI_ERS_RESULT_CAN_RECOVER;
 	unsigned long irq_flags;
+	bool notify_recovery = false;
 	bool terminal = false;
 	bool nested;
 	u32 flags;
@@ -2792,6 +2912,7 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
 		goto out_unlock;
 	}
 
+	notify_recovery = true;
 	WRITE_ONCE(vdev->pci_recovery_access_blocked, true);
 	/*
 	 * A second event before resume() has finished the first joins the
@@ -2916,6 +3037,8 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
 	if (eventfd)
 		eventfd_signal(eventfd->ctx);
 	rcu_read_unlock();
+	if (notify_recovery)
+		vfio_pci_signal_recovery_event(vdev);
 
 	return result;
 }
@@ -2981,13 +3104,15 @@ static pci_ers_result_t vfio_pci_core_aer_slot_reset(struct pci_dev *pdev)
 
 	up_write(&vdev->recovery_lock);
 	/*
-	 * Whoever clears IN_PROGRESS owes the wake. resume() will not do it,
-	 * since it bails once IN_PROGRESS is clear, and the core skips it
-	 * altogether if the domain verdict is not RECOVERED. On success the
-	 * transaction carries on and resume() wakes.
+	 * Whoever clears IN_PROGRESS owes the wake and the event. resume()
+	 * will not do it, since it bails once IN_PROGRESS is clear, and the
+	 * core skips it altogether if the domain verdict is not RECOVERED.
+	 * On success the transaction carries on and resume() does both.
 	 */
-	if (ret)
+	if (ret) {
 		wake_up_all(&vdev->pci_recovery_wait);
+		vfio_pci_signal_recovery_event(vdev);
+	}
 
 	return result;
 }
@@ -2996,6 +3121,7 @@ static void vfio_pci_core_aer_resume(struct pci_dev *pdev)
 {
 	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
 	unsigned long irq_flags;
+	bool notify_recovery = false;
 	u32 flags;
 	int ret = 0;
 
@@ -3011,6 +3137,7 @@ static void vfio_pci_core_aer_resume(struct pci_dev *pdev)
 	if (!(vdev->pci_recovery_flags & VFIO_PCI_RECOVERY_IN_PROGRESS))
 		goto out_unlock;
 
+	notify_recovery = true;
 	if (!vdev->pci_recovery_device_open) {
 		vdev->pci_recovery_command_valid = false;
 		WRITE_ONCE(vdev->pci_recovery_flags,
@@ -3056,7 +3183,10 @@ static void vfio_pci_core_aer_resume(struct pci_dev *pdev)
 
 out_unlock:
 	up_write(&vdev->recovery_lock);
-	wake_up_all(&vdev->pci_recovery_wait);
+	if (notify_recovery) {
+		wake_up_all(&vdev->pci_recovery_wait);
+		vfio_pci_signal_recovery_event(vdev);
+	}
 }
 
 int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
-- 
2.43.0

