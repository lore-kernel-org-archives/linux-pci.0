Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013005.outbound.protection.outlook.com [40.107.201.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E59368285;
	Mon, 23 Feb 2026 18:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872236; cv=fail; b=j/UqxFFcJcaFZEo/1Ml115nM4qVL6GUdltxhnUF3Zzawp94e3FnVe4x9421C0yFgaBAY1rhx9vQS9xxNMJnqcggxLZjrE2i91nsYP614Jzs8SxNdBjPw6cgo/NTR6ECQDfKUmZmEt5m1cFqvx+z+PjARK/jTjVLFJKDjjnGY+tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872236; c=relaxed/simple;
	bh=Hmav0Tm5THwAOL32+83uOhu7B3SdTwbpnSQzd885l+Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mzrnaaUFWZWsibdblrUlBF2YF3Fy11mElImKNflMDyzEFiC97ISd+yV+ndTZ9UooGxZ+dXgP370jXV7Cv1nPJwFczKj1sfiajg++FaBStPl1n0zzFEupiIyk4bvTWucUjulCDTMZ5ZKnXz2eiZ2z+27gqeWjajgszM37jxxA/mA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MlXYFl1M; arc=fail smtp.client-ip=40.107.201.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MlXYFl1M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCqBPq1oZT809stgtYYZyE5Vk2gV59LQG65XVh6ziHHayHq3RDxTF6sniio45eVUJaDOhjhTMO/aFMiKmqNFY1AN3DVRr+umyy8z8mAZuXRn+f4KL0AxgTQuzlhYthwJLufxn18dnFXdxtr4vCzMglMRiA8612NbxB2ODyQLXZ/J4Hq6w2rATvv6x+bahHpAoZrt8QJU/nYF0uu2s3xsDad67JVqWsiGGvGvvUZsG/cE3fnrhA2g0iDm31EKktP7U9xWT2s/Y4dRNaNqmkYO3ac0tEXdNLk6k74m3SFsNfuz4YZILiKxzdIx7Ondw5HnGgIaitF5p50WGqInk6Ps6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSD6Ugw0e+zNx9EwHNO49w8u6AVbRB641FtlOoWdHdY=;
 b=SZuKEx/Mz1Oe2tK5MZrLYgj3uoESXAXNM5TiTkS6Jd7v1eUeP1a4qVBtmSPSRQNcp+vX30lIoyGFzjOkE3Ih03kHlRokFkhnCKzQpkgYKgVydJtICv/rpjK5CA4iPKUrlYguUmsrWzY5zJEZvPFGjTjNo/OrD4wxfTGFMt0Ak9a6tm8daK9UTWjbpT59SZXZ0ic+CYMs+Xe2+c/CLyMnF95Lk6n9qRtqUcqn3++1N3s8EwedVwfBgPide9hxJpfEplqdYHYnsaPIf3LXoUY1RoieQaUzw4LOW/uUPWbaTEzfP3H3RiPeMkbP5WgZkilYqMI+cw+eWrlGFRVCGETgfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSD6Ugw0e+zNx9EwHNO49w8u6AVbRB641FtlOoWdHdY=;
 b=MlXYFl1MYdL09sNPKsUGHk166HE4GozOJvgFb0lgXhXqYRB9uR8QbnEBQB/fYHjOk9Ln9rqgPKLWLRlEZdgcoiUk1emkR15mL1W82pWaehGkx1zUZE5iYjN+9N9OR4LqtRELV1+/xxq6W8exavHAjnWKeDQlM9o4Spgy6V+JsQ3XyxVrov6A0AbFufrgEUuFn2O0dtfN7wfnR+/JGJc2f/R/wqGKzfTWapdIUO+Ga7b88nPm7m7EcWnGwgqpF5kgMusV/X5WRe463wwqrrar524g/4xWu/mdRfHRywJGxWWv8hHEcqQWmnZxBAwzVeFgTwJg6pEsN2b7DBVun+tGqQ==
Received: from BLAP220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::35)
 by DS2PR12MB9616.namprd12.prod.outlook.com (2603:10b6:8:275::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 18:43:47 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::25) by BLAP220CA0030.outlook.office365.com
 (2603:10b6:208:32c::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 18:43:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 18:43:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 10:43:24 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Feb 2026 10:43:18 -0800
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
Subject: [PATCH v6 10/13] PCI: tegra194: Free up EP resources during remove()
Date: Tue, 24 Feb 2026 00:11:48 +0530
Message-ID: <20260223184151.3083221-11-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260223184151.3083221-1-mmaddireddy@nvidia.com>
References: <20260223184151.3083221-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|DS2PR12MB9616:EE_
X-MS-Office365-Filtering-Correlation-Id: b8c66e46-4cf5-4e46-d209-08de730b7ae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KwkxWSX8IXulnNuAOOoZSSl3pQOn1fcisOUWsI/SHt2FYmmXmxdbwMWEHQ5u?=
 =?us-ascii?Q?qATzGvYoZgS+HBU82B0Qg7mXQnEVgcN8JX4jXPU/MRcdNxhG11th/GSCzEkN?=
 =?us-ascii?Q?GnnmtbqLqbTmMlHhD+SPk/BYzXF4mIjPryPDFMpnvWRmtjA7e/jQKIPhqK9k?=
 =?us-ascii?Q?BoKH2afgQq6bH1PewWwKYYrLX3ipar2rdaivbiYGkKQ7A/omGlz2maR1LZLB?=
 =?us-ascii?Q?/576kOZJhRZ3kmAZEJyjn7WZgp0TuAY9AqIJHHffv/3Uu2ukAav7yybStxX2?=
 =?us-ascii?Q?mMW/MMQdxW53HIATBYgu+aErzeQQBQfQq+lool0kq3VOz/tlIEp930Snwuih?=
 =?us-ascii?Q?XgL8O8iutjz0CpWQTX4nfjqZ1Hu6TqPv1K8JEKSBDZRG2K/YAezZUd1plkUF?=
 =?us-ascii?Q?2JxlBsMb7gevgC4lbOgl3Iua6w1Dm4h2P4O03HT2Lqzndu/Eaos2L9NGbMay?=
 =?us-ascii?Q?38Aogyd9oDY8U7hdJyfXswbw+XIoM4JdlENoyDlLww9F88S80PumeaB6RvBz?=
 =?us-ascii?Q?2q7bdoexBlVlReogng5Sl1Qjit00DtA02RupgoTD1CuQ/RMI66z0eeujoGyf?=
 =?us-ascii?Q?CrIUFPheMyup+qZwDtqoTJLczsWUjZm89FP6NXX78SfZ8nfdcErFORp9mgTu?=
 =?us-ascii?Q?0tN37BKQ8cOyfMRFK1TnuEZ96fUXaJCQuNEqeNWnC4NdHaJFPV1fSXlIgaTX?=
 =?us-ascii?Q?rShMs8ywK3M/4mILGGK8/9ms2Kj4gwwkTXP1IHkNDvjf9B5a9t+gpDhfehL7?=
 =?us-ascii?Q?N99n2a5VMK+5dXHTRBFBE8p1wZxtXCN7DV6/51xPx68Ace7BOjsURDVI27U3?=
 =?us-ascii?Q?4oCkSNhg7nuYXaVKSIfGTS32PNVXRLFQ5zjFzxJ6bHX4hsuFLOiYNKXetDYD?=
 =?us-ascii?Q?BodwPs9NxCO06+v1e+7nqcyIR0DXXaKduePxhqPGPmmpsFr9ZlM7ki8sV+lD?=
 =?us-ascii?Q?+TlwcMkruJPCIAVxMAgl+oaDi/rE7tsI1VH5BINfM2Au0abUQ52MvYbo/6lp?=
 =?us-ascii?Q?vrTQMhK0Fy+U0pxCVhfLoaXfpFMaOd7eK1waW93uujWpfDcNkCTVah3N1tqO?=
 =?us-ascii?Q?1r2IpmyYefCMLgVr8qvseFfuGRLRAkcfQPFC80O2mbHBcrHk4+P5KScBcg03?=
 =?us-ascii?Q?iUAGtygt1S31v31ZH1/AZpC7XW/ZEpM6ZMDmOgoY9tikMW3hDiPg/nTS0XE0?=
 =?us-ascii?Q?QsLuXRwkXyOIWfbz7vgjsWlhBcIQd5POoBEVvoUgT6vjnKNKK2p9mE4ng4fL?=
 =?us-ascii?Q?RsnP3T4xDFFnqmlAXScMfd0QshwkbgpAuBsCc0xupPNtCMFEQA8sGWbStYCF?=
 =?us-ascii?Q?0UBXQn3dkCwu94BK7q8QbfczPdhlQQM8uZB+zCgpoiyqKTM3pMGq+XpqAo2T?=
 =?us-ascii?Q?V3mf3ILG3l8n2Vn7D0ocX5hRBTSe/4gwEDYmuTvSg8ujm8G2O+PZN+g5b2Cj?=
 =?us-ascii?Q?2iLHLi5CsDOkTaHApiA7B96WVbcXsUmroXC6E+Q+o/qJYcAjCyeL2ldEzx1j?=
 =?us-ascii?Q?5cRAaUvbxK7jE5qoxdByTtwh2wEhzsDYHkgGQpkqhWWhfYoatEhiCAOLbak3?=
 =?us-ascii?Q?5X20QJzOGcHd+BaUJLvLAXEJ8B2k7BqgGZvmSMMBWokPmQqXP9g7QT4P0peW?=
 =?us-ascii?Q?3YiQ9VP5Rd+rLCf5zyCh0uJt9PEAdziuc2BvV6dwNQX1ak1kioipZNVP5kmm?=
 =?us-ascii?Q?iiyJTt8/Y1sDTaSG2LXOkCBZaHc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UzUwMA1o+S6NZ4d6yKSSYaU61GHz85SdDg+q8WLxEFVNYfx5oEQVjNuq7PwWQz+o0KMXxdV+jyYnP8K0xOXJXqaoTiYvrxfBOw9B805IDJr4NQmHngWNt8bpY6GXaggaYR/PrPbQy77tQwrVzBLtovmbQFDJ9i8PesuNCWMYLUeL5pQ0Mwp1GVrG5eBFVzCB3e0blUITAtLS9TauL1wQf2X4xN9hhZQ8eyRG3po9HCm9NYXj+9aZYpIQrLGXOOEht9pSkwuAA6TaX3VORh2GNbjVeLL+YCtN3i9XWV+WtxXamIo+RkveMbThU+YwUlclS661y9cZyWfBOipOs1C++61YnwAAJTKlpy8Noct+U0fBxRRmUzJ8WXMGV1wLf1jdU3wO1SqKAjlsFVLrhSDjLXTlgJ1TnHtNOek/U3GPOO76YOJbKPMhHqVi9dq4KoiN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 18:43:47.5256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c66e46-4cf5-4e46-d209-08de730b7ae9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9616

From: Vidya Sagar <vidyas@nvidia.com>

Free up the resources during remove() that were acquired by the DesignWare
driver for the endpoint mode during probe().

Fixes: bb617cbd8151 ("PCI: tegra194: Clean up the exit path for Endpoint mode")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V6: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 58069b1615b8..d225165a3aa2 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2247,6 +2247,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 static void tegra_pcie_dw_remove(struct platform_device *pdev)
 {
 	struct tegra_pcie_dw *pcie = platform_get_drvdata(pdev);
+	struct dw_pcie_ep *ep = &pcie->pci.ep;
 
 	if (pcie->of_data->mode == DW_PCIE_RC_TYPE) {
 		if (!pcie->link_state)
@@ -2258,6 +2259,7 @@ static void tegra_pcie_dw_remove(struct platform_device *pdev)
 	} else {
 		disable_irq(pcie->pex_rst_irq);
 		pex_ep_event_pex_rst_assert(pcie);
+		dw_pcie_ep_deinit(ep);
 	}
 
 	pm_runtime_disable(pcie->dev);
-- 
2.34.1

