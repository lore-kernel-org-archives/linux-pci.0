Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011040.outbound.protection.outlook.com [40.93.194.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3585E366DD7;
	Mon, 23 Feb 2026 18:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872259; cv=fail; b=uWAhc3CE3f5OeTiMDf5v89imAX4UuTOEuVWniCLKqKL3qcM+JDbaaERH77+ZlXdFpL4S5iSag8CDnQkVDvbAkC7UzxFQja5DOCgi1/tpl11o3MNogusWRw1QTO5vlDBoTQ4FEx9c7ug0PjN9X6ScC+IIB3ttmZ4wzsKFrTBERSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872259; c=relaxed/simple;
	bh=2Ea7WpgHGrpPllIe4Ee4VUQF++GmcqNG1SvRibfBzYk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C97Zuu3ddOeDbggEnDI2BtV6ybqogPVP1R4sQONHZvWedI3rUUIvLZIRfldsiH+nGKq+V4FPHqJtRIrYSE6IU5J7kSetPRy8G10NXo3ZvfRWiXo/lPt39m7uGiOQdmiK8PRV79wSPCsWEvLeAYb0jM5AQas+iWiYCNjKiP9UU7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mnAccdSL; arc=fail smtp.client-ip=40.93.194.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mnAccdSL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LaAYo1L6uZSCoTfVSez7GKOXzoblhszbNnRNE2JNcNdwsKfmykoHUZeqvlnNzL9u+vstD6mB/0foD66sPqmpb29NZAPbDzPeGxHZmow4CGdhm+5ggPRpn9gcl2UWWzn+/BaZ2Bse9gULShLimgYMirvqNlKRivxhmQPVPeXhyEfFNk/dGjepQMtJ6wDh9bkuAPlHFTPjcRBJP5nI2q+3Bi8meUb4d9dueIB9ocU6nush1L8XgIoDBYMcyvfoTwZuusE04beZpigjGYgc7cocXjgahP8pRuSGJFjk7xndOxfcsiMwoPmhccOcWCo0MgQVaNKk4IjBR7zw47W6dOZCWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4zXL5kGot/kbRJTne9SbZ63wj4lmzWxfD1SDGFMVtE=;
 b=O6/eihwr6rHBm3k49d/d16nyej6TKKYcmwtYf9IOBM0X6yia7nQbFXCRujQCRBvXizKQoGDwwJcsAMg1DUVMP7R59V3TGRa08XAZIPVWGPPjek25ZU8ZsAoKQoqRBHJFxBxhIchL0+qp+4EZoutPPUAiuELyEEzzadNtD+heUkG6r+F0xjswQPw43p0vsJF58/GXvbuemeZJLIK2rB+RyxKyzlHq316ng8NvTQL2KTCONwWHPK5fXroXotpNITbOuymwsyFl3Jo7YZayjk/GVYSQshGzN/wmsGZBk1bHtZ5lmj7Nkfb8dPc6eeHfniIHntgEwvsiUUI4ML9frjm1Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4zXL5kGot/kbRJTne9SbZ63wj4lmzWxfD1SDGFMVtE=;
 b=mnAccdSLxFwklNLKrIodDZGsMeKZJoU34Fiiy0ZIS2bVmpzE0fmQ7OATbhMWxfgB6KKjvhCRI/WwCUQaTJcNJ/d2PZEsHU8VIOxAbPq9xM2nKbn3W3kufNfS4IN9WYTt61vbMvdpf9FjZHuXcic/rk+CcZe/5RIrUuStxW4UMjJrBo00iWkSqqubdozY7Eb9Nc7MT0zRuJ+4FAaLp53cChfkDBIYfXmqGwPkZ66YHlgQAHJn9asxeVMDIbw/x2ZtL7edEy6S5YSOVA8oV8YKHGAOFqnOohdDc2G1hFp8WPhyH1LOzsDRU1ew68Bsx8jzAPQco7nkRNfl/gy87JVnlQ==
Received: from PH7P221CA0089.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::7)
 by BY5PR12MB4212.namprd12.prod.outlook.com (2603:10b6:a03:202::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Mon, 23 Feb
 2026 18:44:12 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:510:328:cafe::98) by PH7P221CA0089.outlook.office365.com
 (2603:10b6:510:328::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 18:44:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Mon, 23 Feb 2026 18:44:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 10:43:44 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Feb 2026 10:43:37 -0800
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
Subject: [PATCH v6 13/13] PCI: tegra194: Free resources during controller deinitialization
Date: Tue, 24 Feb 2026 00:11:51 +0530
Message-ID: <20260223184151.3083221-14-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|BY5PR12MB4212:EE_
X-MS-Office365-Filtering-Correlation-Id: 4758d1ed-54bd-46ef-99b7-08de730b8948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SUz6DxBh/K10HFo1qkzJFQtIzgLVyfQsZ40uJg/JBubax2a6a1n6Fo9tqiYk?=
 =?us-ascii?Q?xYYvyff7BVF4nLGtQiZW0g6Y8rpUUMJiDkU6J/UP0C2iropdBR8SFmL2dtG7?=
 =?us-ascii?Q?LKTKPp3XppxBg22veVnv8OdNPDScGiZfTJNIwUWfADnLalLuJza0yeewHL3e?=
 =?us-ascii?Q?Ma3CyAL5cpmUnAala/nzPejpZ3DexwGh+kMqMR41K9YVSNT2G1xyVc6VFx0U?=
 =?us-ascii?Q?WdYr3Oz7b73L0oue/Y5kGwKr2in2nnNrvQEzPmQTnYcfv+0zIxIgBbYH2X2O?=
 =?us-ascii?Q?gD8rqBSctruqb2jgLQW5qkxwKSdbjZjtEQO+PsG9/0L/3aRgKzsvz5GW9dOc?=
 =?us-ascii?Q?YapCkNcuODPU6KEICulgoKh9WxmScW/jWdPXDe4i8/MYS5KizzISqHp99jgx?=
 =?us-ascii?Q?Ed2UBWfE2i3KjL3TiZ6KCwvsEoSJBNX3JB8Mk8dHK/k+JEr9VTlAJufpxUmq?=
 =?us-ascii?Q?2vKP5phN6ydG1qaNHQBfTNMkwa6/HOdwRjzB/CyuDpUbYfr04UrykaPEGKx4?=
 =?us-ascii?Q?VyXv0uhReh7f+4N2eX8Z/XoSqKLU0dyr+Lu1G46NwzVjUHKGdky3F1GWdj6W?=
 =?us-ascii?Q?EmfNXwEALDLJOdridmM9ziT1ScM4aFWCGR4LdHU1MgsxVtW2rwfXowrCAaPO?=
 =?us-ascii?Q?a7llyqzWOcza+SxJTb/srxM27c73ONLF/YNDs7Clw8Y+jrfzHirTXonkJFML?=
 =?us-ascii?Q?VDJvP/Dj1VWe/b466Iv1TzQIJbnbfrwXdj7SuzWeCZ8VqDkIwElMXJ/3mtCI?=
 =?us-ascii?Q?itHt19H7E27XlGpmqRWsrgJQY5tIL8/GfEARcDOoseDGaybS0y+tsPxFctKp?=
 =?us-ascii?Q?lrhggCSnZyB+CsK42rKmaEHu8QfzbjZsk8oOn3Vq/gF1BEXc2ZYeIvlYHxtj?=
 =?us-ascii?Q?9pR8DIAw/J+rv80vH5oiPzDsy8rlgfbb3sTquH8huYBwJNP2cH8+aKljUip/?=
 =?us-ascii?Q?TUI+MmrU65NF16vX6eQkGNwXPz52wYAygD0a0MGAqycgGIDUQ+vl4R0/RSSr?=
 =?us-ascii?Q?Q9cwCvgpjLyYqnNhC2bPJFGvha8XXynwuETFtc4bS0yFIby2LAk+5kUpj/Gk?=
 =?us-ascii?Q?TofwoW0mkVIu2JoxBd0RbwCUix4WlflqhWZQfM2Zx+OCJboPgKF3vcEe8s1i?=
 =?us-ascii?Q?NZBKGMo0c9kD19qQ8pCuTUxnN/UI+FxbpVsK8OmGZHyWR6l9RcOHzW9/QAsV?=
 =?us-ascii?Q?pIc5+qFOZQhWqLSHLjtoqqxJb/kkVZVc4VwT6vakqWkuI1UkRYJLXjMIWpkt?=
 =?us-ascii?Q?Yt41i6SgabEyXSHQK2AQrygmbSQf1yFu3f1D5Dhk+QQAwLLycBpJJdAZjyWr?=
 =?us-ascii?Q?aJvKh4V2kSVzVl11DvfBa2TaZrPvSKr/0iZSgz120HZUF/pizUQHi0HiAUVK?=
 =?us-ascii?Q?lepcihLgAuY85iDS96H7NChMO4rGFWbfZWPx1uMfV+nMom+591Y83+iok7sP?=
 =?us-ascii?Q?1uQhv28Nj8+UOrtwt7NgvnlSjzvDh7bSnLUVYF9OnFK/F9cIOlddy95dseKl?=
 =?us-ascii?Q?mO1oF2qSbCjFg7sE7aZ7zrC2smR4saOtlr1cKgVpXU2W3cXXMAOzUPscntxO?=
 =?us-ascii?Q?Vxb/k01H9MikJzSzhb+6G/PzKCNJU1p7R5P5h1H5h6buIY5MoIgRHeb8oVUx?=
 =?us-ascii?Q?S3CCQfru6JFfTJLERMdCZ7ieLgsoRfeL0Y6qxewya2W1xWn+r/8zxf1EE4/U?=
 =?us-ascii?Q?2evsv9Lhpwqnp+QO2XRD5jBTM60=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ww5+x6GQPZjgEGiQG/Ry1daP71c7peZQHyJguCwPK9CmVi4cgVuIn7LbEBHbg9y2GeGoVNFqLnct6cHhm++08ft4pHio36Tb6VEpQpx8tm8pei5+Jv+wmHNWwsqNIUTfcWuj949JiiQzoLZKIokJ3onC7FDfm++q5ZEfcPERTf5CDZwqi0ARO36alDw2mJCGHP/XZSPLQXGFehkR6nZdjGaYQ98NNKUpkmnk/URVte01LNmikCIEjjbRP53XTCJqWaLUY46tah9WgRNDk9B56fVFakR0oGlXYnxbBamaygQsygFhm0atPGs9vDpUZVXWAQkuZohKMTsnx8F25JePbfQL1VB2cr/MBUkXe7375L3ueEpPI6MKRod8aTYAiXn1vLO1tHFIrNkXIB7ZorTf4iBUc9tDAsfJtedtDaHXARE27CPM16l5rcvZHWPfJalH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 18:44:11.6957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4758d1ed-54bd-46ef-99b7-08de730b8948
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4212

From: Vidya Sagar <vidyas@nvidia.com>

Call pci_epc_deinit_notify() during controller deinitialization to free the
resources allocated by Endpoint function driver. This is safe to call
during PCIe assert sequence because we don't expect Endpoint function
driver to touch hardware in deinit function.

Fixes: 40e2125381dc ("PCI: tegra194: Move controller cleanups to pex_ep_event_pex_rst_deassert()")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V5 -> V6: None
Changes V4 -> V5: Remove pci_epc_deinit_notify() call from pex_ep_event_pex_rst_deassert()
Changes V1 -> V4: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 256a5d1eba16..9883d14f7f97 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1627,12 +1627,16 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
 
 static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
 {
+	struct dw_pcie *pci = &pcie->pci;
+	struct dw_pcie_ep *ep = &pci->ep;
 	u32 val;
 	int ret;
 
 	if (pcie->ep_state == EP_STATE_DISABLED)
 		return;
 
+	pci_epc_deinit_notify(ep->epc);
+
 	ret = readl_poll_timeout(pcie->appl_base + APPL_DEBUG, val,
 		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_QUIET) ||
 		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_ACT) ||
@@ -1795,7 +1799,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	reset_control_deassert(pcie->core_rst);
 
 	/* Perform cleanup that requires refclk and core reset deasserted */
-	pci_epc_deinit_notify(pcie->pci.ep.epc);
 	dw_pcie_ep_cleanup(&pcie->pci.ep);
 
 	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
-- 
2.34.1

