Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010010.outbound.protection.outlook.com [52.101.201.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCF93112A1;
	Mon, 26 Jan 2026 07:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413608; cv=fail; b=enl21nGnjr5f1TEqh1z8eH6PiQtq64n44zfWuU64/NEUd8xp2hFBZ2175I+m/8RW8Sp0m69WBFRbUsI3f0oHZRdLuEYA/MiyUVVOxKTmCV3xgn86YwoWVJKLT433xavKesuQxgiiAholGMSG8f6RIIGfPI4JJrMq8mONHN+YPyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413608; c=relaxed/simple;
	bh=R8VwcvV1uRMhLf8xceaQD21ZT489YHQl7iYc5hH6Plc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YwI9zFMCe4T4HwzNkI4vQkWN/uYc/kuUHXwVh5Xkc3xsqdlqjShVMttiaxxr4EQb95OWjOVZK+bYi3NnwmM+wxm+hK354NfW8fMc304xr7aJ2DiCw0cOSMwpyB7O5n6IMo3lxLnfkbXBeOglOpQyGB4I1Qt34xs/UMgj7kYp8Sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jwWa5TsE; arc=fail smtp.client-ip=52.101.201.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jwWa5TsE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+CgnjKqzWiDXyJUFyhlI43jAvFrbdmf7zFBbrMKCsFXC/31mUXfkT1si5o50+/nmN29exvcSuklehOguT2k9X+6ek1e1bBPfSz1f1r9akX7mszmejLxq5a3KGoluYpJQBrspBaM//ioyhvYZ4BSLDEstBad7Kvb3z+7ukN6OBZxPBur0dXFF4VKQvTVPpgbp+z7InAUjivB579zo8C5E93sfNXVjlQfZqFdGxk2tnXHUy3MFGnmruxpT7NtKghUNywzowkoCsEGjw1kw9M0W9Un5kuqyKdrrJdofRnXEmmxn0sT/RZVUPOPTbClGHBY+O5Xa5Bic7dut1zwfc9OwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6xUb0VxsP5fix6qv2uFNd8BfPyMWDezo+5W72vTddA=;
 b=Oe/ODWXgpYz2kXuYGR6YtWqHHj4AD/A6zJgLnL/pY94pYISULJFPXeJxgtUSM9ryM53YKNlRJB0HF8sN/u2i80cQS7LQQgjNqUHTxn/GrhugbKaTj2hwrvNA0qPDuxfyZu+vSvmlsI3cya2C4yVoiHWhFsCJUIM+ENJTGx4dRAZ0MXvbMPtjcPFUyKo6ocTKK8aNetsTbqrlj/8gVFDG7T2VOBhRUTHm5XAF3Sii9bU4dR4RK7FLov/5rLep3UvSJkjfQyjqG+HzbrRkvbpVtiyu8qvShJw8oCoXQ6chpd7au9srQDuJ2S9pp3Ya3Wcy91MFlJpTfM82gIUq44kW8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6xUb0VxsP5fix6qv2uFNd8BfPyMWDezo+5W72vTddA=;
 b=jwWa5TsEjr7lddV7Uw9/yb5xJ+PJQCUrF2LbMnDwJiw4dJ4MgbQvZwiqFFJhKa2o+IPrDzkClmyM5BSiG+cVkZNJ1IB+HUXvOUO0qCyAY2MZEwba1gNZcvKqZoAp3kDwZ6iZVniB1hFhCaV50OP1WEWSJKCOKoOP3OR84OBLtoBVP9Ipu2Iy/K2rLLwQISo7ILJ9RXv9DOkJJ1gtTcs+oX/NNnT9ZGICZiJo6BdeHuyEe/yrVOy3IAujdJTKtLPurIP8ilbkOHqGrtG4pp/84BosK7hCVVQGFejhU0yBWh9njVS+S+Fe8U3TBQHM9r0ZNlds2j5w9GWgLHjMK88M8Q==
Received: from SJ0PR03CA0239.namprd03.prod.outlook.com (2603:10b6:a03:39f::34)
 by MN2PR12MB4285.namprd12.prod.outlook.com (2603:10b6:208:1d7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 07:46:43 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:39f:cafe::30) by SJ0PR03CA0239.outlook.office365.com
 (2603:10b6:a03:39f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 07:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 07:46:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 23:46:31 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 25 Jan 2026 23:46:25 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [PATCH V4 07/22] PCI: tegra194: Calibrate P2U for endpoint mode
Date: Mon, 26 Jan 2026 13:15:04 +0530
Message-ID: <20260126074519.3426742-8-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260126074519.3426742-1-mmaddireddy@nvidia.com>
References: <20260126074519.3426742-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|MN2PR12MB4285:EE_
X-MS-Office365-Filtering-Correlation-Id: ce711033-8640-478d-472e-08de5caf0c6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RpJDvucJ+J/eUceZqRv7U8qoip71zfP7iPCKTM07BOEDROPfE9qsZPod7Ypb?=
 =?us-ascii?Q?Vt/JQRySU5TgeUF8PnmOdOORCXMsFokdx8uVhvH40xqsv3qGUqsScWb2tnd+?=
 =?us-ascii?Q?f1lCXcQKS1UJEAAuluKbLjYlhMBUE2Dfr66ByAjQ3eE54UzSC4xKqucCJ5hY?=
 =?us-ascii?Q?0z+DUufpM5oNa43WMj+elIFyzKwoFjxFHW8mpWaJBubPF5xlLH9ugzHE+czW?=
 =?us-ascii?Q?FQLmV77rGzcZTtq7nLiMhv2Hog6bdOy7vPLNihfn1QRtrnf8xbJPbA0W7cX9?=
 =?us-ascii?Q?pX+/8dX9tPH9y/T7FqotYeM2df9lny+zowrb2NPHtEDZ6fQTKRdZQUd5+82g?=
 =?us-ascii?Q?vAo63EUOgybdWbcrJvUvi53DocULPMpeHK8ao/0QH4z/dEQqfSHPDcs6RmcN?=
 =?us-ascii?Q?2SQBuoCUBqlZ1/du02Gr8UQoMQokV1u2blvRT4E37yPZn13FANgB3WWLYAOp?=
 =?us-ascii?Q?xZ4UnRvSpY4BLmSf9CdKgcksFM0IULFbSCF94cQyh2qRlUrbk/3hBU94jCNv?=
 =?us-ascii?Q?1veK/g7iLDtn/P7D3lAUBo9W2NaRfWELXjxp9Zy/EYo06pbcvWfXLDDDfIo4?=
 =?us-ascii?Q?igKa9Fm18NzLXLI1b5tc8K7W8E0xTBmIWNLs3vpDiVPBffU/gEM62a5ylFyO?=
 =?us-ascii?Q?197XpIdrDcht01MOePICnd792v2xGIxQMEYwtQ9VZoytE2ewQOQS1F5DeKz3?=
 =?us-ascii?Q?VLq5nBl+gRgxitz8RvvNAwcIg7h5S6m7dfxmhB8/KLrrygLKVw7Y7xxxMMeR?=
 =?us-ascii?Q?VzQlVnCftPh5+TQzfbqnNyrsDJNcb8Tp0BoaLFigHgyhdY4yi+cQulDJNkn4?=
 =?us-ascii?Q?WXVkRT+Em6GEY6oFHKxg6VSyfF6fLDE8lwEYTLfoMpoxxGgQOKnlWIvxRkGJ?=
 =?us-ascii?Q?+tOn2tjEXt90l9/Yw+VVK7xhI5v+DcfnzDA37eOx3YhME+KWh9YkPlsvZDsJ?=
 =?us-ascii?Q?cEHZlXedzRedGF9cSY59b8iDe08uqQg7y0P/wgEbO9yBG1bnwIhJWlP6Bzdk?=
 =?us-ascii?Q?x07QGtFuO03oGqIdl9xtE1i7BWhFZh4yys5S6pBvBQEmLcLoxXyLpyaDcfcc?=
 =?us-ascii?Q?XioSrdOml6dgGfO80PDddWYjkxYnN0EipLrIf8IWWDIHGci+wDg14MrfWYgI?=
 =?us-ascii?Q?ApSZ+ljRjviVnWAYRsWrw7iwMg4AbjgDbe0ELHH3QCt0VAzXcjP6DaAlt0Km?=
 =?us-ascii?Q?rwYV3Wcqqnufd1XENG1vTEiCvgy32ok85XoI2EwNc3H2Aqpv2PC0TF8JPpon?=
 =?us-ascii?Q?STUoES3yk5xXae7dSc6kdhKWsWiB5ciqjQLyR5s/+tNEvdbTlk5HIwT8ET4b?=
 =?us-ascii?Q?dQTVjKDQN43JykQZ28lpE3i0kEwl6+9Yyt25E0CeBK4NW/SQFazbCfJbUh2A?=
 =?us-ascii?Q?RYXEzVNfBu+RUNcvro2jGCYOiSe9Jx6fpu0RVd3EN0EleODmO8Uk+jog0C6M?=
 =?us-ascii?Q?OFhGAZd8JatiDnzG8FWQtDs3UaBMVXwvqGiEDNQJ689M60D1TdlzKdJmgHna?=
 =?us-ascii?Q?374UuigzMpRIIkNJpJTZ2xofeNxp46WT9qeVgqjEmmngFhm6YNZ3aeqsZg0g?=
 =?us-ascii?Q?Y/Q72iHf4/3b/bdRNe7XufH/c9snYyQ2R/2BFKnV7EM1rwaRNeFd76nW2RcV?=
 =?us-ascii?Q?NNEfswPMprMuymw+svIoCst/h1zEdKvHaJGcEr+KgXkk6+TM9YgtEfKW69xR?=
 =?us-ascii?Q?WZL8dDWDRzCjNB31uMfTGhv16OE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:46:43.0167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce711033-8640-478d-472e-08de5caf0c6b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4285

From: Vidya Sagar <vidyas@nvidia.com>

Calibrate P2U for endpoint controller to request UPHY PLL rate change to
Gen1 during initialization. This helps to reset stale PLL state from the
previous bad link state.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V4:
* None

V3:
* Reworded the commit message

V2:
* None

 drivers/pci/controller/dwc/pcie-tegra194.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 25f933a578ae..f69bc416b031 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1065,6 +1065,9 @@ static int tegra_pcie_enable_phy(struct tegra_pcie_dw *pcie)
 		ret = phy_power_on(pcie->phys[i]);
 		if (ret < 0)
 			goto phy_exit;
+
+		if (pcie->of_data->mode == DW_PCIE_EP_TYPE)
+			phy_calibrate(pcie->phys[i]);
 	}
 
 	return 0;
-- 
2.34.1

