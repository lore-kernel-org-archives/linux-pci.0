Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010071.outbound.protection.outlook.com [40.93.198.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F99055821F;
	Tue, 29 Sep 2026 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703277; cv=fail; b=QkC3ixIHlMh6lxPTtPCoMMFhPT55xYB2r4hwI+1S1wAx25818GGzCi5DZhomKZTuoTOQEUYgPso3SNtOsgdHOv9StNvQsbvGL6xSJBT4ucdxFVuWTk9nHJCCsnXUWFRYxDAFzfEX7m/e22elJurRpEiTs4nneKJIP3gLdXNP3yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703277; c=relaxed/simple;
	bh=RBDEdzaQdli03vB+T8uKUgpDPnZFZUdnv/KLAbiIKTI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BK3E2a/kAEnuqSUMwMUeRnqUC3FPk438ZmiJK+p3kLqwKFvXwVHzNwA1LAJr2xD5I7wEQSBXg25GPEfcLZ+iBamfnkMpSAfNyXjxIXesMt9kF2JisX1AmfE0Q3cNe8KEiqjIWGFkpBdlHtmXMFAzQI3NTRsGAYnpnmkIYjCe9Gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sTQnKt2H; arc=fail smtp.client-ip=40.93.198.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sTQnKt2H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNtfupVv+0Vu3XV0SMxsD5jVnUwVnoP9lUJPc4HBBnFkgQhbriKBTZoXzgZwtR+uEh2qMi/qMw0/UdOdQK8yZLCsZo/0c6WLJRpRFrz1zFhWejrkdJdIG+0oVZEuAeCeg7sWtozZ+Pwb8UJJ0qj7/tu6oQ8SHC5HvViHRF9ExEMH9HltZiYbB+zlC4koPE7lJR0EJqL8DKTUc+i+lmjWVN4p7ZvsiMeCewEKjTBqKTxcBLw3nClG/Uw4InarzdJuP7tJhvM9Lpdh+zNEd8dpuQDjzEWKjRYGjmNGcPAlxrv0QS9BYUhsxVL4y2DjI/bemd7V6buleQ+SMDkvk6zsAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJKMR9jAUIPZr8nm25qd8vkD2UhhV36Gq+aGkj6C46g=;
 b=A7Jv07yZr4Aea5z/SHWBLQlEfL1CqPlpT+NNzSqzvcA0lf3c+kVTptbnjex112eu4Z/0r9zsgIlHSfaL9PZXUSoo1WqxQawubcoIhqhb4YCVySZr5pDbS5QN7waZ9j2F/vB3cqYxPwMdicxmkMKCv9nH+gE9hhu6+M8JAt5sn1nJNVEC55K4u508hmgKptdtphi4jg+ydCKx36IZeQMCwaUVjUytvm5gVEfdXU/ftA7cAOeHkjbsgX+nvqQQ0B5ebdE4dN3yBz6w+kYRQMEZSjO7tDJe3OpJJ6IrvNLhbrn6u4Pj8I5cPQyu4gUDr8+s8y0+zn9bo79znwqxkJ41CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJKMR9jAUIPZr8nm25qd8vkD2UhhV36Gq+aGkj6C46g=;
 b=sTQnKt2HSxNn/oJBG5QG5ka3DwXf6SsoCOJSXeKioEit72u8+Xg3Zpa/4rIUSlgUbzil+xBXgKRfxaAjutxDEEpemMwgx++d84tDnuXBVbS52JrqmGwOZStvrRXbuVY4hGLkM8W1sFLpWaTdsEA66KUwuP+4joEyFme1wI4UHlze4KH9gfbAadV92gk3gumvVsgHAsOpbT8VQZSv9cokELpR1C0nTW2U4Ax6/cueYWJfZ0xHYueQJJOMylsSTJiSVi880J7E0Bl9FMr2hBmzf8emmYhuqeb8d9IXlsNh2GFnPzXlIxAYqiaQwBC16MXTA6tgygffebkHpXlSzmYOHQ==
Received: from PH7PR02CA0022.namprd02.prod.outlook.com (2603:10b6:510:33d::20)
 by CY3PR12MB9632.namprd12.prod.outlook.com (2603:10b6:930:100::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 17:34:28 +0000
Received: from BY1PEPF000264AF.namprd02.prod.outlook.com
 (2603:10b6:510:33d:cafe::8d) by PH7PR02CA0022.outlook.office365.com
 (2603:10b6:510:33d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 17:34:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF000264AF.mail.protection.outlook.com (10.167.242.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 17:34:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 10:33:58 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 10:33:55 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v2 09/16] vfio/pci: Add PCI error recovery state
Date: Tue, 29 Sep 2026 18:32:58 +0100
Message-ID: <20260929173305.204856-10-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264AF:EE_|CY3PR12MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: 787dbf0a-2019-4986-01b6-08df1e4fe9e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gw9ketOBjn+NV7tsed2kMaVXj5v8puensDc4xEp7H5OfxpTxqn7gXWjw4vLSd0scjN1/TlGaULmwRrC4fmQH0UpD8K1tb1BGynpm3Yt4YAQvNFIoNaer/gKWg71TLcvBdh3i0N4C5Z6u3UvyIaCm+qv3VyeuiYnMYSzlmjpDndRYmmOnwPl3WOmwJQZGtBk6M5lsecT4zQGYoSDxI4ljIbSO+TonrkeIA8IoZibwXhUPhRyt7NWQAGtHtMGEQ1oU3U/bL+llrzYbj18muFjI0tHc0mJ8DUHa80DGEb0qESg0FuTB5HgsJlT6SU8zDfK84RwZCqNRKIKpU9BP51Dlx8B2eU3pYprXKpJsqR/ElYEPD3WtXKYLVxqWs4zBdZoWc+sWcNDs6KVX12jqV7XQsNGY3xAHVAwKqW7l2TJ+9LZywnTuKdB0D7DbF1ygrd+M/LQfszcAm9FMbe9hX35oo+mpxbI2QyalntX63hC0sPW8wrOoXyqSFSPflwJUeDJ+1qT+LVQb0FYqq9nDtGrSpAm3EOpkxl9alwbwFF1+bWStxCTQEBgtLLsjUo+PTuR7otwzrZ/787HvaYE+Q0k09g3jmYQkDPqmF2gnP6zMgp/sKCdoYejjwIazwPazv/b53rcP0xiCKnmR9TQXzIEif2Cyln05uPhpFjU85HKuK76upWMDkCv0qVg59G5nMwRSOZZ/ij160X+ZC5V8TPb10Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1+HWWD+ve+RWK3biA/Qm+zR1xB/HdGV4fSeXslga2HblshVlO/6l80MSKeemNrdAi4w8f8A2DlzwdsJxR/ZPk5u7fSD3YyEpKp6BQPsjj2MxhpUL+acPkg+UyZUj5fywUY2+O5BiewOID9sbgrxy0f0cManhpZ3Z/SfgWAIUNMcgnRszBm3E8MPGfbR3j07hgD3tUDGt76ENEOhsJJElOqXBGB5FJyWYNWfrCyAsZiFWXGQtlXX1KgfKKzzA5NSHHZB1NuBqvHMsqd0muEVMFB25TaRus3dXNuUXI2gm5n2gVC3luzrwHitCuO3SbEjIk+p57kjSSXyThBdg4NHVT3sFqgWfx+t38dKAic0tIiyttYqckWmRryu992Ylrbwbzrkd5AkGJu3kjCPeVLcsTfyexlJ9SzpmLtrxuKuAB8YaeYkQtXZriwj7N1Pr0Z+s
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:34:28.3800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 787dbf0a-2019-4986-01b6-08df1e4fe9e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264AF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9632

Add recovery flags, a sequence number, a saved PCI_COMMAND value and an
eventfd for recovery notifications. Initialize the per-open state at
open and clear it at close.

Track the host transaction separately from the userspace session. The
host-active flag survives close so a later patch can reject reopen until
the outstanding recovery completes.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/linux/vfio_pci_core.h    | 19 ++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_core.c | 11 +++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 1dc9630dc740..61d21c3f8089 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -96,6 +96,11 @@ static inline int vfio_pci_core_get_dmabuf_phys(
 }
 #endif
 
+#define VFIO_PCI_RECOVERY_IN_PROGRESS	BIT(0)
+#define VFIO_PCI_RECOVERY_FROZEN	BIT(1)
+#define VFIO_PCI_RECOVERY_RESET		BIT(2)
+#define VFIO_PCI_RECOVERY_FAILED	BIT(3)
+
 struct vfio_pci_core_device {
 	struct vfio_device	vdev;
 	struct pci_dev		*pdev;
@@ -143,6 +148,7 @@ struct vfio_pci_core_device {
 	int			ioeventfds_nr;
 	struct vfio_pci_eventfd __rcu *err_trigger;
 	struct vfio_pci_eventfd __rcu *req_trigger;
+	struct vfio_pci_eventfd __rcu *pci_recovery_trigger;
 	struct eventfd_ctx	*pm_wake_eventfd_ctx;
 	struct list_head	dummy_resources_list;
 	struct mutex		ioeventfds_lock;
@@ -168,7 +174,18 @@ struct vfio_pci_core_device {
 	bool			access_blocked;
 	/* Set after open completes, cleared before close tears down state. */
 	bool			device_open;
-	struct mutex		access_lock;	/* gate flag writers */
+	struct mutex		access_lock;	/* gate and recovery state writers */
+	u32			pci_recovery_flags;
+	u64			pci_recovery_sequence;
+	/* Saved PCI_COMMAND, valid when pci_recovery_command_valid is set. */
+	u16			pci_recovery_command;
+	bool			pci_recovery_enabled;
+	bool			pci_recovery_command_valid;
+	/*
+	 * Host recovery in progress, protected by access_lock. Unlike the
+	 * per-open recovery flags, this is preserved across close.
+	 */
+	bool			pci_recovery_host_active;
 	struct list_head	dmabufs;
 };
 
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 92497224f471..667c5813f6c7 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -845,8 +845,11 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
 
 	if (vdev->pci_recovery_supported) {
 		scoped_guard(mutex, &vdev->access_lock) {
+			WRITE_ONCE(vdev->pci_recovery_enabled, false);
+			vdev->pci_recovery_command_valid = false;
 			WRITE_ONCE(vdev->access_blocked, false);
 			WRITE_ONCE(vdev->device_open, false);
+			WRITE_ONCE(vdev->pci_recovery_flags, 0);
 		}
 	}
 
@@ -866,6 +869,10 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
 	mutex_lock(&vdev->igate);
 	vfio_pci_eventfd_replace_locked(vdev, &vdev->err_trigger, NULL);
 	vfio_pci_eventfd_replace_locked(vdev, &vdev->req_trigger, NULL);
+	if (vdev->pci_recovery_supported)
+		vfio_pci_eventfd_replace_locked(vdev,
+						&vdev->pci_recovery_trigger,
+						NULL);
 	mutex_unlock(&vdev->igate);
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_close_device);
@@ -885,6 +892,10 @@ void vfio_pci_core_finish_enable(struct vfio_pci_core_device *vdev)
 
 	if (vdev->pci_recovery_supported) {
 		guard(mutex)(&vdev->access_lock);
+		WRITE_ONCE(vdev->pci_recovery_flags, 0);
+		vdev->pci_recovery_sequence = 0;
+		vdev->pci_recovery_command_valid = false;
+		WRITE_ONCE(vdev->pci_recovery_enabled, false);
 		WRITE_ONCE(vdev->access_blocked, false);
 		WRITE_ONCE(vdev->device_open, true);
 	}
-- 
2.43.0

