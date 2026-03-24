Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011049.outbound.protection.outlook.com [52.101.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF82F3B2FD2;
	Tue, 24 Mar 2026 19:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379489; cv=fail; b=qLAW/Bffjq5LcWfo2XzbdfdWtJu8TdR/KqxNOiAmhNew5m/wNT7AP6RryOjA8e0kec4cL36SODDquH44gkp+tV6c+Em5WYWOl2Ac/7q9+0A8N202ZOxV9znLNeZdrztfk04qiuCRQoQ37JqNKNWLGxHdIqSQ7QUX6nj5BThvy90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379489; c=relaxed/simple;
	bh=w8DC6Tdy8cfRmT7cFbJ2bonkcJqwMe+eV+NqHKGWe4w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DY8Xe6uueLrMfVfKRFkD+q1ifFNH/Xftnd/+DPsSCKgAZKDWJj0xXZrGy0iDrejZjul+RZgfCl4njWSe4mPEb2Kf4p5C7ZQeQMZdZHnS6Y4vxdwSi3WLJQZwvAEdj6VKZ+XiQACB47eLUAI1n0yrs4RbiGdJcr+vgMznJQRR5fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J0Jj7C/Y; arc=fail smtp.client-ip=52.101.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J0Jj7C/Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8/Eq8RZPz2h+WzVJs9SZHM3F86mxXsv7HC+QQbfJJcmG79OIMrx/a9o4xVIMBUy+rQRWClHAkYuLNqtjoJPppIMU8br+blPIMp0bKf/RzuriOrVybEqXj5UJmOE/7RnizDW0m8OwI9DnHnoQQW/MN4j+SbG545pq8iRwn28ZjZIcgvu2L02xyzDrW6LWlFNvdLTD4YZAMet9ljsKq38t0inRecmODW4l0zjRo8ZdQ+4ei9TdrvdRB2ABTnuzR4SMVd+dLkxX48Wy7NGr/CMEf0qEsqR6SnLFVslMqUc1tqjrFt2YX3F3C/KC/Mia0812eu0hvT6+xiq+NnMcVmeGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Me0RiVWGUjdfLEJfTeY9yjUHTT5SQ24jpM4//YbRqQ=;
 b=OmdP3a4z5tyh0BsGi2Si6arY6PHUXStPrprVDQXv5zl3bdox7G4CsnEpWLixWIvAT14N5Pq9xSIdUcQiMdq91YQSXCr7vzrvQ/bjrtoh6T+cb2WuwV0uYq34X9NvWT4ZmB9BsvsCF862oi7JnfwbvWDRcNOBGrZ6DCpbuE866SEUw0J23URvXkVWg8zSa2HGNMkHE4JWYAju6cyAsYWtXMWqjfaSkqIxNsbNVLetCectF7zne3rFzW0zOF1hVSpP5YVnQkVk8wzm05d7mwsu/ETv3GFaYrC//OYiscyrurMeaiGvVgeyvsoUe5FgLPJ+a+BdWYuqd+KZjztnhn1Z/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Me0RiVWGUjdfLEJfTeY9yjUHTT5SQ24jpM4//YbRqQ=;
 b=J0Jj7C/YHDWxabW2tFQT4yDxLiehsF2N0/opYFS5tLVWABhFOmNp7lOPkkrLhYnZSM58mAFQ1Nu57Npoolz/UhYbEQXtDJXQh2BLQb6zUoeBfP6lxd5OqTBMwTb8qxEe1CtP83dbmcBMDidC+EuhNYvdBAKGNrlUKjL0LbMtcY8FZFBIt2AahJckUvtmvtRssz8sLW4MuwXCOdczEaPulSmcXms12HmAmNLMKXETVtBSanutrPceyPqwwmYpbPKKupmsKwSR5LbdfzFgNyufDbJIstum/FXfaMhEThZAgaD1HKJTatf3Sn/oXRRbOz71/Dly1KVBBC1i/l3Poc5ZzA==
Received: from DSSP220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:3d3::14) by
 DM6PR12MB4371.namprd12.prod.outlook.com (2603:10b6:5:2a3::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Tue, 24 Mar 2026 19:11:15 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:8:3d3:cafe::3b) by DSSP220CA0002.outlook.office365.com
 (2603:10b6:8:3d3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 19:11:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 19:11:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 12:10:55 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 24 Mar 2026 12:10:48 -0700
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
Subject: [PATCH v8 5/9] PCI: tegra194: Enable hardware hot reset mode in Endpoint
Date: Wed, 25 Mar 2026 00:39:56 +0530
Message-ID: <20260324191000.1095768-6-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324191000.1095768-1-mmaddireddy@nvidia.com>
References: <20260324191000.1095768-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|DM6PR12MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c5a5a79-5778-4508-0470-08de89d91f08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9JLLi6xPdMTo/hXjYQSTCtxOGfee7ojNUFPaouKE7Uv9hK1H+Nr2bVeNJBWbuoRgCf9jYP1CeZ+ynr7ZCwhOB6NaJYkSOfH2RK/6ZYbDPPqTUeKN6UORbxM41z4YmdbrJaBJtUFuAW656c2E23cIedz0VHrTENX0lMyHf8deuvCMStMRVJzogxPARmBYwv47WIqjb7bbr0l0YqoYlkKcXV6+XcD3z/rOn1u7+SLvWDiIXiA2QvHHrLaTp5hLQUfRBzqI7tIsDWqengtcCdPFJSScXHd9vZKwHTXuzYrQUM5aqGkH76Fja0ZDXJvZMTZnciOAHv+E4GBncxRJugGFzkv6MOvKTqjlqKgFzf0h9VV651O+VOMnlnD4t2C/+D/y/X9+Fy9wTOk/ElQnOUUfxqcPfUL/kbmDxcZMBeMddyH2kgbDeEkqCAFbhqYbPm9btUuWQpPctvch5ekv30wUyvKmIkyfX73ElJ38VFmGJ1g0w8nEhS99+0j5ZmOjKyLZvUDjt59mw4MLpfm9fxyJHxemZKLEKMGRhjabUNcSum547K/vBki6s6zMWymaSknSEeVncHkLsJ7ZyNYlrCydneecrtxz20rtx2d8PCoLcJAOFNwgFfDNxbvzwiwVXjRworY/kpQr6C0Ys67Xl10CV0pI8L5bGwrENeVj5ddqrGV2vMYraUDUAOT+I4Kd9Yl3rKM1ZhgbW4kyLdx3H12nvOhhOWWfGfN/y36Hewr238vbV7WFg8H+RzydDRd3lAk6ZsD4PtjY2B5g06cOTo+quxzpqkzwLEjG9YRx+QPblnByfhkN5SoU3uuPt3Mt5d5Z
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SNUOP/pjqRRXKBsPIIrD0k3TdWT905hznA5XKW0aKuSDZE1Ajnjq3yR+kkwkOO95gMKGzZzFlrAekqLMruBgi8co6vTLQ/J6Maua5QEbQPlJI7yrp9YXQD9vJIJHGrSImmu8slOJrozAviLGY9t4crWjv/f+D8txUTdETbBmkQx7GL1ntHNpt4WrbUFczby0Bzcn47SC19bxCejNWGkZEbqU0FvHtEn+lFaVP5/nDAoZUb4sB2sFCZzS3EUTJCmoxlwIrNc78cr0gH0N3qcqlSmg2vXIDnGr2qderN51Grp2tQhc0GxVW1i3Xyj9pJQUlt6fQSRzZID+IKdaXrMb5ADAuLimPWDyJQAsJR26B0H26aMZ9BCe7L89lplyrP5NrmTVTJHRTMNtUfBlljynST2xbNiS5+x+gl9JhUK4/dr+S0P08uVwB/kH11m8xgzn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 19:11:15.3249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5a5a79-5778-4508-0470-08de89d91f08
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4371

From: Vidya Sagar <vidyas@nvidia.com>

When PCIe link goes down, hardware can retrain the link and try to link up.
To enable this feature, program the APPL_CTRL register with hardware hot
reset with immediate LTSSM enable mode.

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V8: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index b312d02f8dab..4527d4759e42 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1791,6 +1791,8 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	val = appl_readl(pcie, APPL_CTRL);
 	val |= APPL_CTRL_SYS_PRE_DET_STATE;
 	val |= APPL_CTRL_HW_HOT_RST_EN;
+	val &= ~(APPL_CTRL_HW_HOT_RST_MODE_MASK << APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
+	val |= (APPL_CTRL_HW_HOT_RST_MODE_IMDT_RST_LTSSM_EN << APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
 	appl_writel(pcie, val, APPL_CTRL);
 
 	val = appl_readl(pcie, APPL_CFG_MISC);
-- 
2.34.1

