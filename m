Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010071.outbound.protection.outlook.com [40.93.198.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5104219E8;
	Wed, 21 Jan 2026 05:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768974185; cv=fail; b=YNNQL00az7GmDJK7RxM4Ngv18MRFGMViuSK1SANpvpaKcaDkm0V8aTa+6IOdR8iFAEIgHgQeDgbEcar1GLz3R1UQQBaFNlp7T20LESHgWdF+VMfvWbAc8oHaD96Pl186fj+ldChkMLbDtGjxT3wqLyqqoj0NeZ8haGPwX92lo0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768974185; c=relaxed/simple;
	bh=nOilYfYZt48Ffnei9kA1mqwiQOA9naCzsWjTFca88Bw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kXoAFDyV9fB0uStxoEDAUTPjXVl2EOYDKXk0yvHdQcgcZSGtomS1ffG/AORXZQzEIJtkiAbWUMj2GVqbgswbKw5QN25EKKlAbgPsNKL6uWNsEFHdyJbU2E+as8/0kR9JPoC2z+iHQz9gZpF+zrUiKs5PMn3ouLVgWNe6zXwueN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SvxUVlgl; arc=fail smtp.client-ip=40.93.198.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SvxUVlgl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCww4g7axkBgvc96kQGUgK8EL8Z1ifB8FZmKp0IoGmuaU0vPI7+YfXC4vIGOveNhRsIxrqdM91JfH4oV2bK/V+MpjSejsVU2T8OJfG2Rf1oTqAUhtypWXnm7hasCU6okr5CqRDuNfftYz2yY/Iy8AG15ZkW8JiVUCFyIpZ6zf9IfLumPBFF/CCZL9jX4ReWn3qjQrqk/EJ1dsVasQV1vt9WwaMYFg1cv0bChLxjMz4GcIggGRXPNYw21B+ZVsaa3P9o0TL6jBwZoHmpEyptC7IxZAhPqdfV9200w+Swx9NpAbGMS1eEBqJGldrJfjmEwtun5E2lzaEFXKv6ch7u6xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8o8JFPNQ+hPTPCx95XKjZyyJra2T2VssjHdOy54+7c=;
 b=MD4pS5dOSu4JE7stkBYReQ1lZEXTIHUHi2iYTyDpAmjAXTeeF61p+/BpxjJjyoHfH2O7fKUoSGbeVAxdO6CY5DfLtwKMq9uNmX/jkYDF6cDpYcyb78cTEC605VOV/k7BrsWbNJf2EwEN8pB0QD1tjUrB2VxZV4FuYUoCikV3y4F3hSkMfJX22D1ZqKYPL86aW2Hqw5K4F858ia08NvrLPnpu0d79GYz/63rIeglRBdNWppPWQgVrK1/qWiypD/SauFAFVZTI8HnjhDoXgXmpHj//MgllygFuyQw33yrTQ72/V3cpoQSEVee0VDv06iOm9QwldXyiWT96b4/xS3dLFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8o8JFPNQ+hPTPCx95XKjZyyJra2T2VssjHdOy54+7c=;
 b=SvxUVlgle9SKn4pEG1Tg1RI+P1fpP+9p2Fuk5zih6nP/c+m8VAC9auQlrpn1kCvmQv+z+JYisSbSup+MLN2QLK4EIsuH+wIky4F5UK6RIGgiqKyf6f5F6QK30rcIdxg06ud6gHnWjD6IPtzohyrCoPHcHfwFRO5QmLswc1sH7EE=
Received: from SN6PR05CA0011.namprd05.prod.outlook.com (2603:10b6:805:de::24)
 by CH3PR10MB6761.namprd10.prod.outlook.com (2603:10b6:610:146::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 05:42:54 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:805:de:cafe::fd) by SN6PR05CA0011.outlook.office365.com
 (2603:10b6:805:de::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 05:42:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 05:42:53 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 23:42:52 -0600
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 23:42:52 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 23:42:52 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60L5gmFP2466752;
	Tue, 20 Jan 2026 23:42:48 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <cassel@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>, Aksh Garg <a-garg7@ti.com>
Subject: [PATCH 0/2] PCI: dwc: ep: Enhance multi-function endpoint support
Date: Wed, 21 Jan 2026 11:12:12 +0530
Message-ID: <20260121054214.274429-1-a-garg7@ti.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|CH3PR10MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: a0e8e5c3-7719-401c-16c6-08de58afebd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lo/sO946NOjjcRGF9zSW2+8Q26sv2r6YWJn5QfGXeyjERE3/+Rr/6Q08shkr?=
 =?us-ascii?Q?gN/QKLcS+EUFlxjapsEaKyRAD0bLyxbtMWQTDtcACyZzh/+IjDsbtUr1BQ6E?=
 =?us-ascii?Q?LNi6MqiifeOoaf9HrD9wSS0u7qC+CY0oUjAP8OvKXXqwATBenlFumBMjdc4M?=
 =?us-ascii?Q?cGoDWMKNBvTGZ9w/YAiDy8vSYnD4ylMUjzFMhGhnqBtv2qcQ6WFb9BSYjYPv?=
 =?us-ascii?Q?bgSJ/WHHLFw446QJk06juKB6FzmBQBkefSNHJsq/TA8lETWreJI/4RR+kp1/?=
 =?us-ascii?Q?qiBAihUFeSoLVrtr7dHolL3Gnxz4He5xp9mtfbq2BeAguYa2SuY98VYOuDVt?=
 =?us-ascii?Q?mjBKfuDuhuEKu9jgxRcYjZjgelL+RK9aPT0toyoj9S5cuDuovn/5yLeidhxa?=
 =?us-ascii?Q?Fb0NB6hhaq/yZ15ZSl69x0+/ODApgpBLFBr68NPMoKMp6hC+kvZx8UgX6BfJ?=
 =?us-ascii?Q?xxe3+fFcmJ4bqRcduc8PcYoWAZmQ8Sg2Re2sv6X/7EV7wUIKHrotae9xXfz+?=
 =?us-ascii?Q?0aBYszz5TVI29krRy4ZQPqJw8e00QoWYwqR8k1kw6CnFb+fpiJO/iEQbmKJg?=
 =?us-ascii?Q?if8xu8FwolGHK3eLJqXCLnohvgi2REKZZ8Ojejvl3hAc35yUjwt//LrZ+nzb?=
 =?us-ascii?Q?kn2nx9HWVaI/0Dph/hij1zXypLRNED2n2V2kgpEymBexqtK+0y50RG1Gc75i?=
 =?us-ascii?Q?zMGsT214MDkOBStz6xXOXflFcaDVFhcG+gBDf4JV6BN3+H470w3xaz/Facvs?=
 =?us-ascii?Q?GUyH7Vppl3q41L0yKNemjzHZiUbKjkX4d6VLUBvOel6OAQw7kXdDSbs7/Zue?=
 =?us-ascii?Q?oqJ64UmyaKoJvJmwjEcd9guhbN5cDc+rLkWi6Dw7EpbhKgzw+LAHbSAQKP9n?=
 =?us-ascii?Q?7CVjJXD45ApQT8/kH/9Vl6Tafjyog8WAjLCgAbFHWi6pptgiWn6nYDM3UZKv?=
 =?us-ascii?Q?sultiHcYxxxI2/nmXmABwG/kJpStzYGBMvpo+T/Nf/xDaOxut1d/7ZqsmNGC?=
 =?us-ascii?Q?zy3FSl9bPcGxscyvHoiSLxO2TpEMHWVzhCr+tdKW3ibDYrsE9gAavZ7WQi6/?=
 =?us-ascii?Q?NFkcNAJHTCTd2v38pjGNBFVB0ekWIGsWf57W3hCsnHkGlvXAqP04qH9+67Ui?=
 =?us-ascii?Q?SvMHLio8dUiC1h1NPfYKTrZJP72IGP41iDijV1aqlNVfxyQ8nB2QtVDw62hD?=
 =?us-ascii?Q?Yz9v7yPReKledr2NCzq9EVJMx3kGkycjkP7EAc4D5WOZyTZ+kNuitINfpKFj?=
 =?us-ascii?Q?eGvvHEhHSwsUdFI4snTqW+Hz9klGlnjTlvhR00sP2T98ZmcP7ahj6OBpOgGR?=
 =?us-ascii?Q?WwxZNy9KjE6LqlRbrVUnss2GDTfSYfv6u381R4dMHH4HbeO/AAkTa812XoYL?=
 =?us-ascii?Q?unr6AxVAb/YuuXaYO+jzStsLypQTjKuyFZ2GOq6qQ2cVD8gIXotlqhH/5COi?=
 =?us-ascii?Q?zKHoNmRCp7c/NG/eAduOwutrV9Kn0fQsJ194epTCCQvMCEAbZGMz5bc2hRlv?=
 =?us-ascii?Q?Abeqe4E6pudLjB8x9I4SmGq7DjF0Sk1emwYj1gQqJsCFt9VRsjJ/5x6TZXRK?=
 =?us-ascii?Q?TYHKMJUDTVvQXMJXbCr0CnHztPFiwAcG6oV4rIOC6FSk2bR+mrx9Nhjrnqli?=
 =?us-ascii?Q?gliZiv5vmJ2Az0K2+HhzBb5ZE72L0G8AzmK0v8Ct0BpKCLCoYZbCX757sksQ?=
 =?us-ascii?Q?WD+m/A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 05:42:53.1597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e8e5c3-7719-401c-16c6-08de58afebd6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6761

This series addresses multi-function endpoint configuration issues in
the DWC PCIe controller driver. The changes enable proper operations
for physical functions and enhance the multi-function endpoint support.

Aksh Garg (2):
  PCI: dwc: ep: Fix resizable BAR support for multi-PF configurations
  PCI: dwc: ep: Add per-PF BAR and iATU mapping support

 .../pci/controller/dwc/pcie-designware-ep.c   | 97 +++++++++++++------
 drivers/pci/controller/dwc/pcie-designware.h  |  4 +-
 2 files changed, 69 insertions(+), 32 deletions(-)

-- 
2.34.1

