Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012034.outbound.protection.outlook.com [40.107.209.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA3243E486;
	Thu, 13 Aug 2026 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613902; cv=fail; b=MFpJBoyQBO1bnO7gF3tp1Lfw6raiNZWwertksk8zjchzNnXBkMg7ZHkSLvO7SZzUE1MN/+inJSEGviJsaApkZZ5cJnbBM1JADwmDuCzdnmS/Y9Nod0Ey8zxmBSXx8p2KsEaG8i/n8VbIyeA3mds5LLpEdf2CkVrIM0uO6qrAdc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613902; c=relaxed/simple;
	bh=rBq0ZlisUKL98JQCPjs3yiNyNJYu7obgDUGy+nKQUis=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MoK87u2ZbPzpmhvTSUg7KIfZ+ntjQcquE1fpv59GXk01cCYIu5Sy/15qmZJ72os4m4I7qbbB4Utey2CRu1qBwD7Tklf/5G6tdTmmjeqMaWPz/BF1F8/9VYutlfHCNxDyHfbZl6yJnsX31fJqK0amVRZ1eo0T67k576dEWNOgfWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z1/mcwMx; arc=fail smtp.client-ip=40.107.209.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z1/mcwMx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAcZLS2vDSatfcuScT/LPw5ADdnb6B/+UOcb7KnW60Pdl8GWy+Ky4PPgo9Tz4h7uL00M05JiM+rQiAOSrDF6412C0vgeZ45lxqWq+EVv9L6y4MijG6dCxizTH88pnQCE0VSRSlovqH+tnmtwzT4E5ecI3jnYsas4VjojE9cySZVVANui6q7kbVMgfy7H4xjeqe6ZrpZUmurNxRrWvzhGfBHn/Irrr7H7EhodCirjCTKW5Sm+DiHPdJrlQ5sKGYO5Xn/MP6jAdsv4v9NPHbcRz+TREjPYtd7PME4BjBpxgaC3rpqRvZa44DiqGnxx7xm4KPjDfUYby9LfLUpW8FBuow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5R9w2pLXzdUpphYD4Zbi5cnV8Llbn7JsjyagU71Rzmw=;
 b=FSCRoImkKDq6K3K+G8u08yNTUvYLPdp+K95dnfF2cUwiqU5A8vguta5w2UzqsdRpPe9qM4nd72ckspsERORnxG0vrBL3hFCMwzW/5pzSCqRv9puWsPr4KI+xHeV4s4YXnCUoOeahKzdQDlMVuOU7uN2oGeIHRMZzB5AZ/yK7CQjg6BeQG2uaoD7EFYEquJcPPLiCjaioo2IO8IfFiCTajzWzn70l/YqPWZDua6sPVcdksGWadvupcxiaU+GJYD/wu44tTSbUh0VnNYOUSLDaZ4ZwRc8lj3AF95oIHuRhkochlAY1wo7Y1YsBmOgO6C6o8o8hkF1pI3K5jWZ5lDAG4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5R9w2pLXzdUpphYD4Zbi5cnV8Llbn7JsjyagU71Rzmw=;
 b=Z1/mcwMxNTJGhqiqoz/ld5ZE9GE3RytOdgpICK1KlKpjMvaDerMVcAeSKaLId/rKixmqIZMnfcXK94qN6RJM0DoT5LZB5LypVuFHAdjaQaoITZsbGgKeWnyg5af8fHnl1PbKY/U+HrLCbfdJpNP49HFtopHU7tFNY/JMdz098j7chD4Wk2sGcTYygLYzvh30biXH2QzpTS8Jkb6DiKMzmj7UMEKSy+nS4FdTTB6LoGoOJlXgoc07//Nbmi3OSZHcrH4/XEk+EL8P+XiYZd+4fxZb7CCqw9JYCJGijuUTABfiSxfn7tEyKa30TWhelG+6xQ4oNBbhkycPExPfdZNnEQ==
Received: from SJ0PR03CA0227.namprd03.prod.outlook.com (2603:10b6:a03:39f::22)
 by LV5PR12MB9756.namprd12.prod.outlook.com (2603:10b6:408:2fd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 09:38:12 +0000
Received: from MWH0EPF000C6189.namprd02.prod.outlook.com
 (2603:10b6:a03:39f:cafe::a5) by SJ0PR03CA0227.outlook.office365.com
 (2603:10b6:a03:39f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 09:38:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6189.mail.protection.outlook.com (10.167.249.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 09:38:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 02:37:49 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 02:37:40 -0700
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
Subject: [PATCH v4 04/27] cxl: Establish media readiness in cxl_mem_probe()
Date: Thu, 13 Aug 2026 15:06:08 +0530
Message-ID: <20260813093631.2288172-5-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260813093631.2288172-1-mhonap@nvidia.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6189:EE_|LV5PR12MB9756:EE_
X-MS-Office365-Filtering-Correlation-Id: eab40067-218b-4b3d-352b-08def91e9738
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|23010399003|1800799024|82310400026|11063799006|56012099006|10067099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	L0ThvdiOz+XKMwpNV8qzwulR1vfOXL2YjzVGcQHLT70pQdn0seJRuek5CsAbcugWwdwDtwyE9sf78op0NZTzqt8lA2vxTxhVVSORMEtnxutLlmzFDBVFOh8005MWig8k1NLsNFljZh1BPScbVHLdgS35IrlStQGW07epdWkE0SBjfixm2R2IZrQCQTcQgmGTbLb0Af7nVYWi3LeU83MVldkfTeYtSgP0s0HLETvSwMjZtp7xZ520O/Axj62vtIyxpb+kIRib6b5eabjaFO9dPZ4eEML2xvIvbcUMHJa8oZWuQsCBbmXTKnXsn3azh2/CLolIDNsPHqnc1eNK3+DFt6q072QGxV8nJlYhqVZ4nj2ayObOWJ/TUDjIFkjmwMvBNssRIcU5NQGBqmOpS+Ie2lluZspqwa6iV5wjO3q2k2spcqjjKcrf688jdZYvPPzoYLmMbudnEFeNDxqmkYT2WXwOLbhatgvLRybjiYcbdSmeOnhhoG24QBLZrGdLnkyrCHfyNlR3JjgXvf4irA/LFudiEem7LVMHIwAvpraCzbCTUAMqYGuVuCIqR6xQgbriKZA2v2nHNQDA95CHJ+rzdmRZIKoq32bHtu7iJYQjbwVgLbWquPL62+RQX4vA8e2ugIZevG5PKc8D+vZMHxuDsM6IUqSBLdXDgk2f0clxAadm2p5Vuq2nN9zfjvV3gz2aryC0lXGjhjiOFYLCTjczS2aIXtYfid6j1aeTn6gLQ2n+b7x4r8N3AaW5rk/TR7pK
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(23010399003)(1800799024)(82310400026)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qjuS1r98nmEKcnTCT08ItjtT8Q9fnwKchzd9kXo7SRFOjSDwCaa0NL0MydiypVz8eJRGOzgDFoi+4laFFK0jbE8I5SAdhTZ/8009F/I4BO7V7JZnl+GyXJn/ihVkjn8KdGo34ptVeGnVHfvYO6uS90kzn7sS97MLR1Nm3Dvne0vcqDUSvN/hH14yn0v+mEZCT5zN6cjuchT9G9KS0V5FYD3JwGx3yGHzh1IXwUu1MscsrUTwDd7oRXtdFtp/I6A5t/Uh/j05A90YHmzVjlePcvnhUNHgtiaQRE4zOnQA0H+Picwxg9804i2nXcnAQ4CPjbBfKLi5doLVClgwKuVgzvgssYEqfXOMmUJq4br9UglJ2jtLyMl/Osz982VcKzsOR22gZH8t+46ITG6uARMmbM0lHMRzQ6Dww11JC2vJhxck895oGRm8lxYpejdluNSA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 09:38:11.3006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eab40067-218b-4b3d-352b-08def91e9738
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6189.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9756

From: Manish Honap <mhonap@nvidia.com>

media_ready was only ever set by cxl_pci, in advance of registering a
memdev and with CXL Memory Device register assumptions. A consumer that
creates a memdev without cxl_pci, such as a mailbox-less Type-2
accelerator brought up through devm_cxl_probe_mem(), therefore handed
cxl_mem a device with media_ready still false, and cxl_mem_probe()
rejected it with -EBUSY. __devm_cxl_add_memdev() turns that into -ENXIO
back to the caller and the bind fails.

Move the readiness wait into cxl_mem_probe() so every memdev consumer
gets a ready resource regardless of how the memdev was created. When
media_ready is not already set, wait on the device's DVSEC
Mem_Info_Valid and Mem_Active bits and mark it ready. cxl_pci keeps
setting media_ready before it registers its memdev, so that path skips
the wait.

The CXL Memory Device register group is optional and many Type-2 devices
do not implement it, so cxl_await_media_ready() must not read the Memdev
Status register unless the group is mapped. Reading regs.memdev on a
device that lacks it would fault. Gate that read on regs.memdev; the
DVSEC bits already prove readiness for such devices.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/cxl/core/pci.c | 15 +++++++++++----
 drivers/cxl/mem.c      |  9 +++++++--
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 08d4c955137d..9b372d5a1aa4 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -151,7 +151,6 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
 	int d = cxlds->cxl_dvsec;
 	int rc, i, hdm_count;
-	u64 md_status;
 	u16 cap;
 
 	rc = pci_read_config_word(pdev,
@@ -172,9 +171,17 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
 			return rc;
 	}
 
-	md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
-	if (!CXLMDEV_READY(md_status))
-		return -EIO;
+	/*
+	 * It is possible some Type-2 devices (CXL_DEVTYPE_DEVMEM) do not
+	 * implement regs.memdev; only consult the Memdev Status register when
+	 * the group is actually present.
+	 */
+	if (cxlds->regs.memdev) {
+		u64 md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
+
+		if (!CXLMDEV_READY(md_status))
+			return -EIO;
+	}
 
 	return 0;
 }
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 798e5c369cfc..9c6e99b9124c 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -105,8 +105,13 @@ static int cxl_mem_probe(struct device *dev)
 	struct dentry *dentry;
 	int rc;
 
-	if (!cxlds->media_ready)
-		return -EBUSY;
+	if (!cxlds->media_ready) {
+		rc = cxl_await_media_ready(cxlds);
+		if (rc)
+			return rc;
+		cxlds->media_ready = true;
+		dev_dbg(dev, "CXL media ready\n");
+	}
 
 	/*
 	 * Someone is trying to reattach this device after it lost its port
-- 
2.25.1

