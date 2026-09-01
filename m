Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011041.outbound.protection.outlook.com [40.93.194.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1002479899;
	Tue,  1 Sep 2026 09:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255233; cv=fail; b=ttSkXCsgLd9uPPX+z65nF+eKv1q1LbgN2p91G1xChJ2E6pIB/TscfDPwxOxKm5nQubpXvEKv+GckcNCFR6cnXrs59lbXPJs8uJHvgTpAemROeV4Dy4pX4GaiN65XcwR2VitHjjL5uWIGah/eBi+MQjQAqaDbE9bQVS2d1cIqyDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255233; c=relaxed/simple;
	bh=oKfis5IYjBpNMMKH/3X08d15gbhbFzJbIFMTe1Nfnp8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0NmyhqnhAd8rnDlRRyC+UA7yV3ZHRfwiNfDdlMIoRxjtGk8CXSTkwMDcccqcrTnFjGIDw8cfv723m32RtmnHtBhDE14gS1fFL/OOt9HmZDdY1T/F8pzauOBa1MqppXdy5YP1M3kpiwxK7PCzogInC9pDzZgRb3gylcexnkTxi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sy9yFWKn; arc=fail smtp.client-ip=40.93.194.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sy9yFWKn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vcAYOqqTDy9DOAuNuYsCxEDli1p+0rnIgQDt4Iqus/woUBTdqvedA7U+HkRV2Bx3QWSKVLseVVpoSFhQshQfbtqWTJdDeXTYJDfFdBKuVKsny6Thy2DUP6Jb76N9Gqe0hO2JYcIqSVs0NFxKrxYWFFcLSE1wxEZoaxYXwX9acWFLKqdPXVzr9OIgWr8wRdAzfX2UUTpgmhqZhbqmkot3ouU5PGX0U20SOlGKCnob7El09kuVEirF0i8vwoyA+AZB8tIum5ovTuUoBRMCMon8M81Pyc5rupOq9pz+MwpasVadO9tu0PM3R5Qx8UAFC4cNPIOSIgS0RsvIOPFVWrJyjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsVHDVIQ7iJptVDDyKc8hVRL/XSx8/O8tcF+kGZBAqY=;
 b=vaM61EfzCKBYluXsIcspFo0+ozBpodVMRgZ3qMYB+ZvZe/0tnWESXAgzZC0SrvBEP11/LC90+DxcZgLECjE8MXK8E35NcRU1TtmhoS4f8xefKtOXv+wDEZ0xCVG5hnSSgmu6pFCdbAmRY+cpu4xGdXDvhHwoK299eTtETDCy1DGFAvGiR/xO/3WrvsaycMwYrC9jeP4iZMGjcwGGsTBtM79PBdi3Qiz6WIQK/FqmnEywtGGKXk4PUv6d+/HCMSahFajzvGPOURv/nbGUjjNk617oGKGGbrO9WyBwLigwVqr7E8TE6DKTzgODhJp+8z8wJCvhkw2IOCRoOfz6T6VXvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsVHDVIQ7iJptVDDyKc8hVRL/XSx8/O8tcF+kGZBAqY=;
 b=Sy9yFWKngMD2RrhKybaAHzZ9pxNIBB/35+PMJ8aa8sM52Nj9wodC09vGFPi2H3twnapm5TdHXT7odu3o7MrEqhACZVan5zWeDyrnLg0f4DE/1Jy0MoZA1QgMCHi8kM1GYv/qEzYq0ENXHyiLzm17rQ1J3oTViQEj1Lb+gLAY5PdvdeYq62U9yD74fyD8UUHFmhxAcWhADCAYloYhtnC0cdrR4FfuC3Eg7bxiOqjNQuJwEcX4vUYY3Iu7m2NTZDj76vqDUKEOZa1XfwJn+FcHqfRCJrKQCXd0tUvpmpflcvr/aK/XAlaRh0EftFzOfA6XkkKy79OFI98FnMXGJ2uq0A==
Received: from BN9PR03CA0219.namprd03.prod.outlook.com (2603:10b6:408:f8::14)
 by PH7PR12MB6934.namprd12.prod.outlook.com (2603:10b6:510:1b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Tue, 1 Sep
 2026 09:33:35 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:408:f8:cafe::28) by BN9PR03CA0219.outlook.office365.com
 (2603:10b6:408:f8::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 09:33:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 09:33:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:33:16 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:33:13 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <nathanc@nvidia.com>,
	<mochs@nvidia.com>
Subject: [RFC PATCH 01/19] vfio/pci: Add PCI error recovery support state
Date: Tue, 1 Sep 2026 10:31:59 +0100
Message-ID: <20260901093217.8539-2-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|PH7PR12MB6934:EE_
X-MS-Office365-Filtering-Correlation-Id: ec0a3515-53e5-4782-4820-08df080c184b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|6133799003|10067099003|56012099006|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DO/qjpHXVsXSDHkuCkrO5nr2d/0QRGDL/bFFh4WAJQpj4LrHjGlfwgCaBG48I0XhD/4bZGX7PrkawTBYpAK4tHsPC4ACvjwpZ8yc0V7vf0Zffq2c+Mio2R8jc19sMshAMVQM0KvGr2dltrXePb1/A9OMi+Yn0pN0KUTG/TD2rx5gzh90PAVebZ6huof/ybZ93NcsXONdS4qJATyq2Bb/fbyPdon/PbpSK6aQnHMezGVCNI0rs/WahLuNBW4/ppo7ZjGxAgYD4OuNF+1hT1SFMIHxNbJfiJAJ/m4+Hrc+x+mC5wZnsAz41y7IqQQmPntiXXs6Y4xIn1x91XSgcefPgOdqm5abS1NxHTmbJsnNxr/8j53jwqII+ot3K0Cvgn2REPUsO/4cFwHG4Bx7/KNDPLBk/Y1uI+x7OyiAMt8h3bizyaHS2kdWxj9bCVJEWZXevGa8yN+75K+t8YnJeAapBqY+72qzlLpqiwQAulDuWwKvS+YInmroETlHMrTFCWWRHYPx2+/jneh8ANHQ+AgQCji26bjAuLFZuClAeaeNi5xsccEXMr/zgirKnyQq3V1M0mL6oXHPsdoae0lQWi9iypA7c+dAKarN0in8Q69Nt1reot2vk6e2R4h/6nm8CGIDchZA1K2eOBlAz/PteQAW9heeNIn2WreqadDKidCBuoktbGv8jzrn2NU0YWKnWTOWwMcExHb8vEDilSBvqErFkQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qJGVDH1McRTLZeupKBSsqbBffnBf8M1wuWhcCNWPsgxB3n73R3EZtIylASDPxxOJxVRvdWDg8mB/Hfe8aTAeHp2xY2UuxKeeqzZYlH1aQTlLqyf9AseE/GT5UJeuHPmKT57/jKBlur2Ob9WWXGdd5Vo4Ft1DMRYlS8L/lbJIPYQ0OkTyZMbGmJODvfG/HESoGjTEJq1PKB4Ng8P+hxDK0wMwNv7bz3zfmTlVc/QHeitGtokvMtkiyJx76pUwPyKlDUfgGo/xpsiWOmvouF2i/zreKc4eVsLrRpqKJH49t0J8X486lfoO5WGAHkEEig2ZnURV/TpFd2BQSI/U0FuaHDLsMXQqEEulMLz2nc8pqXgkuq0GJwKnzPrPcEmLiZUQd7nBshRvIC6x2CCqDda5SizVsGgcyAoobXn5UKNtMRPoUn2AZ+DmDlOb/EuXkAcM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:33:34.8197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0a3515-53e5-4782-4820-08df080c184b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6934

Add the state, the lock and the wait queue that the rest of the series
needs. Nothing uses any of it yet. The lifecycle and the access guards
come next, the recovery callbacks later.

The flags word records what happened in one event. IN_PROGRESS while
recovery is running, FROZEN if the channel was frozen, RESET if the host
reset the device, and FAILED if it did not recover. These are internal.
A later patch reports the same set to userspace along with a sequence
number, so an event can be told from the one before it.

Where both locks are held, recovery_lock goes outside memory_lock.
Recovery has to shut out new device access and wait for whatever is
already running before it can take memory_lock and revoke the BAR
mappings. The other way round deadlocks. An access path sits on
memory_lock waiting for recovery_lock, while recovery sits on
recovery_lock waiting for memory_lock. So nothing may take recovery_lock
when it already holds memory_lock.

Only the generic vfio-pci driver advertises support, so variant drivers
carry on as they do now. Userspace activation is a separate switch, so
even on generic vfio-pci nothing changes until userspace asks for it.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/linux/vfio_pci_core.h    | 59 ++++++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci.c      |  1 +
 drivers/vfio/pci/vfio_pci_core.c |  2 ++
 3 files changed, 62 insertions(+)

diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 9a1674c152aa..42a77ed6b93c 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -95,6 +95,11 @@ static inline int vfio_pci_core_get_dmabuf_phys(
 }
 #endif
 
+#define VFIO_PCI_RECOVERY_IN_PROGRESS	BIT(0)
+#define VFIO_PCI_RECOVERY_FROZEN	BIT(1)
+#define VFIO_PCI_RECOVERY_RESET		BIT(2)
+#define VFIO_PCI_RECOVERY_FAILED	BIT(3)
+
 struct vfio_pci_core_device {
 	struct vfio_device	vdev;
 	struct pci_dev		*pdev;
@@ -129,6 +134,7 @@ struct vfio_pci_core_device {
 	bool			disable_idle_d3:1;
 	bool			nointxmask:1;
 	bool			disable_vga:1;
+	bool			pci_recovery_supported:1;
 	/* Flags modified at runtime - dedicated storage unit */
 	bool			needs_reset;
 	bool			pm_intx_masked;
@@ -147,7 +153,60 @@ struct vfio_pci_core_device {
 	struct list_head		sriov_pfs_item;
 	struct vfio_pci_core_device	*sriov_pf_core_dev;
 	struct notifier_block	nb;
+	/*
+	 * Serializes host PCI error recovery with device access and the
+	 * open/close lifecycle. recovery_lock nests outside memory_lock.
+	 */
+	struct rw_semaphore	recovery_lock;
 	struct rw_semaphore	memory_lock;
+	/*
+	 * PCI error recovery state, written under recovery_lock held for
+	 * writing except where noted.
+	 *
+	 * Some readers cannot take recovery_lock. An interrupt handler cannot
+	 * sleep. The ioeventfd write runs on a workqueue which is flushed with
+	 * the lock held, so it would block behind a queued writer. A
+	 * wait-queue condition cannot take it either. Some checks would refuse
+	 * work against ordinary device traffic if they took it. Work deferred
+	 * past the guard has none to take, since it reaches pci_bus_sem.
+	 *
+	 * Those readers use READ_ONCE() on pci_recovery_flags,
+	 * pci_recovery_enabled, pci_recovery_access_blocked and
+	 * pci_recovery_device_open instead. All of them fail safe. A stale
+	 * read costs an extra refusal or retry, never an unguarded access.
+	 *
+	 * recovery_lock does not exclude those readers, so publish each field
+	 * with a single store of its final value rather than clearing and
+	 * then setting. That keeps the states a reader can observe to ones
+	 * which are meaningful on their own.
+	 *
+	 * device_open and access_blocked mean different things. device_open
+	 * says the device is open and its per-open state, vconfig included,
+	 * is allocated. access_blocked says a recovery or reset is blocking
+	 * access right now.
+	 *
+	 * access_blocked is only ever set while device_open is set. Nothing
+	 * sets it without testing device_open first under recovery_lock, and
+	 * close clears access_blocked before it clears device_open, so a
+	 * block never outlives the open which created it. A reader which
+	 * finds access_blocked set can rely on the per-open state being
+	 * there with it.
+	 */
+	u32			pci_recovery_flags;
+	u64			pci_recovery_sequence;
+	/* PCI_COMMAND value saved before recovery quiesces the device. */
+	u16			pci_recovery_command;
+	/* Userspace enabled recovery for this device open. */
+	bool			pci_recovery_enabled;
+	/* pci_recovery_command contains a restorable value. */
+	bool			pci_recovery_command_valid;
+	/* A recovery or reset transaction is blocking physical access. */
+	bool			pci_recovery_access_blocked;
+	/* Device initialization completed and close teardown has not started. */
+	bool			pci_recovery_device_open;
+	/* May be set while recovery_lock is held for reading during ROM unmap. */
+	bool			pci_recovery_rom_disable;
+	wait_queue_head_t	pci_recovery_wait;
 	struct list_head	dmabufs;
 };
 
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 830369ff878d..46544dbe70d0 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -139,6 +139,7 @@ static int vfio_pci_init_dev(struct vfio_device *core_vdev)
 	 */
 	vdev->nointxmask = nointxmask;
 	vdev->disable_idle_d3 = disable_idle_d3;
+	vdev->pci_recovery_supported = true;
 #ifdef CONFIG_VFIO_PCI_VGA
 	vdev->disable_vga = disable_vga;
 #endif
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 6757054e9d87..e0be5ddf7039 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2196,7 +2196,9 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
 	if (ret && ret != -EOPNOTSUPP)
 		return ret;
 	INIT_LIST_HEAD(&vdev->dmabufs);
+	init_rwsem(&vdev->recovery_lock);
 	init_rwsem(&vdev->memory_lock);
+	init_waitqueue_head(&vdev->pci_recovery_wait);
 	xa_init(&vdev->ctx);
 
 	return 0;
-- 
2.43.0

