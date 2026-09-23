Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012065.outbound.protection.outlook.com [40.107.200.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201FA451985;
	Wed, 23 Sep 2026 07:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148421; cv=fail; b=pPImasiLH6YrJLVcWi79pPR+lV/WPfJFcIwuiC6TOaxp7pdT3qXzvIBBdDYLQvqlUzScmssJJj3RuPOkWT0fjjK0raMPFw4UJjyZRqBhuGVVYYI8eRhSbZ8ttSWR++woHRshHT9A+A1/sSNln50wBQy9UQWSzXzda2/Y5mF+4ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148421; c=relaxed/simple;
	bh=DMg5uSU31puPXD4SInDa2AN2+kDnLKGp0qdaklxhvpQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mtnr03+NLvtoeDLBGo5teNlzlSIEYZOXjoCzbuEplrUsZsUzPtCDmDo5ztQhRcQL2zO0g9IPjh5/0KK1Tbfv8WNnXJ6tb7vQfcHGqpWeWU7dPFbTq8SDag1FFVLeikorzdLBOEwdBID2f3hB16ipQTU/KGdOw+Rol3Dailg2eNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qAplUTmg; arc=fail smtp.client-ip=40.107.200.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qAplUTmg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SAOFazwxxnTXIvJdVFo9BIcFDVYhm9Fr27JsxmfCgzDd6pGTk7PYZ3tggQd7kXsUHqSDjFNg+nqm+g9FAi3wU6W14ky0+LrlFue7jvTFtTx61f1MvJVIAlZ76UWnpVz89U3akSy0Obc3rNw9ndbNV+A3X+jOvOoNCyulRbNLY/KRDb7pBE4H/Mc+lnXoAGCXtpM1GY5+x3N63Yw1kTBKOIJf/n+r+WSkKboXP54WWFajBKFwjuTqmyPW7vNr0gqoZ/POoDIE4Y2rECpli0Xu9gjQr5iI8OlszyWNMSVyR5DKMJfeTlS4yKU0mwyc4mUAqG4KEt6KlO8CymFT4zwgkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FY8x+amPTaYDb7e3HLw7mjuJZDb4tBwo00m8M1rhlg=;
 b=bwkV3norJHfOVZrZW4nQlwfJ4UcqkNMjGxm3Mb2TbCJjW74so+PdE/B44SJlIzk85ngwHi+NEX2ffOA3URXUn7Im2lG7Q6MHzJ8O1NB1Baksegg+nENFhkq6YOFHBVJgJjzki1Lrf40+ZK3IkxU2W04WEqvC1tVqiRV0tnFycVawuv65W+xmcOXz0WmonT7jXLO1SbDCg5f8OaMMEfhgPStOv8Z74hWwNbuxYzD6HJGE0FT5e+RHD0DFCWBAkC6ViTnmjyYl+9gTniaj6JT7I7Jcnh0wYbCJ/pUgOtXPtmn+jAd+JaYqmBbe7bLXxOO+H+aWmEGGK6R9uLrF154urA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FY8x+amPTaYDb7e3HLw7mjuJZDb4tBwo00m8M1rhlg=;
 b=qAplUTmg3uzUoPCUlc06E0u9iS93dvj7y42qHGEtBH6tNR1qSMaTjRFboOAuqqnqbzhwk3K/r8fesot2UfZKHTm0PTVoNMHq/zd4IM4u9lvDtl1Rswe6ylOB1t5eC+a61JvnKYMlG0MIh6PMDMYpXzsXbGcX7nn2iBNC7vwg+pf6uv6EZUXPprGPZXNxvCDkXNF7DGDUwgT3fg+V8Wldr/biB1RkiQH99XzbWPZ8sqQp+5LzHnDFat4gZe9L2PCATTqHmHvueR9NzJekqLxPO8d6J1AZQN6DNz4YvKOZOfNDbNXp2UbkU3EpI4Pg5HlTveOY1piV5PYu5+EGHWNmdg==
Received: from BY3PR10CA0003.namprd10.prod.outlook.com (2603:10b6:a03:255::8)
 by SJ1PR12MB6074.namprd12.prod.outlook.com (2603:10b6:a03:45f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Wed, 23 Sep
 2026 07:26:54 +0000
Received: from BY1PEPF000264B0.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::43) by BY3PR10CA0003.outlook.office365.com
 (2603:10b6:a03:255::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 07:26:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF000264B0.mail.protection.outlook.com (10.167.242.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 07:26:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 00:26:32 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 23 Sep 2026 00:26:28 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam
	<mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, "Krzysztof
 Wilczynski" <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>,
	Niklas Cassel <cassel@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 3/3] PCI: tegra194: Notify Endpoint functions on PERST# assert
Date: Wed, 23 Sep 2026 12:55:54 +0530
Message-ID: <20260923072554.1141864-4-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923072554.1141864-1-mmaddireddy@nvidia.com>
References: <20260923072554.1141864-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B0:EE_|SJ1PR12MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: eae0bee6-e070-42c7-7be2-08df19440b50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|23010399003|36860700016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	K2FjXLSgofFPiZ3STKd2jq6wbb4sKbmdJ5tKh2WP7j/SY8K8pUJFgl3zD5YC8xJysMhHTRMu71A3nNuRNniXecspNMyQFvNNG6uPxKJJcOOmXqFY2/F/TMOptpzQ9H9ixCCwoSzSWnDK/Yp3vFngy5wpvvMor9c3oQMKXBb1mRaAq40G1fiwHUOziqR2IzZBf95f61al/O+MS1KEQRBsmMxwgqLAe5oBTh3Cz+vevlY7iGW5uGpkwuGqY+VcMqxbcPBmRUrn78LnekSWMjGqrKwFaPlZkBnYz84SJI7Hz0SQd2NjLrCCfumedmBv+cpAu9HTWlUW9YqUGpqonIh2HWhrmnVkgoga+q42WX2pWeDG+RALauCBRSjnXC6DylLUSo5kvY8jDAFxHbeNiTI9XNDBY2FxENJWPl8uOvnuBlsfLJfdP0CtdwwFDbu/IRKByYzP0RvR0gT5I2uTr4WMoCr+std4zgXQMYrwZxb8iGiOVYcnx38oinvCNqJB2m0hZ6PupLZNZZjfdPQljbLhDSOP4O2S1oJm3bvbQrD0blINBeNxf4jchaAT1IawowYnfqPeUhaoDJEkvOA6p2On7LhF7jREcsHxtTXLdAYpaOBHgiAic8KlBkljtP8f7DOz4N9AVPeJEjceLKNU51sSrCsbv99U2QhbJLaBSpeUL2s3lScPmEd/rUZcNpFZU6kXozvC/eqio8pGMU6MCc25xA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(23010399003)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qbdb60tufGa4LFpba7IyuC7gLsRM9iZC4s+Db5E8Mgxu57kmG7Ry/PElYdxXXZ0cFjZzQkLbQ6EdZeVxV2BC6Kv9esaW3iB1SEq15zJoiXlLEQ/LruO70cHdChRHh8o97kVlKaA6RlK0EBUXc1D/BIZ08oELsHeZnvrIS/tXud0/GDKBi8s0EQPA7X2Am8jSGsIZf1Ai9viRWKFE9/UMQajwK3YMHDJ3oO5LzdrulVBUEYN5xoqICW8t7ZGfdhYMqsbuzUakcoZVXGqZydfz3O77bjRWVaXckSCklNbfr8cC46UV3VBZoLIulYUgsxVBh1OXptinv9+y31fg0Ysdf+4OkebkXgBsMAhJhfLvhg1GGWSGKqrDVqP97jDEVH0UmR824tRI4TzjgWllL1UxRURkLU6S3V80HTjt1bia4Hyb6oz8PtCPvFtSwmBF2k68
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 07:26:54.6825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eae0bee6-e070-42c7-7be2-08df19440b50
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6074

Tegra Endpoint mode powers the controller down when the host asserts
PERST#. EPF drivers must be told about link down before that happens,
otherwise remove while PERST# is asserted can free EPC resources while
EPF work is still active.

Use pci_epc_linkdown() directly in the PERST# assert path. It is a
software-only EPF notification and avoids dw_pcie_ep_linkdown(), which
reinitializes non-sticky DWC registers and touches DBI while the host
REFCLK may be disappearing.

Keep pci_epc_deinit_notify() in the PERST# deassert path, after core
reset is deasserted, because EPF deinit callbacks can clear BARs and
therefore need register access. If remove runs while the controller is
already powered down, pex_ep_event_pex_rst_assert() returns because
ep_state is disabled; that is safe because the link-down notification
was sent at the earlier PERST# assert.

The final dw_pcie_ep_deinit() does not require Tegra register access
today: Tegra uses its own MSI-X address-match window instead of the
DWC MSI iATU, and the supported DTs do not register a DWC eDMA device.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index dd3f4c30ba52..3e9d46850a78 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1724,6 +1724,7 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
 
 static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
 {
+	struct dw_pcie_ep *ep = &pcie->pci.ep;
 	u32 val;
 	int ret;
 
@@ -1745,6 +1746,8 @@ static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
 	if (ret)
 		dev_info(pcie->dev, "LTSSM state: 0x%x detect timeout: %d\n", val, ret);
 
+	pci_epc_linkdown(ep->epc);
+
 	/*
 	 * Deassert LTSSM state to stop the state toggling between
 	 * Polling and Detect.
@@ -1913,7 +1916,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	}
 
 	/* Perform cleanup that requires refclk and core reset deasserted */
-	pci_epc_deinit_notify(pcie->pci.ep.epc);
+	pci_epc_deinit_notify(ep->epc);
 
 	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
 	val &= ~PORT_LOGIC_SPEED_CHANGE;
-- 
2.34.1

