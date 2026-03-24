Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011065.outbound.protection.outlook.com [52.101.57.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D26359A89;
	Tue, 24 Mar 2026 08:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774339802; cv=fail; b=AzRfTwp40MiL5/d8Xj0SMn2r3ENdVrK1TXI46MIpBAty8x/pwkkLNma+aUmlijfByvpb3/8wm8S6vpIVu/nZAN2xp2x95UtlmEnjwXN3OrSo+Daqy+Ssvpt2x5ttGxU6+ryGPCJ7uPy6eJnJKKs5DId5bKsFfoWgDnKd+Ggf0vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774339802; c=relaxed/simple;
	bh=0WNW8fB1q2G4vpL68tFwOJIWGeAXXsIxFCT3pQslnPU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=twV8+Tf8vKRdd/lrzORkKowjAnfr4Ln84KoUxdhxovpsd3RJY6+oTwFLp0gnTZSyMzLBcA78zV+6/iUCj51X9WeFdlVj4ds0jcqgugxfuPynRc0qn1YPj/BC5Hzk1OIebZtzvVZs+d8dcJmWeQ0ScpDau6zt2MxX3CaTff0jFlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FNQ52uTk; arc=fail smtp.client-ip=52.101.57.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FNQ52uTk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ix6Ki0oj3kdLlNNhhzXJeQ58hAnn+UiAOGiJsDkMhCUkI2svMv76ptDMwHdfUNopC2dj97iwAWqgsdeWu8wbjRRGyJuABvA1ApeDHJxztSnzbjePwbnrKZg51in9T/fAjQnBwZSjj1bNyPcBPRTD956f2dbr75iZUbOr2UbVACzUr2CplM3BmfvEL/YMyuLySVqA4FxWi3OMzwQd0Uyq3n2PizZ69pQ0UDSyCHAhRy1vTse2OJXePwjXsP8bnTen3xogr7IkC03dnkhdXdoqSysVAxcRkh5nRovQzF97YYYxfPKDK1fyF0GwG1RThT3PkD45WzPbgT7k7q/dPnwXJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suZgK0CioOyapHc8xhD6Mfm4zxQYAATVcXm5Pu6pk3Y=;
 b=AEzhD4TdpHGK7WHNEYHN7L5sDrpJM6ftZCOCerv68rgPeHMupauP+L1JBUGJPex/dNsbYKWODcFy5L8FLzl9fN/TjtG4YS/RPp23JI6nsLJfbH4XpCngR6fmc7E8Oc6NbfvThneq5YsAJSsdigei/BnaYeItaqbPobE2is1DaPdHE/egDr6hFl/Qjtc7YGmGxc1U+hNkpPKXmwwYhRY8NNE4ZSW/bTG4Gd/uUWad0mAkKJYXfuX41UqEgXnsBBhGcpIpADGlpk5OtceUtwXg/vCdsr8I0gusrD5IGSSmV2oEM2/RSfTf4vbDaWC+KlgT+kJgdLK7wcz9ttXju+atjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suZgK0CioOyapHc8xhD6Mfm4zxQYAATVcXm5Pu6pk3Y=;
 b=FNQ52uTklyNL1tgE4rY0ctW5eS9/bGqDhjfVmB7rE3aNe57omIO22QHPi2Tjasgd+JIYGC2EAE30U+pyMqPTW+OoFsqq6xPvyoKHRJblYid0Rt+3HsB4hRwqpcKnIpX3WlX7L3PT29CWXrL1vBzCdEjeA060y1fLrFwrYaLMxninOZsiSbtgagHhIWHS7pjiaN3WpEsvGTYe+YBYyO9rblbwiycQIuXG8pulGp/1cwu3A5Hnm48gQJuRrFJfMfZP74lHommuAnD6qQuxH3rW8/OXfgIRGOMHdP4xYdGbvqIybpXZeb1bjOghqXzPZpc21J9UcFi2Tc7yprCG7okCuQ==
Received: from BL1P221CA0041.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::19)
 by SJ0PR12MB6904.namprd12.prod.outlook.com (2603:10b6:a03:483::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 08:09:46 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:208:5b5:cafe::4) by BL1P221CA0041.outlook.office365.com
 (2603:10b6:208:5b5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 08:10:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 08:09:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 01:09:33 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 24 Mar 2026 01:09:26 -0700
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
Subject: [PATCH v3 2/4] PCI: tegra194: Make BAR0 programmable and remove 1MB size limit
Date: Tue, 24 Mar 2026 13:38:55 +0530
Message-ID: <20260324080857.916263-3-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324080857.916263-1-mmaddireddy@nvidia.com>
References: <20260324080857.916263-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|SJ0PR12MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: dc94dee9-2ab6-4fab-d19f-08de897cb639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|7416014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ZcU16Q3xDc6iqMoiMxK1bnMZVnutEGvKUSjNfVnAAkGfJ27ortp5++VAUAPT2DVORpiVjTNkWEMvbskM/QSohhH8gCnjGht9QPxzCEK2tvKwUO2VCX9VWK6oL3UIEozodTPF+TSK1ZiLbpfCbfzx01ns/m5Zr9yH4seCWu4N3pwFNfk22T1q4zZp73Ki5Ukh/CuzfdBaNDf0jVX6X+8Cj6OpSJiioeHONaY3ZMdv7njtmvrUy384AuVnBvBh1Xr0aRJagp4ZXYlPYZdtVOFmGPCLrSPu6wdUaQLK9pBeNWrpMa8EGvxuR3SuQYSaHjrU/1I0H6fZVG/MJqJwuW7zgcu3B7/DfWaZUIlLx+ZZEa5FLiXoHXwCtT1K5Hm6hpa5oWCCQag4fNshXBWU0L63z2XHiYF+a/Wwmxkz7NVckKdWa/Uwxo1LK+loFKyvA9ORCUKGF9206r7jEx8wUvT4SuzxCqLF77ID7X8Vuz6OdXe//C0zuzZ7wxLeYfmkxSOa2RjQyQFxYX0Xa7tlvGZNxecXifVXvugtFrLeVsf07VDY3SX/g9g2bsN/JUFcLAUGoeWH6ZOl0LUy/Dtc2U3tUYlYjHZFrgOoVd23jueWLDfiNJt1TVRib4LtBdrP1XfeNhMApUFRQf5GAFhSqcc1Ii+LDziScPkyLtiyl2kvjwqpEaAZlLR53pvaLDpzRIuxaH5ovvZOavlTVgxmKOF1ySMcet6p9u+NJUH4o8E6oymyotzcit0x387a04I0CIEe5y9e7YaXBO9bCZKDdU4777DJMg9HCS0FZ1v1S0/oVbyo14TfHVbZLePA22mPlGV2
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(7416014)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wHrzDxsrAxw6118OKgHzYb9LR4/OrenwKykgprPpmBDZ65yMiUzqQJPE1DCm7lm0McLWnxmVgMOyKYxP8M3BPmSLCoHRZyENyKktBjm5OmvSpvbQj9xLm8uX90ZDeoeIae+KM+1vEEQzCjwo2utQT0EyoXRg+Qw9pSjeFV3Iyyzajgw1G0A77iht9oAjbRwhFjhLu+9PijMirDi+VsUpvbsExFMQhDWHt+3uSQOTgm24bQnNmL38WWRwDs4jEOL8B6otF4wc6niOgg9XJjAv54Acpi+p8werJDDUFMusBNhXKqNmBbc8Q7EqXZNth1PEP4knQ+4PiupOtMAIvAw994LziXn/DFNttutYD+LntKHg0fC9SC6wrdFkiM88rmd6Sg6wifQjADRW3gC0RYViLsQPKyw4WXDPh4CKGjQa0I2TeLpHy3aNRROIcIxt3YfM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 08:09:45.7416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc94dee9-2ab6-4fab-d19f-08de897cb639
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6904

The Tegra194/234 Endpoint does not support the Resizable BAR capability,
but BAR0 can be programmed to different sizes via the DBI2 BAR registers
in dw_pcie_ep_set_bar_programmable(). The BAR0 size is set once during
initialization.

Remove the fixed 1MB limit from pci_epc_features so Endpoint function
drivers can configure the BAR0 size they need.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
v3: Rebased on pci/endpoint
v2: drop .type init for BAR_0

 drivers/pci/controller/dwc/pcie-tegra194.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 6881f0b94c73..c5381ffdf1eb 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1978,12 +1978,12 @@ static int tegra_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	return 0;
 }
 
+/* Tegra EP: BAR0 = 64-bit programmable BAR */
 static const struct pci_epc_features tegra_pcie_epc_features = {
 	DWC_EPC_COMMON_FEATURES,
 	.linkup_notifier = true,
 	.msi_capable = true,
-	.bar[BAR_0] = { .type = BAR_FIXED, .fixed_size = SZ_1M,
-			.only_64bit = true, },
+	.bar[BAR_0] = { .only_64bit = true, },
 	.bar[BAR_2] = { .type = BAR_DISABLED, },
 	.bar[BAR_3] = { .type = BAR_DISABLED, },
 	.bar[BAR_4] = { .type = BAR_DISABLED, },
-- 
2.34.1

