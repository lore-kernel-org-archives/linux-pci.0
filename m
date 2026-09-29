Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012024.outbound.protection.outlook.com [52.101.43.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1F8552923;
	Tue, 29 Sep 2026 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703272; cv=fail; b=OEkfFi14pYAl2SLdmv4a1gpxV/PQ4+yYbvkat9+4ql73Fq+mkybEF4DdgVjBrMy8sd9tcdOE8yu0o5pKuqkIXdBT1OTvChQQ52xjeTC4h8gZYonn9RmMN74+p6k/0XXZx6faf06WED9GZYSWj0dvsslzCknpZEet4UXMcQVsM4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703272; c=relaxed/simple;
	bh=dqfivoM+xtD4VT/rPWQDIAuZnel53mQJhwZLHrp+CF0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dsJGKNqPIcdTBXV7KDT8tuSHhhherN96lmFB2kzUkL9GX0wTZafAZSA55k5J4jW7VvmEwI3dIBciNJdE3fgOBPbqtRX2B7o6Lg5UKHwsiVXAsGH/Avu7wHIm9PUcOl7MiCE9C1W1d1tbV+nh/43ZOBEuBYOfF91jmOiGkrwjqYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MpMNhgG3; arc=fail smtp.client-ip=52.101.43.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MpMNhgG3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5+7xZyssBN6nhzTQl6Vrw9NtyaqV2kFoJ/sPYoX3tXNZxI47gwLB93sWsmKMbHFZiQkprWucNbEwmj19qMy2IAfnyXgMWvbyaUjqGx5sWVA1N2g1BUsjIvYs87pjq79TuXA5U/WLHGs95Nkxbgjw/acjxYyZVqZPzdjfbJeDefWX1Z/ihDNpbamRGdpS69G2E50ZHtoNLglnBh+WOo+siKWjbrbnw2G/NwbFMAjTSuCp08jdbJbxg7uS8LukuLeAPwkiEgvVOhVSA4BdUvAbT1v05LVxYLfbedQDZEicMyuto81Lndd21iBbXiEBNwNUyX8Rer43WkDDhEF/PAJmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x26nCim5K2UDr2weeQhu37cj770HQhZpXhzUwEY16h4=;
 b=yQOMrUKji3nYG3g3UZzYZWQtbdKyV1OwLWt+tsseuInSY+ip0aeiQtmA2Ruqgyz4cxnRZAfau0RlIL1kGGov7kAgNdIjE/U/OoMGYswVADKWAAHqEJgtf/OZwKPDTIo4a2W6aELkHApSiJZXTKwYTprSgyPrUjP3Ilt6P37iYgVPb5CHSfQuSAsJ7TUxCHIQtRhBrW5Ep1V6Biuup0ww2/t254PZpelbvqhzVvqzgzCzHzKiD3Nxv5KKS85qfZxUxvX/hvX5uYHH3LDpB1OAgkv0JTilZLQo+UUTw3W1q5R4ObL4BWCeH71PGelQya2eUyPKKu7XAGmatebRO1AuPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x26nCim5K2UDr2weeQhu37cj770HQhZpXhzUwEY16h4=;
 b=MpMNhgG3YDngVkrkuOUTtiyvZBt39tjf523TiYhszK8Vo6MjWRdX2qGkXiNVirCcekqM8Niv1GIyIS6KxmrSrywWFhTNlPy864DfJ7VUo1H+yXnzgdJVIRB5i/UlzRnvbGPT3cJLv1l+PC8txdWUB3Egqy1ThemlZZMdw/D5PGkYzPpeKzxoHylvYx71YhDBsyINAfgqtIadcJ1EOUKHRBzDmqruBkk1oDOS09YwrgEhq/OqSjZzct2X3KyRX7Fv4TRlDTQSVuYAph0s82QTlwE34uWublh9PW/lI+VdBjRn68+oTjU3eb5uh17aIc65fvr2ssesJyjM5yu7PpuMTA==
Received: from MN2PR11CA0022.namprd11.prod.outlook.com (2603:10b6:208:23b::27)
 by SJ2PR12MB8783.namprd12.prod.outlook.com (2603:10b6:a03:4d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 17:34:19 +0000
Received: from BN3PEPF00022BC7.namprd05.prod.outlook.com
 (2603:10b6:208:23b:cafe::84) by MN2PR11CA0022.outlook.office365.com
 (2603:10b6:208:23b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 17:34:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF00022BC7.mail.protection.outlook.com (10.167.248.212) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 17:34:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 10:33:50 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 10:33:47 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v2 07/16] vfio/pci: Gate function reset and runtime power management
Date: Tue, 29 Sep 2026 18:32:56 +0100
Message-ID: <20260929173305.204856-8-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC7:EE_|SJ2PR12MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c680751-88ca-47e0-a8d2-08df1e4fe2fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|10067099003|6133799003|11063799006|18002099003|56012099006|5023799004|22082099003;
X-Microsoft-Antispam-Message-Info:
	3xP+khWtHLCHsYNPkct4JnlKxMnEyU0BmgGRTGdGbVcuPVkND3IJQ3yPLAUuSuJoA02lnCOGyrREPc9qe+82Hugv2EBFHWwLBZboRfCDEieU2BxbkYS5i/N58NdJBZqzs65LqPVw6JUHibqZ9X/MSQbQxOOWFbwuPVqbq5R39E9sNzXCi1BsJIiCa2pV9IoDdjoiB7cTkThzqndcK6v/xzuNhPvJH/ts6pMHKy6o0puXhcakPaQ1gSwp9LkfXCaeupR2nZNgw3THxr648/RQKo14o+y73DLW7PCdpjj9XLZmk4l3LDbW/NoiAOECsChMGDITsinrYbPOVq23/UBX9tXi+cOCtPaJb0UcgCmxVnBd5+MqDFhRvEFE8k+hhdBxgz0a+OYx9Nf0Z5gL8fZ3GDvmD8cc7tJWjKgBW/F3pX4G8187g7NoEJlRusHv41GuvgSkoHcxprO6y1KyregZR3BTJQnal8t45nrXTwZ9QOuctTxoO0df5PJRP9FsibLNJJnvh12Nkn3PNCL6PeFl4+QESidv34fErdVVZxA7bCBPbDxvR86NyNHyuy/NIjJeY6dbPXYKi6+F+TVPtEdBVwdJKETnyEodlK/HY0OiKa7UojkzuXVEfEffZBStGb27t5z6kT/07Q7vmRyNGGmJIYEQ+vg1qS3AjqGdTbWM2nr8zlmiWiT9UsEDUGDf4BgYJGA7AK1qlJTPPPDJ1hzzGw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(10067099003)(6133799003)(11063799006)(18002099003)(56012099006)(5023799004)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	L1kx4Yt4XPrf7bQ68JgKTRNUYMzqbAu/f4O9tvId/eAenvY4X15+k/d9vZ+rJfrt/vzcrr7Bvzj7X8+GmRb8jBbxP/AS2MyLQO3mH2lEHSkmpNWRZ6QyBbwC3cfbhxoqQRl1jOnowKEKgKJ1ne1uWF7dYjtA1xsPuFVtCnxnQp74OobKgilR/4nZhJ+QrUnOYaBKV28jlo5vR+14tsS6mHiX86kZAlXV6aC6ayWq1HOsKHMjfZt0ywLBV99bz/9bmJuc0J7/LX9u+0WHq44bepxVF+4i5JEjncBdS2K1UOVzVnxsghsliVagqLhyZPGqbQEhYdtZFkrDFzfPMZeVXkuoTm3exF6S7I8fQtSrSSMQfknAll1M+jYSWg2O7aF9ezsgFqPfFeVr8LKwZs7zZxgJUBv220+h+rG3JMVSiqpQB+CC9eg8wFzmLq3ZQ+PZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:34:16.7651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c680751-88ca-47e0-a8d2-08df1e4fe2fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8783

Reject function reset and low-power entry or exit while device access is
blocked. Hold access_srcu across reset and runtime power-management
updates so recovery waits for admitted operations to finish.

Perform the reset ioctl's D0 transition before taking SRCU, preserving
VFIO's pm_save handling. Keep memory_lock held across D0 preparation and
reset so a concurrent guest D3 write cannot intervene. Check the blocked
state before D0 and check SRCU admission afterward. A rejected reset does
not queue a deferred D0 request.

The reset uses pci_try_reset_function(), which returns -EAGAIN if AER
holds device_lock.

Assisted-by: LLM
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
Note: D0 remains outside SRCU, but this series introduces a recovery
locking dependency involving memory_lock and pci_bus_sem through ASPM.
This remains unresolved. See the cover letter's "Locking and open
questions" section.
---
 drivers/vfio/pci/vfio_pci_priv.h   |  3 +++
 drivers/vfio/pci/vfio_pci_config.c |  4 ++--
 drivers/vfio/pci/vfio_pci_core.c   | 32 ++++++++++++++++++++++++++++--
 3 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 623e73f379cc..f757e5407ce4 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -41,6 +41,9 @@ ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
 				  char __user *buf, size_t count, loff_t *ppos,
 				  bool iswrite);
 
+int vfio_lock_and_set_power_state(struct vfio_pci_core_device *vdev,
+				 pci_power_t state);
+
 ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite);
 
diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index e9480b573381..f3366df4af68 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -720,8 +720,8 @@ static int __init init_pci_cap_basic_perm(struct perm_bits *perm)
  * It takes all the required locks to protect the access of power related
  * variables and then invokes vfio_pci_set_power_state().
  */
-static int vfio_lock_and_set_power_state(struct vfio_pci_core_device *vdev,
-					 pci_power_t state)
+int vfio_lock_and_set_power_state(struct vfio_pci_core_device *vdev,
+				 pci_power_t state)
 {
 	if (state >= PCI_D3hot) {
 		vfio_pci_zap_and_down_write_memory_lock(vdev);
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 91c92e8f3daa..38551bdedc89 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -372,6 +372,12 @@ int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev, pci_power_t stat
 static int vfio_pci_runtime_pm_entry(struct vfio_pci_core_device *vdev,
 				     struct eventfd_ctx *efdctx)
 {
+	int idx;
+
+	idx = vfio_pci_core_access_begin(vdev);
+	if (idx < 0)
+		return idx;
+
 	/*
 	 * The vdev power related flags are protected with 'memory_lock'
 	 * semaphore.
@@ -381,6 +387,7 @@ static int vfio_pci_runtime_pm_entry(struct vfio_pci_core_device *vdev,
 
 	if (vdev->pm_runtime_engaged) {
 		up_write(&vdev->memory_lock);
+		vfio_pci_core_access_end(vdev, idx);
 		return -EINVAL;
 	}
 
@@ -388,6 +395,7 @@ static int vfio_pci_runtime_pm_entry(struct vfio_pci_core_device *vdev,
 	vdev->pm_wake_eventfd_ctx = efdctx;
 	pm_runtime_put_noidle(&vdev->pdev->dev);
 	up_write(&vdev->memory_lock);
+	vfio_pci_core_access_end(vdev, idx);
 
 	return 0;
 }
@@ -470,7 +478,7 @@ static void vfio_pci_runtime_pm_exit(struct vfio_pci_core_device *vdev)
 static int vfio_pci_core_pm_exit(struct vfio_pci_core_device *vdev, u32 flags,
 				 void __user *arg, size_t argsz)
 {
-	int ret;
+	int ret, idx;
 
 	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET, 0);
 	if (ret != 1)
@@ -483,7 +491,11 @@ static int vfio_pci_core_pm_exit(struct vfio_pci_core_device *vdev, u32 flags,
 	 * already signaled the eventfd and exited low power mode itself.
 	 * pm_runtime_engaged protects the redundant call here.
 	 */
+	idx = vfio_pci_core_access_begin(vdev);
+	if (idx < 0)
+		return idx;
 	vfio_pci_runtime_pm_exit(vdev);
+	vfio_pci_core_access_end(vdev, idx);
 	return 0;
 }
 
@@ -1387,12 +1399,16 @@ static int vfio_pci_ioctl_set_irqs(struct vfio_pci_core_device *vdev,
 static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
 				void __user *arg)
 {
-	int ret;
+	int ret, idx;
 
 	if (!vdev->reset_works)
 		return -EINVAL;
 
 	vfio_pci_zap_and_down_write_memory_lock(vdev);
+	if (vdev->pci_recovery_supported && READ_ONCE(vdev->access_blocked)) {
+		up_write(&vdev->memory_lock);
+		return -EIO;
+	}
 
 	/*
 	 * This function can be invoked while the power state is non-D0. If
@@ -1402,15 +1418,27 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
 	 * have NoSoftRst-, the reset function can cause the PCI config space
 	 * reset without restoring the original state (saved locally in
 	 * 'vdev->pm_save').
+	 *
+	 * Do the D0 transition outside access_srcu because it can acquire
+	 * pci_bus_sem through ASPM. Keep memory_lock held through reset to
+	 * prevent a concurrent power-state write from putting the device in D3.
 	 */
 	vfio_pci_set_power_state(vdev, PCI_D0);
 
+	idx = vfio_pci_core_access_begin(vdev);
+	if (idx < 0) {
+		up_write(&vdev->memory_lock);
+		return idx;
+	}
+
 	vfio_pci_dma_buf_move(vdev, true);
 	ret = pci_try_reset_function(vdev->pdev);
 	if (__vfio_pci_memory_enabled(vdev))
 		vfio_pci_dma_buf_move(vdev, false);
 	up_write(&vdev->memory_lock);
 
+	vfio_pci_core_access_end(vdev, idx);
+
 	return ret;
 }
 
-- 
2.43.0

