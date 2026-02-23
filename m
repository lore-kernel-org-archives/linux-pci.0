Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012030.outbound.protection.outlook.com [52.101.48.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B15366DCA;
	Mon, 23 Feb 2026 18:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872207; cv=fail; b=ZSrC6wjdK/Yi14pYtQhxRKPJg1SHanwtnw+DD0dYNWTEedE8BDxYbrfyWuhUC/eKHzjDTKvWEyn4w57dZyrRKDzHHlkxZQqxrx5o0uL6GQj64vaBP+vvkh38pVqIO3UHs7zO2pdScUEZnhhuPBgb4J4ykFnP8qTOK+4kP0m4nu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872207; c=relaxed/simple;
	bh=xsApKfdvlUkvbA173JbXf1K1kd1z8hcKuBamIaUwWCY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZ7JaJhiMOGuAoMV392uW4KUgrsWkiNeKSBsQMmw8p5A7QQI55EmQ7R28OS+5xqmqA3w8hUEWFdZPI67PpukRS45o29Sy+rG2yzcqgxfFhn5aan3rNmfA915hIkuQKUsJUEfQqFF61FwIJywHmYzMap6cuL5cBCZrP06Y9+h6T0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aqqoIwIF; arc=fail smtp.client-ip=52.101.48.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aqqoIwIF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MqBoFFxNo2i2uOrEDRo916thQOm4tWF2iS/2HV3PMDER+395tnpfieOe3Y75ABZW81dwcvIj9auHolH/UXe3cTdRLwmD9pI+fpxT1QoMEP0KVjBsGBDvOcfXNejdmAB8d5CEWsw5Lm8/SYj/D4cxBDF8uRhjwKaSLwP3exR02EH10C78tVVM3MiEFtNJJPzke0a/XV1BpJCkEwDPa92rqaAhK1Xm6hkENfLeQoBvYq5o6M68+Axt+qpUGqP5MM+EbrgDOhb6sHzOZoRatvgN6YLBEyUczv2deEXSc7Iw1QvWoY6XT4EY8pQOAUS8yWwFRAhCZWmMA0N8+9arvxLQZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79xY+bf23riJ4Xj+9bI4a8s9lHZTpnmxjQW539EQJCk=;
 b=xf6FU4xsqPphXjfYfpHcekj10dYekqMs4kEUpfKvacJW7lSs4eJLXGhTr/uiQTGA/qzpRNCNiLJmVjV3TmzmeyvHDXmsKnHDS1rX6fNbdC/m+mQspX9dyGUuISn8YkT5Tw44XDMj+/drc92HCuoAjW1z/BBQ1H1c3goavQ0FfZpeKWh4F1aci1c3PQo/x7SGsk1eIqysHxHWSJd8Mjis5DaTpP5ZWPR9xBbIN7i+xS0sCgBMb+GExI4AvPbIjmAU2bCg7FfBw9HPV+5sCvOVn8OrNgBrqeL8sbRbX+y3d5qMZgatqd1HuI3dq0KPFhAhyX3/aW61VZ83OFSQSV+s2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79xY+bf23riJ4Xj+9bI4a8s9lHZTpnmxjQW539EQJCk=;
 b=aqqoIwIFkJHdy+tsftg75kuUryH4/hWPfU7xE5I9VdVD5FgPJUz6BLHyLlG0VQ/8SwMAxcJIXsPzm4Fee4R0rAvQlDj1tMNWm0qAqKZ9osP8YESSdvxcYgGRLy7DP05zxjWQmcI9THaWBW7v7oAezKU6mibZ8pcxeFATenJ8tjRQPBtKdEMVNlNFwxUFUn4XQyOcP3Gp5peJrg7ipHx+8uwBDCJUH5fY0IlYyCt5R80PwYnix10iStZEOUXf1ZetcIbMCe0f/n8iA5pUsLGfU004S8CGYRORnoAJy/V+h9WY1mmbrXfnui8b1zZoH/0lnxkp2Ddm4ewBdfiSsqrAoQ==
Received: from MN0PR05CA0002.namprd05.prod.outlook.com (2603:10b6:208:52c::11)
 by SN7PR12MB7273.namprd12.prod.outlook.com (2603:10b6:806:2ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 18:43:18 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:52c:cafe::79) by MN0PR05CA0002.outlook.office365.com
 (2603:10b6:208:52c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 18:43:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 18:43:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 10:42:44 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Feb 2026 10:42:38 -0800
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
Subject: [PATCH v6 04/13] PCI: tegra194: Disable PERST IRQ only in Endpoint mode
Date: Tue, 24 Feb 2026 00:11:42 +0530
Message-ID: <20260223184151.3083221-5-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|SN7PR12MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d162e32-e2d6-4313-5d98-08de730b6963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1bnrlrXNi+w6IvsqFf00LiGZfiLX/Cq3PstgEZl7TjzO51m2whv9mL/ropxA?=
 =?us-ascii?Q?VsPMgBCLe1yJeZntHxLQLcx7sf2j2/XaP/8P7Px5TrDLRmRKWOvqow8VgQp6?=
 =?us-ascii?Q?rHjIbjtRsD4YCP4bVG3csw/BMBSU0jS7h8h5qav7XFgGy7rSxGwTLJLVdzQx?=
 =?us-ascii?Q?Cdkyoej/nbo01D0rk1nl3a3k5VXytSuB/3gWVs1oJCDumtM+S7mRmjG7N7dj?=
 =?us-ascii?Q?2MImJs1YVXFs4wltc1Q8i/7GYOvlYACSPWwMwX36tCfoIIWsxZWoxh6RyzWI?=
 =?us-ascii?Q?w2MgVS3A3N8uSZMvFScDZNaxPDZmnKT57zbblVKLbhycwOPWJeCV0R3G+kvh?=
 =?us-ascii?Q?RPRasITD4jYmU/50Gj4KDcP/JSpjXkjbd57GraEhCLcDGv/m2ZwBSqhMo5XS?=
 =?us-ascii?Q?le/bcRwKnSoZ5fdNeh3JfiJKJZDB8fQXrWEwFM1lommBXiVf9d8VdtV95kAI?=
 =?us-ascii?Q?OD5GgF4GwIm1qPgWl06zmki1qySXAlrP/F/zsZQ2Gc1EF7/gHu9RUpo3rP5Y?=
 =?us-ascii?Q?hwSBrGxrPwNC1HVWuNCvA47G9Zze8co7pTiZa5KMN5M0+tK018PC3/AtZ0E5?=
 =?us-ascii?Q?0CCMyEsjz/9D6fbgm8R4tM/7QX8B17/JjfSGEQobgBIARTQQax7Jopi6kolt?=
 =?us-ascii?Q?gC4Bzqr6XdI3z9JecVdmqLNXMB7Cik0IZBinFScR9k1VQzpwWvtbme3yWE6A?=
 =?us-ascii?Q?d9OBXwJITd4G6if6QjXS/Ckxdk5gDmlnV5uYO8ELDlpTwHMJeZmN4uOiPfQT?=
 =?us-ascii?Q?qX4aiIn4w9Tc5dtjAsFMCVcr1YrpMngBCu5bnyL/E2vcy3Ed14/WljzmRfKd?=
 =?us-ascii?Q?pp1T8lw5YlBoBSic91gNtFTMsykN23dLxLfVLvZB/wXBNZEGE6LgKYuX/EAF?=
 =?us-ascii?Q?kHIJhZJr/PsoJuyv5s4VSNyuYG86CLSUyF3zUkPliscWoh3yqgU4EEB86CF7?=
 =?us-ascii?Q?6kCodqIK6rKMQXNMlvopwCUx+Wuy0/4FhIgFy3KnldP2s74TfbcTPslfseOC?=
 =?us-ascii?Q?ZCAIAqGUXssHS3/9tUQ476ryQIR/FSGYo3Ih3iOUAMyINSkNXQbDC6gzEEUR?=
 =?us-ascii?Q?/TlOwwnO5vIMgeJoV20UHdzY7VfuWOprGbztmmzNadvNyXOiBqxiY8sg0FZN?=
 =?us-ascii?Q?96/n6ibt2Saiavademy94jAI4CvaXdttB3WjyM5yEi7+cwdhNPy5TBYsta/E?=
 =?us-ascii?Q?yq9W1v8Hs7yxIpo7XsqbGHRMIiHrUwEZS44/xIvMY9wVdR6upA9nDS+F4hNw?=
 =?us-ascii?Q?jmvmDatDZgu0mZTq60SZcs9fb+oEHYrw3DbL+/pNPgRXpKuavukOQJRPEjvy?=
 =?us-ascii?Q?O2col31HHzSA+IQACOeZ3lszPfiMbywWZFc/v90sH3VfKDVvOx8jjAKs2hYm?=
 =?us-ascii?Q?2yMhArFtvmCl0PluVK9YVU07Gj5u9qDNLWebLALTt+9dAXhJoLtCJXLwocA4?=
 =?us-ascii?Q?UvjAewUF7Ni4KgHYrQNTG4kTtYIQL8rZzCLbJl68qeDB2c27ZJ79/bFtZNPX?=
 =?us-ascii?Q?PD8mU9JcRKh16xM5PrOKnZqj38vsyzlpeLavF7NU4SsGVF9imRhtCoh4wcDK?=
 =?us-ascii?Q?GDlJ4TpMbNILpWIz0BF/Zwo8OSYK6o4sgDGu6qev+u8Pc015VjQguEErF67B?=
 =?us-ascii?Q?xhiJYINCvY8hs7UMaMQUrJ6BVyrCTPKkFD4f7N5kugCcna8WEsx52p29mr8L?=
 =?us-ascii?Q?ohbTj1iwxLZGGN8TS2JgXL674lo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/bTXgraQAnS9jRqmgA30tWEAp+k2iGuEtr7LeC4zpsJofOnxaz1SRmnhaxmQwNoCcAKV+TgHqNvAWCfYpjcp9DA3HLfHklLmShPX+XtJpBC+lK7Ct+DT7nBxyHfMVKnrG6xJEaOd80MUbBG81oQO3KEGXZSBKOzo761PxjZcKQM673zk0uc+9gOad6KZutZuSEbHDvCdWb2hzYV3HGKjz4Ly9YDlUVe9RI1UUgAd5ytugte4aLXNTPtMxobBAVwqqxI4FTmE7Tn4yA3Afp7y4I6c26ckmvKnl0kpQOtG/jthFXlUyum9CfiNMPdA1t1mJo40krqVchQ4IPwmaKCWSMzC8Rcc1A7uqXCgX6UXIiVMHuP/X80Dxvm/LA9nS2ukkfCfk2/ndH05GBXZaie+82d/GETmYplDfGseqrODT8R6Kghii0iZsgn6yHbFGI64
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 18:43:18.1252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d162e32-e2d6-4313-5d98-08de730b6963
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7273

The PERST (PERST#) GPIO interrupt is only registered when the controller
is operating in Endpoint mode. In Root Port mode, the PERST GPIO is
configured as an output to control downstream devices, and no interrupt
is registered for it.

Currently, tegra_pcie_dw_stop_link() unconditionally calls disable_irq()
on pex_rst_irq, which causes issues in Root Port mode where this IRQ is
not registered.

Fix this by only disabling the PERST IRQ when operating in Endpoint mode,
where the interrupt is actually registered and used to detect PERST
assertion/deassertion from the host.

Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V6: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 808a1e213b79..9455456028bc 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1028,7 +1028,8 @@ static void tegra_pcie_dw_stop_link(struct dw_pcie *pci)
 {
 	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 
-	disable_irq(pcie->pex_rst_irq);
+	if (pcie->of_data->mode == DW_PCIE_EP_TYPE)
+		disable_irq(pcie->pex_rst_irq);
 }
 
 static const struct dw_pcie_ops tegra_dw_pcie_ops = {
-- 
2.34.1

