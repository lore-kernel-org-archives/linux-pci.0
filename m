Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493228;
	b=OKsLFB4Mp3vq0ZZOADAdWG8KBYps6ws8yKN0beYUy66bSBDwTPGvGJfZq+/MRmm2/Ccs
	 1PbkV/ws9GkaQWo94WD34UGCLsew/4TFHzRFt5v/UGoAssay0O9N5GuvxHQW2zjyUzZNU
	 +rE98pSaY/naVKqtRkbYgN7wMMcgjqFhvK69DePGlH+Eo/3FS5hT+hWSgoDs8ZAKhMXMv
	 Qi+8t7NzrCjEIJY7Dv9HtBw5UQLmXab/WGQMt44XvhrlEb1Np+8o5dK99bXh+j+xWGp/o
	 umgeew1IKp61TIiXsDztoeEgZMd0sFcqEwVsxLnnybn8pz35CaQ2cnh9BJXdU/H6Now==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493228;
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
	bh=ClXyhC3+RsuUgrJDxd9N8wZMYWV9PGzosE0ADnY/4wI=;
	b=BmJO8fXbfdsqCRfvMdUA5LDrJhWfzOq+f6Bwre0OTGQZxZJnCU9luUd7z47elFsCZVfy
	 s1ySTSIiKXY4cy/XtSHzdqDq3pWj9swGEtuNXgNctDNj9HXb8/yMMvblRzM/jMu5JhA4u
	 ij6xfJZ8hdzs5KbP1PuB1tWQhUSUqlpxUl/AHVTHBVG3wuvZc0DXcg3UVbms9xNtsth8I
	 Kygg6gRIxb3DzRV16xDq9k/eFZZCF9bPgJqaXslplCyxv/YYOU0zfslzBFnk7zTyNh+i8
	 Z9wmsLJNd9n/SZHiiSzGbBRaPK5tvl9DL6F3sIEMSDlgjVRXog8zLq5TM7muuHi7vSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nRCQdrGT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.6
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013006.outbound.protection.outlook.com [40.93.201.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C6B6073789;
	Thu, 12 Nov 2026 14:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50C6B6073789
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nRCQdrGT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rV2MRDYG0zXiYkAJR0B/5u/l51GWzNa7Ifglx0q4Tq0IWkLKqtO8OncTAWjob5UBXcRnpTPsqO1k2HcSMEAtzJJ/dM3T/oqpKA/HGLxN0P1mFrtcg60MGLSh5HoWWUjvdS4Lx0oKrAUx79GoBpekaB3CbnezIwtlp9LmZaCdyp3/4fDghWW8rtRSgEqlzehQazb9tv2S6qDoH+95yqLR7MishtUZ2QzOM+MJZXtci/cPU+gAPbI1/g2X0OQEdBtf4ecHO6MZ1PZr+sGfijbpXKnTeYK4HQNaUuuM/FrTGJhdSG1MbonXHwa5BDaLjQtVGG/ZCHURKAT10TlXhN9djw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClXyhC3+RsuUgrJDxd9N8wZMYWV9PGzosE0ADnY/4wI=;
 b=NdobB8m/yq1XkrGVWZtXxQSJO8ihuly8JcuPHF+JkvavXapGv/46O7l9bkJ44TCXItXBmQF7IZ99BDCeIOFu2JPGYbrcdATaWiviI98L4y97o5l9LQr8GgWXWgxUBI7mh6+69Q04UQ+mAdsAs4SIiHODOeojMdL2zwYF9DpFesHMEHIGPtjce5YzPeRVqssQ8aJ2xSNwSu8drJKn5YvAUgFrNnper6Kw5qy8q3mMGdoAdLDuyCR2f664GwerO75UowJiwt6KsW2MNv8w2eQ4xeksJHNgb7KPUxlPVo6FErFJ+ax7axwigS19/Zf6ft5P/vTiFT7YpHN1w9OPZf74Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClXyhC3+RsuUgrJDxd9N8wZMYWV9PGzosE0ADnY/4wI=;
 b=nRCQdrGTay3XrrfFjmeppNbsJwTPxWHlLsvXqr3bhHABXGEanfFGfCDBn8JzKuBXlG7mrlrgBT1kn+NAgOPKuEpYjloA7LodaW21xxoWSgMkIlgJ3oVhHuafjZa3Jojvd4XJuIzZUoIpG2Fsv9gLoRsrAl0LNahcmtlC3xhyvdeW6eXr70To+9ySh/xuXE++qPkUsUzwExiByRpbtM45uGxIx0zc+EuR6ewTPzEpMaRowV3ylfjcQxDpr/+LA+2rqzx/5jnfs1EaNmUpOI8+aNaRSR6iSrj/8G2h+LTqo9WakBwKaW2+MAwLAAx3GVXoKFL7igO63Xifl01VD2dLFw==
Received: from SJ0PR03CA0219.namprd03.prod.outlook.com (2603:10b6:a03:39f::14)
 by DS7PR12MB6262.namprd12.prod.outlook.com (2603:10b6:8:96::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.9; Thu, 12 Nov 2026 14:19:00 +0000
Received: from BY1PEPF000264B3.namprd02.prod.outlook.com
 (2603:10b6:a03:39f:cafe::50) by SJ0PR03CA0219.outlook.office365.com
 (2603:10b6:a03:39f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 14:19:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF000264B3.mail.protection.outlook.com (10.167.242.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 14:19:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:18:40 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:18:36 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v3 15/20] vfio/pci: Use access ops for SR-IOV configuration and shared reset
Date: Thu, 12 Nov 2026 14:16:27 +0000
Message-ID: <20261112141632.918954-16-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B3:EE_|DS7PR12MB6262:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e4d3924-e378-447c-5272-08df40c7e55f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|18002099003|22082099003|6133799003|11063799006|261026121527099003|261022105027099003|261026140227099003|261022075727099003|261009223027099003|261028144727099003|56012099006|261021123027099003|261021121427099003|261102130727099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	8Q6KVJXI0jA0FRqkGb91rqs4fbaadRAVwUcsilIxxApQYlEo77EKX1XTLvHmrqbS6U/vMgjS1GW+DoEVcHhlfJWcHrR+lF9zsYUuSHy6CNJviP8UfAw5mVtdQtb6T0hPr1MbNG+Xi/bZvwp9buNdJLfTAZW2BneAAt170yEfW+DrTDP+9MjgRRuRLUkdg85DqqAzMwGyY2Qmb9aeFAUVRRyMqOfx86Ymniv2woq8NZT+ixWQkShp99oJCjAIpw4YC4PVTHI2cv4Kv0NHSa3awmAC+TjSr6tbuGErooyuqPAWrhGsXrXl921ilAl+y2laFy9nbzL6f37ghDs93BxASSoiGvG7DqqmxjkVL0jEgvDn8erwch3A8+eTyVPoCv5RjRvmuWti9girG/yvN2tMTk+q5+Z8f6uWNaomvB9T1+qzRx7ITJSjQmojqCX1nTXuJmae5ay/DXJNN++DqibZsxzp9h1rBx1q+o9CquGxSDPdJVHw1QWRgMx03UjIwtu59ptY+UkzuPThYHaoAoOHl/1wHDoPZ9tGEbjV+b6N94u6Jt4j8o74ewPd49TJcW5YwCG6Y8CqIV+7gPE/cW86hDMrkircB4xb2xFP1ayz0QaDOLpGP6W9xooqP+LLBF1vCW46DfXeUUxEWvOR90btMMwDDySrlVtXfW/TEKY0Gp/qL7ncUJmrS5BV4jEkpUsNhsLTi/s8901uZokKBCH0fQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(18002099003)(22082099003)(6133799003)(11063799006)(261026121527099003)(261022105027099003)(261026140227099003)(261022075727099003)(261009223027099003)(261028144727099003)(56012099006)(261021123027099003)(261021121427099003)(261102130727099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	23onQrdvJYLtDS+/vFj7/JwfkBu3YX+0dFfRjCGEBxDIZ9sIYKvPRmg+pDR+yCdSLYnvhXvJLoIRyhXXPbP8BMiXmMxmdZbVh+hOn41JHnB+8VxwPeX7p3Sx0hZwNEIezORYhsHdmdSyL881/aACqoZA91BLdw5un703mq5vj6TuMbBN0brFbzY7Flo+GmCq4caplt2WszvKR0h/gZ7E1qByIzrLKha955v053VxeCESwN3+1L3J46Bv8YcIFsMvcPK1icHeOxF64GaxePEGbWFp7fGfDOOSP1p/4Hs1d5omqCxUSIG+8WxwPfN2SuLh1q2LJvaDx+Vo5v94jVWNHsl69AU3Bampg+U9KdcL+kanDq6mMFWNaz9yojnVubVKVeSfvVSBhkYANV6nEd9e6qzTnlP1JULX0ar9Rub7Z5+te/CNbtFdsqK7BlBi96QF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:19:00.0552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4d3924-e378-447c-5272-08df40c7e55f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6262

SR-IOV configuration and shared hot reset can change device state during
recovery. Both can involve unopened devices, whose per-open SRCU
instance is unavailable.

Select SR-IOV configuration through access ops under the PCI device
lock. Reject requests for open devices while access is blocked, but
preserve configuration of unopened devices. Unregister uses the internal
helper to remove VFs regardless of the selected ops.

Select hot-reset preparation under each device's memory_lock. Reject
open recovering devices, but allow unopened and failed devices so they
do not prevent resetting healthy siblings. Unwind the acquired locks if
preparation fails.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_priv.h |  4 +++
 drivers/vfio/pci/vfio_pci_core.c | 55 +++++++++++++++++++++++++++++---
 2 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index c195ed3e4d9e..e4f3e4f51180 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -100,6 +100,10 @@ struct vfio_pci_access_ops {
 	int (*set_power_state)(struct vfio_pci_core_device *vdev, pci_power_t state);
 	/* Caller holds memory_lock. */
 	void (*restore_dmabufs)(struct vfio_pci_core_device *vdev);
+	/* Caller holds the PCI device lock. The device need not be open. */
+	int (*sriov_configure)(struct vfio_pci_core_device *vdev, int nr_virtfn);
+	/* Caller holds memory_lock for this member of the reset set. */
+	int (*prepare_hot_reset)(struct vfio_pci_core_device *vdev);
 	/* Select and call both INTx methods while holding irqlock. */
 	irqreturn_t (*intx_handler)(struct vfio_pci_core_device *vdev,
 				    struct vfio_pci_irq_ctx *ctx);
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 89cebe2522ba..0ef51810254e 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -312,6 +312,11 @@ static void vfio_pci_probe_power_state(struct vfio_pci_core_device *vdev)
 	vdev->needs_pm_restore = !(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET);
 }
 
+static int vfio_pci_sriov_configure_live(struct vfio_pci_core_device *vdev,
+					 int nr_virtfn);
+static int vfio_pci_prepare_hot_reset(struct vfio_pci_core_device *vdev);
+static int vfio_pci_prepare_hot_reset_blocked(struct vfio_pci_core_device *vdev);
+
 static long vfio_pci_access_live(struct vfio_pci_core_device *vdev,
 				 vfio_pci_access_fn fn, void *data)
 {
@@ -334,10 +339,21 @@ static void vfio_pci_restore_dmabufs_blocked(struct vfio_pci_core_device *vdev)
 {
 }
 
+static int vfio_pci_sriov_configure_blocked(struct vfio_pci_core_device *vdev,
+					    int nr_virtfn)
+{
+	/* SR-IOV can be configured without an open VFIO device. */
+	if (!READ_ONCE(vdev->device_open))
+		return vfio_pci_sriov_configure_live(vdev, nr_virtfn);
+	return -EIO;
+}
+
 static const struct vfio_pci_access_ops vfio_pci_live_ops = {
 	.execute = vfio_pci_access_live,
 	.set_power_state = vfio_pci_try_set_power_state,
 	.restore_dmabufs = vfio_pci_dma_buf_restore,
+	.sriov_configure = vfio_pci_sriov_configure_live,
+	.prepare_hot_reset = vfio_pci_prepare_hot_reset,
 	.intx_handler = vfio_pci_intx_handle,
 	.intx_unmask = vfio_pci_intx_unmask_live,
 };
@@ -346,6 +362,8 @@ static const struct vfio_pci_access_ops vfio_pci_blocked_ops = {
 	.execute = vfio_pci_access_blocked,
 	.set_power_state = vfio_pci_power_blocked,
 	.restore_dmabufs = vfio_pci_restore_dmabufs_blocked,
+	.sriov_configure = vfio_pci_sriov_configure_blocked,
+	.prepare_hot_reset = vfio_pci_prepare_hot_reset_blocked,
 	.intx_handler = vfio_pci_intx_handle_blocked,
 	.intx_unmask = vfio_pci_intx_unmask_blocked,
 };
@@ -2594,7 +2612,7 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_register_device);
 
 void vfio_pci_core_unregister_device(struct vfio_pci_core_device *vdev)
 {
-	vfio_pci_core_sriov_configure(vdev, 0);
+	vfio_pci_sriov_configure_live(vdev, 0);
 
 	vfio_unregister_group_dev(&vdev->vdev);
 
@@ -2622,8 +2640,8 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(struct vfio_pci_core_device *vde
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_aer_err_detected);
 
-int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
-				  int nr_virtfn)
+static int vfio_pci_sriov_configure_live(struct vfio_pci_core_device *vdev,
+					 int nr_virtfn)
 {
 	struct pci_dev *pdev = vdev->pdev;
 	int ret = 0;
@@ -2695,6 +2713,13 @@ int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
 	mutex_unlock(&vfio_pci_sriov_pfs_mutex);
 	return ret;
 }
+
+int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
+				  int nr_virtfn)
+{
+	device_lock_assert(&vdev->pdev->dev);
+	return vfio_pci_access_ops(vdev)->sriov_configure(vdev, nr_virtfn);
+}
 EXPORT_SYMBOL_GPL(vfio_pci_core_sriov_configure);
 
 static bool vfio_dev_in_groups(struct vfio_device *vdev,
@@ -2776,6 +2801,23 @@ static int vfio_pci_dev_set_pm_runtime_get(struct vfio_device_set *dev_set)
 	return ret;
 }
 
+static int vfio_pci_prepare_hot_reset(struct vfio_pci_core_device *vdev)
+{
+	lockdep_assert_held_write(&vdev->memory_lock);
+	vfio_pci_dma_buf_move(vdev, true);
+	vfio_pci_zap_bars(vdev);
+	return 0;
+}
+
+static int vfio_pci_prepare_hot_reset_blocked(struct vfio_pci_core_device *vdev)
+{
+	/* Unopened and failed devices must not prevent a shared reset. */
+	if (READ_ONCE(vdev->device_open) &&
+	    !(READ_ONCE(vdev->pci_recovery_flags) & VFIO_PCI_RECOVERY_FAILED))
+		return -EBUSY;
+	return vfio_pci_prepare_hot_reset(vdev);
+}
+
 static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
 				      struct vfio_pci_group_info *groups,
 				      struct iommufd_ctx *iommufd_ctx)
@@ -2849,8 +2891,11 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
 			break;
 		}
 
-		vfio_pci_dma_buf_move(vdev, true);
-		vfio_pci_zap_bars(vdev);
+		ret = vfio_pci_access_ops(vdev)->prepare_hot_reset(vdev);
+		if (ret) {
+			up_write(&vdev->memory_lock);
+			break;
+		}
 	}
 
 	if (!list_entry_is_head(vdev,
-- 
2.43.0

