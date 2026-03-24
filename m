Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B183BC67C;
	Tue, 24 Mar 2026 19:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379462; cv=fail; b=HKDBXV8Grn1vsh2eMFygsSlBKPKHCfXLmZ3Os2pl/TRDo4GEMoPxzk888jcAXedlBFe3WqdPGxsVMVoqTcQ6L+nenjQ20lqTVlhNkvSn0cu+IeLhK4QUW2XKx/JWcWqLY/QLkLYsWWGZxjVFbgQEnC62Q61TgR2laEi9hDBBb2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379462; c=relaxed/simple;
	bh=WanZlmtLoJ5E+i/Q8l5ed7RNWqVgUKQ9VZWvp2HJsHA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o2p6yxoExm/HedJaiU4mGbfKFJlcGV+dIYgQ7yQwOeREOS7YQD+crhUV++8HZT4g84LcPAZZMfs8UJgxYOV5RbKDy/6pDgZSNwIytgbcE7sQH+v392z4ZiOQXJtMmen8JK7/cnykeL+xWFaOQN2FCHVuEzTnX3fujM6d9O1EjwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hdqbZi06; arc=fail smtp.client-ip=52.101.56.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hdqbZi06"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YS8WGaG+eHS+nKrZCDmrVFMfiEKY/a5ZbkZfoN7nYyNrJ5YDK2kTWVoCIXQhE7WTr8NPHCBkn4iH7RGom22WmA5CbsxXlngScRCtlaJmtyufw40jOK7j5t9NfCNOFQGPkH4zKxbPYdmFfKqgtXlds1+o2RRnOctfu65FyWyoan0eoo4K2liChgAVxN1wdbQ2UUPi31/w+AhmoUcJEJj+S0oOI3aMdlD6CB4iN/mouyljzMkXLoBUdadPUXKPylE2cAE4f7wTBdyiuarMzxbS40CM6kMBJ0Rq387P9WEW3Y6PbMYNhrxQCNspAhrqU2Ocfk/unBzO1pVXDLz+0GA5tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrXhysgtloCQFrt8A7t/G0+qqIYfms12Jknw/3YCQJU=;
 b=emnvhEBN6dEU8av++Gx4BdjHU0MG1IPRYpD0GXmncove1hgIolsm1z6bJibCJhl8V/4PvP6yiBlGxY+TgLLlgp1bQE925AHbbkbj4hJZnpm+K6HPAwMkb44WFOE8dwZz3buuCvrft/XFD5rIBhMSbPbvXnxEGjpc1uu5tNtBHNvaEdochGqPmu4Bq3VwHODDOTsZnsqgAm7Hl3R8dvCIpVV42merBNXA/EIQSiiaJFrCNrCzOr0doy9IzZzAXaba+QIuhvff+POAZEls2PRRCzWcBU3P1fODjvX1gijtzSZkbXLXgdJymwDRWwSocZuEAkVhe8aaFVve1ZQ/LuCRcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrXhysgtloCQFrt8A7t/G0+qqIYfms12Jknw/3YCQJU=;
 b=hdqbZi06eLXY7wV3fZVJTM9v+N8khtwEztRpagGo7uEee8TefQegvkBhmcF6nfj3BUMr2g4sffgVoqkPxYIOMN6dfVuEANWHNLdX6DJuiqDW+c2ipB5iTM3Jl2Rh7JnQlUfzfvEkPs15Yjq01lS9tKdKJTXROo3rv/b2V5ayOZsVX/lpmqW2Ng7+cHI3Phrr+LMWRWpDfbRRFX/smsTNzaUW3GF737TLD6CyayZWg/d/oUYBqtIza5dc82vXg/e1/3lUgt0ikSDCkpIXHMRWlIE0Oofc9YkXsgG5AY7M5FcK7jQ3yrExsZSr9+llM46a/OU2XAngVtvfHHpalVeh4Q==
Received: from SJ0PR13CA0066.namprd13.prod.outlook.com (2603:10b6:a03:2c4::11)
 by SJ5PPF816B88375.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 24 Mar
 2026 19:10:54 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::eb) by SJ0PR13CA0066.outlook.office365.com
 (2603:10b6:a03:2c4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 19:10:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 19:10:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 12:10:35 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 24 Mar 2026 12:10:28 -0700
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
Subject: [PATCH v8 2/9] PCI: tegra194: Calibrate pipe to UPHY for Endpoint mode
Date: Wed, 25 Mar 2026 00:39:53 +0530
Message-ID: <20260324191000.1095768-3-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|SJ5PPF816B88375:EE_
X-MS-Office365-Filtering-Correlation-Id: 395280d8-fec9-479a-b3bf-08de89d912c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|36860700016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Lw8mqzZ7+EyKQ5VMwuEM1Px2jGIkEdGR6RgZxcY8LMb7SyptRBolU20dnTyaAsav7bGBKLPMvj+HfxUxyRF8Dm+ixnzzXz2elRS/pGGbZUoA/eUcbf787WWXW8OUZqGyDeMiUYwIKpOEjb+muOSVwrvimqC7AklKRImOimk/ZgwK963i0QBNUmXM7t1oJwdoVoDlE/DdVLZkIzslA5AsvG+0tm0ypPcFwb4OuDAFd/VM9/421X/55TXs4I/1VnuikEVa4ZJaPEMvD9zz0DE+sncAsl3rgNTlG0UrawKmJBfg0NP8hB1ayV2XPkNBFEJ/He6mnsx8FzzBKOPC5mIs4ZZMijmmvO9UgGGMf2PXCLQnz9QIlh7MwkdiLEY8ARPOcVezBpIU3+n3m2KaEqXHYnEWjCbntqWuTGwxYjLnczZLyNVwtQExwhaRAPeQKN3G+Z//3/OmwlTMAm72stnAsPvMUPV8E7yyEsBXju5HUWIUvKZsnZta1UL/PK26cb5thIL6SHDQZaIMxHCcpT0KHU5MUr+CEcsDME7ankIYE82Zg8Ly23ovZJJXb33pzFhahGfLsorVYsEuZcHe95f8COUS4d53sLrYFInMlqOllttC4iZ3uZP/dEzwumqeDVaBX7zVd0dsOugp0HtWit4q5r2pDiTcpJ/hzu5x1vcyEcQju+vjxkHdrFR27hd1biWXlvyZHfUlze8a2OgTY4PZpsyCobuDtWoq35qR6ic8/5kRM3OBHni8NHV/Gbskcog97dJsKgu71QWSxHIGTnh0jCOhzOkXHv/+qi8Mtxbde+GIJgcUReTKrFz4Fa0ST2l+
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tc4+qpGaW31cTMVMIlSykfApwKFrYxqKNixP90vjh9tMxBgGW8f0Sdq4CveeDd9+ondkqnO0X0GrrOiO+XVxBtwh2vdPm/xSPo/Y9gbu4XSsTnzWZ93GgAPwH218/bD/rK51tbGhQffFz4terpxirvHyoNN4TbhvpFZzorod/3i0Fa8DY/YdxTy7FQmvXaWzMVJRbZHEyNKcqVADqqbHmtoQbex+d1lEywRBzhThbHu0FJV8l8+OCs21PDiWLKdPhQX9YzN9rb/ZNuePnkmZaFIEOsnVnvKFloFuU5hW/RxhnYr561jhPmnmaTCTBSSxWHjElXU8TlX/CVfwBJymdyH4UZrxr9XakvyM7/4ebBO5PDQ3tWe14D7oKQ+ytWjVZk/6pMNca7hXgz9dih9RGdMConbRqT5mfM3p04IpC4bT7L+1K/fWd2G9t2q1hOyY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 19:10:54.8729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 395280d8-fec9-479a-b3bf-08de89d912c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF816B88375

From: Vidya Sagar <vidyas@nvidia.com>

Calibrate 'pipe to universal PHY(UPHY)' (P2U) for the Endpoint controller
to request UPHY PLL rate change to Gen1 during initialization. This helps
to reset stale PLL state from the previous bad link state.

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes v8: Fix commit message
Changes V1 -> V7: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index c823285368f5..37fcac55838f 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1071,6 +1071,9 @@ static int tegra_pcie_enable_phy(struct tegra_pcie_dw *pcie)
 		ret = phy_power_on(pcie->phys[i]);
 		if (ret < 0)
 			goto phy_exit;
+
+		if (pcie->of_data->mode == DW_PCIE_EP_TYPE)
+			phy_calibrate(pcie->phys[i]);
 	}
 
 	return 0;
-- 
2.34.1

