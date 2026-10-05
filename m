Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012033.outbound.protection.outlook.com [52.101.48.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6336713C9C4;
	Mon,  5 Oct 2026 07:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791183826; cv=fail; b=VfJzMY5ps8lnIOIRW29rqfqiHuS7rQ8joIRFGJpHhWNpzyAPzlMIBhvbSbdO264D9SDP/MBcDbwy+/1Yy4bdUtGrHWFKmtKOjpyS2TR65SqAa+/QOGuKy8NEHOBN+oB93WyG9uP9UmOboLxDp/6ueMpbuwv+VpJ1hfFMPEfaKco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791183826; c=relaxed/simple;
	bh=1GA1cKVoKBtSgg/JDosdEmy520z8RVIwdwFi46kEQAM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m1L5xLDpScPdCy5Y4iDXX67oLnzRbl5GlVfU2NePk+aRyQ2yKYFIW0tlMiLlde0O+QjDBordYMp7NnEh8aqS+vqj0gvMpbDqmfY1fnGTDjr1qbiQWfGAIq3ITQIL4x4NPrqfnMf6eWsXFNyG3nsHFp9HT8izPLy/WSIoLFI7EYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tx9DKChu; arc=fail smtp.client-ip=52.101.48.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tx9DKChu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVrsT1kHlE7NF+c5sDsChhRW4eMdUx6mTccnntbZ+nhik8VzLed8HQtWqP7IsUK8+VddrNlX/wFSR+GjdIvpQVYTYKd1Fip7tKZIpyFd+G7ghLOCiB+T5fAyj2/dBHYg3qaXd5j9cjKtA5vvkBeBJDWSCI0hSSolFdSjMlcz+HzA4mX+0rIO00MqJszNw6e++klG4IZtnMAFngtZh50jFMi08mRjA4B05WDC9TSJqbM4qSHB9e4qSeCidOYGvi+yBTo8J5jck7AT3oh4a+TtTCCFc7QD5X9HPuOJWlQKj1jUTxcBMzJF5ANP4V+Q6HsWKpfYbGmmWYvkToySIbSHHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtGsdQ+4+4gHqELTAe4lbfRzeGj1j1eDyJW9sMsUUoE=;
 b=EyPXz0NhdJPhxeeR+XUCpEhl4t/y05N5U2CoQslJdzGJfaj5SqImv3vgNQfeY3NtQ03ZBWv+9zqdm8ViUpjAiGc712f5d91UHneHwDamop+LfOQhFGsqcn92MVgHpHIj0Rv6IHMYk+iodDf+AnzmG+Fhnh/e2wzmmZGJzye4y2PZaPaWQJNLM0APF74M+qRvKVhHxsYZe3YAfS5lfaSOk4nRIrZtA4XimNQV7csctqiRzH+OBxXTxQ8oLFIJLaE30244L6XzBe17DXRB4V9IEkKD02WoaA6s+8MR3w1QppNc6r8GhQ4qHL0ypLXE3YDgiyv8uZqgHVop3e373ymRZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtGsdQ+4+4gHqELTAe4lbfRzeGj1j1eDyJW9sMsUUoE=;
 b=tx9DKChu/mRNDvsXj4XAqLiCNjTmOwyB0/q8XT0mJQpr3tVa4xZRHuhrrow9sxuySjHg/Ux0sbzYg4h0Bd6EiBbezRILU7RCgiqxO7DO2nPddwn0Ww6TAHPGXH0GjmL50nguiOqlIAC2zaHlIv/FpCv6dcrwOmVfEPTm4rDiimKVnSAs/HoDIkmgEupAPRxcMtj+TAjFplrJ6b8uQ4FIJspBwwxnkawNVZKV/5OKPTA8hTQ7HWOtS1JNbF972xPF6uWZ2cr86bTtINMw7lSrnDgrwVqWg3qmJoHiLw8cx/EiMZJPi+k5EKEOJkfyQ6hZH7V/gzOPWDDfK3EZa2KcWw==
Received: from BN9PR03CA0069.namprd03.prod.outlook.com (2603:10b6:408:fc::14)
 by LV2PR12MB6015.namprd12.prod.outlook.com (2603:10b6:408:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 07:03:38 +0000
Received: from LV8PEPF00000065.namprd03.prod.outlook.com
 (2603:10b6:408:fc:cafe::11) by BN9PR03CA0069.outlook.office365.com
 (2603:10b6:408:fc::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 07:03:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 LV8PEPF00000065.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 07:03:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 00:03:16 -0700
Received: from NV-9TMPJL3.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 00:03:10 -0700
From: Ankit Agrawal <ankita@nvidia.com>
To: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>, <jgg@nvidia.com>,
	<aneesh.kumar@kernel.org>, <aik@amd.com>, <yilun.xu@linux.intel.com>,
	<iweiny@kernel.org>, <ming.li@zohomail.com>, <icheng@nvidia.com>,
	<bhelgaas@google.com>, <smadhavan@nvidia.com>, <ankita@nvidia.com>,
	<ilpo.jarvinen@linux.intel.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-coco@lists.linux.dev>
Subject: [RFC PATCH 2/4] PCI/CXL: Populate and insert/remove pdev->coh_resource[]
Date: Mon, 5 Oct 2026 09:02:50 +0200
Message-ID: <20261005070252.84810-3-ankita@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005070252.84810-1-ankita@nvidia.com>
References: <20261005070252.84810-1-ankita@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: LV8PEPF00000065:EE_|LV2PR12MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: 415c8364-ca2b-4b4b-fe1e-08df22aec7ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|376014|7416014|82310400026|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	y+laQw0kZQcDR1XvJ7bFf6fVsVe2PfARtr5qF90lj4zMUw9nshQBe8mBxbhZFiacFpVj2E/0FQLPqvzseeOOKMjnZPEDlfz8bi3XVO8RTL+sdXLNlj8cbN0VWwtzcrkyG2fHmK7MIlEenkkU6Hnupw2cm2EhFLyafSnanvbpRYHkzeeNOpNMHDjh/CDmxfBlxDgH36dEGsBw2AvSioclAuvx1Uixf9Bx633c5D0Ipaa+Si/t66BISGdLsCkMO7k2bVq9T5maV0vbAhhOHso14NbRNgubv8jQMuJ8XM8x7o9lUql/GetHvoBtsyTZosHUAT2NwPWM3Y1KYR82EjXwWzUyV4sdhAObu/BUa2ArKaIq+Z/AasEwpuAv3I1W+JPpTp8lQBZsQFvh4oD36HBNXuOaKQJDkmLwdvkcVmxSvCfTyR5uxfIsK1XbdihekCWBH30ZC6o7lWwD6Xh4LYlAsCRAFgnBTPXJ3/knkWc4REzo3qr9GdwR+1Y9iLjCRpA7GDDKH4gOl+4IvjXzTbqBUBLfa5HZHTxUmgpCZ/C2SeIWLC40VI6JZ8MatvYfvgSBwuo6H0SDK9++tOi3mki6U5Ro6GlLfpKByrrpOdhF6UefvoIHdoafBBMD1ef0vRbkwXSfyrZyZOleTe8yAkFv+kbf40Gf/ZmJy4b+iXacQ5B/J5ugweX7ZxNU9PWE3CKcVmAKkctxwgWcxjN0rfyjow==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(7416014)(82310400026)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Qog7I+wzjsTxNApol/m6L4M4JIPJGNfDZvNX+e8IMMJn3T5MswV98VGc8tOCw+P1EGLHBglrc5nOSZPIGZkopctTrpgWuBjXDyocjPBucnqn1Rx+5eubWvL3i2wHRYZUUE+V1bgY74eka1r/a+FhUITrszKFN0SwCM4caY4EP5OeCE33Kj/9nOkMkZJCYw85OpsWvwCrpNQAl2r+OzaDwEUC2VqB4eTa9kFe6VUkEkXsjAeXGofOO2oLuI92ofCRd/BfaRdBLm/Nsr0GTmBc5/YizrD4WTmGEx8No8fK2jt4inI/bHFufq2HCdOo4G+6g5vD2medQf6HWI4/7aaIj2cAeM7NIIIMA1FuYsH9lassBARKqLQKlAaN2ZEjmiosRhLxNGDHWKC+BJlVmnpHMdantnn757Hzcw+B+L7AZqnTbl1R1xWh72lxhem2mFVY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 07:03:38.1664
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 415c8364-ca2b-4b4b-fe1e-08df22aec7ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF00000065.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6015

On systems with precommitted HDM decoders, the firmware programs
the decoders before any software runs. This range also stays constant
over the runs.

Snapshot precommitted CXL HDM decoder ranges into a new
pdev->coh_resource[] array, so later code has a known-good source for
a device coherent (CXL) windows without re-scanning decoder
registers.

Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
Assisted-by: Claude:sonnet-5
---
 drivers/cxl/core/resource.c | 52 ++++++++++++++++++++++++++++++++++++-
 include/linux/pci.h         | 14 ++++++++++
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index 3422139ae3ab..4d2082c8e321 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -404,6 +404,46 @@ static struct cxl_hdm_info *cxl_pci_hdm_read_info(struct pci_dev *pdev,
 	return ERR_PTR(pcibios_err_to_errno(rc));
 }
 
+/*
+ * Snapshot committed decoders into pdev->coh_resource[] which is called
+ * once per pdev before any driver can bind, so a populated entry is
+ * always firmware-committed and not driver-committed.
+ *
+ * Insert each entry into iomem_resource for /proc/iomem visibility and
+ * conflict detection.
+ */
+static void cxl_populate_coh_resource(struct pci_dev *pdev,
+				      struct cxl_hdm_info *info)
+{
+	int count = min(info->decoder_count, PCI_CXL_MAX_COHERENT_RANGES);
+
+	for (int i = 0; i < count; i++) {
+		struct cxl_decoder_config *config = &info->settings[i].config;
+		struct resource *res = &pdev->coh_resource[i];
+		struct resource *conflict;
+
+		if (!(config->flags & CXL_DECODER_F_ENABLE))
+			continue;
+
+		*res = DEFINE_RES_NAMED_DESC(config->hpa_range.start,
+					     range_len(&config->hpa_range),
+					     "CXL coherent memory",
+					     IORESOURCE_MEM, IORES_DESC_NONE);
+
+		conflict = insert_resource_conflict(&iomem_resource, res);
+		if (conflict) {
+			pci_warn(pdev,
+				 "CXL coherent range: decoder%d %pR conflicts with %s %pR, leaving unpopulated\n",
+				 i, res, conflict->name, conflict);
+			memset(res, 0, sizeof(*res));
+			continue;
+		}
+
+		pci_info(pdev, "CXL coherent range: decoder%d precommitted, populated %pR\n",
+			 i, res);
+	}
+}
+
 static int __pci_cxl_hdm_cache_init(struct pci_dev *pdev)
 {
 	struct cxl_register_map map = { };
@@ -442,8 +482,10 @@ static int __pci_cxl_hdm_cache_init(struct pci_dev *pdev)
 	struct cxl_hdm_info *info __free(kfree) = read_info;
 	guard(rwsem_write)(&cxl_rwsem.dpa);
 	/* Another initializer may have published while we read MMIO. */
-	if (!pdev->hdm)
+	if (!pdev->hdm) {
+		cxl_populate_coh_resource(pdev, info);
 		pdev->hdm = no_free_ptr(info);
+	}
 
 	return 0;
 }
@@ -466,6 +508,14 @@ void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
 	info = pdev->hdm;
 	/* Unpublish before freeing so subsequent readers cannot use stale state. */
 	pdev->hdm = NULL;
+
+	for (int i = 0; i < PCI_CXL_MAX_COHERENT_RANGES; i++) {
+		struct resource *res = &pdev->coh_resource[i];
+
+		if (res->parent)
+			remove_resource(res);
+	}
+
 	kfree(info);
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b00f5f38f77d..ce724d067fd2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -148,6 +148,13 @@ enum {
 	DEVICE_COUNT_RESOURCE = PCI_NUM_RESOURCES,
 };
 
+/*
+ * Max CXL HDM decoders tracked per endpoint in pci_dev->coh_resource[].
+ * CXL 3.1 spec section 8.2.4.20.1 - CXL HDM Decoder Capability Register,
+ * mention a max of 10 decoders for a CXL device.
+ */
+#define PCI_CXL_MAX_COHERENT_RANGES 10
+
 /**
  * enum pci_interrupt_pin - PCI INTx interrupt values
  * @PCI_INTERRUPT_UNKNOWN: Unknown or unassigned interrupt
@@ -572,6 +579,13 @@ struct pci_dev {
 #endif
 #ifdef CONFIG_CXL_RESET
 	struct cxl_hdm_info *hdm;	/* CXL HDM decoder state */
+	/*
+	 * Precommitted CXL HDM decoder coherent ranges, snapshotted before
+	 * any driver binds. One entry per decoder index. Only written by
+	 * pci_cxl_hdm_cache_init()/_release(), outside any bound driver's
+	 * read window.
+	 */
+	struct resource coh_resource[PCI_CXL_MAX_COHERENT_RANGES];
 #endif
 #ifdef CONFIG_PCI_NPEM
 	struct npem	*npem;		/* Native PCIe Enclosure Management */
-- 
2.43.0

