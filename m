Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010019.outbound.protection.outlook.com [52.101.61.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3F62DB797;
	Thu, 22 Jan 2026 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769070370; cv=fail; b=H/cd4YHMCp+uJdyNs9GdEjUmPM8W8WPrbYxVGzS63o+qEXGonOxonnzs9yU/O+hfOk6gmyO4ajiB/MDfKi5owDG7aSyxjKTZnIi3tWu4bBNmSEWqH9swfEJODA1fhyTo3bfY3iMfcQLVXELKRzxmRrnmogU2wXatI6dwe7Gfc7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769070370; c=relaxed/simple;
	bh=9iUv/7JhuTPSJLmFbPMMby5IeIdHKBkDbuIHstSoLl8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PwyRwiecNsnvclnCdkjCPEeACh8OFdy2hm54s2oy0xF5YuzYuaqVANynUdVVAYfPMDxlDoWeKz3GQQZ0NNtxGQoYUPgmxyWcUm1jYtmRCV5FFLLEmo+Wwsjk4SfCeTNMlBoPcZsxB0QY0j9Zlxah7wZqYLtpU5R3/3zq9KIWuYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Opw/Rgbq; arc=fail smtp.client-ip=52.101.61.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Opw/Rgbq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azLHYd3a6NL/h3EM2x2VIpcI4brKBqXgZslWURwAm3xMFc6AJB7hVSxqMUxl4l8qkS/gp9Xy/VQ885zyNjWSQ3XSNSr5RO1mNOi2z3/SpzHxXN8O1tfoW/sK+rsiY3995bMwW3fca+66IXdVv4MVYIv5Ojr/dqjsXakdP7tpm3ULySh2qPnm2ae+vtx6x9cZLIf68s1ADP9MUnZiN8Nm4lE0GhIvrN2zEzmu9vjfY5NNht64uvRivwbT9zaWmq421U/AvWIVZkLUAESUpcch7lRZ5h3Lz9VRUeOtKAM9LBALLF4Cn6gbclLMRJ2KN2HrV90S5I9Cmt3Opu6SkTJLtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KYdUTYUZiiYgz0o2P0waBV9UhwfSPTFTKIm/c1amGs=;
 b=jayriqDuWWQ0OEN7LbK9C6WGDGJGZDLQIwwNP/VsGP5ueC0aatRoWfEgvbFAWCm6DMrKhyoksxNjWrM6h6510GXZeRY++1yMYAIyJHFeqs0p0IOHG0uMX3HsYsbEdeIGmgkjZsUQwa2Vr8rcWAfyWcQV29IVn8M6RHh6z9aauGlQXtW0qYKHBRsR6EGbJXnD8X9e7WJ2z0Owe8XzkGvFZ2A0lM4zHiiGfkZkIRTglkP8vEqSzYKunC9phuvLequGFLziR16C1RWP6op1UzLAzMCyhn751BM9IFU1YuBAnoJdQUgyHlNs3VMDTXkhGX/P1PdZbGDkvAkKN1ImdP/eAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KYdUTYUZiiYgz0o2P0waBV9UhwfSPTFTKIm/c1amGs=;
 b=Opw/RgbqzeNh2dtpXN/Wubh4SZbmW0r7I185AjIhc655+puyGMsFRCVN6/dGF8zKRJfMiP33QWPlIZdLzAhziF4PfcnRV1jfVAzUWS6+inNWCZVgnnT2v9DM9EDd8LWRsmrOk4QUHqtmeYDmdHXEo8uBNF9tN6HLufCOqtB6Qc0=
Received: from CH2PR15CA0020.namprd15.prod.outlook.com (2603:10b6:610:51::30)
 by SJ0PR10MB6326.namprd10.prod.outlook.com (2603:10b6:a03:44c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 08:26:02 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::a7) by CH2PR15CA0020.outlook.office365.com
 (2603:10b6:610:51::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Thu,
 22 Jan 2026 08:25:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 08:26:01 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 02:25:59 -0600
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 02:25:59 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 22 Jan 2026 02:25:59 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60M8Pi0I125446;
	Thu, 22 Jan 2026 02:25:56 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <cassel@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>, Aksh Garg <a-garg7@ti.com>
Subject: [PATCH v2 3/3] PCI: dwc: ep: Add comment explaining controller-level PTM access
Date: Thu, 22 Jan 2026 13:55:38 +0530
Message-ID: <20260122082538.309122-4-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260122082538.309122-1-a-garg7@ti.com>
References: <20260122082538.309122-1-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|SJ0PR10MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: fc01d4ca-b112-48c8-ec91-08de598fe06b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ue7GJjqNHOAgBiHv3S0swJaz5i4p65d6s+wx3lmcW4n6GUcpMndN0myi982R?=
 =?us-ascii?Q?uK715hzXqk4INq72iAvqocQhVPr4muGTnE+9Mi1sKqiDNo/99UV3OSAyJ6fJ?=
 =?us-ascii?Q?0r21xOgBNNSi7k98YI0iodXeBuQR7R8xIed7rFT+Rrcn1Zz8dEPhm5x740XD?=
 =?us-ascii?Q?pyrGYgOj0TxVmtHtPZEbpixQdhBwOQsfWJaG/CH8Dojn7aFQqUEw5KULPp8i?=
 =?us-ascii?Q?Aa4/7/JxKCsDQbaQn9dTpaROSpZ9SEZa6zIi4k3OQnED9P1Ma5Ws4hH07GzD?=
 =?us-ascii?Q?/BgcUL84JloRBH3QfwRiDcK5O8nSXVf3/AZocPLgDgGexpqiiLvrm7+XJ91g?=
 =?us-ascii?Q?1flv6r5YzHq4EhgonAim11rSzn8BXqYAUcLCA/H8jc9wH7z2BHuiJ6ckzg6k?=
 =?us-ascii?Q?8v+5jZKobhSDE8AV6//k52ItEK/txDsohO/OtQksdoz6DTxdICE0ZAfEBWTw?=
 =?us-ascii?Q?O0x7hTW5bj4929SN4RkwVKWVgMbua2Hq0RvOSBCiTKtcOorm9MOmei/cXwm9?=
 =?us-ascii?Q?tG43Y5qQ7cZGirv/keX+5HQ0s1e1to8wxePQfQQobxfxCzMYQ4LknbYMkxsx?=
 =?us-ascii?Q?SX+DiRY/0GGSx235lWrTMaA8jjiFMh15Yg0kriyqGaI9xJKY9LLWGxXeP73N?=
 =?us-ascii?Q?8bOU0lbb8DbVFZPWEllOQBMKUiRNW6oeHJ0Gm/G9T/P7AhI7iQ8R1Nypaick?=
 =?us-ascii?Q?6hDMTvVF0+RdxVlWeOJqBZt/l1W5jOmGtIUgOK69+QNKCWHmXkIkX6xz6rXN?=
 =?us-ascii?Q?GI8AKYOPSXpqXjZTUNhBU/PA75RSZ9pIu+pWpzbXtbS3YbAPuod8XHcVv3gC?=
 =?us-ascii?Q?+NoMfr/SMbXcHGRqbt0FYt4PaDMCnD+FxbTp3RbGCAgqp7rbl+4aaSy6nX8G?=
 =?us-ascii?Q?s+ggTXdr+LPnQgGWvujYf8azMYUNyLzcPOPMBP8zdp+sEoSjwHHJ+EpzrGYI?=
 =?us-ascii?Q?b8YtnsddjcfsC+VOHO5m4dXzTLXgq4WvWUNf6cqMpGwgWwFKXZMmq5bmOSoa?=
 =?us-ascii?Q?XTDXAVBbOxP8fPaF+ASR5Oilk50Zd40n9d5tZtjPK0/TTyNSQx7Vlxf0PLBK?=
 =?us-ascii?Q?Ape/zHlmQTiPXaahPj0YQdopXm0ZUcCUA4NSPo92g6CpaILQ3OTEiszovN3d?=
 =?us-ascii?Q?FO9P97pcV6ffXCP1W+0+F6YscEHAyLS/77Yj6d93a14FarbL9CqdyfG+304O?=
 =?us-ascii?Q?MW2/9dCo7xaASjSmMTGJvMHhWiIsClv4KkbblMRSlRO2Lqq9ZF2Lz1ZABykW?=
 =?us-ascii?Q?Lhie8ZmqvXVLEYHxKWhM0TDUhn35i4QP2ZDEdsZHOdlG2L6LzDAMaoWMB8uy?=
 =?us-ascii?Q?eHe+XHWqBQWThgbxm140A59B5f79tTlEYk5hYAuFH/x+v18TFM7DMVMUULZ6?=
 =?us-ascii?Q?x0O5178N2llTSCySbmHACGcTaBe2W9Xm+KqnDM4ZdiSN2u5KyaVpQxjyQV1h?=
 =?us-ascii?Q?F5iLCVdOCOkVqFDFCK3BRQ0t0fQEGqSZu7flyMN8LHvp6PeMKpyQ7uUszr5w?=
 =?us-ascii?Q?fHaXDoSfN7hwshd63l8rER6qfWVGrOEk4LYBppK31ida9R1rl+gerwWSGS5B?=
 =?us-ascii?Q?UMBOZ7K469pCvvDs2yvMF22KZ6PzxTJoBOm+D0aQslBeeYUhVWZBkzYtNFaj?=
 =?us-ascii?Q?Uajk//YTq1zamkXOCXTejy62m0QGl8fokB3bUtub0ZePqjsON7OuhU9M6Uyb?=
 =?us-ascii?Q?m1GzMg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 08:26:01.2617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc01d4ca-b112-48c8-ec91-08de598fe06b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6326

PCIe r6.0, section 7.9.15 requires PTM capability in exactly one
function to control all PTM-capable functions. This makes PTM registers
controller-level rather than per-function.

As suggested by Niklas Cassel, add a comment explaining why PTM
capability registers are accessed using the standard DBI accessors
instead of func_no indexed per-function accessors.

Suggested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Aksh Garg <a-garg7@ti.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 12625a1059a4..0a9d5402f23a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -995,6 +995,17 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 	if (ep->ops->init)
 		ep->ops->init(ep);
 
+	/*
+	 * PCIe r6.0, section 7.9.15 states that for endpoints that support PTM,
+	 * this capability structure is required in exactly one function, which
+	 * controls the PTM behavior of all PTM capable functions. This indicates
+	 * the PTM capability structure represents controller-level registers
+	 * rather than per-function registers.
+	 *
+	 * Therefore, PTM capability registers are configured using the standard DBI
+	 * accessors, instead of func_no indexed per-function accessors.
+	 */
+
 	ptm_cap_base = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
 
 	/*
-- 
2.34.1

