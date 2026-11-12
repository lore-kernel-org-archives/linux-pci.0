Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493144;
	b=DBJ+rtLn1RCq17sSEZHQ4qZTLJRNkTq75gl6aSIINts3xSWXDoiQxMWwK5iZk5yoUewh
	 y8h5HuEbz4Xd8vXeDj4BHi+6au3F+IDirYcsB1aKO0Mp8hboBQ1mzymKfYbntFLezwkh6
	 /QF4pxy0uDXaXZEHSdxwmkMF9sDO53siipUq1Rm8/wpafymXWDcVbOqSnZNGeZkD1jmux
	 Mi6lTb4DNEKg0qonuxzsD7R+Xyo47CD1cr3AtXogN/aYH/54bO8U7MDbRrYQyyWPKNc5L
	 tjyoxqB9NbnKBn+peG8flfbMMMKHMIFvj9KftwdOAPUybQM7Y9RM15qN18fvaSByTWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493144;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=PI0qq3aSAac9+WOcrhCA94dNS2lU5eSUBofGsHZM6xI=;
	b=v45ewE59Y5aeMpbS7JwPEfjnajJJ3/w0YnPfQpjZr29ilU0OYYAsTgLG9rlgk9sgKAzv
	 LN5/PW13+fO0VeRiLqXj/U5+24vNeBsE8qlHoVewAXvup2GXbQOKbQt1SnQW/kuNhBH/6
	 jCeoeDFyEXCCRl8rM0GQmU5s40gzeK6dNgiYaieUjKr5R9Pk9/DZxFi3QfMUE3zU3xnP6
	 TH3QrmlOZw8CmE6ZBte8Ylz/FC7Wp73uGSLgRaEq5F+48Gi2WLkeqzu6SBkpaOjxMXBkE
	 ePN+Bxd1MtKPtyfwUvr04MuOSH9Qn6sokVCGFI4oeOppxs+34IS9t/D2244+c2GfjPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=naDmEPLE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.34
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FCF606A89A;
	Thu, 12 Nov 2026 14:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55FCF606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=naDmEPLE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHCm4xCIhOQyupi2cVHXRv2vbVoKA5bt6X7O/CKleqMhSjk1bsZduNyjLD0UbvU2is6+XwIyZJxCnld9nC4wg0wUKF8MQ5KUGvsUzfi0s0ip7lOe6Zg9yw/O+V8kFJ70DHzVr2jSMnqmZ5erxSFaZ2l0A7dxmFSvbDTRv2DjkgRL6dFS+g/PBQoZFTJS+LwwPhXA5JOxMtEpvli4M/chvvxOmQQIb6EjYWMnexyfDY1NQ6fDpeqkSEJ2iu++3IQnEy/mcex/pNOe9YHWZAmadI8m5qNkYs0uyO5vBTm06TJERxaKGkU9Oob0aAtJi1p1CCFy7GiTRGKFAEldjHTH3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PI0qq3aSAac9+WOcrhCA94dNS2lU5eSUBofGsHZM6xI=;
 b=Dx5sDk6IYD/vdoBYna3hrhtJNgfgb7Cp/SFuNEzIf/R/AYAo70bLW1moTx8iOFPkYzMp4tKYWRJ2MhgpMPyJc42jr/xhPgMVkObMV3vQjWayVqIVRYRk4fVhPCzTNVawKRcz71K/5bpXIDEgmBDQiqi+oucAOnzAnh5pj3EL9bUg+7/+7vjdpCm7wH9Qv9bQOa5UoPopPUjKXlNobF9GtQxjv5LtSuu2syVdG7gFX1lNbY+sEC1xtb/3d0LxpcJwyG3loqbVYAcMVlRcNDNqvx30gA4AKUtYOU5OqWs6lgv6TZcUPJYDQG6dPwom0uRWa2vvJUc2FJui3BJ1uKktlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PI0qq3aSAac9+WOcrhCA94dNS2lU5eSUBofGsHZM6xI=;
 b=naDmEPLEVuVFx+Zsm69cXlnQhG3axKIkrMYWhiepRlfARqylZKaKgq4ue8/li3Y64/F5P2I13PrkacfmwcKkJxepN/gXql/KxuvG5RysnrIdmeTOUtPr6r22nQN2q4KKjengi88UHEunyiTA+JKebJD+yNDB4uXcoMSqkfUnAXm0P80HQUQQwjL3pRT3bI6xV95B0f99+97GLgY2hhtv94CIVYbD93L0/31DxYg37uB2RdgenDX6sEXa53YvwhCnR74Pm6SSR8phc88VnKMskrQrLFdKd9vJc+taqKoPabM6L0tVIVMVQ8t1EEhJ5ZSCJui2/24NKnM7VTGidw6gQA==
Received: from BY3PR05CA0016.namprd05.prod.outlook.com (2603:10b6:a03:254::21)
 by CH3PR12MB081100.namprd12.prod.outlook.com (2603:10b6:610:39e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 14:18:57 +0000
Received: from BY1PEPF000264B5.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::2a) by BY3PR05CA0016.outlook.office365.com
 (2603:10b6:a03:254::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Thu, 12
 Nov 2026 14:18:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF000264B5.mail.protection.outlook.com (10.167.242.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 14:18:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:18:36 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:18:32 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v3 14/20] vfio/pci: Add INTx recovery operations
Date: Thu, 12 Nov 2026 14:16:26 +0000
Message-ID: <20261112141632.918954-15-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112141632.918954-1-skolothumtho@nvidia.com>
References: <20261112141632.918954-1-skolothumtho@nvidia.com>
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
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B5:EE_|CH3PR12MB081100:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b105697-be99-44bd-652a-08df40c7e3be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|10067099003|11063799006|56012099006|261022105027099003|261022075727099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261021121427099003|261102130727099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	n1ynTJPe+VYe3Ci84zFLruqmGrD+xd5cTbVTp8OT5bMvOl9R8GZcdXxFdA5zzvivl2dKmiG1kme6Md4q0y4Rckfb8qNnh1SvQNkYXMKje/UvMrobegRSW+gf+D4t8CHp96yGfVsXqP57JZpJrW5qI+Kc2ikjyInCRuYSQVV46vL2ErQX+KrOuVVvm4555tPuWkO6E6N1xCiPoal5iSOrHof6/ezonJPSURp1DOk2dkvJrCFYrUSxVZ7pi7fVoVkYs40CMd6xA/BryDCEiUX7stRo4TMXULUGOidsUh8f0uIPp9jN8dNKfXyLTxWMYvHDGBkl8Ys0N5Y5iNQ1+qNVkizvxJ85DNvYPaw2RSRfhjP6eYpEh8aK5oo0oQGQpoYH+ReQWLOQnXS5WHi/h63m+Yi8W1GDi+vMpSyQYFaIopL/t7X39wzdmNIuDqMz8fPJPpBkdA/jJRgV9tFCcvwaRpRzcAQzZA/URuS/UhxVsYAkkj0OztLKK4HCtWm6hzvF+gD/Qlw55m0oW4nYsiEenRdlMR6dRyC7P6ZK29jnAtpNjWufawSUxQ4tGvESNwheYM1ag36yAzgR7MjILd/D4xWshj5JYEe8iOKJSN2t9r3fObJmC/DQXmIjwQZw40tK3qjcQlumgzkIOoYMxSsGfnKiBSlX10vNZfBrveyhh7N658wi/3lN4GL3yHX4Sp2jawLdB9Ssvi5XXKNCa1Upow==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003)(261102130727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Nwn6sVopGOiLHvVwzEePvzsTdA+mk0c7x4y0A/o31OH9OBOpvtyK3HydtR8BeEWtx80ufX4P9AMRS58WtX26YLX8aIPi2Yqyc9FK7qb4OemUwOtOvOjL/HA+76LRXXS1mNp+tnKi4zx9mSV5IXYKdS/8AwQdUOC6g+oizyASjx02PCxLBnk1qj/mg7rSH2xDUGFyx6d+zvz71pVdoepeWKZaJdD2DHpL0aNmJs0SOmfix7H/7JHVu1xSN8LYJsBgSWZGhsLDffpiZab+422B0HRRUpQZMuJYle/LVk7GbPYNF4n62ecAckSzrafLWT7hvEAo85G85P140d537B9BhkxtU+FnabMVm6WXzB+wMt67E6U6I1+K25ycKuB12UjhXnvbNkZQldg9zP3Lv9q2paVlPxp00jjN7voHS0uUjkm+aQxDZ2JeeWmqSvyHspOT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:18:57.3234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b105697-be99-44bd-652a-08df40c7e3be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB081100

Physical INTx interrupts and eventfd unmask requests can arrive while
device access is blocked for recovery. Add blocked operations that
remember unmask requests and keep masking pending interrupts on shared
lines. An explicit mask cancels a pending unmask request.

Select and call INTx operations under irqlock, and hold the same lock
when switching access ops. Process pending unmask requests and publish
live ops under irqlock so requests cannot be lost between these steps.
Keep closed and failed devices blocked.

Provide helpers to mask INTx at recovery entry and preserve its mask
when restoring PCI_COMMAND. The completion caller holds igate and
memory_lock through restoration, then sends any resulting INTx
notification after releasing memory_lock and irqlock.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_priv.h  |  22 ++++
 include/linux/vfio_pci_core.h     |   2 +-
 drivers/vfio/pci/vfio_pci_core.c  |  23 ++++
 drivers/vfio/pci/vfio_pci_intrs.c | 183 ++++++++++++++++++++++++++----
 4 files changed, 209 insertions(+), 21 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index b02fd1fbcd31..c195ed3e4d9e 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -3,6 +3,7 @@
 #define VFIO_PCI_PRIV_H
 
 #include <linux/vfio_pci_core.h>
+#include <linux/irqreturn.h>
 
 /* Special capability IDs predefined access */
 #define PCI_CAP_ID_INVALID		0xFF	/* default raw access */
@@ -25,6 +26,11 @@ struct vfio_pci_ioeventfd {
 
 bool vfio_pci_intx_mask(struct vfio_pci_core_device *vdev);
 void vfio_pci_intx_unmask(struct vfio_pci_core_device *vdev);
+void vfio_pci_intx_recovery_start(struct vfio_pci_core_device *vdev);
+bool vfio_pci_intx_recovery_finish(struct vfio_pci_core_device *vdev);
+void vfio_pci_intx_recovery_signal(struct vfio_pci_core_device *vdev);
+u16 vfio_pci_intx_recovery_update_command(struct vfio_pci_core_device *vdev,
+					  u16 command);
 
 int vfio_pci_eventfd_replace_locked(struct vfio_pci_core_device *vdev,
 				    struct vfio_pci_eventfd __rcu **peventfd,
@@ -84,6 +90,8 @@ typedef long (*vfio_pci_access_fn)(struct vfio_pci_core_device *vdev,
 long vfio_pci_core_access(struct vfio_pci_core_device *vdev,
 			  vfio_pci_access_fn fn, void *data);
 
+struct vfio_pci_irq_ctx;
+
 struct vfio_pci_access_ops {
 	/* Select and call within SRCU. The callback receives kernel buffers. */
 	long (*execute)(struct vfio_pci_core_device *vdev,
@@ -92,10 +100,24 @@ struct vfio_pci_access_ops {
 	int (*set_power_state)(struct vfio_pci_core_device *vdev, pci_power_t state);
 	/* Caller holds memory_lock. */
 	void (*restore_dmabufs)(struct vfio_pci_core_device *vdev);
+	/* Select and call both INTx methods while holding irqlock. */
+	irqreturn_t (*intx_handler)(struct vfio_pci_core_device *vdev,
+				    struct vfio_pci_irq_ctx *ctx);
+	int (*intx_unmask)(struct vfio_pci_core_device *vdev,
+			   struct vfio_pci_irq_ctx *ctx);
 };
 
 const struct vfio_pci_access_ops *
 vfio_pci_access_ops(struct vfio_pci_core_device *vdev);
+void vfio_pci_restore_access(struct vfio_pci_core_device *vdev);
+irqreturn_t vfio_pci_intx_handle(struct vfio_pci_core_device *vdev,
+				 struct vfio_pci_irq_ctx *ctx);
+irqreturn_t vfio_pci_intx_handle_blocked(struct vfio_pci_core_device *vdev,
+					 struct vfio_pci_irq_ctx *ctx);
+int vfio_pci_intx_unmask_live(struct vfio_pci_core_device *vdev,
+			      struct vfio_pci_irq_ctx *ctx);
+int vfio_pci_intx_unmask_blocked(struct vfio_pci_core_device *vdev,
+				 struct vfio_pci_irq_ctx *ctx);
 
 #ifdef CONFIG_VFIO_PCI_IGD
 bool vfio_pci_is_intel_display(struct pci_dev *pdev);
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index f2b64420cb07..fadbbaa58770 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -160,7 +160,7 @@ struct vfio_pci_core_device {
 	struct notifier_block	nb;
 	struct rw_semaphore	memory_lock;
 	struct srcu_struct	access_srcu;
-	/* Updated under access_lock. */
+	/* Updated under access_lock and irqlock. */
 	const struct vfio_pci_access_ops __rcu *access_ops;
 	/* Set after open completes, cleared before close tears down state. */
 	bool			device_open;
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index cdc6bafe9861..89cebe2522ba 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -338,12 +338,16 @@ static const struct vfio_pci_access_ops vfio_pci_live_ops = {
 	.execute = vfio_pci_access_live,
 	.set_power_state = vfio_pci_try_set_power_state,
 	.restore_dmabufs = vfio_pci_dma_buf_restore,
+	.intx_handler = vfio_pci_intx_handle,
+	.intx_unmask = vfio_pci_intx_unmask_live,
 };
 
 static const struct vfio_pci_access_ops vfio_pci_blocked_ops = {
 	.execute = vfio_pci_access_blocked,
 	.set_power_state = vfio_pci_power_blocked,
 	.restore_dmabufs = vfio_pci_restore_dmabufs_blocked,
+	.intx_handler = vfio_pci_intx_handle_blocked,
+	.intx_unmask = vfio_pci_intx_unmask_blocked,
 };
 
 /*
@@ -362,12 +366,27 @@ vfio_pci_access_ops(struct vfio_pci_core_device *vdev)
 /* Block new operations and drain ordinary accesses before teardown or recovery. */
 static void vfio_pci_core_block_access(struct vfio_pci_core_device *vdev)
 {
+	unsigned long flags;
+
 	lockdep_assert_held(&vdev->access_lock);
+	spin_lock_irqsave(&vdev->irqlock, flags);
 	rcu_assign_pointer(vdev->access_ops, &vfio_pci_blocked_ops);
+	spin_unlock_irqrestore(&vdev->irqlock, flags);
 
 	synchronize_srcu(&vdev->access_srcu);
 }
 
+/* Caller finishes internal restoration before allowing ordinary access. */
+void vfio_pci_restore_access(struct vfio_pci_core_device *vdev)
+{
+	lockdep_assert_held(&vdev->access_lock);
+	lockdep_assert_held(&vdev->irqlock);
+	if (vdev->device_open &&
+	    !(vdev->pci_recovery_flags &
+	      (VFIO_PCI_RECOVERY_IN_PROGRESS | VFIO_PCI_RECOVERY_FAILED)))
+		rcu_assign_pointer(vdev->access_ops, &vfio_pci_live_ops);
+}
+
 long vfio_pci_core_access(struct vfio_pci_core_device *vdev,
 			  vfio_pci_access_fn fn, void *data)
 {
@@ -965,13 +984,17 @@ void vfio_pci_core_finish_enable(struct vfio_pci_core_device *vdev)
 	}
 
 	if (vdev->pci_recovery_supported) {
+		unsigned long flags;
+
 		guard(mutex)(&vdev->access_lock);
 		WRITE_ONCE(vdev->pci_recovery_flags, 0);
 		vdev->pci_recovery_sequence = 0;
 		vdev->pci_recovery_command_valid = false;
 		WRITE_ONCE(vdev->pci_recovery_enabled, false);
 		WRITE_ONCE(vdev->device_open, true);
+		spin_lock_irqsave(&vdev->irqlock, flags);
 		rcu_assign_pointer(vdev->access_ops, &vfio_pci_live_ops);
+		spin_unlock_irqrestore(&vdev->irqlock, flags);
 	}
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_finish_enable);
diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 64f80f64ff57..f78c7217017d 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -29,6 +29,8 @@ struct vfio_pci_irq_ctx {
 	struct virqfd			*mask;
 	char				*name;
 	bool				masked;
+	bool				recovery_masked;
+	bool				unmask_pending;
 	struct irq_bypass_producer	producer;
 };
 
@@ -126,6 +128,10 @@ static bool __vfio_pci_intx_mask(struct vfio_pci_core_device *vdev)
 	if (WARN_ON_ONCE(!ctx))
 		goto out_unlock;
 
+	/* An explicit mask cancels any unmask request saved during recovery. */
+	ctx->recovery_masked = false;
+	ctx->unmask_pending = false;
+
 	if (!ctx->masked) {
 		/*
 		 * Can't use check_and_mask here because we always want to
@@ -162,16 +168,13 @@ bool vfio_pci_intx_mask(struct vfio_pci_core_device *vdev)
  * a signal is necessary, which can then be handled via a work queue
  * or directly depending on the caller.
  */
-static int vfio_pci_intx_unmask_handler(void *opaque, void *data)
+int vfio_pci_intx_unmask_live(struct vfio_pci_core_device *vdev,
+			      struct vfio_pci_irq_ctx *ctx)
 {
-	struct vfio_pci_core_device *vdev = opaque;
 	struct pci_dev *pdev = vdev->pdev;
-	struct vfio_pci_irq_ctx *ctx = data;
-	unsigned long flags;
 	int ret = 0;
 
-	spin_lock_irqsave(&vdev->irqlock, flags);
-
+	lockdep_assert_held(&vdev->irqlock);
 	/*
 	 * Unmasking comes from ioctl or config, so again, have the
 	 * physical bit follow the virtual even when not using INTx.
@@ -179,9 +182,12 @@ static int vfio_pci_intx_unmask_handler(void *opaque, void *data)
 	if (unlikely(!is_intx(vdev))) {
 		if (vdev->pci_2_3)
 			pci_intx(pdev, 1);
-		goto out_unlock;
+		goto out;
 	}
 
+	ctx->unmask_pending = false;
+	ctx->recovery_masked = false;
+
 	if (ctx->masked && !vdev->virq_disabled) {
 		/*
 		 * A pending interrupt here would immediately trigger,
@@ -197,9 +203,28 @@ static int vfio_pci_intx_unmask_handler(void *opaque, void *data)
 		ctx->masked = (ret > 0);
 	}
 
-out_unlock:
-	spin_unlock_irqrestore(&vdev->irqlock, flags);
+out:
+	return ret;
+}
 
+int vfio_pci_intx_unmask_blocked(struct vfio_pci_core_device *vdev,
+				 struct vfio_pci_irq_ctx *ctx)
+{
+	lockdep_assert_held(&vdev->irqlock);
+	if (is_intx(vdev))
+		ctx->unmask_pending = true;
+	return 0;
+}
+
+static int vfio_pci_intx_unmask_handler(void *opaque, void *data)
+{
+	struct vfio_pci_core_device *vdev = opaque;
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&vdev->irqlock, flags);
+	ret = vfio_pci_access_ops(vdev)->intx_unmask(vdev, data);
+	spin_unlock_irqrestore(&vdev->irqlock, flags);
 	return ret;
 }
 
@@ -220,33 +245,151 @@ void vfio_pci_intx_unmask(struct vfio_pci_core_device *vdev)
 	mutex_unlock(&vdev->igate);
 }
 
-static irqreturn_t vfio_intx_handler(int irq, void *dev_id)
+/*
+ * Recovery always masks INTx and remembers whether to unmask it afterward.
+ * The interrupt handler masks INTx only if this device has a pending
+ * interrupt, since another device may share the line.
+ */
+static bool vfio_pci_intx_mask_for_recovery(struct vfio_pci_core_device *vdev,
+					    struct vfio_pci_irq_ctx *ctx,
+					    bool quiesce)
 {
-	struct vfio_pci_irq_ctx *ctx = dev_id;
-	struct vfio_pci_core_device *vdev = ctx->vdev;
-	unsigned long flags;
-	int ret = IRQ_NONE;
+	lockdep_assert_held(&vdev->irqlock);
 
-	spin_lock_irqsave(&vdev->irqlock, flags);
+	if (ctx->masked)
+		return false;
 
+	if (!vdev->pci_2_3)
+		disable_irq_nosync(vdev->pdev->irq);
+	else if (quiesce)
+		pci_intx(vdev->pdev, 0);
+	else if (!pci_check_and_mask_intx(vdev->pdev))
+		return false;
+
+	ctx->masked = true;
+	if (quiesce)
+		ctx->recovery_masked = true;
+	return true;
+}
+
+irqreturn_t vfio_pci_intx_handle(struct vfio_pci_core_device *vdev,
+				 struct vfio_pci_irq_ctx *ctx)
+{
+	lockdep_assert_held(&vdev->irqlock);
 	if (!vdev->pci_2_3) {
 		disable_irq_nosync(vdev->pdev->irq);
 		ctx->masked = true;
-		ret = IRQ_HANDLED;
-	} else if (!ctx->masked &&  /* may be shared */
-		   pci_check_and_mask_intx(vdev->pdev)) {
+		return IRQ_HANDLED;
+	}
+	if (!ctx->masked && pci_check_and_mask_intx(vdev->pdev)) {
 		ctx->masked = true;
-		ret = IRQ_HANDLED;
+		return IRQ_HANDLED;
 	}
+	return IRQ_NONE;
+}
+
+irqreturn_t vfio_pci_intx_handle_blocked(struct vfio_pci_core_device *vdev,
+					 struct vfio_pci_irq_ctx *ctx)
+{
+	lockdep_assert_held(&vdev->irqlock);
+	/* A shared interrupt line still needs pending INTx to be masked. */
+	if (vfio_pci_intx_mask_for_recovery(vdev, ctx, false) ||
+	    (ctx->masked && !vdev->pci_2_3))
+		return IRQ_HANDLED;
+	return IRQ_NONE;
+}
+
+static irqreturn_t vfio_intx_handler(int irq, void *dev_id)
+{
+	struct vfio_pci_irq_ctx *ctx = dev_id;
+	struct vfio_pci_core_device *vdev = ctx->vdev;
+	unsigned long flags;
+	irqreturn_t ret;
 
+	spin_lock_irqsave(&vdev->irqlock, flags);
+	ret = vfio_pci_access_ops(vdev)->intx_handler(vdev, ctx);
 	spin_unlock_irqrestore(&vdev->irqlock, flags);
 
 	if (ret == IRQ_HANDLED)
 		vfio_send_intx_eventfd(vdev, ctx);
-
 	return ret;
 }
 
+void vfio_pci_intx_recovery_start(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_pci_irq_ctx *ctx;
+	unsigned long flags;
+
+	lockdep_assert_held(&vdev->access_lock);
+
+	spin_lock_irqsave(&vdev->irqlock, flags);
+	if (!is_intx(vdev))
+		goto out_unlock;
+
+	ctx = vfio_irq_ctx_get(vdev, 0);
+	if (WARN_ON_ONCE(!ctx))
+		goto out_unlock;
+
+	vfio_pci_intx_mask_for_recovery(vdev, ctx, true);
+
+out_unlock:
+	spin_unlock_irqrestore(&vdev->irqlock, flags);
+}
+
+/* Preserve the current INTx mask when restoring PCI_COMMAND. */
+u16 vfio_pci_intx_recovery_update_command(struct vfio_pci_core_device *vdev,
+					  u16 command)
+{
+	struct vfio_pci_irq_ctx *ctx;
+
+	lockdep_assert_held(&vdev->irqlock);
+
+	if (!vdev->pci_2_3 || !is_intx(vdev))
+		return command;
+
+	ctx = vfio_irq_ctx_get(vdev, 0);
+	if (ctx && ctx->masked)
+		command |= PCI_COMMAND_INTX_DISABLE;
+
+	return command;
+}
+
+/*
+ * Restore INTx and allow ordinary access under the same lock. An unmask
+ * request must either be replayed here or reach the live op afterward.
+ */
+bool vfio_pci_intx_recovery_finish(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_pci_irq_ctx *ctx = NULL;
+	unsigned long flags;
+	int ret = 0;
+
+	lockdep_assert_held(&vdev->access_lock);
+	lockdep_assert_held(&vdev->igate);
+	lockdep_assert_held_write(&vdev->memory_lock);
+	spin_lock_irqsave(&vdev->irqlock, flags);
+	if (!is_intx(vdev))
+		goto out_restore;
+
+	ctx = vfio_irq_ctx_get(vdev, 0);
+	if (WARN_ON_ONCE(!ctx))
+		goto out_restore;
+
+	if (ctx->recovery_masked || ctx->unmask_pending)
+		ret = vfio_pci_intx_unmask_live(vdev, ctx);
+
+out_restore:
+	vfio_pci_restore_access(vdev);
+	spin_unlock_irqrestore(&vdev->irqlock, flags);
+	return ret > 0;
+}
+
+void vfio_pci_intx_recovery_signal(struct vfio_pci_core_device *vdev)
+{
+	lockdep_assert_held(&vdev->igate);
+	vfio_send_intx_eventfd(vdev, vfio_irq_ctx_get(vdev, 0));
+}
+
 static int vfio_intx_enable(struct vfio_pci_core_device *vdev,
 			    struct eventfd_ctx *trigger)
 {
-- 
2.43.0

