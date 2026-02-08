Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012018.outbound.protection.outlook.com [52.101.53.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B23D2F7ABB;
	Sun,  8 Feb 2026 18:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770574162; cv=fail; b=cBzPniMxbU6O1XJEahJ8M7nUc3GmgDBvkwLlTrMUdlJqaovk9LWCuDZHIGZj1stS9EmxjZryi/AZ+ezEC79d18RexZ/+uN6bWTYWNq9f0rcegkhXufb/qme+SNhG/CIYNLXtjRWv6pQ69A3l7OrCCQTi21Aol94nhRG8Y08k8fA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770574162; c=relaxed/simple;
	bh=ZojISb6x4si+i7lMJZeuhqg0lNObB4p/bk1agOoi1eM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o54u91JRfhdjkfqSk46aljF4qnMEyaVdk11DKKYirmbF1KEDdwae6/eSGmP+wia34JJJrnqb8Mnrjo2gqMnjODzvhPm0Me2qcIX/3fzUQvXzO0Gc9fxb80gzsmAFXNWbUrfKX4jwK+8TX3i9RMCRAg50xBJ+gcF2RyzjGarls+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jN8R33qj; arc=fail smtp.client-ip=52.101.53.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jN8R33qj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTn6kg65/Ubmb8ZOvH9o5l2/xFR8P2Lx7AEOsG9YKSdZpNoKLypawHZUv32IKy6OnBckwBifhyhATzWc8DdzvkwsiURDWSPOaieVAPtN3N4tckJ0EgbKnmEZ6RNa0Dg8oof4SCRBVzeZeMmN9d7/15JosGm1aBPAZNxvuYOo/cfi8eKbZNaMfP4zPXaHqIpGxtxtruq/+2lsC39kiIQcCSQUzcTkw27FiPfj0txZiAbuAHW2qzDYfyEmffe1rfbuHBYYZWopPFSxvE81BaIh5AcRLlQvhiupphZFrNb/xrMqP3Nxt3ZyHAl/bx1P6a/NeJ+kec9CEWGLaEP/JC51sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDpF4J5JmnGcresb6F6/uedErE7e5Va2t3gYDxsaZ9Y=;
 b=og++SXZhiNQ3WPLVoAzjyrroT1zYuwIqMbCRpehv8YqQsLl3d0+QvEfcXaXV6OsVCCjalf93373Y27/I3p2avR18tb2seL5dH7IFguMpQOIkoMAODYtGWbmYbJDQ2ct5U+NOGewr4RCKKaUQqS2+i+K5WEH1T+nO3qGZ9sv2svcmCL8PbGlP1D5UTWOGvGpd5rvH7BKp3IECLmG6lr/xnFNidBXciDWSwzR9/p6CoQT8pjNFpNi4UjboJiHt34ruf/WGzYQWJfxWttiOeAmMSGK794M8WGu7e9qGqOU2d46QSilm8DE0rxMC58nmPS0Kzp9KeZnvKJBrpDdd9HIU8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDpF4J5JmnGcresb6F6/uedErE7e5Va2t3gYDxsaZ9Y=;
 b=jN8R33qjyqjbI5+CarMfcJQGTlXyMzo/6fjBzWHAY6y8uMGv0JWu3bW7qA8BpsWTDHPFHTOKe/ZvY/nUZTXPmGVbcOPZh7kJD1skK4IwmuKNnVRcoi/V1kVRWYFSRW/tZiicOdqKLGNdqSMWnMrr/07Hrsq382RCBJn3pdW3lyJu3p0iYaOlHDRJchGeCVut9jha79YiFl6KTSbfmXqcfpgklRbW1fPbCx2NSEYFDd029zmludmxdKSaWpEE40VWO7C42g5Ar6nZVuV+58znHoVvMS0pP/s3E20bBpoG0vcz1iduyto3rWD9+JNkf77/2vU68fxvGZbgWkEWBMj1Yg==
Received: from PH8PR02CA0008.namprd02.prod.outlook.com (2603:10b6:510:2d0::17)
 by IA1PR12MB6409.namprd12.prod.outlook.com (2603:10b6:208:38b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 18:09:17 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:510:2d0:cafe::b7) by PH8PR02CA0008.outlook.office365.com
 (2603:10b6:510:2d0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Sun,
 8 Feb 2026 18:09:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Sun, 8 Feb 2026 18:09:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Feb
 2026 10:09:13 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 8 Feb 2026 10:09:07 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [V5,11/13] PCI: tegra194: Free resources during controller deinitialization
Date: Sun, 8 Feb 2026 23:37:44 +0530
Message-ID: <20260208180746.2024338-12-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260208180746.2024338-1-mmaddireddy@nvidia.com>
References: <20260208180746.2024338-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|IA1PR12MB6409:EE_
X-MS-Office365-Filtering-Correlation-Id: a4ceb84c-a8d0-4e0a-848b-08de673d2c88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VCmkHWcRJjFi9+pbnPEQMrPCTGHY+TYCFtDnvCgqfGBPJL1zCFLs44Qgl01G?=
 =?us-ascii?Q?UOM9Winx/UiEejWqAUn1acQHsHmvZ1Y6aEXN3rseNadsuhp/e/pSdPCmZVLn?=
 =?us-ascii?Q?awIe/aRes44o4G2Ae03QtJ7pT8X16GkVjRK0g0Xbdr2yxWc5KonquL2C1XI3?=
 =?us-ascii?Q?370p/Mp4HUND1K4Kvvh4K1T6sZj88oWMGVGn5eXWtjBGfmYXHUe/V9V562J+?=
 =?us-ascii?Q?N+IjY/YqX1guaDUVVKEm19DLqf1bXIvFpXERAGNcgRBM0x/S+CJ9Pn7bRohn?=
 =?us-ascii?Q?DmqFJJTjhJ57rTMO0+T1CH3vRJ4XKgHWIYizBXyxGgXwIWQCtl0ltpG7JkfU?=
 =?us-ascii?Q?7QUUXmvxgtJgkxNvvd0HnSpoDC1yYJDegQfCmi68dS8gy/kh8A49BemkOBUg?=
 =?us-ascii?Q?hYDR6OcKnTwAJsE6KSBAg/x5yGv3f/ggpy1sNhAPgEVna9XvL4xNnAlbBtOx?=
 =?us-ascii?Q?T/cDhxdGYjEjblpoakJMZzwnlDP9fmvkD3lq0lLoyMUb6FzYeZao1kf7hgQT?=
 =?us-ascii?Q?bEuDJ2/K6qWjHgaBx6auvs2vyqOBDe7pEv4qHos8GA9Z/MAOfir00Rveg+WC?=
 =?us-ascii?Q?xeG0Nk2yh3Q+cbQfahZbEm5X3SiOe0HVZ22SWUQockI8I9MyO7Q1/vGr/57C?=
 =?us-ascii?Q?lzZdHm32cKFNfe+EznpTpBbc01d+YaSy9HeJZYYu/rz6JVvR8sCSD8zVGqBC?=
 =?us-ascii?Q?VWjUb61Yd0uCj7l6zZy0WzK5+4UAOaKygHobIMEKfxHr9V3dbvHExdqmwKFa?=
 =?us-ascii?Q?1mmUvMtef/RmJX3X8slxEVkvMk4UjumSaGpTWtdPT51CxzJS85WBBjlt43AW?=
 =?us-ascii?Q?6L79w79bWXeHtXyylYdAmJR6E2KMx0w6fZRJqjIoXv9J/sLXwBvRAfa3VzbS?=
 =?us-ascii?Q?dxkO3vi4Mrt3mpSJBog38zji+I2GFeB+yJXw6plj4rCHMRkByQf0dWHQpWtN?=
 =?us-ascii?Q?THel67A2XfyT0Ql8w1J92WIeXgLHGpsVA4/O7iUlGBUTbExFldYpOvupFW7/?=
 =?us-ascii?Q?Ci75Ob1ZLWfsLGrXZfvtK/CwLVE/1OHYmRoolTtQD2J+QMUi268p15xXIafM?=
 =?us-ascii?Q?ebvnlL85tfciTytju4QqOrKmDvIBUNcT6RIbpOix5GVIttjkjSEUzBs+Z2dd?=
 =?us-ascii?Q?KhgCkuEHfo76MYZHtuEX07Pkx9zj4rR3fKgFMcnujgh+/GkU8UvGfVxOm7O9?=
 =?us-ascii?Q?7vbsFQTu97rXH6otkrrAz/mPrWw5BZnICxYmTbCKUIzjmWELHqFSVf/FZSDW?=
 =?us-ascii?Q?7VaGwCz9H2vQiTwbRBWXBPEx2Mivp8ttGR5c57Gppad3P1KFBe8UvBIQSpn8?=
 =?us-ascii?Q?NgmseYNwn6M5ms/0O7xiVuMCtyna6+ZzxiKhBMrPzTIONC+QWVvdXOQlx697?=
 =?us-ascii?Q?ZrLPncaA1kSB6cSWEt9ubn+EmBoUP3eVUwzRKCFMrTwW+yoVymzryY6a7m9t?=
 =?us-ascii?Q?z9pm+lhEGuD4+y/6mYvbs2Je/6incn+mlxkZWs7ZSQw+jKx18xo8JiiHTlNT?=
 =?us-ascii?Q?Rm4Q+/yFCOOyhTdCqiMq1/b94qcfqe3uX8/QSNhNkHq/byiRpARiBAgEfNyr?=
 =?us-ascii?Q?gMlnvP3dip9XYG4au6EcwIe3c/TzfimFCWW6zN7U71Axql79d7UzP9TvRdS7?=
 =?us-ascii?Q?/yCxcypoMX+XT2BOjhtSO7Of+8UyEFB5JXWy9MEN0U4Xq2asTRYi6GyRf3x6?=
 =?us-ascii?Q?zhRkgtsTlQrZtUVSFoPDIkZKbYs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TyDg8nKIGBqVqqozBXPp+a7oawtWR13L+9Dn24lMT9mQQwUm16UOWFyd6ctP8RkFU2+J9/QSKM8EZC40OpT4FeoJSlweFAvCqz5rmqvIk19HdHhzHyFhVOz/lm7uyEoHTYmpoaitNeLYySxda5oeBb5iKeMTYJ/zCH58wTkrlFhhCXGArROdOM9HHtxqkcx2unSeLOnOxC4Fe82s7NXfCoHnmhW23pjqyJUoebkyv0eZk2NEUDFS81y3itU/w4sBlhLtqESzG98AqBxJvMm1HZ0dwth/VVqhuEFVgKWXLmCAWiKr7q0qNlxEiiuBojhZW5pJv+0Fr8ic9J0Z4h5CuqUsGUch4gp3h5P9OQw3JZyEEtcGfHeE12iNsj09GoCyimiA/iSa27p77272vmYsk0lgTMQ7AdEbBe7tnBQZKM0m0mM/NtJ0bpkfGvRcja5m
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 18:09:17.0713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ceb84c-a8d0-4e0a-848b-08de673d2c88
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6409

From: Vidya Sagar <vidyas@nvidia.com>

Call pci_epc_deinit_notify() during controller deinitialization to free the
resources allocated by Endpoint function driver. This is safe to call
during PCIe assert sequence because we don't expect Endpoint function
driver to touch hardware in deinit function.

Fixes: 40e2125381dc ("PCI: tegra194: Move controller cleanups to pex_ep_event_pex_rst_deassert()")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V5:
* Remove pci_epc_deinit_notify() call from pex_ep_event_pex_rst_deassert()

V4:
* None

V3:
* None

V2:
* None

 drivers/pci/controller/dwc/pcie-tegra194.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index ea1f6b26f8ec..ea39e263f4b3 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1635,12 +1635,16 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
 
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
@@ -1798,7 +1802,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	reset_control_deassert(pcie->core_rst);
 
 	/* Perform cleanup that requires refclk and core reset deasserted */
-	pci_epc_deinit_notify(pcie->pci.ep.epc);
 	dw_pcie_ep_cleanup(&pcie->pci.ep);
 
 	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
-- 
2.34.1

