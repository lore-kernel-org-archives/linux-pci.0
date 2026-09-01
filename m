Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010070.outbound.protection.outlook.com [52.101.193.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDF347B423;
	Tue,  1 Sep 2026 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255275; cv=fail; b=vBY6AGsSA1wynMBiqLv5GIpVu+hoQO/1Cy0KhjXgoaSEIqKHmaIvpeEJaO5tW9n6iqePf8NQ1/xiKLLEq8cf3lKWljfi3UYI1SkMTWs2xgefpgScoh1BIlEDvDktaLFyENIR4LZBrnTJxW4FYIkdRUiWmsabhidSklQO7DueyRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255275; c=relaxed/simple;
	bh=+4M+cqaBshtoDg7+6SccNvipDSq9Y5Jbk94BQxPWAj4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vAgB9DvECAUYqiyqEEIvVC0sAZO7lupl78GdMCfW8/gL9CxmDdXTxGcmmWmseFRKSKtTiClvJLlpCrjugTUCH8Rr+0MXQ0oHagRL0EWBGut8eJVhsgvynmT3bu+DzM9ZRNho6TYBabJBRI9Imha1dFLRz//1bN7sgx9NcO5gJ9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S+Ae3PGQ; arc=fail smtp.client-ip=52.101.193.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S+Ae3PGQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=By0+vOqzNDf1I1O9sc85HzTiFDtxtbRd7FfG4HkJnzJiXY83wyi1QZQ8ODIu2pNmR30tU0jvbyosNkv96eqo/Ln6gOUtdJVmuR+mmGk36MmMjNBAXdu2O93oGPj5g9q5pHPHqntW/0oOaO7Nyb4P2vLqIQuDxxQAwiR/motzuiHEF05M0Xslrdu2n6j1uVu6xC13yMzO+WpUbBSLsJnoKlxQKlIiAPd4FmXzE1fWg6CvrPmTUoQE2HAhRMgcye+5COC05e12vEbGm3k2Gw0AntCSxNs5bO8FUAzaW/ALm5a7/M1+tppr1MGVd3ZlvF+z8ArmtCY+MqCk8WotI7ZTPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/En5j1Cx6pO5WXnKyFfWs3D9RfkR6Nnr0FP1/zV7oz4=;
 b=bPMEmGZcQ4aKh9HRnxZeIkliUAEbIRfKBzAVRtMmJq3YGe1wG4Ahg4vOTwZmFrBgtpOOxribzrH4B5DUBt6YPrztV+cn10qHTeHjP92WkdAba6Pc+S/2LWYpvmxSeN5rq3RpEY8c0Xh/k4Tk/R+CIH33VcnJksRPr1P5CjSYgjUdv5IS6diiLWSJllwQc1ZH4Fj114M6ZUlwLsdgionWk38qUYHVPyO4iVF91iLOSvZEK4wmcjzH98T+c8MzrEmN4aSb2PayxMvImWCwE+06707pD29j0QFiinTisCQjBd9bsqcZw25r2cjO0mr98gOFsxf3l/mnO4HBiphbAxQfCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/En5j1Cx6pO5WXnKyFfWs3D9RfkR6Nnr0FP1/zV7oz4=;
 b=S+Ae3PGQi6qTSXaYCOLJSRjIiEaZrIonfvlLPcCUjR8lAV0g5A6H8v/dEP8NBQlK1bzlcj1/2Mj+wacMfVGeceh6eS6KOjrontvId9njfvWnhSo3jDR8rotI54plaL4Sn/zWsW5gP4Zbuvf17NB8MCq35g4qr5IqlUsGtGxI1voJDArcvh3ejMP2m+dFGIvzOUO8OLYhAukpnAayyDOlfkC7eyN0iJfsaqBis672I0Jv5Xtoi+6mFXrhxbgMPW6JIY7rhoFxawo24h9+kDJrYV8ui1LKK6w1xQj3xXeaJ8J4kTTeP3dOS+Rh4NBLGe32Wxs1NZbHnIiqvQadVBVKug==
Received: from BN0PR04CA0081.namprd04.prod.outlook.com (2603:10b6:408:ea::26)
 by IA0PR12MB7553.namprd12.prod.outlook.com (2603:10b6:208:43f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Tue, 1 Sep
 2026 09:34:16 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:408:ea:cafe::a7) by BN0PR04CA0081.outlook.office365.com
 (2603:10b6:408:ea::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 09:34:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 09:34:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:33:58 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:33:55 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <nathanc@nvidia.com>,
	<mochs@nvidia.com>
Subject: [RFC PATCH 12/19] vfio/pci: Serialize physical device information queries with recovery
Date: Tue, 1 Sep 2026 10:32:10 +0100
Message-ID: <20260901093217.8539-13-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|IA0PR12MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b6d9d36-a143-44ae-36e2-08df080c30ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	OBKHAXvGtIiXx5rVMdbAbrw4bjeKiPr076y4xkFfMlkJwhq2XUShzbMW1ddF1Y/UY7qp2qG4kuHRckDcgr8t1y4NEZZZm1Cpz6o4CH/fRLChDf7uTS6bk90UQkclX7S9SGgb/V+mfgNIrJign5Ff0SGE8WRIeSxCLF3cl31WY7E8nLe49u448alz1C/A6YVh+DYRlZZGJ29wsmmoa4d/Hpz7WFtF0lnT8bUZl/t6OmUjH8ryCyIMGV3pHOgFtrA6H8SwLU5U75ZlMQihnEoWH/BAi1vsCrNTnuAiG7pOdO9GyXiFJzs5cqZ8Dke6hCkmsnuGvW05w4psuYdnbfKoSkYJoS5RMTuYWCsfS58ijDJ5E2aFSNwHz3EWFjdKBRh68Q47waf0YGlz99l2x/99TosbgrLEtOwMw1znWlDRukapCY+B2VNRmZAeWzROtNtdSFioLL8/i2hnc46ufPNiXqIPfNtansxk/zETjP9q0DRA2HlxOVBXhwFzmqphubAxfWbm7YW2UyBvVILDTd7uMQVTC8YuTn/OCMrTa9r0LdDLY4t9MkKCMGCpfIAHv5/fbGjh2F+jHQ/xxaKnUSJUh0Luo+LSCWXq1lPUTLd6dkMUgRIaYhZ+gXx01a4stdPR7ecvr65HcTj/1KH7WWqmQnvmyzZf1Ozx+smce1jbMLRnXP4p7WXNY/Gy/fre+ziuaUuNZouDhDfPIseTStnyYA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	v+yLINiczsiOF6uinXvC8H9CvXXdTtSPKuRMy97PqkAAmfun769TO42fdN5flKzkhNDhHeqKQQnb9WMokwoOwm81bmhr4y5GvaElpdqVtRuKFFdXt1l9+5gqy0PmZQurm6R0hE78dS6dvs2YBs70KJ7/WFRK//Iii84WRT8W+O5+XBR+i+ch7bgissILX5NHQ2S3RDSebZNkB/6Dqr0RaWLQTmlF0zzUxmaW73u+IEhnjakFpArnzY9lLyyuQXLS+obCV3Jka8CTeyLNXdnT1QXTBe3xpVMW8Px2dezKRmA9LstN/VWzo9yOuZQantXvEP5BbaCIdQaUThHd94r8HPMspNwSSMUzfH1AdaL3AEk7+8SHhWwwHPc9gG+SQD/qBX3ilSE5cBDb9719DPZXmDzLFloWi04XLav7tDUx86VnNtFosBRgpKARfYCYOlXM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:34:15.9285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6d9d36-a143-44ae-36e2-08df080c30ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7553

Hold recovery_lock for reading around AtomicOps capability discovery,
which reads config space to work out what the device supports. The rest
of what VFIO_DEVICE_GET_INFO and VFIO_DEVICE_GET_REGION_INFO report is
cached or software only, and remains available without taking
recovery_lock.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 95884e713a4b..4447967413e7 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1179,7 +1179,13 @@ static int vfio_pci_ioctl_get_info(struct vfio_pci_core_device *vdev,
 		return ret;
 	}
 
+	ret = vfio_pci_core_access_begin(vdev);
+	if (ret) {
+		kfree(caps.buf);
+		return ret;
+	}
 	ret = vfio_pci_info_atomic_cap(vdev, &caps);
+	vfio_pci_core_access_end(vdev);
 	if (ret && ret != -ENODEV) {
 		pci_warn(vdev->pdev,
 			 "Failed to setup AtomicOps info capability\n");
-- 
2.43.0

