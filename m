Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013030.outbound.protection.outlook.com [40.93.201.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3975D347510;
	Tue,  3 Mar 2026 06:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772520937; cv=fail; b=kjb9T8WrtWFZBh6RrK9WxkFzy/foLzbrc3peCYvhnWy76qD28pHKVLFAGTZu1z7SJtsGGeqGye2r++NPsXE9tzx4hmiUtoGPw9skov9xNYISITQiUGyCTdMjuxOmLnpQXXgYlIv9FKmbLc353K0V6XKjURJfJOS3sN6OYcSToB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772520937; c=relaxed/simple;
	bh=Bx05okLjZ4HhNiUgE0/4E27f1mOC8inI69dQ4Qhr5Z0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BTwdzY4AOBWWJv2Qbk3dxAgKrkKoqn4lsSBokBfAgg2H956mhE6Pe6arx+bysinFKfAQzUJuK6HJK0g3U49lMWahZMulADJpVXAo8vDczy0VIo05g3wusy5c4zrSgzH/RoeCyx8cOrW3pyk6XPfFzVzz6Ydg3xcd1HPaS0eoJdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mo+VM5Ic; arc=fail smtp.client-ip=40.93.201.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mo+VM5Ic"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YzE3zVRcIvHAQ5PxO8Pt9xXWlKPy6EwLr2qTJZps5N2y564ymCjAVmUaI/VNCJXX60aQIpKS4FnxSj5HIF2DvyV9uk3ZVcLoWHbHKfFGQGvsCFN/9vJoM9FfA2X4wHXZV1TCjodLM88C9eVRKfi366OKTUghhUO2WAnA/r3VBIOIEyZBxfy+iG2fFc2uImOrC+2pLkc3vMt7AdS3cuArcoYgdFIOSxFhutB+/RwcNJydUrdy/+9kLInoPjJ4If+XK8S54de03bJQp+/XbxN/I/w+mauxHWINqgKJhERk1kmkKkOAHKc2hBEuW/UeCFBvCuMuImkX7NAgtLKGO0YzyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LydLstGn8i1QcB5QiYFE4ycsfj3VX5+go/kswcRxDw4=;
 b=beOz7/IcRozn2M41EFq1TTvJBgTTdkZPm0a6X9CKHN4k+cG0LS73RXvZp4W751i2CZwf7h0vi859f/UXU6dfmegoZ9bze3hFJkLaI3hyC9wlBiI8An8FxxS2Wyz69VYDDcBXfDwKRCIusL6ya1C5x2DouxlUmwYwsw4cZvCJ/tiC3onEZDiAeZguxLj+A2Rk1SGsFhww4oioY3jSgAnJnZio3zgsl7Y1tXVEvzKp627AyqUT5w7aiEF9RSB77g7gCXRwz9DU6CNQXgA6C6ralTUWzVeh+CdIauGOSugggduNRSjZgKMXFkqMu7Ezwik2Q9PY6YT41NrlPsFr/wCJ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LydLstGn8i1QcB5QiYFE4ycsfj3VX5+go/kswcRxDw4=;
 b=mo+VM5IcVV5cv3dxVzHrVk7P21/j1kwmRn2TJ1Y6i07Zt3Rrrpi1rND8t5rQB1GPJdea7PMuAFezF5F1PwB5/+xN6qOfIEOb87Lxew/sS/OeVxwDBN57TAAt/lrzaKaEMrGOp6zvAh3rMgUEnvVN+vZS1yXA32qtSB2T2HMyoOU+aybjfJt3I8srJdaZohykg7eLZM5Mw5gRMiH6EGMtH+OisS25kVMHZsx+mXNWr8V7xTIYmAx7hlMgFf2I4h+n+niHmo0oPPryo5gbdHZbMEV5LNJneWardORuYBckIlkW50/T8P0aRQhVeODch2cRom4ZbGveb914mv2RI4L+Yw==
Received: from BN0PR02CA0014.namprd02.prod.outlook.com (2603:10b6:408:e4::19)
 by CH3PR12MB9219.namprd12.prod.outlook.com (2603:10b6:610:197::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 06:55:30 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:e4:cafe::71) by BN0PR02CA0014.outlook.office365.com
 (2603:10b6:408:e4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Tue,
 3 Mar 2026 06:55:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 06:55:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 22:55:15 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Mar 2026 22:55:08 -0800
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
Subject: [PATCH v7 00/13] Fixes to pcie-tegra194 driver
Date: Tue, 3 Mar 2026 12:24:35 +0530
Message-ID: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
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
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|CH3PR12MB9219:EE_
X-MS-Office365-Filtering-Correlation-Id: 71a7d248-bb06-4799-9221-08de78f1dbbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	TtJrOX0DJib2GfodeszvU/M0z7G/6C+gPO7T5tU+lqsdD3LaW5CmmNTVjYuFqkl5P9fvDkMG8F3NxeMI8xtnl7vVCfaHfhhViQOYvJgD/D6/2Nyv6+PJFFxfD5MCg7pdrpoDmA4ll2kVvjf0i45+JtWUYFw4TLXMOSm6STTAICEWU5ssWnvzL3VceVDAOssqIjDngyPcWbZPDXgqvdB1kvpOwn3MY6xyGYv2hBEX0BLCQGu2Pnks6ZWfvZLJwmk0k69oCNXx6oulkyFz5ngWDn6uayEV6RxzeWYXKAiJ7yUNvxmwUv3QrHvDYh+7Z5zEx5J2QztBOxtBtYyIEidEZBxLYPZhPAvKXT0E5J0/itW9d8t3zEM7sdrG24CnGSC/5wZ1hvdJM9eUOt2dWUqKMl1xUvzEjfvRf5g/xL9mmorpgBS2/M4Xhq4gYeLbAJy7vh3wJcn6qyApJ2/T7m4bVNmuYnD3AuhDzhLvGmeKqCQj0Bf7TWLVF0QgIAQ9S9flSkaTxGPuKl9JcEgceQrnyuIG8DXCOiVjrSl/8tkr9U2hXYn+PSKhmilvxO+0nOMrRPrN2Oe7GvytzZUPtJi3iYKcVktWedfd99r+wf8tagJ4kfDuyg1H25hNgt/ueC+9OFl8HVdZ4AHp1/IvC+S11t/8ayYgu0cGmvFhanD5Q8MfkrxDW1C7LApetp/Hna/gnG/mQqye2iKpcDEx4nw9TZawIksTBLE93tWto2ziDEIdmDcw5gkFWuJBtKtqc5mT1nmITl3rPH/yPRrMk07XmX8VuAAod6fLTbRx7luP/MeXIAcjN/m6u5Q/mfSM4HYmegNNHCPTXSv5UIhXHKT/sWfGtzb5o4/TBCFUMpDZzxE=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XW5a0IOK7CoQ4qnzghSYOU6amjRvKgPHAFgkMgQbO6GB7DGv/1mzMXpxt0amUQFiOaZlBHRbyILcr8DJcom6kGvzec3b4ZEt7JQvHEgLXU80vTSi/tb9Gbd/cK2mrza9gxUM5pcmaDjeUL3tcxiwQrnJ4vBTAn2pC7LyoxO+40KoOotc1zPiN9lT1rF955XxwUOp1lV14im0xl8bNovoTF1F+bmUAQGdL9F49yh3pNfexy/a+lLmtdlSaX+lMkk+XDbjVfd2zWuLhbgqZDGkp2WFYlI1NpU0V089EjhZmuiOjNqk3y33slXrgurS3freU8EDaBaw/mtcuYnWlCSOndxQm9ig5HG0TzCaHiiY9d+yXWzQUQ2Wh1qjfe/YZ5orM5jIV0R6v1Ps8wIW9rHL/iUC0SNQJKSGQiPUxDGUR9dIyLl+/9PWBrb57Z57R4na
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 06:55:30.0291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a7d248-bb06-4799-9221-08de78f1dbbc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9219

This series[1] was originally posted by Vidya Sagar, and I have rebased
it onto 6.19.0-rc6-next. I addressed review comments and split this into
two series, one for fixes(current) and the other is for enhancements.
I verified these patches on Jetson AGX Orin(Tegra234 SoC).

I added below four new patches to fix bugs, commit message of each
patch has the details on the bug and fix.
 - PCI: tegra194: Use HW version number
 - PCI: tegra194: Fix CBB timeout caused by DBI access before core power-on
 - PCI: tegra194: Disable PERST IRQ only in Endpoint mode

Rest of the patches are same as the original V3 series, rebased them on
6.19.0-rc6-next and addressed minor review comments.

I reordered the patches with regard to fixes tag.

Verification details.
 - I verified both Root Port and Endpoint mode controllers on Tegra234 SoC.
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
 drivers/pci/controller/dwc/pcie-tegra194.c   | 194 +++++++++----------
 3 files changed, 97 insertions(+), 101 deletions(-)

-- 
2.34.1

