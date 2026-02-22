Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7395213D891;
	Sun, 22 Feb 2026 19:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771788941; cv=fail; b=KGTWIvdyY3IooWi1/1avyfyG4s530pqw9tlqyT3nI2ph4JlI1ARCYKnnc7VDjMiZyCHKPdNz4wBPYEgVePH94v75zgx/arZxojg+1aftTINxLXwIjzueZHh9DAsW9ES90nkhT+wUxluPG3l0SFd0HxVhCEWuAcMZ5BbtwHQxVQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771788941; c=relaxed/simple;
	bh=Xj8KStkGtWzdJR5cS0g6ow7GNZBp+x3REKhZklIR6SU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XXlCMIa5CbixvDenzPYbWvdx/zoosv4M7QsBJnJ15CZNTQsOSa/LwfzBe8spuH+rGrSQhA68asqSHpS9kINfpwsz5jbBh/5YVOCxIysmh5tPPzZiThCAKXmQ7voaId6b+iq0S/G7DOrUbuMsEtt9eQRL077ze5qPL1kHe0QsRs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PE5fwfKw; arc=fail smtp.client-ip=40.107.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PE5fwfKw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJOvp8Bl8N3X3+jHpbbcJ8gzniF6nhnVmFgBpVMUvESCuZLpr70dtWD855nm1doHt2lGNaaQRg40Ek5VPnjdesoWWjP3ki/vL8fbo+v3LIEjsYsly+thSCaVQxkXiGtTQF3vfaDkjwW8awgMALk+LVMZQHK7JPLKv/chngd5gu0rDP1Vwynvdj23C8AuZVb5/HX3PEMaPQW6hEcKayY3/qB4sZurY2UXs8Doy4JgGrIHDxSl2f37PbhxYZqlxs7NM/PVpJiXbZuKld+AyTyIJ0ldsu/ldt7jwgxhLa8m8VIem0gv8k37XqgMGt9AMpWTMboJK3X4RdqylAbxA2eDsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yb0C/3zrWIXc3RfPME6oltQJDwqYe65IsBM6uZBih/g=;
 b=BEtpCzvpjmwCvHgc5ZdIvxPSq7buJpCeTqv/2vvln1S+GGkE+yCMho4KBIPjT5FhdKB+sWA9BlBi/nfjUxbLCZx8/savhPsqHMBKx26QbcRQCuya0Zk0dWvQeUW+JKSyuSe/aGGx8IGXin2yq4KRr0E+8whhkMQJvsh3U5J7C2l0OqkvL2TlEp5shpdKetQeDPVPE8nGkkzuvXUBTKHFgGfjtdSM9ata/23U/fIzgHD/jDUXU/o+0Kv6gVrDBa+sG+lb2MmxigxD7nBJZK6JlDVrVqcaE5xVes0bgmlbofENcLzmRiyQDWCPX3aO2K9XcAa3Y/rwHdPWJ35RK40rbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yb0C/3zrWIXc3RfPME6oltQJDwqYe65IsBM6uZBih/g=;
 b=PE5fwfKwO/8FkI0fTi8yefp6feVTqDJaMoDx5QRWpAYw975lLhuNArOaCuO4luK6vvpO0QkghRO3sfRo46gKXUU8atuOPUEjvhv083lwlvZeyIdoqOC7SOCeheA6qlUS8FQ2nZWIsk9OReI4UM7e9SnYAz1teqVLNRzOhRD1DsNU3KazBz0vYAGMtK69WGIOlvc5zCcQQW3N+atdjlBkl/KqOz3RLfNnYTc1q9X5wLqDNoBBEnYKN0VQY+cP1yEjHsw5yEx/ptmrIeZ9EkfrsZ5ydq0HbqWuGqf2rg3nrS4Yz8R2DXlsToT/dqzgpINzSSES8Bbnj0Bs4ONfmtt+HA==
Received: from SJ0PR03CA0376.namprd03.prod.outlook.com (2603:10b6:a03:3a1::21)
 by IA0PPF6E99B1BC1.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Sun, 22 Feb
 2026 19:35:35 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::8e) by SJ0PR03CA0376.outlook.office365.com
 (2603:10b6:a03:3a1::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Sun,
 22 Feb 2026 19:35:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Sun, 22 Feb 2026 19:35:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 22 Feb
 2026 11:35:25 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 22 Feb 2026 11:35:18 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
	<Frank.Li@nxp.com>, <den@valinux.co.jp>, <hongxing.zhu@nxp.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 0/4] PCI: endpoint: Add Tegra194/234 BAR layout and pci_endpoint_test support
Date: Mon, 23 Feb 2026 01:04:52 +0530
Message-ID: <20260222193456.2460963-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|IA0PPF6E99B1BC1:EE_
X-MS-Office365-Filtering-Correlation-Id: 47e162f2-479a-4fbd-aa2f-08de72498c70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lx272b+VFqOQTIok24F/gzO0lsFblEZdmVzN/5RNpuZ43aum1ppuUpaI8fg9?=
 =?us-ascii?Q?uyvXY7qPALzxm4/kmF3bNhs0pHgWchrafPfIJ2S2CU6Cq18dKMMliabMChsN?=
 =?us-ascii?Q?suVNNnLWZBDVkKwotg/2ZZFgZnnu8Sm+Z1zLOFxsXOIl3fHuCTICwAYbzGkl?=
 =?us-ascii?Q?KL1Gr1stV2xqLL0t5EEL2rSDZiN/mC8+cQAwcqI0YeJ6+zP6ZGxEp6aAprPk?=
 =?us-ascii?Q?fjF64eYmZ31gGPwBkA3jNViQUGyihaXVujQaWDyzimaVbopAjYFScS23jgRa?=
 =?us-ascii?Q?YZwJbWYnjR/Q7hRr+oiQqOzIqpKwzYvXx2cAdB7KbtqVUDJGzwquxP4sx4gk?=
 =?us-ascii?Q?0vLi7DGUNcrY9Lk3i2TBSodjP+kyqFKBUYkGu5CzlWsGnzbDdJ13/xTHYOBW?=
 =?us-ascii?Q?PDxM35j0k0I38raBp2hi/sFfqQRiv9Uz1rTDddK+SydYxXXzD+O9PTQlLI7Q?=
 =?us-ascii?Q?45gBRpOMWHJDVIY4o4vd1uLMnGOyHZrouYfi0ENmxNA2GrU12pWv6G7x0nqS?=
 =?us-ascii?Q?KRX8VX5xwvvNF1+TdQD//TJf/KnlW6q88dpN1brgndUiolBDdzDe4wzlSjuk?=
 =?us-ascii?Q?HkpaaYfSoBr/0E+PhY0JSl08ypf682DJSN6KegUbKfa4mhiQL6X5HXj0+HbN?=
 =?us-ascii?Q?DwxeKwsz/XFjYeQCZy8+YWB7THcdUgRvCmsAxt9WnbzFv8DmYS/lnReQEC9p?=
 =?us-ascii?Q?ly0MplJ7bgWhbUlVorDMREtgkCqn4UwyuVYXsndsvbjzPneSnKIfunMwLgdt?=
 =?us-ascii?Q?n2uwEbrEN/30Mc7cpAzZoonDOkci2U4jPQHqmF9N6VRMhjrSw0BpaN2+TIDC?=
 =?us-ascii?Q?/0yCs+oRWvGTNPozJUpM7tGP9w0kDIzRu0b7LfFkIBsk/TJvTiZNMhVh1Yyq?=
 =?us-ascii?Q?PWuoK3Q2fZTckeRh6sqQDBVd9HzrSz9zPG2B0IsPhtImOvJ1vTe5vFMycF5y?=
 =?us-ascii?Q?RuXfLEH6Ja7cfB+WUHQAEUbnL+xY9/4MhAggetPshSh5LlJHJPZ6WwQ98f4t?=
 =?us-ascii?Q?vyRvJTJKAIjEBvITISjFzEdj7pRnuXSx8rnHyPY7WVrq0TAV37UKXJ3R8KnM?=
 =?us-ascii?Q?8tQ7g3yn6Gb45vropJEnAWy0bwgQp/gcqOfylTmsI3p5yXisYjaEGrDY4C3D?=
 =?us-ascii?Q?jPl4ggNb0y1GgcOFj5RyXGhS9vw4oKrJrz+HTF2Ag/+FuqbSX9mRjhKTDc6Z?=
 =?us-ascii?Q?jYUt+5bL+z7VyRpBgWwgO6SHiTAV7XOnkW3PsxwsTURkKyUsATk72rcHeRzT?=
 =?us-ascii?Q?pCofoqRI2SVV1jYmau4avAMrsTRBfwOFn1YGors0iirEcsxS2kreDL2FyV1p?=
 =?us-ascii?Q?2UjcrUYBwNyhd8uRLu/3tqwUjScsf127KU1nepW2hMgsU0Ep0UHbvy/YmrzE?=
 =?us-ascii?Q?uMJPVkQwggQFJsHYZybuA3nbB0ZVGpGzAapoIBzpWZsZYMbcDP9X9GAijiuM?=
 =?us-ascii?Q?Vn9WzogG8e50gRG8FLV/er362oNZAcBSJ5zgl8ifWk4StmLkm6E99sHZKUG+?=
 =?us-ascii?Q?1uk4MOQuqUUlk/x8LZjftvPZ5DtcFHXzhLBQQGzQJ95EIh4h2qqzEdFDala7?=
 =?us-ascii?Q?aeMsTfjfZihsZtrCa3oie/dbpf1UH1d/QEfznL9ClosiHkZXgNpoRqtpE6Vg?=
 =?us-ascii?Q?XM6Tuk9ZexKOqgPwuCeWH+RbPME7K6DmnOEIYFji651fDPEFwrp80ksHPsV5?=
 =?us-ascii?Q?Htvme5W/BpLYhn05blPGLaVNSio=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(921020)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	V7Golv0K9sivOFj2JKf8Ki6hy/NanTbBoR0Iv9KfEYzq7OMVRnCWJWhwXmJDR3eyruyeo4Kba+9/5bWC4wZpdvVP5jYNTiV5Vl8/S5t7Pu+MoSHj3YDJX1H21BOaDJPk9mdP1EU5RmrDwVg0Hk2BgDIqYjiKWM4vPmugLqqK5W5vPBtuDhotkcwTIgVvYGIT36Vxt5W5BkBuAvMRTzfSif0nv808fjnB4kaf0k+MjvbaInxS2IgLe7LTEhUZuqyPHnL0KRPseKSyrWGC4r96zbfEAXQ2nRzETXKKUSrtDSmKPyMDiEpgEjv+/WrjafI0WRx11lEKT7Qh1W2GKTCIlWtiemUmJl8c2Lnsy890y6gTsXPjp3xU209GmN0Rb5dCKjwUWQwJaUn70k3Dc8EHVKyXwcRNtr3a+TaP2m2eVyl+6dXwEBAI/4i8Jyw5KPR8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2026 19:35:34.7095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e162f2-479a-4fbd-aa2f-08de72498c70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF6E99B1BC1

This series is on top of https://lore.kernel.org/linux-pci/20260217212707.2450423-11-cassel@kernel.org/T/#u

This series wires up Tegra194 and Tegra234 PCI endpoint controllers to the
shared PCI endpoint and test infrastructure:

1. Add a new reserved-region type for MSI-X (Table and PBA) so EPC drivers
   can describe hardware-owned MSI-X regions behind a BAR_RESERVED BAR.

2. Make Tegra194 BAR0 programmable and drop the 1MB fixed size so EPF
   drivers can use it with arbitrary sizes via the existing DBI2 BAR
   programmable path.

3. Expose Tegra194 BAR2 (MSI-X) and BAR4 (DMA) as 64-bit BAR_RESERVED with
   the appropriate reserved subregions (MSI-X 128KB, DMA 4KB), keeping
   CONSECUTIVE_BAR_TEST working while allowing the host to use these BARs.

4. Add Tegra194 and Tegra234 to the pci_endpoint_test device table so the
   endpoint test driver can bind and run on these controllers.

Tested with pci_endpoint_test on Tegra194/Tegra234 endpoint.

./pci_endpoint_test -f pci_ep_bar -f pci_ep_basic -v memcpy -T COPY_TEST -V dma
TAP version 13
1..13
# Starting 13 tests from 8 test cases.
#  RUN           pci_ep_bar.BAR0.BAR_TEST ...
#            OK  pci_ep_bar.BAR0.BAR_TEST
ok 1 pci_ep_bar.BAR0.BAR_TEST
#  RUN           pci_ep_bar.BAR1.BAR_TEST ...
#      SKIP      BAR is disabled
#            OK  pci_ep_bar.BAR1.BAR_TEST
ok 2 pci_ep_bar.BAR1.BAR_TEST # SKIP BAR is disabled
#  RUN           pci_ep_bar.BAR2.BAR_TEST ...
#      SKIP      BAR is reserved
#            OK  pci_ep_bar.BAR2.BAR_TEST
ok 3 pci_ep_bar.BAR2.BAR_TEST # SKIP BAR is reserved
#  RUN           pci_ep_bar.BAR3.BAR_TEST ...
#      SKIP      BAR is disabled
#            OK  pci_ep_bar.BAR3.BAR_TEST
ok 4 pci_ep_bar.BAR3.BAR_TEST # SKIP BAR is disabled
#  RUN           pci_ep_bar.BAR4.BAR_TEST ...
#      SKIP      BAR is reserved
#            OK  pci_ep_bar.BAR4.BAR_TEST
ok 5 pci_ep_bar.BAR4.BAR_TEST # SKIP BAR is reserved
#  RUN           pci_ep_bar.BAR5.BAR_TEST ...
#      SKIP      BAR is disabled
#            OK  pci_ep_bar.BAR5.BAR_TEST
ok 6 pci_ep_bar.BAR5.BAR_TEST # SKIP BAR is disabled
#  RUN           pci_ep_basic.CONSECUTIVE_BAR_TEST ...
#            OK  pci_ep_basic.CONSECUTIVE_BAR_TEST
ok 7 pci_ep_basic.CONSECUTIVE_BAR_TEST
#  RUN           pci_ep_basic.LEGACY_IRQ_TEST ...
#            OK  pci_ep_basic.LEGACY_IRQ_TEST
ok 8 pci_ep_basic.LEGACY_IRQ_TEST
#  RUN           pci_ep_basic.MSI_TEST ...
#      SKIP      MSI17 is disabled
#            OK  pci_ep_basic.MSI_TEST
ok 9 pci_ep_basic.MSI_TEST # SKIP MSI17 is disabled
#  RUN           pci_ep_basic.MSIX_TEST ...
# pci_endpoint_test.c:146:MSIX_TEST:Expected 0 (0) == ret (-5)
# pci_endpoint_test.c:146:MSIX_TEST:Test failed for MSI-X1
# pci_endpoint_test.c:146:MSIX_TEST:Expected 0 (0) == ret (-5)
# pci_endpoint_test.c:146:MSIX_TEST:Test failed for MSI-X2
# pci_endpoint_test.c:146:MSIX_TEST:Expected 0 (0) == ret (-5)
# pci_endpoint_test.c:146:MSIX_TEST:Test failed for MSI-X3
# pci_endpoint_test.c:146:MSIX_TEST:Expected 0 (0) == ret (-5)
# pci_endpoint_test.c:146:MSIX_TEST:Test failed for MSI-X4
# pci_endpoint_test.c:146:MSIX_TEST:Expected 0 (0) == ret (-5)
# pci_endpoint_test.c:146:MSIX_TEST:Test failed for MSI-X5
# pci_endpoint_test.c:146:MSIX_TEST:Expected 0 (0) == ret (-5)
# pci_endpoint_test.c:146:MSIX_TEST:Test failed for MSI-X6
# pci_endpoint_test.c:146:MSIX_TEST:Expected 0 (0) == ret (-5)
# pci_endpoint_test.c:146:MSIX_TEST:Test failed for MSI-X7
# pci_endpoint_test.c:146:MSIX_TEST:Expected 0 (0) == ret (-5)
# pci_endpoint_test.c:146:MSIX_TEST:Test failed for MSI-X8
#      SKIP      MSI-X9 is disabled
#            OK  pci_ep_basic.MSIX_TEST
ok 10 pci_ep_basic.MSIX_TEST # SKIP MSI-X9 is disabled
#  RUN           pci_ep_data_transfer.memcpy.READ_TEST ...
#            OK  pci_ep_data_transfer.memcpy.READ_TEST
ok 11 pci_ep_data_transfer.memcpy.READ_TEST
#  RUN           pci_ep_data_transfer.memcpy.WRITE_TEST ...
#            OK  pci_ep_data_transfer.memcpy.WRITE_TEST
ok 12 pci_ep_data_transfer.memcpy.WRITE_TEST
#  RUN           pci_ep_data_transfer.memcpy.COPY_TEST ...
#            OK  pci_ep_data_transfer.memcpy.COPY_TEST
ok 13 pci_ep_data_transfer.memcpy.COPY_TEST
# PASSED: 13 / 13 tests passed.
# 7 skipped test(s) detected. Consider enabling relevant config options to improve coverage.
# Totals: pass:6 fail:0 xfail:0 xpass:0 skip:7 error:0

lspci output displays all three BARs with this series,

0005:01:00.0 Unassigned class [ff00]: NVIDIA Corporation Device 229b
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 165
        IOMMU group: 13
        Region 0: Memory at 2b28001000 (64-bit, non-prefetchable) [size=256]
        Region 2: Memory at 2800000000 (64-bit, prefetchable) [size=128K]
        Region 4: Memory at 2b28000000 (64-bit, non-prefetchable) [size=4K]

Manikanta Maddireddy (4):
  PCI: endpoint: Add reserved region type for MSI-X Table and PBA
  PCI: tegra194: Make BAR0 programmable and remove 1MB size limit
  PCI: tegra194: Expose BAR2 (MSI-X) and BAR4 (DMA) as 64-bit
    BAR_RESERVED
  misc: pci_endpoint_test: Add Tegra194 and Tegra234 device table
    entries

 drivers/misc/pci_endpoint_test.c           | 13 +++++++
 drivers/pci/controller/dwc/pcie-tegra194.c | 40 ++++++++++++++++++----
 include/linux/pci-epc.h                    |  2 ++
 3 files changed, 49 insertions(+), 6 deletions(-)

-- 
2.34.1

