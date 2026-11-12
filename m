Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493125;
	b=jtkEZlSlwCD5U2NcwI096ohS38T6vACY+g5cIJGGdwggmH4KdKWr4BrQmi4cdNWKmOtk
	 n1A0tcKOmaDV8U8lWWms+sJYdjodG7nEuIcdMPcCWSwVrjsJNOQQcnY87SIC9zOYRggHf
	 RHLjYkH1Z6FGGuqu0PNI0SQwbOyOMxte4rv7whsM1dEPC6P3Xl5CkXQe8mJ0+yy+CZdnY
	 cOsyme8ss9M5UhWzvUinOM6AT8YQF/yHYrph+KCxqJWwWw3bqJwXbMtoqEzmo8PXyCSTq
	 XrRN2wWbRty5Xooh+bAxNZCeYc4nWJB3kFU7F0oA5KMkPGFrMWBmn6P8Z0duSGlIDdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493125;
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
	bh=yqeGeiLiCdDTbULyAZzAHQuzZ+GMS9lhhu3sSwRRF5o=;
	b=fTdX4qZ3smOujeaOnK/zbiJTM5gdR8KeAv7Fggd9b1w+CQyOMz0AuhCfj9BRJuBbt+/Z
	 UwsVaSvcWRU1LqBBe9SykuolxSS1ui0eV6FETY/ZUSU8oHff93ID+avIHvzJe+YHG4rVt
	 cVF6qgIs2YR1iCOSMjMqJqguC7ODpejW+mfE5o66Rhm0s/ov3PITcJi0uuosMu5iCCA2E
	 cmBwNh3sFWyPhkGeb7euvhVsUWRZzUIkjQuJ5tGnAy9+7/qLUHajZRGZ2uJT0Brmm3Txx
	 BpYB+Ze1Zwsabcc48SGWrKEzFL9pjZwu5WEvpw2G+2ou4lKI46N89dgbiV7+CwWyojg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AW7cDY3A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.18
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010018.outbound.protection.outlook.com [52.101.201.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1C1606B838;
	Thu, 12 Nov 2026 14:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF1C1606B838
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AW7cDY3A
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJlAfM3rK1gRPKXQ0UpDM/7clEWpViKPmeYO042iEVoyLtSP0oS1u47gI4CF3i2/WpYbx1LlkxV14IPC0C52OcDDc1+SvIXVj34F8MCW9+P7sSMRMCLxOVj8WPymf03XM3gPIJvOzLffdWH75KMdc+/WR0WQDlo8qfCco2pwqsRl6J2iZKXJg8UlrufXuVFAGvTd8H/a8oYpg5p3v+DbMWeTtdTtuyrvukc73ghsYDB/XlQo0JRgfg7+DpJKLxODSLH08Il5LtohEAnXO1D7BC1Bi3T9snAPHD/kNIlvCFpPZUsmoQ7aW3cthJyOZXe6batYtTR61Q7amu2Vjeid4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqeGeiLiCdDTbULyAZzAHQuzZ+GMS9lhhu3sSwRRF5o=;
 b=Q3zGqXE4qFizHG547JeTpvbR03LI1NPb5MQNnGgZzsJWb475Ax2VQV3BFPX1hmUCRksamlidZMuQyqfk6a9D+8rJLExstJCEolX0Py0hDQFPm9msVTDav+U4F0J37FP8effiDJKrtIx4rwUTxourRiFLj2jlkaWWaieF9VLrc6wmfLbrggKBg2UhzbyiJ2WJnR43Jph8cbTbLC2uSg1ZPvtNmoQkFV5N+az9JO0yz6IJPwzeAgvheYgL2sWUg1ub7xvfDdnVX1JA9c2ya3f69wFCuRoOPQaJiPwcwR7BnlPJG84VcTUvH+7dCF3VG+iCVx/fc4w9lUr/PbH/rcCs6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqeGeiLiCdDTbULyAZzAHQuzZ+GMS9lhhu3sSwRRF5o=;
 b=AW7cDY3A27jCq6anM/7SnpIpXyTZFvqflSWxVSFGMwPZCYCBHT0ihX02pGbuYJt/GEo68Az2AgIRkgj2IwKlPv5cmRQuBqhl7zSvt0sIlfZKG5q8PoglryJUSPIDXJheUh5+XYRkUX9dqn1QdwwgtCIIXozWxmZPF5OOL4hc0/ykzBtGdzoJwn6FW76IAEzbAdzy5WyyObfxbSO8vgLBRCVtkaLnAmxqpsXyQq5IFw/eyWK6Bzw6voqzHI0FtipWVto9v7nM1gCGBJi25s35fllwRbQeIMtBJ0PO9LkbiE0HGvMq+sTT98HEvEQcFaNtTQc3itjvkF3p91+INaim+A==
Received: from PH0PR07CA0116.namprd07.prod.outlook.com (2603:10b6:510:4::31)
 by BY1PR12MB8446.namprd12.prod.outlook.com (2603:10b6:a03:52d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 14:18:39 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:510:4:cafe::7) by PH0PR07CA0116.outlook.office365.com
 (2603:10b6:510:4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Thu, 12
 Nov 2026 14:18:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 14:18:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:18:16 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:18:13 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v3 09/20] vfio/pci: Use access ops for function reset
Date: Thu, 12 Nov 2026 14:16:21 +0000
Message-ID: <20261112141632.918954-10-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|BY1PR12MB8446:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff6aa37-c2ec-4664-806b-08df40c7d8e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|10067099003|5023799004|11063799006|56012099006|261022105027099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	SJ36z7bhJK3tDdylb8tBwEN3iTvHjbHVLy8KAvvnoPfOAn10BAjvHPdYWvpJF14mvDeoPgyeKPh3R0sin5UpjO/nWV7zCZrkKnozOGU77dIsKIq8sUnE29sqRp5KR+mk0VRiF83d1QokY7zw5LYHs+erB7Z1EI/iLlDWPW0Q3DPwNOfoNynmCLGSGOiuyInHgT3Gmp9xNd7USCJnFVDfjHSpZnYs2orDZ8+9TJUS55QLVr2yp2VeOg2l+NLTbLFug3SX61QmD6jPn2302Jho0ylNbjFK1U2D62FKDpfB3IlkVRin0khTZg12VHpHh2xEIWJymZdI/R3RiLAldJvYUN8TfLgj+/KIS2k8TfUaCFAmpiztaVdHCDX9LnOPpwWRQA1FfDicQmtl6+UP+Wxx1ozRFcD/xyKvI11yVNFc+MYuo9gyJUOv0C/6PWZJ/0QN/dazKu5K3iOZxBE39Vj3ySss3OWAsuWE9q+XcQtDiY6hArMtT0kJEe6qzJQ2TMtk5fSMEHIn8iEFyIpqRryVJGekaV1nIJ63wWjFZa0HxNvETTYIlpSmeuH+UlQFn2JvQkkLFzCYl7Y4t8r1XcY3MOfUovgqmtg1bBvuZw3Isz+/n376ABr9Fh+OrbRNSPPA6DueUeYxJd5EnYcg8WZvSc2dxVnCUc/SpCozbqy1PptrGlCGGwUEFbqlD+p11vm3RVe90yz7NU0PyoIjkCM7Jg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(10067099003)(5023799004)(11063799006)(56012099006)(261022105027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Mfj1zBhu0pquECQCfwFYbcM19BOCuQ/ARDk2qdqVUo1wYFe7zWCSZyJkEA6QwR5+ivzywFt9YXovDOduDCYpDN4YtkyvX73I61V1DITW1hxWeFTF0li9hnvhR0vgkRABw7rNuGnZWu4JxTdMRqGAvlnp3j5kOTBgjQ8+DHTz2JTu6RzSYbOcddxXI5KAaK65ujQrAGSn4aImgC6+nsN+FDbBQM26y/YINNLC9lNUYrHyWo78xHNjZ5lRippgfNRmjYf4G+1PvN73irNA4cE7LG1eXDyl9WrS2SyinGqsHrxiQPtxWeZk7WwO13kZ+4K+ciTKNLr3Yw6fB1fV3VExbN/IYPBzy1kfs6GnN0KfwrsHMAz9QsEaHBErG6ltOoVbNaGzIzCgeFbDEKU38BtxHudt6MseK66DDZC6g6GQrmJenUJtM5MuSEKQY6VjBeVG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:18:39.0670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff6aa37-c2ec-4664-806b-08df40c7d8e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8446

Userspace function reset and its D0 preparation must finish before host
recovery changes device state.

Run both through the SRCU-protected access ops. Reject blocked requests
and let recovery drain admitted operations. The D0 helper returns
-EAGAIN on bus-lock contention.

Hold memory_lock across preparation and reset so concurrent PM writes
cannot put the device back into D3. Keep the existing DMA-BUF mapping
removal and restoration around reset.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index de3a1c8b6d9e..fb7f46c2ca36 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1474,16 +1474,11 @@ static int vfio_pci_ioctl_set_irqs(struct vfio_pci_core_device *vdev,
 	return ret;
 }
 
-static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
-				void __user *arg)
+static long vfio_pci_access_reset(struct vfio_pci_core_device *vdev, void *data)
 {
 	int ret;
 
-	if (!vdev->reset_works)
-		return -EINVAL;
-
-	vfio_pci_zap_and_down_write_memory_lock(vdev);
-
+	lockdep_assert_held_write(&vdev->memory_lock);
 	/*
 	 * This function can be invoked while the power state is non-D0. If
 	 * pci_try_reset_function() has been called while the power state is
@@ -1494,17 +1489,27 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
 	 * 'vdev->pm_save').
 	 */
 	ret = vfio_pci_try_set_power_state(vdev, PCI_D0);
-	if (ret) {
-		up_write(&vdev->memory_lock);
+	if (ret)
 		return ret;
-	}
-
 	vfio_pci_dma_buf_move(vdev, true);
 	ret = pci_try_reset_function(vdev->pdev);
 	if (__vfio_pci_memory_enabled(vdev))
 		vfio_pci_dma_buf_move(vdev, false);
-	up_write(&vdev->memory_lock);
+	return ret;
+}
+
+static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
+				void __user *arg)
+{
+	int ret;
+
+	if (!vdev->reset_works)
+		return -EINVAL;
 
+	vfio_pci_zap_and_down_write_memory_lock(vdev);
+	/* Keep D0 preparation and reset together under memory_lock and SRCU. */
+	ret = vfio_pci_core_access(vdev, vfio_pci_access_reset, NULL);
+	up_write(&vdev->memory_lock);
 	return ret;
 }
 
-- 
2.43.0

