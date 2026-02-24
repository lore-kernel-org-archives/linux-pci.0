Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011005.outbound.protection.outlook.com [52.101.52.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7402A1F30A9;
	Tue, 24 Feb 2026 08:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771922311; cv=fail; b=Qg8hT7c+gkDukSxTsfnu2TuDeTBEIiVTPib8b1Udq7nhfIH7J47jvty5c/gN7hxITX0P7F6uC+U5adFnBSgh0xv5DbHBym/FIqhpiIRCCkARFz19hKprvmgiEIllWTLHnZwdjDTrD6kbHD/z1e4Frd+i5jXq1InzPMAxv15Mxxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771922311; c=relaxed/simple;
	bh=qw2ztsb8gIkg8AbuYZycFDrPAVMu9SX+mkgx0PIV7To=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F3paOHyQXhAWyIG9XhU6kUOYZEEZNxFgvk+M5DRnINiY4lukRRUY0G0Pszl0ugrT/t7xR2n3IoCO3IpZxAGu09EwGYLoEOj0bOI0GNGXVmlukn6TnmBQTmEPCj6G54TTkSkJFM4a1yMLPw5ifzK9WeyFo15boSC33obhDx8GPzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lgCGhIQw; arc=fail smtp.client-ip=52.101.52.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lgCGhIQw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j58JOVKvD2/U3zML9ypRkzKy3bKlGj4KgA+yKhA6hIrBgnLkJKhGR1NI+CLGNFXjRY4ghslpnIAFcc6lK6EKs7soCI9UwKTLTapnHhdjQVvp1b/shqFcGyN+N3nbtlUC/vZCOpPTxcKGBFMDGR7a09h3i4fUWOvhZRekzaaou7yhZhmEMJB9hCanV47VsmaQ43CfEjurW1gfakkdILK69a9hQciu81sy0QJYKjY9R38KKpIluuwG9XXx5te+BF/DYKfh4p2UOij7IGMH78yhqGpNt+BMRtM72m/p7mcuTzw251yfUGAW/OjkarBdD25713KfoUdkRaUGi2heljFhgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6oBtS3fTo2elH/VtTDvW6+pZ2m7EPJCNDP078B8BaYs=;
 b=cOKTiiDU5wX8QErYgMeirMjYYlHGcCFl/gNJOfQk/zKPNnDaM2eoZPjfkdXcoI6y+IS8ipBXDJc/n61Axxp8gHINOP8001RrG4tn4O7chOawQD8G82d+oAuwkLchgF97j7MsLIhI+zahDROnorGtVu3NQ67+ILGkSB+8r+PUtE4tQCO1rww0tMWru0D1Na4ua/TOymPC7DKoNTLCSgQcQsM8y7t/4i8a5DgIEQt/iDLaoKuJUy8+0aKJJ8iFibkfdxVqxaIDLPQQmV92jNCKFdOWpXAhC3HbXnIiWpbSNlf0ei6PynHVwvTBKCOMK3w5IxL1dz1CUlh1Jpn4cyk7QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oBtS3fTo2elH/VtTDvW6+pZ2m7EPJCNDP078B8BaYs=;
 b=lgCGhIQwPwxoIcYNOsiS7j5QzHBvM+Os+SP+1u9QuiV2Nhq3+tN9bXaTglc1QLwi/xIU7NBA6chOSpbzk+UrOkCvZyq5sqEAVpXZNHlNev5q01eEdXGTWUcwrpSYxBNS/trnP3SUxa+zYtFySvQcqVVoVXVpqhZ/hMkC1kDXSHg=
Received: from SJ0P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::10)
 by LV3PR10MB7842.namprd10.prod.outlook.com (2603:10b6:408:1b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 08:38:27 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::a4) by SJ0P220CA0002.outlook.office365.com
 (2603:10b6:a03:41b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 08:38:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 08:38:26 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 02:38:25 -0600
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 02:38:25 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Feb 2026 02:38:25 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61O8cKBX2414416;
	Tue, 24 Feb 2026 02:38:21 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <yoshihiro.shimoda.uh@renesas.com>,
	<fancer.lancer@gmail.com>, <Zhiqiang.Hou@nxp.com>,
	<gustavo.pimentel@synopsys.com>, <cassel@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>, Aksh Garg <a-garg7@ti.com>
Subject: [PATCH v3 0/2] PCI: dwc: ep: Multi-function endpoint configuration fixes
Date: Tue, 24 Feb 2026 14:08:15 +0530
Message-ID: <20260224083817.916782-1-a-garg7@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|LV3PR10MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b18d6e2-3147-455a-b145-08de7380148d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nuGid431YLfQhtW1+VzZpc5Rf4L3/1CCUfpkRgfj8M8sME1zRuFkYygOHPN2?=
 =?us-ascii?Q?sg/G0yqpak3G++A8X7HokDXBrF3t7cSY09fsgY+rd1w1FhqBuNO6G/LhxnZN?=
 =?us-ascii?Q?Ppb5tqDNLo6IByZEUIFSQ7Xcp66LKWBxLDza+GnfPZPcksK5LqT88NbwD07o?=
 =?us-ascii?Q?8ayj4EyMJ3K46fQGmjmz6vqLuTCAj+Ey/WBAZ+k9K99azbqK1CviJuTZF7UF?=
 =?us-ascii?Q?woYElob4FuVRn5CO9H1RaffZLdbpv2bWubFsTsHsUrx36ER81AiXAX4jNH5i?=
 =?us-ascii?Q?EtH2x3yPrM6Yc8ZjfpA+kyDbj7BgrDl+ev8ft6hf2AvlgB3u3e/LueDbXGyt?=
 =?us-ascii?Q?vmBK5kY5Tr4jExFlk+WP8qi2+L0JdE7t2Ey9uORK6j2HoicdcqgcHft/7IZv?=
 =?us-ascii?Q?2K6sY1yAW/6L6W+7eiTrDr/iPD19zcwnTJ8paoalkI52ThSHXa75mj1wwZh/?=
 =?us-ascii?Q?PZpVicb31Oz5PtYkhlyc2NB6/WYV7USBU4vsrqrAQomek+yc/nxLo7EMHzpk?=
 =?us-ascii?Q?SrxyTs0g+aNozM3A44YWDeMzFkkxsnZERRu2E9dSyp5glj0TR4Hm0xP2qvTg?=
 =?us-ascii?Q?BFLnWOyxinfIQH5hkkyiNOiWV+5qhTwOs9wZiB2WyzYLbD4r31/jgeYoQVJp?=
 =?us-ascii?Q?lByoiHxboeTo6OPNGvrDJABClp+RUamiYnqLUbyeGqN93GSmWoPEYJoGNxdS?=
 =?us-ascii?Q?LszwtzTcfhzjMSlRBr7JPc1bsa4dDAxQh1JzclQFG0mHKL4uRxTTElSCiP8Y?=
 =?us-ascii?Q?Sp3CDiCV46n1+pQw+5fDDJbUNw0p01E7QzXVqNOZnhjriteq4hn1pJxsB6Uc?=
 =?us-ascii?Q?Adg91ViJp9OguRATNsM8fDLNusTBqrfZwUir0US0FxaIhKUJulwnPh1Ai3Jg?=
 =?us-ascii?Q?NcJlzZ1Z1z2FpEvyv+DSFpBPbQS/cFsqYHGifErAIm/m1GLquOTnmWyjDW5f?=
 =?us-ascii?Q?YX8v48Hc/a9+75vk336rFtAbdBUa+K0hDfnQE2Jj40AElBtenFZRCL9snqcZ?=
 =?us-ascii?Q?VolsN3qsIB5CM20FQn8Ik1AHIUmecX8lAwr/9l6rKSEmw6HVBRYn3en3zjxZ?=
 =?us-ascii?Q?KQnpEc+YWcq5E5OTSAKMKD8uBZKg6f4V5F+hwPYlYnI9tx8WnGfMM1d2AiOk?=
 =?us-ascii?Q?1y/KATvolPUOjPOc+l+Qk8RoRGnK8TNfRWsIYlSnpQtauBgipq6ZnhACAdgN?=
 =?us-ascii?Q?2AXC5JOH6H54w4hHB1Vt5N/3Gm4i1Owh6k2QmRhKzyVyG2ErHQtNtjwJbZAg?=
 =?us-ascii?Q?FDYOgbYNMjtUOE+QuFylMGoFu2e/JRWbaRS79azkoe/8omNKqifv0mFNeNFD?=
 =?us-ascii?Q?sprwDPuKYrMLtgn0ADeKT1l5WyAhzX7pmZlLAcK4QobbyxIZ++JiXbqQzy9g?=
 =?us-ascii?Q?WxWxTQxRSfqTIg8LrT5dAhAAoIuWEiFgU9u4QskHFayTJPeLQZbEERDpoXoz?=
 =?us-ascii?Q?dx3Gc0k0eRPIOhhnU7mxQ39aYHL3eSmFvsC11Xjk0jOF4Guck0KhX1zC8PfB?=
 =?us-ascii?Q?l0gOGlfDKgR2+G9uxzZu/6J2rmUas8nrmh0mDPu4J4R/rEdSYALAqemqbXt3?=
 =?us-ascii?Q?3D6ewbqUk+91jquU59p4n6Kqrlbkfj3HApbaYjK/VFs/gSoDCZsLx87jWfp/?=
 =?us-ascii?Q?42cI2KntwYYsALixPwoDfR6YA0PPl8aCpS40+Z8hz7PjZydasbk5E+htzqDh?=
 =?us-ascii?Q?czUk4d4byxXGURW3tLXoXeGNggA=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TEEeiS8RuK/xep6xpDkIWfemGoNi6OXTPGTsTKq9QKxaXzlqpDo6HcYlnzqxKMaS7mz3qwXTfXnBsaEZCtDBCELe+MxsB3lVcDBJCNPh1Lm1QteaOKJayK+7ln3OtNuJaBuZJNeFWH/3leora+HUSrH/dZuS+t65TtL8QPefDn6jjJVYZDXRJVR2H0vvx6MWgbn3/cy7XN01Hm5TJsrPffP6J1aH1pgXF1UrDpinSESdzILC8rcMI4SS++fYC+UMKS3pGXLzkl/1EUn6je3GMhLRY5LRHhiYpeROMtsWqjV65PAd6ghcXA8ZMB99XSlcJGW2yqHrAF0ThYqrR5YEMADbz2/Xt1tFQbhuWF098LV2P18PqkbdP9EJf3RlbR6TY6U0kxJ6MotQh5mgbiXEjL3cUTeF+xC195gv9yV8zH29Hs5RzrOHC+GzqaEpsl53
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 08:38:26.9656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b18d6e2-3147-455a-b145-08de7380148d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7842

This series addresses multi-function endpoint configuration issues in
the DWC PCIe controller driver. The changes enable proper operations
for physical functions and enhance the multi-function endpoint support.

This patch series can be seen as an extension of the patch series:
https://lore.kernel.org/all/20260130115516.515082-1-a-garg7@ti.com/

Changes from v2 to v3:
- Wrap the patches to fit within 80 columns

Changes from v1 to v2:
- Fixed the minor nits in the patches

v2: https://lore.kernel.org/all/20260219064511.695086-1-a-garg7@ti.com/
v1: https://lore.kernel.org/all/20260202072758.101845-1-a-garg7@ti.com/

Aksh Garg (2):
  PCI: dwc: ep: Fix MSI-X configuration to write to correct physical
    function
  PCI: dwc: ep: Mirror the max link width and speed fields to all
    functions

 .../pci/controller/dwc/pcie-designware-ep.c   | 31 +++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

-- 
2.34.1

