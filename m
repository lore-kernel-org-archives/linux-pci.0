Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012033.outbound.protection.outlook.com [52.101.43.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748B013957E;
	Wed, 16 Sep 2026 18:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583907; cv=fail; b=n7nGl7kCfG8g7tTdXVVqhrnhP3y66X725w4+qhVpWZDDYqTwP0sde8pLmf/2BF1BohzrH3h2U2x0KK8r+fJDh///RRUE8J7jKaFSJoP1GIvhVyouFUK13GtXpu/wftX2nG651Oo4rc6YsuQg2d1yhJzWVx8Z3fOembSwSOwb6os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583907; c=relaxed/simple;
	bh=LZGAO4rIMWLh5dkA72qZcksnlVcbIkJE/30qQiKGAvQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fC+I7GoiSJ827aQFHB4Ij+3+zK6TEkeToceQAWZn+53vjgxBzYssdR/2pkTZ+8NmAZRgLzzeNIMOuLNXx80FFNeQgPUjkVumci7c8LTFaJIQiZ+FHz4famY+D77+IdkWmUr0DUXEdOH9Wyma5nGfuFusbFtbsNQpamaGougxoV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qrGVwlZ8; arc=fail smtp.client-ip=52.101.43.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qrGVwlZ8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yp3HE2OP3+IOuhnGNbQ2Vj34i6SEPgaj9m5JAs9gL4pyPE/mt+Jt8IyOImn7jXEa4tqaOhuoVr5D7HOs+rMNtlyDyAA6x1lmvtztE6mIl2jah4dkaZZPSrgaIXMbUJdXB43j8VQAe/f1Tev4bn0B6gudKcGWJEJLjn9jeugsJcUPri1+91sNNhEDTzr6RQDyOugF0a6J1I5jjERBlXHTBA2hDnGrTFPf1I0PHbADCZe7/VXG7iFxFi7PtXGbcIXVDgtxRx79oNn8ZxJ+HmqqIAoB8PYA6GkBJJq003Ku3Y5yiHeIu2KrSV3xxUyiX1xwWIqFubJ3HMJB7Z4P0jR6PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7o9qdGBXy1sMSI1xRHJqrRJdLEHCBys8HvfF8SRHp8=;
 b=Lt1AoXBrYxm5ghlABXO7JCiTX4UhjHz1VSH2ubJo7TIzOZNgrQolG8RLekDpvOgK7/qIk4OLm76IOqDXP1OjtwswjCRQavMN/EHn8oqoGDeuM/yp8Fzp0TMLbTB+bELGkNNTWCne4xdFxNtjXmVjPCfQCwz3ivvYfx8P7Mye8xhy+ZyxaobwLSzLhpE2E7xuT24IKBMrMhU/Bjid2wYqMhRKo7w/UUCH46bof+3iljhSmoFZnab3utTBVL1ydBWvwStzL2MwKeEUDganF80+tmEnVx/rRFW+69GT8zjmPQRzBNELOZXnNmRBfExjciY8oNxpWWD2Bp7bjEabee2Kig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7o9qdGBXy1sMSI1xRHJqrRJdLEHCBys8HvfF8SRHp8=;
 b=qrGVwlZ8UwW/Nz4CQaiUatH5ehujRkrqeNwhzTDjzZNtbNxZYqmJ/4cSN62jUedo85nCpwc+rxer15wgZKb0OhKBd9MVXsPUpxAF/rB3Ds1uKBpKQ10/z8L85vrIytqK/bAuYHxAw+fyvLo9rDGC3nDsyTEgBdQosU1vWZnl07QOfM9+c4Kaf0TDKApdI56FhOiUACN3dQUNspmkw+KreeV/xjDn1M6dI/4lCVG2JCcqdym+Lp+uirQJy77ujaStA73728RndDeSHywmwOsV9QEgWbKLsy0jMw3YTSaF/72j3OBwxZ6jYJfvDCnxeva7TibGjHACNysrO8UH22FoOA==
Received: from BN9PR03CA0156.namprd03.prod.outlook.com (2603:10b6:408:f4::11)
 by PH0PR12MB8797.namprd12.prod.outlook.com (2603:10b6:510:28d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Wed, 16 Sep
 2026 18:37:56 +0000
Received: from LV8PEPF0000006C.namprd03.prod.outlook.com
 (2603:10b6:408:f4:cafe::aa) by BN9PR03CA0156.outlook.office365.com
 (2603:10b6:408:f4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 18:37:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 LV8PEPF0000006C.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:37:54 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:37:21 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:37:11 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <ankita@nvidia.com>,
	<jic23@kernel.org>, <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
	<smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
	<yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
	<bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
	<gustavoars@kernel.org>
CC: <cjia@nvidia.com>, <kjaju@nvidia.com>, <vsethi@nvidia.com>,
	<zhiw@nvidia.com>, <mhonap@nvidia.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: [PATCH v5 08/27] vfio/pci: Fall back to plain vfio-pci when CXL init fails
Date: Thu, 17 Sep 2026 00:05:21 +0530
Message-ID: <20260916183540.3813685-9-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260916183540.3813685-1-mhonap@nvidia.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000006C:EE_|PH0PR12MB8797:EE_
X-MS-Office365-Filtering-Correlation-Id: 11e412c2-fa40-4506-9f64-08df14219f16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700016|376014|23010399003|921020|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RE3p6hJ5LJNgdot86YUymZbzOUjDlYzyKyGo19tLr7KstX0W7PPg347Lc1Q9weVblFTQwKP/lo7aY4o2OanQcwznqDvT87BwcBhTn60yU5xxzOQYNBU1dE9fHPIwnY1qkc15Bb3ABHoWkhQfzCYlX8T8pwVCqaYBqeJ1pFZOOTOd1LxqgkZYtVWbuSeUDqAoBkTsnZmJqdkuvZ0cwlL3Kyt2Rsnve/B7Z/rA8KgPnVfcLVr1XLrIrP4HF0VXvqf1ZVBeCHPab+/GkLjW6GMPjAbbaBR2WMmCuGT2XhJBybgt3kuBjjP1piKHM0SKPlFTRYDHx+KA//9JbIbDL3sVCeldDjVB5JXgnwbg4PxA9vybR8RnZ5nY72sYlx763r6jXClnVshV38qUHKF0UpgX7ta3rTyVJBIJtGpz+KeVjgAB6GCGGDgNk71WK2N25OWKNuHCtOYFRn9se1F5yGo9b/f1RaZXDUCcih0RZqNtS8DpH/Z3Rjg5POn4kg/9Du252j9fDwevI7oCsVVetcoqwy3LKpU0f6K9656Ex5ZMCpED0mBZPePMEy/bOLHMVpk6hBqlknwaUCiFY1QWe9Fu7G7X2VO4T9B7YOm6I3vj4UIJytBj1zHk2ReyPJzz2rpe4JDwGTujST97a2uz3A+LvV6XcIe/wL4LxnwIP3gfgrgxrN8AvWDcjwmsVRyYUQpRKQKja3IQ+/iJV7cRlmOMeq/EUm7qrXFaNQrX0d+67eGWxl5j4NK43sBiVuU9LjFE
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700016)(376014)(23010399003)(921020)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZSawq8P12N1LaBtphSPqfelHOJwjK8cD7B9y8sk9+tjkHt52JMgoBiPj9MGJnxFoiRsKpUH1QfL6EeZyOD9zDFgLVIlQ9uYvKR9G2y98SzAX+zZmDb4rQBx33X9Do9GkNBZGkhB64evgitV6YU9M8/qRAeXSieJ2QlTk/f1+flnlOO4QBeyjjFJzjnoM/JziPiPkjKS+jOeC92zsYYCXTFr7OSclIUrpenW00Z38H7cvoS6KxFli2UQEr2RV8GCsSjIlVZWYa0F1d3dwJNuZ3OwNBsWApwQGnnu569+C8kmV+1j55++rI/EEbEn5Bs/gRqKbra1QGKgkCLnuSNqklKYp+VE+8H7uZWpAGUiz38jOKE9IqbGXy6xtEGN1XLs5qUHmWGqbC0PdW1wU8GQiidPRg2ihBvfSyoCM/8im+/9T3uaP7JvNV5hwfcU/YQnN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:37:54.3662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e412c2-fa40-4506-9f64-08df14219f16
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000006C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8797

From: Manish Honap <mhonap@nvidia.com>

A CXL Type-2 device is also a valid plain vfio-pci device. If the
vfio-cxl provider cannot bring it up as Type-2, failing the bind would
regress a device that previously worked as plain vfio-pci.

Make a non-deferred CXL init failure non-fatal: log it, drop the provider
reference, leave cxl_ops NULL, and continue driving the device as plain
vfio-pci. The -EPROBE_DEFER path added earlier still retries rather than
falling back.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index a63a4f5228b8..9a75c30b67e2 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2271,9 +2271,17 @@ static int vfio_pci_core_cxl_init(struct vfio_pci_core_device *vdev)
 		vfio_pci_put_cxl_ops(ops);
 		return ret;
 	}
+	/*
+	 * Any other failure is non-fatal: a CXL device that cannot be brought
+	 * up as Type-2 still works as plain vfio-pci, so log and continue
+	 * rather than failing the bind.
+	 */
 	if (ret) {
+		pci_warn(vdev->pdev,
+			 "CXL init failed (%d), continuing as plain vfio-pci\n",
+			 ret);
 		vfio_pci_put_cxl_ops(ops);
-		return ret;
+		return 0;
 	}
 
 	vdev->cxl_ops = ops;
-- 
2.25.1

