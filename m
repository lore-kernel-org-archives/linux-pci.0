Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010003.outbound.protection.outlook.com [52.101.46.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932B12D3A7B;
	Tue, 27 Jan 2026 08:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769503880; cv=fail; b=nPBhklntmLhFpeT5YhPZS3/NNslIYhWbTdKCzkZBJtohfp66IWQuvmAjY2w04NMyoEpVkuw5IW5MG6zwvl4nV0/DMSnqZT47XRFdtEi6IHLhWUUmlNw/Ej7Sq0yNapH/ROg69CHhclgYKeCrsUbm8z2SECOhZ5BhbuKtQp+kpKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769503880; c=relaxed/simple;
	bh=sXvcHHkfAJwjTAZdSxfopnXTOsmyrmyhn4qBWKQuUlo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Go/lhvuxN5LYNRSWZjZCoewgUpvQ2f1HZJ3KPrNhE9saXtx3a0JDqqUFwSedqEhFiiUy53f6bfvF40QyDzA/NUn1b/XmQnpzgW4gx1pInOgZt9ovWqLFNv7Gl+GAmz4SD48ePZQ3qsNYggknzXSoPltN/mFjUxBwnL5c+Y1Dbmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pTyTNT4S; arc=fail smtp.client-ip=52.101.46.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pTyTNT4S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJUix7LPH7dbWHWKmUGyvzXnE5r7nQ/gYSHhDcFlokSbdUFTwVnQqdaUW5XDLoEYwwEwuMPUDjq9LnZcVSo+KflIf5LjqCb37cbn1FTaDxLtv/uaMXJTwnpkf5Yv8lTKwXKoNjvhqMZ/VRaPw+4kPOtgnmgkD/oOPY93EKFha+V6NmfbmQSeVCq1I4IVdOORxN3aqcY+jRAiy6icgdZaezCacHYIYM1vESTMKiEdT0toqfGWK/ChM3HyDrGCXC/j6+JsqKOTB8Lc72dxLv91fay3fwMb9t25EUlcB5XKoDGufSqHySL+E2t/Ppyv5A7s/DK+LhzWvxA/9IRUXzBLSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jz8Loymjozg29iPimpcTKXL5h1vdS1HZNUUM129/nfM=;
 b=rlaxZ1s/E4TgE+zoJzUbnhBWF8uIQ8IXsiejWt60ItS+6jyDLwqcaL4mhVISWnu8LK2hwj+NuWNYnV3PoxbBRIRhZY9ighzXg/AmMmLkidhhV4sAp6HfnX3y7FDOaRHg5Zzja5XrxtDB2+AtDeC+/BhYG06/8/6zxi0LtveJNA4YZt5+ESzKCUIUKPbE3NJtiKkqWjMCtip9g4SzpuGLowJ5T+rik4wpxUsCnpJf8nE7jrnjLlOlBH407ZVDO9emv/VGgc4DvtI/aJRafYmOhFFWdemU+A+CLtZSQ5xZw+Lj9EkMdSri0PyEjAkfmTRtcPUFLCDOERb+eaDbP2XOFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jz8Loymjozg29iPimpcTKXL5h1vdS1HZNUUM129/nfM=;
 b=pTyTNT4SJljC6LHs+cO59kpX5lOO+DFq5jm+UYaLlZboFzR2gYWEC5nq+jx91uJNT8+PJsi786Y/lzuwlDiSlUVCHQjs//1Ks69NQssuklfzton9E8ZKoRk5XipsBvXLXRFSqfpJEPz1k1hLnumPKZz7kjGCIe3L+jIX0/r++zQ=
Received: from DS7PR03CA0248.namprd03.prod.outlook.com (2603:10b6:5:3b3::13)
 by SN7PR10MB7031.namprd10.prod.outlook.com (2603:10b6:806:347::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 08:51:16 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::a1) by DS7PR03CA0248.outlook.office365.com
 (2603:10b6:5:3b3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 27 Jan 2026 08:51:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 08:51:15 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:50:52 -0600
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:50:52 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 02:50:52 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60R8ol4c4071462;
	Tue, 27 Jan 2026 02:50:48 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <cassel@kernel.org>, <Zhiqiang.Hou@nxp.com>,
	<xiaowei.bao@nxp.com>, <gustavo.pimentel@synopsys.com>
CC: <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>, Aksh Garg <a-garg7@ti.com>
Subject: [PATCH v3 0/3] PCI: dwc: ep: Enhance multi-function endpoint support
Date: Tue, 27 Jan 2026 14:20:07 +0530
Message-ID: <20260127085010.446116-1-a-garg7@ti.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|SN7PR10MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: 51ed5000-4570-46d4-4266-08de5d813b2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RhhWKPAq5GgFzS9FUvA8JZzsYVMQCkCn+Q/Qbdd2RyUrQzyrl7LKwHm49r8I?=
 =?us-ascii?Q?0jLU4C2wkmyR6FnWQn9oqimbI3c92v0n+1PKTLpWJCMnAGw7PmjYFG0NSnSd?=
 =?us-ascii?Q?IunjP74s8TUzifcflQWmCU0yJ46d9TmmLfz5U8ZGDRa/ReYVpcZpiL3bZ6Xn?=
 =?us-ascii?Q?PEWhoUvBbgbcSg9yCaQHLG5aZM7MvlCxe1GtnXp7ajxMQp9YiYT9gEElcDnR?=
 =?us-ascii?Q?Qn+xamikaGUQ/bYhBl2GOd6KWTy4h34VVWRir+AO15d70IFVDiEovZqpRrHY?=
 =?us-ascii?Q?HjqlfSK0pe+O1sbb40xKsW69536S0qoJwI7OlFhluSyyR7JHzTEaOPlZuraQ?=
 =?us-ascii?Q?w5Os2yzVnukEu2RlLCg8zKueSUsI/e8/sUYLxbpd70qSUNQzRNU/vYm54/0B?=
 =?us-ascii?Q?6nItZYjDnGHalmDzggs41zIFbvjaRqG5G2aC/Ts1PBuWlrmEh9t2VPvmgXwi?=
 =?us-ascii?Q?husmRtAdV/2lZgIZD0nAyb3S6+3o25zGqwoxcaM/VN9wg63k6xZRArzobP1E?=
 =?us-ascii?Q?pZNtQPTIPdH51HFxhAQVI9/R/Nk/0YTctKS77C8cnlbvvmlKPX8kPHFSGMct?=
 =?us-ascii?Q?BPM8q5Smhl58KJwsKYZbHxI0RWerVTy9e8bIuIMqPWHp8cwrI3oKnMD/LKVT?=
 =?us-ascii?Q?H2zxPvjfGx2AZnzWwpQFriYk3N079mRqzXR/Dy5l8P1uxh/drR5x6ynNDQqs?=
 =?us-ascii?Q?5v7wZhttGnad/AB46Kif9hCY0VnK/vkNYtQ7iXg85YwGvoEBwDmqrmqPQhQb?=
 =?us-ascii?Q?YXJbVrIMHN8+SvzRo8b+lBg9QEEUYo6pdWz+53eVuY4A88a0IShWGdbHLtLN?=
 =?us-ascii?Q?Xh4KKdXBXNvyCkbLf04t651TstesIzcZXUA1K1dIJl6tKUNq+G3u2fmN1VyC?=
 =?us-ascii?Q?43Rl4YKF7MCsOXIu3J2V31qmiJVDEDXTYN+4nxhq/unRSznexcOho5vaST9h?=
 =?us-ascii?Q?AvGwtCgz5UekxKe5IgKRV0Jrz8XSPhuCMRLOOm+vy0NBgeYBhq7N+xHqs+ez?=
 =?us-ascii?Q?B8yNnhqyck99ojgn1PKWfcf7zyv7WyYUQWkAiMsd6pcApkM+VJ0FTtQNDHhY?=
 =?us-ascii?Q?dpQqjx91+Rz+UvzjztynzEtR0wvO1nXLIVk5Wu1wEvxF+341XrnxPATpsHKP?=
 =?us-ascii?Q?PvlZPOgXKaPLDyGxO5DEBOEhSuycvEiVTwyqFBaKuBLmbVChiyRo4Mqs/qCI?=
 =?us-ascii?Q?h8i/k44/PDXkOjxn/g3Pojh/iwAP1ugS4IK1PIo+vUg+n4CbwwpdhVadE9Wg?=
 =?us-ascii?Q?fOtTPnCVh2pXdQAL42JxJ5Kh7maIxhwvT2n1wBP+jEGCD75zdh6V4xpF9R7w?=
 =?us-ascii?Q?5mgxDTM5v+usPWvNb0rGEP6VMi6n5LnS4AaZ0LJRRJ2wAyODpSM8GqMfbnnh?=
 =?us-ascii?Q?PKw6k8uyA9iaPXp+BQ0COkJABB/36DK4BDKzLPU/gHwtGny2vxJLIbaZc1ZW?=
 =?us-ascii?Q?kyC2EmCVCQ5z1CyaOl23tC478vn7NduGkrx9+br6YnG3P6Gj9iSLMSDhWUKS?=
 =?us-ascii?Q?e1oZs5Bf/7IR8Iptpxz1wC6Xqmfp+gbxrtJGDhV++pdnfS0Hs82GkvP/4+G7?=
 =?us-ascii?Q?t9mus4TQHzAUTuTJrNX85bXxykH7XGnnDWLuZgsokIDmBgEo/LRupvQPSB8T?=
 =?us-ascii?Q?KTYCWDgWQxLE/lBDA1LCSL9ZTfPj+8Dwf391bnBEYmtQ3UlLOeevkWu6bFa/?=
 =?us-ascii?Q?EjI3mInyYoDbftH877UG1dYYXYo=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 08:51:15.7418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ed5000-4570-46d4-4266-08de5d813b2f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7031

This series addresses multi-function endpoint configuration issues in
the DWC PCIe controller driver. The changes enable proper operations
for physical functions and enhance the multi-function endpoint support.

Changes from v2 to v3:
- Fixed minor nits in the patch

Changes from v1 to v2:
- Fixed the minor nits in the patches
- Added a new patch in the series to address PTM capability access

v2: https://lore.kernel.org/all/20260122082538.309122-1-a-garg7@ti.com/
v1: https://lore.kernel.org/all/20260121054214.274429-1-a-garg7@ti.com/

Aksh Garg (3):
  PCI: dwc: ep: Fix resizable BAR support for multi-PF configurations
  PCI: dwc: ep: Add per-PF BAR and inbound ATU mapping support
  PCI: dwc: ep: Add comment explaining controller-level PTM access

 .../pci/controller/dwc/pcie-designware-ep.c   | 102 ++++++++++++------
 drivers/pci/controller/dwc/pcie-designware.h  |   4 +-
 2 files changed, 72 insertions(+), 34 deletions(-)

-- 
2.34.1

