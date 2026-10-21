Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792563593;
	b=H0lvAsQFJboZlIX3tMbmE0TVQ3TZvIRB6mjI8NLNbcQCUn66dS008RhjiEFJfn9NsN/X
	 QN6TjaUirM+QOAB6DI8rO3NXn4WKN/6Crjh6XtAeo30RrZCQu237rrITH4zKa+CM8MiLN
	 adCR7pjJffJWiZorzGYV+3YWE8OarJlGjX+9wFhp9WWa+iRHa+pElQ3Tsz/FY9QYw31CK
	 P7ZO+6ckUPXQTPLhkyWNCB/XnzWFBr0FdGM+FUtSjEkZURjVJ9kbrI4hXEo+STevVcGZv
	 FhsEm/qIqjsxaBtdzlOYpfnYo3z45fBdMes8S2yzAS4aaCxasI04XzmTHOiMzkEyvtA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792563593;
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
	bh=qLCAbZhfCaIS/YcGdMpScL5pu9jysldF+JFjMTkV4/I=;
	b=dda4REgZccHmNLRIT4PxrkOZyn77dwisSA0DceguxOBrSOVnmcjgAHhRpfHCggHrAXfn
	 yHR08Gl5NcRt4QUOc0TBXNam+8zsCyK/E36RJW1Pab0zeW8HI0FPwP9dlZMtFMozjT/vd
	 YE5G8gFPVLWQN/o4viHfPHFwRnHHcpDWV+uWuNwF9dv8PoMayPpFrP7T8VaMuvOsqRDPx
	 YiS/5QK0EnWtqawSebbRhmN5cdnwsdwRzR7Nt+Z53sFojck7E2CcROPt2onwjRtXs9gmB
	 K0IFkbPDpoGs3CB85Rxxjxo5IE0mtCjiIHORpQoP/RAzubDAaq3CsBgog0J5RlA8rCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pwlTuDrD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.32
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C21A606A31E;
	Wed, 21 Oct 2026 06:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C21A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pwlTuDrD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jaD/qg1IgG9f649N16Ed+2s65LN8RjQX9OPtSVYBFHiIsXdRLaRU7gAIWKgc5xjsiCU8U7nzypFRWHEiDYwU93K2OJoMpd0exYBelOkNvem/C0yQdtej+kSLaWXZRtyQp0VPkWWG+gwpMJhnEPvNNeza5VNBSoRC0NzT9HccWZ6EviMCni4GwoojxNkaJ6BjWxr2AQo+03evKR8LjLiwCFTEi4RTeTDjT2zNb0SCBX9DRoyrka2HsoZQgBgXcih1IBEYiBPP3Qs/WGQ9raxC57svWqUv4yT7VognoBFoLhSU4pd1YMQ4F+wO4xNMMJ0FjnboQEfkdsMLGFAyTPv2yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLCAbZhfCaIS/YcGdMpScL5pu9jysldF+JFjMTkV4/I=;
 b=tgQcDCRxi0jo9je0jGVv1RwhnC5HbEkLgnqYhtTvZvLJDv4pVtwWmg/MsiYNnQ8scOdyKq2tEmukxL3vyn6CUyt6bI1MlejcilWcZW9lFT7JUql9cagisdesZ/SZT+wE44cwXy5PcgujFXC9pCKE6mYxChQ0430jju8+h4A0LXSp3YhtenjLw7CHvxu9v4/VnLqGebGO3WeGfC7ezZyq3dvNsMBqx44zRLZ3AEwxMXwcpOKI9I7WxVJmQj/7e2j92LnXYw1U/9pco827SJOztgsNMoEwAZdKQZWml/A5QRurdylQlh/ZezTqw2+vmpXnradNkvJkS5dnKKS6xAjcvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLCAbZhfCaIS/YcGdMpScL5pu9jysldF+JFjMTkV4/I=;
 b=pwlTuDrD/WzuE8dqVu1AuLLIYaUHdFT7TD1QWc+acIn82SRvahcgGs3PfQJNqD/AQTThJu8I+6Pz9eMyxtNHmVtyEF5PnFf9KuPgG6Qq2BHdYXXglCXtpVpBQB5LrcmDFCYcFVwL1UZa0HwyQy2rvLHyWYngw/fdnYTG2mw7BPzvx3d2YSNfx6wRE7V2VmHXHV/uDdZo8L4jPOwtE574NRmBcSK5tb1yGLLhhehMb/wH0JpAVTKn5cfSchCwvR3a2FLWV9O8PUVt9KDHhtoruBlWNLrF6+5mxvBSTtzyfzro+KS4eqO0Hgs56ZPlObSdsR9rTTEbqUmRyKJgGzzBpQ==
Received: from BN0PR04CA0143.namprd04.prod.outlook.com (2603:10b6:408:ed::28)
 by PH7PR12MB7378.namprd12.prod.outlook.com (2603:10b6:510:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 06:19:49 +0000
Received: from BN5PEPF0004698B.namprd02.prod.outlook.com
 (2603:10b6:408:ed:cafe::7c) by BN0PR04CA0143.outlook.office365.com
 (2603:10b6:408:ed::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 06:19:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN5PEPF0004698B.mail.protection.outlook.com (10.167.245.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:19:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 23:19:34 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 23:19:29 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <jingoohan1@gmail.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
	<kwilczynski@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<vidyas@nvidia.com>, <cassel@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <mmaddireddy@nvidia.com>
Subject: [PATCH v2 3/3] PCI: tegra194: Notify Endpoint functions on PERST# assert
Date: Wed, 21 Oct 2026 11:49:03 +0530
Message-ID: <20261021061903.1269605-4-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021061903.1269605-1-mmaddireddy@nvidia.com>
References: <20261021061903.1269605-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698B:EE_|PH7PR12MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a496f2-9f4b-4c72-f2ca-08df2f3b4f25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|7416014|11063799006|56012099006|10067099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Og3+An7nZOuQ2i2AyOvYnzJTGtF+5jLDc9Py+VHwcmex8ZqXcpDxDHuuCSRaav7p/CxWfHJyY3XRxuGzQE7Phl12pcpny94uy6NYGd8UVpJT4h4TzOM1MGHOeD3cf9EwhmNUDEmjI5AHDJ2Yt0vl0gEvTDv84zEIr1PsyGC46NQFGDHYGjF+WAcyqmjo4g0Y5BpKa0kgC8KAOH0ZxpSFxEYU6sQ4V3xl2htVGRy/wQcBfOqWwtTymMM9YARBO8tnp/eUQEJgvjPbEA2YD2x6vOJevfJVXfd2sQaZ5PMjx68GjQz5vjgK8y8vYFH1wVcMDn029HYdEALc4irt1eMEFNIrBBNApvky2vhfq3vRYoh+ESfcYUTfy8PBTp+am/nU0NAPhjU1DHgQWtuNS531ib3zTYTdHTGgVh2EoE3Zj692JNoZ5NKTNLNYPjdtFX8tvYfwnK0X1eKb379ed8TxOd4ajUJJ9yV/a9LH4xVDcLpCfeZxPPj6aooytkfPqBJZJf/QcKN2Tj+HSe/r3YCxMljeaz/3VYhISJugMpFdfUIoRKM66XryrDQ36YZR/wcDR9lricJhsTd+6NpsWdPbdFuqCuqevdgIZh59+2GddeJbLGJn2myTN4lNCE6S382TXA8tNY/GRlPKyNdkvltUvCkeJ3lC97MCD+Rqe7/gkT0JOpiPV5C817aEXaeNI6m/okPqGaEga0cfVez8uD6AjQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(7416014)(11063799006)(56012099006)(10067099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	E5+NFAQPf5M0jXAiJs5F9TSdFwtT/Sjle7YLjgVBLspMg1fTcLxWisjdtiZOubm3+k+ud9cKeKbXZd7Qd6opKLc7v97Fu0msC4cCfSFXqfstxYdVDTWmn92jQL7ZMZH9+NryxwoRFymnMD1TIA810eYmv4GPPR9yc2tD2/tugBl3bfv8ClIjIsg8yRSAKnjOR67wZ1DPHigRFfUiwMRzCFickgS1fGBhfnvUftNUQghObgKaUiBu8e2KP9N6jbIW7DPJWwmu1elkYGhmghWYX2P4dm41JQ9DYzkdIQOCf7GG6yWykGMnffJiQ/t0FuNVsw14Y3D7iLtXZ6pvOW1LUBN/kZZqpi6zuWrQiQt5MWqBaEcNmwNcs+cQkG8IUHz+eidaZ+fhbspV33z5nCRnsZnhfwsn1jxBaiAU6Q6h6cmR+l+ni9GFRIwn9orHTU5h
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:19:48.5608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a496f2-9f4b-4c72-f2ca-08df2f3b4f25
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN5PEPF0004698B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7378

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
index 47a83a69533d..1eaefbbdd67a 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1745,6 +1745,9 @@ static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
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

