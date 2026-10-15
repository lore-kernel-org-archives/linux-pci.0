Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021109.outbound.protection.outlook.com [40.107.74.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD3337E5D1;
	Thu, 15 Oct 2026 03:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035089; cv=fail; b=faEbZ77HJWJgsPDFvRsZwiwKcR1sMP0GGaPc9TFr7/pRMvlJsSXWeJRLJ3eY+NKldB/nPZ1M1GFE+y04tdku2EiE+y6oMHS0+61q9Bw14e/z3mLbIKJMmBYstqjy6siEswV08HfzRqD4PjSDTwMCA5og8t7iAtpmDGchgplwdtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035089; c=relaxed/simple;
	bh=1Bb6EjbX5pB3990dK463O9NRHEumsQ+TUjuK5GJ4ID0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h/ENYzYqlBsT+zaWklQSPHnNhsGdDUaWzTx1f8DvgMtNGTUcyOJy+WRIJbd5JUppCax9r6zKJMEuVIRn2Erjbqy0v5ZtNH1cdutb4gkiHruXRHvOUo1FPbVdYmSMEgdCSTZ5Z8QsTpQgcyGSQSUG7OfGSA7gvL2xGSH+D4pj2kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=lbb5ghDb; arc=fail smtp.client-ip=40.107.74.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="lbb5ghDb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqHCKzcWAKaTWXkryF9gVnNgPZfycuNe1c1IQydSktyMNE0Aw3uFmckwoHqvDTaUZq3qgDS/sE+OHE478yZxk89FYcara/EAYUIoJ5KdN0uWrZBTlGDDQeSzfbxTjMwy9UfLdvI83RNUMnA7No7nzvftKivjst7d85Kq1EH3L8WWAwftvdMA86KAYoxgjVWwcMU4uaKnV2OyjKi7OjckIv94F9SfG2H2PdytvgPpgKRFL4Z5EONv2FfS77rPb6SPbBSReM3n5uFfJ4GlO27IcxaIdJ39RQ9xMlpXFNPxvqjmMixMXl4thOfziNWaKXpfaNWB08WdKRjDLucCVTq4xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBQ2+cd/Sc0JBvFn62FPMVIY4EunTzvNHmDShzl+Z0A=;
 b=eNSs2c/ZK90covK5XMDtGqaWdpjki1trAnFHeCaAuW/s65xkVnEoAmF0WkTRsmqDoe431ACVQwsMcbLEXxxZiR4rBUVapBegD9PAswZme4ZLbJ4j8pM0R+OtbyU9D4a4Il/7zOqxxMXluZCv5OVZoEHtxVf0BMVf9GVRlJRXtygR19tTjxdEKLdX5uSpywpcyvAqbWuUVs3rVk+bANpXTceHj/Ez++jKw+++Sw6r7nal8h+Guj+1DAfjgrSjDLJKBOkq1P0YlYkBBW6jZj2gelgp9Z9TcwH8E0XHQBvx2XuhW9AqJ9G2/vV6UGP4mf9WhLmXS4a5CGP+GLmVTMtK3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBQ2+cd/Sc0JBvFn62FPMVIY4EunTzvNHmDShzl+Z0A=;
 b=lbb5ghDbJ+p/F5zwyB+l1ed+wGdAQMUtn2bcBQHaVlTWPgtQewH0MmrhTXcBZebn7xeWkVfmJpabLtMWYHe2ysl0mMMHOS3BfLBOU7J2t+GRh6fXDcCvPOPRObbUqEeWrZFuc/6ixffQrV0aHLz90Z1dw0IJfOuUQyb+4EcJyY8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYWP286MB2699.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 03:31:17 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 03:31:16 +0000
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
Subject: [PATCH v4 08/18] PCI: rcar-gen4: Separate hardware setup from resource acquisition
Date: Thu, 15 Oct 2026 12:30:53 +0900
Message-ID: <20261015033103.3076869-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261015033103.3076869-1-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0028.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::15) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYWP286MB2699:EE_
X-MS-Office365-Filtering-Correlation-Id: 6955c28a-6ed1-43d5-5553-08df2a6cc558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|7416014|366016|376014|6133799003|10067099003|22082099003|18002099003|921020|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	EAA5KirU9WzFp9T0QM9RVpdgTVUlIZjuWLNcNrxBaulRmpbhp6T62yPrSqlIXfUES9vruTPML7VQ85hSBGzbpFV1OKIC6yd0yLLd4efJWKfk4gwoyWeIALsEWG+/GKQH5gFphx2EUAreUmsAzpMqAhENmZ0NhzrFU8qHOYtETscLU80tpLqgmDJH6ljYg1xiuv8H/e3MqViiPqso67BcuVYcOGPC5ZnnwRxcH9AaXPqrcU6YAoGHb9ENY/0bgu6otRJBzfmpSchKcdzHlJmDMBqJRBdA1cfMfXhgRdc3RVFQIfdL87dLr80bumeFt4Wkof/xCHYQptYSX7DQLCuM8TVGQeCkeMa7YXWBEYBkm23whpvYlaZD/HS3cgszT6aId9WvIfSGFuTs88mCfWop3Yk4k8VuP/3XHfisfHs/arCzul1PA8fsJCtVwXYaVBFLZ0l51xqPFOP64FzAKIZPpjv4NviEbN2kAX/bZITdeq9FCdVCnjFWWt4mVEjuXvAoxmh0DlrXrCT284UPBiOsdOy51KDM4qlUByuLD8HxIvYhgYU7z3lO0UB0u+J5cGXLKmbyhHjOX/ZujZ5UXS0dw0Rtw/czGdZy6dty+QD8C8D7Pk8lA3Ml/O2yYWb8Rr0xHiVJAF+v//s6LyLfysbbrqPIw5OWUVb3u6x+RjErpdo6YNo4XnLegsKfi5INwcXRakwcWeUXzHQeLklbH+7TKg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(7416014)(366016)(376014)(6133799003)(10067099003)(22082099003)(18002099003)(921020)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QJVrfF+VpCqs0KgA2U1d0YtVTFShDrvEmTd3yP9qoSuM1PoanvgNc0wCPhO1?=
 =?us-ascii?Q?KyE9z0zU7sIWtSkQjnH8o5tNOG+1gk/XH/FxYlwusykJUphjYfll/pdXyzAo?=
 =?us-ascii?Q?zvv1sp8w+4btk0zAn/3pah1eht/CScIRa//2J+8sBIdhbgNf4xpiLPdoLRMv?=
 =?us-ascii?Q?L1THURm4v4/hOPshps1NIWrXVDjcuYovtjcSTNvL5K1m5gHrVXLsz0Mm9xwY?=
 =?us-ascii?Q?N7ZEz3R5xEN8h87mljYZUQgBusS+UfWeIYjOvootBtXUZJow5WbttfRk99Qb?=
 =?us-ascii?Q?W8eVfURKJ/7wjYz0a1tRsnyCM97OBpUemgi9bX4o/RYlHc5vDBeHl2BZtyyc?=
 =?us-ascii?Q?C1EIb318artNNicLBd6w2klRugKx/jEQCK9T9Ogv6yXrUpSnZat40xqjduv7?=
 =?us-ascii?Q?DItY72Bliz+ZSk2/Wq4beshZF08ZFk5ACKItIVVf642c5Uh5N/2cXgv2mHph?=
 =?us-ascii?Q?kcrDMUpaQigHe5aX/xkxEKgOsmQbylZx6H05zZ2fht69Jy8WVgpdEZphXiI0?=
 =?us-ascii?Q?sLTT7tkp8F2fhF+CQS9j1rWpLkWBdpnIzhZhgyKk8PU+ElPxWU6SHszTsJTC?=
 =?us-ascii?Q?t7txWrsYQ1ddxDIj7vdioc8wTKo6atlhXwlPvmqFpQEPI0lfkcb7Mkt8Zob5?=
 =?us-ascii?Q?QItN1vSwkmazImDTWbQqhsEAGAcjOuVTvP9pSML1qEGK2gGqHUKYDqkLLqB5?=
 =?us-ascii?Q?o6O15RudPhK02EfZ+qy7smHHpeZBqNSFT3oyBEShNGaWYBlL1TyOj1m8FNaD?=
 =?us-ascii?Q?XwQUm7+s3aczdPZy4YcjnhwmW7iT9j9Oa2/bVm114UYqqo+ujaNDleZ+82cb?=
 =?us-ascii?Q?AHI3pn5lOWqfRn9SOx4C+yK5qSudbT1vDtJ0b6zWNZIs9xFkHiumszcV1F5H?=
 =?us-ascii?Q?HNrxk6fFUaAQGt5eUxa58vf/pJ2MWp43fFGQ3bL8jaNz2gkeFARW7TT42O0e?=
 =?us-ascii?Q?119gN4x2xTM/RovwLAlPEAhheuRHx3txTcE6cWL0aexqNa6Mt7eLgdQixs9R?=
 =?us-ascii?Q?jUXTbKI/a24Ou2BNf1Pm2S9MsmKmZNkJ3JN8os0U9C/lN5tqoe3LO9MBPMCD?=
 =?us-ascii?Q?8SDtGxBTC6DsqDayv9nQs/QYRkl4SkK+B2pa0qS58LqptHh4ZPyKGuT8NtKC?=
 =?us-ascii?Q?N8noESvHR5hD3djzU9EUd378ae96HkK+Cl4VgQiiOdUozaS9d0y2Q60mQvAs?=
 =?us-ascii?Q?ljW1Tvenp3ZjE76XndcvVvOt4OYAY4PCJ1QhZ0e7BPQCmMjtGJGAo/tsRIfY?=
 =?us-ascii?Q?0iPncTvRngmIT0My5gF6dTxroJhoN0avDx4JrtcCa9Vlsql1uxkiqHCgsIGu?=
 =?us-ascii?Q?ciTSRFl70tb1OjNABQqPz3BAEmnxos7KKcKJpudV3R0ks/VeSz96Ynd7BLbp?=
 =?us-ascii?Q?o9TEFjALI0QTF3u8AEEdvcZC4/cqY55e4Sldw/ruFhzM4/W86rODN3RzypK3?=
 =?us-ascii?Q?Y0HRJ6cg/peFKvJtFHvESeSQNEdTJtBoRNkVx0U1Vgym9f+aE7E4A9L0D5Gy?=
 =?us-ascii?Q?NjNOzz7L87VYvlVqjnDasbtrqBqyLEhLStuq1v4GFIz7AmHHTsrRGUu3R8+A?=
 =?us-ascii?Q?tGWjU6TcARmUFRt+5VnTuAJU8ILs1l1zyhenqTtDU3/6gXR/Dvw824YDxKvh?=
 =?us-ascii?Q?S6bYonXWBtRwMtqsgVIrEL97aMC9wN0utpMQ53S85jIfsX/VmRQ4yXLcdv+9?=
 =?us-ascii?Q?UEAjnuIbdQ426QbfsitPJ57WP9g9tX17b+7OpTDsih9GNeq+Yq0YKMppeWf8?=
 =?us-ascii?Q?VNOrvCR/ugiIRs5zUpf6vTHhf53AyWsg1EsDX8ZkDNzjXFKjs+cx?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6955c28a-6ed1-43d5-5553-08df2a6cc558
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 03:31:16.6637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lf+BHw79tYtEKfyL+C2k9KoMcxUoyM9CiZBt/s2spPltmX5/kFfXk+RNWP6+J/0+cIhL/ssIHbdrFRutr5uIZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2699

Factor out the hardware setup needed by Root Port recovery into helpers.
Recovery needs to reset and restore the controller while keeping its
clocks enabled and the R-Car Gen5 SoC PHY initialized.

- From rcar_gen4_pcie_common_init(), extract the power reset and mode
  setup. Leave clock enabling and Application/Local reset control in
  common_init(), so recovery can keep the APP registers accessible.

- From rcar_gen4_v4h_v4m_pcie_init() and rcar_gen5_pcie_init(), extract
  the SoC-specific register setup. This allows recovery to restore those
  settings without taking another clock or PHY initialization reference.

- From rcar_gen4_pcie_host_init(), extract the Root Port register setup
  and PERST# release. Both paths need this host-specific sequence after
  the per-SoC initialization or reset.

No functional changes.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v3:
  - No changes.

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 125 ++++++++++++--------
 1 file changed, 77 insertions(+), 48 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index e1b748a9d58b..cbd22e6bb44b 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -234,20 +234,13 @@ static void rcar_gen4_pcie_stop_link(struct dw_pcie *dw)
 		rcar->drvdata->ltssm_control(rcar, false);
 }
 
-static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
+/* Clocks must be enabled and the Application/Local reset deasserted. */
+static int rcar_gen4_pcie_reset(struct rcar_gen4_pcie *rcar)
 {
 	struct dw_pcie *dw = &rcar->dw;
 	u32 val;
 	int ret;
 
-	ret = clk_bulk_prepare_enable(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
-	if (ret) {
-		dev_err(dw->dev, "Enabling core clocks failed\n");
-		return ret;
-	}
-
-	reset_control_deassert(dw->core_rsts[DW_PCIE_CORE_RST].rstc);
-
 	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc)) {
 		reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
 		/*
@@ -266,8 +259,7 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
 	} else if (rcar->drvdata->mode == DW_PCIE_EP_TYPE) {
 		val |= DEVICE_TYPE_EP;
 	} else {
-		ret = -EINVAL;
-		goto err_unprepare;
+		return -EINVAL;
 	}
 
 	if (dw->num_lanes < 4)
@@ -277,7 +269,7 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
 
 	ret = reset_control_deassert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
 	if (ret)
-		goto err_unprepare;
+		return ret;
 
 	/*
 	 * Assure the reset is latched and the core is ready for DBI access.
@@ -293,6 +285,26 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
 	fsleep(1000);
 
 	return 0;
+}
+
+static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
+{
+	struct dw_pcie *dw = &rcar->dw;
+	int ret;
+
+	ret = clk_bulk_prepare_enable(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
+	if (ret) {
+		dev_err(dw->dev, "Enabling core clocks failed\n");
+		return ret;
+	}
+
+	reset_control_deassert(dw->core_rsts[DW_PCIE_CORE_RST].rstc);
+
+	ret = rcar_gen4_pcie_reset(rcar);
+	if (ret)
+		goto err_unprepare;
+
+	return 0;
 
 err_unprepare:
 	reset_control_assert(dw->core_rsts[DW_PCIE_CORE_RST].rstc);
@@ -310,16 +322,10 @@ static void rcar_gen4_pcie_common_deinit(struct rcar_gen4_pcie *rcar)
 	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
 }
 
-static int rcar_gen4_v4h_v4m_pcie_init(struct rcar_gen4_pcie *rcar)
+static void rcar_gen4_v4h_v4m_pcie_configure(struct rcar_gen4_pcie *rcar)
 {
 	struct dw_pcie *dw = &rcar->dw;
 	u32 val;
-	int ret;
-
-	/* R-Car Gen4 common initialization. */
-	ret = rcar_gen4_pcie_common_init(rcar);
-	if (ret)
-		return ret;
 
 	/* R-Car V4H and V4M specific additional initialization. */
 	val = dw_pcie_readl_dbi(dw, PORT_LANE_SKEW);
@@ -331,6 +337,17 @@ static int rcar_gen4_v4h_v4m_pcie_init(struct rcar_gen4_pcie *rcar)
 	val = readl(rcar->base + PCIEPWRMNGCTRL);
 	val |= APP_CLK_REQ_N | APP_CLK_PM_EN;
 	writel(val, rcar->base + PCIEPWRMNGCTRL);
+}
+
+static int rcar_gen4_v4h_v4m_pcie_init(struct rcar_gen4_pcie *rcar)
+{
+	int ret;
+
+	ret = rcar_gen4_pcie_common_init(rcar);
+	if (ret)
+		return ret;
+
+	rcar_gen4_v4h_v4m_pcie_configure(rcar);
 
 	return 0;
 }
@@ -341,22 +358,11 @@ static void rcar_gen5_pcie_deinit(struct rcar_gen4_pcie *rcar)
 	rcar_gen4_pcie_common_deinit(rcar);
 }
 
-static int rcar_gen5_pcie_init(struct rcar_gen4_pcie *rcar)
+static void rcar_gen5_pcie_configure(struct rcar_gen4_pcie *rcar)
 {
 	struct dw_pcie *dw = &rcar->dw;
-	int ret;
 	u32 val;
 
-	/* R-Car Gen4 and Gen5 common initialization. */
-	ret = rcar_gen4_pcie_common_init(rcar);
-	if (ret)
-		return ret;
-
-	/* R-Car Gen5 specific additional initialization. */
-	ret = phy_init(rcar->phy);
-	if (ret)
-		goto err_unprepare;
-
 	dw_pcie_dbi_ro_wr_en(dw);
 
 	val = dw_pcie_readl_dbi(dw, PORT_LANE_SKEW);
@@ -375,13 +381,25 @@ static int rcar_gen5_pcie_init(struct rcar_gen4_pcie *rcar)
 	val |= APP_CLK_REQ_N | APP_CLK_PM_EN |
 	       APP_READY_ENTR_L23 | APP_REQ_ENTR_L1;
 	writel(val, rcar->base + PCIEPWRMNGCTRL);
+}
 
-	return 0;
+static int rcar_gen5_pcie_init(struct rcar_gen4_pcie *rcar)
+{
+	int ret;
 
-err_unprepare:
-	rcar_gen4_pcie_common_deinit(rcar);
+	ret = rcar_gen4_pcie_common_init(rcar);
+	if (ret)
+		return ret;
 
-	return ret;
+	ret = phy_init(rcar->phy);
+	if (ret) {
+		rcar_gen4_pcie_common_deinit(rcar);
+		return ret;
+	}
+
+	rcar_gen5_pcie_configure(rcar);
+
+	return 0;
 }
 
 static int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *rcar)
@@ -619,21 +637,11 @@ static void rcar_gen4_pcie_host_perst_assert(struct dw_pcie_rp *pp, bool assert)
 }
 
 /* Host mode */
-static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
+static int rcar_gen4_pcie_host_setup(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
-	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 	int ret;
 
-	if (pp->bridge)
-		pp->bridge->enable_device = rcar_gen4_pcie_enable_device;
-
-	rcar_gen4_pcie_host_perst_assert(pp, true);
-
-	ret = rcar->drvdata->init(rcar);
-	if (ret)
-		return ret;
-
 	/*
 	 * According to the section 3.5.7.2 "RC Mode" in DWC PCIe Dual Mode
 	 * Rev.5.20a and 3.5.6.1 "RC mode" in DWC PCIe RC databook v5.20a, we
@@ -645,13 +653,34 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 
 	ret = rcar_gen4_pcie_host_msi_init(pp);
 	if (ret)
-		goto err;
+		return ret;
 
 	msleep(PCIE_T_PVPERL_MS);	/* pe_rst requires 100msec delay */
-
 	rcar_gen4_pcie_host_perst_assert(pp, false);
 
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
+	rcar_gen4_pcie_host_perst_assert(pp, true);
+
+	ret = rcar->drvdata->init(rcar);
+	if (ret)
+		return ret;
+
+	ret = rcar_gen4_pcie_host_setup(pp);
+	if (ret)
+		goto err;
+
+	return 0;
 
 err:
 	rcar->drvdata->deinit(rcar);
-- 
2.54.0

