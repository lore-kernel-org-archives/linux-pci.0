Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013009.outbound.protection.outlook.com [40.93.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A6A54DAF6;
	Tue, 29 Sep 2026 17:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703279; cv=fail; b=dALYRpdXiyliEbUhTYV+Hcvl5H0C9YU2fPn0H67sTDVuDrJaDAAJ7NtXMyoKTl2bt19trtJQuwBz8epVx0CavzdFi3ritJ8zGxJHLLInSrua4ElZzQbZCCKMzkY4sHVgPDbBq/UeVv2V/2OMIRKMyzpRjGlp62EgpLJcRgOa/x4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703279; c=relaxed/simple;
	bh=N5p5ANMtl5hN2A9eVd9KCMxjNqpUQdyL7T6hPZ6cBCg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQNLoZ3fB29NdegWNbGm1r/wYPm0rJRBw1ESqpIOn8hRYP6EKvEao/a+NrxV4ut8hOMVq5o4G0/2nP9EfivnFK3IbeopTduWQOEewcXHcXCSM5UAfrkUvmQrRA3bhSavhwKXE0DVsRmgNlEy/DjtqxzK7GQqhSTbhLTbGmva2Zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wd9cESop; arc=fail smtp.client-ip=40.93.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wd9cESop"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ghCt+4d/2knnuoBgoENNZJedHPNKlDuP85X92Ho6KPXBl2ysvdqIOWonMqPRpMOMnWjwma5K0cdO88RUKMr3XDv+oIr6hzCaRhoBV8xYxuU375S0VGLVi1a/x8F0+rbDDBlofyqmz0F2WQHiC1Aci2AdvmwjYqvHtCvD7Z+WhbQ7VGWVox7NtBLxqkU+jXBP3QwBat6W/+eF+oyf1idMHTA6XKwgixM6slOWmXKTrIQKQGJp4PGuQT7HSd1BXFE6QdKv/JVOSq4tWe7T4dQAeVtm89jwgYWrkYh8C46s0zjspYkMpGkk0FfckP8dCWvtp8S/hZHFMiYm8PICrxhu4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tl3BD+4aYWUXRpxvTyKjVGnyz0rEsKRjHKMv4yuYH/I=;
 b=g7r8jopQQg6oMGHdx+D7X/KFqrdD6IEmeeB2yzjjgR8vEa+4KrMrUXcjNd0W0qxoEzL1nYDGbERPNAP5/pCOIS73/v1JYcWCOFK6AigYDA2llYdgWCATJyvqPUYhbv41VovcIC0jlEm8cEUe/ZOsbSibvvyGoIjOaT9CqZI2gtAHAde7aaGMzWDQJNhmNtq7D3g5nUkffSljGS0wLvbyTjFxmAmLsHWnrnVdE1+upONWOIRRepPWwvnalZgmqHiPx5bZj6YZ/gXU4Rtz96D1edfK6qeIH94q03pk6OFQ/vQZXiRspBGaDnqJGvbg/VL+9V0M5yzA6OHLDJ1DqFcuFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tl3BD+4aYWUXRpxvTyKjVGnyz0rEsKRjHKMv4yuYH/I=;
 b=Wd9cESopQwpifjx31+j9a/kGzYS9C5gYpF+ZbOgFLN2IQ2RERaZeWI1wVvL4P8q3AfUk63Bamo8evkIAOyhIxgNZRuzQokiM/VYiQXrLwOnRKXZk73QE/jwZKkUY9WJj3Agx/xXdy0VlOg9AnnJxPx6qr2EPe3j2g7N0fytlGBmjUcF2vl9aC+iIazMqV39oXRp9s+NZsmpbRFK0RandvzlWlz3pDTnh+gUiiIWdwVo3FjSAVDiiRGsRiqxoDwnL5P3fXAOIjJnyfn1lrOgMaVfNRfDGV4Eq++i+clS0SoMIonQKbw3c6jD+HiC8aXGs8o9BrZ/9aqvUeApfVs2LMA==
Received: from MN2PR11CA0015.namprd11.prod.outlook.com (2603:10b6:208:23b::20)
 by CH3PR12MB9121.namprd12.prod.outlook.com (2603:10b6:610:1a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 17:34:33 +0000
Received: from BN3PEPF00022BC7.namprd05.prod.outlook.com
 (2603:10b6:208:23b:cafe::a2) by MN2PR11CA0015.outlook.office365.com
 (2603:10b6:208:23b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 17:34:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF00022BC7.mail.protection.outlook.com (10.167.248.212) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 17:34:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 10:34:02 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 10:33:59 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v2 10/16] vfio/pci: Quiesce INTx while access is blocked
Date: Tue, 29 Sep 2026 18:32:59 +0100
Message-ID: <20260929173305.204856-11-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC7:EE_|CH3PR12MB9121:EE_
X-MS-Office365-Filtering-Correlation-Id: 72ec2384-905e-484a-bf2f-08df1e4feccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|22082099003|18002099003|6133799003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	XbITRaTwiMvenDnVm24lOm2CKMkqajmcIrKsC+W/6/xoamxAC6gdhLG0rEWtc3nmCqXq6eseZiIotFmlindTAsOym+xSWlkdkH23EGBPFEHDYYs5y4z4wwn1bhsrkiTgFAu8LV7GfNqCY4OMUE4IbZjCxqZlStqm1ZsyJjGxK3rV3xxp+o8sdQh/oYeC8i6kO4u++mPNPMnQClhe1KLc8+m4gdwBtWCbOdrNqMGw9eHC60BWjKxG/dDEzdz9pyCQQtIPmgBEXuJEFLJsgdhEUptLHuGa2w0xd1Gp+IK3Ekc/EgWMluPw72viTjTSF+3bBIToW4W4il1qQzWHrP0zlGfw1HNn3ogiNCMYlVcKQP8cdhtSFyUjxocTGwyYO4qq42IwW5wMQYTj/e+tqGHDSsZPwtrul22iZLJpsvRINebjbv/Ui4CWDJeXSrftBxASAA+atTvO8fNH9r/xJEvS8/dGwFRN2C4NS96TmHKPgIH9Y7s6sT8EsG2G/92fj0XoiPez8ygVsbwitN1yDhnJY6xaHlR5H5r7iNMnNJ17N695KFDYOv22w4VHTw1lBebU++k7UcJ0Nyot8DL/Sv9Luxk55af1i91Ob5Urc1mA8teOA5ETVt3rCtkwFnKHOX5t+xhFqNHOQ5QcuA5snWjLtVRAK5BkGVh/KlEbVCOAonHWmXLbjAu35r9P9EqyuAttNWJnIQ77QtgWZ/MSsb8R/Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(18002099003)(6133799003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0IJIiXZzFYNVXFKE9mQEVEUpMWbUn+mXn/U3MrxfEIKA2jnfDjCtqCnkVvn0C4An6MslEnOqPA0bZOWjdDxQoVyUTMC98U/6JO4cgKa54sKL7/yO0FURsqPW4QSyaewl0omSFa/s4UgeUDNw05qmRyqEHDDU03tuSS/3KoaMg8HxSuoWEo71XPN6/yUesLWlJGT7nSa+j6vanPwFm2J4H1sKoSYH92CKrJY+mqTpxcEb+i1t9FIeTAqs3v/cXXKGnUP/Hz2DQke5fnQihu59fqzLorMnG/JfKxqA2h+clV7t5Dynrm6iwrJxQ6vlMl8igFjiCThgaDIhhhd8jPmp6DWdmB2OG7n3BaUz0PdpOVhJ91Fk2hNOVzd+2KkNlCgeIZlYg1kTIXI/88Har6MNt3uTHgqfw/VK1ZuqL6m1mlIihvtTWmAwQVJfsnAafe3c
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:34:33.2002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ec2384-905e-484a-bf2f-08df1e4feccb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9121

The INTx handler and unmask virqfd can access PCI_COMMAND without taking
access_srcu. Check the recovery state in these paths under irqlock.

Mask pending INTx while access is blocked to prevent an interrupt storm.
For shared lines, claim only interrupts identified by
pci_check_and_mask_intx(). Record unmask requests for replay when recovery
completes.

Assisted-by: LLM
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_intrs.c | 45 +++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 64f80f64ff57..ff29377c1ae8 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -29,6 +29,7 @@ struct vfio_pci_irq_ctx {
 	struct virqfd			*mask;
 	char				*name;
 	bool				masked;
+	bool				unmask_pending;
 	struct irq_bypass_producer	producer;
 };
 
@@ -49,6 +50,15 @@ static bool is_irq_none(struct vfio_pci_core_device *vdev)
 		 vdev->irq_type == VFIO_PCI_MSIX_IRQ_INDEX);
 }
 
+static bool vfio_pci_recovery_blocks_irq(struct vfio_pci_core_device *vdev)
+{
+	if (!vdev->pci_recovery_supported)
+		return false;
+
+	return READ_ONCE(vdev->pci_recovery_enabled) &&
+	       READ_ONCE(vdev->access_blocked);
+}
+
 static
 struct vfio_pci_irq_ctx *vfio_irq_ctx_get(struct vfio_pci_core_device *vdev,
 					  unsigned long index)
@@ -171,6 +181,12 @@ static int vfio_pci_intx_unmask_handler(void *opaque, void *data)
 	int ret = 0;
 
 	spin_lock_irqsave(&vdev->irqlock, flags);
+	/* Defer unmasking until recovery completes. */
+	if (unlikely(vfio_pci_recovery_blocks_irq(vdev))) {
+		if (is_intx(vdev))
+			ctx->unmask_pending = true;
+		goto out_unlock;
+	}
 
 	/*
 	 * Unmasking comes from ioctl or config, so again, have the
@@ -182,6 +198,8 @@ static int vfio_pci_intx_unmask_handler(void *opaque, void *data)
 		goto out_unlock;
 	}
 
+	ctx->unmask_pending = false;
+
 	if (ctx->masked && !vdev->virq_disabled) {
 		/*
 		 * A pending interrupt here would immediately trigger,
@@ -220,6 +238,24 @@ void vfio_pci_intx_unmask(struct vfio_pci_core_device *vdev)
 	mutex_unlock(&vdev->igate);
 }
 
+/* Mask INTx for a blocked device. Returns true if this call masked it. */
+static bool vfio_pci_intx_mask_for_recovery(struct vfio_pci_core_device *vdev,
+					    struct vfio_pci_irq_ctx *ctx)
+{
+	lockdep_assert_held(&vdev->irqlock);
+
+	if (ctx->masked)
+		return false;
+
+	if (!vdev->pci_2_3)
+		disable_irq_nosync(vdev->pdev->irq);
+	else if (!pci_check_and_mask_intx(vdev->pdev))
+		return false;
+
+	ctx->masked = true;
+	return true;
+}
+
 static irqreturn_t vfio_intx_handler(int irq, void *dev_id)
 {
 	struct vfio_pci_irq_ctx *ctx = dev_id;
@@ -228,6 +264,14 @@ static irqreturn_t vfio_intx_handler(int irq, void *dev_id)
 	int ret = IRQ_NONE;
 
 	spin_lock_irqsave(&vdev->irqlock, flags);
+	if (unlikely(vfio_pci_recovery_blocks_irq(vdev))) {
+		/* Mask pending INTx to prevent an interrupt storm. */
+		if (vfio_pci_intx_mask_for_recovery(vdev, ctx))
+			ret = IRQ_HANDLED;
+		else if (ctx->masked && !vdev->pci_2_3)
+			ret = IRQ_HANDLED;
+		goto out_unlock;
+	}
 
 	if (!vdev->pci_2_3) {
 		disable_irq_nosync(vdev->pdev->irq);
@@ -239,6 +283,7 @@ static irqreturn_t vfio_intx_handler(int irq, void *dev_id)
 		ret = IRQ_HANDLED;
 	}
 
+out_unlock:
 	spin_unlock_irqrestore(&vdev->irqlock, flags);
 
 	if (ret == IRQ_HANDLED)
-- 
2.43.0

