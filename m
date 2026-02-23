Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010062.outbound.protection.outlook.com [52.101.201.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4070366DD7;
	Mon, 23 Feb 2026 18:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872169; cv=fail; b=h+/DEUn9xdI5ES4xLE4XjeTkvi4zOCzk4UiIElVU++VxG2+HMHUvMn1DACC3ANp+EohzUjlCaZM0J/qKAmB4UrdqAoE5OGpIJSYtaDqLtgw6h15Ki0DhC3HqbQa/2UUIdsgyn79oK9crqFVp479O3319+6wdh/gtbgGSmZ+P3r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872169; c=relaxed/simple;
	bh=QrrqDp+kOOB4V3TuVoUD46fUe1gO7SFh3gSggXBTv+c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ev7Q0PhAFm80Vi5ZJInqhq0mc78PwA9gnNA4HQ5oIaoc8LTbghOiNEPgFwJRmQIJQrAdGFqXTDIxnMlj3xC6OnRo4Fji8HSKB9ULI95uMb8gFSQBetaHVmF3h1197dj2uv/CnZWcvnsJaVQs4jXNuDVX3WYK7F7vc73C2nmCvt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gBymgXhm; arc=fail smtp.client-ip=52.101.201.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gBymgXhm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=om9g/c71zx7UT1boXLFMg4iF4YAWYX07WuP4w9Ya+ePqUmS4iLOiOmPf6nLU02RyvWsIEDGV2NcfK2nvs1jAxFvDEm9UfBdeBqupltWY3dCql7qZ/jOwq/olstFL0AHgT6yhP4+kNRed4FJMMZGLn9aHwQ0AK3J2eKKH1VtJNwLsJ1JBr/NDzTk13nDw49DbAjKguYA2s1HmbkfuDJVlP8GHRW0nIwzZ0Yc+tD4YQ8ffcXoGb0qLnO+tgLDlEdfgdp1qA0kmKLbuk0lsUZO51K2XqKEmWTgdlZo6jkc2hZKwRme019axlK7gjGnNC7/ucm7jKH4XpoFlqlXd9tTBnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYSwwH8Cdx2n6Tl9HzDzvdaGqsfOdcWQZpIjevraGM0=;
 b=o7GZz5AaHdxiD1IRf1iZPJhfr9Q4hoI/4Av7D6oEspzWGdiBDZdB3emWi6F6y55lMKzl7JNA6NIbB0HbPJ6aNlEqbHU9kB2HDMEstdwqYn25hJna73q5NoCw1oACmBFMfx0a8DfxFn4dpFy0vz+112whXEZvLr03f923cbdTV4Jw9MsIvSvsdjgag4djrlbHqD8I9l+5UjNfk49JJCde6Eql2qoxOBsyvwVfMbE7KzWHAiw6+gqM948Fic/iMVHM74eVYCIU8tRKzhZ7EH4nX1JV5bPPFfhQ1kv4hM55XG0SME8/vBSQUcNj5ab+CQ4eAMKJCFx4mcdC4pf6m/+xgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYSwwH8Cdx2n6Tl9HzDzvdaGqsfOdcWQZpIjevraGM0=;
 b=gBymgXhm23wx6W2lGGnDN8Lwq0t1UFi2WKALQkHYqi1pO21upUg9k5rYa/wcqGy5Jhll+m7fgDMqiA84pOsZRCnq7+5dF/MQNUqGwFYB0mCTrCZH8e/9hfnqk2iwY3c0GL2cNQPmZyO1xBS7sH9Unfxk9efOR4IMhEdOT+eYfIOLsmq2mfqPrjFC8xY79jGbrj1mYfeDkWXBRzD8jb/K5UmerouiqS+DtnGSL5Z09NcZ5yGPnJG3xwZuEfGpgg6igJdpeFIauCgBedYlL/Ec81ZUl42DgkeVTlUp3orMvaEN1K4spqvXgdfS3KnQKm8x0kIqLiaROULoCA1jTNFfbw==
Received: from MN2PR03CA0023.namprd03.prod.outlook.com (2603:10b6:208:23a::28)
 by SJ5PPF4C62B9E70.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::991) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 23 Feb
 2026 18:42:37 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::59) by MN2PR03CA0023.outlook.office365.com
 (2603:10b6:208:23a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 18:42:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 18:42:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 10:42:18 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Feb 2026 10:42:11 -0800
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
Subject: [PATCH v6 00/13] Fixes to pcie-tegra194 driver
Date: Tue, 24 Feb 2026 00:11:38 +0530
Message-ID: <20260223184151.3083221-1-mmaddireddy@nvidia.com>
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
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|SJ5PPF4C62B9E70:EE_
X-MS-Office365-Filtering-Correlation-Id: 30b6d3f3-c19c-4ba6-e018-08de730b50fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ql864/u6tTyNlVOaDH5FvPq+tUiUY8U5+0B9ZOLNcXf5MpWMxKqsAErZR868?=
 =?us-ascii?Q?xdp3PsZBvmVh2bP8uVMMAO3KMoNxibWOJr/gpyyr7idiD18e5rLpYDTu9pFC?=
 =?us-ascii?Q?YXqxvmSTQuSr2MBQV9/Z6Q9ncCrkTcUYPJA4YLh0Swj0FjFsIQcQ5moNFKgz?=
 =?us-ascii?Q?VonXgveLVqk1azSF1n0WxF4OCxapZT5DXD7zIqrYyNNvk87BYCvHsBebpn01?=
 =?us-ascii?Q?kXRyza7G1F4dFsMz1+4RB/1ZXGc3HIj/UqV9zVgoHtLSRYCqiXE1njuoqjmw?=
 =?us-ascii?Q?2Kf9Ss1cxZc9AOhGYhTdWQrSXMkSx4trxcH9eP5US1/IEz1TuwKRupysPzx+?=
 =?us-ascii?Q?JjCeAWOGzqWQOo3+PL3/nIdoksf6H//i3BVl9M1vzrp+qKpJcM8QlsFln10+?=
 =?us-ascii?Q?3vrdRJv7DtYLAJ+s7uBuqHLG6MACs/ZjTvLq0kjYlGRgJrjYL5XYT/idtYQQ?=
 =?us-ascii?Q?JtqMREx0cArC23VPqKBAT6iRwIgCd7CY4j/CNl/DZzzzeo9cwgFmjgmHjwEE?=
 =?us-ascii?Q?W/X9O7In2hvx562eZG6ymOwcz27vW09RwORUYtS/FaqhiYleHlWIFojFHcge?=
 =?us-ascii?Q?E0w1G/TV62kaoVoh80Y+JkATJxJYe+bwgLSZT6/vAZJc2kOs7l3P1Ng467pP?=
 =?us-ascii?Q?0M0dYpYUKYnlvqawZJ8uC6SnCku8r+Ojc1SbaRM2Bi8SvaWwA2mnurIaa40G?=
 =?us-ascii?Q?E5k8R6B5Bm84zQZIHwC3Gm1i+9SoM09wakNZvUUcqnLidlt/+C+mjexCw8rF?=
 =?us-ascii?Q?heYNoEBoftZQ40J68d8Wzk0py+0nxYhcPvl8zT1hTP2LPlyPeAJminFfFzhL?=
 =?us-ascii?Q?xF/84hkCcyAQSJoTrcZcRES4mynaljiAFMphWib13VgtB8iVHlbUX7rQZzW1?=
 =?us-ascii?Q?VPlRMeJILxJHa4RTbsuv4KrK5aRXJ6sxyllYODrdyff0czF/dJxEgUtzabCP?=
 =?us-ascii?Q?CxlsmBw4mBXTonQSex2/3ua0TRM8MY04/Lh98XATSGPZ+gbvmV25/X2M7XlM?=
 =?us-ascii?Q?lOMXEj41J68+dJCyJrmkG+Ut92Aq7ZNsrSJTwuN3drVCHCimxH9wfMC5uRi6?=
 =?us-ascii?Q?PwdCy+zlOYZGO8CQzHkHupLgx3iWaamsqWocA7b0dWeYK3s6ZcQpLSkMq1xK?=
 =?us-ascii?Q?WZtRu922bylrR0EPQDDhCForyNmUIV19HGxJxQaBBocnQZgIN/7q3HL2Nx9j?=
 =?us-ascii?Q?SPz7ZCxVgbOD7lokvZBUP3i1ZwOL0922pPj+WJ1j7QnynbYFtjoTixnJ1Ddu?=
 =?us-ascii?Q?nRoMI3t5cZl++75O4ulXeYPHlN2tCMaq1HCgxiONPDl4iRtNX137lUUMMO/R?=
 =?us-ascii?Q?i3rgjRZ3mtpVW8THgpRq67y9zku24NWDezwMcuYSOKDHAuTORKBbPAJb5Cec?=
 =?us-ascii?Q?mrwyC5lHhq7P09Vx/AaVdZQ8rFCbR1xgEFxGyyiLVfsUtkA+TQuH9Ox48fx5?=
 =?us-ascii?Q?L4kWKQFA4OZcAPWKACWmd55t6c4ei5dngXx5Z1rYXGFhmhDgLDAAkq8luj7x?=
 =?us-ascii?Q?3Tb3lyZ8myiD4herwhoXse/l1PHA1g7sn4IjeCYpBxVjclRWD32ArI5dTZ5o?=
 =?us-ascii?Q?aztai5beILuRkKscos9ZxwQ0jAlMZGcSFH/GFqHHGVl0e1qZC/Oq7ekDsBih?=
 =?us-ascii?Q?jJqHS21DYpzAmnFbrDDJCFU5CmdxqPquJxYkPu/189l9U9miknGHS37W22X3?=
 =?us-ascii?Q?/u2XxYShEnGIcwgP7rsNah+snwk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cFh66wruBLHw//0PlVwD0eSIPDOSFmTA5eqalmoHGfvgOZqbmqBe8amG1YlsdsT0N4IZy8upAIm4ZacjKGFS4fT8ClxpNlVFP6MDXpEI3D8rK8aoc+qZ3C8FO5pnDrg3cgpKY4g+Mb0iQM98gl7We1wx8sALiuP+wfyICDUKyH46gjpP+4zQ6VwD/1ttpJlPLK8VJchk4znELiO+0PFVwP9F1QgivuJUNYyDidpAw81Fa2rUm4Gj+Bvi1ulPBiM5aFuLSGfnxWwroTBglajO1rNMaGx3CNmFkj+fZX09Ye5vtmhS3JC5wtX8+KKokoedxouqAiUES9pQCPTDDYf3HAOOI7ArbDVGmOc7Q3VOJyA1mzALrsjYqF3QfYzOJHRCrAjQfUXahKf5bKz681wvWP04QPpi8IopZsUY0CEfYTElb0+JzL81DTq6SQAmxUkp
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 18:42:37.1739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b6d3f3-c19c-4ba6-e018-08de730b50fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4C62B9E70

This series[1] was originally posted by Vidya Sagar, and I have rebased
it onto 6.19.0-rc6-next. I addressed review comments and split this into
two series, one for fixes(current) and the other is for enhancements.
I verified these patches on Jetson AGX Orin(Tegra234 SoC).

I added below four new patches to fix bugs, commit message of each
patch has the details on the bug and fix.
 - PCI: tegra194: Use HW version number
 - PCI: tegra194: Fix CBB timeout caused by DBI access before core power-on
 - PCI: tegra194: Disable PERST IRQ only in Endpoint mode

Rest of the patches are same as the original V3 series, just rebased them on
6.19.0-rc6-next.

I fixed the missing PATCH prefix in the subject in V6 and also reordered the
patches with regard to fixes tag.

Verification details.
 - I verified both Root port and Endpoint mode controllers on Tegra234 SoC.
 - Basic sanity Link up, configuration space access and BAR access are verified.
 - I verified that ASPM L1.2 capability is disabled for Endpoint mode.
 - I verified suspend to RAM tests with Endpoint mode.

[1] https://patchwork.kernel.org/project/linux-pci/patch/20221013183854.21087-1-vidyas@nvidia.com/

Manikanta Maddireddy (3):
  PCI: tegra194: Disable PERST IRQ only in Endpoint mode
  PCI: tegra194: Use HW version number
  PCI: tegra194: Fix CBB timeout caused by DBI access before core
    power-on

Vidya Sagar (10):
  PCI: tegra194: Fix polling delay for L2 state
  PCI: tegra194: Refactor LTSSM state polling on surprise down
  PCI: tegra194: Don't force the device into the D0 state before L2
  PCI: tegra194: Use devm_gpiod_get_optional() to parse
    "nvidia,refclk-select"
  PCI: tegra194: Disable direct speed change for EP
  PCI: tegra194: Set LTR message request before PCIe link up
  PCI: tegra194: Apply pinctrl settings for both PCIe RP and EP
  PCI: tegra194: Allow system suspend when the Endpoint link is not up
  PCI: tegra194: Free up EP resources during remove()
  PCI: tegra194: Free resources during controller deinitialization

 drivers/pci/controller/dwc/pcie-designware.c |   2 +-
 drivers/pci/controller/dwc/pcie-designware.h |   2 +
 drivers/pci/controller/dwc/pcie-tegra194.c   | 191 +++++++++----------
 3 files changed, 95 insertions(+), 100 deletions(-)

-- 
2.34.1

