Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020111.outbound.protection.outlook.com [52.101.229.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719483F106C;
	Fri, 18 Sep 2026 03:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789701655; cv=fail; b=su78uRyEecTzIUe5g9nY0JZQ4BirZAy96bUg1xW6Gd/f7vzpK/Z/qH0Q/MRDr1dJ/wj0ioLl83r7DDhWLfHEJgrn/ilkjp1bIxF+wAeExW80gAac+UgUq5YaBmqjkJutqwZE9J6rMtwZoyQwQRhI0vp6J/fPTfv9Xc5M3o8KT2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789701655; c=relaxed/simple;
	bh=gJgf1I6gohWC5/B0x5E/rsx7OTDHL/aqOL9Fz4YZD9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RkMKgtj4FQOO3SYuBOMerkTfiruM7JOHkwQoUvwCbD1uotGFrDpYCVeQUmcO9ZnPX0jjXvUHGJrLFvjhgbyhLn2vSO2dTPDWGcItql24l+nEnwCX8u1zreJVske2JaqvkF2Jbk5t90bQ2qnDWpalTT5XRGjUM94dguFczSMibc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=uE5JAwEB; arc=fail smtp.client-ip=52.101.229.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="uE5JAwEB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9Iq9hMXHDfjfDTJlLLqlQrBscRWeepcykqGy1TWmcCPRH3CRkDudRU8p4nR7uN/D+8uqoj4eCZjUhb+9YRxlY6hFCy8vGGxwQ3YeKSyzF1ba7BPJk851GTli3cfOwK6YPyO6AueZsQmFG7X3YFoTkOcURvr8n4+2TyGQeCjADIufBAkFmgBBbImpuDZuUb13B6/pMr3/MAiK70/O53URTVr9au8KBt0GRAV5gU8xaxvgDLfFN5+D1SufgK2BOU/KzBJl4N9oVMaOp0d4/QGxg5HkA2JxZnv2NH1VUfq9Is+5r5t23+fbp7iw7ah3LMwNi7c9XV7zrqLfAWH1z6v1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6gIt8Vxbecp3Q8hHpCg6BUp9cwUj+OHKXQAFoa10e8=;
 b=TtRFHZRBgWw7sUk4fMcdReTpjoa9laIZ/VS4yOEmGc5wxlUZlSx33/O6ekNePUfh8q4/uoDyKfh1HsrVRcYR8vIvQsHo0yfm1OxRJghS2m1DoKmTT+BrYtLaGlj2cxsZcBwOySkKYaBYc9OmLpGuVpklfrmrk9OozgBL4BJbCb8Rf7DtL173rBn7O076y8kUtB9mihLgesxIp1+mxcATmtR8K47SNvtnurVUOiJlY491W9/QgvBcupR5nt4Vw6xwJ7cbMeLnDWZg28MpFU6vDE4mAYYmPdad5S9Bp0eG1P/9MIPX0OX7DY1dpcj1Aal4JonZ4zCMfFyCPL7xwOGOBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6gIt8Vxbecp3Q8hHpCg6BUp9cwUj+OHKXQAFoa10e8=;
 b=uE5JAwEBi6whhY73y6i/7IgvjL8JlnzzH4jBjauswsKlUhpheuo4o5ZpglitO1QP+E+4Qu43gfk/MZ+qgDuL3Ckf58is/beaAcaBS03hvqGfkBDQTz5TJ9nFOYpOkBp/UithAuienuZhrLDHL5aYLE3KAMzCL+0DSz8hV+z6+vo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB5141.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:350::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 03:20:48 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 03:20:48 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] PCI: rcar-gen4: Split reusable hardware initialization
Date: Fri, 18 Sep 2026 12:20:32 +0900
Message-ID: <20260918032038.2216471-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260918032038.2216471-1-den@valinux.co.jp>
References: <20260918032038.2216471-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0120.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::20) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: 705c9779-d05f-4f34-9daa-08df1533d57c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|1800799024|7416014|366016|56012099006|6133799003|5023799004|10067099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	JIhcpigE4kzPZamgJtd0yyPCXIuZ3Yg7KXIVPQeEgIZ7yTNnda1KQ8teiiZipYUXseYGnEKqF4oBX3nHT+YDAWyE6GqrzsBGb4/z0nnGiPm4eGHHFF20j/fPa92rTBb+T7vyC0d+uDl9Rfl72yHJ079DmF5L9vwLOkJ+lRQKEtLjlnUOfR9NG2q2Egy7Co5+Q38JCTskqpmaU7yHW/CpTYfpjiGN79xbLid1QCPCzVEhmcYSOLTP0v7SCyjMEA/KsFogmgZZttV7wRYlgZJJrLCx20LonLMd2pzG1iknwFmMJGe08D2lzB0rrj3UXjbZV6JMxQRra9EyBmGP8RRiXvki5gjinMzHo3gBEF5sjqGvY/7oFmkSd5vmXRB9vXk+MSKv41Og3M2NHN7ey8im/UdsLHYQMMXsXR56Rx/dGyNIrO9RO9Us14Y4O3B+sVwjKk/+9Nt7+xJaAPOavq4jpw2woh2gLFCD2EzAHX7KOaHnUajXXPo3XlT0LnVTBMly8OZg1UIyvw3VpB741XzMLSje4vbDptNV91ZUiFMHLYPgVX0wvARXBBlU8sPkUqIOTciWsNwkRyFQ/x2c+VpAQXgfK+weKhzr6i0ggweIbQ9O/gc5FKUfbfloyCK8gnYIAgKs2NFE1KleuLZJiMwmcCXhAhb4xn2hAT9GZdg/AmvZWBQUZVFt/+dzqyh1gQkq2GSCMxLUK3WF8UrxiM16cA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(1800799024)(7416014)(366016)(56012099006)(6133799003)(5023799004)(10067099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uPRJid1ItwCYVygH8JduFf9r1c4P7U13zypxxKB1djQJylyOzARzduc/AodA?=
 =?us-ascii?Q?FYd+foIlXrfS5wTFpZ/p8JrcgBRDHtRTltAP6SXMFxl59r8H246z80rS7659?=
 =?us-ascii?Q?pcAv3dSL0TPNIvkEQwvbB95bJmMdLeL0HI/58wU3Rh0eee8JOcNuQhEz51vX?=
 =?us-ascii?Q?6CHLtnL/PI5Z90iFZFPtW23KxgtOx+bSuHdujI+ma0oulVLAjbR86zbZnIJ2?=
 =?us-ascii?Q?1WZkhsQQhF+wTM6vnh3PIhTw87QpvXEkYDvDyQBB2PdofxjvzVQxRWRpRKGn?=
 =?us-ascii?Q?4QfeSjbXUzaae3SR4OU0MkSLX2WJC1q/KXd57/mHImw0m3qCzB7UaRGRfTVM?=
 =?us-ascii?Q?QnRmhGqqw8/fYz4eRJliUOc9+Dk4u1ZTC9k5O5fUO3xVcWaqbVVgNw1P5MSV?=
 =?us-ascii?Q?TTM00pwsUcbI5AIvNOFzzG2Z+f+IfAgCKUKhtFygChqOcLkP3CMpOWQ3yXyr?=
 =?us-ascii?Q?D3y6W+a+pwqJFiXXGLBXgX2rF66/Xx28h9qhJOkKonWlCq1J/yIMJIQWUJ17?=
 =?us-ascii?Q?TG1vIL963mc8hMI27cvAxwjmgiGRiBQZrA6Al0xoO+mF9m2sUS5fBnmVNoG/?=
 =?us-ascii?Q?IFffRAI75aPfulSFTgFub9mJZuGDy2poHbgTYDkAeAQtFwndKMOSSNv3fsZj?=
 =?us-ascii?Q?PDJbDM0ovoAModH0jiOw3OWIZoL0tyC0ighKOBVPfQe8F9oMAptUJpPGhHyA?=
 =?us-ascii?Q?S6GQWP7gKZ5NJFfE3jTvBdGU0T03w7NXULY8zD/2nC/6nle7cjxnBVTpznyv?=
 =?us-ascii?Q?FuELDemZFXi44UIzI2l6NmFgGr0veIr/o8HVtD9SYR5Hh6sBxdsfH5s1sxkC?=
 =?us-ascii?Q?YfFM4sOp62zqbC/vRWZv7sVH/TayrmvjrxBkZoT1B/9BufnruWwj+TH0BNvo?=
 =?us-ascii?Q?UsiUXvXcKZ15dC3N9ZPqZVc5hFqs9lXHxPZRdexVlM1SkMDcdeJxofoKWh3b?=
 =?us-ascii?Q?B5hWY3L+x4nVIuI4gScu0enWJ4BKTNCYRtE25BayahfWJy5hY5/KrePJLLuK?=
 =?us-ascii?Q?c2u0ZIAFOTMFPTKchOu+YZClnwD0sc2tCZBTl/f+eOfNKNHDBHZCtnXb/7XR?=
 =?us-ascii?Q?zc33jcASfwds29Idsh0DJHKkvsdZyP966r5Tv0RJHG/tAlCZID0gjVRTt771?=
 =?us-ascii?Q?dGwGUxv/bry9q4eVv6CvHBOZ3DqT/KJidvgtdNXfhAZquTchWiTif7e9jXtX?=
 =?us-ascii?Q?iwToFEiT1zEhOnGK1weWDtB6KjumR546JPE9AXR3UT3CtFjXikwSToo7W0pg?=
 =?us-ascii?Q?3oEpRcq7qyAhged2V6NhZHZHpQlrVEibCPlN40Q8XwpbyvanmGgD5oE9HrO5?=
 =?us-ascii?Q?ey4d/Hu/1BV9PJROjZWymfSZzz5zhFL6P5XWamd84YsYO85do1PIo1Qod3IS?=
 =?us-ascii?Q?BkdX2Y/iF3RNJsSg0LBu2L6ZpSZlnYAmYveS8jCpmnCo7Lxra/is/X+cf4zL?=
 =?us-ascii?Q?pULjmDQ4TGdnaCOhomdBIyTJ2mvJNtOjIzjnKxZFARApocuKFvo0WxsK2lLU?=
 =?us-ascii?Q?6M2fQdSMAojb28K0azQu7rRn5+oCLHBXz/QXVxj3CAgpl927gj/mMdHKsiSN?=
 =?us-ascii?Q?rRf1lxggU5jHH6wwBwQcHOUoLc/tbHbTFUXJ1BnhFGb8fDyr77UDAoEFbCKE?=
 =?us-ascii?Q?L5AOqP7ULnKRfFd8QiLsdL0LllZ2t0KjQxPqRT3beLiUM5cZvRBtoEUqlsYb?=
 =?us-ascii?Q?v3DuZN9B+JzknPUAH/QddC7z3mHokr/XMu21ekXwpqDvjsCdrbypXroxpM8f?=
 =?us-ascii?Q?sg30slmzZMii2igPl9E+DweUZD9prv5KctefrsAjlq+Dxss0qIBy?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 705c9779-d05f-4f34-9daa-08df1533d57c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 03:20:48.0054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8aKJ4WBceGr4XO+PWd5DQlLIqneDHUMi30bUctTRQqVpdfIemSWyv/3NVBc8GDjQta0MPP6pXJegSZXcE2MJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5141

Prepare for Root Port recovery, which is going to reset and reinitialize
the controller with the same sequence probe uses, minus the steps that
must only run once.

Move clock enabling out of rcar_gen4_pcie_common_init() into
rcar_gen4_pcie_clk_enable(), so the power reset and mode setup in
common_init() can be re-run with the clocks already on. Gating the
clocks as well would add nothing: the "pwr" reset is the controller's
cold reset (power_up_rst_n) and resets all PCIEC registers by itself.

Split rcar_gen4_pcie_host_init() into rcar_gen4_pcie_host_hw_init(),
the part Root Port reset will reuse, and a probe-only wrapper.

The power reset is now asserted unconditionally, since recovery calls
common_init() with the controller running. At probe the block is
usually held in reset already, so this only adds a 1 ms wait there.

Propagate reset-controller errors while at it.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 88 +++++++++++++--------
 1 file changed, 57 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index fe1f1940e809..8a85f5f45cda 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -178,23 +178,18 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
 	u32 val;
 	int ret;
 
-	ret = clk_bulk_prepare_enable(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
-	if (ret) {
-		dev_err(dw->dev, "Enabling core clocks failed\n");
+	ret = reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
+	if (ret)
 		return ret;
-	}
 
-	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc)) {
-		reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
-		/*
-		 * R-Car V4H Reference Manual R19UH0186EJ0130 Rev.1.30 Apr.
-		 * 21, 2025 page 585 Figure 9.3.2 Software Reset flow (B)
-		 * indicates that for peripherals in HSC domain, after
-		 * reset has been asserted by writing a matching reset bit
-		 * into register SRCR, it is mandatory to wait 1ms.
-		 */
-		fsleep(1000);
-	}
+	/*
+	 * R-Car V4H Reference Manual R19UH0186EJ0130 Rev.1.30 Apr.
+	 * 21, 2025 page 585 Figure 9.3.2 Software Reset flow (B)
+	 * indicates that for peripherals in HSC domain, after
+	 * reset has been asserted by writing a matching reset bit
+	 * into register SRCR, it is mandatory to wait 1ms.
+	 */
+	fsleep(1000);
 
 	val = readl(rcar->base + PCIEMSR0);
 	if (rcar->drvdata->mode == DW_PCIE_RC_TYPE) {
@@ -202,8 +197,7 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
 	} else if (rcar->drvdata->mode == DW_PCIE_EP_TYPE) {
 		val |= DEVICE_TYPE_EP;
 	} else {
-		ret = -EINVAL;
-		goto err_unprepare;
+		return -EINVAL;
 	}
 
 	if (dw->num_lanes < 4)
@@ -213,7 +207,7 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
 
 	ret = reset_control_deassert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
 	if (ret)
-		goto err_unprepare;
+		return ret;
 
 	/*
 	 * Assure the reset is latched and the core is ready for DBI access.
@@ -225,18 +219,16 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
 	 * synchronous one, and wait a little over 1ms to add additional
 	 * safety margin.
 	 */
-	reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
+	ret = reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
+	if (ret < 0)
+		return ret;
+
 	fsleep(1000);
 
 	if (rcar->drvdata->additional_common_init)
 		rcar->drvdata->additional_common_init(rcar);
 
 	return 0;
-
-err_unprepare:
-	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
-
-	return ret;
 }
 
 static void rcar_gen4_pcie_common_deinit(struct rcar_gen4_pcie *rcar)
@@ -247,6 +239,18 @@ static void rcar_gen4_pcie_common_deinit(struct rcar_gen4_pcie *rcar)
 	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
 }
 
+static int rcar_gen4_pcie_clk_enable(struct rcar_gen4_pcie *rcar)
+{
+	struct dw_pcie *dw = &rcar->dw;
+	int ret;
+
+	ret = clk_bulk_prepare_enable(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
+	if (ret)
+		dev_err(dw->dev, "Enabling core clocks failed\n");
+
+	return ret;
+}
+
 static int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *rcar)
 {
 	struct device *dev = rcar->dw.dev;
@@ -449,15 +453,12 @@ static int rcar_gen4_pcie_enable_device(struct pci_host_bridge *bridge,
 }
 
 /* Host mode */
-static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
+static int rcar_gen4_pcie_host_hw_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 	int ret;
 
-	if (pp->bridge)
-		pp->bridge->enable_device = rcar_gen4_pcie_enable_device;
-
 	gpiod_set_value_cansleep(dw->pe_rst, 1);
 
 	ret = rcar_gen4_pcie_common_init(rcar);
@@ -475,13 +476,32 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 
 	ret = rcar_gen4_pcie_host_msi_init(pp);
 	if (ret)
-		goto err;
+		return ret;
 
 	msleep(PCIE_T_PVPERL_MS);	/* pe_rst requires 100msec delay */
-
 	gpiod_set_value_cansleep(dw->pe_rst, 0);
 
 	return 0;
+}
+
+static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
+	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
+	int ret;
+
+	if (pp->bridge)
+		pp->bridge->enable_device = rcar_gen4_pcie_enable_device;
+
+	ret = rcar_gen4_pcie_clk_enable(rcar);
+	if (ret)
+		return ret;
+
+	ret = rcar_gen4_pcie_host_hw_init(pp);
+	if (ret)
+		goto err;
+
+	return 0;
 
 err:
 	rcar_gen4_pcie_common_deinit(rcar);
@@ -529,10 +549,16 @@ static int rcar_gen4_pcie_ep_pre_init(struct dw_pcie_ep *ep)
 
 	writel(0, rcar->base + PCIEDMAINTSTSEN);
 
-	ret = rcar_gen4_pcie_common_init(rcar);
+	ret = rcar_gen4_pcie_clk_enable(rcar);
 	if (ret)
 		return ret;
 
+	ret = rcar_gen4_pcie_common_init(rcar);
+	if (ret) {
+		rcar_gen4_pcie_common_deinit(rcar);
+		return ret;
+	}
+
 	writel(PCIEDMAINTSTSEN_INIT, rcar->base + PCIEDMAINTSTSEN);
 
 	return 0;
-- 
2.51.0

