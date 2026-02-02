Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012017.outbound.protection.outlook.com [40.107.209.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1EF28CF5F;
	Mon,  2 Feb 2026 07:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770017295; cv=fail; b=SUnRR55AXogefadSaBV9iza1nbTYYs4YdpEejhNv+0kbfSYgLi5bd82pJfiW3IqhkvggUvTcw+AVj4sJV/fvosOUT3wHuikVyaoIOHOjjP0Gn99s5a16zir9HtfSv78KqWd1JX5avxFbpl0QkKvC+rkk6WYaXoQHgFFhO+15VHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770017295; c=relaxed/simple;
	bh=/wAroipNxn9Oxo8Icf5GZdQh5D2YhVmZuha1yUTMSLs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dpwNksaqAKF/BAsUljAqZPO+XYD4oww3PZfyQOn+RjNpr5Zokgax5Kf2YGIA9JOsTPcHCuq/dfoWeNgRl6wrSFVz9heWXmU1shRV+h1MmD7KhpIYEa7tYQ0jV160j/LzbmEhW4QdKtx3HXBVsB6X5W2/JFoD811DjrOt79VwmCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FJ5i4z90; arc=fail smtp.client-ip=40.107.209.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FJ5i4z90"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhE2KhPZF8lRjJGLHmglIEH04UPkTtb0ZB+y9bC9eNBOIFGrfqiW6VaDKSjvGyhvqDRXiv6dMXlZtK7+1MV4LQw55tVCc9qY4XlmSQzqs7qwIq3Ni7b9TI/W8GG0ToDOZtKUvcVlDBAM9wP8k+IqLpIhJHj/m5SyqInQtSIoo2kMk+d/vd++UE24eEWvsP1qYSIVlEm6thWF9RPXlpyjeZqN1RwTrQGyonrQt2F5z+y8GYpESrHYIv6hmIDUFXQcMujAV8gjX1byN0FlhWENtuKUJiz/jZMOiUcm2I+8rGTm2XXwv1v1Fmynu3mVEsyWHPiMf0HaF1PGCYAZcdeK3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCe1BIkLFQvNqkUJt6YGu4MXRvGTd+9K5HMUHKURFq8=;
 b=SHCTLpKxluVEXE192zPrxRtWmvTFGObLOCv6JieofTbFEboaeQfyIZ7QqXG4mOYtqboRlmOZgv6xqCne4gOXH8lDtiIqpSgo4NYXB4+3QBlUQNcgtUta6PIG3MBquqBMbRO3PpehczTtXRJW1I7bnIig9rjxQAjv7YlTJRhJESU0XFJEeNV3Ab7wU/kYEmqaUnMGYoKKuY0o2gUMjMncJEteGx34FLBqhmQk3ufM+ioNHo+Bdaccy/zpn300Z8DgVhrpCz6I5iXvUt8VFxOKzULq83Tri1+OgJJwO68sEK5rjMNr6kPOFrftCMmv/mOaXC1ZI9REzEyunENlY0/qTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCe1BIkLFQvNqkUJt6YGu4MXRvGTd+9K5HMUHKURFq8=;
 b=FJ5i4z90od4AQvSI6k4nYUPfQld3lF2jazJMecX+rBWBbIOpHSQ2KaMffr8wqQjdwVQFzFFFlGSaI3kxkaaTean0hhGyQ3ffwoNhVMX7bKXKZZaeu5Yd8GcjhCDC6gd8Q3Mkg92MRyPqDLoTEZeMB79DCFvaANHspBSmX3o8B2M=
Received: from BN9P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::11)
 by PH5PR10MB997757.namprd10.prod.outlook.com (2603:10b6:510:39e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 07:28:11 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:10b:cafe::2c) by BN9P223CA0006.outlook.office365.com
 (2603:10b6:408:10b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Mon,
 2 Feb 2026 07:28:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 07:28:11 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 01:28:10 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 01:28:09 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Feb 2026 01:28:09 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6127S09N1732804;
	Mon, 2 Feb 2026 01:28:05 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <yoshihiro.shimoda.uh@renesas.com>,
	<fancer.lancer@gmail.com>, <Zhiqiang.Hou@nxp.com>,
	<gustavo.pimentel@synopsys.com>, <cassel@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>, Aksh Garg <a-garg7@ti.com>
Subject: [PATCH 1/2] PCI: dwc: ep: Fix MSI-X configuration to write to correct physical function
Date: Mon, 2 Feb 2026 12:57:57 +0530
Message-ID: <20260202072758.101845-2-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260202072758.101845-1-a-garg7@ti.com>
References: <20260202072758.101845-1-a-garg7@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|PH5PR10MB997757:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c239472-38e8-4c33-6ef2-08de622c9eb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MqTt6i2PD4UxBe4GKc9XylVHh2XMn9ZGxiW28U7OyXfTCCXDcD4vkBlqCjQ7?=
 =?us-ascii?Q?Fo6849fur6tBn5kSVniV4FunuLepEhJrZYiigl4wKqbpmrOwhfXmvCdOli5Z?=
 =?us-ascii?Q?eJrvt2NeDBnbwj1w9ZzY8dC2/Z+nsToeLg3SsMGHuLczPHFImEHr85AFFrrc?=
 =?us-ascii?Q?aVTkUQhYZEAUtzIfycSjPgSwmQKzEr7S93fT+TRq3JdGAeyvsmVYn/HMAz09?=
 =?us-ascii?Q?tISYt3VnSTUqcwSWDCoe20/N1czOjxviX6td95y/dz9NNqIWw36uLCn/0rbB?=
 =?us-ascii?Q?0vUMeVYuMdEsErlbCOLRywV/cXNxVXLZNokHwg4lHsKEUvoyzy2cWymKXJqx?=
 =?us-ascii?Q?wxRZs8XoUDe1DgJpVAlJQ5KWgrkoh8ZmFdIGwtV+2/vl+9XafeVrt3Bjpeaa?=
 =?us-ascii?Q?tTvlyvjFPPc7sdZPEiHdV9qreYA1WlRe8+TD+SNW8r1A0TFTlL45QSl63NUH?=
 =?us-ascii?Q?LpBQHqJ6vjg78pxkT+re/tQ3KyfaU9TEfzXK4LvOfoxRgNfqVUMbnNUQgljl?=
 =?us-ascii?Q?qPIB63UNKrW242yeYT5eOpKKdpb+Ep+wd7K4dl7lnV2/CVGhP6M3k4HU0muM?=
 =?us-ascii?Q?kttzlP+I8ddz9jdEWbw8W7/eNxcPV111JXJaaWHhN0T28TOYxdQh8L55KBze?=
 =?us-ascii?Q?kZr1dXXb3ZXWXWzmO4tX9W4mQo0F+726eDQzRoxrVckJzvE+1oQUQGe6vrxx?=
 =?us-ascii?Q?hiOE9TvGRjPJbiW65gy0cjf5FM5vmNwNHm2TQDj/sMNh6FwDH5inkEXWVGiA?=
 =?us-ascii?Q?ehmGLZaGhKpAQE1txCnNQUr2aRDGOEarDos5Zvf8UAPpyFYhe7fICgUCmoif?=
 =?us-ascii?Q?0fBKJ9RjXPcJfZxcuUUgiFy+Fwnu4yT4Ou728XtTWqgWgGZIU9A9dqI9X2zi?=
 =?us-ascii?Q?GUMgMoGylPmnSQCXc5lXfV2lRoMmjTPFc9pRcepHw3A/BaEZZcEIJuOx2efl?=
 =?us-ascii?Q?P7pUUxt/p0b3Hhx+jE8Q2mzzMABGCfpDLbE+U/F1lP5axeRo/MeAUHSxjGX2?=
 =?us-ascii?Q?Vg3R5a++O8TIgWkHJQ1SlIsibBXGKJ2TD20j6gr4UpZoosA3QjU9KIoXY9AW?=
 =?us-ascii?Q?/BMprbHFih9mPywq9EDSCxkSRukZIZNjB3oPoU0V15jgoVNRbygxqHsTywbx?=
 =?us-ascii?Q?ADfoGeZfRQtHlP2p7PhZ8nhVEh4ASCr+FxzLsSMP9Ad4zb2Ku9HsIE0BoWSP?=
 =?us-ascii?Q?6gWB1zCepzDyi/pim8KpHmXIqAipc/ZTLew4RL5rXXRBotUoYj9dqQFI9A1j?=
 =?us-ascii?Q?FjgE/FlhSXQH7nw750aVE4Zt2gOJZmCUyAc9q6tVQ5ioZjEipXtAKbTmYOL/?=
 =?us-ascii?Q?vbsHpHiguB7DbIGukW43bfi/ir9ueaRlQKJNrPobnLUt2spd5PpWbIuF24AQ?=
 =?us-ascii?Q?OUjmiySF0rtVCrzK1VSk5XdCHzy3OzOfF0KzzSzGojX1AEjC87WJMxGElDnV?=
 =?us-ascii?Q?JO8S1ybDrwsomLjgyHk3LjhmRPqMvbq5/8AXhQJ+u+QScoIK7gyhnckPloFw?=
 =?us-ascii?Q?qj4PYtmT2Ntqm8/qrzTpGmBxVmNIOtWAKpA1mylfaAHhpVDDAcy1NmPIMx6x?=
 =?us-ascii?Q?x+BWu6vnqorRYOVaH3krxpRiw+XGPqU3aAB9RrIxJJTWSrp1nJYaDZ3m3iLl?=
 =?us-ascii?Q?Ll1dIR9KaOJoVpmiy0gib9s4VYBP6oxXqb0hX++qx1UnLawhFQ11Ft7+dFQF?=
 =?us-ascii?Q?rVAhPg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LZw/A7ARRqMHN8F49uqdc1Pw5QPhhxuFcXl8WS/zQHn4Uj0Ilqb9gfzBSUjOInDNWtorZdmCzkx/fY7kLtt0p0CTrI4o8scEAqpkVuGDLIy2WSnpKu3xocur+ACThM3AQYzdTBGZX0mXgxG8aedUvxG6VQJXtv4mRIBOhXU9CyQMIs/poVQCEMdsS29GqSW09JBBJMOitSzdYKouS9vhKJ/rQvNMLnS7AwgwB8uQT9/Q607l8CPJ9kLwdIktEg1IhpmCVxoNJ5xHKcaEB+Hm6vYrkOVuMevGnz6dI/2OISFFuL9QJhynT3UkDWVKnjnMOYIaUrsLWF5scNU8s8n0ad4fUZEUQyuM9zd6IhH/txjfoZ0OCxaadRgGUmuk2rTvxAyBbXZm8TwSlVUCJCZqYtwsKpCOE/MN/enV7wUkxO8niWzlsjebfKAKT/qljqnG
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 07:28:11.2715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c239472-38e8-4c33-6ef2-08de622c9eb4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997757

The MSI-X configuration code reads from the correct physical function's
register space using dw_pcie_ep_readw_dbi(), but writes back only to
PF0 using the old dw_pcie_writew_dbi() helper. This causes incorrect
MSI-X configuration for other PFs.

Fix this by using dw_pcie_ep_writew_dbi() to write to the correct PF's
register space, matching the read operation.

Fixes: 70fa02ca1446 ("PCI: dwc: Add dw_pcie_ep_{read,write}_dbi[2] helpers")
Signed-off-by: Aksh Garg <a-garg7@ti.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 7e7844ff0f7e..771241e1a2c9 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -745,7 +745,7 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	val = dw_pcie_ep_readw_dbi(ep, func_no, reg);
 	val &= ~PCI_MSIX_FLAGS_QSIZE;
 	val |= nr_irqs - 1; /* encoded as N-1 */
-	dw_pcie_writew_dbi(pci, reg, val);
+	dw_pcie_ep_writew_dbi(ep, func_no, reg, val);
 
 	reg = ep_func->msix_cap + PCI_MSIX_TABLE;
 	val = offset | bir;
-- 
2.34.1

