Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793618145;
	b=rxOEBSZfKh31ISnKzTa82l1cE8vlOgHhXfT2TQ82ngaZ96+W3qqQLX2PIgD9R9LH1BEW
	 p66QkviQ7hI/6kF64lOy6vAZmCs6h0CaQWcYSfjSyoxBUSufnvlmOfeOFF6hmG3Z7WD7x
	 cynGAC6IFK2Qb3H9dvqEFZ57hwscnxd9UVpHZcFEnjrcjlQfsaaI5T58f0dVNkjTuDe4A
	 fBGHtJjVTtgi9OXtLlCFPUN1m52F+q+jXFCyVzzcXypamvuVHAhb4KPy7u/KZhX6RL/Zh
	 lGfy/VGDmJiRnUz7jEKkRVh9Ly48b+ch83n24M/1BiuFLVmb3RKx9UzaIiycr3LQaqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618145;
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
	bh=8XRZ+cSv2fhxvZrUSPPEF+Dpsi6JHA27wJAME7tkJm8=;
	b=mD1damBl3/1K6pwvMSnHsVNtGR1aVEsFwpnbiuxk9sGWnhdxrGCVcm9Y2KdPCRQ246eJ
	 d0lo2uBE0pubsrLgyEvDCYnfjNBl2d4BZXRzlKHbUpAEJsiCErqne787Ak5/IsDhLHSBE
	 0dATmDeJCTYogbOUN7ov7D/HK1pBn9VGanezuIWyT4nkds/pvkj6+tklbIk+CtFVs0fgb
	 Iw9prCP2utFfTG/zcjac5Z3dHoivA3zTl/vX2fpBNWs4nN9jmSSpq0dDAEVoU2hjMAakq
	 THobVvhOAEQUpUYMGYIr2SiM5xWAlurQS7C0EfjvHb826b4w4rjR0AHD8LvUNOGoMLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JKUEQTnZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.62
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010062.outbound.protection.outlook.com [52.101.46.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B13E606A326;
	Mon,  2 Nov 2026 11:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B13E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JKUEQTnZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ko0ZQdUrVePib62ew9JCuoIJrY9ihJUvSlMX71Ue+fMqm9NmepckIS9ipesPHE36tEvbCjv//WROJ9IwI4Iq/F+Hlj9N/l7U6mQZ7nXD68lTs+xZBqhj/BUYJiRx8Acd1XgbXfHyWXWexu25to4q6cKNIYXHaZ8EXQNLHnv0AGNYd3StB8WcKQnxzunUZIZzVWz/54mQ1YJfkEPAGXVh+wjTHjQHumXCvOmoz2g6Obhc36kqawXBBxMQCVlLWT1VulsATlyJJtuO5pyGxohMJxr7i/k8Ezcr/gvzvY7i+vMSdFhy+Is6xtjYOcu62Gv5JgiyXAJ5HjxPioxDAGerHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XRZ+cSv2fhxvZrUSPPEF+Dpsi6JHA27wJAME7tkJm8=;
 b=CWM1LnI797JdAgDzya9mUG7e0/A2k8YNbrnI3vdN2kGhBFjFuEejYwdL32gz4C8qdV32rDl4pxG3l9P1gsvTr3M9uipCkNVyGANZhvGpZnp0+40TchhD4PMgJLCPf0f4077C3OMUkzDMdwPzT3047sF2yUFEiHRHgp85jmM9ss873PY2b9oq0Iaf/2+XLca7nm+XX3fUGt6Lzho8f2HlSNeaI/ROg8cmQlLKUIAAeh3yjvbCebKZL2jNebMZB3xzDPJh7T2L8gJDah59kBRmpHb7FKqdJhaH74KNDx1HAkHNSsK7OYfp2jeNUSbl75QSE0r2gAbmiDgjzNzhpYqOMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XRZ+cSv2fhxvZrUSPPEF+Dpsi6JHA27wJAME7tkJm8=;
 b=JKUEQTnZWkpOeU87DlhV9BX/ppG0eJTrtUJl3aUvZ4qhhqEtrR2Z71S8oCB1R8WIP1DpH/JMt6LIxeeviRfPqs9WHL9AX+Gz3pp0iHYD7S9L1ESusF4LFjIRYTkhLLbsAoqWJhpqBmnFX54SigNcPKVuiHXZaLeMbNhbG1jEiYzFN7+FQVxCT5tqjMsHNJGTqKW96ipRYJIrkvvV6D75Gvg6A0STMscT+BdAB96vVzjURuL6hf3B1+OUDiuMIcqIjy+yR2AbiBRTMbQBaCWcNZNi6OkNHNtxuWjJfHt6bHRkxUn+Cqi3DsaNh4zjRkGHZavmg2pE9V/3j9lvoOdVRA==
Received: from BY3PR05CA0045.namprd05.prod.outlook.com (2603:10b6:a03:39b::20)
 by DS2PR12MB9590.namprd12.prod.outlook.com (2603:10b6:8:279::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 11:15:39 +0000
Received: from SJ1PEPF000037B5.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::6a) by BY3PR05CA0045.outlook.office365.com
 (2603:10b6:a03:39b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Mon, 2
 Nov 2026 11:15:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000037B5.mail.protection.outlook.com (10.167.244.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 11:15:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 03:15:21 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 03:15:17 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <jingoohan1@gmail.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
	<kwilczynski@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<vidyas@nvidia.com>, <cassel@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <mmaddireddy@nvidia.com>
Subject: [PATCH v3 3/4] PCI: tegra194: Notify Endpoint functions on PERST# assert
Date: Mon, 2 Nov 2026 16:44:49 +0530
Message-ID: <20261102111450.4010818-4-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102111450.4010818-1-mmaddireddy@nvidia.com>
References: <20261102111450.4010818-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B5:EE_|DS2PR12MB9590:EE_
X-MS-Office365-Filtering-Correlation-Id: c70b7744-5492-4c15-60ba-08df38d2a05d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|82310400026|36860700016|261021121427099003|11063799006|56012099006|261009223027099003|261028144727099003|261026121527099003|261026140227099003|261022105027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	8B7ohw7AU9SfjdKWJMCxU+WGgtssu82NqHTqrwfsj2crZFuqAEeNBb4trCxIBDYJoKoGjb2oE4Tpku4hsHaCEg37ATXrV221zn1Bty5oWFcbHFpV5r9bP0ksrWjigqg7UTYgGrg77yc6adHxQMEjGhsqX9C2lncss/S3AB8CB0JA75TVtWAzJVmRpwjyqCKCWW9/xCUJ8X5F1WxyKy8QgWginvkfFfyXhD/7TtsLpjp9NhfAe+xt7CkmtlyzOL3Uc4ZGh5fvilKD3KV6UU5T+8jbeBbrr2GBJARcxbQeTvOBmPdwmELreUYlvtv0qG0crpqh2ZYztsAZT/5swYhCGPA3frvz3+5PZ17MH1SQQWKw5YsI4QTYMkc4ogoYG+YZZt32RsGcRfXn18axNL8e05fU5/UFnhOLQT6NryeLkZj5yfLMag8OeiRklq8Lq+gj6Jxl9ecZtGNUszSfGpeZG4MNeSa2pwFp27t4m7+lWHc/pidSPCIovexFMHpZVvxzvvaJh9TicQDkbDPIG8hERf9CV/SfbnpOWKLIpxFzgYivlapBy9ao0KKPoY3xY4Yvf5LxwKNsYVrqYcWFBqrlEPJ1yKMDBRuLAFMi5L5dhC90AxefMeMh3ErcL8KCnsLftS0b2BS6NiNVAuAvWG7iR0ZMplzGaZC3x6cJfXTOYLUPWRPSFhRmbE2VUFGuaLIpDF1ejylTTYTaKj7CWWvDaA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(82310400026)(36860700016)(261021121427099003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	u6XVU78C2dbFzVYBaa1kxpBhaPvuD4KP5ejFJLxxfddq59voNb5CbRg9N3EG2VxA+k/XQKEAp18vg0sD3uxB0WEc34KYAc2xsiUQbe7if+Wb3CED8s9aXMDimGHDcUo1ZU2gpYesqwmdm93sryuU89UFKCFoOfGDJPZoViwyNyh8Tk0Wk1RLggGXRDXjlNs90XWXYP3O2plEIx2qFYTASu3mZHT9CCtPBFW5egBo2uRTwjJ66DdAA/yk8MWe5fRdC2pyrwL3oEeZP/7BtkPxNvZKof4GWtBwLWX19yK7vSUFCsikBnGK5xYKUYqFL0ARspr69sna+IQEIynYLTKWoJTpOduI7pDxF5sork3HDI9kgb4U33/8GX5BuPzJxgKVSh+tRkgsUud8Ej3xitBn4WUe1kRuqBEbY1w37h8lKNqk3KWY/ngVAs5fcKCqRw54
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 11:15:39.4258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c70b7744-5492-4c15-60ba-08df38d2a05d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9590

Tegra powers down the Endpoint controller when the host asserts PERST#.
Notify EPF drivers of link down before disabling the controller so their
link_down callbacks can quiesce outstanding work. For example,
pci_epf_test_link_down() synchronously cancels its command worker.
Without this notification, the worker can remain active after the
controller is powered down and while EPC resources are later removed.

Call pci_epc_linkdown() directly instead of dw_pcie_ep_linkdown(), which
also reinitializes non-sticky DWC registers through DBI when the host
may already have withdrawn REFCLK. The direct notification avoids that
common DWC register reinitialization. It does not guarantee that EPF
callbacks are register-free: they can access MMIO and must tolerate the
hardware state at PERST# assertion, including unavailable DBI access.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V2 -> V3:
- No code changes from v2; rebased onto the current PCI main-based stack.

Changes V1 -> V2:
- Clarify that the direct notification avoids common DWC DBI register
  reinitialization, but EPF callbacks may still access hardware.
- Add a comment explaining why dw_pcie_ep_linkdown() is not used.
- Drop the unrelated pci_epc_deinit_notify() pointer cleanup.
- Remove unrelated teardown and deferred-deinit discussion from the
  commit message.

 drivers/pci/controller/dwc/pcie-tegra194.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 08d6f4c5220f..df679509677d 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1740,6 +1740,9 @@ static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
 	if (ret)
 		dev_info(pcie->dev, "LTSSM state: 0x%x detect timeout: %d\n", val, ret);
 
+	/* Avoid the DBI register reinitialization in dw_pcie_ep_linkdown(). */
+	pci_epc_linkdown(pcie->pci.ep.epc);
+
 	/*
 	 * Deassert LTSSM state to stop the state toggling between
 	 * Polling and Detect.
-- 
2.34.1

