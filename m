Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020089.outbound.protection.outlook.com [52.101.228.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC26384CCD;
	Thu, 15 Oct 2026 03:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035080; cv=fail; b=KouBkHBB9TT7mC0OU5bxvkPa7dQ9p5ABobm9R2ZcI24V13scjd07FT9pU0ABZhV0LDASCjB6+N8S5pywKDOHmhom2UF7RnvmyMkgne63i0jxZXL/d6vObbZvkwV0zu3x9PM6pgWqthYckS7HJxhZ4uTKaUaUhr2k3UT/a2oaY4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035080; c=relaxed/simple;
	bh=Ft/LCPivbK01WwpvH3NIpcWAma0mVIpFhrvpsVGg7qM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DEj26aA5Y5s2BhHgZC3hoOL6OiEb/D2RreTMFnsKhUFJcgYlRCibiKRVyCyPL99EX/qXfJbqe3Tc5Ac391hR1RHpsMk6f4MtxOd+N2Z2NXeySO3S2uH+x6tlyF5VloNK/LP9vHbr1VUI90RhO0+B10eg5kxsj7ifW7ppY1xTHHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=BOtT4fDN; arc=fail smtp.client-ip=52.101.228.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="BOtT4fDN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+Evx4VcT3kA4nFwBJ82woD/yNTbnzIzfsGr7nrZgYVbZfehYGz2s3Or2DuKEwoWGDG7LN5feHck0nqz1HaPIMJdX8IPXi4Xbi32FS7q5SWnvQ2skT6tBEdYXuQ2+8i/K0rp5Eqs+PtkXHAXH2g+VvAVjo77I3Br7y7OKbe4J3jI/aOdZEeuXr/lQ8KJ+IdXmvruewmOVol16wTBMWNTro42nT9yuO6EpK1CRLjoCSK/xWsG8oSNBsAKcHRNgsgxvexgSc0LCTxYQiZ5JNYCFVm4V74BVA1/MCB+vV1W+owoiCJyRGEQ2dMx4VFmGXveolPvJM+cTAnObtTMNZxqfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbKGCCmMaSE9Zjbgq38EOf9yj5AMxZ8Nrj9UYb9+c0w=;
 b=n3UU+S8WvDJx+Q3D2CYorhg7//0tIvPliQpSbD4NY9yneINpVbh2A3b+h+6UkRcel7+rJeekI3lMcLLDIlZBvdOPtuT67jyYYTkpRuapUMEzARlyUV353MCIKdn87mNq8SZBs3lUyy6Ffi50su8WwmX/joQp0tcczPmses/Fqdr7J/hfdSwe/J901mdrQnB+dvf0Mec9D9K2tMEakIke+VB4WJ2AgBfWgQOSf3Go0OdEkMgjp7CIkWn4+cUbk6pbhMlwemtbdFlb4Mv97EjkTzXdJD8SEcRVkM/gY0BKjVZ3RA1dXQUjV8hVW52ekY2wKqlKqTudR67fzY6Q3kub1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbKGCCmMaSE9Zjbgq38EOf9yj5AMxZ8Nrj9UYb9+c0w=;
 b=BOtT4fDN5tvkBzCJOBM+MFx/MjdO2YDHghad2XBLZo9kny/zd7E7ZOWZjQrbJ6LB3DEq8LUl1UZcq7GjnDRv9Am672Aasfo2lVgEvORiDE6/ky+bJEJ6fhri5b3oz1JoQoTzQ1rINGqRT5Nmc1iB0IaMPSOHVr/U3gEWChwcXsQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS3P286MB2044.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:193::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 03:31:15 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 03:31:15 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
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
Subject: [PATCH v4 06/18] PCI: rcar-gen4: Move deinitialization helpers before SoC initialization
Date: Thu, 15 Oct 2026 12:30:51 +0900
Message-ID: <20261015033103.3076869-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261015033103.3076869-1-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0082.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::9) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS3P286MB2044:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eb1e9e4-0567-4009-1df1-08df2a6cc445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016|23010399003|921020|56012099006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	1Wy1EIppW53LcLW72m2Nw07Jz4UhAYlHaAJsqChEODFAuhoGs+OOYfFZEgbJ2+oLvgKtgz333vqKrIFW+Q92a6vI9Mre2+KPcKpRvpd9p6ZYrgHTPnYhurz0NtRlGos/CZ6c5r0ner0L4If11B9BeOT8pJDrJRd/3X/eYDLTBE78pupBKJP6fbCoW8qVq4cl0DEAAgApVAUOL5sGMIIounqP+5af0qnhI5DaLDjZN4YyXr/259iKBUmlGAuqyu0Y4xq+a/tFXayL1ZJ2j/cxYUcc4emIBAGrVDIIc+Ni+B5QHt2ALNuvZz9SRPcmfW2cEtDPboON1dFZ4ZJxB3hr+35H6hKaFJJwWSm7vdFu9F/M3mIMSHDLSzB/Le1V6I6Xr7GCalV2uBbljiw3VB37rA6hJRrrlaiKL9ldvgPJYTNh/7eFKdonfSeWnIP+U4iliuLEpcyOk0ZmOnom80L+F7AyH/KYkG5TAmavQKVbXMnwdqONQOqR0liqpJac9JcajQrbYQYXUDXegtx3inCz5zAvA2fLQhZqdFIOhUR0aKdSjLWMp0T7PpBcHCpNjgq5XhWJraZtKVDFwGE6ftJ4pSSJQ6z8fkY8bBzuQBPy7SP3EoY8g5IPqi1kyD5znm2RZexWs6crv93VuOahgqsDkNXowXYde33Q6mVgR++6F1q5Scfa48LaV4j/AgH0632HCntI42KQB4uJ1LG17exDJg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(23010399003)(921020)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gu4dtkBk7nwdZnuaW94QNZwrxX6b7b3w+4gd5/ql1zAgpXQ6RTYTrjcFac78?=
 =?us-ascii?Q?kpr2bdTUwwgXtVkkxNQosd/ZqUBfnaF0Iv1HtZMydy6GkFlsO1VQNZzb8sao?=
 =?us-ascii?Q?fpdHz3mYmhRk05nsxg6kvc9+r976q4UJ7kptHdtA2zTPPpjNNqs2QagBTWSv?=
 =?us-ascii?Q?bU5jdlCrlKOGnmz5mz5sbRX8xiDactD6FFEQDkVU2IF14x8UnkIY6wmKG+uK?=
 =?us-ascii?Q?qwVre7tR0F2usg5pjNk+NDwhTZD52+IzKrujQVHwAkoP/XM3vusdVEb4j3Rm?=
 =?us-ascii?Q?0WwZbJwHO+FLoVOjLBH1CdDZd9wKKKMBLo3sfyswNvWio6tlneqXHoRVCouQ?=
 =?us-ascii?Q?ZIcy+3QlpLi1bC0c4+Fv3O+XE4x1n+P8VwiXSUygydf/ZQKxvkUT7tA/07ci?=
 =?us-ascii?Q?JJ7Ch8Yh1ysjYb34IyXYrFvSuCFlivBmCXaT1djtGbLaJOxCX/Olcfuk51If?=
 =?us-ascii?Q?jtcj2aCQxWwyKjmFGfGXyD/Qyo/C2GSt2DLkenJ+EtN7bsP3+el83L4UayDG?=
 =?us-ascii?Q?NPUgpVd7woBVHwiQ0OecKMwBK4Z99vjSysW59A/Unvz5HjROWfReS8ZhQ9gl?=
 =?us-ascii?Q?J/gVXcXRZvfOGaXfjbUy/W7RZWvoZmCek+EGnARr49NmVd4W6NiRrr9d2crI?=
 =?us-ascii?Q?HS4TwNGC1QRS970v5Qnk8obJlWUnUOeoaLxwJ1hEEAtwDm5utnvMMAkD4Qo+?=
 =?us-ascii?Q?9z9TwB9F54NDxVq7KgefR+zalvjXO5IeDq1EMjXZGq1YIabxk0WOvF/OVQlm?=
 =?us-ascii?Q?irO5iLerYJ+lqd2eQhEQ4PR5QkqH6LkJ4EPcpt7YvBU0f7ja9vlvRGHs2vy5?=
 =?us-ascii?Q?OcpDQhq/mXSW3DTrk6hD5Uam0N9tKttin6Lt1bUAVZNq6FGjyCO6QSIWq4L7?=
 =?us-ascii?Q?b1ofHr52MH8dqNGf6Cahmjd1zcBFZo7B3EYquL3Xmgrnp428GkYpNyA1ASul?=
 =?us-ascii?Q?9oGa+sMTWa08GfvKyHCEkkdHBoKMgd7SKcH+TGeipsJk4E+IJk6abxipOgYx?=
 =?us-ascii?Q?F2b7i1/jUy9DbQOAjbeXGS08tOwL2GJEJZbDCCDjCrOnD+EirSksGX4Ur2EF?=
 =?us-ascii?Q?T+InfLavXZO0DrwEWai89QyPeZ2BsX+dcOz+uXnSi118PblYHRRmfbimwVmg?=
 =?us-ascii?Q?qpTcC9czMhhDLnEwE7Vsl2cP8jtjMZt+jdyR0Im1ooMWaNGrtVVPRVdxWqmm?=
 =?us-ascii?Q?lbR9W8LuTYCJ52WZS4fEQ/foWpgCTKlvLprH9c6gPHjLI+dKl3lU0TOYhLNt?=
 =?us-ascii?Q?jJWH+MQrSXudY+DfII9n/raTa1XLWeu2IxNS9Uplkd01YfUPnQY4tqbmPZxC?=
 =?us-ascii?Q?sXEy2Sjk/IUFJyuOf5t/e8RZdewaIV2HlB0An9w1CDsaVyD6N/3KS9dwddgF?=
 =?us-ascii?Q?f/TzxieRsGjgjHt9oubQV3DKItuelqWLugWpxMe+ca3XHlGzFTlYTwNv/xwu?=
 =?us-ascii?Q?hjzpIM2Eo93g/gbVxJI7GElYHMf3NEgyGULgWyDPCH456+JM7DnLRlHP3a77?=
 =?us-ascii?Q?+nR1ayUn8SBADWF11T2qDSlCG/ImcZOeSQZ/6G6ah5Wjn23rpcXicaTbCom0?=
 =?us-ascii?Q?9ngd4qc2B0PwZV0bRnV2nLbgBYyL1MB1+//af3Mw3O8PPnI8dScbmvKm86Lg?=
 =?us-ascii?Q?2LAYjo6Xcx9ri4ptvg4W+A8jFkP4iJRT3leerfMBMoD6ICMWnEIDMUrvl6WO?=
 =?us-ascii?Q?T7VNmApcDT8axdbiklVSDTk2vbs0T82otAh16o9FuFmJmAQM7Mcf9ACil0Qt?=
 =?us-ascii?Q?kiWUSPUsMk7oNodHGCr15tfDsS04Jr2e26tcLR+4fXyiBNznGrCr?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb1e9e4-0567-4009-1df1-08df2a6cc445
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 03:31:14.8325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rua0HZGf6jMc6fuGd3Jp5jEU4W+9cg2z/2jxAreiRPQGANeDxGubGh29azq9h8PPFWndutbOdX9kljwmWqWM0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2044

Move common_deinit() next to common_init(), ahead of
rcar_gen5_pcie_init(), which will call it when PHY initialization fails.
Place rcar_gen5_pcie_deinit() before rcar_gen5_pcie_init() as well.

Keep these moves separate from the following initialization refactoring
to make that patch easier to review. The function bodies are unchanged.

No functional changes.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v3:
  - No changes.

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 30 ++++++++++-----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index b101ad7dbc31..0a845b67f6c1 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -301,6 +301,15 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
 	return ret;
 }
 
+static void rcar_gen4_pcie_common_deinit(struct rcar_gen4_pcie *rcar)
+{
+	struct dw_pcie *dw = &rcar->dw;
+
+	reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
+	reset_control_assert(dw->core_rsts[DW_PCIE_CORE_RST].rstc);
+	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
+}
+
 static int rcar_gen4_v4h_v4m_pcie_init(struct rcar_gen4_pcie *rcar)
 {
 	struct dw_pcie *dw = &rcar->dw;
@@ -326,6 +335,12 @@ static int rcar_gen4_v4h_v4m_pcie_init(struct rcar_gen4_pcie *rcar)
 	return 0;
 }
 
+static void rcar_gen5_pcie_deinit(struct rcar_gen4_pcie *rcar)
+{
+	phy_exit(rcar->phy);
+	rcar_gen4_pcie_common_deinit(rcar);
+}
+
 static int rcar_gen5_pcie_init(struct rcar_gen4_pcie *rcar)
 {
 	struct dw_pcie *dw = &rcar->dw;
@@ -369,21 +384,6 @@ static int rcar_gen5_pcie_init(struct rcar_gen4_pcie *rcar)
 	return ret;
 }
 
-static void rcar_gen4_pcie_common_deinit(struct rcar_gen4_pcie *rcar)
-{
-	struct dw_pcie *dw = &rcar->dw;
-
-	reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
-	reset_control_assert(dw->core_rsts[DW_PCIE_CORE_RST].rstc);
-	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
-}
-
-static void rcar_gen5_pcie_deinit(struct rcar_gen4_pcie *rcar)
-{
-	phy_exit(rcar->phy);
-	rcar_gen4_pcie_common_deinit(rcar);
-}
-
 static int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *rcar)
 {
 	struct device *dev = rcar->dw.dev;
-- 
2.54.0

