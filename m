Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012003.outbound.protection.outlook.com [52.101.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E96A32D0D8;
	Fri, 30 Jan 2026 11:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769774130; cv=fail; b=WQxqyLa+e4rz4wm5oX4srVMYd0fQxVQS2dfYxkBhSULM/v+0ELcYsEZ2u1NOKbqdDGPyT/DVEKLDSbHgWeei2e40QaxBkebEB+8fLN5qVCr7pzZXBnjYDpWDy1754PTznNHXOMFhwt2iolZtQ8ouRpp+yzpK1+yj5+BXV7F70Yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769774130; c=relaxed/simple;
	bh=NfGbW4C0Pj8gUZdC2TZAuOI6IRiy1Vuh4IGAL6F05iU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VM1Y5eVGALuAF2YJMzOKM+sr3jDNiazcXyHHkop1AVvRsXOFO/lAY1IVEImz+Q9Pr7ewzHssyqHjCaEl+YrVFHqBGGfHQOODYrEDq9g9RJ+L7tfi5frlUYR08f8lU98D7xzEEAylGBB5YrWvzl7GoWlO7B0g21oggpFKyj6As8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=S/FYagdm; arc=fail smtp.client-ip=52.101.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S/FYagdm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCozFOEw2pTtIBCz7ioh/mV0lmc5c1Degy/xgWVP1y24zBioj7i5NlmEHX468kxPr4RQRRtSGpIPY/qf9GeQxch8j0TAf1v2p1w7tTnAAHsw6Mupn4/SYyASVJSpC0yQljx7jxr6tWIeGjtOoV54Yecsx8wIlJfmPERIo4AxOA5VoyFLPIwib5zE7oiviGlvxAjxGbXdIDv4YSVgeoWq5ahDWCoIPZreO9L2PLaP13sbCxg2K7t3btB53diIwB0fa77aBxFjdr7eML9YhmhnToH/C/lXU3PMkGGcJvntWJx3IfAgYOEv9WmEzQi1OHZlZIEOP2KfjaMBy2QlQLn/9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvqC+eo5NpDaR70i9aCiHY15avE+IOh8sdb1E3W75z4=;
 b=C3xhB4pK6rlwUj2lhuC73zcIq+qH5SdY3YbAJm8OQhEiuVT/2LK/t1QWNIE7xcjSttgGviAUwx804rrtkkdYFSarA3eXgOAnNKIbpgo1z1ZSmEeOQmtAYOV2CZCje7eYpBD5nPXADZJxsU6leluB7FcdSJRPOFKZldZHNigcBA6pel87yedi53imOaf/OT/uJhD5Wzf5AdtRkkR1m62eCJVhTxqRuVQyMh8hbJZRzbSN2lVN26IYORKB0OMtuB0yHoBxkoeuG7i1K+iMr+xjL8UYZAlFkVqln63pjXeHyXm0HkCZB+d3D6JVf78WZUjXUlSz/aU6EYCog+Tb6MVtzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvqC+eo5NpDaR70i9aCiHY15avE+IOh8sdb1E3W75z4=;
 b=S/FYagdmUdxI3sNXFfWQs3g+ibskN9tSmao9evmVGZjvof2fok/m9oZt+S+PidpcwvJ7yhT39oPReTLtQWQnGS+AY/ZEMaMzPym+uCohymGY/1jKURQ6HfOJFInUdeTWQrsQ7VDZ6jDDMkBrS9f+Zqk0Zpuvt2V26/Qtz04ExlA=
Received: from CH0PR03CA0009.namprd03.prod.outlook.com (2603:10b6:610:b0::14)
 by SA3PR10MB6949.namprd10.prod.outlook.com (2603:10b6:806:319::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 11:55:24 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::9b) by CH0PR03CA0009.outlook.office365.com
 (2603:10b6:610:b0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Fri,
 30 Jan 2026 11:55:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 11:55:23 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 05:55:23 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 05:55:22 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 30 Jan 2026 05:55:22 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60UBtIu01665999;
	Fri, 30 Jan 2026 05:55:18 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <cassel@kernel.org>, <Zhiqiang.Hou@nxp.com>,
	<gustavo.pimentel@synopsys.com>, <den@valinux.co.jp>
CC: <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>, Aksh Garg <a-garg7@ti.com>
Subject: [PATCH v5 0/3] PCI: dwc: ep: Enhance multi-function endpoint support
Date: Fri, 30 Jan 2026 17:25:13 +0530
Message-ID: <20260130115516.515082-1-a-garg7@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|SA3PR10MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: bec41f1f-be3f-45af-9f5f-08de5ff6735e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oXQZi5NqV8FKJChSJ5YN+ph9Wdglwz3TS7+woEe2XaEPz/gPTAEgvQf7aFaI?=
 =?us-ascii?Q?U7IuxLHjpyMbFIt977wxxEpw+XuWsKf/AKD3o/PZROLqwbu4T1CYTRjnup8E?=
 =?us-ascii?Q?JfibTIaFD77ZUXbvreH8fLp5VFKBnDRXqELBTTYqsX4hn5iFAc04ACQvdiNe?=
 =?us-ascii?Q?Dk7AoRy2F+gZBEaxUh3a99GfP/fXTSvoR4+Xg1HAH4HrGzKJ47WksxkSVeKo?=
 =?us-ascii?Q?a1u5QrKhr8Uh/yAiR5AwvNy0WwvycCQFZJEX1wdGOztLypil7yZKd7IcQG9k?=
 =?us-ascii?Q?XnzZ3VK6a20iJ5w8LfLRKe6SKtO85KDVGY2n7gZ/67W2VaQQ3js6uWg9kQF2?=
 =?us-ascii?Q?q6MIi6H9Un6vzVFk/LGv0/I+UMaC9t4JVFYhHrajNvktDZ5aSoons2iuTlEs?=
 =?us-ascii?Q?GNYo9cAWlZkihIccjckEJarNcl4vgiwCOKZGmvgk5k20pEK21ATNHI/BXs3v?=
 =?us-ascii?Q?UAFFLDUfPLNbCDBEI6z8E7pKLEAKVQK3MzbxOPLLNuWaOujqkBCp8vQi8Q3h?=
 =?us-ascii?Q?iOwd6r5MCVSHv4EBplXGxK56+0iZzTmTrgmYYp9NI1b5C7Zh5q4JU7qYSPc/?=
 =?us-ascii?Q?E0XNZKdQNM5mcH+uDt/GWdONPhPbHSwfTldVM4gDRRFP+euzfv3CsBTEw9Ll?=
 =?us-ascii?Q?+HkcUsqLMRvoQ/5XpybxTUKhxZxBHgML2qSiiVOIHQmTyOO4yiKuFj1QG0JB?=
 =?us-ascii?Q?rO6pwpoKl9dfCZODvsGjN5iEExQwkhXPD8YB/yD/AX5/L3QOEOKif9M+4A2/?=
 =?us-ascii?Q?NwLSIWJQDyT4Oa757SbrnIhyCqb8mPyzwbs7FSgyVmzbysZn+x4gmg7jaP6v?=
 =?us-ascii?Q?YtZGgbNDfFq/gi+PanB3CpYHdO7tY+jizTbYFJEz/A/2FVxMjBUPzyELw0oN?=
 =?us-ascii?Q?ZoxgC64hEQCCkyFJ0K36AOHjkkPLnN8R8ihk1EHLutBZXoHovm8EKYo6N/tL?=
 =?us-ascii?Q?4feDSxwHZqtHweQ+vj6IrG20j3khuqaw0qZ8ZpYRkFkFVtR6bbnmsIIe37Wj?=
 =?us-ascii?Q?ED9a/jcGQnaGyaXKbaRyyV74n9XZ9dp3sy47gHXXMLj7o4pQskYHyiAreXA9?=
 =?us-ascii?Q?/wopORw8cEwOpGZUztVI1gvISfB/SVit48WitZHhGu+Moddf8rAxb0NgDvi9?=
 =?us-ascii?Q?47O/yD9huyLgF9EDqe7GzBGbmGYSV8EB2/eJyiO92NemUpQ4rFBofPCSwqft?=
 =?us-ascii?Q?iW6H1fi+nzHdE4wSLr+b7xbfmgqq7mCl+LlIO5QzxavtY431VLw+QR7agE93?=
 =?us-ascii?Q?q9j+klASJO845YcQHKErFn/4I1jfp53rsIB3/lybXI+yqsilhWuYjCUpaeVG?=
 =?us-ascii?Q?S9Vf1UU2YOsL6zvaa3ohm+PSCPJkxamNPAisaO7ViXuNdFLHqbaDo/2uDW+e?=
 =?us-ascii?Q?goRzxzMlJ2F1pet8Gf7DaTLp3CCVoidZOFg1ihR+FJz2tTpfnGAVQpZuwGia?=
 =?us-ascii?Q?LfqOKy9u4RNkfuSxbSEzKZy7dEL4XAEzdqcdvyQfyDZLefCvz6C0x5JADXgp?=
 =?us-ascii?Q?29BsWJg3fJgLy1kKCtzw0pe+EnaFcU8d1JHtXAdAC2r9O2sI/HkS6WHuROEH?=
 =?us-ascii?Q?YCfDQrPh14gE7Sz8PutXd6BFiDM4veNraEjdLsJtekyLoea3uo7sPiYJvwxB?=
 =?us-ascii?Q?lrFIDdIx2vOPlcaaBD5eCoxwQCf4OJVETYHSBAk671nLgbR9SiG6PkJPsBH6?=
 =?us-ascii?Q?omeC2Y/of8J9T8gLRX1tgcw242o=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TpCMTHj/UzGWpl9a7OUhk7EhBYfTX6F3HfNc5Tkcv4MnACJg2F/a9YkSzH40r1vitZEZEPs8MxRwyqNgV19/JJ+8k3H0Hxl8FP/Biy53tKp81CsXAbDGafoIjbAGD0GKDYQ9OAEAQsKz5z6cGrrq7tvbUWDu6XiiLW0CY4y1NB77/dz/14L9Q5+0CowjS7uW/m6LxR7jKQnaLRsVhtSUMMOKVtpngMCjSBHjUuC4O3o+sm9+X2gfheDORVvzhcq6YFRiWwpq/e8ImvvlqTRu0HXgrZQ06lOHtq8OzLGWHHOpjGFKLv651WFqGtllSKMv646JByx9cuT4t+vQbXohfmWO/FSQTOBS2FLSyS9SmXgu8lV7eqOl4c5QbI3Q5Jru8ZAktT2sOYDXbQMg2Mf6RZoTzNRqY385JCOBeixsnNuvONRD01okyXM3b1NPjRwl
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 11:55:23.4369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bec41f1f-be3f-45af-9f5f-08de5ff6735e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6949

This series addresses multi-function endpoint configuration issues in
the DWC PCIe controller driver. The changes enable proper operations
for physical functions and enhance the multi-function endpoint support.

Changes from v4 to v5:
- Added NULL checker for ep_func in patch 2

Changes from v3 to v4:
- Rebased the series

Changes from v2 to v3:
- Fixed minor nits in the patch

Changes from v1 to v2:
- Fixed the minor nits in the patches
- Added a new patch in the series to address PTM capability access

v4: https://lore.kernel.org/all/20260129091753.490167-1-a-garg7@ti.com/
v3: https://lore.kernel.org/all/20260127085010.446116-1-a-garg7@ti.com/
v2: https://lore.kernel.org/all/20260122082538.309122-1-a-garg7@ti.com/
v1: https://lore.kernel.org/all/20260121054214.274429-1-a-garg7@ti.com/

Aksh Garg (3):
  PCI: dwc: ep: Fix resizable BAR support for multi-PF configurations
  PCI: dwc: ep: Add per-PF BAR and inbound ATU mapping support
  PCI: dwc: ep: Add comment explaining controller-level PTM access

 .../pci/controller/dwc/pcie-designware-ep.c   | 135 ++++++++++++------
 drivers/pci/controller/dwc/pcie-designware.h  |  12 +-
 2 files changed, 95 insertions(+), 52 deletions(-)

-- 
2.34.1

