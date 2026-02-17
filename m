Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011063.outbound.protection.outlook.com [52.101.52.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F3927B50F;
	Tue, 17 Feb 2026 05:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771307747; cv=fail; b=huQnwhYhYZU7zHPCDMYR417/9kPiH6qacUlu9l2dyj5V3boSBizDMKUFtdg6w7erRr6L8IvWBlEI4J+b+214p0w3WPA6tla/JrjYmgcEC0y3yIQg25w8qRIEIWOkiUSONxXJEDXCWuTTs6yfaMMVs+L+ODz4AkTrnBsdnOFWYz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771307747; c=relaxed/simple;
	bh=YwZ6681eagkm6tUghhbAkb+MD2F1S+UXy86L8uz4cVo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=osOqbKH/uCZHdIEfBnT4xsFPuRkrKkPuvuQHV41CvjOAOE6073AgYn+BDUeVJYiCDXPb7fnIcYVkawI3GHeGH9SqZ+7Ta8WdgqEgLbYn7LkcqvW1XpD/NVOKChVKLHlfWuER144oIX+ltUusdZ/fUd9Sz442V1RMEB1JS1uSFQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Amb/BFR/; arc=fail smtp.client-ip=52.101.52.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Amb/BFR/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8ZcvGFfHY4otTSG1X//pB29rFxtwhkV3WKpHYhBPoP/CV6me3wuKprOPaYPqCAJro5tuijkJaNa7OZBI+HssHndjZ/gEYFLYdHraD17pHhNXz5Q8ILbkYH95GRRkYTro5k8Z3pPb3SOer5qWv9StHdOzLqyiAUjxXxwsSanMJnn+z+37/lfKHd+k52V+dpFCA4eZwAGXBMr0EQ7t4DlEk2pl/Q1UfzgabX5orzRUkviK0gziq4bVqW2q67iQoCYFVUy/IARS0bFeKH8GF2ID2qS96W9AbBR2rCObD1FzJjAsl2WeOrtKq0k+JD9AvKwvTVYUxmOwMsIgAYq144utA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSpJBHPqA1YLc9cuwCtYG0wvuJS/PoVz6uWbojMBSrI=;
 b=F8bOzJkK3e/oKcFstzAjbUvsZ94ym5wyQ1dBO0oBKAeEfmqJJqR83Xy41Uz5MFJ4zdRnFgplNpR8timANDIMnmYPzizKkMYCwxPduvutDW8jVFj5+MYGRyOa9O/pyHTTUZLhkh9GZYEjvwIrgET3/Z60hfQPn8oNe7c8Ee5Izn0S50I30Lnr1Q/N4sZBlOerZegfkANQw0HupctjcZBzTAgrrMQ7bk8oL8sQOOznv85+GZ7uw3vnreLcsX2M2gzjAe2LD2v4ptnIG6PXLJoaUPttsv6QMHcZtEo43+9BcAe1uZRBCoXZXkAj72DCxEmUtCGaCdZTKOCjtLn72Gugvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSpJBHPqA1YLc9cuwCtYG0wvuJS/PoVz6uWbojMBSrI=;
 b=Amb/BFR/PhInnu1UmAAf/x7oEavgeptsQtGUHh5yE9gKSlHKXR8OZXpH51o5UGm5vpjDgFnRlli8/Eml4ECYehkP12MzJAqPCSxg1lg637acxiQIfFrrRwOk2jW+Uc0VDXnekqAi/Y6YYqdqHbpPbsuE18lbQhR3e5CYw3xoJRVBVfM6ViP+Gt2ZKKPw7zutvC1s0ZYi2+9CzvB2lztvgyNh/UfFK10g/m+HmxRzCcGP7qxABi7rAhHtMGX8bKLhZ/G77TpVyTmRfzhospKxaXgR8WGvn26EQJRzPhqIDTfwYjVCGzcgQ291SW7LaJEKSxpYVmpIH6DalWfM+HUFfw==
Received: from CH2PR03CA0003.namprd03.prod.outlook.com (2603:10b6:610:59::13)
 by IA4PR12MB9785.namprd12.prod.outlook.com (2603:10b6:208:55b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 05:55:41 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::b0) by CH2PR03CA0003.outlook.office365.com
 (2603:10b6:610:59::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend
 Transport; Tue, 17 Feb 2026 05:55:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 05:55:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 21:55:30 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 16 Feb 2026 21:55:24 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: Niklas Cassel <cassel@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Kishon Vijay
 Abraham I" <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, "Thierry
 Reding" <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Kunihiko Hayashi
	<hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>
CC: Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 3/4] misc: pci_endpoint_test: Add BAR skip mask and NVIDIA Tegra EP device IDs
Date: Tue, 17 Feb 2026 11:24:43 +0530
Message-ID: <20260217-master-v1-3-727e26cdfaf5@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217-master-v1-0-727e26cdfaf5@nvidia.com>
References: <20260217-master-v1-0-727e26cdfaf5@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|IA4PR12MB9785:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f6967b6-6d0b-4d34-9f57-08de6de92efd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGxJOEdscHJZYmltbXl2YjdVZldsclVvV2lzSlBlVHcvdmFoU2JjRS9VcDZQ?=
 =?utf-8?B?SWhWN2thaVZxMzZGaWp2eGxDYWUyY0hkQ0lucDMrQWxiUVZ6NmhJZDlUTXJU?=
 =?utf-8?B?UXVUOWNpN2szK2JZOVZxNEFZM24vRlNBQ1RVLy9WSkFuSlJKblpSVlJjZjF6?=
 =?utf-8?B?SG9CdWovV2JSOE8wRitiRVVHeUdISWtGcDlFRVVBcGUyRFhpdFhwZWZLM0lW?=
 =?utf-8?B?Y3Z6UEo0VWN4dnVBZ0pyMFo1dWxmRmN0TWxQY1I4akJlb2lSa25NYW1uQ1BL?=
 =?utf-8?B?QXpYRHAxMWpUd1RrM0VHcGZTSVNnaDdLMm1ySDh6ZXZjU1ZqbVY0UmVMSjJS?=
 =?utf-8?B?YWg2U3ZLS3JWNHFCQko2UTlTTlpFWkg1UUJ4b3NESmcwRWxINlZWM2RNQ3hp?=
 =?utf-8?B?eUQ3aitrQXFmbmpHVFVaMDR2YzNvWENEOTNML1ljVEdBb0NvM2dhNnAxbVFv?=
 =?utf-8?B?OTd3K2VtdHdVTXkwcHRlNkEvdy95RU1sN2lEQ0E4UkFrMWJBQ2JOR2hPYzgy?=
 =?utf-8?B?cFJDa0pSSWlBckVPMWE5ejQ1Wi9sd2xIVVQ2SlVaNTFRaHpUQU5ZLzh6SDNK?=
 =?utf-8?B?YllKdExMQUU5RytoTFc1dlVTSFFJSUtxaHpWemZnc3puUlVHdWdaR1N2R3hp?=
 =?utf-8?B?SDd1TWlNblg4NmIvUHVqTnMvUVRIMWtOL1hFN3FPRFJmSTRCY0RUeVpPeFJF?=
 =?utf-8?B?UjdvTUE1R1VPTy9nQkFmbEtCeVp2V0FEcVhoN0FLdWV6NjZsNGx2OXlwK3dH?=
 =?utf-8?B?NDlJdXl0YlhFeGF0cnAyK2hGV09MalQvaHZIMk5ZaUVYanJ6c0NlWFhjbFlr?=
 =?utf-8?B?VTBVMlo3eTJENzhSc1pYbytrWmVJdUhhRS9sWGNkMGQrcTRJUGlPWGszd2xG?=
 =?utf-8?B?bWJKZTBKdXB6MmcwcUMvUTVpV3A4TW94dWRQOVVXOERNaWxyYWI1YldMYzJS?=
 =?utf-8?B?ZTFRMkJXNmpIaEIwSDlNc3RDWWNzUnQ5YzljZUtCdGJhb3BVY0ZKZlRpcTc3?=
 =?utf-8?B?eHR2RmxKWUxRZE5WclZjVVBDRDYybDdWa0NJMXZnYVd5eWJPTi9tczFkZDQy?=
 =?utf-8?B?OU9OaEtLalNsUXAyUFRieit2SnAzZGJ1RzVPTkk4d1dMbXlDZHBIK1JsMklH?=
 =?utf-8?B?MWtVUC96K1RqMlJjVWg2anU1VDg2Yi94ejFUbDhhcmdWTk1xejhOSGpsaTFB?=
 =?utf-8?B?aGdGQlgzQUZBelZQVWlnQmYvWTNReWErYnpnYTZGaU9IZFhKeERza1pKbzF6?=
 =?utf-8?B?dnpuL0NhN2g3citTbHY2UStNVWd2ZXJuaHE5MG9SVEpERGdKbmZqaG1uaHd6?=
 =?utf-8?B?aGt4R0xvNWZGNjJFb0hUeWV5TXNaTlNZaXZmUzliWWhoSXpLL2RlUTBHaG9J?=
 =?utf-8?B?WDdOMFNWdXg3M3VZd0gvSEVlQ2lEMUxweDQ1OUI4R2VzUFUzaW12QnJiYU43?=
 =?utf-8?B?VFJQc2JtaDRiVVBxdW9XRllscWtBcUlxWFpUdERyZm96eSs2ME1hTng1TTV1?=
 =?utf-8?B?MFhSZ0xjWkNyVWV0UjFlbzlhWXZwVHNpNGE0Kzg1Q1lyWGNST012cGxNOVRV?=
 =?utf-8?B?U0Fud1UweG9KYi9mYlc2NnRvNlU4NGVGMnVUK3ZQcXA0Qm9PV3lMaG1vTjNj?=
 =?utf-8?B?dER2UGlzQk51QjJpRzk3dThBZWFOa0pjSGhmVC9VUlUvOFRrYjZaaVVsYXpp?=
 =?utf-8?B?TlNXQ3pmcGxQK1lHTHlzNEJRUjQ5MlE5VnV6OHg2YUI0TlJudEFSZU9hYVJ2?=
 =?utf-8?B?MVB1Z0FreUdLZW1XY01LaXhnb2hPZkhqaDJJS2NjTXlRRnRpZHBNUkNlRjV0?=
 =?utf-8?B?d0xNRnJtMFA4d1JNZ1pBSnNkSzlMMm9CMUtIYnExZ25vSW9vQ3lUV0JNRCsy?=
 =?utf-8?B?V21zMThURUkxSHNSV2J2SUV1c25lc3p2UGpocGhtQm9NN0VLRHNRVHhQWWtG?=
 =?utf-8?B?b25vN1RwbzNiUjE0TWlZcS9PNnVDSEdVNStWZGpaSGpTaUx4djdaVUV3eVdB?=
 =?utf-8?B?MUx5Q1hUMHduRXFyekFMSk00NjdmRkdqZ0JJYlh6c2lhcnpXb1lqbmJ6c2tk?=
 =?utf-8?B?TUVuY2gzR0ZZaFBHS2R3VmJJeGxneTJ1Nmlub0o1QW5veDAvQ25LUU1zUFRQ?=
 =?utf-8?B?MWViNzY1S2ZHMWVGVjByRlZzUW9VRy8xY0d2dG5VempneDZZeEl4T3B5eEpQ?=
 =?utf-8?B?OEVuTlZjckI1VTltdEtZN25tZXQzV3B3c0VlVzVGV1lVNWc4VHVJWUdtRVIw?=
 =?utf-8?Q?L4hEgswJw7jKM7kL1lUN0DME6mRjtzDIfWaSz1kyX8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	J+N4mgD9E4/Tlb2kCgCW1y4JF4NkoQNulJwUMkfbVMV1iRPhbHhqMNanHHe8GHsakLhGIO7P5asKcZ7zQJafHB/7F8CjVP/LncaBO+D4elmSmh8mBpbm0zNrz0DX6cRnA6OHPVvZq9JYYIswkZtlqL4ay6RCdvHuM1UY4nRD5SESBdttuN23IucRnBwfd4x0hJv3PMKK+6QCws69jCCz1CNKbz5I1IYM/kEZ7lMD6IQcnbd0MBX6bDKQEbWA0KBDuPStnH7zm3/p5SdteqG8wT7Y1t8Nmo96bW9p2C1yxHObBYBeZPvq/GES8/hIk2yhWBXwrhskX8gay2pVFwa3Em7MaCHqj1MgNFQEOsbIAUebmXryVlHChhtGTompoKAxvz0ySDHKzaS9Ndl+o3KBxFKZqI+GuA3pQn7S7DMxZ7LAUmu1fgFxXeHIljLQaOkD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 05:55:41.4798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6967b6-6d0b-4d34-9f57-08de6de92efd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9785

Add an optional bar_skip_mask to pci_endpoint_test_data so that
endpoints with HW-backed BARs (e.g. MSI-X table, DMA regs) can skip
the destructive BAR read/write test on those BARs. When a BAR is
skipped, it is not written or read in the consecutive BAR test, and
PCITEST_BAR ioctl for that BAR returns -EINVAL.

Add Tegra endpoint test data with bar_skip_mask set to skip BAR1
through BAR5 (test only BAR0, the first 64-bit BAR). Add
pci_endpoint_test_tbl entries for NVIDIA Tegra194 EP (device ID
0x1AD4) and Tegra234 EP (device ID 0x229B) so the host test driver
can bind and run tests without corrupting MSI-X or DMA registers.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/misc/pci_endpoint_test.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 1c0fd185114f..4c9f02dbc41b 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -100,6 +100,12 @@
 
 #define PCI_DEVICE_ID_ROCKCHIP_RK3588		0x3588
 
+#define PCI_DEVICE_ID_NVIDIA_TEGRA194_EP	0x1ad4
+#define PCI_DEVICE_ID_NVIDIA_TEGRA234_EP	0x229b
+
+/* BARs 1-5 are HW-backed (MSI-X, DMA) or high half of 64-bit BAR0; skip BAR test */
+#define TEGRA_EP_BAR_SKIP_MASK	(BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5))
+
 static DEFINE_IDA(pci_endpoint_test_ida);
 
 #define to_endpoint_test(priv) container_of((priv), struct pci_endpoint_test, \
@@ -130,11 +136,15 @@ struct pci_endpoint_test {
 	size_t alignment;
 	u32 ep_caps;
 	const char *name;
+	/* Bitmask of BARs to skip in BAR test (bit N set = skip BAR N) */
+	u8 bar_skip_mask;
 };
 
 struct pci_endpoint_test_data {
 	enum pci_barno test_reg_bar;
 	size_t alignment;
+	/* Bitmask of BARs to skip in BAR test (bit N set = skip BAR N) */
+	u8 bar_skip_mask;
 };
 
 static inline u32 pci_endpoint_test_readl(struct pci_endpoint_test *test,
@@ -393,9 +403,10 @@ static int pci_endpoint_test_bars(struct pci_endpoint_test *test)
 	int ret;
 
 	/* Write all BARs in order (without reading). */
-	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
-		if (test->bar[bar])
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+		if (test->bar[bar] && !(test->bar_skip_mask & (1 << bar)))
 			pci_endpoint_test_bars_write_bar(test, bar);
+	}
 
 	/*
 	 * Read all BARs in order (without writing).
@@ -404,7 +415,7 @@ static int pci_endpoint_test_bars(struct pci_endpoint_test *test)
 	 * (Reading back the BAR directly after writing can not detect this.)
 	 */
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
-		if (test->bar[bar]) {
+		if (test->bar[bar] && !(test->bar_skip_mask & (1 << bar))) {
 			ret = pci_endpoint_test_bars_read_bar(test, bar);
 			if (ret)
 				return ret;
@@ -941,6 +952,10 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 			goto ret;
 		if (is_am654_pci_dev(pdev) && bar == BAR_0)
 			goto ret;
+		if (test->bar_skip_mask & (1 << bar)) {
+			ret = 0;
+			goto ret;
+		}
 		ret = pci_endpoint_test_bar(test, bar);
 		break;
 	case PCITEST_BARS:
@@ -1028,6 +1043,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 		test_reg_bar = data->test_reg_bar;
 		test->test_reg_bar = test_reg_bar;
 		test->alignment = data->alignment;
+		test->bar_skip_mask = data->bar_skip_mask;
 	}
 
 	init_completion(&test->irq_raised);
@@ -1173,6 +1189,12 @@ static const struct pci_endpoint_test_data rk3588_data = {
 	.alignment = SZ_64K,
 };
 
+static const struct pci_endpoint_test_data tegra_ep_data = {
+	.test_reg_bar = BAR_0,
+	.alignment = SZ_64K,
+	.bar_skip_mask = TEGRA_EP_BAR_SKIP_MASK,
+};
+
 /*
  * If the controller's Vendor/Device ID are programmable, you may be able to
  * use one of the existing entries for testing instead of adding a new one.
@@ -1217,6 +1239,12 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_ROCKCHIP, PCI_DEVICE_ID_ROCKCHIP_RK3588),
 	  .driver_data = (kernel_ulong_t)&rk3588_data,
 	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_TEGRA194_EP),
+	  .driver_data = (kernel_ulong_t)&tegra_ep_data,
+	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_TEGRA234_EP),
+	  .driver_data = (kernel_ulong_t)&tegra_ep_data,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);

-- 
2.34.1

