Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012051.outbound.protection.outlook.com [40.107.200.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED57C28506F;
	Mon,  2 Feb 2026 07:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770017292; cv=fail; b=X7oNqiMRXi0VCwsRsC69MrNtxoKzsss3wntNPOK2I4YYvJHCVFRgdNSQWq/DJ2/jGvaqEGVpICRc0dwdnKkDC83E9jGq+KSAH+UAAnrsz67L2GjYUjc7L3BmGPoK1DARzwQ1oyDx46csl2L4WEa908XK/D/ZMhuWTcIC1lqL3PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770017292; c=relaxed/simple;
	bh=4PcKuUGNq1wyohYtgYoQnjiOIug+MZDzdTCELYZN2Uc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AVOkO1JaBSf3C/Ag2lqR0Az2s4jG04QF85KG+RwDnO4EhT+RpNl68+avpffU3sCo0IUbHpOQZHN7uTtIY2SZ0SknCWnxH/jnC6DVGhNHT4zVgZG4zYQUjPVPATp0Lmz8tN4nQWibxKIHMRiP89djTZy6Qm0lQV11V4cFVhFmD5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=M03xoGIW; arc=fail smtp.client-ip=40.107.200.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="M03xoGIW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xv7xbFhO3lcgv6fdXFcU/I8DTRGOBJBLgC3BVrYBH4u9Jeun1/+FSn+X617G1W7O93M2/v9rkiDD5cyiayJ0pFJBxM4thBAEVdnhgNszOwRxnsGUHsmJewg4IPxqbLOJB9gkCzUCsBkIJZvtaRvzf1PX6GJ23phKaPcBUw+ljxHnKmLKLIuJIuQ+wgANdk1dzhr8/rOqqFMCqlLkuWn6KORyCDMq14MBWhxmPHvfzTPj/qUS13tiPW/DDnG+90/+w6JBD9OzdAVnCljwWj0JoIcTMwJEC9VcgCz6WdP4F4Brj6U7hj8L7Fxuon7YWYD2+vDfJten4uQOfH5pzydKIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6F7RQ7ScD2qOLiWcrIjkPgJ3UHvkBlVp+PggzbvO/V0=;
 b=a+P1DkeLNXkGKLJYnl2N1g/Uf2Bt2UQ6e1tcHsGIjgCWDnMDpOaNSGjgulx0GBHyhNI8J9gDZf+wI+fqBAGxdwU5w8t2gSlpmAfymh0dZCA+3aGL7jpnBsY334eZSd6jwmzeigkZ2qw1vpwW414CmdGiJshpYuyyr6RUZor4+iaPqw1RUI/3/j3FDEP19IqrCrZ+OhlGJnA5lcRg96mWes5MLiy7esQeMXx/p83OWd4FKjWPkpWx4+dAtBQara5xG9Xtbs9G6AdyeXnhDebst3rFa1V0q4RgJ8/kVKRZ7bi1wjv0EdGF6wHxBpmeGLRyR/P/P4Zr557yBV3TtPWczA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6F7RQ7ScD2qOLiWcrIjkPgJ3UHvkBlVp+PggzbvO/V0=;
 b=M03xoGIW/mzXHvE6c3vpGqUml1dQZqSxKj72XKSqCLAZh8OgBtBrcTUiYFCxsCs9rYl/pf0/TQKeRddrBeuQuC5HFV6VIcrpDgLWZFLiUT8P1xduERl0ERQa7cFdKlP2N1ZOUtGnqsRU9KztABi5f7KIt257Nt3hJ7DFjg6F9Jg=
Received: from BY1P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::12)
 by DM3PPFB0C5EC304.namprd10.prod.outlook.com (2603:10b6:f:fc00::c43) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 07:28:07 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::ea) by BY1P220CA0010.outlook.office365.com
 (2603:10b6:a03:59d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Mon,
 2 Feb 2026 07:28:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 07:28:06 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 01:28:05 -0600
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 01:28:05 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Feb 2026 01:28:05 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6127S09M1732804;
	Mon, 2 Feb 2026 01:28:01 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <yoshihiro.shimoda.uh@renesas.com>,
	<fancer.lancer@gmail.com>, <Zhiqiang.Hou@nxp.com>,
	<gustavo.pimentel@synopsys.com>, <cassel@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>, Aksh Garg <a-garg7@ti.com>
Subject: [PATCH 0/2] PCI: dwc: ep: Multi-function endpoint configuration fixes
Date: Mon, 2 Feb 2026 12:57:56 +0530
Message-ID: <20260202072758.101845-1-a-garg7@ti.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|DM3PPFB0C5EC304:EE_
X-MS-Office365-Filtering-Correlation-Id: c52cac71-f6bb-4825-d6fd-08de622c9bb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0UNZq/xN0D7ZwsVq5n85UsyUpACxehbjW9ycqqw1XgK0GqTHVWT7lT5Qu+I0?=
 =?us-ascii?Q?cHx2bJy4foWOIYkG6WLkdt6ZDA7lWgFL4B+HeD81S7KyYj/v3zWKMf2raVlF?=
 =?us-ascii?Q?QQUy3QeqPY2+JMzTn/MehWsEEB8x7bISzUp/7YsauQK4BAYxGSdpyd1+Qc9u?=
 =?us-ascii?Q?ZCrHofdLOYYLFzY6KM4PgNXH9ESko7pHQEZReKPulcpmM9p40aOEqhmI7ZbB?=
 =?us-ascii?Q?IICpx1CrmuDmp3kVLWYgYd6CoXx17MXVIGnA7SLDbEYa1f8JiD2dyS4bFx9C?=
 =?us-ascii?Q?URuO3jbZLmqyOHdAR1InVE++SGx9gN4ybDGMY3J4Q/XTM4kZzTGMgZz5GgUL?=
 =?us-ascii?Q?HBOWBElHEDZW2EQ6o7wGkhv33A47T1tzerJq3T/mNax1rv1Fj7iKX2WQVOoI?=
 =?us-ascii?Q?uOTa22LJPP+MKuprZveoIygWv1KCSFWvrNpvUjWSRFG9SDsMSdxPSDJDM5ZQ?=
 =?us-ascii?Q?3BaBibDTSqOytT8W0eeIUaHA9jJrBJ4rp3D+IzguGOWQH/gpP3T4RdoAbU58?=
 =?us-ascii?Q?KLDKUD4pdEie6klLil2MUnMVkA5W5k6OLstulRyFAxkXgFdbck1fyfU/pC+u?=
 =?us-ascii?Q?kpcW7cM4EgYcAiS7PJIp3q/pLi+eHfzm+k1897cgSKLAnBqrhDtRxQGRDt72?=
 =?us-ascii?Q?7rHWKJISrWkvS5e5qyVFT7y9hRVTIZKbTUY35Bd9162fqHS/BTKwoWa4MOVb?=
 =?us-ascii?Q?uB1n2i24n5JPM71fSreJijOJcMAWaHFgAcUFDCeUj05S7L8UAJqSiNx+86Ac?=
 =?us-ascii?Q?cLFFpnCras9PzfUU4qm6cImuR5O9pDKa9fWUVDV4te1+2aBD5QPBlGWHDh/D?=
 =?us-ascii?Q?CVqjPf/mZyDzgqwLkmc2o0/y85H814BHDEla+Z7N1YKZuiwsEnP5yQ1yAN0C?=
 =?us-ascii?Q?wrN/Mx6V6OCwT08R2G5rAGN+HXQ/emZYb2E+CsU8G/s5lKKFgLa/hhRPVeF9?=
 =?us-ascii?Q?/rX2X8cOS7V9CSPQdyS5nSSPgKgny/rVuaOqY75K56SPdWCSv/xag7SFN7Yi?=
 =?us-ascii?Q?67O9lUkuZCCHgS9dU2LU/hf2HLTw4WaHhfp/3dltenYgGMXk3aivTWcJVCOT?=
 =?us-ascii?Q?I92KRTF60hiR6kbKVm8k8MNkerISGS3Q9p+dKbzkiFrqfgXjhq6lRLEH9kGV?=
 =?us-ascii?Q?NFSrCPuf/B7BJ5W4oA9l23dwViwn7Qldh6bOGUWcW/amA8vJYP8+nW0eRDTX?=
 =?us-ascii?Q?mdXe40836PdaUTDuMC1h9O79yXLifHLw8B6toFgymaTSm/oMV0p4uHo6k/r1?=
 =?us-ascii?Q?qnDtmfkRegEwtuGrk4DImfMhQPmFJXD8bpwgfY0znrBXY30NWnyLLo4hf6hs?=
 =?us-ascii?Q?DSg7ITX9eMDuRYNMwyaME4KD1UvDSJHwFg8DUkjcHPCr5GNrrITaH8BtNZpJ?=
 =?us-ascii?Q?Xm8v+NS55LzCzwU9w529NDeeX8cIquZdCT5PMX1IF/Kd9SlR9WxaiAbeX6mE?=
 =?us-ascii?Q?GfJk1Rb9sUgZ8s2z+9E/AdI6Y72m3gFWIbps4kx0ODIlAtGapmZC13/ejxuJ?=
 =?us-ascii?Q?Q64sFKpLEDy7SJZqw9ExlXr8qSIPpSFUMYPS60bLfApHa5c2sXkDerh2Iyl7?=
 =?us-ascii?Q?KvOHTf+PPFOwn20O83tiN1LEjtAsmIyn9hOGwKbTQakt1J/FccRx0c+FNLvx?=
 =?us-ascii?Q?bwDbUS80AAJ8JJUKHmrfZd/0y0wXO9IFgMrilB7UYbdekzXQcxGSytM5nbhL?=
 =?us-ascii?Q?phc1ZerLENldyRL8+A1WpZfwidg=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	14gNIxASrCrQvWq0A3Y9iozLxzhauT04+87oGHciDWIpghh7/3Iw3Ivwnc998gy+k9Ruh2QDItUj4exq/FNXh4gM1FC3d0U7XO/T0oKS5zkU/esubfDwmEIfdFDTMcPQGhwdlbKYaQa4CXhTCHpgBEEYfDJAN90X2rCHlk0Hk92VVvzlpX/LppreyfjJtGr+B0nZbYPGR4eK6cv/IwonJkSSA9RSJlNHt/CXLP19wL5YXiR5QqiXPkBA2yDgmWUBfCctSla5bG9sHi34ckDYfKt9lgMXyeNOySnWygm3xEzX82FjMBuTIZLoGk61/NzWzxlW4wpAXTqGCe6bopdVffO/8sIi/2N8cL/bKQIf2E+kqb3VZgdFVh8jaJHcYCfVNApafyYEkjE0BW8KcOu/CS2EjXHusRcXg8mAoVE4bIMSp8l1NH/rtqbwx0fkYt63
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 07:28:06.2433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c52cac71-f6bb-4825-d6fd-08de622c9bb6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFB0C5EC304

This series addresses multi-function endpoint configuration issues in
the DWC PCIe controller driver. The changes enable proper operations
for physical functions and enhance the multi-function endpoint support.

This patch series can be seen as an extension of the patch series:
https://lore.kernel.org/all/20260130115516.515082-1-a-garg7@ti.com/

Base: controller/dwc branch, latest:
commit a24149881558 ("PCI: dwc: ep: Add comment explaining controller level
                      PTM access in multi PF setup")

Aksh Garg (2):
  PCI: dwc: ep: Fix MSI-X configuration to write to correct physical
    function
  PCI: dwc: ep: Mirror the max link width and speed fields to all
    functions

 .../pci/controller/dwc/pcie-designware-ep.c   | 26 +++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

-- 
2.34.1

