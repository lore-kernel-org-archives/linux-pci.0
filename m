Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011027.outbound.protection.outlook.com [52.101.57.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E76E305057;
	Tue, 28 Jul 2026 20:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785270071; cv=fail; b=tdtO3q1AqknYwcKGVzSOnQChD6FvL0SBIa760OL12bzdZRpI/q6GKP+2//SKAcUCFFCa9I7MhLgPnCQm2YkyPoGreZ9ORz73vlHVD/5L4kCxki0P2TxIVUhbVLma/9MIGR9IUS29m2r0/o+k4uHR9U7LWccEvxEPjmuShsV3D9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785270071; c=relaxed/simple;
	bh=vu+lkdWAlY+Zw7h/ygF+vmo/AYlNXFkmclzqEyDany4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eHJ5Vu6i5+eQPLYtAiE6KFnL6ldzIAvGjmXun11utbjUIwxsZ6VmqJgyMG+TlljkYDTJSMgqm+mxru/SZggn9nYP4Mhl8FrHQd9Jjmw18C0ydNI1ok6KOfUzg17c8JJek8tvs7enZH4zEX4SitnyKzl3QB7Pve+Mgto3f1zLed0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KOuXRjbI; arc=fail smtp.client-ip=52.101.57.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KOuXRjbI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pzExmwsod0bKT2/+6W63LEfMu8fgJqHl0MYbk3cXdRu9J23gxXqJG+5koIUksa12En4/xEqGf6f8fGaws7X7s1jhxdBzfY6hzl13aL+WqAqWgS2N2deOzOi9tunBdpPyMB0XN3pry4Yy4PHAFpjkANFNgkRFdilulqjivB5c9J8SIwTcfByFvg/y+RxIKYwTm+GqIBOtzNTjTyjf8SVwTFTtKZ1w1+p8kkyRZggJ8u/93fWNAbKcQdYukeBS8iGH5puQto9XMtfyEsa8Krf2YIQSM3MZIsvV+evuQPRaAyRJ8jienSHBKvIkSQf3AKLXuNWMwBzgu2qR7NWXn8a6yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lp/3oVr1s4i93Sqh+wkKAtKJ4O/CIjBI+qENB0q0zHs=;
 b=p9f2453UAev/2O85zrfHr1KnIA3dEyXJYSpT17Q/GbY3hVZRI31a/vBbmgUQQiu7dKhftHVnvAoLFh5VkGh5syCOhbMcrr7XjXD64CKyg35Vz98bySgZ9iYdi/1ynanORHSHlEuHzbBrSRzLpVabjDThF1xJjo4/H3KIeDIB3Po0+vvZmQM5S21C9gHWldZVIHScAcrHqNZ8VzNqDwcNC0vuLx/ORyLCpdP/S33upVrOLgUbKDat9ljaTeK9XdmE8tVqlQNfigPilMUInydpGZfMU+rScPC8gEoyoaHiPI/XCZH1JM8saWh/oqc/JqyBhswMpgtNqo3re8HX2ONVqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lp/3oVr1s4i93Sqh+wkKAtKJ4O/CIjBI+qENB0q0zHs=;
 b=KOuXRjbIWFHEz3hkSWPvbpJ2lAfKUwXvVnANYwo8GTTQ+u9XigElrhhW3rcNPYZPfZud7oRZ8G5iUoiiPVzwp6mX+9N1EepCfwf1wELrav+x5awK142wfURwMiicQQIgYo+HIbgPfbEpvJuFrK7ge+86WJZcZL81dgtNKLU6IQA=
Received: from PH8PR15CA0009.namprd15.prod.outlook.com (2603:10b6:510:2d2::8)
 by MN0PR12MB5929.namprd12.prod.outlook.com (2603:10b6:208:37c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 20:20:58 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:510:2d2:cafe::89) by PH8PR15CA0009.outlook.office365.com
 (2603:10b6:510:2d2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Tue,
 28 Jul 2026 20:20:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 20:20:57 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 15:20:56 -0500
Received: from xhdlc250058.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 28 Jul 2026 15:20:52 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>, <pranav.sanwal@amd.com>
Subject: [PATCH v2 0/2] pci: AMD: Add Versal2 CPM6 PCIe host controller support
Date: Wed, 29 Jul 2026 01:50:42 +0530
Message-ID: <20260728202044.1785986-1-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.4
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|MN0PR12MB5929:EE_
X-MS-Office365-Filtering-Correlation-Id: ed914180-56ee-4313-cac3-08deece5bb8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|82310400026|1800799024|36860700016|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ub3P01ONwY3niu3Mc8gCQE6CYdo8iRkgTM3I1bx0PUFgl1Psxze1XY9GsQEBQLtTV5305hLu77njzN9ujnjMRbPBty24dDfbGYbxz8SFMcQxQ9Ar0aPWkuUM2pH7snoILjtJitm6ZHpkfw+iMMGtU52JzhyRP2sm7UGcgXMgwRSmXr6/15t1kcjKPCqfnlAx6ddDJ3N2wRUYaBHOeeuTg53q4Myvbv4gbbxejNTH4yw/6yrbWkSk6lz/ir+8+lxlEVDrPwjTy0UiNXuTCWz+NdhOWGG6i2ZtHYddjk+Jbr8ut0iePHlSF4B2WvFWatUqY8Gpsd5yisz+fN66SMzArFLZaO5pCvMiYkR/MfM76TBEeddy9OdU0NYYlnLxoFVKKcDTcknf6whJXBg+Yahm3nGreG1MyvF397Dd340Ln6p+lQaQtEK1e3/or7fLGjxjZE7ByiT5H3gOA3Y4blPBodyDD5XIAVhyTElTa1p6YiqD0KfylkRe1xfSMJ6htqd2yr/6DrGqf3VD1CpuYVca+AMPTWSq/TVRYChHY3YIwJUxlyTJtLG3zDirdns6YS+EFwBdSkwSzvy5JQRsN0CShnBpbu7+48L+8NTyvK8UVSnaThS3UJM6ppKNLKjaoloFvDjxy9EMx4ibqf1zyB0yd2AK5SFKwE1KJ9CWWLXv8jWu3zolWHfLXGjuUMCL/8xK98zuduee6ocjdT80YnBcrg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(82310400026)(1800799024)(36860700016)(56012099006)(11063799006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KmfiGmrr3nqV7infuhAui0WzmpAd7NCVQvNYTItXEt8diUqOlhdwdUms+lctELuYm6uEQtcHyBqJGZH5GTDzdTtDiO+kQ027B2l5sbnAP1J6idanw356gf7qmqQjG9iKoD34RA8gIdBVCApnn86jYhxjuQm0M+PIMiR4xlXqm6Cy1JufcSre7XGCdgxLvsvFDLQHPOocnExizGL1SDNec6j+eWPOKWDPJSXuzGOfF1JBx9YIlpDB/riDSHwUzyenFtlLswUSte7cDUcYEp2jG4s4TisBu/Lo0h6TiUT+XRFuJVwviUtUL+UW/MimXR2VDqsTN2AdZTjpyMPi7HHAQPOLtaRhpzWYB3nr3i+jIg2crzU+1Fd3QyrNRPVKbZMluwDDZhpJhj9dx2w1IByGnfrHHYae/Gzozui/Bzz5ig7hgwlyHwm1gpay2r7ixR5W
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 20:20:57.0468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed914180-56ee-4313-cac3-08deece5bb8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5929

Add support for the AMD Versal2 CPM6 PCIe host controller to the
AMD MDB PCIe driver.

Update the device-tree bindings, and add the CPM6 specific driver register
layout and interrupt handling while preserving MDB5 behavior.

Sai Krishna Musham (2):
  dt-bindings: pci: Add CPM6 support to AMD MDB PCIe binding
  pci: AMD: Add CPM6 host controller support to AMD MDB PCIe driver

 .../bindings/pci/amd,versal2-mdb-host.yaml    | 111 +++++-
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |   2 +
 drivers/pci/controller/dwc/pcie-amd-mdb.c     | 351 +++++++++++++++---
 3 files changed, 407 insertions(+), 57 deletions(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.44.4

