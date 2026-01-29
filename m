Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A6B37BE9A;
	Thu, 29 Jan 2026 09:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769678294; cv=fail; b=bShcNuRd27Rv3nwiwMo+mtA6N6repctaPepyjLIK0cj+/1C4G4Wm1S3f4VTGyDsZ2gUUlAGHTU2YHlvFSiLgL4cvqA8SD9deUmLuAcg6ABqXzY4d/RPyZSglmgMG9k1r/OUtHRhAyt2J8D1gBPkZa5kBHh+Gw8Z30pUvkyDm15Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769678294; c=relaxed/simple;
	bh=UBwcCOjc+SNOTX8DCl2J9snpgzMBpHWpo7n68mhs1r0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JXXZD5Qax4CI8VbVWuFixNbuD3u37fr79QHNnkOe3ihWcbFTCPiiOpfUucKXlm+XHnde5F1w3ZVOvXgxDHzcKoFT3N8UmL+WM39Bqq4o8veIZWURQjcDc8K327jMNcCS8CZCsx7jhoTC07HVvdCOCUt8ICjD0kzBGab3qCjxd/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KVQCYtLs; arc=fail smtp.client-ip=52.101.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KVQCYtLs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQcr/LfBWQTDVs4q+lVRDfLwdprgPEFGIm0oggAWLOib9rTiiW7yBOezI1aIyCo7tHxojOLAaAWbLFM+PW2Vowc64XlWbBs80M3dGQT9pnIcI9TGVH3l4ze+yo+WS75BghOFWzd1DblEGhG/X3NgroZjxFZQ16ewS9pDlNqfr/fqZW3N53kgz996DanpKInz2A8dBWfwpYA6s9lINuAwddLxJee3ez12u7Hw5LAXQYMxbDnWF/f8cWn6bmOo+f6Wc9k3pa/df4OSrU0Hr/9yq8+74CcI0NQIw4r1TflkBcvj9J/ThI+FA9BDv3ztTOqNh/9kELSOqZVL6qfWfB0DQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqvMca+e7uoz7w4JHuiMzEDB8GFXPvj5yibfnAkep4M=;
 b=y9gmlYb6IkzUgh3LVbQsqcV5+opQSNBfTpv/JKC1mSwbctWXQlpBtTvP1EQn7Xhs92QrWSh6aOFTkKEGP7N1XYpJwous90bN+P8+a0jVDwK1xNYU8FKCNXPoXPQyVAABE6RQrNsinEGY2/S4853RrVOAHC2H5EfWkc2dFrnz0GAvdi90MlKy7FGmuIeyc0rC7tXC/9rO7xJp+oR4cII7sEFDXT4YEzABnCHEJ4QVRZsGbN89w410AzuPYi0MWt8X8Px7GIZRQF/FpZplPiHxN7yIE9PHPzPwH73Q1ragwoAgxUbtwLO7MOa2UrgmgDNMIZCY+oF3ki5hmq2aWHgA8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqvMca+e7uoz7w4JHuiMzEDB8GFXPvj5yibfnAkep4M=;
 b=KVQCYtLs6+OKhBvRo2vbB93BjJktPe98tAiiyAOJi/xdIzJgYkxEa4Fism/+T91J92ihhgnbIdDv8hmfWB56HDdkOhiLqf3tOQtgX4E1yb7aCYZ5nE+ozy2IDRlksv8doZTQviNVrS+2eisUu1WsPkEw5KLRsp1zuJLoIi6Cbso=
Received: from BN9PR03CA0866.namprd03.prod.outlook.com (2603:10b6:408:13d::31)
 by CH0PR10MB5068.namprd10.prod.outlook.com (2603:10b6:610:c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Thu, 29 Jan
 2026 09:18:09 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:408:13d:cafe::6c) by BN9PR03CA0866.outlook.office365.com
 (2603:10b6:408:13d::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Thu,
 29 Jan 2026 09:18:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Thu, 29 Jan 2026 09:18:07 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 29 Jan
 2026 03:18:00 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 29 Jan
 2026 03:18:00 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 29 Jan 2026 03:17:59 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60T9Htkn3499594;
	Thu, 29 Jan 2026 03:17:56 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <cassel@kernel.org>, <Zhiqiang.Hou@nxp.com>,
	<gustavo.pimentel@synopsys.com>
CC: <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>, Aksh Garg <a-garg7@ti.com>
Subject: [PATCH v4 0/3] PCI: dwc: ep: Enhance multi-function endpoint support
Date: Thu, 29 Jan 2026 14:47:50 +0530
Message-ID: <20260129091753.490167-1-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|CH0PR10MB5068:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c074040-65ea-484e-3039-08de5f1750df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DKNmRTnEU7ZQCFpsaCUPaMESqV1ai5jIC8y+D5ZKKKL45I6ZZacP/MwQLgAV?=
 =?us-ascii?Q?96LBqNYbaBn0E8Cnw7nq4hXNosXj4b7SlDl9OqoRH4bkhE/SXzjzlCbYeknW?=
 =?us-ascii?Q?mL7VGdlh1OIjb47XadHIt4slQ5LLJ0VwNJ8jTfwHWAZEdu8ec3ZLsUYmiW7R?=
 =?us-ascii?Q?zGZ4giMj/EFW2K89v72y49MB+9xjkXkjULl41D1cEgJJixEEppW0I4q/OdEE?=
 =?us-ascii?Q?WAcCYkjv4DyFIexiSZTcp0tVNLAyzbCgfLi+qihcyMP4Ob3LvfaGGaDF+/BM?=
 =?us-ascii?Q?21tIN9OWhX4vidmjc4X6NDbEaKGVpTIxt90rtguXkmmJ72WsAhzn1+b9NThQ?=
 =?us-ascii?Q?PCsu1WE58RV63isydVCAGDP4UC91iQPE2yXtcbenfOhf+hVVOVwlsfwXmYaw?=
 =?us-ascii?Q?PTPD2P5OSd7GKI1kkbxsUliYIAVyvsCnnN7zpAFf1dtFkKLhUnG7CDlBK1it?=
 =?us-ascii?Q?Szavw5xRuKLQAQoD0MYZCnfB6sVh55dvHEXgHL+Vq5RPxepAjAMwMV26t8c1?=
 =?us-ascii?Q?JTK2I861GT3zO32pu2hHB8UQLHtN7i4zxPdaHuzqmsSjbycmHHKIwSWTTEPg?=
 =?us-ascii?Q?apB+rsFMaNzuREuudTqJunP7AV1mhhP59ecKwQf4Z1z7H3qpEU1kiOyreHi8?=
 =?us-ascii?Q?A1ADa5NN7CNZE/cL8YI67nJfXnpEHyVNn44AGrE3EVwI8Wk7YGlMm8evluis?=
 =?us-ascii?Q?KTmNGrocGnhGr2+JU3lfF2HP3Gh266WXIaUBG8fTebVhoOIyq6syrSBnRapq?=
 =?us-ascii?Q?pCQcqx5LhdGvVP4P0TxZGmtCT+Uot9zUVji4uW6yFXQYm6xi2SnnKHcE2qe9?=
 =?us-ascii?Q?YdujugAoUd0tAGfXIgNozsOxZmRFz3jfy7VG+6+j6oE+YtyVONPyFUApvXgi?=
 =?us-ascii?Q?FblZ8/FqkAjIEp5aNByGdaQe1oGZkNTQooel4wv98Xtit5/U+5I1chiPOuN1?=
 =?us-ascii?Q?FM+eyjQFztzWvXwpkortVUDwYryjW0i7zNLR0OGInXKy2wd/T95+ByMv/9Dd?=
 =?us-ascii?Q?ESboAuGl3Kx8L/3DVBKRokEBJHpJeuE3oFlUSemCWhpsM3B1OSwTQKnBnLfX?=
 =?us-ascii?Q?iwNzQcNcM51TVhCo0lsdzjifs2ZDbqh/PGYaZaIzYiDkit+eGUVfGLklTRen?=
 =?us-ascii?Q?ejJe6fXlGw5GYzrQ1x6mQuxkWccf2jT4pr4TaIxsONtWFDFvacP/dTw2butL?=
 =?us-ascii?Q?wre25wrm1t2SOw2ykHiM4FDWHIHENfC4J3N2zZTmyfE6eAtwwn2IRxSYn8t5?=
 =?us-ascii?Q?0ZETcivoHK22TYxoVcWDk75Y3gjdXbCo5p6ndJUOzKhCH1/Uw4HIjuhhi5a0?=
 =?us-ascii?Q?x+gS8bk9A/s0jOiQ2D0WrZR+O+JWhuvHmE0PlzAuBqmjcQvRxHTIgvvPUq0/?=
 =?us-ascii?Q?7ySXWf6Eug3nice7pKh6zPQcPPXsYQPPDAJJBrfz5M7+1QuR8akxFwkC/Qif?=
 =?us-ascii?Q?O6PUnV4zzUlaAe5WTvYKLj07sxiG/vgoqlBuNSzBQV3VOMaGVyzeuHwVlMy5?=
 =?us-ascii?Q?4ZD35S87eht9KxNrL4Us8HqHvBjwKvKnxyPi6MhSvg4ZmW91PZbrxfyy9uut?=
 =?us-ascii?Q?GxQ5JaCVL7+6Fp75Rmo3rvy2SJ+6pTBVe+7SKYE6LkYsfTlER4lrKGLwpIC0?=
 =?us-ascii?Q?gxZkR9pxAoZvVyFrfiHa6e7eSoST85UR5qXzX3OqxMigsYUQ4IsWS3I94x/N?=
 =?us-ascii?Q?cO+1ClzejhcE5DSzrV8MdhIsZsA=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 09:18:07.7717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c074040-65ea-484e-3039-08de5f1750df
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5068

This series addresses multi-function endpoint configuration issues in
the DWC PCIe controller driver. The changes enable proper operations
for physical functions and enhance the multi-function endpoint support.

Changes from v3 to v4:
- Rebased the series

Changes from v2 to v3:
- Fixed minor nits in the patch

Changes from v1 to v2:
- Fixed the minor nits in the patches
- Added a new patch in the series to address PTM capability access

v3: https://lore.kernel.org/all/20260127085010.446116-1-a-garg7@ti.com/
v2: https://lore.kernel.org/all/20260122082538.309122-1-a-garg7@ti.com/
v1: https://lore.kernel.org/all/20260121054214.274429-1-a-garg7@ti.com/

Aksh Garg (3):
  PCI: dwc: ep: Fix resizable BAR support for multi-PF configurations
  PCI: dwc: ep: Add per-PF BAR and inbound ATU mapping support
  PCI: dwc: ep: Add comment explaining controller-level PTM access

 .../pci/controller/dwc/pcie-designware-ep.c   | 132 ++++++++++++------
 drivers/pci/controller/dwc/pcie-designware.h  |  12 +-
 2 files changed, 92 insertions(+), 52 deletions(-)

-- 
2.34.1

