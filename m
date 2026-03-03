Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011006.outbound.protection.outlook.com [40.107.208.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB5A35898;
	Tue,  3 Mar 2026 06:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772521124; cv=fail; b=N549VgjKhbm1/sUgYJNcCW62/FHFjqj4rSzQxx2Yz9Dou5aOQ/nVCbH2NxA8ndIF9FBMGvmVoBAx4DN++ZKMf28ewxT2NjSjzI5hObeyIqS9dlgXI9OCFwmQqTURzKf3p5ub+/v2kcKcSV0ZUy1STST3iL3Gtak3tCphUWIR6YE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772521124; c=relaxed/simple;
	bh=eXVljPLA2eRyoe/1RO81z0iLRudZmLI4Dhs/jvsdbco=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQYTtZSLzKmKboJLL/qOPWWQZeZyJnbPKqwtS9eRlZWY0GLpOMzPB5lNy4bEMVy5p7SoZlb/kcYCO1WtcoGI34MrnqADJgc2IKNLKnOGJHAygw1PpKvvD8B5CVf2y1JH1FPsrJz7B0B4ZJeItsx8tBQW2IY70/AANRucFOR3hAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qGA/5YjJ; arc=fail smtp.client-ip=40.107.208.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qGA/5YjJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qbW9xUTcZFMv4NFaHEuQN7XaWxFrzcOy3k24+UMjjsGrzVGDIRyYW7FQ7+RH8mYAaDSiq8XSm9Fa9z97E7W21SGBKCJbC1CzOn6vcJlf+ZYka9xCT/4NuHKsVmKs0a1K9IY8CwUmONewGvVnkq2xTWWQqDPaMqTAFDKTl8bNQgzqya53YuZe25kFgtTWADZti1tZyPoM/1k0T7gGrEmWuMVlafuMMhLUFlgYxOAV0IAMnX0It2TpL4nlsA5BFx5KHSFhvm0oljyKiJ9Erit9W5Q3FerP4TpKxWr53+vmKjz4IEXHZE5zFKVmk463WHdUReXRMzyQj8mFBhg5Dhn56g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fi6UyiU3+rdw04s37Q9xXTxfe8LDd+ex7AkiK3bCW0=;
 b=gxUON/zbR3/adNinYb6iCaP9EjaKCWu17vtdxq2diuF6ysVvMh0369I/i2A5sGO/axlw7L3LEHHrigL8nkiI4OZFIorHuyyIcYsq+SG/ylXFRqfXV1puQjDK79Rjh5eCL163m9ru8EOYpfPY9rCVdyY7IRzkgqRBQwFWwDoyHeSbcorbsGPOkxZdKx3/5g3cAd/2+gORCNDsT6vZaRgRAWP9tI8+3ljxnTTVjxwCHsQxnUOvYbIagSbGh7GiQqmS2xT/JEOaC2lkYRrCmcFVUEFJfSZGA4XHYCxqB2t4FkGggnVB9TN/sAQAaE6LKpns3CKwKNXrPvwXSltVsasNSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fi6UyiU3+rdw04s37Q9xXTxfe8LDd+ex7AkiK3bCW0=;
 b=qGA/5YjJ+PDe7bWlt6+GGDJfbphDMw7GlH11Zpmv8QXw/n8wH08i/3FbKvPPa0X9lLs2bMdsq6Ibbdo7l3ob1HP7ARmUmnHYJMRED3FKYWYswIMZBuY76iIhqazcFSYpsdAunOB5GBE16qEp1VS3CrcFtUEpDIGrk2Kmz/VJAxNcPVbedAMSB63hP6yNVdrTu2/IscMK8Q6GIa5TAg+ukXvcLPTmsW8qkVcd6hntkJEYMRrXJR/jc+gYpzUovO+64BOfI+6hcuBtRppJwWuDEgp/4m3YWcV66HwstJJd01MROJMIv/jAocDkkRgru6WgWaB49QR+B7GM/4nCTMXcqw==
Received: from BN0PR02CA0002.namprd02.prod.outlook.com (2603:10b6:408:e4::7)
 by LV8PR12MB9451.namprd12.prod.outlook.com (2603:10b6:408:206::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 06:58:38 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:408:e4:cafe::af) by BN0PR02CA0002.outlook.office365.com
 (2603:10b6:408:e4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Tue,
 3 Mar 2026 06:58:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 06:58:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 22:58:25 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Mar 2026 22:58:19 -0800
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
Subject: [PATCH v7 1/9] PCI: tegra194: Drive CLKREQ# signal low explicitly
Date: Tue, 3 Mar 2026 12:27:50 +0530
Message-ID: <20260303065758.2364340-2-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303065758.2364340-1-mmaddireddy@nvidia.com>
References: <20260303065758.2364340-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|LV8PR12MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: 918d2d1a-24e5-4acb-f1e0-08de78f24c15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	bP4hkrlI8FN/jzjdchYluxD5V1AeGa4ulYp929/pJBwK4Q/1n5waY4kyglefoRV1goV9Os8ta6B2eK7pgyLcMxlG4xsCDtsyZR4XMwMBUSNvHcvfF6FGFHWNe+SH2Cz7ZDoQbuGSsA6hI31HoCd5IhozsstAoAEwDlSE2BbK22sy2YfSKuIDWh96KuOpjZsVwDJjhbSojkemgQOa8dtROlSqiFRDex16D3/sHjivoVPhaN9JPFnrOPa+q7EGoO4WWwikDuvaboLZKeNHmnUegKmoB3zzvVaDs408EekzS4ryx6ZUAgTeck3bYKw7BqX0hOOoldW0cMb7pfGHXJ4nuwVMHjsJPiwhh0ySBpM8mP7WfM7VeNrrumH5b3TixFIPcVtHrpU0yjJ8XTtgttn4yTWv7PVYXLv4LV03beDvAFe9QnCf2uuCp/8GdDkacX51bzkJCgLAeEKn3ipffO2KEHkLbz4PHwhMUMauwiRTJg/Bl27cA+mFrG6+skQF5obbvDWbHm8vZm66zEykhqnsDU61ysKPK/CMmkjE0aMC996tGWZdckB2B759D40Wkq63VHpSIeSXRq1Q0RpVJ/ENAPg2LJGbCfar6UBpHwn1/yc8D7LMpapdipbOYbkxKDAN6qn18smEaIV94jA7Ztvf7VKTMtDdWjTifvyJkpzigFg95BSynUq24sfRCj8BWKm+A4jEuO/LUXg74/L6fLZt/k7KhhQr+SRaa7k9kphi07LvqGedDGwLxYUMriXwMF+3twhUBCFZiIbh/M42AqmY09c+mYtqDRDGYoxBsPT78ZaNTjKW6hJG5hVNm1QvGu1D5ZzfeZ7PWkNp2HxfkLVB2M22HB4yJnrq9hDHJRyceMw=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JkoPI42okptW8aTUIl6Ae4udsWAMeFSULYO8wemp3HJ4KEHZHStUf50qbVeQe58XBL+u8HT22UjxFnWl7hwnZBeckaqgAhTK9hVTz1xxI8U83219bJ3+EGbRHvZhwmTIBqGaoy+x1L0JTRnLsMccyAT4Yqo1vR1lN12gIMVpl57/diGbvO4yMJt4+RYskU6ow17FOPBSE4+4T9CHYAaS3mTXCFByUq3Ewcju8HYpdmH0d2o/pWciJio4aRcI/SPSBUExLUdwHdwxjjwNxs5n8ICaVgtfbNq1WfP0T3gLIUtvm8GVIctupU17mrhrVgi79gQcIGmY6lLxq3gXT0Wy2/IbzrQpiQDGPJMPHHFaEueqKHvwUZhl9//EUWNSfCGpkXeCmg1L/p+ocsrKZcq3XVBBMz/FXewp+CJDtCfFBIQN0+8iKTUaUSVIQxg05wrH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 06:58:38.4199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 918d2d1a-24e5-4acb-f1e0-08de78f24c15
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9451

From: Vidya Sagar <vidyas@nvidia.com>

Currently, the default setting is that CLKREQ# signal of a Root Port
is internally overridden to '0' to enable REFCLK to flow out to the slot.
It is observed that one of the PCIe switches (case in point Broadcom PCIe
Gen4 switch) is propagating the CLKREQ# signal of the Root Port to the
downstream side of the switch and expecting the Endpoint devices to pull
it low so that it (PCIe switch) can give out the REFCLK although the Switch
as such doesn't support CLK-PM or ASPM-L1SS. So, as a workaround, this
patch drives the CLKREQ# of the Root Port itself low to avoid link up
issues between PCIe switch downstream port and Endpoint devices. This is
not a wrong thing to do after all the CLKREQ# is anyway being overridden
to '0' internally and now it is just that the same is being propagated
outside also.

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V6 -> V7: Fix commit message
Changes V1 -> V6: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index b1ae46761915..2f1f882fc737 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -44,6 +44,7 @@
 #define APPL_PINMUX_CLKREQ_OVERRIDE		BIT(3)
 #define APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE_EN	BIT(4)
 #define APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE	BIT(5)
+#define APPL_PINMUX_CLKREQ_DEFAULT_VALUE	BIT(13)
 
 #define APPL_CTRL				0x4
 #define APPL_CTRL_SYS_PRE_DET_STATE		BIT(6)
@@ -1411,6 +1412,7 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 		val = appl_readl(pcie, APPL_PINMUX);
 		val |= APPL_PINMUX_CLKREQ_OVERRIDE_EN;
 		val &= ~APPL_PINMUX_CLKREQ_OVERRIDE;
+		val &= ~APPL_PINMUX_CLKREQ_DEFAULT_VALUE;
 		appl_writel(pcie, val, APPL_PINMUX);
 	}
 
-- 
2.34.1

