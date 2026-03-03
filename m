Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010010.outbound.protection.outlook.com [52.101.201.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABC52BE057;
	Tue,  3 Mar 2026 07:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772522457; cv=fail; b=QIF92EcjUIrC7iKTK6alf53O4DO0FurhQT7r5UYsZ8POaDHn54XILjCjffIQ9P88f4gPFGttMvZNVFOW4ww8tT5pQ3+BnBNTVE5nBPSqoSuDy7+n1cfU6r7l1ZRtlQu2kG/2wi4FCJz/iXFeA7ar+o0JMGWoeKhLgw4BFxefyLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772522457; c=relaxed/simple;
	bh=P25dI1/gf4zpiSyYT1mpWHDnFfFKF1lN1dCb6P1Cepg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JBjdOMOnsjG+Oyi7d6QtKKf4KkxJ7TzJ4dehWce97SMl1OnjYjZc/KQC47sk9ynXkZ8lCNNzWHUZK1Q5VJaIU8O+/10Yzl8JBkiy8gkDhIYmqIL1W5gMCKo39VNERKASmmkoDhQaUwUBJRAxEsBjz+0e1EeQFJeXhHSF6kXmbt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZBggfm/N; arc=fail smtp.client-ip=52.101.201.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZBggfm/N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilDWKRoQFHaJNVeJJaA46duS+uNYZ4/9icR1mjK3LycKNG+/3gB7PccEXs2a77abKzba3PTgEAS++ggIH0N7AmQfjbOT9Y+5wlCEMo/QB3mg+aDhMaEX/qIKoIRoBFcSeDiH/oFSoLZq5kSbcJJwUcrQ0f3I7b4SPHXjkGnAi7shvdY7Aq8OgaDSoS979NCAoemX+NO8i/AdrkII8VI3vKo9+ei5Dxz8iRxMVE3VPk+GSR2MZcpfauuMCHnQJMLu04XjorogwqHzwu4w0864mQaFwuGxcksdyLDJT3sH41l2/gwLv/RTjFjHPSFwATeQFlb76phPUx0maOS9tPAfeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhv7wB0vzv5PIwvuY8i5AS3DYf6y3f0uBp9+oR8YvnI=;
 b=CDs/zWUFLc11tz5qh3LS9PwOpYm3yzaU5dkfDYvCC23ffSl/abCEL9Do401ag0QYyn1g/uUmXcnJuGYYFdhkteZgQPNcl/CydtxUFAztxOVCR359D5qWUvneuPx5DBEsTKL8XDrR0NHBxH29HAZqn7vnAd6BSWfoa7TfmTe+L+AkVUL4fGsVVUOB8HcMOtHHGPqKU/OSBe1ILuFqWev0HAf7GdvByK1DiM1JJcWmIN7CSSOjpAJfV5G2jIDFgRYGpztAL04If1ZSP4gZaADK8yj4CGAIw/rpv7ukmA348hoDGpSe5Ryob4CQova50sc3rz+nd9GRl54bFL++8EB5ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhv7wB0vzv5PIwvuY8i5AS3DYf6y3f0uBp9+oR8YvnI=;
 b=ZBggfm/NdF5nrLoMENH/wquz3zCEyGfJ+OEflHxhFwFHIb4HsTJfaWYJRUOuD5z/BwWVCYEALvZJ8wJcuZcREIa7ipNUrxeMrU4L+JIOOQYowoLIsVYomw9khzCDOSygMdayvdc9JN+8SWDOPVgJdzIcavAdAWMfRUI+ZdbaD408EfBx3l7NTuy2yrzr2ACbe8ONWL7y/rJ/XPt4AZ+nvzbel6dxoCotpTQ6UZI/LxEt2vpys/jGxM6pZQ0cu7/KG2Wm1gQ1uwWpMduO6Unsmydg56omEZB3XeD60Y6F3PXIJhVrADmhiEn6HlSTqdNt4YEX5aqfGLxMKofZxAAC8w==
Received: from DS7PR05CA0049.namprd05.prod.outlook.com (2603:10b6:8:2f::27) by
 CH3PR12MB8404.namprd12.prod.outlook.com (2603:10b6:610:12d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 07:20:49 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::5) by DS7PR05CA0049.outlook.office365.com
 (2603:10b6:8:2f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Tue,
 3 Mar 2026 07:20:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 07:20:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 23:20:35 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Mar 2026 23:20:29 -0800
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
Subject: [PATCH v2 1/5] PCI: endpoint: Add reserved region type for MSI-X Table and PBA
Date: Tue, 3 Mar 2026 12:50:00 +0530
Message-ID: <20260303072004.2384079-2-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303072004.2384079-1-mmaddireddy@nvidia.com>
References: <20260303072004.2384079-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|CH3PR12MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b3fcf91-f310-4b11-c979-08de78f56572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	eAUUq6OTsjGQ4+912Ncv7Q8BGAY3OqUpXsd5FtNO3y+2FUF9OVkLD36qhhLB/ouUlUuNqgmNZPSJr8VTIQ3nyS63Q6rw/MhJvBATCjdbKOUNUIWLayvGTXcIvF++a5Ml3BtM79F0YD8u2roOOh+6vkycfQoHOLkl2HyBRTbgqccQSGz9bGmm0znNddlImHMf57MrALVn/5zFhr5PnqLLvubPzh0H8k+QlUdzAXJoUtu3OWxxEtO/K+bwF473VcmeXY1pS9vcDV966ZdH2e0tSNkei1uZJ6lxrAq2zLfoxSwpomZEshdx8TDcZFCZMloU+1And0rJ90SrXxUCXryHES+9HUmMDoPXUJNTkE1AxtLaYXlKHaHfMeBo19yweqtdvzwMU96MMHFfILelKHAlIpwR3AwxONkZ6MpFx1cqariJciilWrrDFpu9imzlWFZX89cQRtE+7A6pxfO8npk3xNX9h7No2WdfEXZETUo8kKxN0kUIZat+ZFS4MKbt30Ufp7kYBcWE6dsYV3SgIdIOTuV0PuOgWbm0LThU/mZTobBChB5KAeeGflej86SUS7/UuHhfOp1gtpKBxD3tbDB69YeHRDvUM6H6Jd/SyLxl3noSFBVOVD+i758an3BIhh0SLI/83cj1p1Pt9txv3E15JKFTje/eY3UrOi6T4uUu1d+d5iljR0eWw0Lm9W3hi19T6tapO6aUS7gsqv/BauxlV6x7288QBR3YpGuidLHsQH51x9LN0Hrh5+aN28zfGS1Pz1s82zPoyakY4SphEO4mHdL2CMXkIMAK5LHKpxLz2D5z2VMNlptu1ovGLHn9mhFeKgIZHkVOWgrVTQcTHe9wylbbFr2ZE+NYbKt/XTTtXyk=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ggp3HlUT133T8l7uDn3A5xp3AHZNGfZfcquqvWYrGwq5yCEeZt5Kdf8NGKMHf7alFGP0QUKu3CFoSewtU+GSlVtqcFoXFBJ6AmFso2dSIM7MYDih2LKWXBFPlErOgpv5R6CvI0Gy7Oy0ymOGs4eVJZ69uMKXJfBCrYprJgD1amqaVMhUapYJB1OWzre4AcynbBhH4dgZl5Rch3QA7zVjuDGCA5Iug/tGrsN1IYzw4JrC86JLRhM9ooqML/JPp1Ag+fygHbwKGaGWzyZVwL2wILuspEjtmND/en4wHq/JPEuiLpYndGmwmZmOMEhGwlYmm5waDsh7ELVOhRji1SW/YlQOnfSJ+ygnZc+3K4fouRmW0xMUK7bnRukfK04Su/oTJRnItk4sbWajMO3O34fcffYqyAjFc6G6cF6dj8Z1Igwo0GyHTs1oiNcuYMl6tEr2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 07:20:49.5987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3fcf91-f310-4b11-c979-08de78f56572
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8404

Add PCI_EPC_BAR_RSVD_MSIX_TBL_RAM and PCI_EPC_BAR_RSVD_MSIX_PBA_RAM to
enum pci_epc_bar_rsvd_region_type so that Endpoint controllers can
describe hardware-owned MSI-X Table and PBA (Pending Bit Array) regions
behind a BAR_RESERVED BAR.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
v2: Split MSI-X pci_epc_bar_rsvd_region_type for both MSI-X table and PBA

 include/linux/pci-epc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index c181c6d107b7..fb3f34829d2b 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -214,6 +214,8 @@ enum pci_epc_bar_type {
 /**
  * enum pci_epc_bar_rsvd_region_type - type of a fixed subregion behind a BAR
  * @PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO: Integrated DMA controller MMIO window
+ * @PCI_EPC_BAR_RSVD_MSIX_TBL_RAM: MSI-X table structure
+ * @PCI_EPC_BAR_RSVD_MSIX_PBA_RAM: MSI-X PBA structures
  *
  * BARs marked BAR_RESERVED are owned by the SoC/EPC hardware and must not be
  * reprogrammed by EPF drivers. Some of them still expose fixed subregions that
@@ -221,6 +223,8 @@ enum pci_epc_bar_type {
  */
 enum pci_epc_bar_rsvd_region_type {
 	PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO = 0,
+	PCI_EPC_BAR_RSVD_MSIX_TBL_RAM,
+	PCI_EPC_BAR_RSVD_MSIX_PBA_RAM,
 };
 
 /**
-- 
2.34.1

