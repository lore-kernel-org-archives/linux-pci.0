Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010068.outbound.protection.outlook.com [52.101.56.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF380368271;
	Mon, 23 Feb 2026 18:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872406; cv=fail; b=K1FHhBTXKRtUW1wroCj3BfUZR606s6qH/psJiOpHS6XxkBuFPyitv8L2KFxGDU13tHx3JuhQRFShpCkcVCC6L+AX6RAJtPwFVJGqbVHVmzJxA9Efm3vgLffxf5WZiTGJ+VytGwL9Ug0SPfd17khKe37TYf9NXXjpfG/ac3r04zU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872406; c=relaxed/simple;
	bh=OBlUggWYMCKdif8VZJNTKPbme+xn8TnyL394GJUHqno=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKs5aFdQnIBpjoVaZIHbyHOqY1TRMsFDSR0mDUE+JqQAOjNm04SJr+h1AOu01xDyPotkgIz9+WoiZ2caP1DXhH87ryNsfGw/exdF6qYEXFnjtVOYDYQK83Tz4+UhoTH+xHOquv4wQH/avfx+kS7H9I49pno8r36Du0GF9EC1HdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BiLNNXwO; arc=fail smtp.client-ip=52.101.56.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BiLNNXwO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukLYJ52z7Y6ECFrllGaQL1Vn0OnIGqzBx/RIi9oSuwd7U4rP+TLIcXU2hWVhA+MTbKTGM7g6p0+KpGNp8uqxL+lUOz3DV5gzgDBN2R8ij4W3F8/ku3ywz0AME3M6i2RWawllGOTH9p+o3cUVdlDVKCBeCPm8vaYZcWXwX15HnNoXcxIsy4JH/sY42qSkTNthMT0QQFtuMSB6wzv7mCLeUp2NNT2+FJUoEOPY+uUvjsCqfjs2V1+MKCDjVhLvg9I8LU/b+ezMh048wHlEryJBO8sRrRdn5FSgS8oC33/epYgapfLbqt6exTaKPwsxegii8TXCGBC14MljSiM8WoX1zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GU+7U09BsNXyrDEr4WbyVJ54pcVM2du2y7lcs6xPpE=;
 b=DMutTAs8IrbjG7y5E9uoobJ2PDhXQIunNnl6RuDG4pw0afWHWPJZc6cVNhPWoU0ec/UeuAkveW3pDNoRksdjfjG14FtmJo4Wy1b3Br4bo6QoUtZ0fWCpTFQ8EBoNIpWZjrznnmSNcvAhxVPnsteFC2hHDOM4ZOQyQOLKEk6TnNJnn+grwgT9GxKNt/ubAnKIrFHcE4mIIRGXTKzVAAWGSio3egJg3FhXHM5IkBEg8tAUANl8nd8K6Leaic9OKmeemQ+Pm5x9kXmBw4FYeo86/x2W0WjzTrPPhDhzFZJDnMFcocICIa1XHumBHK1rgcyuxKRKiN0UByw+q649JTQJ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GU+7U09BsNXyrDEr4WbyVJ54pcVM2du2y7lcs6xPpE=;
 b=BiLNNXwOKISPk/TJK8iaQQyzBZY3qmomHIjONqD671Eltg+7i54aJGo61zxs2abimxBvBFDMu642yc8eQ8tSPMJRi/jX84jcd3gztfmy/fY6QzWIIIxXkqOYSn4G+0NjR76FWQtJfUM6//VhxeS4gDwbKzmvOCqYcV4gFfVy6Xc95QTtpZQXbiDL0iNJSvaaE07qGJFkqXbTv91qHwYXnPZBVNBuC7YqxbTrN0wDEFbLAZkTIgEYOJxmYcfx8ad17C7Zn69q22B3eddYOmkGiZkfRDt99APvHPQMCcEgnEHN1sPvLDFDqHYblAEKI3sB4weT4jOaP5NrQffxpehBvA==
Received: from BY5PR17CA0021.namprd17.prod.outlook.com (2603:10b6:a03:1b8::34)
 by BN5PR12MB9487.namprd12.prod.outlook.com (2603:10b6:408:2aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 18:46:32 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::29) by BY5PR17CA0021.outlook.office365.com
 (2603:10b6:a03:1b8::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 18:46:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Mon, 23 Feb 2026 18:46:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 10:46:08 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Feb 2026 10:46:02 -0800
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
Subject: [PATCH v6 1/9] PCI: tegra194: Drive CLKREQ signal low explicitly
Date: Tue, 24 Feb 2026 00:15:30 +0530
Message-ID: <20260223184538.3084753-2-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260223184538.3084753-1-mmaddireddy@nvidia.com>
References: <20260223184538.3084753-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|BN5PR12MB9487:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d610f52-2451-4f59-2efd-08de730bdc63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A1oLIf9wtnLyH7wcfXemEjHXqX/r+A7KxIgyAGKMxW/7Q8gL/8i4Ya0RcJkC?=
 =?us-ascii?Q?0oHgdIQpBu0mtbGHG4YAx9l+3Xt1CicdIglXUkJ3GLQde3r7vIVgz7rjtvtI?=
 =?us-ascii?Q?vV+TyekXfzu9YA8f4u6dgseZsslK1mf6KhP359g2/ln0nCLZKB+sxExOGqf/?=
 =?us-ascii?Q?E3zG4b+oE4OalEtBP+m3Ph9129A7ANKHet5x3jcc04Q4nEoZuCIE2ZySnlV+?=
 =?us-ascii?Q?IkKlok9fPRcrMGGOxWcjVe0V+uJV7t8NM2/wM3v0Kco3OAf91mbqsPkq0t1/?=
 =?us-ascii?Q?1qCSrUG8JN7XiIkZnEh/JKU/zV2qGpKqbenQ9h2XGCwojZFMAVGJ6+V6nPLN?=
 =?us-ascii?Q?3Gsx2LuPeMRGjkGI5x/439JrZspiS8U9+NSYYvNhNj0JssriT+FKIzEzTm9A?=
 =?us-ascii?Q?rT30SkP/aUcCaqpz2UnrjJ36qh3trvyxFq2e4Cw2lxhj97mFJaE+M4bfy/gY?=
 =?us-ascii?Q?vayUMTVVdLkXowZLtCP//DyT9LaiYq5jjSy3XDB/2KVo9vAvzW0BpTkTSjlM?=
 =?us-ascii?Q?oJCswurVXlO76GirT1wUltYNrx0lY5O0xy8iyXSMPwdU8a89N/6+S6EY0qLh?=
 =?us-ascii?Q?fL54T1ASjIqEKxQcgheJzGv+ogyDS47L3Uo7WwYnfeMpgOIh9/CeszkawQmC?=
 =?us-ascii?Q?Wq1AZyPU228jJqfpxpehaNzMhuYWhsJekXB/gDqEUDoGA+j8AXaJnQYqUc8K?=
 =?us-ascii?Q?mUpvy0SmM+dAj1+2uNAC0Dfjwz2MV2WW1NYOni/I6eTErrUmFPjT7tSIIl6W?=
 =?us-ascii?Q?NDObe1q3zLdD94mtP3QHbPiggQZrKCur05RtBZy0h3krrWv+iqY/j1HvgD4u?=
 =?us-ascii?Q?BfuVjReeDtllELoYcLIKNdKKNT96hcxVoUOV+5ORPfeGvJ7UMEuGMBWenhEB?=
 =?us-ascii?Q?M/G/qOTxVtyH+ZBtjqVEddpbUSH1LcxNP4zqQaocKupvjGvjj0J8Wju+Nyu6?=
 =?us-ascii?Q?jI7xxPEQVmFFZr7clQnXgfWJoZQcv6FcMuQqo97H2yjCIxtZM2X/zBCbG1Jv?=
 =?us-ascii?Q?FDT9MFJ4QQte5dyP8Ae5MULRtpZUN/Az+9dsP6B4wH9Zef2tXOA3Nno0IH5i?=
 =?us-ascii?Q?HdkYb4qTDmjGV5ef16xjk74q7TsNXQO/wbGydM9FPbOCUZvpyEaYKVM2BkcI?=
 =?us-ascii?Q?eS7ofMK4IRsc6t7DLhELbeU/bt7vntt28h+pqR2L+mG6HFdBF+0rnf1gyAgh?=
 =?us-ascii?Q?N2iD4rEQVsb4EnE9MPykHBmP55E6Rm4FF7hdbclXr8sG0eWtV+Zb1NjzEQED?=
 =?us-ascii?Q?DtlO14hOhR0pz6a+EdVvA3+GpZP3IC8HCaVM/ruLEr/a+H+3Tf+ztF67KpEN?=
 =?us-ascii?Q?8CVh0p2US0yAMlscTP5PhUZp2zYEWb6cd4Sd5fA1f5LByWvRPlkLZbsHXCw8?=
 =?us-ascii?Q?IRbZElMGN691kr8TPVMi6aZVptnZvtvSCkqamMz7aK0BJG8NQASGDW01M2kq?=
 =?us-ascii?Q?equce1aHq1mFCBlhKJqDTPaeTH3WktIH+9ejawHYWrnZ246sb7352Ne/9CYX?=
 =?us-ascii?Q?VNTJJML0gnPKSiDlcTiH4PU3FpkLBOV66gKiHTL+HiVINOEQWMbPhfvbsqnV?=
 =?us-ascii?Q?mO2U0YQ0uXYQ40eh87xVa3xcxtQkJUjb9EPvQiiPHa68Te98u2sHNpHPNJcf?=
 =?us-ascii?Q?gX5IdWL7pLxAe+IpiOtrEZXv5T0BJ8ddIPMNr/5hQVZuLh2Y34VMbOx+dyLD?=
 =?us-ascii?Q?HE/FwPw+4WuabgyAgiF/Rfs6ljs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JVZp21SsEGFgNj3ww9oeSZoUY/spFy/XgdNzXyRwGtIHg/B9YS+C7NY9L1HpazN1oTziudCnPJ575N1dNwOQ6dxOGh3BBWXj1Etx1Lb6Ox42WolXBYTc/wmMp0C/YuAFFeMZAiaK4L0z8i+OMiIaWyvodbuZv+XSR8X38qtTNi68w1eKNDZ9v2F/SNK//ikp8axDGSOuvIN24C5yJWaHieXfqMJr8C5ExQBWxkDYN30+xZeBUxG/+0bRDM6FXt5rdwFiVrUYi/u0kktHECZtIZ0QhBee4jru/A6VQXNXP1mMoRWq7RdpuC/lhKttPCI6WGHX4dyg2GzLoL/mzBimBlKFVRGIogK57RgFZi/dV9P/7/U7A02P3kKRrsLmx8FGSQbLG0FudOgM7y0YtR28wCO2+0wHgp0CzcL0FN5e/s1tY8429uUjU+otN3UuaMv8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 18:46:31.1256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d610f52-2451-4f59-2efd-08de730bdc63
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9487

From: Vidya Sagar <vidyas@nvidia.com>

Currently, the default setting is that CLKREQ signal of a Root Port
is internally overridden to '0' to enable REFCLK to flow out to the slot.
It is observed that one of the PCIe switches (case in point Broadcom PCIe
Gen4 switch) is propagating the CLKREQ signal of the root port to the
downstream side of the switch and expecting the endpoints to pull it low
so that it (PCIe switch) can give out the REFCLK although the Switch as
such doesn't support CLK-PM or ASPM-L1SS. So, as a workaround, this patch
drives the CLKREQ of the Root Port itself low to avoid link up issues
between PCIe switch downstream port and endpoints. This is not a wrong
thing to do after all the CLKREQ is anyway being overridden to '0'
internally and now it is just that the same is being propagated outside
also.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V6: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 9883d14f7f97..f026af7c2ce0 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -44,6 +44,7 @@
 #define APPL_PINMUX_CLKREQ_OVERRIDE		BIT(3)
 #define APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE_EN	BIT(4)
 #define APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE	BIT(5)
+#define APPL_PINMUX_CLKREQ_DEFAULT_VALUE	BIT(13)
 
 #define APPL_CTRL				0x4
 #define APPL_CTRL_SYS_PRE_DET_STATE		BIT(6)
@@ -1415,6 +1416,7 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 		val = appl_readl(pcie, APPL_PINMUX);
 		val |= APPL_PINMUX_CLKREQ_OVERRIDE_EN;
 		val &= ~APPL_PINMUX_CLKREQ_OVERRIDE;
+		val &= ~APPL_PINMUX_CLKREQ_DEFAULT_VALUE;
 		appl_writel(pcie, val, APPL_PINMUX);
 	}
 
-- 
2.34.1

