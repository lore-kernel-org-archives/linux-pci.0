Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010008.outbound.protection.outlook.com [52.101.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD7925B09E;
	Mon, 17 Aug 2026 02:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786934389; cv=fail; b=A+tRbS1s2fydpcdQ+KJrshj8RKzAGuZIJYpTD6xJynFMdcxG2dSypUxSwq5zIuzdgdy4cyRRvhteHrTHXOQo51HaDrz/LCAeA/E/+yHUrsKgw2Q1UO413HFWjtNu086zLEvKLPsEdYgYyafSKYPMYCHlQbLVF/WZg0xyFNIFqTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786934389; c=relaxed/simple;
	bh=iAnvnyXbZ6dtRs4WeN9UsIIvWTE8Z8QOuYVdnU+/4x0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EsShtWcVFJvA+05gBWmixi+OUKcNW2ojf7sWquXjrpBzJ0U1mf1x7Ila/XuRrjijSEtndTco6AMDftD9C/Iou5lpUqnf3XZqOLtZQnZXrxJGA8c2Jk5p5xVMogDyYoWs8AlFOEF83joLa1PTY9XF0NhE2Z4H0z9rdOpRopH349U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cKFodvCw; arc=fail smtp.client-ip=52.101.201.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cKFodvCw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qvJXnWfqFvrE0hcL3D3CMGViIOOhW8OipIvMIRsT7Ihy018Dbp6lWKRosnE8dM+6BTr0VVOjkDM4ymm1oXsT6kLIZv2j66hOdlWgdOwMdMC3n/5w2+vkX9PoVuPP1LEeNqWxjcejux3kxHFrAldsPKXjQfaL7c08rbS8ESA9FhaVmYDt8oamso14gqMposylh8N4chQv95z3iTyJx1zJIgINPIZnIhM4Il6wfZW16IqcSqMuSYIUQ9yx3g62WYt7kY9M4BKpuajEWFbe6CTl1Nml6WTYB90U+YsIZfk1gHv8QhgqOFznzu1z0wG5RRs9A2yYvRmsfwUcaCSCT/VtHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CM18VG+3ChI6l/UaEgGON9VSnNgd+UkIPtn8IC9hJNs=;
 b=kKwjQVSAAFfz90LnF0PTADRbocWklFfDgDn+IkYu+6jbklLeIVmMnQ/VEFuJ1CnCzNZ01ANLMCr7lx97YJWgQmYjtIrjepm9ZO0JEjiUozcBf6zsbi38qr3THji8XiiYD7C68p1+V9b5/FoL/HAVOQHVxyRVBFF+lNd8acNQyJ1kLGwoVqzVVhNuzb5JDqnYwsj+tBUq+jWGrgl8U/Z3TNqAxZKtESx5sllNZ2Qglh1U75V3JHkI1xiwIjlFC1D7VQ+YdUDOgW++uhwEZv/ZSLF90tOkarsfcUragq2qecytb6XlEnlz3m6GWNhuvGysw7HldKaltEaEyPGE0niLVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CM18VG+3ChI6l/UaEgGON9VSnNgd+UkIPtn8IC9hJNs=;
 b=cKFodvCwA2CPKDOxQJ2O1sx1uXEE1auUZEnXdqVG/i7kTQnj8akTcGVF2U8kXA5veGOK/s4JDrL7XSKEJn27+nMFHnJfsc9q6rcTNKhcaJ4oPRBk9F7fpnt2xxGBM9zlrIN2riKcbSsBb0h+EIU8DOWJkLKwEcN5+yO1YuAJ6CI=
Received: from SJ0PR13CA0189.namprd13.prod.outlook.com (2603:10b6:a03:2c3::14)
 by DS7PR12MB9044.namprd12.prod.outlook.com (2603:10b6:8:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 02:39:41 +0000
Received: from MWH0EPF000C6192.namprd02.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::2f) by SJ0PR13CA0189.outlook.office365.com
 (2603:10b6:a03:2c3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Mon, 17
 Aug 2026 02:39:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6192.mail.protection.outlook.com (10.167.249.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Mon, 17 Aug 2026 02:39:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 16 Aug
 2026 21:39:39 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 16 Aug
 2026 21:39:38 -0500
Received: from xhdlc250058.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Sun, 16 Aug 2026 21:39:34 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>, <pranav.sanwal@amd.com>
Subject: [PATCH v5 0/2] pci: AMD: Add Versal2 CPM6 PCIe host controller support
Date: Mon, 17 Aug 2026 08:09:30 +0530
Message-ID: <20260817023932.1743100-1-sai.krishna.musham@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6192:EE_|DS7PR12MB9044:EE_
X-MS-Office365-Filtering-Correlation-Id: edd6ef9b-b3fe-4883-f669-08defc08c90d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|23010399003|7416014|36860700016|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	mcLg1GhyQiE+QepLm3UJF/TeZajI+X5rq5YazGIYfYhMrqGVHyhEC5Pr00ep3zRahraxm6VPvU5GcEGvhPQGhu4rjQNT4oGmhh1IGOwjbIb3/I1Q2G+f/2wFkO+qBDfs6XPjkftqoQ/ej6EfbYcJeFhadIQNRkfm0YoOHW+aaFZXqUb4eQTXRIFywiWRLOGO4/I/Mr0VQdLyvTJp9/bbvKzUF0XLiT0LW2Sdi31hC/gKKuEH08nNaYMB97nXPdlXOLDSBSmt0m89WEcjlwmbt4ZFGBNR0dwTTXajp67d9loGpkgzR6j6ByjPP4n+1jjJfm2fhOMQ2pUm227Qll6dSjJGfqHnHPm7yYXjYy0B2BZYHIc9BKDyMCP0+kPmFzbqgrSbitdwZ62VGOcQWcgPVfCPDsylLviHD5qgB51iTcmoRvgb5g5fIH+AI0bbG+32/PDTgoQEVAkOPWAtTh+8eBHByrt2tPFa54CowAIoRSwG3kPMMbWyLAAvDFtjD6S/HW5sjpgBXfw1vkbQ5kF2Ro/0rrPSU0EwHh1ySoCQBw3SO4BWJmiNmsy80IXkafQCClO2LZbRjouC2H9/7Yal82qNHlMjISdHkyy4Eb4lmE5vEFRhQblPDU7l6+NyWUBCGNZ5q2WrAYlAEl2zgGkersgTtcu1fyc9zsgCj/XmblOE7sh+oxDLA4jSlI3F6ZuV6dsdcjmK8b8iXvbo+Rb51Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(7416014)(36860700016)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fGRqE6csSlYqBs/Ed3xh4TkzwJ06MW6smc+5SkvaL+YVH+U28U9dTOju5QM5rd5UHxqm5JC0cW3j+RuvPZWZfTl0K+slpnGNauGJ1YOIR4A5ptMEsJdWypDYAE8xmIpNfP8xWHwUsFJgv+/SKMKevNGfHUs9G3BMvJo4AIvpBqpL4C4iy4zRmzYuCtwLuy2jMnaSetygY0L/f9Cx46HkXrI2rjYI4cJYvPh9dcyFY5S6AL1X6HzuJKwE98vHXX76J1pHucm9RppqvHdPW6CEBLZ1/v3RafSEyVn0OgnjsQ2E/QeBF/8YCCc8pgaGszBnxomAVSK9OJ5uUoK6ZvndMfzBPMU+CFub75y7YDOllRG8kOfythKWXqU9dPQjVx/kIzL7kPtR3Kl4RfLRsCbUYpQBICj8anFpMlWP0gy6QB0uHuO2p8MH7Lr4qw0WDdtR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 02:39:39.5454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edd6ef9b-b3fe-4883-f669-08defc08c90d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6192.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9044

Add support for the AMD Versal2 CPM6 PCIe host controller to the
AMD MDB PCIe driver.

Sai Krishna Musham (2):
  dt-bindings: PCI: amd-mdb: Add CPM6 support
  PCI: amd-mdb: Add CPM6 host controller support

 .../bindings/pci/amd,versal2-mdb-host.yaml    |  41 +-
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |   2 +
 drivers/pci/controller/dwc/pcie-amd-mdb.c     | 480 +++++++++++++++---
 3 files changed, 456 insertions(+), 67 deletions(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.44.4

