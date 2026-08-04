Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013012.outbound.protection.outlook.com [40.93.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39E54A1399;
	Tue,  4 Aug 2026 19:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785871824; cv=fail; b=a4SG09MDDYLk6fdA6MYA74iIZdzDQZCeeJ7myF8WmMgiBqjUDPXx21N0Yu6xvqF+dPSz8iwyQCtNQOXSha6SGsk3kzijrVT21V7kmpDAs9+o3tZ+n/O3B3xHwluzByzVCS7o5wzzi6QhNB1paxFsl53B6r83ufbKQRupp88P5hU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785871824; c=relaxed/simple;
	bh=XCq0rfTr2JvfZKgcoqSEms8PP/5Am5cO3VLkThb2/qE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nGpDwQf5glJjMtNekMMqgUPw3FDnpS1zTQPYubrRoFvsxMvZvVhW0KDPluyxx4pRVnYPdFHNkl/Z81A+zR6BTuNlYnejnnS9b3qvELjXwFXwihLpY5ykiGlgCFDW4BnPFL9gSIIIF8HHc2GFn8wuN9A7wvm/szvv7CIodK0e3qE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hBwxTP3H; arc=fail smtp.client-ip=40.93.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hBwxTP3H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rzxd/dcFCLGmRLcKDB8IbvkAnmvaAVebX/yL0+PlGl6I0/tHecEhnDYO4QdK3c/AbG6WZiG3JFvFmr87WwLWit3rGgf4s1f+YI9fMu7aujUlvKDbCdNzka9SU4Sb7iOkQD3GUZE98eNLwOWzNRoYnItB8ZASbmUq/lq4tw8lYUEDUtmo8yswy9gRwvTHmmHgtK+hIj2dKziFUrEzRRKVSG9MBPivYvooD5ZoaokymhgyAtR/oxw3T7z8nrbIjPRXmk1rBhwByLZtgyBZThJVUf3qCgIdJAu1Td5hDAObGTi8EdbnkMFszzvZkF28sJog2pCoW2H9WjDEOQAnnc2wmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPvCky1dcm8JH3hFkLPwaEsaFrHZyXn0c9amguDwdUM=;
 b=OpfRrKvr5vhNhK9ZYHJ74SQprp8bhq0KcdwKyH1VgV4hqzul1NK+963v+lmYRxXuL4mhULBjex1szCg6sxJmHhVvNu1Oiv6YoMxy0DPRvrNqVcu3yrGoMdhBTOywtZCLiFrslB6Mv9E/0VbWX7Yo/h9+v+RSkuw7kTHAzGmkL6kOTxpc3aDtl3oxVqRhXQdXaUTgz+QGtEAwBnt2AswDYvTtd7zdVseSqcSWeT0V7LOwsXV8hjqL86lBbR/xz6rMd3PnQDKCIvp/ejZzrn0a35v1KjlNb8skJIT6rb6vP7+d43UX5r0UcLBF3x4fZ88/TCMGwwFHWfFwK6yr0Lj5+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPvCky1dcm8JH3hFkLPwaEsaFrHZyXn0c9amguDwdUM=;
 b=hBwxTP3H6pWHD+k4+xkAru8ZHAcnmEHki4w7VZY75jsIO7SluffxtkNm4HC2t1p2bCKMdQzChBc3iFShtGTQjoBSa2nin3l5LJ5Gagn1iKO/5MFVtmqz5VuNrGxu+0Y8+g/lS1Pc2qya9oE4IIGP8lwn/XEIG/JDNawkzqH9++xZu8WiHM6Mhay2gxhFuqyX9D4rAErcx8gg5lApe2eukQxARrXZ1QdyQWAjvch5lJF/TVlGC4yyL6hM7xyjgtNHjzGY31ofwFQvvPDV+p7p1z+5IL+kjZX/wQA7PVco8OxJiFOBX/Spb/FZKMdEAQ30b9IpgoyMuC3sktXgX6s6Mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by SJ0PR12MB6759.namprd12.prod.outlook.com (2603:10b6:a03:44b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 19:30:15 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 19:30:15 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v10 03/12] cxl: Share HDM decoder decode logic
Date: Tue,  4 Aug 2026 19:29:49 +0000
Message-ID: <20260804192958.1823952-4-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804192958.1823952-1-smadhavan@nvidia.com>
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0186.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::11) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|SJ0PR12MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a98fd41-25c1-44fe-1025-08def25ecf19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|56012099006|10067099003|11063799006|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	c/ZCUOP8aSE7ci/AcdgXqBAPuitnM0/QRbJ0+y8wAp73uk//ebax4BJ18W9M+3g5ZULESbD/1UHr0sDERYD+96OfB3TAaO1XXs4j+xWZyDZqGksSgS+Cd1wfsl4TcePBXaxzCMEAtXiCPtEFWggx/q63i2ruuMu2cK24CEkSLvSZw8xeVFgpb0G/6DltIFMIzCFHazONsF+iy0ARgSHRlpKqaUtSwh4QO42E2FXX+AaLeU+bHrsneO2OcoUaIpZDnsIMj/SXzRsnwthFKS2txMZq8qUj3qYuNLR89XzTBnfBEoS7cJ5o8q09nHH3V51a5ubiAE2IXK16d02+NUS5e7vy9f4mwesQoodWUvYnAvhPj02NSclni+VrfNZ0PDXzzUAxqzjy3YydWiJaQcWtkB6P1rmDmGfQh0Sv86rt5giqtJ9liuEKB0kcQ7ASU7RIQnx+DlSXK99z269AbXF7mRrmcWTkhKy7tACcQglFNsn085aqARwQtzPdxHldy6gHUcpb88uhWby+PRMUqlaIuJPHctx0jEX9/7nC3OewLSWtWzrRynlRgUWCuRwVamFbyLVYCw1jxI0dDX7vAQf4lc22s5Jwf5lFGgKwNH+e0ERjehdqb7gRDJE28snBbRCU028QOT5fd7Z3nsUZ2ccfXKwWv3Qy0xN7R86O8EhwD24QUjngTPd1tOQDwrv9nwvhIaUXOGRfuTEN1YALc33AdA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fRPHp740wSx5dNJeyingQ4ekW0y3wF2T0L05e0dt/xCJqwXg8XAiOlQF8lGp?=
 =?us-ascii?Q?bnFKTQglIC7t3ttuknhn91dPI2EleLAmbrtnXeV/sbObMF+JZ0qD90ps7bdB?=
 =?us-ascii?Q?dVegreIS9FNdbjpcFtolXXJiJMQp9Cbuzbkp17Mnjp9UR4BrJ1f8OO2BDy1T?=
 =?us-ascii?Q?vcAU7AWggAzZ/s62c3nQa1EP4ztNl0NHA8KxS1WFZNGr75r4pYUYuEpuuTX6?=
 =?us-ascii?Q?UJKz2hRSkXLIOsgJaE9Gyo8WtLeQ6Lun5gKYGpv6IWGXc4sat4sb9SqE6+37?=
 =?us-ascii?Q?Vw9Bt+GCx1G5YVPwT74Itupw36pX/O4+HAadHW5fKOOqAPgO58MH48VvCiOB?=
 =?us-ascii?Q?dIKZlOPMYEkLU+8+2vOXNemOhMqkBdqAxAMNvZePDAhQ6yIGGWajz269kCte?=
 =?us-ascii?Q?B9E7Wv992G7/8Ysdv+2+d5AjCk3JxFI7w4O+YgrVTYPZyvYAohKIJw2uAezU?=
 =?us-ascii?Q?LpOKx6siu2dl99PRTPXp+eAWvbTh1cUVt7ThE1eVCA4zTdZI+ZFuQyNNjzI1?=
 =?us-ascii?Q?dLnVeARA4flav0VLe4WqvHXbHDDdZN0RQ/IzOkLp75ESOCMyYe05QhEtj/81?=
 =?us-ascii?Q?BWbRvTt/0vpK/Q6z2ZViHvhtEsFkKcs8xH48/airuy9vP7YgU0PYzE1Ly87c?=
 =?us-ascii?Q?PPOta4xonCF3LigoWMHsMBLhiO2r962jEMA42qRJIJy2eX7jHzeh/yGsGRHJ?=
 =?us-ascii?Q?ACfp1xggHHNg+YoPvbFsjMIZnCXLgrLSrbh4bnvvBKToqKolrKkH++jj4ida?=
 =?us-ascii?Q?Olkmq+2j/NUwQOd0Wtd7f8rCFVC0narqeTZa5eevw6vdcpl15Q0WE4C9B4vC?=
 =?us-ascii?Q?CnVLA4vwmsauOKAw98zSt0sElFSz3Wfhjh7miFTMMGIjN3JjxN2H0F9y7b9P?=
 =?us-ascii?Q?Oeu/hTvObdhlQkzFHuWXmjYIYZF3019IUW6x0Jg/wQ/G4g718BfiKqi6u8Cc?=
 =?us-ascii?Q?94a9xQ06ciAWr1y/IucmT01CmA2x3YXbxKcUzK5f2AJy0MrpTD7B/VDbvP7p?=
 =?us-ascii?Q?7DfCny+ORWLloSeZ8gCBMDZD/nHYMbXtFjsAgaMlliHWYfWDGhftVOmMkPfI?=
 =?us-ascii?Q?IiU8wBqoLOx82a5UYhjRdUw2GlmsWcj6YdcK2A42NkD6zrsV1bLkUh2co27h?=
 =?us-ascii?Q?iwww1IKmWuAXkA8N7wVjGk6Ds0EsqOkXISO3rL/8YdTJqHG5SLYbu5tulQ5T?=
 =?us-ascii?Q?ChCbl7YFptShpIhV2juYX7yfuWUMDvtt+XKNTCb18tOAinTVubtQckoonLZv?=
 =?us-ascii?Q?/UJO+iazfzPplP/fjzx+mmUPyIPZRVOdmiITLajDAsYpxy7NR9wlnlSCBx/p?=
 =?us-ascii?Q?LI2diMoP8yu4zAvqLVvh0SzNH5f8O4sYMF0eWSS4dZN/zD0wybWcpiyopil7?=
 =?us-ascii?Q?KrcHPOSTE0DkoAVJ8/ULrk0vcPeKf9w8OFXfN9YF66oyJbary0jZwJhKVsvC?=
 =?us-ascii?Q?GW8s8dbanvrTug7ZRmlDHM1EAI4IN3rRlPZQZA3GTKwBBz1UJo7a9Dcu9Vub?=
 =?us-ascii?Q?ubYvjui/lwJEao3RoxdX/BSTZ61aRX67QLdteg+oQS/gW2pCE+s6VqLWYyIF?=
 =?us-ascii?Q?/hyl7tRQXP6eiJu6YecAaCPoAS4PWy6misHG7aWEoB6LYrBprmozZIAUugED?=
 =?us-ascii?Q?OjNVH54mIWYerv/QNlKORC2m5jSHNlKiFxsZctInkXdMaoTpQdtTF6+VHdeT?=
 =?us-ascii?Q?uJ8+OWyW4uyBRc7iJHOf7SOx6axGWBq399VjCTvoEwlMpSLsx+frezomwkfZ?=
 =?us-ascii?Q?VmzzV0O2KQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a98fd41-25c1-44fe-1025-08def25ecf19
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 19:30:15.0286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mP0FXZ5Y2fakRs3sKAmiwefTA6eg5vCzmApK33EvXBlRjVPzg4TieOL9wWHGuHfjMThFm4btZLWowinggC3IHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6759

Add a helper to resolve a CXL port upstream PCI device for paths
that need to associate CXL core state with the parent PCI function.

Move HDM decoder register decoding into a helper shared by normal CXL
core enumeration and early PCI HDM cache setup. This keeps validation of
base, size, interleave, target type, and enable state in one place before
adding another HDM parser.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/core.h     |  4 ++
 drivers/cxl/core/hdm.c      | 76 +++++++++++++------------------------
 drivers/cxl/core/port.c     | 19 ++++++++++
 drivers/cxl/core/resource.c | 45 ++++++++++++++++++++++
 4 files changed, 94 insertions(+), 50 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 1426254e6657..9c54985fd4f3 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -155,6 +155,7 @@ long cxl_pci_get_latency(struct pci_dev *pdev);
 int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
 int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 					struct access_coordinate *c);
+struct pci_dev *cxl_port_get_uport_pci_dev(struct cxl_port *port);
 
 static inline struct device *port_to_host(struct cxl_port *port)
 {
@@ -216,6 +217,9 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 			struct cxl_endpoint_dvsec_info *info);
 int cxl_commit_start(struct cxl_decoder_settings *settings, void __iomem *hdm);
 int cxl_commit_wait(struct cxl_decoder_settings *settings, void __iomem *hdm);
+int cxl_hdm_decode_decoder(struct cxl_decoder_settings *settings, int id,
+			   u32 ctrl, u64 base, u64 size, u64 target_or_skip,
+			   bool *committed);
 int cxl_port_get_possible_dports(struct cxl_port *port);
 
 #ifdef CONFIG_CXL_FEATURES
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 9047b190c35a..6e132b4f092b 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -899,11 +899,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	bool committed;
 	u32 remainder;
 	int i, rc;
-	u32 ctrl;
-	union {
-		u64 value;
-		unsigned char target_id[8];
-	} target_list;
+	u32 ctrl, tl_low, tl_high;
+	struct cxl_decoder_settings settings;
 
 	if (should_emulate_decoders(info))
 		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, dpa_base,
@@ -916,35 +913,31 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	lo = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
 	hi = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(which));
 	size = (hi << 32) + lo;
-	committed = !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
+	tl_low = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
+	tl_high = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
+	rc = cxl_hdm_decode_decoder(&settings, which, ctrl, base, size,
+				    ((u64)tl_high << 32) | tl_low, &committed);
+	if (rc) {
+		dev_warn(&port->dev,
+			 "decoder%d.%d: Invalid decoder configuration (ctrl: %#x): %d\n",
+			 port->id, cxld->id, ctrl, rc);
+		return rc;
+	}
+
 	cxld->commit = cxl_decoder_commit;
 	cxld->reset = cxl_decoder_reset;
-
-	if (!committed)
-		size = 0;
-	if (base == U64_MAX || size == U64_MAX) {
-		dev_warn(&port->dev, "decoder%d.%d: Invalid resource range\n",
-			 port->id, cxld->id);
-		return -ENXIO;
-	}
+	cxld->hpa_range = settings.hpa_range;
+	cxld->interleave_ways = settings.interleave_ways;
+	cxld->interleave_granularity = settings.interleave_granularity;
+	cxld->target_type = settings.target_type;
+	cxld->flags = settings.flags;
+	size = range_len(&cxld->hpa_range);
 
 	if (info)
 		cxled = to_cxl_endpoint_decoder(&cxld->dev);
-	cxld->hpa_range = (struct range) {
-		.start = base,
-		.end = base + size - 1,
-	};
 
 	/* decoders are enabled if committed */
 	if (committed) {
-		cxld->flags |= CXL_DECODER_F_ENABLE;
-		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
-			cxld->flags |= CXL_DECODER_F_LOCK;
-		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
-			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
-		else
-			cxld->target_type = CXL_DECODER_DEVMEM;
-
 		guard(rwsem_write)(&cxl_rwsem.region);
 		if (cxld->id != cxl_num_decoders_committed(port)) {
 			dev_warn(&port->dev,
@@ -984,33 +977,17 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
 		}
 	}
-	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
-			  &cxld->interleave_ways);
-	if (rc) {
-		dev_warn(&port->dev,
-			 "decoder%d.%d: Invalid interleave ways (ctrl: %#x)\n",
-			 port->id, cxld->id, ctrl);
-		return rc;
-	}
-	rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
-				 &cxld->interleave_granularity);
-	if (rc) {
-		dev_warn(&port->dev,
-			 "decoder%d.%d: Invalid interleave granularity (ctrl: %#x)\n",
-			 port->id, cxld->id, ctrl);
-		return rc;
-	}
-
 	dev_dbg(&port->dev, "decoder%d.%d: range: %#llx-%#llx iw: %d ig: %d\n",
 		port->id, cxld->id, cxld->hpa_range.start, cxld->hpa_range.end,
 		cxld->interleave_ways, cxld->interleave_granularity);
 
 	if (!cxled) {
-		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
-		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
-		target_list.value = (hi << 32) + lo;
+		if (cxld->interleave_ways > 8)
+			return -ENXIO;
 		for (i = 0; i < cxld->interleave_ways; i++)
-			cxld->target_map[i] = target_list.target_id[i];
+			cxld->target_map[i] = i < 4 ?
+				(tl_low >> (i * 8)) & 0xff :
+				(tl_high >> ((i - 4) * 8)) & 0xff;
 
 		return 0;
 	}
@@ -1018,6 +995,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	if (!committed)
 		return 0;
 
+	cxled->skip = settings.target_or_skip;
 	dpa_size = div_u64_rem(size, cxld->interleave_ways, &remainder);
 	if (remainder) {
 		dev_err(&port->dev,
@@ -1025,9 +1003,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			port->id, cxld->id, size, cxld->interleave_ways);
 		return -ENXIO;
 	}
-	lo = readl(hdm + CXL_HDM_DECODER0_SKIP_LOW(which));
-	hi = readl(hdm + CXL_HDM_DECODER0_SKIP_HIGH(which));
-	skip = (hi << 32) + lo;
+	skip = cxled->skip;
 	rc = devm_cxl_dpa_reserve(cxled, *dpa_base + skip, dpa_size, skip);
 	if (rc) {
 		dev_err(&port->dev,
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1215ee4f4035..b8bb6ac19cac 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -33,6 +33,25 @@
 static DEFINE_IDA(cxl_port_ida);
 static DEFINE_XARRAY(cxl_root_buses);
 
+struct pci_dev *cxl_port_get_uport_pci_dev(struct cxl_port *port)
+{
+	struct device *uport = port->uport_dev;
+	struct device *host;
+
+	if (is_cxl_memdev(uport)) {
+		struct cxl_memdev *cxlmd = to_cxl_memdev(uport);
+
+		host = cxlmd->dev.parent;
+	} else {
+		host = uport;
+	}
+
+	if (!host || !dev_is_pci(host))
+		return NULL;
+
+	return pci_dev_get(to_pci_dev(host));
+}
+
 /*
  * The terminal device in PCI is NULL and @platform_bus
  * for platform devices (for cxl_test)
diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index dd5e0cc82da4..97cb136cb2ae 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -125,3 +125,48 @@ int cxl_commit_wait(struct cxl_decoder_settings *settings, void __iomem *hdm)
 	return 0;
 }
 EXPORT_SYMBOL_FOR_MODULES(cxl_commit_wait, "cxl_core");
+
+int cxl_hdm_decode_decoder(struct cxl_decoder_settings *settings, int id,
+			   u32 ctrl, u64 base, u64 size, u64 target_or_skip,
+			   bool *committed)
+{
+	bool enabled = FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl);
+	int rc;
+
+	*settings = (struct cxl_decoder_settings) {
+		.id = id,
+		.target_or_skip = target_or_skip,
+		.target_type = FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl) ?
+			       CXL_DECODER_HOSTONLYMEM : CXL_DECODER_DEVMEM,
+	};
+
+	if (committed)
+		*committed = enabled;
+	if (!enabled)
+		size = 0;
+	if (base == U64_MAX || size == U64_MAX ||
+	    (size && base > U64_MAX - (size - 1)))
+		return -ENXIO;
+	if (enabled && !size)
+		return -ENXIO;
+
+	settings->hpa_range = (struct range) {
+		.start = base,
+		.end = base + size - 1,
+	};
+	if (enabled) {
+		settings->flags = CXL_DECODER_F_ENABLE;
+		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
+			settings->flags |= CXL_DECODER_F_LOCK;
+	}
+
+	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
+			 &settings->interleave_ways);
+	if (rc)
+		return rc;
+
+	return eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK,
+				    ctrl),
+				  &settings->interleave_granularity);
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_decode_decoder, "cxl_core");
-- 
2.43.0

