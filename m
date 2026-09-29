Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013000.outbound.protection.outlook.com [40.107.201.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45382545DAF;
	Tue, 29 Sep 2026 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703289; cv=fail; b=L6KOs+4vwUFiw44JxwegBO+QowfQFV3UKu5ZYicLZunOpwAh7fDOxUShPxOxzXYa5JlTF/z8Tg/ili/0d2WYSop5S647RIK/2xfzr6ZD/pPR+Ek6kmOTh/eq2X+80QJqqkK/6LNRjrHb7cma3zQHVE2mJvV6RqHMsAZ5Hvd8yrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703289; c=relaxed/simple;
	bh=qxtEDeONCxrBiYdoD5r/LbtiRZWpfeSaMbtyfKTWFjg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jh23yIUb0MQ6Ed2wx6VvGioBjHhIYTukqOXf56kqkgX47IbGNNQIlXgF82RFf1Iak6pGky8gplKb07zpCcFH9Sz6HN9Zw504ocAW+qwxed1MqCbGXbmyyaCKqz07DXJQjGATTpajiRo8gFcbIFJt6PtPiHmPO0gki9/luZ/2zms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fm+Ny9TO; arc=fail smtp.client-ip=40.107.201.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fm+Ny9TO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UID+cEC1/lFKThr5+41HPKka1IMG1tPy28O8S1mwovzVpBCu9FG3qm8KjtJHSoEMXwDGdNgS4rXM4Mi1bi+r7EO8g9YuALloVyjPbYbVgLVj3DjAXYuy8zqGk6SantnCRIBsuFL/F8vpU/bnc7WgyLX83Br2L1rtp5ejUpiviDC7cI9RYPjdcsbHhSnsHbpdHvBYph65kW7h9YfIgOPnvnwFxeXzqAOiNHBJz0ZVPM06wUpwtkQYR4nKljuBD6jTGTyKvuG5AfcDCirGOaereL8WeG1XtVqyHc4qT0YKl+QVa1YOF7e8NHOKRtANALsDkxrzmGb78OMNWTdpQ6CHsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0DkG5O865jEoyjnK8bZyzAukTQ7p0D9TG7hoXW2Js0=;
 b=of/KkqH8yvD8tFM8rP7uRNk67bjb0aC5zssQCETY6pJwE9kUOC/94UCy12a+eBaBgCW0zJ47FzH4g83uzgNOiwzqP3AYrWPtVI0q6q8S15MbXKmrggtbvaEThBW+ZGo4osPX3y0sVoBip6Q+M57UZhKMgyRi0Q3W5f+82yGHpX8ijeI8/v0IuE0OSy4xvZCYsD43xZz50bv73kH4zif33/Hixwk75cREHCrdFQW20/Cg/oHklw2wUA329ikgYo961lbO029nwDMbDYMzUvT6vUQiRYA0vTX+H7YS2uPIOlOu2ZdFzb2ZYlpVXIHRKNVpLhQCfV6uQyD9wIc++jv7Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0DkG5O865jEoyjnK8bZyzAukTQ7p0D9TG7hoXW2Js0=;
 b=fm+Ny9TOSiFr/oOA/HW+PBH5YJac1WOUJQ2EZKS1el1oYiDar6KpaayNllfeAOEaFbDxT/ZY/5vl0Zj7iMyOmsupCY67pjT2PjTuUyPFDX0BWJKWgCBmjbV5mZ0XFMbGG8FtEqk09kp9d7bJ8Gv3PlLHwcwxEnLUUg1+7uTnIaot7nGlhMvoKFzJo5+2uCsibHELu6gAZo1Qb5tMKmcH20HpDW4lfDav9YLF1xqCXznIDtI4rTo5CPyxkXnRYJ96ICD6YuD7mH+E6hC13i1ggtpNZVgTqKkAQaEMOeYCq5YWAvxU6t0KCfIFv1ChXYakLOWuBde3AUCuGbOSs01nFg==
Received: from PH7PR02CA0010.namprd02.prod.outlook.com (2603:10b6:510:33d::29)
 by DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Tue, 29 Sep
 2026 17:34:38 +0000
Received: from BY1PEPF000264AF.namprd02.prod.outlook.com
 (2603:10b6:510:33d:cafe::93) by PH7PR02CA0010.outlook.office365.com
 (2603:10b6:510:33d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 17:34:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF000264AF.mail.protection.outlook.com (10.167.242.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 17:34:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 10:34:06 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 10:34:03 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v2 11/16] vfio/pci: Add INTx recovery start and finish helpers
Date: Tue, 29 Sep 2026 18:33:00 +0100
Message-ID: <20260929173305.204856-12-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264AF:EE_|DS7PR12MB6095:EE_
X-MS-Office365-Filtering-Correlation-Id: bb46a7a8-034f-4368-a58e-08df1e4fef6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MmApZ8OYs+LCRkNiw6wdokWT6fDWcZcDtK8426Vn6wEc1zBSdSPaGQCvekn0tRxwAAUykWvhovEqbS8bWvtjkdy3Y64zvPFC7Oo9UoD84rL29RNDCIESYAZkRW7RH6qYXAzBt2tL3pVo7HBmgs/dYO6ir4GzwcExASNHpkghVrATCtb9c8o7KTkEjg4detdLzqOukIYo82rTW5FZmBbRqwFImmQoc78OEsVMOLqqQTxkOq9DJR4wisjCDcVeYc22aYsVukqfzq282gUZ3E6rJRAf+aoThRi4TOt3/3Y6XITLue9wvHcJ3QD1dXfKo/13/8XMO+2Nm6zk9rm9axsTrFmOBcHEcL7SFxPi13jNZXm7XmD8Ds8MX+WUT+R69ObeY9rTUbBKEJuh09deC/XzD3Lt6nsXIcpefWcGeo0wGBEJnwuxBxGOdx3Xw7D0V97UL8OvqdZ2f94uaorjt73yZ4SOfJEWvcUkG/UvtQBi1FIcsrmHvGJn/Abgr29iLaDNVd3R6h19qpYhOyAa1Xb8FppcgPzdOHHEmgWYRDydFOTsU5lFllyZ2z4Tt7yArZXkS12WZaNnf7LBx3HYzznLzy+z/iKv45UTfBm765gEoJUzmdefoCWqSd2o1j5esoKLhWdOZBLEZXOyElarOx0DCxywxzJDOBcFjLkRD2lnfMrpdLXnm+hcup9h05Ho34tpweDT4wPvMUflUeRPehC/mg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KjWj/8cVnHTzOBZEXLBIUhGlLWRX9NnfE8wWGmE69XnuxRcaxFmarXZbY+jSssCyGQbosuzrjBM/dej/eQiL8d+61Njz6j6VwrFoSrjsFAmouGvThkK2NP4Ul2tS+2WN2PhNruNQL7KmYQ0b9OazkI38oJqJPqFNnMak1RIu+7sjYI4kO5GbftNfzgfC6Sbu/VzjQlcNAdVCfZpx6rpF7ciJoDmlcyekBHygWu8u71DvfOqmpRBg4cj9QAfYJCaJtgP/w3Mr15jIhASq1IUA18pLrlbYJ4SI5ie89MCJ3VJEzo+5j09vlk/wbGLuIkZSvxfBjhk8RBvVFWqX9io3Z6zofRNtV+iBmLUeYh19NCMrb+S/HmPteH5pDQv7wDOFZu3Yh/BIvE/wTQLAxrijpx3v7L3qDd8Zd1dzqKMIgJ9cXza8ikS1CwbD06N/HVj0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:34:37.6985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb46a7a8-034f-4368-a58e-08df1e4fef6f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264AF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6095

Add helpers to mask INTx at recovery entry and restore it on completion.
Mask INTx at recovery entry even when no interrupt is pending. Record
whether recovery changed the mask so the completion helper can undo it
and apply deferred unmask requests.

Preserve the current INTx mask when restoring PCI_COMMAND. Only update
INTX_DISABLE for devices supporting that bit; other devices use the IRQ
controller mask. Run the completion helper after access is unblocked.

An explicit INTx mask cancels pending recovery unmasking, even if the
interrupt is already masked. This preserves a mask request made after
access reopens but before the recovery completion helper runs.

Assisted-by: LLM
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_priv.h  |  4 ++
 drivers/vfio/pci/vfio_pci_intrs.c | 92 ++++++++++++++++++++++++++++++-
 2 files changed, 93 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index f757e5407ce4..387a831f23c0 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -25,6 +25,10 @@ struct vfio_pci_ioeventfd {
 
 bool vfio_pci_intx_mask(struct vfio_pci_core_device *vdev);
 void vfio_pci_intx_unmask(struct vfio_pci_core_device *vdev);
+void vfio_pci_intx_recovery_start(struct vfio_pci_core_device *vdev);
+void vfio_pci_intx_recovery_finish(struct vfio_pci_core_device *vdev);
+u16 vfio_pci_intx_recovery_update_command(struct vfio_pci_core_device *vdev,
+					  u16 command);
 
 int vfio_pci_eventfd_replace_locked(struct vfio_pci_core_device *vdev,
 				    struct vfio_pci_eventfd __rcu **peventfd,
diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index ff29377c1ae8..d78260776ac1 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -29,6 +29,7 @@ struct vfio_pci_irq_ctx {
 	struct virqfd			*mask;
 	char				*name;
 	bool				masked;
+	bool				recovery_masked;
 	bool				unmask_pending;
 	struct irq_bypass_producer	producer;
 };
@@ -136,6 +137,10 @@ static bool __vfio_pci_intx_mask(struct vfio_pci_core_device *vdev)
 	if (WARN_ON_ONCE(!ctx))
 		goto out_unlock;
 
+	/* An explicit mask supersedes any pending recovery unmask. */
+	ctx->recovery_masked = false;
+	ctx->unmask_pending = false;
+
 	if (!ctx->masked) {
 		/*
 		 * Can't use check_and_mask here because we always want to
@@ -199,6 +204,7 @@ static int vfio_pci_intx_unmask_handler(void *opaque, void *data)
 	}
 
 	ctx->unmask_pending = false;
+	ctx->recovery_masked = false;
 
 	if (ctx->masked && !vdev->virq_disabled) {
 		/*
@@ -238,9 +244,14 @@ void vfio_pci_intx_unmask(struct vfio_pci_core_device *vdev)
 	mutex_unlock(&vdev->igate);
 }
 
-/* Mask INTx for a blocked device. Returns true if this call masked it. */
+/*
+ * Recovery masks INTx unconditionally and records whether to unmask it.
+ * The interrupt handler only masks a pending interrupt, since another
+ * device may share the line.
+ */
 static bool vfio_pci_intx_mask_for_recovery(struct vfio_pci_core_device *vdev,
-					    struct vfio_pci_irq_ctx *ctx)
+					    struct vfio_pci_irq_ctx *ctx,
+					    bool quiesce)
 {
 	lockdep_assert_held(&vdev->irqlock);
 
@@ -249,10 +260,14 @@ static bool vfio_pci_intx_mask_for_recovery(struct vfio_pci_core_device *vdev,
 
 	if (!vdev->pci_2_3)
 		disable_irq_nosync(vdev->pdev->irq);
+	else if (quiesce)
+		pci_intx(vdev->pdev, 0);
 	else if (!pci_check_and_mask_intx(vdev->pdev))
 		return false;
 
 	ctx->masked = true;
+	if (quiesce)
+		ctx->recovery_masked = true;
 	return true;
 }
 
@@ -266,7 +281,7 @@ static irqreturn_t vfio_intx_handler(int irq, void *dev_id)
 	spin_lock_irqsave(&vdev->irqlock, flags);
 	if (unlikely(vfio_pci_recovery_blocks_irq(vdev))) {
 		/* Mask pending INTx to prevent an interrupt storm. */
-		if (vfio_pci_intx_mask_for_recovery(vdev, ctx))
+		if (vfio_pci_intx_mask_for_recovery(vdev, ctx, false))
 			ret = IRQ_HANDLED;
 		else if (ctx->masked && !vdev->pci_2_3)
 			ret = IRQ_HANDLED;
@@ -292,6 +307,77 @@ static irqreturn_t vfio_intx_handler(int irq, void *dev_id)
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
+ * Undo the recovery mask and apply deferred unmask requests.
+ * Call after clearing access_blocked so unmasking is not deferred again.
+ */
+void vfio_pci_intx_recovery_finish(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_pci_irq_ctx *ctx;
+	unsigned long flags;
+	bool replay = false;
+
+	lockdep_assert_held(&vdev->access_lock);
+
+	mutex_lock(&vdev->igate);
+	spin_lock_irqsave(&vdev->irqlock, flags);
+	if (!is_intx(vdev))
+		goto out_unlock;
+
+	ctx = vfio_irq_ctx_get(vdev, 0);
+	if (WARN_ON_ONCE(!ctx))
+		goto out_unlock;
+
+	replay = ctx->recovery_masked || ctx->unmask_pending;
+	ctx->recovery_masked = false;
+	ctx->unmask_pending = false;
+
+out_unlock:
+	spin_unlock_irqrestore(&vdev->irqlock, flags);
+	if (replay)
+		__vfio_pci_intx_unmask(vdev);
+	mutex_unlock(&vdev->igate);
+}
+
 static int vfio_intx_enable(struct vfio_pci_core_device *vdev,
 			    struct eventfd_ctx *trigger)
 {
-- 
2.43.0

