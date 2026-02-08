Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012049.outbound.protection.outlook.com [40.107.200.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ADE284665;
	Sun,  8 Feb 2026 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770574234; cv=fail; b=WiiNw22yA1XE4q/rgBS3o8wYbEgx4Cn2L2g3H7HY+lZ6yXgKWpVDrRJmhDz7RSpHSdxbg2SSDPdBxswsGotxiTFb2yZfZLxmnFr9nchN26mX56CFVwP2NkkpZQroxGShZjmRHKN1lL2iWzwpV6cH+0B2Si6dFFhZUtV7nq+Y5r0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770574234; c=relaxed/simple;
	bh=cAkhdKWnSqIaMnd5NMAf39c41O4QFhzzj8R6ANaC+34=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bz4QbEya9NWE6JhcClDofZd22zBwo3S6U3G2y1SMvFzgiiuuKOco/6Ma5md7VNaZBbVe5BK9V5XS6PUXmtd7d7B7NHlVdIy2IkVmHPPV7IOO7tmfwZFKlhdwkjDwDAptuAHb4c/53L+I3QfiRNbZJQZQqcekUMMJJ/wukkflx1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U2sQd/80; arc=fail smtp.client-ip=40.107.200.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U2sQd/80"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDsCqssSbx11/mB9KmaNG685pZt/dgiC6AiB7JXmIBOndUK+4NInpKxulTmLPxb+MRgCPqFGqQH1ZT9bN0OqtWVa9aKyUW0JQj+SoZMsvZylzDLtt54OmEmtZs74utv3ZdtJWh+bq9ypJz569I3e1Dwun5G+ZbQLSXC7Gr0rSZpr+pTSZAg36tcsdQVf0p6AGbZcawYxycDhrmE1E8J2+4SViJndbu8F0n2TIOKTcYt14Pg4v7wZDIWWeWYLv6eeeBNBrAjW38Hk9y1stvgxsMbHkTw3+FVxi8UynPA8jnzCOok+WNrYT/ssN8cHIEMBscMOVR+XsvQ/A3G1uVdhIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RS0tvmupnvsxS9wk1rqy1rZoO6+nJNl5ghsM/OUx3ls=;
 b=NoauJ0E4ZxkE+CD4+YjTZcPgx/f90rH1YT/911vJxqhoggCe1kFTuHJeS57qBugNWuLK3QCF7IbOggj4VwIzds+pjYfJwfW/58BAiTGYdv7dT80ZtLLDPShekqeYC4WJLdecml911MmzmK8wvPUOxmAuEt9H0c936ObSSx5TDDsjuQi3hZOVyG24fjd7ZgeFep+MiG9G8iphDUopAN8NhKPrKDsoeOXHA01iLuWDRCrv5sfOlwQnHpPWmXQy00mXGGwEUfF5HRCbQJncH7PZNeNG0nwOnhMfSVEl58Rqogqvw5P42FTIJWrQ/O+sEzebyA3pfpwRqMOLeU0bvGYN+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RS0tvmupnvsxS9wk1rqy1rZoO6+nJNl5ghsM/OUx3ls=;
 b=U2sQd/80Z8+Wj1g+qkLhoUxj8RC4Xb2XsC92UBK6mV3rNnyp5r0e1UcCqChLNlNy5F1UH6URdODJmpKMNSWBdBptLD+ebvep/YTBvgzWBaZmBoQmjBQyY4GRZyCT9Vf790A9q11m9q4fxr041Nl/IycLDvwpsBwC2wxMcsMMHzTSbR8TbPJzvqY8nmejDzlJ26yh5hKGpsIwET/LgkgMwVDnAOEvxH28beq3dF8uqJ6HwHsnv5TdlQzEk2KSZserATaxVmyqt0N3FdKAnWmWeXtCZM0Md5dQv3nVOyaLI0DTo6m/vG6iOG6FLD6cUKXWyoy/Ftvixu6MvvawzQ2hcQ==
Received: from BY5PR20CA0013.namprd20.prod.outlook.com (2603:10b6:a03:1f4::26)
 by DS7PR12MB5839.namprd12.prod.outlook.com (2603:10b6:8:7a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 18:10:29 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::b4) by BY5PR20CA0013.outlook.office365.com
 (2603:10b6:a03:1f4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Sun,
 8 Feb 2026 18:10:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 8 Feb 2026 18:10:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Feb
 2026 10:10:08 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 8 Feb 2026 10:10:02 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [V5,2/9] PCI: tegra194: Calibrate P2U for endpoint mode
Date: Sun, 8 Feb 2026 23:39:29 +0530
Message-ID: <20260208180936.2026329-3-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260208180936.2026329-1-mmaddireddy@nvidia.com>
References: <20260208180936.2026329-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|DS7PR12MB5839:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f7b642f-db47-40e9-bbad-08de673d5776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kxt2vlXvgGSvCKaBng72GwaQhMjgedOIsSr7SLHbfhednkFoZqjyNC6D38qx?=
 =?us-ascii?Q?96IWxO8Y+Iy4W4dXh9flPjaKyixkHft4dA3Cp12k/3u7bQakTFNDtHaLuMHs?=
 =?us-ascii?Q?xID3hBgvOhR9UD5hblhYKL5JPc3Osl+mLwD9gI9BbekToKsX6WjaKcsIDQsi?=
 =?us-ascii?Q?/CvwPIaS4VxFao2yKVYK2KuPlOjaeQPEIMh0J6nZB3TNCAgiz5l5U0+rcnlS?=
 =?us-ascii?Q?NSDWGxGvj0yD9jTlTbhttQ0uE/lEhL/ATY3choHxzh3Uw9Unoy3smPmytxOh?=
 =?us-ascii?Q?YJdi00sIh80INbvO1kSxnvW4H+RFDq3ZB9X2vdBj6EqAIkzTbybfCUcQ/PYf?=
 =?us-ascii?Q?t++fWbpUBBY7Hyx3ji1J0GdtqhhhmNlvw4O6QVYadPpCdWPMuBK5Rr+vgtAJ?=
 =?us-ascii?Q?dkvn59iiiOxEXQjI9Ld8XRfrbO+gXiFepOrQ4GktUZA7xkAoVXFlfncZeeha?=
 =?us-ascii?Q?AOn7Gg8ovU2ChOME97McEdDDi8oibsaxxUWt+cG+bRY7LGgRNarSmnLLffDd?=
 =?us-ascii?Q?8hmZsy5QEwvcqFkRwJhNe7lYk80txLwx+wLcpqKoCwozY7KS7IManLcN+xWj?=
 =?us-ascii?Q?4sjOhUOQSSEn8zJtu9CExo3Bhhc2Vdz2vivcRNYnI0QJoWWy1YrmenRjh59a?=
 =?us-ascii?Q?OJf0APibvj1kwFT6h7RQPNdcImm3ifUTFkUyCGlyy1EW7gXCIjNBhHkEjL2c?=
 =?us-ascii?Q?z39InkjE+TxKJDdmtOrnZCVXxqpgaYJEFRbtiAzxPDP2iLg5Eccx/LiXtxjz?=
 =?us-ascii?Q?iSAGGbVTGwQcrp3pZQzzA5EQ6wfNFiOxb88blg4zJUIzEAKMwfdr0g2c0Szl?=
 =?us-ascii?Q?jtWmVRFKzvk3teoJeNYgU1uYffFe1h5nTjPcvAPV3XcbFB6QCFyaAl/IPZ1X?=
 =?us-ascii?Q?GghJ1mCQ3pR2D5fpOy4WraTU4rEJudkYEgWCqNZKzel7fx702xu+6L9YNX2x?=
 =?us-ascii?Q?wSkYyqxIgtJKOVuvKlWn0wzkWM2XBEi3kjsYiCgeVX9B6CiA8tbTqRS1AZpj?=
 =?us-ascii?Q?sGjFwKZY6IRhPs3eXKmU6P+h2cexKygIj3GcuZHau3BuoutZmGqeqFhGq1PS?=
 =?us-ascii?Q?sYAiSDrf+uj7yOZ2cmsPHB5xq9hc/D586hFIinHm80MrnWhFwVtBWNpXyn5k?=
 =?us-ascii?Q?+oguaZWI/6tlX4IWcZMnSsWZRgfurFCP63pCNYXqImARLImmmdMRI9GsP0v3?=
 =?us-ascii?Q?ed+U19KGqYoCHrOtdaJPBxB5tJRALTlij5lA5GhrusJ3Cf8WnqSKmLenpdpD?=
 =?us-ascii?Q?9Yh7Bx6Zc/4tatgf0zDiJdzpKlb8EBPzUN4OlnDfCo+tK0rPHzaP+qonp63c?=
 =?us-ascii?Q?GX2BYunuL6ARbtyEGh0r/vJlw2OQNgsTQG/IX6gFn8nWYONVmFmBwBc2ny7C?=
 =?us-ascii?Q?Lkdx+PHP2kCykkfV6QOwTEEAdDf+A+9pdJVdzkkJljVS5ghcCV1a43g6EtsK?=
 =?us-ascii?Q?796bqMVZrvwZR/9FA2DD7yGWpnKRxpGTm0ROz7KPe6Lf3wP097/YQJUwZ1Lb?=
 =?us-ascii?Q?xBlf2CBd/1Hhg1yTbmFUtwSD94Q+m+cE1tWGmmY0D/ZV2vkh7SKJXmupaAAI?=
 =?us-ascii?Q?t564bFf+swtWixkj/IWXA8zo8RkFQAoou3nCw+fL5ixuFgrEXBWc5uN8QObj?=
 =?us-ascii?Q?cdELHr64NN383+WdzpCKHFQ2Gbq8OiTANNHLZnmPbLdg77Qo5yHmjWguG9Lu?=
 =?us-ascii?Q?KAPiFyEDqt6XxMySZRDU6S9ox4Y=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aXw5wcSCGSC9Dn5nSlrNK8JGTDrNvvMns/kA3Fe5otoYERP7gd+MLJNoKtXyO37t14XxlAHEdqxZ4n+HsowYoPMeJQnEZRXf8fJihHLNO/OjriI4pJ1XAJDF7E6n2/RSdv+QNYF1qz+iVRUL8/J4pIFHDp2j+l4/wxSNthrXiZPS9EbomzUZM/YA5BRkYUYgwZhkWXcU0KNqk5QJdp3xHJ9aZ011elzOsUt021RT1f+whLqIT2Fs2KZj+OmTh1aryed6xTovqRx0LVIEgQ8iGWq6NYH92QhMUpiDFptMWfOUko3bZdLVvQ1Fr5VVUjsmXMPfFUmBNuxZU6QwpcRrXoXg9/9dlRlv98UDnnZVt4cFnlZfnQaFjheOIsIY2qPlXSpI4STXEwXcFbV5I7JoHiCpRWoIlFTVcQP/0YQJH3AhMy2Uf076xwtPYeIJojB3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 18:10:28.9812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7b642f-db47-40e9-bbad-08de673d5776
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5839

From: Vidya Sagar <vidyas@nvidia.com>

Calibrate P2U for endpoint controller to request UPHY PLL rate change to
Gen1 during initialization. This helps to reset stale PLL state from the
previous bad link state.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V5:
* None

V4:
* None

V3:
* None

V2:
* None

 drivers/pci/controller/dwc/pcie-tegra194.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index f026af7c2ce0..51bad99cec31 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1058,6 +1058,9 @@ static int tegra_pcie_enable_phy(struct tegra_pcie_dw *pcie)
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

