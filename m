Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011022.outbound.protection.outlook.com [52.101.57.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6DF3603D7;
	Tue, 24 Mar 2026 08:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774339818; cv=fail; b=S7O14lk41aqoy/1PVKxgC94nGpuIKEg/WUUDbCamd3i+ffX4ymCkbRY5wFikhkLQ3fHxiqb6NnTF7FNgSqIgsJwxlyWW+xD8LjWea0M9zLil7YZsgURu3MZwUVZ0jkPslRTRyjLxIdU3XCcNKvmHTUYBaLRCjIMVFvtRJoFb7hY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774339818; c=relaxed/simple;
	bh=TvWePUg0yeuUwlXpejnhNWHN6D2i2seWdyQqHg9kAgI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SXH92W7QmClo8a7mYl37YfSl1VumTDSdqR27sWycTZiD8ST3h2yctRFQS+kCcXrRUnjz5uriSZS+aEsIe3N7eXZdAOYIHBKlTNmBJlJtdrtF5yl6DsKZzX9sZlHI3RCX71TYwZfFtoj/nF8jnVeygJ4NCBv4zmjLLkEY+asKx6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C9QtFFcX; arc=fail smtp.client-ip=52.101.57.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C9QtFFcX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPGNUvytKzaRAXYHViY5Q1DUUoIu56vqGL7FBy8j4Hb4qJ3U7slFu21CjK0gWlr0o3gup/sZjzO26AnSGIg8Yk581nHB4C+HU0zpLRHS2hKdSY/ApY0ORm9vkvSZGVlxrk3hfk0c0jbghN9NA2U3r48rX4mI8R3/qW25VilE/qDfFymSVeYNngq6ipgY0+rxLO64ZWk2bedd7m6ZOrEV5k+/vFECchDo5G88adBj9sBeBAMVYu2v4wwsqb74cv1JLi2ggRD6190rRiEGtHgQc9iRR/5CW+SjMaeIxNrGgaLtiir8BbV4xGjtN17ITseSXcgEejFNw2lQmbrX8ksT8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0u4rgBEdEZqtpeBS+meo7LgZGswkUiofJbEV6daQKdA=;
 b=kslxwqjq2gLKh/nDgfwJroZYlsq/8OBuAQuGb8JO7r0/p70TVfNSZhP04RJARkTVtTLqLLb1JvIGBn1qoO8Yl1iNi9EUlz/1xC98YJTrdAhv+Fe03Jfg5wg29mQsmRr+0Nwa9AmLxuxG5oKB14OFH/scCCrCWEEcmY/tWrzXca/Ei4miMmoDHr3O8r4l8HcmDLNzIuYoBLP9KVEDub7Z42WORNLRTg/k1cRVv8pe6CPatkKOm1y/nE3IfhKAGs6UkypUY3zi2/xxT6/J75P+lP74KHPuQ4s7E1TTwbSzyMIkRZUiOSvdR8T75v1tNiCBFLK8Ya1AuA0tr4oU8gnTaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0u4rgBEdEZqtpeBS+meo7LgZGswkUiofJbEV6daQKdA=;
 b=C9QtFFcXMrrfP9Kc5q4Mtz/rWnauVJ63h5xlj0FfFhBofIjW8W0cniBNa292ipBDmT/i983v3jstL8/JzFxRzryfSrVnpCWYODWmiFD1ovixL/Sv5gUB6QoPzkiNYLBL0jRO6m4TRCWB8eXY7BDRxEk6nCMYMgr+Im1uvPaUiYPE8eJxqGzcNaJ+DAssCnUfGu4pwaRbgyyBnvsPvLqFL6IqI1boBsg6rMMndFNDMyh2CCkHUpkDMtdofDxktlPdpTuM0XrJSPBX7bLNnky5I7NXSG9JlZkYnBq1LCFmhh9SOtQVNVW4m9zQ7Dm8swG5QfCCbuHBFOS6TCPWojWh/w==
Received: from PH8P221CA0050.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::11)
 by SA5PPF590085732.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8ca) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Tue, 24 Mar
 2026 08:10:08 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:510:346:cafe::5) by PH8P221CA0050.outlook.office365.com
 (2603:10b6:510:346::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 08:10:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 08:10:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 01:09:47 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 24 Mar 2026 01:09:40 -0700
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
Subject: [PATCH v3 4/4] misc: pci_endpoint_test: Add Tegra194 and Tegra234 device table entries
Date: Tue, 24 Mar 2026 13:38:57 +0530
Message-ID: <20260324080857.916263-5-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324080857.916263-1-mmaddireddy@nvidia.com>
References: <20260324080857.916263-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|SA5PPF590085732:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d077bf7-99e9-4557-0491-08de897cc37c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700016|22082099003|56012099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	sUDYRgj0ZYEu/JvgB0g0DyySWwPTdzoBRW/RNbecACXb/zcw7YErZI0TBC5o9h7v3qaAdQ4mUy0ZIIQAWlNRDJB4wf37r8U0waTxLEEbw+8m2pF5BLVdbUJ7MWrcz4Zvk/cjhuTVxgnj9uuNbftM5SRYFbU7II/0l5ZMwW5pL4F5t5OJLNRcnwceB2X02O7NzR+KdrESLNXUTpbKmJgF3fkVlIMEA4LNuwJzGzDDOTUAUyyL3qJUEK7Sbm/x6/0/FbLbL//ps+qT9zsJ110zlpVbAF5K+S49cjqNwggZSY6Tfe18P0VbNQRj5pU0osYXTSaMGLvqGqsk7CD77Sa/NGTJOMxqGYhaco1pakRtwvZsO4Hw9KuQlo2adlGZuH7xOkM8vf8JZHTfWjGjxD2LExrufN2zLaAn1hLaVn2OJ9ij5VY67nGLuuhT9MbFMKJch1pyVIWk1/WVBH0BbggQ387OCIj5DThlcBdLAucP++y1BQjcMZidq3FQf72qOlZ2FKlfdiTQZtJnvBCpEiIxas4M/BBeaBT1vYU6YEtISklB30RahRIM0hFDVhaEEX1c3t4d2VqaMQQg9pFlBZRHgkE8LpD/rVYulowpmn/ygh+VPV3+AgVcVIryOJcPogTZuS0FPQK4Izx188c8X6C1htvDgTf1bVNWY2xg3Rr5wdVW4VMUwm7ZLQ3dN/VZHuV43e8EcM8RGDkfkJXNHJvCQrAY9oYhZR6/yJAhu9awdkjxOtF8hefnuxhJGnoOJZTgyQ0L7ri/m54Zg3aZ2pAZmTRv6NoD4fu8xq5pAXRLRFrSDM8acZ0BdobXmMy2bVR0
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(56012099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EFC24zyAE8vOulbz+6YNUMCXQIMpfd3gXOfM2p45c1Vi2VOHxUxoiJxK4q3H4yglNM/aLqGceSlFyNvXiIh28Gjgcfbb2UkgbfHT8aJMjKXF/uXy5zHjtEflz1yovFtUB4We8pwe/zQBNUHge3u3NsJxKe+VuZ0Cs9ERq1EnWbFJuaQKis5rBCNOui9Xe8KMEeAqZYdt9PLxV/cAFxoomfYWACZyTRUd5Uy/pW0OqzP6zRPhIum658m6dAbNsdX8Q+kHMWJ5394M58XzGySXttz4fIgy97Dm2267osQMJcTam97amqYPhoceyibg1ze0uTlmsfFCBTpIKin3LWdOnyZAM23B8n2W2iYddquyFBPzsZevO1HdVWQT1xbq7ufGV2OwODiWCnAZpPkrKIyWRCwjBFfbuxRMUZRE55BrE+qwS8mlxmw033dPKSdD7y0+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 08:10:08.0611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d077bf7-99e9-4557-0491-08de897cc37c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF590085732

Add PCI device IDs for Tegra194 (0x1ad4) and Tegra234(0x229b) Endpoint
controllers, so that pci_endpoint_test can bind and run on these
controllers.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
v3: Fix review comment in v2
v2: Remove pci_endpoint_test_data

 drivers/misc/pci_endpoint_test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 55e128ed82f0..63f1e874719a 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -114,6 +114,9 @@
 
 #define PCI_DEVICE_ID_ROCKCHIP_RK3588		0x3588
 
+#define PCI_DEVICE_ID_NVIDIA_TEGRA194_EP	0x1ad4
+#define PCI_DEVICE_ID_NVIDIA_TEGRA234_EP	0x229b
+
 #define PCI_ENDPOINT_TEST_BAR_SUBRANGE_NSUB	2
 
 static DEFINE_IDA(pci_endpoint_test_ida);
@@ -1438,6 +1441,8 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_ROCKCHIP, PCI_DEVICE_ID_ROCKCHIP_RK3588),
 	  .driver_data = (kernel_ulong_t)&rk3588_data,
 	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_TEGRA194_EP),},
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_TEGRA234_EP),},
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
-- 
2.34.1

