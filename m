Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013071.outbound.protection.outlook.com [40.93.196.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E5E331EB7;
	Wed, 23 Sep 2026 07:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147982; cv=fail; b=Lkj4Q9sqyNLN7XZWTktsAHyeonztCnrW+mTBXa9zG04se7lm1KEaaaPVC2uON+0QW0OhxfTGyGG2oCARXXY90rmTxqR+3f7l3BWCCMJVSsay7sgEyrEOrQ3bpaPEkLqqnAC9NPgEniUfTUY6GzckVXih036ZUw+IOtu382EGZAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147982; c=relaxed/simple;
	bh=XGyKid2kdXozp+AxywP//MlN2hWTAvAxjSn6n1GGtl0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qfcJzuLkLMFFCBcLYos+QynZbBuQPJHBN4z5vX4xlHblSCgeR3KTuFIa73FVlGK4k+gWPNDbzstM4cVhNgc/WSpXRBx+jmC83968+HkHOsh16gHwzzGnCp1z3Qv8/q/mUyIh0nNFsYggH+rLuh4RW/2BDSLiQWNyoNyk+5WrDJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fzcPi55L; arc=fail smtp.client-ip=40.93.196.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fzcPi55L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0qlbnszgkI4T6rtbE57rpuI/+OtuQQ+QqvxrjSVwAxlykQeVC86Og/8yTpLsYkPjB10h7frdEOIJsjnaiXmx4MfJ8zV5VsxoLYvmFfUvSG5D07hcTjf4RJNpFt0otSmZJX8sBYZJswNq7DPZbxBenoaIir2Ef7YUEYh3K3Ps4ne8w9IfwWrdO/y51o5lU4R/NaMXe66FEmFk7+mr/AEY5zqD1WbeYsIuA/8XpxOw83fVeCsG4pZ15sv52sipXSXBZFsAwfwvPeQttvdo7uIodIBHwd/StEEF9NVCazVP8SxIxP/iUSSjhxhO4WtBsjYEFrUbTsy4q/vw5FzuVUtYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGr26r9zyR71bF78mDmlYHZYRhUKP/aOf3YmhGXh7V8=;
 b=DQAJiYia4JQpXQhaeH5roWe+/JWPlo1UUPueL+/qjIXisJSjcM/W3oD8msUMgX8DmSaf6baJQaHzPHQMrBJ7WcHwxsglMDTvoDaBCX3zxAeFMmz/ykvO9bjjyr/cg3o3HE7+g8LC6iBvFtPZf2/co3MCG7rc0k/7SeXsURgp6B09IUNeE/li4DHCmYauxpd4l011G6TQKaIA8DpqxIzB6ajREKUcvhZzlNYoFVaySpcVoP/Pb/ZlQ8vF3McgXPe7o/HeB5/Z7HgqzUbIHDJrmPgeK5N+ZIcJpxOtpBGOSQWFcXo5UA5oWktVvPu2YRZ3Nc6Jkc7piguvpM/TMWAQaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGr26r9zyR71bF78mDmlYHZYRhUKP/aOf3YmhGXh7V8=;
 b=fzcPi55Ls72KaDpY8lBpsLYSUMAYaxPvNLEpat0GPsoSTaIn4BaSj8i+EzGmBpEzzcxVIMLsQmN9jMTmoD6G3XowdhMh4pwz/Ad2EWeD1A8sSS9JWtBOMI+4u0ph6PJ4l0sUltEvEIz7UwrRjL+pgzOzlZs7fVfpd6UIvBKNERWWrSyMgtI0Lz5ernVx9AoRt23ncO87BHUD0VQ6mZGaeT51VrKhizbZkcqAmmzOF/u9/la8+9nNNrBVcbcLyW9oqiw03u0DIn8zFXa8Zwwg9j5doSrrABzo8fFLSi2QuGju5+oKiMHMF8lXRLMNlcuBjCX7OXIfpg2Wp+Xzs8lXVg==
Received: from SJ0PR03CA0355.namprd03.prod.outlook.com (2603:10b6:a03:39c::30)
 by SN7PR12MB7788.namprd12.prod.outlook.com (2603:10b6:806:345::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.21; Wed, 23 Sep
 2026 07:19:32 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::98) by SJ0PR03CA0355.outlook.office365.com
 (2603:10b6:a03:39c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 07:19:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 07:19:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 00:19:16 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 23 Sep 2026 00:19:11 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam
	<mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, "Krzysztof
 Wilczynski" <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>,
	Niklas Cassel <cassel@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 4/5] PCI: tegra194: Use standard RAS event selector mask
Date: Wed, 23 Sep 2026 12:47:05 +0530
Message-ID: <20260923071706.1134320-5-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923071706.1134320-1-mmaddireddy@nvidia.com>
References: <20260923071706.1134320-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|SN7PR12MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: efe0b572-4264-46f5-68cf-08df194303b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|1800799024|23010399003|10067099003|5023799004|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Cd+ooxKKeRO9mNTzphi9jFiok2g3s/h1TDTTXzzO5M00d/P0ItSIz6zFY5ZsW3M3EMjM/49HzKkiOPiE12Z72GTOGH1oLBiD3+kHXvhVk2kdGvP1kvBsmJUpuoNRBMIpeD4cgXivHkmMjXMAZVXll360PLpsT7UyyRENUxcYY0rXlZWIs3pAD+vW4IJ7ruYKeHttxLQ3+Rb6OVIiRA366mi8llCLKfmghQYt+MagUYe/hHo4sxrxH0B4uXyTUsSkw6kN98CsyywA+ESVDL06PkfGHa5Jsp9Pmz95aXGP0XJfpJIyQSTwFYsq1BXf8ZKWpcWP4YfCFa879nYLmPPYjeebb9yr4/vc9XUI8Bt7m355dzQx4YkTsxLl/D/RVWf3ayQaWn7YJ2wLuJB96Npg3sm3Wjn42uqel43Yj3uO4BMhwGj2T6pcBSRleGkvu/YNnQ89cNQ/8h3INkVTktBYBR9dE2VznXel5OHDHrg2GthHVr3C40Jlt1ufqYJJQ7cgJLMUx2ESPW+9+HTJvt0d9Fqy3JKlv6j9WulvG+/vSHMdGfhb4inhvPh1zzMFgxBs5STb5Cg7joH0te2MxL0vlp00Oj40RzhzB68U6mIY9ELARj4LZPuO/0dJDLA2KAzxTQxIZfEPQtbGHAoHEYhRRtVx8CdnjV3w7ilhAlpEBv8cx0Wa2JR/K+XC3dKFjQE+ofcznUouJIswFrIH5bG66w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(1800799024)(23010399003)(10067099003)(5023799004)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	n3BUR8PVGLONSjP3zZPKmm/CL17TS8l0RSARix0GnRraciFLQeSk0ISr7tX+S1r82XDaCrcJ1aEFcn56GlqL3sdh6QHENQKOaQP0F2Ki0WxYpsKKb867N/0BKKWFHM+1cGQ/4zrMcpYcXjD73vIGsW9uWWTURmq9j09+okrV1UoUkyEA2nOXHSaDvCuwN/SgPbnowloTtRITFCsNqRGg29kNDjvhaIsgNcIxMRs3xO7RaLOwGUIuH2VqDOk1ns3j/6WzCTxVvpTcbtVGmM2thVWC775uEJAmyWrM9sywgHHVxL5L4VHniiwSxAaz5KXkyfuWgw23peIlurJCLveZyVZompy1WopTBnUgzh/4sRUElswsD5QzbKbTE8Ul3oy61PoUxMj3ixacpexrr3YdE8WDduO/EzvfbTfkmqVY4G1xi34HfDyQm77Q9Cj/9AFC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 07:19:32.4269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efe0b572-4264-46f5-68cf-08df194303b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7788

Use the common DesignWare EVENT_COUNTER_EVENT_SEL_MASK name after the
complete RAS-DES event selector field mask has replaced the old narrow
value mask.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 3cfb386dd433..2462da8664e0 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -618,7 +618,7 @@ static inline u32 event_counter_prog(struct tegra_pcie_dw *pcie, u32 event)
 
 	val = dw_pcie_readl_dbi(&pcie->pci, pcie->ras_des_cap +
 				PCIE_RAS_DES_EVENT_COUNTER_CONTROL);
-	FIELD_MODIFY(EVENT_COUNTER_EVENT_SEL_FIELD_MASK, &val, event);
+	FIELD_MODIFY(EVENT_COUNTER_EVENT_SEL_MASK, &val, event);
 	FIELD_MODIFY(EVENT_COUNTER_GROUP_SEL_MASK, &val, EVENT_COUNTER_GROUP_5);
 	FIELD_MODIFY(EVENT_COUNTER_ENABLE_MASK, &val, EVENT_COUNTER_ENABLE_ALL);
 	dw_pcie_writel_dbi(&pcie->pci, pcie->ras_des_cap +
-- 
2.34.1

