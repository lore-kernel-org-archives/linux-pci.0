Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010069.outbound.protection.outlook.com [52.101.229.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321E8356742;
	Thu,  3 Sep 2026 13:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442452; cv=fail; b=hiWAw2ri+KATzcRj6cCAhO6YU6HPMLj3oRlAfTfClLVUwutgl/Z5N3578KhniPAe5lyfYrLGYICi4oPnZXdwlKX8FjIN8gpcIQzRTpYDwn0sAZCazIthn0nsZ68pcVAJ+NKt5rQqw8icO//LCd/B27KdTVdhZ5HWabEqkChNwjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442452; c=relaxed/simple;
	bh=iQCfKlPEgX1s5weulwgNk7LLQYS21KIra74bVFoiXZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LI/FCoaug79QADedEriB1Ev2yaK5rj0WygiSiA9Xktg8+qNpN/32EQSPm40FPvbk/dUdHHFu8zRU9UQq3o45XzgoDC9gnQNaigmBHDdYtph39z4ia43pDY6VuGNEzQU24Z3ZCq2jAPHzvbyne5I0tk9kWQ3UwwwbkgORUFzX9Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=nwhR0wI9; arc=fail smtp.client-ip=52.101.229.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="nwhR0wI9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLOBwcoATklAj9i0hw8/eKBVSosYyrluOgAw2hTOJLrZ/IdT1QdIr0hhib4lNXyi/WGjb1EDxCuZGIl/3Kyw3vko3R4PDhUiLAcRL1BKOZb+mleFj6B6Jrmghl57KsWhLgXC08B23hc1kXLAISbCfUfAW62q6LXVqoNJvN440f0+ApetKYYs/MnA4tGDeDGdZxFemmYy3WG2cRDD8oe4o0SwIq+Gm0/pVuI0kEhyffew/oV3AvzF3iHboCPiK3leb/oBqxvTQKfqRTT1ymmAThdFNOXRJyWnV+MLZPiP9sT/7A3tRrcpzr/Spo1n4WFQhzClxlr9MRAXWgLLOT7d6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQrwDa1Kl4Th5NoaM/Gx/5ppaNDACSi6pqQJ66J4ZM0=;
 b=E2+pRz9wTAiEpa2hIAXNfmkcdxylYEMtSxSooID3+Bu8yGiX5ebzBZDhitBE2EZwYgqTK0bbI2tAlrwpUj9eMzDoi/e0ng0fgnS/Xseyp7TD/eMlUg7BE5NevfdcM1YW7HueDSCNxJxGmYRXJBLm9TwwNnel9CeVg5cUxmmRYiBi2uMEbw4trAY2XsxIVegJ4R34sLU66vxJHdZbqhWZtga2VcRYHG2IH0kGOXXYzSTvy3+/THIvFnY6UjM2xfeg7ri23vQYAdLyTQnlyEzOfryFjt9YnbHzAC5jrBZhKeSGWJeCltYBmHk+jkiUqbZP+yqGbamcovaCCTBcaA8p9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQrwDa1Kl4Th5NoaM/Gx/5ppaNDACSi6pqQJ66J4ZM0=;
 b=nwhR0wI9j4mZgd9Upn2iotWIlVmSsb6kUxpChPXwwwyZphIMBaBfZ9ZL7FhBeka3tUNaFf6GR9hrUI3Ejd7crMnnQB0PXo7OV8yLc0vmsogTQx6zSr1vL2vYkAAvqotLjmdhbBK5MyrMCU29mj8oWnhEKI6aW4/3tEWO8YomOjk=
Received: from TYCP286CA0216.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c5::12)
 by TYRPR01MB12269.jpnprd01.prod.outlook.com (2603:1096:405:fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 13:33:53 +0000
Received: from TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5:cafe::78) by TYCP286CA0216.outlook.office365.com
 (2603:1096:400:3c5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Thu, 3
 Sep 2026 13:33:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005023.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Thu, 3 Sep 2026 13:33:53 +0000
Received: from biju-VirtualBox.adwin.renesas.com (unknown [10.226.93.2])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 41890300023A;
	Thu,  3 Sep 2026 22:33:45 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 2/2] PCI: rzg3s-host: Add support for RZ/G3L SoC
Date: Thu,  3 Sep 2026 14:33:11 +0100
Message-ID: <20260903133320.144245-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903133320.144245-1-biju.das.jz@bp.renesas.com>
References: <20260903133320.144245-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005023:EE_|TYRPR01MB12269:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4690ff29-a549-43f4-e8f9-08df09bfff6d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|6133799003|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	9jNDc8jZmDUKSjNJzketFa42xaEAgRDno2yN7u8xexBZsAjc3a3RGYVB95aZvSP89D0o1Weo360cXFZ1G2cCmPFtbKvBoSsZnbP03awPykp2hn0rKikYSusCDeKeelcC5wbOXQZy0CyUlW0toldw2SlVY4PTL50ZKi4Ln8XOpbVcFnefmaBlkqNGYWs3cICF8ej5ktWxYdHysjcRrPvadqDFZCW/fPCiHSsn0m/w1cpT5V00At8SY2bPjPkYITAfdkT2pcNsks47kLwyJXIMMsTRDywaiK74wfS0M7e5hrWIWMe5/4lZ8GsT8e2dMb5Rwix+wLAP4nNYVgk2ko0F46ieBvWrs/BnC4kWtwBNo2oYPkGJGdKqzIXbf0g83ooCrxUJbpWsApEvyDS0h5zt/eVbMQovWEdYfN0FLzZ6QKE3OuhUSetd37N+xVFXxWmwno8hh+XWMifPBYEaobzwjGjTVheL/NEdYGWp3El651fbwFuxurURZvEzwGYcvD07l7DtfSrhwGB2khuT5SYHbX1xJN1ZUk/gcc/cli8bZPwFb7+ftIm+TujaWxgqXD2MINPbfHKB8h0PQoWWaC1hXLfiP01H4XOskU9oO1snDY3YHQ3wMXOxWGAoF8XNOxJb0AxXXpWEMkYwHGi5+ZHwb9Sc7iOX7kyTwfYLoJ3J3PZffDXbn4q/vTTrgZENstMXEP4kJS8HgaKG33s9a8rSUQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	K/GlRdKV/jF9X0YwOYSbdnjOKZCJt3vw1NasQuJ74ap/4rPPSA1wBE8zpNOjolyU+qC6ZW8rcIM/zOu5ZLkwYQE+5pUuXx9Vtr128fsq6BJgABw2iQ44obCacAIyPFn8f6Wf3TPXZfDaUkTzgfA4F9pQXBtH3toT+klpLNozp4qm1afOLcP3XRRb6Ynix9lqdp40tFIjSMjGXWTh6AfAxX7JSQ+EVjTVcWntVRg5fBFD7NYofa9MI9izJ5JMpMuflWmA/iULZOkHYIrgQIS59jKMAprSwHXL6UycfRd6OM9cwYVebcbowm4k1ldVM5PKyWCDOssvgsZw84mULkEOUKQlTse6rHOPyqKLgzXCNuzqQDVEASQB0UcFutwVEpq2KAB2FPuROWPR7emkIdqfnnCQvHzR+4ljBG0FJ8eI1U2B5YrVTyxkT6pDjFOG5hr8
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 13:33:53.8193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4690ff29-a549-43f4-e8f9-08df09bfff6d
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12269

Add SoC-specific data for the RZ/G3L (R9A08G046) PCIe controller and
register its "renesas,r9a08g046-pcie" compatible string. RZ/G3L reuses
the RZ/G3E config init/deinit callbacks and power resets, with its own
L1-allow syscon offset and mask.

Also increase the timeout in rzg3s_pcie_set_max_link_speed() to fix
the "Failed to set max link speed" message seen on RZ/G3L.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Collected the tag.
---
 drivers/pci/controller/pcie-rzg3s-host.c | 25 +++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index b3531468ef38..3dffb85c6a47 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1165,7 +1165,7 @@ static int rzg3s_pcie_set_max_link_speed(struct rzg3s_pcie_host *host)
 				 FIELD_GET(RZG3S_PCI_PCSTAT1_LTSSM_STATE, tmp) == ltssm_state_l0,
 				 PCIE_LINK_WAIT_SLEEP_MS * MILLI,
 				 PCIE_LINK_WAIT_SLEEP_MS * MILLI *
-				 PCIE_LINK_WAIT_MAX_RETRIES);
+				 PCIE_LINK_WAIT_MAX_RETRIES * 10);
 	if (ret)
 		return ret;
 
@@ -2467,6 +2467,25 @@ static const struct rzg3s_pcie_soc_data rzg3e_soc_data = {
 	},
 };
 
+static const struct rzg3s_pcie_soc_data rzg3l_soc_data = {
+	.power_resets = rzg3e_soc_power_resets,
+	.num_power_resets = ARRAY_SIZE(rzg3e_soc_power_resets),
+	.num_pcie_controllers = 1,
+	.config_pre_init = rzg3e_pcie_config_pre_init,
+	.config_post_init = rzg3e_pcie_config_post_init,
+	.config_deinit = rzg3e_pcie_config_deinit,
+	.sysc_info = {
+		[RZG3S_PCIE_CONTROLLER_ID_0] = {
+			.functions = {
+				[RZG3S_SYSC_FUNC_ID_L1_ALLOW] = {
+					.offset = 0x3a0,
+					.mask = BIT(8),
+				},
+			},
+		},
+	},
+};
+
 static const struct rzg3s_pcie_soc_data rzv2h_soc_data = {
 	.power_resets = rzg3e_soc_power_resets,
 	.num_power_resets = ARRAY_SIZE(rzg3e_soc_power_resets),
@@ -2516,6 +2535,10 @@ static const struct of_device_id rzg3s_pcie_of_match[] = {
 		.compatible = "renesas,r9a08g045-pcie",
 		.data = &rzg3s_soc_data,
 	},
+	{
+		.compatible = "renesas,r9a08g046-pcie",
+		.data = &rzg3l_soc_data,
+	},
 	{
 		.compatible = "renesas,r9a09g047-pcie",
 		.data = &rzg3e_soc_data,
-- 
2.43.0

