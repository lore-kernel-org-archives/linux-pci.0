Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013062.outbound.protection.outlook.com [40.107.201.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61450470EA8;
	Tue,  1 Sep 2026 09:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255269; cv=fail; b=UmhirH6GwLgLsESER0SdECTEqqQyLxfk/TmkbtcWVefJ9Lo88tGdHB3y2Hfdt0g8hcjCaSB0JNY4r/soj0WmJGI2gTpSYhUou8oMrr384krdtjMduEcegHAIdEDGVFupq9+T+PhW3AB+n9GlmacK0UZkB4k9ODxnxvIJWmIo+8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255269; c=relaxed/simple;
	bh=Fym25nMiS4L9H6deI4pf6dmoUXP7D1xZZLTX4z0jKS0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uRHwwONpRihW1WaXZQT4K/DjJh3ae/bqv1zQleo/5aulqi7YiJvjjpPx7cwWhT30WNkYRU0Oc5gHexNoIedW8VOCYkIwQ/y+KZY7wccpqYSK0XIEZMcAkqXl1h08iyLrv/0dbI3rdUS2AMNBNFGI2Y1iVAIjQJASMNWD9PIICGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NGxZrLiA; arc=fail smtp.client-ip=40.107.201.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NGxZrLiA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hckE+BMuDIq/HbMHXfmvhPIrnVQ7ULX89ihK+VUK21nWAVcGCnxo1TF5hiFQPXHW5ECFtuIujfNlqNu/QaE1ZS4a26QMJ+FZT8nTGP1H44NkvEe5FijViHHNtwjKH1POAN4zS5Quk1AhvAW1pZf3fx132ruc7WWVDjivSPqro9z33JnxLv/QNjzvXey/gzRVsGbyCGzs4UnBKIBb4OUqYCQ4tyLaojKwismkPXA7At2q2RYmDoBjd7EQqM6hw3DqBxThyXsTcQ18ts0DxlcmVZeGpQ0wXszB8FnTF3YGQjYTd6UbX/jr8lf2+42Fz/f3NkFkrqvGrnz0EQpzmi8YtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtSHOhkW2Qnii4iyhAaBDsc/xs0eHQyhWcLvveBNd0Y=;
 b=BXurCIKO+Mtob6oDURDzncoACZaYWb9crx08FC/vWsXkrXtMZpChxXQNyXYtn+9EhhLBg4Dub12m2B67pzyeivSeoFyfTByIyCeCMUZpVytwLeQdkngOS9nPJqoQkv1f66eLCzA87gA9EQ5HkxG0btcYme+Fa310CEHKSM+09hdHwm2wtQG1FvYQ4OXgj0BTriUHx7MQwyRiY9ql2z1NQeQl3EZb4ByOTzesjYH5HFqQRr3azNxce/vcETVm6BJMh+QauvDT3xiXQUk24HKjmnRRhHGo7kfOBbJ+qDWxUFvzhuiCRuo3Ff/EVbywFLO1q16VjptKYvNjx2jkukLwzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtSHOhkW2Qnii4iyhAaBDsc/xs0eHQyhWcLvveBNd0Y=;
 b=NGxZrLiAcIffPnD5b0qcK3MpFEEPK7aIgay/65LjhH3DDXvQigOsq6ML5B1eh1MJamEn0YzL4nlT9Ylqp2O2AKQQ2vjmq8GE0NRxYG6FLkSVfR/sAS43kupxGZw8FHRBFzbGcQB6V22uSxbqCqpKat0HmpK0vC0EEqUtWXmGKGEvSbC5HHbjtZychFXNFoU8eTYQNMTb7rojueQd2I5U/sgnz3kYQF/nXdplDasdvxAhyIfHwv5D80yYGuGDe7JtJx8L8NtN/YXko9Eywn0+5i4H5qHRpdYN6gZ3rn1hH0sjW+I9VTmaLmfL4ABu6wwv6fy1YtEK+JbpdDJ53832Gg==
Received: from CH2PR16CA0028.namprd16.prod.outlook.com (2603:10b6:610:50::38)
 by DS0PR12MB8788.namprd12.prod.outlook.com (2603:10b6:8:14f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 09:34:10 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::2d) by CH2PR16CA0028.outlook.office365.com
 (2603:10b6:610:50::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 09:34:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 09:34:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:33:50 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:33:48 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <nathanc@nvidia.com>,
	<mochs@nvidia.com>
Subject: [RFC PATCH 10/19] vfio/pci: Serialize hot reset with recovery
Date: Tue, 1 Sep 2026 10:32:08 +0100
Message-ID: <20260901093217.8539-11-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|DS0PR12MB8788:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ec9f7c3-d9f1-4ab0-a22f-08df080c2d26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|56012099006|10067099003|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	orbt+P0kHBPFF7rfQprQEURb3/JgIqtuDTr6UUXvDmbCXYK1+wBFWrMbCSSTM0N4Iv6oXutFKD/PJ00PhcGmr0Itenv++egiOIlIAHdB3fyIFLpX4a25dSkMDMMHQe2r/Rn1VxAdRq8vnB/ze1XJfhZHY84hn6ecafo8hidVt+bkpIOAedsdN/8QVqWG1GmKuRX48w+DAmBlpr/KB6CzfxZxdrN9RumCf9msqVxesiS9PSye5u5Lp2zdc0SkNVvckpv5shYZ8uVl8EfOA9RGAqJOLPV7K4ZWFGmrdCkQGBVk9zW41rFw+svmp3mY1ptYtp6WCYPDUoJIMOgiMw9fztdNXa8ovQhAr1BLTUiRfVvQ2wAq1yig8BgWWuveO80Rx9HpzifsAwg1rklHIHGWXfsmMHASdMmybsIliV3IKROzFnELUXTvu4Z1mYBPw6girnxxbZIXPIdUVX7bSypCzbGZTMDuFN/IBmIljzm+IsOD+9NjzX+HCw9pJJJclQ1qLAGeA6008xfJXZamTjAcpyhbGAmsEikHkSVIHkHXtx45uEZVpzbpsOGcjVkuBYJ1tpKxPTmqWNsBKUnvhFJ5wI0E8JJWyW1BHzuhMsIxAXPIVUcEbrOb45xv4k3aEtUc3YDjJCL8J0wq7jQX1QBJ5ZPSLg2BnlFG5NureN1Kn+tLyF6usMB4nw3Bq1BF1dbEaS3/d0seupCbqe3a5S8F4g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(56012099006)(10067099003)(5023799004)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IHMazd3qewQKMo7+xkLEjfpOeA03XMQ8Xw18c+99oRd7tz5GjcA8yB3e6FnmU7HxPbnDuJgXJk2SLiv8bxGaLDvq5zUiIi7R59hX3d06C00hQ2yhVpkAVnqddRsbbDoTM3wi35DBPKu7l+7vAP/W3i3hUgJ0bR+tY6JlLSFXCjpCLcU2REiSH1otDTbhXYxR48lXTrf0btMH5rhq2nd5Ejy2XwnQDyyLKUwj6Bq1XyNxuIZOAojp4RAuZig8pSdmkRVDIBBL8dGxvnLd1hn4aoquaDSdMHkQXwVjM49+zWmPqxEpt6b/ZZRs2LliQXwYKNPg5DEIxW791yN//fMImymnKdqO13ANV9zYO3j+BA03mSakppEr1LHGg3ZS13oj2EjLMgkgs8pT1ffERnu6gKLz1l2qvmP1qaLBRK0gWu45d4EzBQhAe29k4a+t8iiv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:34:09.8434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec9f7c3-d9f1-4ab0-a22f-08df080c2d26
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8788

Refuse a user hot reset while a recovery transaction blocks access to any
device in the set. Between the AER callbacks memory_lock is not held, so
access_blocked is the only thing marking the device as unavailable.

A device which has failed for good is let through. Nothing is running on
its behalf, and a hot reset covers the whole set, so refusing there would
stop a healthy sibling from being reset because an unrelated device
errored. The failed device stays blocked either way, since the reset does
not clear access_blocked once FAILED is set.

Do not hold recovery_lock while resetting. pci_reset_bus() reaches
pci_bridge_wait_for_secondary_bus(), which takes pci_bus_sem, and AER
already holds pci_bus_sem when it enters the driver and takes
recovery_lock. Holding recovery_lock across the reset would invert that
order for every device in the set.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 876ff51d6987..bd3d79d28f27 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2937,6 +2937,27 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
 			break;
 		}
 
+		/*
+		 * Between the AER callbacks memory_lock is not held, so refuse
+		 * the reset on access_blocked as well. Read it rather than
+		 * take recovery_lock, which would have to be released before
+		 * pci_reset_bus() anyway since that reaches pci_bus_sem.
+		 *
+		 * Let a device which has failed for good through. Nothing is
+		 * running on its behalf, and this reset covers the whole set,
+		 * so refusing there would stop a healthy sibling from being
+		 * reset because an unrelated device errored. The failed one
+		 * stays blocked, since the reset does not unblock a device
+		 * with FAILED set.
+		 */
+		if (vdev->pci_recovery_supported &&
+		    READ_ONCE(vdev->pci_recovery_access_blocked) &&
+		    !(READ_ONCE(vdev->pci_recovery_flags) &
+		      VFIO_PCI_RECOVERY_FAILED)) {
+			ret = -EBUSY;
+			break;
+		}
+
 		/*
 		 * Take the memory write lock for each device and zap BAR
 		 * mappings to prevent the user accessing the device while in
-- 
2.43.0

