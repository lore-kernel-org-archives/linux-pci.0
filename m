Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013064.outbound.protection.outlook.com [40.93.201.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD3036828E;
	Mon, 23 Feb 2026 18:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872233; cv=fail; b=r6ENMNPZb2/EM/azvpn4CAXQDcGlZmIzYw2TWXn6bXPV4jD735cMTZuFhRJQFdW2YoWaL/mZNnH9CsDK5J3iLBq5e701+eW4YTz0pzbG5Upsl2gvFN50LSobJ/KHg8ZW50vrOGAD7mMn5Pvm+v91rpMLhcUW2SEJrg4TpM3srsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872233; c=relaxed/simple;
	bh=aVTQyTgwuOoGraZXMZnPgjeu0vITbKd4fOKdYhuKY/I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l8H9hdCbQzQ5XZU9GYhbbu6DBGIIcgUd2m5cklmWx0muD6jCrBbSbIFvrLtwAaqn8khuoIE7LKuLI8pg22bo8pLewzr/gPwD1dQQwNi+NJ1BYx5njpPjgDfLZVKe/iGmA94ERWNhNB7S/tUDIVFqdpTmx+wPq0kn0cd0joYD4uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pDh/Jjhr; arc=fail smtp.client-ip=40.93.201.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pDh/Jjhr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBw0QmqYn27a/Ncc9SsrsoJMWvNRNbGs+rlraPn3o64cbThsmCg+SuZlrSzvoI559K2OXXG62Bd80LHOSQ06NZDUVQAs1tddBQbU3noBmKV4R68UQDviI//H4kVBk0E5yml0jnm2ug/0ZL+KO8YdndpZgYQbCAF2hXAw+C5g4c0ROU8QHhFi4VEWw5bTFrBwQJk0WfLstd5loOauY8cWjkFGwIzh+vSanxfW1fvTUja/n2XGy5ZtXkXjv1jpnBKTg+ekPYBDuQPSxg22DfuHsVDUNJePh47vNQ6pdb1tl1R3j5C12fAySwCC1gpVLi3IddovDdbmQnkUGK+IahF4rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSCiTuR1v9JdT28hKlKzTbVWwwpIU0CS3BXycXlJtTw=;
 b=ifmhejWWCBWTTP5dpsVEdlAef2bbrV+tovIICNG09dookNv6TuoYtVptdxIDPxYZKqzNS6XO2SpfUBQUtQM13/7iWFxHh3xPxLQxex8bD/Mi7QQxk8jq66RIgP71uKgCDqUzZ9BixS/fISxy+Qel5V54Pk/1sm/4NHMG2lPSsLR6xNiSCX9yVU2KirytukXJDPEan+mDMa4pyR28sGla1Sqr3d6/iwvAe3bbsl4h+3IGDbDItKAE3tgrPG49lY33/wxCXa2VxgK5FrkmNGURPZkjypwUe6m64fKcVMVW6Y/ZhM9UQwDLjGFmEZy4r6fAjR9P692lRUIgi0HQbykteQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSCiTuR1v9JdT28hKlKzTbVWwwpIU0CS3BXycXlJtTw=;
 b=pDh/Jjhr0XDA/Or45QUx0tj/IG03gYarLeIUVk7fYk8eaVsDIOodNhPHsC/oWpUZ7x8zdkIssvP/+eTmYfO2p/JfFDGvRCUmJYSWS3t7byc1DTL3Bpp/HyEZ8LbER0fxw0xsgaSR0B1PEZg/1i3aloJHdR3j5nIOyvY9kVesH/44xIXd/ZK9hVa58VbmxvD7paxUZVDtrgU0l88Qg8u1BDMcsX0Y17GTMmPGYfYwZiOJr1deKJjPwww0I6PseaMC8fgbwlduk+fRHhj6p71K0WIvNToSzDLxA5XXbi4AW2FRSh5HJE497X69bojQchZK/tgmIS+lc8YTB5DAglSF3A==
Received: from SJ0PR05CA0160.namprd05.prod.outlook.com (2603:10b6:a03:339::15)
 by DS7PR12MB5935.namprd12.prod.outlook.com (2603:10b6:8:7e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 18:43:40 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:a03:339:cafe::13) by SJ0PR05CA0160.outlook.office365.com
 (2603:10b6:a03:339::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 18:43:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Mon, 23 Feb 2026 18:43:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 10:43:17 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Feb 2026 10:43:11 -0800
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
Subject: [PATCH v6 09/13] PCI: tegra194: Allow system suspend when the Endpoint link is not up
Date: Tue, 24 Feb 2026 00:11:47 +0530
Message-ID: <20260223184151.3083221-10-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|DS7PR12MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: 072bb8df-418e-467c-f325-08de730b76a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i8uqIQMwPskZL6fl9CiQOPPFBL2NUZoACVUna15xUXiNX0vcZhuzV+LBFJOB?=
 =?us-ascii?Q?DpC5mNXkcZEB5mfQ+RlPjlrNuu2XYVRY9HfqBih1gZYZRYg7K6iF9TJbmsdM?=
 =?us-ascii?Q?gb4TTD/NkYzEkDPJLgkihHRh3FQ+sPo7ARnjkLesEWHPsJjUtirMrCbAgt1s?=
 =?us-ascii?Q?W1ybM0zbBbVAFkL0VWpTkgJ/piWAWJiwwYhVnZdwUuJVj7qkp62R/3cOO/Mx?=
 =?us-ascii?Q?VJeP8zXEGZdlN0IYUlxA/tP0tZTdaqs3BRqnJmNHos/zA5dckjFu4mO9eOE9?=
 =?us-ascii?Q?36P5LCxrUfRUqI6yErGl610JxVKb8p61Zbg0hUvoobMS6Eyj5TZpkaZpZx/K?=
 =?us-ascii?Q?ZUtXrfuI961agqeJYJBltENKO6SSn0uU2O/OpC75PfFeA0OTIPIv0qNguDJ3?=
 =?us-ascii?Q?/pv7uDuJA0gGyRO9DHEP/+aXbnFrz4/zz2IQyZnwnHb23egxMoB1pADHXBVs?=
 =?us-ascii?Q?5zbDKB7Fl9ombMjZ4uyzr84Fa94coq5TwZuRzMVzXHEGhRkXDJMiMHqIRaqL?=
 =?us-ascii?Q?UNE7vHqjyKorUQ6IMcwZAA4WiVuxSnDOmele5EtM/S8DYlxghagUQ916Zd2+?=
 =?us-ascii?Q?QmqO3iNLEt0zROdxMsNkCQfpSiPKe4Vgsj096pTtrQ2qXepcR3RyWD6ZyZeQ?=
 =?us-ascii?Q?Ij9lSBZKcojXK0bJg+s26IfR24I/Px92ZcQynAU9OhB5Gb72QJ3gdPpm7Sl5?=
 =?us-ascii?Q?ggQMGFopJHdTaDC2rb60mBc70x2/Uv6MijHDkAa0Z4idFSooBn5PjeyoN55n?=
 =?us-ascii?Q?MmXOv67U7n1UFR6sBUUNyZYyK/IJKwcLb6OGvq8vHoAwR78xUzQkdLaGZxj6?=
 =?us-ascii?Q?G8wfx0RA2ps3CL8i2EHOG7fcYULJnxek6bszk4S+2l9S2wZcNkgeTSAC6J75?=
 =?us-ascii?Q?/0c/kXKQ/zj4XfzVUMiHgr7AJxvd8H7nFvVtB+qoiZjSXNQp8X7FrD6jTQ25?=
 =?us-ascii?Q?gqHGwitJKX3S7idkAkI9wQUQ4xQqWQ9ALz1JfiI1r/aMErF1LWiIUMxlfuFI?=
 =?us-ascii?Q?QsDHY50P6RDpFLEqT409Vgx1ynIXDf2O1SAIh/cK11wUgRSXSijjHoYDuqxQ?=
 =?us-ascii?Q?CaCP5Y8qNucNeTFR18G8TsQhbKUIGu082XjfxZKIzLORkzfzl2i+CVkCSsh2?=
 =?us-ascii?Q?sJ4dwoqTfmPOtZAtP0OJM+TKrekR/lFer5mT+6pN+dE3lD6KnWKlsZ4AuF/p?=
 =?us-ascii?Q?ikuZQ1rQu/qvqhUCFV0nj9/Zn5or7722nJroSsPYVp1zXpEYH4JrlC9qoAkc?=
 =?us-ascii?Q?KTI4T9CqfL9HeZ5hD/tfP1fet5z/svWy2zBTVbiNxx81Qn3+Qs+m8E7CNo5n?=
 =?us-ascii?Q?eW2r5m2tsXCYLlhdi7Qe7L8Q9GqgzkVs9t/ZyDfouvDBr1GffdFOzJmdkQMq?=
 =?us-ascii?Q?oGszgp85Df2EazLKF13h7RRksltqSWwHonMrENHRnBDX3yQXcPHH3B7QaeDn?=
 =?us-ascii?Q?dA2gFCHIgUr36fBuGf03JjBBuSPMkW3X5tYGesB3sz7Ubu8uglyY+vRyygh8?=
 =?us-ascii?Q?sejDgYPw4jlV1T78vVHf3cPyQIat441PdBiyzWqUu75QN9uWuJuyO3FrFYxc?=
 =?us-ascii?Q?fyrLD0GesAu70wO0xyJ/4S1gKhnE+4u/zDIdzGPHNkqIRPl/qnV4Fcehrqea?=
 =?us-ascii?Q?rBCcwUFMyxhcm2V3HqsFcl6jUdFVmT70aLOaeQBJNyvXCTAHUYaOZpi2I+VS?=
 =?us-ascii?Q?Z3mpKPf32wo/lgh0ADwFH00BAms=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5OTXFYdaPV7XGYZrkkGCcN9kcgbA1zNGT68Prx7nWptSv6hauDRdCftdhYsn1fxxzG8rqoImmpXf8XqJxLMOUuBh7v4+/+xLNPMjaWeOOynePQq1UdaDxi2xcos89EYO6C/nOX2tJmPEzkWs8+dcEKLEljqQROF+8nEfygMQ4hc8jTHlOHtbcxxTR1BPd7TcY8mWGshsFyxMKfYX+mIjXDhiLipnmGa1DgPLCA+hleA0xQi9f9TnBvoKFDvn1Vh8bjPRUQEhuZh3LTM/569bileunKK8j4444SykiWHiTpX4OrOREpP3D5SRgtc80t026919QDfdwIVlwp6M1/SoPfNqP2Opy8Tj/oPeyfXBtPeFtKyrKogc7zZVSqPB2MNu7KHbHb1VSOui26B2dnmRW6upToIDDPzh96ZMne/YsGjyss1YVXPEnTSn+ADmukzA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 18:43:40.4228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 072bb8df-418e-467c-f325-08de730b76a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5935

From: Vidya Sagar <vidyas@nvidia.com>

Only a Root port initiates the L2 sequence. PCIe link is kept in L2 state
during suspend. If Endpoint mode is enabled and the link is up, the
software cannot proceed with suspend. However, when the PCIe Endpoint
driver is probed, but the PCIe link is not up, Tegra can go into suspend
state. So, allow system to suspend in this case.

Fixes: de2bbf2b71bb ("PCI: tegra194: Don't allow suspend when Tegra PCIe is in EP mode")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V6: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 31 +++++++++++++++++-----
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 61cbb4f230e1..58069b1615b8 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2266,16 +2266,28 @@ static void tegra_pcie_dw_remove(struct platform_device *pdev)
 		gpiod_set_value(pcie->pex_refclk_sel_gpiod, 0);
 }
 
-static int tegra_pcie_dw_suspend_late(struct device *dev)
+static int tegra_pcie_dw_suspend(struct device *dev)
 {
 	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
-	u32 val;
 
 	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
-		dev_err(dev, "Failed to Suspend as Tegra PCIe is in EP mode\n");
-		return -EPERM;
+		if (pcie->ep_state == EP_STATE_ENABLED) {
+			dev_err(dev, "Tegra PCIe is in EP mode, suspend not allowed\n");
+			return -EPERM;
+		}
+
+		disable_irq(pcie->pex_rst_irq);
+		return 0;
 	}
 
+	return 0;
+}
+
+static int tegra_pcie_dw_suspend_late(struct device *dev)
+{
+	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
+	u32 val;
+
 	if (!pcie->link_state)
 		return 0;
 
@@ -2295,6 +2307,9 @@ static int tegra_pcie_dw_suspend_noirq(struct device *dev)
 {
 	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
 
+	if (pcie->of_data->mode == DW_PCIE_EP_TYPE)
+		return 0;
+
 	if (!pcie->link_state)
 		return 0;
 
@@ -2309,6 +2324,9 @@ static int tegra_pcie_dw_resume_noirq(struct device *dev)
 	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
 	int ret;
 
+	if (pcie->of_data->mode == DW_PCIE_EP_TYPE)
+		return 0;
+
 	if (!pcie->link_state)
 		return 0;
 
@@ -2341,8 +2359,8 @@ static int tegra_pcie_dw_resume_early(struct device *dev)
 	u32 val;
 
 	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
-		dev_err(dev, "Suspend is not supported in EP mode");
-		return -ENOTSUPP;
+		enable_irq(pcie->pex_rst_irq);
+		return 0;
 	}
 
 	if (!pcie->link_state)
@@ -2447,6 +2465,7 @@ static const struct of_device_id tegra_pcie_dw_of_match[] = {
 };
 
 static const struct dev_pm_ops tegra_pcie_dw_pm_ops = {
+	.suspend = tegra_pcie_dw_suspend,
 	.suspend_late = tegra_pcie_dw_suspend_late,
 	.suspend_noirq = tegra_pcie_dw_suspend_noirq,
 	.resume_noirq = tegra_pcie_dw_resume_noirq,
-- 
2.34.1

