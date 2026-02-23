Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013054.outbound.protection.outlook.com [40.107.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86746368272;
	Mon, 23 Feb 2026 18:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872231; cv=fail; b=SLCWWrTFQ6Bwes1My5+xppcCMUZyJdUW7yIVZ1eSqNn77ntqfisTorz25TaBThx/pRMb4cSCE7aB+RoxLOEF7qd9fSmxYncX/mB4MHRDPwiJjSX2ltyM9rOPQmcXpTxLZtuoUbxLb+c7YnSHN8OfmlpVSTagbk6TxTQbMv8ABUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872231; c=relaxed/simple;
	bh=gUXd/TvobuF+yGMiu9qvhcMFjaAi/5ExZh0VANU7Y7c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O5WiFjROvoTWcrjxJXRN2G0BrAWfCD3w5SVjOl0l7sOwP8DGZtN8iJCKQrkjM3izbjjN+5Ifcj7F8gzlne38E7yRfAmlT0dXWF5zbh5+91JKcLNBhPohLoJWT8WuI5x+/u9PF1/BEz4GVmR9eEZjMv9a3lDHzIKqx7aWBFL4sRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ogkHiebn; arc=fail smtp.client-ip=40.107.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ogkHiebn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QL5wA50yW9YW0Py9WVsUce7HEGs5Kp0OghNOiaAV+62Q9ll+u9jyAHynVV6WXMHO9VOfJ4ams+HpIU8ya3l2T0wdCIejCGR7LkZbCWEwzGhvXe2IhxxdqTqIS9nYvb3d1+kDJnb+V7IOXQ1TN4OA+pKeV8w/RhbulCsB4duziVb3LSgl9MQK9iMLBzZMOib7R77jXJuculGQH3Z761G0JTbtkxCqkkElbKL8/ml+uTwMqQaXKv0YfCoud1WkI5k9PIwIK5YdzBl6HbSwb0kx29uZllV6VolgjKpZNaUv+oXX8sMgiHR9wtk+OxKyOBBgKATFAOYNaWpRmkTdxWt2uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sV0rffWVWg2zWrWe3llnupHowgkAtK8mzcC+iuqNVU=;
 b=DF/zbZpHZAqDyesn8c1bTeBztKJ/8fuyZxa14MMRstSdUN/MOtWhvIv7yzeN9wbyZ/tD8kQoO74nJOFnM7WeyroB9oe1ypyG6FNxUgxV3YuNqY1kitVhmJdULspwCBTWExAQnI1aEmGkT6GPXb9LCXKcjlSPb9SSHP+GHAFiUILTM4DGx1uSopa8Kz9iq9klZeN25dhy06LDj4EATvuCERIAdigse7qkTb1ZjhgsQ6v2WXkW4cZ3/CkojeNkWhhKPscoPByNDT6zNo+0REEwpBL+81vleEBY4ck5NS55gc900gdSt5stnnMeBDtupT1bJMkUQclgzy8FHDceTspXEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sV0rffWVWg2zWrWe3llnupHowgkAtK8mzcC+iuqNVU=;
 b=ogkHiebnNW7/modBoMeuPViOE18so76a9z61V38kiVeaYWrJAyArg/bUlhWB79/DdSTeDfhn6xaPOTZcGUiMQFrkhMwrHMSkWNtH3E57EV35XfzULimhlWyvoJ6WTzhOZwldfcN4s3lo6uNp5asC0oo80WztSmt1e21b7cqp9ytoie0pYq5HGmAJjlkwmLWXIiqM0mm3mUPMPhHZgPVfqgwCKmZe2uZg73vUttgdk9VpTNr6LP9l5o8YQI3cgsr5P29mT1VkQI5gHQWBEFQbIGbWRGDyfDN44buuqI250gzCyAWJ2m4WWViv178TpSqOXaQ4PRCgVbBgYJfrBqrfkg==
Received: from BYAPR11CA0047.namprd11.prod.outlook.com (2603:10b6:a03:80::24)
 by IA1PR12MB8520.namprd12.prod.outlook.com (2603:10b6:208:44d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 18:43:43 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:a03:80:cafe::75) by BYAPR11CA0047.outlook.office365.com
 (2603:10b6:a03:80::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 18:43:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Mon, 23 Feb 2026 18:43:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 10:43:11 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Feb 2026 10:43:04 -0800
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
Subject: [PATCH v6 08/13] PCI: tegra194: Apply pinctrl settings for both PCIe RP and EP
Date: Tue, 24 Feb 2026 00:11:46 +0530
Message-ID: <20260223184151.3083221-9-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|IA1PR12MB8520:EE_
X-MS-Office365-Filtering-Correlation-Id: c95ffa7b-a25e-407b-85bd-08de730b746d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TJrPcrrGrBGbOArilfkR2iFjLTttthbMCCNHJV2NOkLRYnyA9mGx0Tsxotef?=
 =?us-ascii?Q?vt1PDo6LZNmppU68q6JHONH4+lznitMbiwUzrhyZlXdNb82TVm/Cmi+ThuJ9?=
 =?us-ascii?Q?0rkXPqpYpsWYxvR3uTsncs+VQDYsPPWCZLrjzjcg5kz8rENSscvy4sh5htfn?=
 =?us-ascii?Q?mNW2KuePdaZ7d9/WSTMyBzTfdhmVvlwUyJyoS9fqig9kREFJh/YIc/nk2jlK?=
 =?us-ascii?Q?W+yISCiQD5TgfQsn4CJhPnFhMpVGJlygWv5t5D5bJimIt27fAnyDunkpUARn?=
 =?us-ascii?Q?EtpiHGmgogdzN/iRLa1HJiCEhzzYgwZDUD9sUQuFucdRxp9NQ9Tl9/Ztx8Ew?=
 =?us-ascii?Q?UCzqtISYxGr2FWSLU9PEwp07PEgBZpI+olajhmxmZE3jUEQZ+3NkZHtmAWox?=
 =?us-ascii?Q?b23VES2YuC/H65AGTg8Ob9d/hneIvNW0ii9iBESnXnyHzYsClcyOLnw4LRg2?=
 =?us-ascii?Q?S8oNs7hm/oArto0xP1wC+WrbdyRqenqXuQPnd8Fx7HpSaktACYqqndBPSzw0?=
 =?us-ascii?Q?l/wehPTVZGoxXML6xdqP07HdZduARoGkpOqUTOCO9raKSLDyIJ+RA2JQ5p8g?=
 =?us-ascii?Q?YPyLSHvgc6BRfVjqK4o9e0L3h4FYzo12A7789WI52B47mJHfphX0TzY0c81L?=
 =?us-ascii?Q?GxQOX/zCkqwDTYbhbpOCPiv3FOdvbVKSu2k9rRS+4LRfalq+rwK48rLr24EQ?=
 =?us-ascii?Q?LW0/7DQjajbbmOrjtaf/m0yyMf69zk1NEirMUTQtqHJSL0Y1dAL20P49d1xl?=
 =?us-ascii?Q?MRybFYtDfB6WPV1rJ29ZmUHZM3YLZREZMj8mdCtjInSvTecBX/CRcyinHqEi?=
 =?us-ascii?Q?c6UeA2LsR7Zaz9uTpN+Mvzl/3e5SbIeOCgKuJhb54LUU0faXXt2UCcOyH21i?=
 =?us-ascii?Q?s6xTBpF7DephTWva03fBK6/3w7ZgoD9Pp9AIPYNjNewlfKwjlNLp6zLlxVSl?=
 =?us-ascii?Q?PudjIxI31/KxUhoLW6mF7ETfCh7oc4zhVzseND4E5djM4HHB4uYOYd6pOFKP?=
 =?us-ascii?Q?CXc/QRC6aZV4Shw7qiE6qBjt86ww5irEtps54WsGrAVkbP9LLMr1VqNkLfne?=
 =?us-ascii?Q?31nYi0pB4QZ3jYAUrcAoo0FXpzgnq+2yLlwRoVt4gV72rj+Q/ZQyolntPoAa?=
 =?us-ascii?Q?7WTxwxRCrlNy9wrbthSEBdknGPfhHfMeZq0pSmBZl91BB/2p1BumIZfCg+Kd?=
 =?us-ascii?Q?bnNT7PCMJNhJUINoiQuZ+x1Y7qtGRlmnLzXqmyrp3ruKHgvUTpyCjIOobaud?=
 =?us-ascii?Q?XFMxcSQNa2NblUijE6871z0SZH05XZjBiAqNLHnPD+iInOC58sgbQMN82KXL?=
 =?us-ascii?Q?iUHQHKGt7SojDZVjuVVYY3rJR9Y6MRksmleYL8U8tsnL7WMovkaOw7Ea543i?=
 =?us-ascii?Q?4EfsgD1I66HNnWqqc8AMMY6vZb5J0I0EXKDaxtngeLkr25bFNbv7LiiQJm9d?=
 =?us-ascii?Q?dKsDMeS5AvmgwZWRsalZdpsJrH+hCPLVvGtevgiDatUfnLHzUHz8j5ciNVls?=
 =?us-ascii?Q?Gbr40dvTFXYT+4vyTI/87UGvQTACVHzcmu1Euh5hlHN+cIjhhvZOaxgaA7Tp?=
 =?us-ascii?Q?CPvxKeAjkEc7b6R+BP0MZeYs3pdqwqT3TW0ydFFp/cHLSKAdcJi7N8x+U/f/?=
 =?us-ascii?Q?Epny9lIbIcgN/pJA9NdR3p4OA4SXOyRAoHCdNCXiEfyGV9gFVvuZh3RqgXDB?=
 =?us-ascii?Q?mdqwTSmVfX+DOTvUlA4jsf1Mbug=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dc0Rta/IjIV+uzfHL4x2wu0SZgXzQhhvyUuWLI3vGoh31KUc2XoxVHH8bX59OaM9wJxG4XqfGA2hH3cBhkJtIRfim+kPVnPQgfH8Z5kyjeU2BE0mxdqeWjsRfoZ1bZ49LXn+W5vY47NWrqnDuc5yoehVA9E/mxj+5sKGxTjt9sQ1lCvGUbUWcgpdLVcFpCSe9Bd+AAHZ+wziiI+eBwYBnk3VkfOmJAIDbxyuTuXatjpSL3m5dPXW/3hQNNhjIyqZMx6ChFoW6xVcjGQa1ATHEx6HgSBiVS5XJDnvELXDH8gESSIYWjVtVxDRLd5T+nF1KMXghgOYwd1VJExFB0MVO86d9Rb804T0Wx06DmQyFd5XwkvZFFBjdGQF5HFZ6ONfxUrTWBrYhO4n7JwkvCe7zqTAcbwoHlFu46jtexVSt/VovKWfMVHJX4EV/f2UrsC/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 18:43:36.7055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c95ffa7b-a25e-407b-85bd-08de730b746d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8520

From: Vidya Sagar <vidyas@nvidia.com>

PERST# and CLKREQ# pinctrl settings should be applied for both root port
and endpoint mode. Move pinctrl_pm_select_default_state() function call
from root port specific configuration function to probe().

Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V5 -> V6: None
Changes V4 -> V5: Use dev_err_probe() function
Changes V1 -> V4: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index ad1056d68d6d..61cbb4f230e1 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1601,12 +1601,6 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
 		goto fail_pm_get_sync;
 	}
 
-	ret = pinctrl_pm_select_default_state(dev);
-	if (ret < 0) {
-		dev_err(dev, "Failed to configure sideband pins: %d\n", ret);
-		goto fail_pm_get_sync;
-	}
-
 	ret = tegra_pcie_init_controller(pcie);
 	if (ret < 0) {
 		dev_err(dev, "Failed to initialize controller: %d\n", ret);
@@ -2076,6 +2070,10 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 	pp = &pci->pp;
 	pp->num_vectors = MAX_MSI_IRQS;
 
+	ret = pinctrl_pm_select_default_state(dev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to configure sideband pins: %d\n", ret);
+
 	ret = tegra_pcie_dw_parse_dt(pcie);
 	if (ret < 0) {
 		const char *level = KERN_ERR;
-- 
2.34.1

