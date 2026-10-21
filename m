Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792563312;
	b=jAUBtFeH2yrCyRcsf+m32bM/EMdKwvcGlKYODHKp1LGsMEOUrzCk3eIOdUjCYvST90c7
	 xL3HN1+5sLeEmVYcVDuno0F9MeAn/qGC62puWpTuxf7HzqTdL4p6dsrEYt/o8I9neg2ZC
	 vhhpQfsM3+GfHOtBU9ap7N88Z2stWgZqZqT9OUOLXGuxcpfSTo+VFt63ZZ4y8yf9G3Onc
	 5mTilNzNZC3nH83rNN29ctu9k2aTb3cZ5NuV8dZthzQXpcsx3Jvnsr/zJTUA4xuAf/NJx
	 WVhU0IqhOM06yKbAl8VPhmqjcZzL6SM2IRg4Xe0gwQeGf3uQDWNXOC0dc4itXzUy8Uw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792563312;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=khS20X0BgRrqoGS7edy2n9TDexYRJ+6xu66TiMUNERA=;
	b=DMwZc9JYiXV5i7GB3y+K+3jXY9QKSvxyKNUM+3JYVFcAfTw9/R5u4Arl9RrgO/JcG8Qf
	 DrEjLOzqa897OhJU6Rhzxno7zU5BAJ4ZFOyjb7BgsASzuuKLo2HPAAFgaATJjRMj6IPdT
	 LwpMiDhKjlVb0bqYD0jojBCweXSPyIw2mY5RWloBsYlEU7DwzVFJqvfFaX3J2yFgf/0P2
	 /wbriuWgNfJlFF6Ltr9qGjs3bKPEky2UynOoO2LswxtXCY2v2VcihLr+svKwr7ExdERYv
	 J868cOtt7kkMsV5GHz9AMwq/bN/WVD7ux5e4xM8J5DrMGWZq2fBIZVZ4ilqyXkdWh+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Tdpx9S2w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.68
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010068.outbound.protection.outlook.com [52.101.61.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB69D606A320;
	Wed, 21 Oct 2026 06:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB69D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Tdpx9S2w
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kb7i6TBjDsvonLx3PgZ5ek0pZCY6bvDjr4O/dj8ES7s+y13ips1hkyZ541+H6nV+6AFNeGsZ8r7d7wxpTicA+KZfX00shCJN89oZac+tzjZ0BoZtPs4nwv58nJyil9o9W5ZglnIF4g6Fa/+217rE9xWR0D1u1JyNC8Sf+VIMv3ZQDA90uXFzK1dIQAvvoZzSvTsi3WOkj4DuRd+FZKEh71Tz6LVq3E8PdsPvw2jfEu8SN0EEg9oOUjKI0uDZ/xeuSSoxLWKjrX+N5xI4IFGAE5+ihZZlh0E4V34bAZN//qfTy8v8ysjtaCa09myJ5lgGotFMGHvv+Nc/sCrtY9ag/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khS20X0BgRrqoGS7edy2n9TDexYRJ+6xu66TiMUNERA=;
 b=j66Qx1GiycokLZ3M0o7aMTTp5hHK+o1RvpU08xkLDOpmN8MS3bSxTGMHeaqfRSV6A9p4FnkdvUivaVgKl09ACI6HX3KebPaRiyY7zmOJWMhs5uJ80pVCz6n9GyyDjmofGZa5CBgLHlN2PSG17JHOAJ4PPZ04/aOVp0EJmRVZqZiT93RFzbksAX0gTLT9kLbOoYfpqCi64F1+ncb+3X5juNP3lAB1mwSyCqdYLgzGXM2on0nTqoddX9phIGuxe5PnQqliyzK2lIbChRnPWDOMnL0oD4PTE5K6cpRKlqIHttVCGy0htdMJ+U4FeJRiJ1CABBWFyebEHQFt7QuZXqaJtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khS20X0BgRrqoGS7edy2n9TDexYRJ+6xu66TiMUNERA=;
 b=Tdpx9S2wvwmTXPBSWwr0dzd7sFxIVLmR1nW5L8CKL+MHdLipNRA/nTcchsizAs1j9q6L/0hVbDXHcYmTPXkwIZGDPlVKsPeArCUHBrb5WDBkHN4aVc7qR9/mw28TAzkAKvKyuxA3cHKVQ+Uae9CcHamUN3PJA96WWw1vMHm/zfT4ch0aqoEUnNlPBMuVR7F54JeK2KL1rzgFUFIeAyGnlPeIfuYuI3mgPypKeM9QMlduO/Sb5HKtTypsSVmKxfvL7nfaXU/w/NE3WXRw7+9Qs4Dma8X1jV2PVGhuQifBLhQU3HsUHl0HLdhL8hQZWx2ZjCKSsARKORiSzNIlvyNWcA==
Received: from BL1PR13CA0357.namprd13.prod.outlook.com (2603:10b6:208:2c6::32)
 by DS0PR12MB8293.namprd12.prod.outlook.com (2603:10b6:8:f3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15; Wed, 21 Oct 2026 06:14:48 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::1f) by BL1PR13CA0357.outlook.office365.com
 (2603:10b6:208:2c6::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7 via Frontend Transport; Wed, 21
 Oct 2026 06:14:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:14:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 23:14:31 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 23:14:25 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <Frank.Li@kernel.org>, <vidyas@nvidia.com>,
	<cassel@kernel.org>, <den@valinux.co.jp>, <marco.crivellari@suse.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mmaddireddy@nvidia.com>
Subject: [PATCH v2 04/10] PCI: tegra194: Do not skip no-link Root Port remove cleanup
Date: Wed, 21 Oct 2026 11:43:43 +0530
Message-ID: <20261021061349.1265704-5-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021061349.1265704-1-mmaddireddy@nvidia.com>
References: <20261021061349.1265704-1-mmaddireddy@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|DS0PR12MB8293:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cdd00d1-9a0f-4931-ebc8-08df2f3a9c38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|36860700016|1800799024|82310400026|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HIl2FwJB5XkgIbv77JQY+0H4xwu6TEpG2kMzK25FoZYxWjWp9E8t8pWN98snvAvD/rk3+Vppx477nEePSnPGtneeofW3TEK0A+uo601bAX8bMJRVB0v52MhkYGlt4PPzQDUhDZ6UPLMPADFCBENbBC5DrGa0g7it1AdO/GMPxXWXwYY+3w8l23ZG7EeLrRilWzVggdM42dpsas6Uod6NJnjBZKgK3CpAb0tUP1YYoblTP39iyonDegZFcY0EZiC/oz41cYpv5rxv2Fhd3piQ2LpUzy0QvjIz8d8vJa2+k5Ziu/Uot/DJxBX/TusNjeGMTA9u2heLYThsrJBI6rSIdBrs7W/1rD2K4AtlgUp2u039NKTm3zDY1u/oEt4425br14Blxjs5mZr4OMACXd401+wCHsv/QhW13QBpkT5P+jCNvyb2lHF2WA/XXdp+C/uQfXZsCqc53v3AeVrsQnFcFysfnKziql+zljgRRZFylxm2X8RkhOzG6nQ5vI/1bwPWNph3edLLG/5w5nPILbPigF19NGUa29WkMkYVxc2tFK0q//35WLLXqJdfbeBjoKPnsG3s5k9aqdgXWT7Ud1BY2qbuQQvtdX0l+novSM1VHLESvwxIIGW7BM0ve4OoUXVLYkoxSwcVO2VcKhO2Mo7BqcaZoWxIuni60r8t2RGa/CbyGqFnxVcKhYA0RPmagWea39Sy22GASaiSs22l92S6sA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(36860700016)(1800799024)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	41WvUF9PES24zfCq/GWb1QBzh9xOXRBASEiTReMS9LGog0ndt2FCTzzK+0pIPRTnbR9TyPK0pdYHWvww2NsMLCqxSprKI/iSvuOZEmQ4c4DTm9QAU2gVRKhW3rvR3we+vhF/VMDYgYwe3fQT6q7FW5Atl99ENmRewMsFfLGTLoWLl2wqv9+01IjMsTCX+JKTtXipgHJ1RO1kByFBZiIuSU78z2dStkLSe5slT6XmipUjN+G+I6HbaxJGZr3ifx/Ya9f7QdHVeINJTLB3Gke59R2/qlPLxaB8Dyf6JGKAaBqYYa6icR4Ox3iHFOMqSh9yDZ1aKjRc1pFRliQNcNV94GNRhsLGEk7UALoIxeC6XvnudNTLP3zmBYWVUanKzpotwPz4Cz3y/cZs0uI8XpaVGv0NOYe485GtO+Zifum5ausJDBGfN5CojwsZhSqZYdXq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:14:48.3800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cdd00d1-9a0f-4931-ebc8-08df2f3a9c38
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8293

tegra_pcie_config_rp() deinitializes the controller and disables runtime PM
when link training fails, then probe treats -ENOMEDIUM as success so the
driver can remain bound without a link.

remove() returned immediately when the Root Port link was down. That skips
common cleanup such as tegra_bpmp_put() and deasserting the refclk-select
GPIO. Keep link-dependent controller teardown conditional, but always run
common remove cleanup.

Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V2: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 0f895c766a71..fb8084cef38b 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2352,19 +2352,19 @@ static void tegra_pcie_dw_remove(struct platform_device *pdev)
 	struct dw_pcie_ep *ep = &pcie->pci.ep;
 
 	if (pcie->of_data->mode == DW_PCIE_RC_TYPE) {
-		if (!pcie->link_state)
-			return;
-
-		debugfs_remove_recursive(pcie->debugfs);
-		tegra_pcie_deinit_controller(pcie);
-		pm_runtime_put_sync(pcie->dev);
+		if (pcie->link_state) {
+			debugfs_remove_recursive(pcie->debugfs);
+			tegra_pcie_deinit_controller(pcie);
+			pm_runtime_put_sync(pcie->dev);
+			pm_runtime_disable(pcie->dev);
+		}
 	} else {
 		disable_irq(pcie->pex_rst_irq);
 		pex_ep_event_pex_rst_assert(pcie);
 		dw_pcie_ep_deinit(ep);
+		pm_runtime_disable(pcie->dev);
 	}
 
-	pm_runtime_disable(pcie->dev);
 	tegra_bpmp_put(pcie->bpmp);
 	if (pcie->pex_refclk_sel_gpiod)
 		gpiod_set_value(pcie->pex_refclk_sel_gpiod, 0);
-- 
2.34.1

