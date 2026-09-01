Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADA547DFA9;
	Tue,  1 Sep 2026 09:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255274; cv=fail; b=jTfeYZzcqLy7fh+p6ZJMEn6BGAHbPTWOUSHCGTarQiU17T11x2DmCSooqYlEbs/qqN5jLRh1xMWSytY+oJwDA12hAlek3YeVK7XHRNeAIdr6xtsOMt95XGSQ4OgE852DmLU79AN7vc8VVFvGGjdA2fZds1xnIj0pTLN29WZltfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255274; c=relaxed/simple;
	bh=Ehn62oPGFdYlZiFCt7Po+Ep+1T4oBtjL3w4xuf1/8Sg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lanKiCD9slLJe69yBeKV0TTHXRVRJg6ciNgfON4wig3x+OWsjtut6x3ANN/bthkj8qaVUYQ44S3lTI26EnzWJ7aHXYWx0Nkot6aHvzVXZCEoQeN8ouzNJYvIyk7JiGWlIV57XYPiaiWRNz7up9l1vVsmn/oWvTdYXLz4QXemzcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IzV2viWT; arc=fail smtp.client-ip=52.101.52.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IzV2viWT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jj+pn8+0REyG/1lB/OrSKDZEvgSO5gup6DaQJUaWmnTmio3YwUf0Iqj3evizlg88z1LL9+KKeTJ3kMf8IcqbzbJ/65YbcZmle8gRIhid2iGC53tJI5WsBKlx6TYMXLvnSEibiZIZJR+6hsi/gVDWQXpdLtuPR2LDuuRmXZgJ37bs8eJMEUqhJ61b0direLRwuRj8A2uHHkKOZM0/Kcfq8lWBNBfFGC3QkFLERNJvl6+bPNzzA+t1VsuFy09oBz7gFwtbi3bF/bPW9/mXb1gi1MngCPrgMVfgnFdKwCWX7lbZUSKe7PLvFh5Bqv9UJcR5CsUYigtc6o5IrhRwyCTQFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ph6bobwgGnyUGJ3SMPMALaWaZHE0wJfF3YR+05aLV70=;
 b=gvAEveAMF17Zs/Aq3ukAo8SIxbTsesMO48DRc/CSEeHmpzsliJ2HtRCZCw+n+UGGCaAUCA2AoPe9/OZKmSbfmnA9Iu6DPfcPnFsl4b06yD6TGFPhuJFaCOV3Nw7g1dd6BBjawjXoC/D0XuVa8IBW45BYNb28AGeod0z4i2uLLeDXPuh73/G7zvPOMPGxYBUo3cAxwPd6b7revpKloiBilqj5Lh92RojuTFgKU4odQ2YUgRGqpb10sVpzD70B8zQh/Urw+sdshJideXOF6HxfS+8U/pqX2k5ymTp+qXsFd0QwF14j43/0V0kYkOK2YiCOHYvoyHCNY26NAS+tcTQqkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ph6bobwgGnyUGJ3SMPMALaWaZHE0wJfF3YR+05aLV70=;
 b=IzV2viWTKU7lA66uHKYbplncseVwdBTYCipUOEfSa1N/ZMwJ5AxZSl+tbyaK2GDRZqyOQzanommEHWEUzqBdYJGM2ghOEv7vtd0zKzqBoGtWkSC1cBTD3C2wONUyAbgT/EWEsNPq78CNJNtxkIerjBUcC5t00kB5oCZ//vKaueJwlzhDEsTnUnKHS5p7N+j8UolAzbYNZ0sW9oWErRLXXPxEZhCnbt+bcK4PHLMcmxzX/ee5KRhYG1zaXAzqBKrpIWDWIjU3FxWOaV4frbkEvmcJjfscJ4+kkpSg8ZHq1/jhtwaZrG2MRqDL2fnyyOVpakkAKs3b8gGfrHttappQCg==
Received: from CH0P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::14)
 by PH7PR12MB6953.namprd12.prod.outlook.com (2603:10b6:510:1ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Tue, 1 Sep 2026
 09:34:13 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::72) by CH0P221CA0004.outlook.office365.com
 (2603:10b6:610:11c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 09:34:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 09:34:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:33:54 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:33:51 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <nathanc@nvidia.com>,
	<mochs@nvidia.com>
Subject: [RFC PATCH 11/19] vfio/pci: Serialize runtime PM with recovery
Date: Tue, 1 Sep 2026 10:32:09 +0100
Message-ID: <20260901093217.8539-12-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|PH7PR12MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: 624247d2-456e-40bb-1e7c-08df080c2ee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hKa8r4ypx7CDtipS69K/RVcsdvw1h5faagM5oFUn9TrCh2m6eWkHqYehb9oXQR3MEuG3ez3nnKLAqouLn6Cqs12BnyykdomCGSG9y87kHWESUg2OQuNIlSj8wcW8EPP/fVlb5e8yCDXv9iE8HLBRXHgotwpzWWci2GvZKq13f5Aj9t9QSi5kNc+azfItr/iyJYZOZEY2+RI/2/7Se2V1j7nS3A7ONFHqhbnnEPJ2mhrSH5ZPd4kR/1mzCfQ6olhQ/BzZgzXfSfw1in7bMwDeqUDygfxj3Jp+F9SohSjLobVV4dMgFbaMHj5rGh74mP/uNOqCc08M5j1UCoSulgsxwNNb3X2A+3zNgWGxLLh0fTvPNKFumDdERs/ocJpvEA2wDqkY9ewg9OO6K1aBhdwMwR3ROQTS/xxooPxksh1MAGLQC/Sgd99pQiaPMa+VkzFjQOVTaVAWYgyUA5VIL/PueCid9WZs9gaswcWvyB8azjmCvAVVv91miON+o+ogyHYIEFLfz+jZ+5YwAY5Ksar0u8fB2YMlZmYMG0wVk+7ppHtam+h5pblafQH4ayzWpph7atphh46ztsFD0HEA1J0WVo4CpveeMnfde8Dclj1CZz+tlS3tnqgy+UAK8hu8JSNxiaN+RLMrGPnUvQTLf7LvgiDBwNylF44qitWVULvqgGqeC4ygEyhQ8ErdcUdU8DQux1J6WPKqph/JOE7/6DnJXg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RnLlEA2TDt07JE7/HNjcalH9w9YiID4IYzw+GGA24cxkrxfhpShy0iSKbodSGpqL/EWorErMYzFbnsZghGngbQP740XEsVDorvqHlRbcaGJyNb+ufZfMppj0vTti8iSnkDuCITyi/nUSjJt1ejGyRufYnSPV87mBLyojMOUYwWGXc0OeXQWS1R2AsdRMsLLJsQcdKTTdt/cRns6YvtZIEE9EKu/AWPvXhaUQ87PMbfh0yW1/LCpLYoL9yF0l6un/SRHsxJvIxEIfnwsNh8TdruB4WRLRyYX//+h4Y1tygyYQ6n4wEEceh0GV1dEP2cIkD/9cnR1B29DCR3jMw9E8lpHzweJUEN/9Hly0y+5mjBzxSTm8KqybY88TRJM1e06/NfzBjg4bLGtCGAsL+bd5t3Q0iLLorqo9+PfLRc1nZ9hUuZZdzH4AocIqHxVNS/I8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:34:12.7881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 624247d2-456e-40bb-1e7c-08df080c2ee7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6953

Hold recovery_lock for reading around low-power entry and exit. Entry
zaps the BAR mappings and revokes the DMA-BUF exports under memory_lock,
and exit restores the exports. Taking recovery_lock first keeps the same
order the AER callbacks use.

Neither wakes the device. Entry only decrements the runtime PM usage
count, and the suspend which follows runs when the vfio core drops its
own reference after the ioctl returns, outside the lock. Exit takes a
reference without resuming. So neither reaches pci_bus_sem while
recovery_lock is held.

Check the recovery state before the runtime resume in the region read and
write path, but do not hold recovery_lock across it. A resume takes
pci_bus_sem, through pcie_aspm_pm_state_change() and, from D3cold,
through pci_bridge_wait_for_secondary_bus(), and the error callbacks take
recovery_lock from under it.

The check is best effort. It avoids waking a device whose access is
already blocked, and the region access which follows takes recovery_lock
for itself. A recovery which starts after the check is not excluded, and
does not need to be. pcie_do_recovery() runtime resumes every device
under the bridge and holds the reference until it finishes, so a resume
which runs alongside it does no more than take a reference of its own.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index bd3d79d28f27..95884e713a4b 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -372,15 +372,21 @@ int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev, pci_power_t stat
 static int vfio_pci_runtime_pm_entry(struct vfio_pci_core_device *vdev,
 				     struct eventfd_ctx *efdctx)
 {
+	int ret;
+
 	/*
 	 * The vdev power related flags are protected with 'memory_lock'
 	 * semaphore.
 	 */
+	ret = vfio_pci_core_access_begin(vdev);
+	if (ret)
+		return ret;
 	vfio_pci_zap_and_down_write_memory_lock(vdev);
 	vfio_pci_dma_buf_move(vdev, true);
 
 	if (vdev->pm_runtime_engaged) {
 		up_write(&vdev->memory_lock);
+		vfio_pci_core_access_end(vdev);
 		return -EINVAL;
 	}
 
@@ -388,6 +394,7 @@ static int vfio_pci_runtime_pm_entry(struct vfio_pci_core_device *vdev,
 	vdev->pm_wake_eventfd_ctx = efdctx;
 	pm_runtime_put_noidle(&vdev->pdev->dev);
 	up_write(&vdev->memory_lock);
+	vfio_pci_core_access_end(vdev);
 
 	return 0;
 }
@@ -483,7 +490,11 @@ static int vfio_pci_core_pm_exit(struct vfio_pci_core_device *vdev, u32 flags,
 	 * already signaled the eventfd and exited low power mode itself.
 	 * pm_runtime_engaged protects the redundant call here.
 	 */
+	ret = vfio_pci_core_access_begin(vdev);
+	if (ret)
+		return ret;
 	vfio_pci_runtime_pm_exit(vdev);
+	vfio_pci_core_access_end(vdev);
 	return 0;
 }
 
@@ -1867,6 +1878,24 @@ static ssize_t vfio_pci_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 	if (index >= VFIO_PCI_NUM_REGIONS + vdev->num_regions)
 		return -EINVAL;
 
+	ret = vfio_pci_core_access_begin(vdev);
+	if (ret)
+		return ret;
+	vfio_pci_core_access_end(vdev);
+
+	/*
+	 * Resume with the guard dropped. A resume takes pci_bus_sem, through
+	 * pcie_aspm_pm_state_change() and, from D3cold, through
+	 * pci_bridge_wait_for_secondary_bus(). The error callbacks take
+	 * recovery_lock from under pci_bus_sem, so holding it here would
+	 * invert the order.
+	 *
+	 * The check above only avoids waking a device whose access is already
+	 * blocked. A recovery which starts in between is not excluded, and
+	 * does not need to be. pcie_do_recovery() has already resumed every
+	 * device under the bridge and holds the reference until it finishes.
+	 * The region access below takes the guard for itself.
+	 */
 	ret = pm_runtime_resume_and_get(&vdev->pdev->dev);
 	if (ret) {
 		pci_info_ratelimited(vdev->pdev, "runtime resume failed %d\n",
-- 
2.43.0

