Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493155;
	b=FerDMp2Y3S1uKDrnFSxcZ2YyuoFpqsIV/um0aF+tNPBBTvhdW/U1y31Y/7G9HEe/zNmw
	 LBr6typyo+zBJ4taHYXkP00AQy5BmY3S8c9ys5xcIEzD7Lu/RFLFhWCbEoWJ3k2frT+zb
	 tmOKrAeAZ2sHRQM2bhd5AACURy+RgjFSxxvaHx1AytVXtzC+caZCs2cxjT6YwZ30S6doQ
	 7ETVLqx9lcDMeWLkIQJtfUzcgvPsz+R+W0RT4Bu3Eb/Tm1t0yEPlgXrvxaZStaT/4kI7Q
	 vUpg39yF4mW94QK7aIzRNvySnXHQ4KJ566eYM4BODqq06MKZlUt7GKE19IvpuUjnYQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493155;
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
	bh=ZHQG/EZam0lVZOGhACBKwyhCNWg9IRYe9mT3flP70Ow=;
	b=OUk5PpRhHrNm1I6yIh5hO7jF7qbUIXNQnAhiGmW7p/KHqVoJxPuqhXRByLQQopqtlCXR
	 3lCJQ1tYujQ+84ORe4R7TQKm3ZQMn1Iq3nADTXNi4Uetn1CYETE5WdlX5jRaQ1iYVNeRJ
	 q3DaUKhPRkDURy0D/ASV7Zmaw+NYtXIEmSkbzCmed0EuRRGJfEjdZmETaGHq9Uaw+crPr
	 DR+GgLxZNN5XGJJcEWKL27YiwBYTUfn+zDCRdpZOBK/uASNxIgti8XIyUHe4qZithcK6p
	 H1BWruBJCZe9xAMRWwst+n+CB2sqm9CjjfqsjlNRrBGKhCnz3HfqnJP2MlcFqjG6qLw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=g1pkntYu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.27
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013027.outbound.protection.outlook.com [40.107.201.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40746606A338;
	Thu, 12 Nov 2026 14:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40746606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=g1pkntYu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/32kPFppX64xnI67FI01xFwR1EUwFwzzJiTd9yotqDN9j7Tlp9+AzrESijSLYhFRF9eWBSis/qWcfathSEIvNuYEePcjMQkDepefohtqTrAvFk+hb4D3obLWGaG0DWjSbcjQL+27Un2tb36BuXgKGN+yVl58jwomMkjjg7KC+q4q451spG74uKqWZsRD3GAdRrumSDMIoIWpc1rvCBlYVGu7oOcm/4nYBEetdrE7H9DSCRvpnDcO9mGpe5bOKQh9FpSec+gE/XXmK+7QXbd2a3ufO9+Euu3yeEIG1y6IsYbDmrljr5pHeqMeYyukT3EI0dERi4k0oZpafJnHt6RFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHQG/EZam0lVZOGhACBKwyhCNWg9IRYe9mT3flP70Ow=;
 b=UA3UCWCNJyVaf9Xr9iwUgLT0IpurzpDIjX/ig9oasPnYpv8J/or+0J6cdmpxCNMqISRNNG9WxbAshE/FGWImNNT3Sg4QhJNNqzQbOKxIKVtnXGzfjNNCecZgnYcDuKWq8SuDDkLa+0W+utmgIBdvaVz/BfkSRYesUyqDZOamTitetblEkT59G825nEN6xEJ1fOh6tNmcghquIHx4s9XoGXp0exKukzpoD6ntu1q+MGYtNxrMzCoX6hq7q+/6PihdMXq5rBF8tpUcgCzZ8rPYKiGn+jtG+TEgviXo3GF0CFmVzs2Jlq6FHA0F3cmouw7ZAHiRTI0ahBGG/psHqYwOYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHQG/EZam0lVZOGhACBKwyhCNWg9IRYe9mT3flP70Ow=;
 b=g1pkntYusQfoPj6NkMIYZFtk+//AXAF3PIcSpQVKZZaRK/4wUlNTcqoQnY7N+hJ96NOSZfdl3Tcdf+KEOILa9UFurldsk/cvD/s74lLAtISAe7GbGlzsNvZY24wB5IUTF/KQ7VkkbcSG9r6OFJV1G20i4sTm78ArHNrQF6rAEowVHNtWLEx7qepLDxXG1qBKKYuWe1OsprqINKPFFGa6uwOf6EoJkvEWre3lF7VDxjnLYmGVG+69VYUGpp+m/DR0gpix7kGf8IKKa5JYqw7pp50njq0x5zRoOJK/+xaBymElp7AJSVpdeK6Yz0ZiM8KaMIyGSVc5IGGgvuV18i5LJQ==
Received: from SJ0PR13CA0113.namprd13.prod.outlook.com (2603:10b6:a03:2c5::28)
 by DS6PR12MB646826.namprd12.prod.outlook.com (2603:10b6:8:4b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 14:19:11 +0000
Received: from BY1PEPF000264B6.namprd02.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::49) by SJ0PR13CA0113.outlook.office365.com
 (2603:10b6:a03:2c5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Thu, 12
 Nov 2026 14:19:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF000264B6.mail.protection.outlook.com (10.167.242.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 14:19:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:18:51 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:18:48 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v3 18/20] vfio/pci: Block device access during host recovery
Date: Thu, 12 Nov 2026 14:16:30 +0000
Message-ID: <20261112141632.918954-19-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B6:EE_|DS6PR12MB646826:EE_
X-MS-Office365-Filtering-Correlation-Id: 0949f8d5-353a-46c4-38d5-08df40c7ec2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|22082099003|18002099003|6133799003|261009223027099003|56012099006|11063799006|261028144727099003|261021121427099003|261102130727099003|261102123227099003|261026140227099003|261026121527099003|261021123027099003|261022105027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	LsstoXL04QC969cHtKFsYl1thNT1gEwVIOwC5OkOYsYkuzLRLEqK+DLVRQ0dCWCmS6yee7Axv8J8Ki2YbihPk361IQZ6joOUaJd49SFpO5HtaOK1n09iithMFZfc6bx4idMup2+9IGWm08CSPk0cCu23phRVVMarpUbPTFhMibFXEyNDBZxbNEEF7QEtj2mD6wfXC05tddScUtlgfUJxOTw/ut9VReIsOatsdYbU5U/5cfUHBTjJaQpen43cYiniwjnhRE3ysKJWRyNqa9gye+ofgBkPSmhoVVBSwBUhIPRyPpBDnKHVA8OE6m4TopnVk1spPNycZxKx6kvdNW7vx6d1aqqFeU59/45t6jafSXDb8pW7vyJ9Yko7uVJHTCTzAIKhoWUUty7hh+p2Rq5jti9yO5Mw+FD7dWn95bP6JxLRllhSl6gVYWqBPmFRu2gsPuMKBEhSFNPBKRipoXKTWmSbPtbkBZ6yp2YM53h0aQNM4hmAMo20xdf6Rxh0t3fJW8AMTIQF0hffSYReFoUV5U4Fo+Yq/+QTGdkgvRqwB5B+ptageJQCFI81/dSbQFOjD5GP64neMr9p49gjJZeuCxcKWNUKaM/F+q+S3bBueiCtBvoZoDlXtXoJuxDMKX+VoKiGhKmbFlyHJMXNVm5kozZtn2cX9Ic2UQJqD2mnkCkMx2ckVSo0Rv1c8Jm+oeCVVhZOwX4LmzEUbL7kIsEx8A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(261009223027099003)(56012099006)(11063799006)(261028144727099003)(261021121427099003)(261102130727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261021123027099003)(261022105027099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dajhRmkVzsi2i9g0yyWBcg+AvRrnH9yqs3mAxy5sdpEE92RzNzM3DmN6TcIZYbsBYg1RioRzAmr8f1eeHYfO+oepIKTqEGwKD3SjERowRBToAmw4eH8OohoxavzxOIEv0qRQ2nXQ+Xo/mGfLALTZFFyge7y4OU/Gdt4sMFvH17EW+FO1xIL3P7H2CA7Glw00YlNqvfLX0fi3O75cd/B3XxLHlJvcvX6ashgH2NjLyHF3DiN41E0bxSd9IqVlIVXTzqIi6oCDLfH53RLQHp8v87S179Rr/UcvfsNX/yr7XgnZqQsrcmK18ycPgjN3ScKKWeQAMSMhvBCLwZKjZrAmXxjXz7Py49P/OrH/MNfYhYVWliVqS80RIJ4WEX688FC5u3EnBJkUITGFLlJJhRPaOdDy25PdJtfEDghXiwVhd4xEBGZhGMYyZxhnh6OmSV8M
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:19:11.4717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0949f8d5-353a-46c4-38d5-08df40c7ec2d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB646826

An error notification does not stop userspace or asynchronous VFIO work
from accessing a device while the host is recovering it.

For an open device with recovery enabled, install blocked ops in
error_detected() and drain existing SRCU readers. Block INTx unmasking,
remove BAR mappings and revoke DMA-BUF mappings. Disable bus mastering
on a normal channel. Keep shared-line INTx masking available.

Hold memory_lock and irqlock when publishing blocked ops so an earlier
PM restore cannot undo the blocked handler's INTx mask. Release both
locks before draining SRCU, since readers may need memory_lock to
finish. Use the same transition during close.

Defer blocked D0 requests while the device is open and reject them once
close begins. Reject low-power requests while blocked. Check for ongoing
host recovery before enabling a device.

Return CAN_RECOVER for a normal channel, NEED_RESET for a frozen channel
and DISCONNECT for permanent failure. If saving PCI_COMMAND or disabling
bus mastering fails, keep access blocked and return NONE so other
devices can continue recovery. Preserve existing error eventfd
notifications.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/linux/vfio_pci_core.h    |   5 +-
 drivers/vfio/pci/vfio_pci.c      |   2 +-
 drivers/vfio/pci/vfio_pci_core.c | 156 ++++++++++++++++++++++++++++++-
 3 files changed, 157 insertions(+), 6 deletions(-)

diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index a7a87c04ee60..cd7d87788de0 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -289,7 +289,8 @@ int vfio_pci_dma_buf_iommufd_map(struct dma_buf_attachment *attachment,
 
 int vfio_pci_core_runtime_suspend(struct vfio_pci_core_device *vdev);
 int vfio_pci_core_runtime_resume(struct vfio_pci_core_device *vdev);
-pci_ers_result_t vfio_pci_core_aer_err_detected(struct vfio_pci_core_device *vdev);
+pci_ers_result_t vfio_pci_core_aer_err_detected(struct vfio_pci_core_device *vdev,
+						pci_channel_state_t state);
 pci_ers_result_t vfio_pci_core_aer_slot_reset(struct vfio_pci_core_device *vdev);
 void vfio_pci_core_aer_resume(struct vfio_pci_core_device *vdev);
 
@@ -322,7 +323,7 @@ static pci_ers_result_t name##_aer_err_detected(struct pci_dev *pdev,         \
 {                                                                             \
 	drv_type *drvdata = pci_get_drvdata(pdev);                            \
 									      \
-	return vfio_pci_core_aer_err_detected(&drvdata->member);              \
+	return vfio_pci_core_aer_err_detected(&drvdata->member, state);       \
 }
 
 #endif /* VFIO_PCI_CORE_H */
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 13f4f1faf90d..a5ba4bb11638 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -247,7 +247,7 @@ static pci_ers_result_t vfio_pci_aer_err_detected(struct pci_dev *pdev,
 {
 	struct vfio_pci_core_device *vdev = pci_get_drvdata(pdev);
 
-	return vfio_pci_core_aer_err_detected(vdev);
+	return vfio_pci_core_aer_err_detected(vdev, state);
 }
 
 static pci_ers_result_t vfio_pci_aer_slot_reset(struct pci_dev *pdev)
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 09923a48a547..5e9451e08263 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -347,7 +347,11 @@ static void vfio_pci_restore_config(struct vfio_pci_core_device *vdev)
 static int vfio_pci_power_blocked(struct vfio_pci_core_device *vdev,
 				  pci_power_t state)
 {
-	return -EIO;
+	lockdep_assert_held_write(&vdev->memory_lock);
+	if (state != PCI_D0 || !READ_ONCE(vdev->device_open))
+		return -EIO;
+	vdev->power_up_pending = true;
+	return 0;
 }
 
 static void vfio_pci_restore_dmabufs_blocked(struct vfio_pci_core_device *vdev)
@@ -410,10 +414,17 @@ static void vfio_pci_core_block_access(struct vfio_pci_core_device *vdev)
 	unsigned long flags;
 
 	lockdep_assert_held(&vdev->access_lock);
+	/*
+	 * Finish live PM restoration before blocked INTx handlers can mask the
+	 * device. Otherwise an old restore can undo their hardware mask.
+	 */
+	down_write(&vdev->memory_lock);
 	spin_lock_irqsave(&vdev->irqlock, flags);
 	rcu_assign_pointer(vdev->access_ops, &vfio_pci_blocked_ops);
 	spin_unlock_irqrestore(&vdev->irqlock, flags);
+	up_write(&vdev->memory_lock);
 
+	/* SRCU readers may need memory_lock to finish. */
 	synchronize_srcu(&vdev->access_srcu);
 }
 
@@ -756,6 +767,16 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 	u16 cmd;
 	u8 msix_pos;
 
+	if (vdev->pci_recovery_supported) {
+		if (pci_dev_is_disconnected(pdev))
+			return -ENODEV;
+		mutex_lock(&vdev->access_lock);
+		ret = vdev->pci_recovery_host_active ? -EBUSY : 0;
+		mutex_unlock(&vdev->access_lock);
+		if (ret)
+			return ret;
+	}
+
 	if (!vdev->disable_idle_d3) {
 		ret = pm_runtime_resume_and_get(&pdev->dev);
 		if (ret < 0)
@@ -999,6 +1020,10 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
 			WRITE_ONCE(vdev->device_open, false);
 			vfio_pci_core_block_access(vdev);
 			WRITE_ONCE(vdev->pci_recovery_flags, 0);
+			/* Discard pending D0 before the next open. */
+			down_write(&vdev->memory_lock);
+			vdev->power_up_pending = false;
+			up_write(&vdev->memory_lock);
 		}
 	}
 
@@ -2660,17 +2685,142 @@ void vfio_pci_core_unregister_device(struct vfio_pci_core_device *vdev)
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_unregister_device);
 
-pci_ers_result_t vfio_pci_core_aer_err_detected(struct vfio_pci_core_device *vdev)
+/*
+ * Save PCI_COMMAND, clear bus mastering and set the requested bits.
+ * Reject an all-ones read from an inaccessible device.
+ */
+static int
+vfio_pci_recovery_save_and_clear_master(struct vfio_pci_core_device *vdev, u16 set)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	u16 command;
+	int ret;
+
+	ret = pci_read_config_word(pdev, PCI_COMMAND, &vdev->pci_recovery_command);
+	if (ret)
+		return ret;
+	if (PCI_POSSIBLE_ERROR(vdev->pci_recovery_command))
+		return -EIO;
+
+	command = (vdev->pci_recovery_command & ~PCI_COMMAND_MASTER) | set;
+	ret = pci_write_config_word(pdev, PCI_COMMAND, command);
+	if (ret)
+		return ret;
+
+	vdev->pci_recovery_command_valid = true;
+	return 0;
+}
+
+pci_ers_result_t vfio_pci_core_aer_err_detected(struct vfio_pci_core_device *vdev,
+						pci_channel_state_t state)
 {
 	struct vfio_pci_eventfd *eventfd;
+	pci_ers_result_t result = PCI_ERS_RESULT_CAN_RECOVER;
+	unsigned long irq_flags;
+	bool nested;
+	u32 flags;
+	int ret = 0;
+
+	if (!vdev->pci_recovery_supported)
+		goto out;
+
+	mutex_lock(&vdev->access_lock);
+	/*
+	 * Track host recovery even without userspace opt-in so open can reject
+	 * attempts while recovery is running.
+	 */
+	vdev->pci_recovery_host_active =
+		state != pci_channel_io_perm_failure;
+	if (!vdev->pci_recovery_enabled)
+		goto out_unlock;
+
+	/* Keep failed devices blocked until close. */
+	if (vdev->pci_recovery_flags & VFIO_PCI_RECOVERY_FAILED) {
+		result = PCI_ERS_RESULT_NONE;
+		goto out_unlock;
+	}
+
+	if (!vdev->device_open) {
+		result = PCI_ERS_RESULT_NONE;
+		goto out_unlock;
+	}
+
+	vfio_pci_core_block_access(vdev);
+	/*
+	 * Keep the original command register for nested events. Recovery may
+	 * already have disabled bus mastering in the current value.
+	 */
+	nested = vdev->pci_recovery_flags & VFIO_PCI_RECOVERY_IN_PROGRESS;
+	if (!nested)
+		vdev->pci_recovery_command_valid = false;
+	vfio_pci_intx_recovery_start(vdev);
+	vfio_pci_zap_and_down_write_memory_lock(vdev);
+	/*
+	 * Hold irqlock while updating PCI_COMMAND to protect against the INTx
+	 * handler, which does not use access_srcu.
+	 */
+	spin_lock_irqsave(&vdev->irqlock, irq_flags);
+	if (state == pci_channel_io_normal && vdev->pci_2_3 && !nested)
+		ret = vfio_pci_recovery_save_and_clear_master(vdev,
+							      PCI_COMMAND_INTX_DISABLE);
+	spin_unlock_irqrestore(&vdev->irqlock, irq_flags);
+	vfio_pci_dma_buf_move(vdev, true);
+
+	/*
+	 * Advance the sequence unless recovery is already running. Write the
+	 * flags in one store so readers without the lock cannot see them briefly
+	 * cleared between the old and new values.
+	 */
+	if (nested) {
+		flags = vdev->pci_recovery_flags;
+	} else {
+		if (++vdev->pci_recovery_sequence == 0)
+			vdev->pci_recovery_sequence++;
+		flags = 0;
+	}
+
+	if (state == pci_channel_io_perm_failure) {
+		WRITE_ONCE(vdev->pci_recovery_flags,
+			   (flags | VFIO_PCI_RECOVERY_FAILED) &
+			   ~VFIO_PCI_RECOVERY_IN_PROGRESS);
+		vdev->pci_recovery_command_valid = false;
+		result = PCI_ERS_RESULT_DISCONNECT;
+		goto out_memory;
+	}
+
+	if (state == pci_channel_io_frozen) {
+		WRITE_ONCE(vdev->pci_recovery_flags,
+			   flags | VFIO_PCI_RECOVERY_IN_PROGRESS |
+			   VFIO_PCI_RECOVERY_FROZEN);
+		result = PCI_ERS_RESULT_NEED_RESET;
+		goto out_memory;
+	}
+
+	if (!ret && !vdev->pci_2_3 && !nested)
+		ret = vfio_pci_recovery_save_and_clear_master(vdev, 0);
 
+	if (ret) {
+		flags |= VFIO_PCI_RECOVERY_FAILED;
+		flags &= ~VFIO_PCI_RECOVERY_IN_PROGRESS;
+		result = PCI_ERS_RESULT_NONE;
+	} else {
+		flags |= VFIO_PCI_RECOVERY_IN_PROGRESS;
+	}
+	WRITE_ONCE(vdev->pci_recovery_flags, flags);
+
+out_memory:
+	up_write(&vdev->memory_lock);
+out_unlock:
+	mutex_unlock(&vdev->access_lock);
+
+out:
 	rcu_read_lock();
 	eventfd = rcu_dereference(vdev->err_trigger);
 	if (eventfd)
 		eventfd_signal(eventfd->ctx);
 	rcu_read_unlock();
 
-	return PCI_ERS_RESULT_CAN_RECOVER;
+	return result;
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_aer_err_detected);
 
-- 
2.43.0

