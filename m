Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010016.outbound.protection.outlook.com [52.101.46.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AC13587A2;
	Sun, 22 Feb 2026 19:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771788949; cv=fail; b=AQsNV8sDbXtRbWpR4BhSi3HNO86eX4HSHaKjYtjkSAIKoY5Zjthy0GlQ/FmLCw8/O6akqjjB3VqvOs8GVZ76+X5A6+aWYHh9VkLLXcA1Ebb/O6Rys/zcCOEGxSTa8MXWm1YvKlVz/PSMAui6VsTbxucZsHMg1PxMQDRLT6uotSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771788949; c=relaxed/simple;
	bh=2Y8X22HXjKwNpHORzZkGTcgSj+btBsgskj30qnBr1ro=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZETAUZmZytxs1LQKPoGlnNYr5M8AioFPxIhgv3PkWwHJt9khq/CjLgkhuGItrH4vrag7VEkXRfYR7Co3xBnatGDfea8hjTMAYghyVMKpx+xICtb43VCsCg4e+VZgojoco4c1TIdNNlNVAwlAAWkipIZqJXp/QByt//nR48oaANo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nllVJd6F; arc=fail smtp.client-ip=52.101.46.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nllVJd6F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLFWqCJpgP8UOIX5KcaEam/M24EP1xJnyI+kJu8rXpJkOCq/YLwMGtQN3j+tiM+g6C1r824DM2PXlj/zW3MRZ4cRsTc8y46n4o4vZJW3VU5aPYDlg76FJDTr8PqWKo/b3oFc3L1G84g+hIwyDkrr2Ws3KHj/f+d+l0rywKtL2kHAvO3O86fBN7IPlqH5hZyTsCQSEtRgwdmqsk0YDDqTDF8KgQ9TFusOJ0ajono8QShfR4gqg4mEYP3rAV2KHKUfSm9qkQ/XvO8NSD+yVP6M2a++bsJLq+ipI+UVtLMWCNwvfPTt+OYeiolL5Y0gKdrzCeoC38CHCqli1n6OA8sdcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/nlMuJMbG1JRKYtUm+lG06xRDxdKzyAPKtv8VT2vlU=;
 b=YmAdK7KLYwb+JHf+qs+VcEOFVgvRuivVw+g8R9ZucqGsS0FLBRzBwBcTxqLxGzm0QsSwb81ju6IZ7tSb5rkdWUK57Y5FBZ26y3KznsSRx4LE1vzLsbYu7WIaLrILoSqy23ZpJ+a6rXoYgsXjNU75z3cH3yiF7SJxuR7RYnTUS+SRyZdjPa8NHXu5SlabPxpJiZDero/rowlZS6meZg/fSTJN9jctpuqq/krIQctQGJgyHir60ehlniMqT1mmlg2+JzKzLLNn3KKqyT6BqH3dtMbmmMChUnwWRyN5TLy14S1U3+5J8Nmxg/f2xt/E1BLqEA3XnQPMDW85tHm/TgZ4ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/nlMuJMbG1JRKYtUm+lG06xRDxdKzyAPKtv8VT2vlU=;
 b=nllVJd6FgSsZDo+OaGMbG4pHCFBufjnkMCXujtUvHHKLS1BYVLci5CwKGFld1K2RJGBQYEv8OX1aBNQsLDGa8SZVrQCxy0Zc/geGEOQYNP5yV9Kp03Nli43cEwyK9k4+Hd7wBft6eYsiz5nOcmo+LXgrY/TTOFmh9GST3gf2fcJC8FBS+M29pW+DPK8qfkWRE76ynWqN4wMbBmL9XOSc0iXYfKrWlyhGOUDdJ1uid2JI41QGBwHJlFGDGsHz2+B3a6VfR8hnz8ibAWwEoS6ZxCQsq5Jmd0GeyeptzMBF29R5oBDkX7n7BurIjVCCXbOmShCXQy4n05Ukph14NLWqRw==
Received: from SN6PR2101CA0006.namprd21.prod.outlook.com
 (2603:10b6:805:106::16) by DS7PR12MB5791.namprd12.prod.outlook.com
 (2603:10b6:8:76::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Sun, 22 Feb
 2026 19:35:42 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:805:106:cafe::e6) by SN6PR2101CA0006.outlook.office365.com
 (2603:10b6:805:106::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.10 via Frontend Transport; Sun,
 22 Feb 2026 19:35:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Sun, 22 Feb 2026 19:35:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 22 Feb
 2026 11:35:31 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 22 Feb 2026 11:35:25 -0800
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
Subject: [PATCH 1/4] PCI: endpoint: Add reserved region type for MSI-X Table and PBA
Date: Mon, 23 Feb 2026 01:04:53 +0530
Message-ID: <20260222193456.2460963-2-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260222193456.2460963-1-mmaddireddy@nvidia.com>
References: <20260222193456.2460963-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|DS7PR12MB5791:EE_
X-MS-Office365-Filtering-Correlation-Id: 347c2afc-c67c-4d25-38fc-08de724990b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ix/i9jzLAkx5lVDBdWeKGvt5oGU29IfiGXdranP+hh3jH6YFRPueb81mCRVe?=
 =?us-ascii?Q?4J7NqU1UUK3XYOzI4UUwx6qJc9Oe4htq+7p5hjGSaRpfcfWb0kLH0OiEhNTD?=
 =?us-ascii?Q?84MiNfsAq+JxXbUFL6UVTMWMfI+gr+jQ2B+2cMhA4i6fG0NAFDWJoQbsOAVB?=
 =?us-ascii?Q?CVub6Mb0dysXxxlUTRhQ5GrJRc4YZhV2+5vq5b7JPDd+OjmJgYrzhVsh4wFW?=
 =?us-ascii?Q?KoWerCAd9yANAlZbd/glFx1x7AxPEocjPLJT+pWMqQ7nCf9PpvA8qQOil5W4?=
 =?us-ascii?Q?B2cESzyApsMH8DsuM4+AlRvRaK3GtZzcTelU+Smr3ErfyT1vLyXW/2EzwFWY?=
 =?us-ascii?Q?OIRtiKE35TolaMnRMMBE2sC7JgDStLMAJt/3vDhcNTfPnATEAxYvWpuLIQSM?=
 =?us-ascii?Q?0UVPHupMRnh1rGs5fMjbY6axqNb4n9U/pHxUJ7KIRaGKQAJj67TPUmLkFJz0?=
 =?us-ascii?Q?5C6gpziRmsC5SwckTbFqMYs3FGhcDQRlAKo4U8SnOO5/wZq8h0t99O9bbZGv?=
 =?us-ascii?Q?nILRtuXY/tY7ExyPT3x/Nsy7zQDFTuJgT0tue6WNCsTCfPRLd0MMFnld2sWT?=
 =?us-ascii?Q?mfqPp5hF7TK3y6F+7o3flpAAY3Y1S6ROCOXUqxGmIbF52dnGR5W5N9mNvqmR?=
 =?us-ascii?Q?AfEruLwPYaOd6uEifsOv92Mql2MDkV4b6i4euYh07lAsjdgTxYGKJCx+bG23?=
 =?us-ascii?Q?lyr3pi0CVcFfIFa8om7SFLOdH0d03OaYeQSVS9P4tUQ20YxpXYOgZENCFH6O?=
 =?us-ascii?Q?NeamVNGTnx3OgCZ4IB3oyQbADtLLAMQAjIS3vFPcGpVZHmuSmh5ISVARnQpA?=
 =?us-ascii?Q?j/lNPNbO5LLj4gaoQULLo6lZUFHz3hRgHrJ7/TyS0vomwBz6jQ+1vQVuUFHI?=
 =?us-ascii?Q?HN8XISwjryMOuRlsD/8ltSWrXk1yr0kDfuOPQGelNvKJfP8sIGIePkfreh3A?=
 =?us-ascii?Q?O/95iu2Q9kTmHIzh1ZQXBxs/joIr57Yat1bdqlNMO6tqW3qoOzK89mT0RjIn?=
 =?us-ascii?Q?qz+Idu6hqWbV5lOVFj4B4LdZxf/x25/cAy8FygeRDwPcKFGZs8wrj9LIEj/A?=
 =?us-ascii?Q?MbS6Wd6OdQ0uSoOF+XpBLxvYd+mqVHphtkILRph9rvAfjbKE87U28jsSvCIN?=
 =?us-ascii?Q?F/s3I8L831z237w3pmhT8JLg4uIXaz0Jnhib9lxkCbnPAYSYSyl35CvxT9H8?=
 =?us-ascii?Q?5zCnzV02x0aNdrs4fE7vPwmqGlIJHrDVKNsRWiv6Mc3lWiNT6WWgqRCaZyu+?=
 =?us-ascii?Q?PeMWkVeev1icKSdgh7Vo8b59hf7FsBPwBhRXHYhcYIZ5Kp77x5DbqcNptskc?=
 =?us-ascii?Q?39bM8kEJpKeTtNw2DajwHsKraWiP1J4R6JyDEsswLviA8+FOfmd5CVkuFYSA?=
 =?us-ascii?Q?QUi6z53fkXQIbH7pnafVGy8j0HLxmGzlazlxYHZIr3LpsgGPYpsgLhIAA0LY?=
 =?us-ascii?Q?xiHqRf3hVsmaG31mN9gCf5dt5C71JG5wwFA3iUR6/X9VA5pfwccQeoq/kzh4?=
 =?us-ascii?Q?MJ+CeIM9HAN01xB5juF5P7ylO2s9mJFPOjgYWGAnBT5mw2EwNuKwbeF5JQPa?=
 =?us-ascii?Q?4NdsnSKwsmDm0C9VQFTP3OdxR8midEmVbi9xgQV4MMttclbszF6tQG2yQ8m3?=
 =?us-ascii?Q?5811b4fsJoYGGJ3u6OQ+Wv0Sr6wgcoKfFj1clxIcC+IEPsJwCZCH+QnPwlG5?=
 =?us-ascii?Q?s0u8FIAm01FyN2p2SJ3TbnxxwFk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fG5K9f2yGGFfQU0ZbL3HjuKLtgi0Q2DcEKVwZUbsZHbrNw8qvWoXWsi2Wn4cbgd7OWcl3t/YAX5Wk5Zwc0giarMiPRwl7jwd1krYii93Vadj9J80Mpqyog9qX4lO8xDHVCSm061piKDhzFuD225bam3kbsrgtBXFyK2kxGqQb3Txv7gnFAVWx3NyZes90b1WcS3QpsMIpKRveHvfZ2bgUAFTu/vjIKDgJYIr11kjku3/UswZSb2C6GHcI0osLeKK89oEnjDlciMH/V6yPmO1gXP2eLoQMrZ7o6zwtd0wnB9OkEmucug1IYfL+ru03yCE2K/dADsEQ3wVsxRgPifUb0K3OjjjXlUdFFzt9vPFgs7eaDk7YwOFnopB1zy8RBQUzTso0poDgCDN3ZD21KSGFOGuIwk+qRdUzKDu95or+9vYZolOA+RIuI2NjemS+sz+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2026 19:35:41.7775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 347c2afc-c67c-4d25-38fc-08de724990b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5791

Add PCI_EPC_BAR_RSVD_MSIX_CTRL_MMIO to enum pci_epc_bar_rsvd_region_type
so that endpoint controllers can describe hardware-owned MSI-X Table and
PBA (Pending Bit Array) regions behind a BAR_RESERVED BAR.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 include/linux/pci-epc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index c181c6d107b7..89ab7d07c5d6 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -214,6 +214,7 @@ enum pci_epc_bar_type {
 /**
  * enum pci_epc_bar_rsvd_region_type - type of a fixed subregion behind a BAR
  * @PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO: Integrated DMA controller MMIO window
+ * @PCI_EPC_BAR_RSVD_MSIX_CTRL_RAM: MSI-X table and PBA structures
  *
  * BARs marked BAR_RESERVED are owned by the SoC/EPC hardware and must not be
  * reprogrammed by EPF drivers. Some of them still expose fixed subregions that
@@ -221,6 +222,7 @@ enum pci_epc_bar_type {
  */
 enum pci_epc_bar_rsvd_region_type {
 	PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO = 0,
+	PCI_EPC_BAR_RSVD_MSIX_CTRL_RAM,
 };
 
 /**
-- 
2.34.1

