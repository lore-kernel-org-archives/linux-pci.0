Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011060.outbound.protection.outlook.com [40.107.208.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2A1284665;
	Sun,  8 Feb 2026 18:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770574207; cv=fail; b=nA0JGzCFOV98wxoi1kyWJPpSB4eka25+WyQd8nCQ8/5cnM66xBK7PwMqVuT2OAuTOMugBCkhfd9egpnNnsfkoW3x6NPEPeNDCrPFiv8rvxyHCNfXP4022kQM9D8mudc6e7r7qRZISFSFCE5S0n7jxP6coRal5kYT+j8SSwknhwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770574207; c=relaxed/simple;
	bh=4p/LamG3EHs+HV86tqxLhzukjMSTuUXqxu6OaZCd/0Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GElqlNK6MXxjHJoa3lDzXHP9ZtgyRJpMvw9SjMfKiTONrfL6RuJTsryRkSqMFguAhxWf+cMm318xXYDnsSWmft3+qpki6S2tqzCwXhyaCPehYmDDP57+bzmq3G6DN84uwXrxkGCs3wyDjQ3FXbcZ0WFsJn8BWgT/OukjHFkw4BA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UgKG+M/I; arc=fail smtp.client-ip=40.107.208.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UgKG+M/I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JbJ3hrSM1OguZRpMecbuusSQX3TyAEBmpgzT7MT43hT2u+ImPQcIPVtuH/lShMOG0lnnvQwfXtCN2J/a+inEHaIjeOlcGWEhODnNspwV3f4+x5FIJS+S/EYRSwUbVaS/6yj5L7I6IYFdfe6ocxwlLrySPGy6jgFw5+LaGSsQ6Cu5RULENNchJgdaPAG3rLLl3An3nLVgdxzlzZV/2iQVXvkLb4tPd3XX5YXd4TjIoOJ2FcGSxCsGVzbfX45rtwLeKYVF02zaSRmPMEYkvibU9ZWTUDRRWFALqxWlSLIY5lpv0DcMO0rYDfQk+Po2vPOU73rXZItatwS3c92jO78bZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+siqVM8SDTKc1nf4+kJujfzmww5mAhWEQf6h9e4nOU=;
 b=y8Q78HaoXlDJUCZ8JO6teqsVcqBjROdrP/JacHGHMHnCc8NPHt1prYlzsMnR59Cq6c/MzEEfJCUyGtIAxPyFd7CqZt5fo01tExQqCGEGzPqncV+1pt1mvz9DV4VqQ+eDJJXrxuJ2gPS7IvPKrmES0DrTbHUWH/rB3XSIu1A7xD3HD882szJgGILhxObJPYb1jBDruJ/uJhu75aKv5rdpY58QBa6hwZ1sQu69IjEEg+oHSWkST6e2U7OvrPZHjmn1bCvRSBiAqzpuNaTwtBbQkxlwCm7M5p2NI51C4MgYvjmWpVwpv7zv78PuXcIT0b6YlbJ0STFLiOgwge8JkColMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+siqVM8SDTKc1nf4+kJujfzmww5mAhWEQf6h9e4nOU=;
 b=UgKG+M/IUU9c0zzoIqL2dszkyr6UQ1VewcolVR2ef0beBlmLvp0MpaLQX4yMJ3h2eAPe0FwWtMapm1PGtozRKAwg5OMBLN/18HDz4Xw9UPLJHQyXxv0NA6fZH8RU/1oM8IDljxQWaSJ6Bub7hjyG/znGc2Xkijy5nU/zkzaax7o5mWQPCoHvb9nhqLbm4KF8L+kPdD0Wm+hykwG/GWS4Z0GyhLjhUwmkbBcsq2kxSBppB0sVl+Ark8y9Uq6Pwo5tuO9/sLVs5j0ROzppQ23YpxzjfplHfdG6MfVl1bJgmdYP3gKIRZRKmLpiIQa/c8hvyLiu9IzkTbXQ6o34fDjX9w==
Received: from SJ0PR03CA0097.namprd03.prod.outlook.com (2603:10b6:a03:333::12)
 by MN2PR12MB4343.namprd12.prod.outlook.com (2603:10b6:208:26f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sun, 8 Feb
 2026 18:10:02 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:333:cafe::cc) by SJ0PR03CA0097.outlook.office365.com
 (2603:10b6:a03:333::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Sun,
 8 Feb 2026 18:10:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 8 Feb 2026 18:10:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Feb
 2026 10:09:56 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 8 Feb 2026 10:09:51 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [V5,0/9] Enhancements to pcie-tegra194 driver
Date: Sun, 8 Feb 2026 23:39:27 +0530
Message-ID: <20260208180936.2026329-1-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|MN2PR12MB4343:EE_
X-MS-Office365-Filtering-Correlation-Id: eee6fc7f-f872-4353-7198-08de673d4795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PRH0TudA26fqUQ52BAH0HZ+VF6so2jJxAR3SBQruWlrmlceiNXUdF8x48oPe?=
 =?us-ascii?Q?22Yzvd9FW8zvpgkyXylCzr4stuvpKkIBCsxmET/ONo1IrLu9885cuKFgCgdQ?=
 =?us-ascii?Q?MPZoNSU2yRN7AsJjMiRB2rlA8QB81ec16xzHRLnWGkjnqdzAL1rxUw8O6/Fn?=
 =?us-ascii?Q?AwMXina4bi13NyfjUWnJxh96jlEV2E3tNQ8eO6fiLDxRZU4AAv86txaz1Rpb?=
 =?us-ascii?Q?MCJICn2OeJelv/QgQEszSZfVBTiBbJicobdJCacG5tZN2v3qEDbi+9vnhjo4?=
 =?us-ascii?Q?JDE4c7DqgJDyrPBnPo6sHyQz3L6Yg3NjjdUW422udttDf7gVddIDNOQBxT3u?=
 =?us-ascii?Q?wmK90qpDGSLSo/reAylP3EewNvLlT/lVj5DCr81UWSMKr5/qLwnNZgbwN/yV?=
 =?us-ascii?Q?qCLNqq/uRAe7H55YEq8ZyzW72eqDTWYXbiL8Ts9QhjhD1oc07OMyxeKaruje?=
 =?us-ascii?Q?Dxx2AkfJru5zhxbotJQOsDl9GIMij1G5EfsoTUIl4PRqLR8QU8nKsyUFOHUk?=
 =?us-ascii?Q?SZ4ZnKvDwJBO7Yu9BGxO0Uadtp3JUna0UtUm/yURc4071m8UDEtkqyBu8QOx?=
 =?us-ascii?Q?ZlYECeHALkCNyXBlpRqafblawC6CuUTluTqoO34KgxEcavIaXan/4CMBM8yK?=
 =?us-ascii?Q?++xonjxobA4m1onO7WrnnE8r+DgWVpXz1E2kDLJJoc2lNnIaiPCbzKqI9BP1?=
 =?us-ascii?Q?tnoDULIhO6zwZTjO+WIwAfr5RGYkO7qlfUGnP5a0uv21ccyGzzmj9ASayICf?=
 =?us-ascii?Q?/uZJFDz0yJ2HCCK4JE2vEJQ1WOpoPn+yi6FoDcgx4jXfFV2xKRa+r25lZph8?=
 =?us-ascii?Q?ll1iLIHzAyaheTLU7hugc7nAwFlkUqYtMSLzPCzANMwcveG8wNKFqtgfudUQ?=
 =?us-ascii?Q?MliHB+Vgxtck0doOezPSWnuf+6NSEd2JONl1Akvo77BuCoVm/QJRz2jnNSS6?=
 =?us-ascii?Q?KAfWxNAzv6DidheryO1oaPeoA6ZbCnhtGFbmGSLF+SGtFuM9ilHX2LagC+U4?=
 =?us-ascii?Q?KPNytP7zZtFFE9vQeNo5L3jyG74zfE2Z2MbZldmDZDeXSsdkrGFKQUhvdFJ3?=
 =?us-ascii?Q?JjpLM14eGASRfO8QUoXUUh0+F25KIpgRDKTZX54bygzf98Bv9uIhjgogokes?=
 =?us-ascii?Q?yam3tb2ONmWC3Ik6JqYz1HJjmcCD/Habz6KvOstqoxPFfCV+OoyQUM9c5JfW?=
 =?us-ascii?Q?qrMdy0kuW4RkTVitMO8ykKAV2nwl7aqLjMXMD8S/fwRl9Jbn5BKtqhe3v6Ll?=
 =?us-ascii?Q?zYtOlDxsWEOQSFnY15z9GjqSNPX1AS48oHidc/omVrFNHOLaDF/cD2duM/+x?=
 =?us-ascii?Q?/SiEdHpouG9QxBbq+FmcGPirt1aGbZwcyykkJjy3oONmdEt5n3TTcoaa4StY?=
 =?us-ascii?Q?ZfgA8TZ4GE39RBg8tQ6w3E4I6huF+rvSReBns9yRS9ESf+xu6JxIh2bl84Xh?=
 =?us-ascii?Q?6bcdl5MRu5m6xqKTe5lq1aJHoWq7LBjBUg3nKFr0nEIoqeARjk1dZE41vAUk?=
 =?us-ascii?Q?ZE4my1M6YqeB1YMyguTMymGsl+jtoHXE3VIHcCUzci/R5GhCxInMnY9MtpHg?=
 =?us-ascii?Q?w85hh5xTJBU0NlGj0M9RXmd2OCLrc4+saOYVaWaZCyNLgJvWQSMMSsXSTRBw?=
 =?us-ascii?Q?g6vsS5R3Zhd+wM09WIIrqu4P/VgZSXrKND8tGxKVDbCsdu8Cz31TVubQQxTG?=
 =?us-ascii?Q?lC0v0h3i7LJRmbpngP4N8fFptl8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	veoxiOj4mP2luTQKu1aX39vWiZYDvVrSPD5rdy5FaGx/JaFgLt1UP6YFk8ZE801x7WImEVKPPPLLgqB6qUbTRAkhQQ/URfeu/rxsYxHskfflKZ/SEs6qGyaAThbH1dwtSciQd6tKCITpawtQll2fvspXJ/U8l7GaZ8/0KCNIb5/yVkxP79zR97Dc2BaM5hILrsz6DZaV4eGT3D0IsvSMx/gs5ln1vuoKnm0FDmyXnt4bMalvCfnSkBCYn8x6OOLiRzPojVtMMlJGX0o3/vF8CWElHbCsjOt5w3rxzbEiR7dvkpMIF1UUgcZ+uyaJjCQmHJEd87CvcPzab067PfIJLZ2TBlfJjwb1eQfXoVNmNgldCQN50BwFPexh3YPr69pMEsy1l1TN8e23LpdKUvV+dNYFTqAWipR5YbkXathf3cNCKM2u+o9n1M4ueILfhLvb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 18:10:02.3389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eee6fc7f-f872-4353-7198-08de673d4795
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4343

This series[1] was originally posted by Vidya Sagar, and I have rebased
it onto 6.19.0-rc6-next. I addressed review comments and split this into
two series, one for fixes and the other is for enhancements(current).
I verified these patches on Jetson AGX Orin(Tegra234 SoC).

Disabling L1SS capability based on support-clkreq device tree property
is moved to common DWC driver, so I reworked below patch to disable
just L1.2 capability on Tegra234 SoC.
 - PCI: tegra194: Disable L1.2 capability of Tegra234 EP

I added below new patch to tune the ASPM parameters, commit message of the
patch has the details on the bug and fix.
 - PCI: tegra194: Add ASPM L1 entrance latency config

I added more context in the commit message for below patch based on review
comment in V3.
 - PCI: tegra194: Remove IRQF_ONESHOT flag during Endpoint interrupt registration

Rest of the patches are same as the original V3 series, just rebased them on
6.19.0-rc6-next.

Verification details.
 - I verified both Root port and Endpoint mode controllers on Tegra234 SoC.
 - Basic sanity Link up, configuration space access and BAR access are verified.
 - I verified that ASPM L1.2 capability is disabled for Endpoint mode.
 - I verified suspend to RAM tests with Endpoint mode.

[1] https://patchwork.kernel.org/project/linux-pci/patch/20221013183854.21087-1-vidyas@nvidia.com/

Manikanta Maddireddy (1):
  PCI: tegra194: Add ASPM L1 entrance latency config

Vidya Sagar (8):
  PCI: tegra194: Drive CLKREQ signal low explicitly
  PCI: tegra194: Calibrate P2U for endpoint mode
  PCI: tegra194: Remove IRQF_ONESHOT flag during Endpoint interrupt
    registration
  PCI: tegra194: Enable DMA interrupt
  PCI: tegra194: Enable hardware hot reset mode in Endpoint
  PCI: tegra194: Disable L1.2 capability of Tegra234 EP
  dt-bindings: PCI: tegra194: Add monitor clock support
  PCI: tegra194: Add core monitor clock support

 .../bindings/pci/nvidia,tegra194-pcie-ep.yaml |  6 +-
 .../bindings/pci/nvidia,tegra194-pcie.yaml    |  6 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    | 67 ++++++++++++++++++-
 3 files changed, 76 insertions(+), 3 deletions(-)

-- 
2.34.1

