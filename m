Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493175;
	b=ui7ycog8M5mwsKE2X+VA+zPvcrpHbL2QkbyqIp0xxXrcRFiP502/upKaCLQ4KgxA7/Hc
	 zGeK5KTsyNVQSmoVMSRDX2KmlhVSVsqrM2ea2kaWEuiuClso3zXeSiRjAwL21q28abBhf
	 CmeXcN3kDQGP3YcCKw9VXyLUPTbTT4k7HFJOrkmoXh+/aptI0hWaPvuyDZUFKsIyKdMKy
	 EGgXDZo3NlROeLLLCE5FihmItd9Zz4JKo1ktMJD5Oe9PfYECk9TemvR+ErdLxG8RkESUQ
	 Hi17UKrOpfmQhzPKKMwCRJftQ7RZmBjrxpJVHi4N3gjfsJEPAUwOSbVj4xX0ESElyNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493175;
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
	bh=mYeE08rE/3N8ndojqh/iZnZmLhTLBJvqHYRuiiRFGkE=;
	b=RsYwTCJUJ9q+UzPOWQirvkRDK3iioaUBifJg+tP2ox4Qj4HOd9HZEF+byex+/gzgM/vx
	 GQMn/44csfTvjjmjbm/OtRJifBTAoVdj8bRmmtXLmY3biKGl5af1vYsLox8eQ5zBNu0Bh
	 GMCE92FAYBol9kSFiTiTuuI4YmbQ2rO5gRtldwAcprkmy04UjRk7fVmIbrcjSlWEOGe56
	 DndjcLvzxFxudkrv3yyoVHzaQoaiiUVdQk8U9+ltqABYgXgsVOgYaRduAqf/FgnkLqmv8
	 uYdjw6gKpA3kiudf1bqrQxAmkXhFTodemCMtXtEqiz3TXJ02CjOjyHe1o/Y5ac5QXlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=K53ssunL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.45
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010045.outbound.protection.outlook.com [52.101.193.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269516071DA3;
	Thu, 12 Nov 2026 14:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 269516071DA3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=K53ssunL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BViNUBpzeL4s4xVIqaupG2sZIdA1cOiAVNavspuqDpbyjLTnJr9XuAcT5eTOyWQ5YqdddfRzD+zwsmMTt3IVLlBNtGwhc2OGVjXtomNyysrrE5LJlc0ZRPpJe1whJnFuItTDg1CGRPTFmEJtNVYpgHMjCoGLVBpaG2s3T1wEqG1/QuD0xD+zn+gFKsJhqPqlsNYgKiUTo18feO+PbmWET5zAq9k/sAKBZgPOSFwKAvrdpI6m8W2XPMJy/aLi/aV49rvSlTDUvlYyZNWLJORJpzHcs2XhkA2E1PTinlAFK/QakX0A4AhFFXHbNrDahMaBzTBuGkxuWwDLAAP571cHKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYeE08rE/3N8ndojqh/iZnZmLhTLBJvqHYRuiiRFGkE=;
 b=HFwWUiEfJ4QYb2c8mPdmOfGhJpiPR9KtdhFXU55Qbalw3eWFAR+6HtGN7/JU2qPKwXRXzxzVOQFj3Tm68wr/FA8kbRR2fOkR13RB1dWBYjGmQX4kMWl+aukLIodRx9NPUV0fXG/CVeGChJXnjznKP9wBLPogoT8PyYTDRevqC63/hCBDVRW1AgLBj66pu3XTceWtYHzpX5pVzBuKSCyforgOSg8jRrNsDRR1KbBP54iWrJHOznKvl85y1nfkx628eEKpVBJ9OJGA0ah4qTuZyUHqDCuZbz3IDOl/0KmXoLqc0bRI5gzFUomHk0LMeF7Hh9HA03Z2WZ6XJhpLyySoNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYeE08rE/3N8ndojqh/iZnZmLhTLBJvqHYRuiiRFGkE=;
 b=K53ssunLopSSZG/8KF3R4VBsy0KjKC6wnwNcZkRKua5PeX1rgkcLtQPQbmYigemXtL3xlrypFpGKW0S9hw2JZJDNPstJL8g26pFgc96A3BCHaFjy8+0gLBnTNNTLC22HVBf0aHGoJdcLQvPB0j4U24MYLTl9uKSQ7kTGAOmNdbrC2M/QORyfwploONgczVgshs7XwhtJD+wloj+kplIPf/iJUYBLwbwjq4xhLQWbCj6M/uITJNstU7b7KlfBcEVYxcvv8Teb4GlfX/eWxqjOorgBIzsuc6FbG53flHaKzIGXh/u7Fxel5tnSCzbpFClQl5yUP7lkoFSmwlikN0Poew==
Received: from PH7P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::7)
 by PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 14:19:09 +0000
Received: from BY1PEPF000264AF.namprd02.prod.outlook.com
 (2603:10b6:510:326:cafe::37) by PH7P220CA0008.outlook.office365.com
 (2603:10b6:510:326::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Thu, 12
 Nov 2026 14:19:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF000264AF.mail.protection.outlook.com (10.167.242.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 14:19:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:18:48 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:18:44 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v3 17/20] vfio/pci: Complete recovery in resume()
Date: Thu, 12 Nov 2026 14:16:29 +0000
Message-ID: <20261112141632.918954-18-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264AF:EE_|PH7PR12MB5805:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f0b3c55-38c1-4a5a-4cdb-08df40c7ead6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|18002099003|22082099003|6133799003|56012099006|10067099003|11063799006|261026121527099003|261102123227099003|261026140227099003|261028144727099003|261022075727099003|261021121427099003|261022105027099003|261102130727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	cJ0iBJ2SeGC3ELNJxuRVpqu/phR5a20M/eFT62i494tb7KYzyNZ7iKUZvl0m/muSwrHw83Ihc7gxh6LZ/AjklLgNtdzLW6bOAHa/VbwFeVmOXi2gFADXvNqUdWF5PfZnsi26HeL2KaD6PZJxjzA5q6bZfKseBuWVjjb0lbElEvXTHw4RLPAGs1hffXEKblNKeh1XJbA6lmUoOvO4ulHrbJ6CHh1KprObFDJoDX9cTERGH0zDz2BpK71L10wdyWp+XgLsYM/LEIiHONVj22NOZeSI0nq6CRvQKAcZKeMeeBAQ/QFCT9okxVO9N2gweOClo4aYMtX5OWPQ84DoMRRRMCYtIFiYFG8NfNQ4yhcZhBMBo9ztI1jHT9Q3beTXZclLeH/mowXlBzaWIgS7QjvbIYFpoqvexjkkEpNtV0WdVU6w8cf9WmqIZJL6c4X+v4dGKeREGNzGpmRCVHJyepyPYqmM0XUAizpMuBJ1Sy6Jyfv8OhIudUoacxYw/n5cqy2h5DvLMnbSb8Hgg2U3apc64E5pvBqnOlkMjKwbK0n4JdDyV9P5459RtV/sxDCCCTnpGqAFblNlSjzhNk1FuMX4B6zGLm4HJ1gSLVZ1S4UXHDiXqgxhoGsHfrMVvqRbtGWWHwRUDpWgWDoVZ2QVhcVz3jdsZMIjwzDXQ8nfj9z3X/9Tl/fkrM4qcOYJwwWEYY9QzxUpzGUyiHddr4sgFk+F6A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(22082099003)(6133799003)(56012099006)(10067099003)(11063799006)(261026121527099003)(261102123227099003)(261026140227099003)(261028144727099003)(261022075727099003)(261021121427099003)(261022105027099003)(261102130727099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lzaOvk4j+OvxsNAplB+vt5LGSENqSN7ycYj9eQYuz1Rc1S5EFdHbd9sk4Hvyz2XfbfpRJyT6ZWjxmHwPEC2y15tGTAcNodItYmzMXuaCVe73yJmQtxHT+natfxeq2WGngoc7KjDruGOP4GQkDBeZ6xlo3/GJQ8mTBjM8XLD2Ovv42b/Ygjwfas7vlLJ8TAzbgyNG+KOgSLWJ5eG6/hcAxsNodnmHn5Ums5X7/dDFMOyy3+KRgRA3oKbvkBf3zg7nQDgnX5y2bbA49LBxsN52ZRt6YnneUdfZxc6fQITQVEXlgjDC3OQGRORpi0TZOjzzNyeSuslWAeFXF24Mdc4hUY69QsElr1R9hSrw+nxhdLlTmQ+2vdtTiYObYn/hPQwcf4xhzxWJ/WDAXZUk70bQGXJV8YkXWIBq7/8bqdoW0aparkI0TPvj7VXGnfkkILyc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:19:09.1941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0b3c55-38c1-4a5a-4cdb-08df40c7ead6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264AF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5805

Add resume() to finish recovery and allow device access again. This also
handles recovery that did not require a reset.

Complete deferred D0 requests and restore PCI_COMMAND, DMA-BUF mappings
and INTx state before installing live ops. Take igate before
memory_lock, matching IRQ configuration, and hold both through
restoration and live-ops installation so no deferred D0 request is
missed.

Use the locked PCI power helper because native PCI recovery already
holds pci_bus_sem for reading. Leave failed devices blocked.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/linux/vfio_pci_core.h    |  3 ++
 drivers/vfio/pci/vfio_pci.c      |  8 +++
 drivers/vfio/pci/vfio_pci_core.c | 87 ++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+)

diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index d36bca65d180..a7a87c04ee60 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -147,6 +147,8 @@ struct vfio_pci_core_device {
 	bool			sriov_active;
 	struct pci_saved_state	*pci_saved_state;
 	struct pci_saved_state	*pm_save;
+	/* Deferred D0 request, protected by memory_lock. */
+	bool			power_up_pending;
 	int			ioeventfds_nr;
 	struct vfio_pci_eventfd __rcu *err_trigger;
 	struct vfio_pci_eventfd __rcu *req_trigger;
@@ -289,6 +291,7 @@ int vfio_pci_core_runtime_suspend(struct vfio_pci_core_device *vdev);
 int vfio_pci_core_runtime_resume(struct vfio_pci_core_device *vdev);
 pci_ers_result_t vfio_pci_core_aer_err_detected(struct vfio_pci_core_device *vdev);
 pci_ers_result_t vfio_pci_core_aer_slot_reset(struct vfio_pci_core_device *vdev);
+void vfio_pci_core_aer_resume(struct vfio_pci_core_device *vdev);
 
 /*
  * Per-driver PM/AER trampolines. driver_data points to the driver's private
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index b4b3351cbd85..13f4f1faf90d 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -257,6 +257,13 @@ static pci_ers_result_t vfio_pci_aer_slot_reset(struct pci_dev *pdev)
 	return vfio_pci_core_aer_slot_reset(vdev);
 }
 
+static void vfio_pci_aer_resume(struct pci_dev *pdev)
+{
+	struct vfio_pci_core_device *vdev = pci_get_drvdata(pdev);
+
+	vfio_pci_core_aer_resume(vdev);
+}
+
 static const struct pci_error_handlers vfio_pci_legacy_err_handlers = {
 	.error_detected = vfio_pci_aer_err_detected,
 };
@@ -264,6 +271,7 @@ static const struct pci_error_handlers vfio_pci_legacy_err_handlers = {
 static const struct pci_error_handlers vfio_pci_err_handlers = {
 	.error_detected = vfio_pci_aer_err_detected,
 	.slot_reset = vfio_pci_aer_slot_reset,
+	.resume = vfio_pci_aer_resume,
 };
 
 static struct pci_driver vfio_pci_driver = {
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 039fd864119b..09923a48a547 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -515,6 +515,13 @@ int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev, pci_power_t stat
 	return __vfio_pci_set_power_state(vdev, state, pci_set_power_state);
 }
 
+static int
+vfio_pci_set_power_state_locked(struct vfio_pci_core_device *vdev,
+				pci_power_t state)
+{
+	return __vfio_pci_set_power_state(vdev, state, pci_set_power_state_locked);
+}
+
 /* Avoid waiting for pci_bus_sem under locks needed by PCI recovery. */
 int vfio_pci_try_set_power_state(struct vfio_pci_core_device *vdev,
 				 pci_power_t state)
@@ -2750,6 +2757,86 @@ pci_ers_result_t vfio_pci_core_aer_slot_reset(struct vfio_pci_core_device *vdev)
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_aer_slot_reset);
 
+void vfio_pci_core_aer_resume(struct vfio_pci_core_device *vdev)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	unsigned long irq_flags;
+	bool notify_intx = false;
+	bool power_up;
+	u32 flags;
+	int ret = 0;
+
+	mutex_lock(&vdev->access_lock);
+	vdev->pci_recovery_host_active = false;
+	if (!(vdev->pci_recovery_flags & VFIO_PCI_RECOVERY_IN_PROGRESS))
+		goto out_unlock;
+
+	/*
+	 * Match IRQ configuration's lock order and keep D0 requests out until
+	 * live ops are installed, so no deferred request can be left behind.
+	 */
+	mutex_lock(&vdev->igate);
+	down_write(&vdev->memory_lock);
+	/*
+	 * Complete a deferred D0 request before restoring PCI_COMMAND.
+	 * After a reset, slot_reset() has already put the device in D0.
+	 */
+	power_up = vdev->power_up_pending;
+	vdev->power_up_pending = false;
+	if (power_up && !(vdev->pci_recovery_flags & VFIO_PCI_RECOVERY_RESET)) {
+		ret = vfio_pci_set_power_state_locked(vdev, PCI_D0);
+		if (ret)
+			goto out_memory;
+	}
+
+	/*
+	 * Hold irqlock while updating PCI_COMMAND, as the INTx handler does.
+	 * Keep masked INTx disabled until vfio_pci_intx_recovery_finish().
+	 */
+	spin_lock_irqsave(&vdev->irqlock, irq_flags);
+	if (!(vdev->pci_recovery_flags & VFIO_PCI_RECOVERY_RESET) &&
+	    vdev->pci_recovery_command_valid) {
+		u16 cmd = vdev->pci_recovery_command;
+
+		cmd = vfio_pci_intx_recovery_update_command(vdev, cmd);
+		ret = pci_write_config_word(pdev, PCI_COMMAND, cmd);
+	}
+	spin_unlock_irqrestore(&vdev->irqlock, irq_flags);
+	if (ret)
+		goto out_memory;
+
+	/*
+	 * Restoring saved state may leave ROM decoding enabled. Disable it
+	 * before allowing access to shared decoders.
+	 */
+	if (pci_resource_start(pdev, PCI_ROM_RESOURCE) &&
+	    !(pdev->resource[PCI_ROM_RESOURCE].flags & IORESOURCE_ROM_ENABLE))
+		pci_disable_rom(pdev);
+
+	/* Recovery restores mappings while ordinary access still uses stubs. */
+	if (__vfio_pci_memory_enabled(vdev))
+		vfio_pci_dma_buf_restore(vdev);
+
+out_memory:
+	vdev->pci_recovery_command_valid = false;
+	flags = vdev->pci_recovery_flags & ~VFIO_PCI_RECOVERY_IN_PROGRESS;
+	if (ret) {
+		WRITE_ONCE(vdev->pci_recovery_flags,
+			   flags | VFIO_PCI_RECOVERY_FAILED);
+	} else {
+		WRITE_ONCE(vdev->pci_recovery_flags, flags);
+		notify_intx = vfio_pci_intx_recovery_finish(vdev);
+	}
+	up_write(&vdev->memory_lock);
+	if (notify_intx)
+		vfio_pci_intx_recovery_signal(vdev);
+	mutex_unlock(&vdev->igate);
+
+out_unlock:
+	mutex_unlock(&vdev->access_lock);
+}
+EXPORT_SYMBOL_GPL(vfio_pci_core_aer_resume);
+
 static int vfio_pci_sriov_configure_live(struct vfio_pci_core_device *vdev,
 					 int nr_virtfn)
 {
-- 
2.43.0

