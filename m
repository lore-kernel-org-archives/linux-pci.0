Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013008.outbound.protection.outlook.com [40.107.162.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8B83090F7;
	Mon,  9 Feb 2026 08:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770625453; cv=fail; b=BL0iMsrpoKCZuKbBRrfW308VtKcDHbWv5CC/cIPMErq2Jm3HW2d6nr476seFv+F03zt1jUqPjVxWOYS6jtFmejrGf7icSSaz/p/1mO/1Imhfs4xnWhhrcSit0xq9RF2R74FWibGXzsAvFsH5BomVrES7M8lYf3GxZmlZAgWWst0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770625453; c=relaxed/simple;
	bh=WKzzJxNpStpMpwmTxQUos8wjAT1uxUgj6FMjKovF6FI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QMCefbt5WwjgZ0meGUYqaWYrVFTnqXzkaT07Ve9PbBLuLMiDe6Z3CA2ipm6hkXHG3/6Q34yTIaHOJjDmwKNFB9r1XKKKRlQldVK7O2xZ9L47eevH7qDxUAjY53Xy9e37xPascLCmQNoRH2wmp4SDcTeETasmM693dwl5GfNMTo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UZY9wGbB; arc=fail smtp.client-ip=40.107.162.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UZY9wGbB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWxfuEj3ucXSICUQBcG3yhkUPzTl847xNknOvyeNO+cvMJIexCPSf3kYp8N4D5Rp0YUBx3jQnvAH0MMCN8mTVYygbjXLUxI+7CQ2rTxJFelFruD7C9EG7KK30q5JyJyROshbfJvoKVALa47XqOQ41zVUvUCetWTwemmLLzUIalwyWNRh4P0YHtFwjNKGvbsvVtfpnniGv2U/kotw+QAOoNUhzO2qED45AGkkkUrtxB6bt68kBEC7a0LXTdo3TbOcLWDfJNH3FGcHZUVB1W8thUlgUTYAMfJWwRios8tEfyxTBTMtthJI359YDUj8dm+ivc0xnD4GYaNSxFpVFqoqnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2s6odGd2U/n4yPr1xH6VkYL/JCZkvSYjaJv+MnG0Tm8=;
 b=k/9jV0/ZPFh3M5/1WETBf/scjC/Va8cWvraM8J9iFtXXoarhF5GGwZW7UKzmfzQE7wE5GMZuF3kA3k4CBG1PzUvpbeFTPWVALkvR963671rmwoiVTSBwVqRUmM6QyXmjkewppjKn/+hWI9fWKU3nAoItSBZVJto/G1gFlJ5B9xrTPq3BlMmU8WbYmu8YwJ3v2LoCeVVO5AB3+b5hyCQ+Y/3JgTmoDlGVduVG11JpoE/Xb5lmnDQDxVDxKX1EVrJKXqHKwYSuDgEWK+rwQJrAncyNVJZE2ZQ04LKor591BWwroWzktQm3XMgKDYQGHJGGncz8ZIvnJju9kod3AZE6DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2s6odGd2U/n4yPr1xH6VkYL/JCZkvSYjaJv+MnG0Tm8=;
 b=UZY9wGbBCN87GtEvfILWGJFm+xXgsSmkFGUp8AmRtjtOWY6msr7zXNAY5Yk0GLCJrLFSOw7BuPRCZVmlYwH8SItVNoVWZjHqKXzYme7YCAPAt/M9zB3ot0RgFekepENcgdTe0IJavKobPo/02OzvI98b5KKieA0NrRbqe4+1pRxwjePiIcnl7s0APLGrRFNG3kNFIQhGPOp/FT8ZeZprhFC73MTE+bBEsKgOk7xvP2hfi/KzkVP3hEVN1cecSz8jO10giYfDZYgh65WgQ8Wk28lhXEAnLziff8WcPFtOiEyUfLsip/98eO01Kl0uk7Wi7F7e/kO4BcOh63FhCGYgrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GV2PR04MB11834.eurprd04.prod.outlook.com
 (2603:10a6:150:2d5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 08:24:07 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9587.010; Mon, 9 Feb 2026
 08:24:07 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	Frank.Li@nxp.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	will@kernel.org
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 03/11] PCI: imx6: Add support for parsing the reset property in new Root Port binding
Date: Mon,  9 Feb 2026 16:24:46 +0800
Message-Id: <20260209082454.2097628-4-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260209082454.2097628-1-sherry.sun@nxp.com>
References: <20260209082454.2097628-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|GV2PR04MB11834:EE_
X-MS-Office365-Filtering-Correlation-Id: 03924f87-addb-4815-0e13-08de67b497b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|7416014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f/9CE15YuQwB0KkAfVQ4jQNy+fWsNr0g/Ag5oT2Va7yAKjo55eZndhL11QQ/?=
 =?us-ascii?Q?RKY7YFnZfZDOP+q4xvzH9TsolMYjETEvZdelMdQ6fdiRDSgjB8q5yKv5zixj?=
 =?us-ascii?Q?Wj2hNsncNyhITv0YWwqylqOYHRv9n8dXjunN6+J0e4dUoI9EHmRoEsZLmsiH?=
 =?us-ascii?Q?EiceQWcyNVSvLzYbo0h1tb3UxG+ddV14R7izeVfTDjg6SVfFT9I6RKgcBVgk?=
 =?us-ascii?Q?qejeIS6aubMNxBX2suZvT5IyE8/CeAnqbyHHfYbCtu1lYb/kpdEBTArPWZVV?=
 =?us-ascii?Q?q2sm0YzoHlKCLv/CMW3yFrRUQC7t0c216c7CpHVbuspmI9f8LKa710Zikfq3?=
 =?us-ascii?Q?80DTkxDQyIUOPOt6f3rLNJNvgZF3aFvD03jP9r/tt/9UWMxigLCRqVmJdgC4?=
 =?us-ascii?Q?t7L5H5baJLrCPEkCFPrwbUdD68TdfLqTTRlNXgwrxhMLpsi2wN46ezZmGvn4?=
 =?us-ascii?Q?bpS0lrNYyxfo/WRMO2JHUbT4hrQOxcuU5o3N75L14Fy4oTgnU/bQK6tkRc5b?=
 =?us-ascii?Q?Nsvr/Db1L2sV2Z3ehXwiR0PHE1aUF5gcGAosmaJdWTO6qQjZPKtNAAn0DnsX?=
 =?us-ascii?Q?lYT5VM5bu2fHxotE/59U/qwGjRuigTKOswpKiDO0/8K0A28mRiBGB4zIazYm?=
 =?us-ascii?Q?D9xDU0phBHwZJS+Xee0Swr10+jKn3zRQaPQYse3h8i1+YtFBx9vjC+gihIMv?=
 =?us-ascii?Q?B3pJLd0iw2z3u8uvObRCUiT2W0nIiTglKrOaovXFAt6Nk/S9ToUxI6iNtmG3?=
 =?us-ascii?Q?3KHQ8NE/moDOnhw9Og/DDYq7iq38iJOLxyEyDLiekRNq+s0d8UDGLkHFQwZG?=
 =?us-ascii?Q?zvgn4mIWw+UTjeMIFAqm/OBG3ESTUVIurG2pwtTygHm5e94EUr4XY4YVkSJl?=
 =?us-ascii?Q?JYjGDZWC16o79QN+dOFvK3JSPFT3lY2jO0yp3aIFfsoO0Zmg7eG3nVWjpCZ8?=
 =?us-ascii?Q?vLXGq13WIrrCjJkMjVV7XykQUy+mgxgXdFAe2Q1wW0IBJTlpKVhc5RjxCHja?=
 =?us-ascii?Q?KnTzKUZwHyZNgI51KdLdKLo2n2jU0ZJMFbrdJpBPJOZ/OXTZhqjkugAZAjC0?=
 =?us-ascii?Q?eX22/1myQKRobPnEwb2y0Wwmhln4iqE/0+Y99uTUqiesNfDnzXkr7B8kADnj?=
 =?us-ascii?Q?iGCcnE9drmF3QnS1McHOZiSyqWZK3FNIX4hlso3fEy5XhLS7VURoL+t1BcwO?=
 =?us-ascii?Q?0r4g5IdfGK9/689CZxpZqp6Vb1gUWn5T87iaecGJa7ttjXkJMha/TgQxL4TM?=
 =?us-ascii?Q?FFv9g1/DwnYhMNe3pwWtZ6lmWrx96l6vrgwWuyHVWo6AdqkURNMTUtnlmaCs?=
 =?us-ascii?Q?JD1ubN0zSvh/Y062ACicSWkOinHBYGzNBzne2yWa+QK0OAYkzfuNXFl3pDqs?=
 =?us-ascii?Q?/5hoTYvWlq7r9AZwBVdwYu/Y6gSuW+8lDtGN0S0irdrMKaepqv390UTslT1d?=
 =?us-ascii?Q?fCtkIaUSAWHFQ9RamYlb20571/BVacdvTkDaOW6QZN22tEv7qfTlE3zZwAIs?=
 =?us-ascii?Q?Q4aDUzbUFRj8O6ArEYEf60qZ5mdCXs8ZBkigOqvtSAnU4qIRjVXWbKrGFik3?=
 =?us-ascii?Q?wNxr8/3S7DC2WGS0OF/vOzMnES2NLwsM/muzZM+5dCeQM6ztA3Qh0bs/9zIj?=
 =?us-ascii?Q?zy+yNgFfXV2oTkvY53w6tEk6rSbGawEVb5T8MLNYFal9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LOwcd/BlMfrBLreG+6VM8o+0gebLPp2OgLKP+2H53SMIak0wutsPSOj/kNAv?=
 =?us-ascii?Q?9dZbU+PAA1d3kfhTP2wDLpjYZBXseOzVJGdWhUIUq4dNnyu50PkHANG6RpkT?=
 =?us-ascii?Q?x8uUDdpXDGDRBPhOi4fXH4SD0ikWLYSEMzpnI5Fc8GJPDn+x8JsYgO+lZ1Yz?=
 =?us-ascii?Q?EN/ACobnF1yp8BAr9ydktWI63NvbfMIxv6VQcOQxp2IMrbx/fh5j93l39U1M?=
 =?us-ascii?Q?m01rOmkq9VgV5/9GSeoHS1iiJ9MXTergbDOqgPZAHLDPg55QFwyK6UiM+76H?=
 =?us-ascii?Q?4zdQ9NznZfLAbHGJYp7TGzyZTuCjUErKGuggtexa4tMSMv8JFy7A9NUvXNwJ?=
 =?us-ascii?Q?dwu+el6nYQdr2AHm1EGR+Kj/Zs+Ujf3TZznCjreUBQO07xa1oXTHL1N73EBQ?=
 =?us-ascii?Q?XM2HcXCqW4wfX7/UMsELWpvq0bPV56oFUcSvncJtTqDTgWg3h+m31rz/fP8P?=
 =?us-ascii?Q?Bc9fX6HuQ/oSai08wj+Jo0Z3E0qzZOH99Tx/a09hRg4ArKi+iM3bvIQcd3lj?=
 =?us-ascii?Q?s3fmQD6DQFuurrfD1T4Y34mERNrfgGUrSixhht9atAS2RHaVQfqiaeBzWT5H?=
 =?us-ascii?Q?ZbJjZQgrznJFMKrw7d7g3AFfVMHysXuXqGorDTn/tuXxUfqSuxc1p6EXpfHM?=
 =?us-ascii?Q?4ftUyVcp38DD2GVTmNXkqCu4EYDQHZuub9nydn3SuuaydKf48HJcodjfY9gk?=
 =?us-ascii?Q?qzDu9CNpfFse44IcTC8c/fgacF7WaXGIaKuuJel/xc06EfH7dw1DcoXVnIi4?=
 =?us-ascii?Q?favF0BlNWYeJzeE+nAbf43oN22vvolwZCr+GGZ3k3hoWflu5KJ/6Et259oHy?=
 =?us-ascii?Q?b4ojLhXNnDbPIYKTsFE8IMlDirK2idz6FIXfik6Dl62VgWmpK7yA5n4p/ihw?=
 =?us-ascii?Q?1a3KrIWdfzazPmeEi1NHvGKIXZ0SYNmanZP9NCgVMblzSX5X21DwrQAo+AA9?=
 =?us-ascii?Q?mG4s3AeUCKSh1JAi2AxBIxowCcilbUgn+9Fdbd2cwPZlw4jVoyNTqfjJ/nv3?=
 =?us-ascii?Q?jhg5YrXHYMTFgSyxmthhT6thw+KC+d2GeHPno5LEpmdq9ZdR9ml/ULsgi/fg?=
 =?us-ascii?Q?93axOUMSAoHUXkrAmb8UD8PIBe6lRFgN/ggDZ9Fl2b86fkAFNOBTXGCck8o8?=
 =?us-ascii?Q?Ydvndb4/eIqoPNVnLxD7BVZVbFq0GRO/Bn75UYuQUjPLXGlCyIjSSt+he3fz?=
 =?us-ascii?Q?RIUvFlDm30Fi8QrV/bwdzYDGk6pzQ0BB4FRqPVLUdXMl99MC1JxNpC/7cPzz?=
 =?us-ascii?Q?UeyYJUl21LHlbSfOJnB+tOvOCj6cLwOH0BiyoFIjRRyOtu3dv3RdfAB+/gGF?=
 =?us-ascii?Q?ME1mFoPV3ZiM+Smb1KBwqoFxd/iKCJqrlwexk1G3azjxhhLm+qgzQOB2YW1O?=
 =?us-ascii?Q?KQ9cGKl8uWnFqDI4Z8oIm8OpVDeIAtElSzx9pPmbCkkt82THcD/EKTt2u1GW?=
 =?us-ascii?Q?8R81LXSrLfzGBJ+Ti51Qh1TIxc5Z50VPOj2ZpmaM3gfKgoh6rNIa5/b61xI3?=
 =?us-ascii?Q?sPrpVSfHNkdqgx1w6pbpjchn/QiA1lyfKFKCrKUtN1FQn9v9F062uWlUOL5m?=
 =?us-ascii?Q?p6ipIY6EPQA4a0m0vtpTxXSAG1xLYnyL4AAVdeBae7LBK32x2RTw5htDRpvf?=
 =?us-ascii?Q?70yNPGOWdVoo+r7C+1dMjeLogrRnH/B/VlTeKfNCk8hdgH4OtrJtc8Pm4H6a?=
 =?us-ascii?Q?nB1jaRDtm6S0jGwvD+MiAhxYzgqvhv3FhvQH19DQX2vM45SAjithjzbY0AZT?=
 =?us-ascii?Q?hfRRV79Dkg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03924f87-addb-4815-0e13-08de67b497b9
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 08:24:07.1953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oVPDzNkfQdHLmuRU3B0lU8zTjsAYpiP4J9Km7JbKsxgRHgBychxpG4+5J9V39kznkb97CeJ6ynb/e5ZF8TqICg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11834

DT binding allows specifying 'reset' property in both host bridge and
Root Port nodes, but specifying in the host bridge node is marked as
deprecated. So add support for parsing the new binding that uses
'reset-gpios' property for PERST#.

The initial idea is to add the PCIe M.2 KeyE connector support and PCI
power control framework to the pcie-imx6 driver. Since the new
M.2/pwrctrl model is implemented based on Root Ports and requires the
pwrctrl driver to bind to a Root Port device, we need to introduce a
Root Port child node on i.MX boards that provide an M.2 connector.

To follow a more standardized DT structure, it also makes sense to move
the reset-gpios and wake-gpios properties into the Root Port node. These
signals logically belong to the Root Port rather than the host bridge,
and placing them there aligns with the new M.2/pwrctrl model.

To maintain DT backwards compatibility, fallback to the legacy method of
parsing the host bridge node if the reset property is not present in the
Root Port node.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 69 +++++++++++++++++++++------
 1 file changed, 55 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index a5b8d0b71677..317a969da96b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -34,6 +34,7 @@
 #include <linux/pm_runtime.h>
 
 #include "../../pci.h"
+#include "../pci-host-common.h"
 #include "pcie-designware.h"
 
 #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
@@ -150,8 +151,8 @@ struct imx_lut_data {
 
 struct imx_pcie {
 	struct dw_pcie		*pci;
-	struct gpio_desc	*reset_gpiod;
 	struct clk_bulk_data	*clks;
+	struct list_head	ports;
 	int			num_clks;
 	bool			supports_clkreq;
 	bool			enable_ext_refclk;
@@ -897,29 +898,34 @@ static int imx95_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 
 static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 {
+	struct pci_host_port *port;
+
 	reset_control_assert(imx_pcie->pciephy_reset);
 
 	if (imx_pcie->drvdata->core_reset)
 		imx_pcie->drvdata->core_reset(imx_pcie, true);
 
 	/* Some boards don't have PCIe reset GPIO. */
-	gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 1);
+	list_for_each_entry(port, &imx_pcie->ports, list)
+		gpiod_set_value_cansleep(port->reset, 1);
 }
 
 static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
 {
+	struct pci_host_port *port;
+
 	reset_control_deassert(imx_pcie->pciephy_reset);
 
 	if (imx_pcie->drvdata->core_reset)
 		imx_pcie->drvdata->core_reset(imx_pcie, false);
 
 	/* Some boards don't have PCIe reset GPIO. */
-	if (imx_pcie->reset_gpiod) {
-		msleep(100);
-		gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 0);
-		/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
-		msleep(100);
-	}
+	list_for_each_entry(port, &imx_pcie->ports, list)
+		if (port->reset) {
+			msleep(PCIE_T_PVPERL_MS);
+			gpiod_set_value_cansleep(port->reset, 0);
+			msleep(PCIE_RESET_CONFIG_WAIT_MS);
+		}
 
 	return 0;
 }
@@ -1642,6 +1648,27 @@ static const struct dev_pm_ops imx_pcie_pm_ops = {
 				  imx_pcie_resume_noirq)
 };
 
+static int imx_pcie_parse_legacy_binding(struct imx_pcie *pcie)
+{
+	struct device *dev = pcie->pci->dev;
+	struct pci_host_port *port;
+	struct gpio_desc *reset;
+
+	reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset))
+		return PTR_ERR(reset);
+
+	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	port->reset = reset;
+	INIT_LIST_HEAD(&port->list);
+	list_add_tail(&port->list, &pcie->ports);
+
+	return 0;
+}
+
 static int imx_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1660,6 +1687,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	if (!pci)
 		return -ENOMEM;
 
+	INIT_LIST_HEAD(&imx_pcie->ports);
+
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 
@@ -1688,12 +1717,24 @@ static int imx_pcie_probe(struct platform_device *pdev)
 			return PTR_ERR(imx_pcie->phy_base);
 	}
 
-	/* Fetch GPIOs */
-	imx_pcie->reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(imx_pcie->reset_gpiod))
-		return dev_err_probe(dev, PTR_ERR(imx_pcie->reset_gpiod),
-				     "unable to get reset gpio\n");
-	gpiod_set_consumer_name(imx_pcie->reset_gpiod, "PCIe reset");
+	ret = pci_host_common_parse_ports(dev, &imx_pcie->ports);
+	if (ret) {
+		if (ret != -ENOENT)
+			return dev_err_probe(dev, ret, "Failed to parse Root Port: %d\n", ret);
+
+		/*
+		 * In the case of properties not populated in Root Port node,
+		 * fallback to the legacy method of parsing the Host Bridge
+		 * node. This is to maintain DT backwards compatibility.
+		 */
+		ret = imx_pcie_parse_legacy_binding(imx_pcie);
+		if (ret)
+			return dev_err_probe(dev, ret, "Unable to get reset gpio: %d\n", ret);
+	}
+
+	ret = devm_add_action_or_reset(dev, pci_host_common_delete_ports, &imx_pcie->ports);
+	if (ret)
+		return ret;
 
 	/* Fetch clocks */
 	imx_pcie->num_clks = devm_clk_bulk_get_all(dev, &imx_pcie->clks);
-- 
2.37.1

