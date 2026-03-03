Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010024.outbound.protection.outlook.com [52.101.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B530D3859D4;
	Tue,  3 Mar 2026 06:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772521021; cv=fail; b=e83vMYVXqe/Id18XmRFlH2YW4gsAfZXEJjHvMZAwrWjHmsb8fflxcHz3sHPFPyeSwANpiKikfFoBk2ZM/hyAzf6nRt/72WWLwRrQI2QCDutcr12J0yX8damSlzrtqXYPjB7oevrAIxfanqS7GhRT/UPK4mwLXLuXpXLtuDmlCgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772521021; c=relaxed/simple;
	bh=/BSRqoNw1ia8khKe0L7l0QhPSezijHsxWvM0mNZS6VI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDRVOztbRPotQCI9pWHeukBVc0wW1KzYF3Xrq9g30tc0V//0QCyY4Y4QT8Q0b+YCAgGjbfITyfL6KHy4rBVDFXFq5x4GT/otpKvbvU1WrrpezmOaLrDx/zTHXDP6UUgAh891H42AdutmmArwIVrpfwY74qevEYTQlMTUOclzrBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HdDLBDfb; arc=fail smtp.client-ip=52.101.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HdDLBDfb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wGxExcBSPW77CdD9ySit9ltOyfAgU3NMePk4XCIR0+LZFLWLrDJvx2ejYrcyQnuTUKiu5ZtIVYr0JYJiXTufKTdjCKe12Jmw1gg8sxIBPBNILLbTnHCw45FGOk1FtlYq3qfZAjXNswI3M8d6tryMhhzgn6p5bY61rQc3InUO+OzYg9j8VMH4om+SbneLSgNjhjHBMsWs+tBpjGqeVSSQlXUwN31UELjl6FTnVchUmH3KZjbS/X8UTP7rj6/hwaAuuhnLQBW1rjWq5ZBj+Uzu77SsmvePu65uOH9IDC4xaCWZYlSlVcVSLQbmzzVHjun1+8iJyFp6QwBgzsu0huJqGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YBaEZABFmaZ/Ip0SrvRvRXI/uqXp84yhbD9C1xeGoQ=;
 b=JnyqgUwKVGwIIOzaBqp/9U8H8KCLnjp3UNLTTRZf0iMilpKgcaVUIOyn5ONzeGN5YT2+zhC0rKsbCEfW/KIf/O8cwZjcHk/c9bp/sUb9SnpoTyn1kxy1JDJ7ZIcB+Pzl0F+UHLenMBUo+D1Du5N998bKdfqaNfAhfo/khCf7q8ggJQ1f/KhHReMsNJ2g3PWahSukCCh6RLGFx/N4Wx0POblo8WMQj3G8oes3rep2qBBwuBmfg/N5ONWb22e4E/fjq+1bWdeO4eHOAqXG8XK9ErW77wZVyBa6OykYnhI2WHtZv7m5D4eFSKY5KazhDUPVtxQn/UioyoGCDsdJ+oFhTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YBaEZABFmaZ/Ip0SrvRvRXI/uqXp84yhbD9C1xeGoQ=;
 b=HdDLBDfby9acmV4td2Epz0RUZCvdcoqOQtKfff5UjiyexBR6JXcFQxLo/9rgPefWR39Wx3LpsGo1B+NIEy566DQkXYa8pK2yA7FKpenKoyla6cqSpaBjSS67EB4NQ9mhwAjkOC17EjbOUbt03WjMTTpRYV49pdNo+gmKYdv96w4qs0UbTW9sjezk3LpUm9WPK476SE1PgczB4TcAIWdZ8ep9ivN5+qXI99b5NtdkbBQV+vTmJy5m6vXHT77PV1vERoH/1YtoSe0wD3Q9aHZvCwYHVs86eVwiWwizPmqg03redN3NkozmZulYK6InK0cKTfRoz9MKaEPEFWCWBFx1tg==
Received: from MN2PR01CA0046.prod.exchangelabs.com (2603:10b6:208:23f::15) by
 DS7PR12MB6024.namprd12.prod.outlook.com (2603:10b6:8:84::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.22; Tue, 3 Mar 2026 06:56:53 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::f4) by MN2PR01CA0046.outlook.office365.com
 (2603:10b6:208:23f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Tue,
 3 Mar 2026 06:56:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 06:56:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 22:56:39 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Mar 2026 22:56:32 -0800
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
Subject: [PATCH v7 12/13] PCI: tegra194: Fix CBB timeout caused by DBI access before core power-on
Date: Tue, 3 Mar 2026 12:24:47 +0530
Message-ID: <20260303065448.2361488-13-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
References: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|DS7PR12MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f7d1b77-5e9a-48b0-d472-08de78f20d45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	IeDb+8vc/abQGuZ1WuTiCVAidsDKDqmnOPhZvYF1Y9+O911inbZIDkVmKnsYZoI21Yc41s9Achwru/YcCfzz8AZrHB7m54obseUZrnRuojlXM8ZE1xj26UkP4TFS9/jIP4LZom+k9gaX3iWD6aqcLFkyllMbUvFnNoVizT5C/mc5pMPxrIj1XEFymge7SwedA9jTDsVFlwOO4wjtLCdaaoYCRx40I3gWGsd3hN2XVgjS3rcd066zeufjY2sYy/WKsmHNVUYOvII4oj/Lg26FgIDXc+MsoHl43aTrHhAw4iPCXaP2zYpU4W95+KUMA0C8KxJc73CcPDsRa6vV+XiQypnvdjs7i6UiI/hs/ECsRh6tYc9zEZpo1qqtPHHFzacnQgUYxcUhz14awaDERFJkmCw5Or5lXQ6ou0Tu8ng0ZTEC66NO3qv8HDA4HwDap1tcpD8K21XCAufl7c3ydpF4Q2o7JHyWllU+k8GQ1EdKwcL6xVYRZQ/WFRKyMwmwDfAE+NZXFh/lmDIihar7BpZxMqmiWOqsq+inhRQeZ9JsIBnwNhpKANT3H80/jA+hhgXD7ddFsIdbvQlSaABmpVaHU/YqWpc5bz/co8GS1srXaZbbmJ3DNG2Vw/iET2ttYAhDcH0EPVORWl9PpKkJrH48GLXs7nuGQAOguqLeDEq+zPvRghJh7/lynfEw6ibAdxxzDE3S9mQdLJyWzxiIL/80OjKRyakT4x+Xg/ciJtcPHn96btEB8Ml6UibQb9q9hiahTG1Q/WctBOp+Kaxv1N56fnZZvwSA4oIXx7nLjhPe3rwIYE0EdSjxmWd9hgaUnzJGb1A+u0kPKRjAQkcYB47g2/rMPGc//RqKJhG/GGHpVC0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VF0iROJF0FhOSbfzrpuALU3snGtdqv+rYDpfvW9+s0VX/TCbR5aqHdh/Fpx9sYCaaaf/1Riqv9lrJG/mEBDAPhXb4/+E0CmknrOIS8kc1qsXzsLcMTMqU3MEA5NaOVBvRexg5gFDoEq5l3tPgwctPVJvWB9xbTzaJ0U2PEk0/CSqgNI+GV5s/5xzr3bXxI7EY8DUhXNd/HSfmnnQAvpRqfcFXAgtW2iixBR3XR26L8WJI9rDV2QbzEb3hLtVsCFW+p+y6q3lKsELLesuagvYmleSN0a9UyDKAqrxdnovhpvGSe2o2UnE+Hl+85RLmsK+BNmAvDUYgN5+zbW27fLu53qcRjZla6WBT8hvFLyd0HJ8TF4yvyhSL3M2/ZVL3/OuzwGQMo8IvXAIuRlzfks3ModOu2NqCQpv2axApV4hGnSYbiHzZ723IIV1VstmzXvM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 06:56:53.0866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7d1b77-5e9a-48b0-d472-08de78f20d45
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6024

When PERST# is deasserted twice (assert -> deassert -> assert -> deassert),
a CBB (Control Backbone) timeout occurs at DBI register offset 0x8bc
(PCIE_MISC_CONTROL_1_OFF). This happens because pci_epc_deinit_notify()
and dw_pcie_ep_cleanup() are called before reset_control_deassert() powers
on the controller core.

The call chain that causes the timeout:
  pex_ep_event_pex_rst_deassert()
    pci_epc_deinit_notify()
      pci_epf_test_epc_deinit()
        pci_epf_test_clear_bar()
          pci_epc_clear_bar()
            dw_pcie_ep_clear_bar()
              __dw_pcie_ep_reset_bar()
                dw_pcie_dbi_ro_wr_en()  <- Accesses 0x8bc DBI register
    reset_control_deassert(pcie->core_rst)  <- Core powered on HERE

The DBI registers, including PCIE_MISC_CONTROL_1_OFF (0x8bc), are only
accessible after the controller core is powered on via
reset_control_deassert(pcie->core_rst). Accessing them before this point
results in a CBB timeout because the hardware is not yet operational.

Fix this by moving pci_epc_deinit_notify() and dw_pcie_ep_cleanup() to
after reset_control_deassert(pcie->core_rst), ensuring the controller is
fully powered on before any DBI register accesses occur.

Fixes: 40e2125381dc ("PCI: tegra194: Move controller cleanups to pex_ep_event_pex_rst_deassert()")
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V7: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 1c6543341fb9..a311c31109e3 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1726,10 +1726,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 		goto fail_phy;
 	}
 
-	/* Perform cleanup that requires refclk */
-	pci_epc_deinit_notify(pcie->pci.ep.epc);
-	dw_pcie_ep_cleanup(&pcie->pci.ep);
-
 	/* Clear any stale interrupt statuses */
 	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L0);
 	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_0_0);
@@ -1799,6 +1795,10 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 
 	reset_control_deassert(pcie->core_rst);
 
+	/* Perform cleanup that requires refclk and core reset deasserted */
+	pci_epc_deinit_notify(pcie->pci.ep.epc);
+	dw_pcie_ep_cleanup(&pcie->pci.ep);
+
 	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
 	val &= ~PORT_LOGIC_SPEED_CHANGE;
 	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
-- 
2.34.1

