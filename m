Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012049.outbound.protection.outlook.com [52.101.43.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098E4284665;
	Sun,  8 Feb 2026 18:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770574106; cv=fail; b=ARxgc6SZUy0UrioxXaTV33jt/kbOwGqzjEpMwDTL3Gkkpr+2WBu47NT3/wkWatKBRhgDOe9X1pizEis8VVovVzUmZu0neUWE54yayx1SeHsmS7VxSbiB2oc2qHrGpmzLUKwDlLSZiZ5zmRC2Vs2pHFGPUZ9IPzndN5bi/n25nsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770574106; c=relaxed/simple;
	bh=WM7TFR3PU7sMXkmnp6ZiuKbCFkzCA4tkRI0TfMiTHsM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K5MJMCOToe4gQKLex18PN3SpUap0TbZ6OFZg9GEdno0RzM8O8PiaTXCou7SJX2BeHjYS35/raapmgBdSZxI1ggfOZv66CLWI9BHTLomG0XdEKJE2a3Qatf2p32KnaLgHcJEC0zsr6ebKMnv4QhdQbWBixpVdRM+FROc5/eutiaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bJbdAoaB; arc=fail smtp.client-ip=52.101.43.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bJbdAoaB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MVVh54eqCiC39m/Kjvwb+r3VpPGVqZthulkr1QI2DDUWNF/PrSqCx92shWt/1guGEdSr9TcZmRoLeozS63zmHYExFCy2W8w1Qj/OW1ciK2t467d8j4kY71ah3I9YdEOE5ucjntpj4BzNHdjAvRarVhZu5uoiUjDSWffKhPnVrMM+iupDQaBkMdupv/3DFv+rTYtsnBS6xtxJP79uoRqqkX0BrA9BYQWOGAGPNYy8rR7hcG9n36g3iLD6mi8bGcr9lMUtpHV/G+UUQeCvtksJn04JNcudb3zpXmrD34yWA8XG0zznDlapASkQyGbAaApAk0YOOuxeDFNMOkusjSAsdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tfpjlbJzyW36moThZ2D77jsN1rV/8mMuZVJtIE0iUs=;
 b=LLdgb1zP8giS2NGBO1LHsr2RkXuls+eiVH+O0U2KXL6aD6ypjp5DANZTgNv7LXJLOcKUSdgFnq0bDRgfk6nTiApPniu8i7LRnRoMhcem4dfxd3sNCgawk7cyp2GOvF6whbyCp3djQ9R2MPeosPQgqrvAEF4Kbz95dhPrZD8B2UG9WE89XpubnWpUC5gxcma1MydssVaYfhiWUXG0nKOmQWbO0l20+SxWmE/rD5f9Gka3jb+xyHLQyYLFklgrNg6ddWYu3pXiuDncK51KbFfD1I3HRFvGILP4671ql2BTp1WS7bfBpHi1AY5C0A515Nn3QGxQEe+++SgrxzUKMP/BjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tfpjlbJzyW36moThZ2D77jsN1rV/8mMuZVJtIE0iUs=;
 b=bJbdAoaBmXG6Y9dGKb3wQWBt3gxAajQn6t930q4q/DmtczVWOfu9GZaTr6mxgvnlfx6UzekyhxkS+dStOr68dyi0INXv9QewSj7MD6nNc+6gcWaQevY7uzlIFGa5rjvvsvkHz8G3a0NG9jBKujB10NBSfBAXFOYQEbN1iadUCP0H8PNYzjOn/CnJMuFQZxQO7hWZskz6h9Vm481kQ21biv8UJ2OkAZAGTAZ1RlDkZx9hfcn2Okt20EhCI4P6H7yEfW6g6wrqzA+KGSGUyiYqf7EEW+T+Dj357YfIZyjGZUrSwfWlg+2ZQCzILSCQjVGRrkcy6aCNshqtwslzhDEIqw==
Received: from BYAPR07CA0048.namprd07.prod.outlook.com (2603:10b6:a03:60::25)
 by MW4PR12MB8611.namprd12.prod.outlook.com (2603:10b6:303:1ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Sun, 8 Feb
 2026 18:08:20 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:a03:60:cafe::91) by BYAPR07CA0048.outlook.office365.com
 (2603:10b6:a03:60::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.17 via Frontend Transport; Sun,
 8 Feb 2026 18:08:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Sun, 8 Feb 2026 18:08:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Feb
 2026 10:08:08 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 8 Feb 2026 10:08:03 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [V5,00/13] Fixes to pcie-tegra194 driver
Date: Sun, 8 Feb 2026 23:37:33 +0530
Message-ID: <20260208180746.2024338-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|MW4PR12MB8611:EE_
X-MS-Office365-Filtering-Correlation-Id: 190e6482-26a2-4376-acb4-08de673d0a73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QYNVL6QW4mWeHonCz1SNQZBrSVC3pNc5QYztP1v3TBb6L9eLVNnxdRIa0K8T?=
 =?us-ascii?Q?PlmfRTG+4wboa65IxcRUgiNQ14nfHP34oJ3hIhYCbFGSgEpMCsmK8rNO+thJ?=
 =?us-ascii?Q?cWYpHxf0+32qeb3+KCrrdN2N+3Cw4olQFKhDySkDB2sVgE82Jprmyveb8WKG?=
 =?us-ascii?Q?2r4gaKDPJIt8e73KEKQjx+4DbbXKA50kHHlusFPQI8wsm602dYVywxVe2wyn?=
 =?us-ascii?Q?Q/9zUvTNGUW50C4xF/4Bl6l0mHcjy89385lVhGoerrhMRQQtR4n53T5vTFm4?=
 =?us-ascii?Q?rNTrgkTUnA7wOl4qMosbWzrN1XsGWnSyvzTazTdtlkP8ptC0s/8JIiHcJZBq?=
 =?us-ascii?Q?L5Pwa5Jftw1SuPsrSkvkqo+UHYSQ2PfQZFE0Eyesy5Enee7XE15fOrg20F0i?=
 =?us-ascii?Q?kzEy9CBybssoQt6oBRdOKJ7hCOIbUZUTkjCcXNFxDnxQcXAH+xYxIj4CGu/l?=
 =?us-ascii?Q?9yf+oHiVwpNmVsDeEp96ilMdgq0erYYGqzFLkvVghziGtjy8jFBeE/Rp2gHk?=
 =?us-ascii?Q?6Kc74KYeBNMJGmSmxtmuTPSctO7xevf47hrlErUQdutx3cwJkHcK6h7mxVr4?=
 =?us-ascii?Q?ky0UBRLN+fC405w49iLi5Wo1ScFftotkySGIhuhlZYJHHWdg95gbAyGo028v?=
 =?us-ascii?Q?AYCQXU9K+iiRBtsv5XMUpCgx8Jwk5XWIDzpdVtkQunLVU5KGe7vJR6I/q5fH?=
 =?us-ascii?Q?CUvdSw/70Hz2h/mC2ztxjcBX5/At5KRFWYpfC30nn/L9JsIPt9nkX40FraIc?=
 =?us-ascii?Q?IoTgAGf3VsR/FKIUVmvET/WFtwbS0SwoieYOYupZ61/GJ0SkgyxlwjdpvirN?=
 =?us-ascii?Q?I7R1IaFDpbeK2qdhHh1sZFWLOWT5s0LAhdAB8TcJRpYzPolx8Ch2wvjIV8jA?=
 =?us-ascii?Q?/K7zK/4HZxQ9KWVVEIJefKmvzRy8HS0mu+fL2u9xRuIZhpYfSavVmWNul4vy?=
 =?us-ascii?Q?3nCgaIxOZRPDZ+3UAC8IHv5trLgUQ7u0PiL+vItckynl20aR27W/7vU9KvA8?=
 =?us-ascii?Q?2Bnl5+E/M33dAQqyJi43Hb4zoyO8/7M1V09RBQScKu+1q3bZwMBH2pbxvYfG?=
 =?us-ascii?Q?qhqc58wpbnjfYOwqYwLOBHVYR/Y0FT7dw3PWeq7Y0ZJ6FiUXNimm0jKlASFG?=
 =?us-ascii?Q?JB16afWEUTJthtr3teJ8VMz3QA0akpsJpgr7NGOaUVzGDl3uWsHpZxcgmANz?=
 =?us-ascii?Q?ZNBVDOTwSLK4uxxlEJPSaxw8AVLhC+XDq3bUx5EgeQu9aNa606cBO4CEwfFR?=
 =?us-ascii?Q?iQWcVV5VeettApdwdgQ16z/tHeN3vvkYWGaDHa/qJakWJZ9kMKTgd5LY0eom?=
 =?us-ascii?Q?R7X5RY6BQFrb8rJ8+WbjEG0NfGfYnJTjGTe0EOkBTwAgBnhNvsFPs6E5LAA8?=
 =?us-ascii?Q?bZdxZ5/n9Bk57Nk1MjEyVfaBOfCnA+hLjYF3gCLIu5uPXshb3iaI5o92Y2DH?=
 =?us-ascii?Q?aH0OHI9N/pUesaT8zPlsfJFn+PBf6HF3U89v9yj8Yvy6Srl7FBsefcQ/3puD?=
 =?us-ascii?Q?QaQ+77axnXzGXVbcrVBxqaQvq0KetR7QIrlXh+DjbcnDfTmjNVBCvVsmwZ6Q?=
 =?us-ascii?Q?96Du8RGPn4U9pN30qAxiSGiAjs9V8xj33paW+/9Fcf/8uMy4gxX08FKiyTr5?=
 =?us-ascii?Q?ZrNP5Q8JExO9fZx/nL+Ann1Q/FFBlJ98pDZ7a2gicVyk/W10AfmPL/t9/dih?=
 =?us-ascii?Q?8by7fynv3cN7iQTulCFCMbNnKH0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(921020)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	151BDBqi/ogs46g4L2pbIxhJMQ1JHST68zrgBPuHkS3TkTOzuoXYqyKMb+Gu8Le6Md3RnYMVbVB1EisMfqfo3oT+cNSZ5/JHzj9hWMJbEvweEnRDzJ3fbCYe8t9YiV9cnGWk1xofhqWkS8VTbmZbb2EDosJgnYcTWjtGMgonHyH/ZL48EjBYUMLHpdmt7KqZ9bkVjlgLCexxGWRBrn3gNrjwY/7DiGE3vwSGZS2vBBzTWWugpq1QJaV3urpysa95GeLT+vfGx+Kk+x4izFmD/PnQW5KILz1bozg1uAkJOppyHjxtrrEgzHS1yIQERRPBUGW2iZn85j3/v5z2NHVZrrYwk+f6eumaUvQUPPIqrrVmk4aeax4wqa+2Z79YMi8RyFm4btm7QfLP1hhn38RSzg8AECUaE7aDXIvsJK0H5w9fp8Z28RqUHCodh3Db0aV2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 18:08:19.8939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 190e6482-26a2-4376-acb4-08de673d0a73
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8611

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

Verification details.
 - I verified both Root port and Endpoint mode controllers on Tegra234 SoC.
 - Basic sanity Link up, configuration space access and BAR access are verified.
 - I verified that ASPM L1.2 capability is disabled for Endpoint mode.
 - I verified suspend to RAM tests with Endpoint mode.

[1] https://patchwork.kernel.org/project/linux-pci/patch/20221013183854.21087-1-vidyas@nvidia.com/

Manikanta Maddireddy (3):
  PCI: tegra194: Use HW version number
  PCI: tegra194: Fix CBB timeout caused by DBI access before core
    power-on
  PCI: tegra194: Disable PERST IRQ only in Endpoint mode

Vidya Sagar (10):
  PCI: tegra194: Fix polling delay for L2 state
  PCI: tegra194: Refactor LTSSM state polling on surprise down
  PCI: tegra194: Don't force the device into the D0 state before L2
  PCI: tegra194: Free up EP resources during remove()
  PCI: tegra194: Disable direct speed change for EP
  PCI: tegra194: Use devm_gpiod_get_optional() to parse
    "nvidia,refclk-select"
  PCI: tegra194: Apply pinctrl settings for both PCIe RP and EP
  PCI: tegra194: Free resources during controller deinitialization
  PCI: tegra194: Allow system suspend when the Endpoint link is not up
  PCI: tegra194: Set LTR message request before PCIe link up

 drivers/pci/controller/dwc/pcie-designware.c |   2 +-
 drivers/pci/controller/dwc/pcie-designware.h |   2 +
 drivers/pci/controller/dwc/pcie-tegra194.c   | 191 +++++++++----------
 3 files changed, 95 insertions(+), 100 deletions(-)

-- 
2.34.1

