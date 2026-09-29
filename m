Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012001.outbound.protection.outlook.com [52.101.43.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A4D544D6A;
	Tue, 29 Sep 2026 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703254; cv=fail; b=nQwC+9dw7GKewi9GNKSCg9m7qmrmo8+e3uC1tEKO5pmLHqR6vy6lAlq3f4GijuHacOoGY2IT1yjJLcUBGjgD08D+bB+YFOE/xCpe/Aa6q8Sb2eaZQuqALGV/aObVjt4DxPI/oR/tJow+lsyK1zeeeqyzzkp0lMiw9su6F6J+Nzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703254; c=relaxed/simple;
	bh=ZEOccStE5alg4hzicvh56W9uXKAWIjwMYJC8GxFt1Ic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VjiYZat2NqCkAKZIGBbQ58SFib05w4KLmGrooEoVd3sJP9ZKl3wwsZ0eHFadH9fEiUcqTnVpY4ZAi6CfAUhFy9Z3SrQk8OKwL+xA3HunidpYTtR1reEV4fx+k1I2u7DYEzHysl7HnM3IvpRurlWj0rcSeyuoKJC9v/8yVu8K72c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mwe9OzN3; arc=fail smtp.client-ip=52.101.43.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mwe9OzN3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DlIWlAFLW+b6/q8EoOjhPywjkpnZ4mZYLjYafC8Qs5edczItPixe/7PISsqFJXqIgWNf7a5ecBhMm9ZHf0xsKVfUXxGLtI5nmQ3HNkJwOaE0rcJu2w6bIIuXsZWu9gFfMWNpHNGMRnbV+yB8mtptsjCmxJSOoQCY5KUYWB8JSHH3NrImMp0pr8hoaThtNJOoQb4xbm16TL0uo0uRvt+nFiIJVfRHwZq6Nrru27nydW31yWD7GMvf+W8XwPS/8JReOGalxg6QbrDH8LAUoIVsUws0455fq6+BYolAliqfWJBYCf52cG7/N7HLr9XLRXAfV5qkwKWV/2F8qgYzm1eA3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBsGiz4s45QyI9MyT0ty9bB6qXmrVqu1WuOEWijs6Yg=;
 b=EX7Urmrw5xPnTxKSezmY+y22/t5VK/SS9pBAhuKnMIwGVJR3hoObzEqo0BvbhjWUaur9lV6g24Rwo9GYlXqDxxD/itu9JizTJxPJuv0h3znRGpqr5QkPrTdmkWVH7nc6vj89AxfDmZnaVlbZNc/LjuPmZp78pS4nKYyzcOklBbiWke7qck+oJb/oBq9NMZRhqjkjy7ujLcn5TJubMHaWkZDDzoMoCXs/Si7x3LVolWaLn9HsF65aB7CThaw9RNja2sX2SVI3aG9s/0nUpYekB6ps0RQUERMTKdjRMYEjjwKThDCs/OyJyO1zzRJbZnCe8ycc344LxISDCNOm5Rk5yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBsGiz4s45QyI9MyT0ty9bB6qXmrVqu1WuOEWijs6Yg=;
 b=mwe9OzN3NQXrdFsGXjfelGEt2fJd6ily2Ywj+cNfNbb9iOR+hD1aWyPZhQ85U2QdYllCiFpfXpomp7J6/f3LmwshJ6DSq6FmxMsPqd5kpKTae0KmHC85S/u+Y0SUNppNuQ3GovivryZiTCQrx5NcDbXbzFbdxt4rdCNet4ZitXfFIsxeboTDFC63SRUR84AYonSfhRr9f5b88UMDzRGo+1cwVVxTu4TuZHCaYDZY7FbwCjNX/giO9EfZIULBtWzqh+jSx/ZpXxSDACOOcoMoryifwB1EGCrt8llEN5dFG7MXapPQz9rzrvcliRzgdUxUUVAOyK6C7y/8sYZiDHeBvw==
Received: from SJ0PR13CA0140.namprd13.prod.outlook.com (2603:10b6:a03:2c6::25)
 by DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 17:34:03 +0000
Received: from BY1PEPF000264B1.namprd02.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::9b) by SJ0PR13CA0140.outlook.office365.com
 (2603:10b6:a03:2c6::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Tue,
 29 Sep 2026 17:34:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF000264B1.mail.protection.outlook.com (10.167.242.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 17:34:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 10:33:31 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 10:33:28 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v2 02/16] vfio/pci: Gate config space access
Date: Tue, 29 Sep 2026 18:32:51 +0100
Message-ID: <20260929173305.204856-3-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B1:EE_|DM6PR12MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ffdd98-ea54-4424-80ea-08df1e4fdaed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|260925022911599003|260925021911599003|260925021311599003|10067099003|56012099006|5023799004|11063799006|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MHUYstlYp+Nbx4umJdKb+JRppBG8JxO6b2GiHJEovAYJT20RA09F4uJkgsPFXHRB3logLDV+BE9Z61kc2b9Z9h8mkEH3sdI8lxEuuz94nVD/0hkL7QeaeaiYsyKxVM+ywyvHAqNukbkvuKm/4mRSyGCuYeTmjv20biUjYlTTpD7cmthTR1B+vo+3mRwA90ZV1qhsH1BMcbTyUpEQd7o27cXed/DFC5n3eDe8ap+bqwBAIQiLJeLFImNHl82ZhySF6xRjLoF89LN1RcFwc8W9zE3NT5SITH2oHNozHei8G5lHKZcnuInCooI26Br0x5tL1mZnu6DB9MHBRMSvsZDaHiCsDET2UJ9l3wxq6zVud1Ri6hH/9rJGt/ZxYB7VM6IfRMgHYy83zb2hu+EQFj7NYJNZ5DHaJJaiPiUmBV/2+bvRaDrDPZ6Jsn9t3DpTib7v/Ytx9kVzAhpe4+qbzWizflg38fPesL2JVMat3ILKnL7LhEGjTXBVFLostRsO/fVex2/S4ey0qnlHyRwDyrQ4ARo59cRrUO2MOHefAuDEsQuKhNtaJNSYHYjMYtlXYO46zBlc5//RbvbqPahuQox0VXioe4FsgTbB5m939907vdwHVp0NjGsLGNulDU3B6Ojb/Lcc7UYULGgGEk5lg9V7Ojzyy3m/wtNO/lgknfJJY2oZTePJ7djyPnZAqQ5OaWeUpHlEfKBo3iPpB3ZEHiq6MQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(260925022911599003)(260925021911599003)(260925021311599003)(10067099003)(56012099006)(5023799004)(11063799006)(6133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tyPIas2W1wSc0T3STfi2hqV+jy+oCkdw/mpfA1aWQ13eaRyOVxhvycPunIdV0ufVXe60qDcv0Wlmp3FE6Uc8mH0JlG9NtWHtc3LDNQECAWUJgTCMV8l5XlfgCySfc6ZG8BQAOQMEG7VP9fatnKo01AXa3dj7LLIGDhXaVnBoAQYHEsojwrnKVjTldj7qTzLPqPAfjSPw5R3YqJMbCPNG7sjjqjIbvglzdpNirLHpfzp+9A5BOZHnKYAP8NehXohE6P5MVdlHWXYuECIbi9+iyX43oYR6URpBTDPeQnzDypUgWzsBvG/dnSXT8bBi/jbumreUomQHoV1x3yqZzW/jZ/zSAFURgA0W2fVz5DCTgD8ftYjn9vYWhOcIqBPe0M0nnmLGNBoNzp6QHWvQ6rPJSBKsA2sECg+A7/2wITF/tTUpERGuNzsWB0HFLBZGoOb8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:34:03.2912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ffdd98-ea54-4424-80ea-08df1e4fdaed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4140

Protect config callbacks with the access gate. Keep user copies outside
SRCU because userfaultfd can stall them indefinitely.

Run D0 transitions after releasing SRCU to avoid waiting for pci_bus_sem
while AER waits for readers to drain. Record blocked D0 requests for
replay in resume(). Return -EIO for blocked D1/D2/D3 requests, which are
not queued for replay. Preserve existing handling of hardware power-state
errors outside recovery.

Add a power_up output parameter to writefn so the PM callback can request
a D0 transition after the caller releases access_srcu.

Assisted-by: LLM
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
Note: The memory_lock/pci_bus_sem dependency remains unresolved. See
the cover letter's "Locking and open questions" section.
---
 include/linux/vfio_pci_core.h      |   2 +
 drivers/vfio/pci/vfio_pci_config.c | 104 +++++++++++++++++++++++------
 2 files changed, 84 insertions(+), 22 deletions(-)

diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index de0993280344..1dc9630dc740 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -138,6 +138,8 @@ struct vfio_pci_core_device {
 	bool			sriov_active;
 	struct pci_saved_state	*pci_saved_state;
 	struct pci_saved_state	*pm_save;
+	/* Deferred D0 request, protected by memory_lock. */
+	bool			power_up_pending;
 	int			ioeventfds_nr;
 	struct vfio_pci_eventfd __rcu *err_trigger;
 	struct vfio_pci_eventfd __rcu *req_trigger;
diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 9914f3ac69ae..e9480b573381 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -111,8 +111,14 @@ struct perm_bits {
 	u8	*write;		/* writeable bits */
 	int	(*readfn)(struct vfio_pci_core_device *vdev, int pos, int count,
 			  struct perm_bits *perm, int offset, __le32 *val);
+	/*
+	 * Write callbacks run under access_srcu. Defer operations that take
+	 * pci_bus_sem: AER may hold its read lock while waiting for SRCU,
+	 * and a queued writer can block further read acquisitions.
+	 */
 	int	(*writefn)(struct vfio_pci_core_device *vdev, int pos, int count,
-			   struct perm_bits *perm, int offset, __le32 val);
+			   struct perm_bits *perm, int offset, __le32 val,
+			   bool *power_up);
 };
 
 #define	NO_VIRT		0
@@ -200,7 +206,8 @@ static int vfio_default_config_read(struct vfio_pci_core_device *vdev, int pos,
 
 static int vfio_default_config_write(struct vfio_pci_core_device *vdev, int pos,
 				     int count, struct perm_bits *perm,
-				     int offset, __le32 val)
+				     int offset, __le32 val,
+				     bool *power_up)
 {
 	__le32 virt = 0, write = 0;
 
@@ -272,7 +279,8 @@ static int vfio_direct_config_read(struct vfio_pci_core_device *vdev, int pos,
 /* Raw access skips any kind of virtualization */
 static int vfio_raw_config_write(struct vfio_pci_core_device *vdev, int pos,
 				 int count, struct perm_bits *perm,
-				 int offset, __le32 val)
+				 int offset, __le32 val,
+				 bool *power_up)
 {
 	int ret;
 
@@ -299,7 +307,8 @@ static int vfio_raw_config_read(struct vfio_pci_core_device *vdev, int pos,
 /* Virt access uses only virtualization */
 static int vfio_virt_config_write(struct vfio_pci_core_device *vdev, int pos,
 				  int count, struct perm_bits *perm,
-				  int offset, __le32 val)
+				  int offset, __le32 val,
+				  bool *power_up)
 {
 	memcpy(vdev->vconfig + pos, &val, count);
 	return count;
@@ -563,7 +572,8 @@ static bool vfio_need_bar_restore(struct vfio_pci_core_device *vdev)
 
 static int vfio_basic_config_write(struct vfio_pci_core_device *vdev, int pos,
 				   int count, struct perm_bits *perm,
-				   int offset, __le32 val)
+				   int offset, __le32 val,
+				   bool *power_up)
 {
 	struct pci_dev *pdev = vdev->pdev;
 	__le16 *virt_cmd;
@@ -613,7 +623,8 @@ static int vfio_basic_config_write(struct vfio_pci_core_device *vdev, int pos,
 			vfio_bar_restore(vdev);
 	}
 
-	count = vfio_default_config_write(vdev, pos, count, perm, offset, val);
+	count = vfio_default_config_write(vdev, pos, count, perm, offset, val,
+					  power_up);
 	if (count < 0) {
 		if (offset == PCI_COMMAND)
 			up_write(&vdev->memory_lock);
@@ -709,8 +720,8 @@ static int __init init_pci_cap_basic_perm(struct perm_bits *perm)
  * It takes all the required locks to protect the access of power related
  * variables and then invokes vfio_pci_set_power_state().
  */
-static void vfio_lock_and_set_power_state(struct vfio_pci_core_device *vdev,
-					  pci_power_t state)
+static int vfio_lock_and_set_power_state(struct vfio_pci_core_device *vdev,
+					 pci_power_t state)
 {
 	if (state >= PCI_D3hot) {
 		vfio_pci_zap_and_down_write_memory_lock(vdev);
@@ -719,27 +730,51 @@ static void vfio_lock_and_set_power_state(struct vfio_pci_core_device *vdev,
 		down_write(&vdev->memory_lock);
 	}
 
+	/*
+	 * Defer D0 until recovery completes if access is already blocked.
+	 *
+	 * This check does not prevent a block starting during the transition.
+	 * A lock dependency remains: D0 takes pci_bus_sem under memory_lock,
+	 * while AER takes memory_lock under pci_bus_sem. A queued bus writer
+	 * can block the D0 reader and deadlock both paths.
+	 */
+	if (vdev->pci_recovery_supported && READ_ONCE(vdev->access_blocked)) {
+		if (state == PCI_D0)
+			vdev->power_up_pending = true;
+		up_write(&vdev->memory_lock);
+		return state == PCI_D0 ? 0 : -EIO;
+	}
+
 	vfio_pci_set_power_state(vdev, state);
 	if (__vfio_pci_memory_enabled(vdev))
 		vfio_pci_dma_buf_move(vdev, false);
 	up_write(&vdev->memory_lock);
+
+	return 0;
 }
 
 static int vfio_pm_config_write(struct vfio_pci_core_device *vdev, int pos,
 				int count, struct perm_bits *perm,
-				int offset, __le32 val)
+				int offset, __le32 val,
+				bool *power_up)
 {
-	count = vfio_default_config_write(vdev, pos, count, perm, offset, val);
+	count = vfio_default_config_write(vdev, pos, count, perm, offset, val,
+					  power_up);
 	if (count < 0)
 		return count;
 
 	if (offset == PCI_PM_CTRL) {
 		pci_power_t state;
+		int ret;
 
 		switch (le32_to_cpu(val) & PCI_PM_CTRL_STATE_MASK) {
 		case 0:
-			state = PCI_D0;
-			break;
+			/*
+			 * Request D0 after dropping access_srcu; the ASPM update can
+			 * otherwise deadlock with AER waiting for SRCU readers.
+			 */
+			*power_up = true;
+			return count;
 		case 1:
 			state = PCI_D1;
 			break;
@@ -751,7 +786,9 @@ static int vfio_pm_config_write(struct vfio_pci_core_device *vdev, int pos,
 			break;
 		}
 
-		vfio_lock_and_set_power_state(vdev, state);
+		ret = vfio_lock_and_set_power_state(vdev, state);
+		if (ret)
+			return ret;
 	}
 
 	return count;
@@ -799,7 +836,8 @@ static int __init init_pci_cap_pm_perm(struct perm_bits *perm)
 
 static int vfio_vpd_config_write(struct vfio_pci_core_device *vdev, int pos,
 				 int count, struct perm_bits *perm,
-				 int offset, __le32 val)
+				 int offset, __le32 val,
+				 bool *power_up)
 {
 	struct pci_dev *pdev = vdev->pdev;
 	__le16 *paddr = (__le16 *)(vdev->vconfig + pos - offset + PCI_VPD_ADDR);
@@ -812,7 +850,8 @@ static int vfio_vpd_config_write(struct vfio_pci_core_device *vdev, int pos,
 	 * of PCI_VPD_ADDR, then the PCI_VPD_ADDR_F bit is written and we
 	 * have work to do.
 	 */
-	count = vfio_default_config_write(vdev, pos, count, perm, offset, val);
+	count = vfio_default_config_write(vdev, pos, count, perm, offset, val,
+					  power_up);
 	if (count < 0 || offset > PCI_VPD_ADDR + 1 ||
 	    offset + count <= PCI_VPD_ADDR + 1)
 		return count;
@@ -881,13 +920,15 @@ static int __init init_pci_cap_pcix_perm(struct perm_bits *perm)
 
 static int vfio_exp_config_write(struct vfio_pci_core_device *vdev, int pos,
 				 int count, struct perm_bits *perm,
-				 int offset, __le32 val)
+				 int offset, __le32 val,
+				 bool *power_up)
 {
 	__le16 *ctrl = (__le16 *)(vdev->vconfig + pos -
 				  offset + PCI_EXP_DEVCTL);
 	int readrq = le16_to_cpu(*ctrl) & PCI_EXP_DEVCTL_READRQ;
 
-	count = vfio_default_config_write(vdev, pos, count, perm, offset, val);
+	count = vfio_default_config_write(vdev, pos, count, perm, offset, val,
+					  power_up);
 	if (count < 0)
 		return count;
 
@@ -968,11 +1009,13 @@ static int __init init_pci_cap_exp_perm(struct perm_bits *perm)
 
 static int vfio_af_config_write(struct vfio_pci_core_device *vdev, int pos,
 				int count, struct perm_bits *perm,
-				int offset, __le32 val)
+				int offset, __le32 val,
+				bool *power_up)
 {
 	u8 *ctrl = vdev->vconfig + pos - offset + PCI_AF_CTRL;
 
-	count = vfio_default_config_write(vdev, pos, count, perm, offset, val);
+	count = vfio_default_config_write(vdev, pos, count, perm, offset, val,
+					  power_up);
 	if (count < 0)
 		return count;
 
@@ -1168,9 +1211,11 @@ static int vfio_msi_config_read(struct vfio_pci_core_device *vdev, int pos,
 
 static int vfio_msi_config_write(struct vfio_pci_core_device *vdev, int pos,
 				 int count, struct perm_bits *perm,
-				 int offset, __le32 val)
+				 int offset, __le32 val,
+				 bool *power_up)
 {
-	count = vfio_default_config_write(vdev, pos, count, perm, offset, val);
+	count = vfio_default_config_write(vdev, pos, count, perm, offset, val,
+					  power_up);
 	if (count < 0)
 		return count;
 
@@ -1889,6 +1934,8 @@ ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
 	struct perm_bits *perm;
 	__le32 val = 0;
 	int cap_start = 0, offset;
+	int idx;
+	bool power_up = false;
 	u8 cap_id;
 	ssize_t ret;
 
@@ -1957,11 +2004,24 @@ ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
 		if (copy_from_user(&val, buf, count))
 			return -EFAULT;
 
-		ret = perm->writefn(vdev, *ppos, count, perm, offset, val);
+		idx = vfio_pci_core_access_begin(vdev);
+		if (idx < 0)
+			return idx;
+		ret = perm->writefn(vdev, *ppos, count, perm, offset, val,
+				    &power_up);
+		vfio_pci_core_access_end(vdev, idx);
+		if (ret < 0)
+			return ret;
+		if (power_up)
+			vfio_lock_and_set_power_state(vdev, PCI_D0);
 	} else {
 		if (perm->readfn) {
+			idx = vfio_pci_core_access_begin(vdev);
+			if (idx < 0)
+				return idx;
 			ret = perm->readfn(vdev, *ppos, count,
 					   perm, offset, &val);
+			vfio_pci_core_access_end(vdev, idx);
 			if (ret < 0)
 				return ret;
 		}
-- 
2.43.0

