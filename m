Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010011.outbound.protection.outlook.com [52.101.56.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B4C3B6BF9;
	Tue, 24 Mar 2026 19:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379459; cv=fail; b=Hi3nBC2e7gn62UL2mfiRynwPE/khd44Jb2glArrFe64kXBTC2D18hjQYvpuA7/HR31j5vTAlOr4fvVqjCPdiPHxfpYylz+YUwqBnFKzlXILtCDRqFhAnLIlG33BL6Ir+Ij9+BP2yM5IVNiylo2Zdo/B85zPYoW3R4Db2L6ToEM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379459; c=relaxed/simple;
	bh=49028wGC+U1sO5XmjTCpGxe2eyuvFL/VLVUplGHSlN0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X/MGkmYrUDTRJgLFGGgdBagy+SvZZadR0SDSBt8Fw9ch4dFKGuGNnfpLv1SRis+mppqrcjOfPPzoT+6ek5ugBBaJKXMUMbP+9MvwyfMstDvKgyngtf7Oq/9oiMc4fRY4CUauITBpfZNVaa4gWghkkFqYGxljz04Dc+E04sduwSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bOG9psJ7; arc=fail smtp.client-ip=52.101.56.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bOG9psJ7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYxltTSR+1XvQN43dM7VCsZ0TXg9CxHqHpsXBxC3NsSI1k3DTJN1cjDMTiQdAIotKeOZw0GcuiiBi4nLS6D0q69EZSkvqtbQ6szdjPe4gIdjdpNmauA6xSdafLfPhu5rR0zIjpaeQMfmwszxI+EXwZ4d0t5zV1baDsZZTiuF4ARaMiInpIi/ws43+IeGUexxKZuNYLDM+D2/+nIaDfi18ne1Q6FZ5p6t8PleoMyOjj0Dn61JKbbJhyVsz/KbUO42yUgWRVoWUkP+eQqprtDbEvKDa8mrGYbo4shmsFFyrmkenqfnCz+6FYwAfykjcfVC5hV8KYumCZXOZLIQ68fyjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFszKneDAsPzyQQU2lrXTXgXbnGD1diZihtepLTpqYk=;
 b=LzqgL37hHjqJZ2LMY8VArwF8/1sWxYo5To8IY9o1rqC0qFea3X0G8e3rTF0MA4BNwYDgj3rjnPIFT1Xe8DidxFiO4IBa+dsveZhVYZAIUppwkzctyt1qAVJueVXmstoqMba5dd3Bj0V9iBr5icqKPbhwkg74JhCnor7n0s3JAEeKrcu6GqX5p/mJF8qSboyca+TkKC5iZxiS3xjJtt2STFkMUlg1kuAcNgnJTltTOUZTstr09jR3Ck0jCr4dUQeZpL7PBbGWsK99w+Ym5vFWv882+ear8mwDKsxJ9sGYr20wOtPvTmUVXD12GXe0U+PIGthDD+C84UvWLoHTkfB69Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFszKneDAsPzyQQU2lrXTXgXbnGD1diZihtepLTpqYk=;
 b=bOG9psJ7wv4Wad/5aT5wMj7RSE1epv2hG9p4CAymqaGA+yvmfoOvIz7EQPspMjaUeiSFtzOzPKntooBLodo9UCTTwsDcDG0UKuWfkph6i5U1/1fVOk664GFo0z4C0Zbd2QJ/BNy+krJ7No8rEcS4eRjFPJZ3gq3kf8B3UUiUoBCchYInll74XQXAtDzRj2YguxQB6K3IaxbEvRH5cpxBC+qUNCLGuyssHyS6pTInQwqhy1AYLt2x46ZQb0viSlXGBok1EQUSO3ya8HHm3xccnu9rUlRCe5575GnMiBBcj+ZGkfwNQnOwi5LSOpuUP/SzWu9eOHPApc5/rVy4WeUitw==
Received: from CH2PR04CA0028.namprd04.prod.outlook.com (2603:10b6:610:52::38)
 by MN2PR12MB4191.namprd12.prod.outlook.com (2603:10b6:208:1d3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 19:10:48 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::9) by CH2PR04CA0028.outlook.office365.com
 (2603:10b6:610:52::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 19:10:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 19:10:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 12:10:28 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 24 Mar 2026 12:10:21 -0700
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
Subject: [PATCH v8 1/9] PCI: tegra194: Drive CLKREQ# signal low explicitly
Date: Wed, 25 Mar 2026 00:39:52 +0530
Message-ID: <20260324191000.1095768-2-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|MN2PR12MB4191:EE_
X-MS-Office365-Filtering-Correlation-Id: f92cf6bd-ffb3-4fb5-c819-08de89d90eeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|82310400026|1800799024|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	nrHcVzIY+o2qaI3wieGUopWZSv6I8pa9vKsrJOgS+22TitiCJVAugZ7Nw+m/PuLMPSOssZ7eB72FqsE6vkK5+eWHF+HXYLH+wx22zvCdHZDIhSZyzxZLdXbJRjdoGEgHCaBckcjGJp0bDKWN7TB3po6ASN3sJNkQC509gPavZWr/I8ZhiIWOpcwPFi8HJklVU93rAXmSrfhZJbM47G8pICEUH5LRvbjtWZM0BW6C9AAAOv8KEZcfWk3Q+QNmXE5jEpjZl5mIBcOuzwzPMB71RjLoWhYlx1ulTAp5WGBWIgsOxr5XYNGYFhJwQRxXmxbZygilt3FibcRrCiH3gxlhUJrWXs7ah+1+EEQkFp5+cl2FKlNweOH9sCx4AKS3YlKaAAmg0X1ao5S23RX538g7TSZUxy41ddA2VaoH736jH5+UDSnwymzmYMo0hYGivWhuNCvehqWOsH+ZoceJhQAfBbctPcxsYAOKR5HZp7RRDRQLaTZl59YN6VZwfpaQZqUTkk/emw7ChlHnav4zmF2U8jvaRKZG2T0aPGJ9TcCxyflcUNQlOy6ZY4QP94faYmEz2hulBAsdEcX0YXmZJ5U+TA0ks+5Po1lBOQ7ZhW3Qys7kPpUoUuzxNxJLI//JDGFHjbwVjDlI/m+ieaIsENLqmUCMXZxPHpIVP466Gy4G5ep8szY41YIa8QzVnc+Yd5nuF0mNq41MawyJtYG8prH7eHkVz08FVbcXm6Ejc70wwzbJy02jWot0V5Wo4GrwDpK/hq19IvHHw+AEgOz+K9BsWVNtNauk5oK9ODbJykm9qz+B4AgVZQnml7+gUVPerxGu
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vTyb1YVH/jx3GZXNuo+IakJz+pWhBHCiN+31sTReUIP043a5NOteCnDFV7ht5HHSiWPivppyvdH6+To45GWLEEXZO3rphiIsAECXQkHi4QP/IdjRNWyGLng4d4ex/OFdbcA1Z2XCI2mk1PzViAcGAPT/Uo+OnTSrNZHfaexS5Gmb7ZAzw8wqHRvy7omL7Xv0g+S+/3vLwqW0JqEk5fjpAIfl4sXdl8ZTaWRw5/9DWzeN5RfgpND8DE9L67XnhKaaZPC92ex9gGCxJRIyxQpCVvoE0gu7sC+im2zVakceMzmev/6Wb/7Olu0c3jZP+YXmkdgu/6pRPvvlHuWL8xM3rxYQENvJMOflzS3N1J+4Le9lST1qkSyHSzWVPhY549zYdNOkqEpHLx3rJYpNsAHQlv9Oxh+sgVdTx3m2o5rOMUifc0l2Y4ZMOPCyL0CwVf0V
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 19:10:48.3130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f92cf6bd-ffb3-4fb5-c819-08de89d90eeb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4191

From: Vidya Sagar <vidyas@nvidia.com>

The Root Port's CLKREQ# signal is shared with a downstream PCIe switch and
the endpoints behind it. By default, APPL_PINMUX_CLKREQ_OVERRIDE only
overrides the CLKREQ# input to the controller (so REFCLK is enabled
internally); it does not drive the CLKREQ# output pin low. Some PCIe
switches (e.g. Broadcom PCIe Gen4) forward the Root Port's CLKREQ# to their
downstream side and expect it to be driven low for REFCLK, even when the
switch does not support CLK-PM or ASPM-L1SS. Without driving the output
pin low, link-up can fail between the switch and endpoints.

Clear APPL_PINMUX_CLKREQ_DEFAULT_VALUE so the CLKREQ# output pad is
explicitly driven low. That makes the shared CLKREQ# line low on the wire
and avoids link-up issues with such switches.

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V6 -> V8: Fix commit message
Changes V1 -> V6: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index b497b178bb7e..c823285368f5 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -44,6 +44,7 @@
 #define APPL_PINMUX_CLKREQ_OVERRIDE		BIT(3)
 #define APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE_EN	BIT(4)
 #define APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE	BIT(5)
+#define APPL_PINMUX_CLKREQ_DEFAULT_VALUE	BIT(13)
 
 #define APPL_CTRL				0x4
 #define APPL_CTRL_SYS_PRE_DET_STATE		BIT(6)
@@ -1428,6 +1429,7 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 		val = appl_readl(pcie, APPL_PINMUX);
 		val |= APPL_PINMUX_CLKREQ_OVERRIDE_EN;
 		val &= ~APPL_PINMUX_CLKREQ_OVERRIDE;
+		val &= ~APPL_PINMUX_CLKREQ_DEFAULT_VALUE;
 		appl_writel(pcie, val, APPL_PINMUX);
 	}
 
-- 
2.34.1

