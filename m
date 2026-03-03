Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010048.outbound.protection.outlook.com [52.101.193.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638B538D;
	Tue,  3 Mar 2026 07:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772522492; cv=fail; b=MxxpVxBmACqMsztE0RngkhPQzMgpUU2PblgLIGPdCpm8xR9yrgzAtomsqr65nUbmeBkP5iURDzpoYq4h799/+D8ESG514InqEZKFlYmQq7n9bbHGxSLXrPbJgQvL2UVVYJNxmYEfGjfQQ9wQkBLReXab+ythZymhVj17CnPwg/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772522492; c=relaxed/simple;
	bh=e0iF9QPv+/oXLgxOgiSybCGLyMZp6kXRh3FTl23QvEI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iqg6teys5fqmzJjl4f3wwq7ExwTPd2qUVIXy+ANQwO7EJJxE2ZjkEU/OcTcEE7WOhRcTtHuPekLxNq8XS568GIAoNrL2x0991d+23qCcPmeo9CjAlO4+SX9RijL/MngHR8diNPElx1YYDgVz9Bwpe2GuWmoKxXd2DZxjSgjmL9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SizX0JJE; arc=fail smtp.client-ip=52.101.193.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SizX0JJE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KeeO/WwKhXtPNytnpM8lf5HR1lWr8ZKv+E06rGQpqtzYks8IlEY42m9TaqQy8TZJ+ZCaahuggZKhnwlMz6yomKY/cPx3hqHkS93po/61Mytzfidx6KyzxFOpsIh1WkzvayuOQzVYEwh2zpvMG4n1H2p3eGQjCHESgsFVS+uC43N8/4220dN9l/R+ptDiHbSMMW+pxiqtAEw1z+6vv5L7yfvBUE8+2HQUVpuEH/oPQlnMOH75CA66V+2x7F95sudDODBUFKDaOmarqQHnLKfuSXRL3KwvEdGahDbSm4Fe9ApySjg5WUJ2dRFCtpxmeil5GAGs6wsAA1TX2t9rVm1lnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxCG7eeP59k0zTl3uY38r8OvTxad1M2PmlpmOOScxmc=;
 b=rGDSqc1YopFE04LlP4gtS8oXNfjz83JWseWqXWwwmIQ40ZLOYLHXtTAnpL+XhN+ppgOne4oIAGTDT7xlMq9hsB+VjwDyT4WtNRZFWWgsShEq+KM5bkvhFd9PBDaVU0a2/qkZboMmsd/8yHOnnhWNcsIl5IzIFNTkeWTEj6gMSSYiFb2A2nwhc5Yo2rVFVB7+wX5fSybPhApB6evBzeAY9aH5L3jZvhsLhTY1AsEeSuaeK5JNJl9MUWK6BdDZduXwLXyEibyieZ1ltaqKApFdK2zwWWY/fk3JSyzkytD/XGdW4IzuRSc5f87JSI8EfeG2mKDq2uJa8f7sfA0Vmhp6tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxCG7eeP59k0zTl3uY38r8OvTxad1M2PmlpmOOScxmc=;
 b=SizX0JJEJQQpypO59yrKnLFSeeye7D1qDfgQx5kk6NnHbsnr9jJVYWLI/RdKfG4UE6oB/tw3zfgROSj1cV9bVXO78IjCVgMRcV9aTQ3ViuTJ1IFkWFyJbXerKsp+Xt1/YdUPKPwuhFZgsGLYQOeIqrhF2QPxKCDhEArHNbvXiRoVL64LjfH90BEWGWqmczNp5ItWFJ62J34tWuDDxBlHfVBSH4RT8ncTpSoKd0WHRuAj3G52knjbzoHabraSApkI9TbJRTRm5YdC+UP0su9nf9jf/aYrMcX07VNXxbYVQ9zVm+HrEtn7ACJM//bGfOo8ib+gfo2SIynNiC2v2VZbyA==
Received: from SJ0PR13CA0064.namprd13.prod.outlook.com (2603:10b6:a03:2c4::9)
 by DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Tue, 3 Mar
 2026 07:21:24 +0000
Received: from MWH0EPF000C6194.namprd02.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::d5) by SJ0PR13CA0064.outlook.office365.com
 (2603:10b6:a03:2c4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.18 via Frontend Transport; Tue,
 3 Mar 2026 07:21:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000C6194.mail.protection.outlook.com (10.167.249.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 07:21:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 23:21:01 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Mar 2026 23:20:55 -0800
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
Subject: [PATCH v2 5/5] misc: pci_endpoint_test: Add Tegra194 and Tegra234 device table entries
Date: Tue, 3 Mar 2026 12:50:04 +0530
Message-ID: <20260303072004.2384079-6-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6194:EE_|DS7PR12MB5766:EE_
X-MS-Office365-Filtering-Correlation-Id: 20b29da9-b4ee-448b-d7f9-08de78f579a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	VInV+yBZ+YPjSzHXeum852VYdxCA6NxXvAJzy+l6Xha9wNAVXJFovHDHecMBrOXIt2O+SG7VZ5v/4c1QwGfOYykux6uDmly5zNTca2tJVfdk1UFC+omN2W3pgjtLg13co4XcEUu7/5XpijaujfwR0FTTKyyJwHJ36O5Nwhz2D+uzIIa4ZDDgBT5fN44U1eX3g7eNgYK1+2zFI+DZJD/Apg011fwOT4j7GSeFqXdSWkAuO9IlLyk4gh9u2YiwTMRwa6ARJWIMuqkFkcWMVS5AsSvmKBDLfryuxe0Ky3hpe76H4BKhg9fxSEenlLmqUxHlAyRaDKx7TxlpTG+Rb41tJ5Oo+aH5B7VUFx+w/HPHxzsnD6XWBmdiqevDLCXqnIuidUts/lyTvudlqhJ7VuM8pi7wFFOizl2hd/m5rWZ4r6QGp/F8IekPKy6CSS60FZJKNdI7IUBtytXKO8VzdS0Roz7IPjOOauBohV+I3klrAUj5xlbPtwspHjYJpRRXSAS9HkLmE08x9cPdQfGDZsuWrZmmp+p969cCc4RWnp0bKX4oTDghWnuA51evhmcetDkB5V7cDTpaSNdeRFmrlEOj5QsDYyC0c3m647ffJVzq7QeM7wjly7J/K9Amv+NYwriLt1nMXVlmbSKX6h2F4nibbXBdtapZ7f/sq5brH37vjHJhzdPA6bJBQw6YxmD9Tnfll0wTFCEhKy57bfCoSzC5YD58xDwXXRVZnft80PghQ2b40jhwqp6mVtSasESmVg9hCpwjVYrD4lzz4WrDPoDAsMhP2LWt7v7aYSOq6WKxF5YIlkuvDFYnfN0YYjz0PQIN2rwxBflJIr1xJXPUs4sgn208HPN89UHXj3xNnipEjZs=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kOpwz7omzttVDv4mBZ2h+lx4DbsHvGRDYTnD5WBWAxmRMxu7BqilbkAKxglvqhYk/ZSldO9w2rc5c45a/QQfXSP8Hz8KRf9dxAQU2Qt8cIrK6+kMLG667Ls6tyo2Ep0Cl0WiGW8prK6mA3zHL88uRLJCewsWstyKolCICN66e9YSXWmTgQu0yUUG3ZX738RcyO+X9lEKXyft2/R65H1wecL1/mBPJ6XAb4O1M+/hsaQ8n0cCikPERM4iZEIEAJPA2jW57JH/jOl6jdX4Vej5f78wuuBambAbKJNPNlPsVLpQNjYIkyDNsPV39K5fth1nyJ1nrEvvPbsJ0tdJB+8odVOoSuSx+v0pFSADagIkWTHN7SBAtDRS6tTaBR//yb1o11dEMWfe+aR72ioDCdwCM94t+/cgY5UyuC/pX0XLvRjE8XntEjacnD3mIWZXskWm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 07:21:23.5159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b29da9-b4ee-448b-d7f9-08de78f579a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6194.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5766

Add PCI device IDs for Tegra194 (0x1ad4) and Tegra234(0x229b) Endpoint
controllers, so that pci_endpoint_test can bind and run on these
controllers.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
v2: Remove pci_endpoint_test_data

 drivers/misc/pci_endpoint_test.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index f166b6fea698..fe370c94b191 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -106,6 +106,9 @@
 
 #define PCI_DEVICE_ID_ROCKCHIP_RK3588		0x3588
 
+#define PCI_DEVICE_ID_NVIDIA_TEGRA194_EP	0x1ad4
+#define PCI_DEVICE_ID_NVIDIA_TEGRA234_EP	0x229b
+
 static DEFINE_IDA(pci_endpoint_test_ida);
 
 #define to_endpoint_test(priv) container_of((priv), struct pci_endpoint_test, \
@@ -1246,6 +1249,10 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_ROCKCHIP, PCI_DEVICE_ID_ROCKCHIP_RK3588),
 	  .driver_data = (kernel_ulong_t)&rk3588_data,
 	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_TEGRA194_EP),
+	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_TEGRA234_EP),
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
-- 
2.34.1

