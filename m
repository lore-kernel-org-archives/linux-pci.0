Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020139.outbound.protection.outlook.com [52.101.229.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD10A3E49CD;
	Tue,  6 Oct 2026 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276427; cv=fail; b=KmkqOLUjQB/tJDuTSWKXRz4mzIBNsW56eIL9sHlJTBl5rfUq6NJD+TT6lsRuAWFbfUCnxGygmS//uCWs+vYZHqs9zs/PLcZRhd5bnuiZSPLdftdwupa+OvFdvsGUFa/9QpWYwBls4gz8lPmZ8DNnEM5nVnkvGIupW2NKP4y0zK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276427; c=relaxed/simple;
	bh=GhKBbvm8mLXQOeFMC4vQGSjNZ2VwBbAShDIwZ++6Rio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QyEQzOZGloCT10jCF82+TT3shrXT17WqFIEbc8P+YmZRIeENZXzQsBA3aGXOVArug7srYPt2mtErUShoZ8JxZfzgdjaezYNVcolXHFGXAOiQwz6Uftd6ojs2DasiJs48e6KFLw8zhgIcm+YUtoW8Yh1VA4F73VtujQrYsfQVo40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=quWCQJDm; arc=fail smtp.client-ip=52.101.229.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="quWCQJDm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfTX3b3Gmoed787s6i8yIPdJyB6CsHdHRmxLMcQrYgszzYYqdFRw2dfafkHVviEdU+DQjQb1Z9Dvp91bFdlYfpvMgFkhX2M8n2AMzK7wvfxgsydUXqStSs82z91c1vp45vVXZvQ0HfqQs5wuzGCc6jRCH+FU+CCZMjgpNPBqn1P+BAWsnX51l7a4uU21xOsdiS8UWf0sa5sVQdibwQhGpi0LiaaGAoDmJQwlJGhqOksGOabnHQ9Qpi8WMK7q9RLABMHzhORWa4rKdAODSfNM1iL0QEGAJz1YD/nLiuvI48hBzXw8QrjhKele3juKQUd+18MtVTYvBmBxp4Qyg+zYGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9bTf2ZhbtQ/HQUUaCplENdTcv1le/piBDIaqhkH2Sc=;
 b=DaDETmAdtUxVN1hINgj4SepmisrN0uTz0mRiROOs+BEnjWOCnLGKPV0wSsukLJ0HD+Txzs/L2wlmpwxBYusTemVtYWxh9rrlmSf9FfBCFhZ0A6toFKxVTQtbGw9kfOv/zdsKqTZmnOnInZaOA18NjiE9OG3WWnzstbaE2PssRVgCH1rDVwj3bGVwS3Oo+Gt3SWwukKtIVHcWd9IjwWuEPLZ4cgbhFNHk4DJe1VTCljweGbb2joOT7/LrWyosNqtt31Y85+wmGbN+PnTI16p+exL+XOGrdVH0jmluUL706XanYm8CKrm9nT54JkzUuhFrIq3/kp7MGDn1m+He2fVLDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9bTf2ZhbtQ/HQUUaCplENdTcv1le/piBDIaqhkH2Sc=;
 b=quWCQJDmauzBWQyE023cpOMwD81/M68DNrBnapUcVbmltGxa5puO7SvTxqLPwo2YzonLXPW4JCi2Vo1Htzo90v846wLwBHgCWv3qm8Ij7iZ3YquFI8JLwlV0XoJavfD8jvgBeo0MYQnk3SjJ0smLO12PBoiGabCb0brCHtglZhA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB4983.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 08:46:54 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 08:46:54 +0000
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
Subject: [PATCH v3 09/18] PCI: rcar-gen4: Add Root Port reset support
Date: Tue,  6 Oct 2026 17:46:29 +0900
Message-ID: <20261006084638.3821710-10-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261006084638.3821710-1-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0010.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::15) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB4983:EE_
X-MS-Office365-Filtering-Correlation-Id: d4142315-1b3d-4e76-674d-08df23865f2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|23010399003|1800799024|10067099003|56012099006|6133799003|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	x1T20NC1BRSjphKONEuHXK4FB2HYpJQNnAuG+8gg60w4aY93HCNEnvvG7JMIY4M/Ww3KgXG9CpWUe5AMRzUMZ6GSArTW1+VysYGjSBHJCH10zi/47hLbxa4U5jnO69NewP+wfmmNq239Xc2PR2a62gPQsOvdI5Wd8fXOSSQJRPdQTG39ytgLX0dibZ1aHYf0eTKeZzUtMsoRERF9goAh0JkbNYfF2GFvwmXGmOSd+Mh/eP8ilrOu9LY1RUDCvXoCKly60qK2baQ9OGlaEdMsTRPl0GwNKvkvBxhcIP5bNLjugXsirk0J876CpPG6GPhGy0HrCKVwsHI6i+tXCOvQNd3RH9+hn8s5vgaGeG2R8bdJq2ASxMOZ2bzBmjdRtBoq3l5Uz/yOBbiw3Fy8DnL6JLo10QzfpRmoEGz7lBOKzo9Von3ynHZvxK2J2H9b0zQiuyEJT+/H2a+H/y//qPOh9puKejcnIxcBh8u5HtrHW+yQo0C5rCKE7rGk65/VAhsyIUwLOPq7k3GUCkzZEq/mEhcARhVeJivcS2zWToKm8uG78cj9UQ2U5en8YgwwgXOmfUypQ7c04hR+lp5RR0C1aOsmJSY9v5XLCBB1ps+IR96Gw6yVGGtFfjYQKnUyHf2vQU6pYiUjQn/4J2RPFlRkNZxHY/yMWaG99/znozLe7HQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(23010399003)(1800799024)(10067099003)(56012099006)(6133799003)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pGXCBhdM4j5GjhB+SUZKNksie/WFjt0VFzqdsXYiveA6FgaAguMm169mQN8B?=
 =?us-ascii?Q?yJq+GTk/SUtl5i0iXvyV67EWPeFwHERfvlJXFxKTvMh1qFpuGGjGOkBZ+CJy?=
 =?us-ascii?Q?e31Co/Bwsa7t2GPvgb4akmWPbDcgXxwROBZxCZMzyQ6KtJ0iraxa8Tz8kn8c?=
 =?us-ascii?Q?rua+D9Iv2f4Z6RbKIVGAVl03iUiObOxMp8ELWw56nYtCJjk7niKHcEmCHxAv?=
 =?us-ascii?Q?3T9GBTgI2sNE5DLTg1nxtvm4cSSQnVTgvAoVK0H+sX1K2a6dZMh1D/Ezol2Z?=
 =?us-ascii?Q?U3k+UPJ8AIz5Z0X7biy35OX5cm+WLMlONNs99MdfFiFhe5ZzxYle/TkmzTuM?=
 =?us-ascii?Q?C22hFbdQz3xlOuTqKBlrsVsP3rdapc5OgLScsGNJy/fXbE/lpgIfOGg+ZDmi?=
 =?us-ascii?Q?cbKJeKRpyFlyyJ0aYTG09u40BC/lGH460ylfoh1KFT1nwlRZLxPveaDkUIwX?=
 =?us-ascii?Q?Ws8sXea6gBy74gwmZQIJI8lvYYgSKlpnxhq6+nsQMDYJwRcvVFkDjmQqEtMx?=
 =?us-ascii?Q?YXJE94mlUCIkBdsQgHRKO9p1srfQrh6huh8S6YoYj4H9cTg8KAFfIu+qUU/9?=
 =?us-ascii?Q?7IGwNP3haD4KbVCxOmT+33IMPVeU/BI6JePfcf20g9zMu4EQCDWfVnCOlEVJ?=
 =?us-ascii?Q?/d/X75jYnMVNhppARGo6K6oQ6Qq1tAb5WW41Bcbny3YzueIFsKzZCGDyhaDa?=
 =?us-ascii?Q?S4TSy152T9qrze2fuWnldkvnGGolOA7LjtAbuHc6zcKF7tLs9Af/sXRV3DHh?=
 =?us-ascii?Q?WCvzBN/Xg3Etl2WUtHmrJF1OROJnyYfpROn1Pp26chgSiYh2q7xjGd1QwL5b?=
 =?us-ascii?Q?yMFpudJ3qpmDzZp8+5rX+UZbYqDSRfLKanjEWKpYFi8MYZqgAwxdsdLm0vE6?=
 =?us-ascii?Q?s1PILMnIeCJ3dvEkokFIuAC1OSUAHnOS2mnbK7mwz+NQpUgXdb0wJLqk1EMA?=
 =?us-ascii?Q?Dy3dogKiUb5gkLk4MwKIKX0EgTyU9cPn3HlzKGznDN7RZk4cKGOy/W8piqfQ?=
 =?us-ascii?Q?bnYQku3d6lSPhqYW6GT2XYd7Mh2tAkCIrdG51CG1sXdh2nPoN+ZAOs3BLJNZ?=
 =?us-ascii?Q?sx0Xji1Bucw9eJFclEuN1NRqmM3UwVnhOStQ5nlsaSHPlhZGz99RPDzvbGjb?=
 =?us-ascii?Q?lw+GpsZTsbTs/aKMKRgtSXMUryYWPZVO3wAz7WYM1HnNP6R4iNHxKEto5Wgq?=
 =?us-ascii?Q?TQ6o/JtlwiKooOWN6cTJ9hy6nPyE3QF98lFnGwjyuS1s3CQcWPYcpas/jxSJ?=
 =?us-ascii?Q?PfhAPoMu9j7gXx34ZgeJh6BUZ930yBpSSOHwuTutOd1mA/kfaNC6/jWaMKga?=
 =?us-ascii?Q?JOvqFuj7eCkmxg0kHYyQtqrbaFoPhed2gGRVc4+AkRDVLzOcx9M36Q2yKXsw?=
 =?us-ascii?Q?rMIdV+Und75dO9Ff1waUzoU0K88CmNADlFGDWRFJtY314SeASyQ6myGXZpvH?=
 =?us-ascii?Q?pYb1Wrwi8cNbF7rmG4A8SzcCz5maWfb9fXJQhNE0KoromfegQTgTujZsgmzs?=
 =?us-ascii?Q?SwjCjMywp++nEgwwx+LC9jkfwI53MoO51Jb229plwJeTdhciR3rC3B2+R+GX?=
 =?us-ascii?Q?0L7tBbjtCYzTrOpYTJmLXoj+HEtTG5iesMWrIJUr5i90LshGDBOVeedw1Fgl?=
 =?us-ascii?Q?XOWrP0upW2Ea/UvkjrRO0/TIw3KayYKsc+WhaRqhL0j1it3cCfrpvIEH/rJ1?=
 =?us-ascii?Q?eEZclkObfCtaMaITZFHz6Xk3nwiNG5FyHg1VLHl9IfW3tpbdT6fDJ+IPnJts?=
 =?us-ascii?Q?+T1kTz3mSgxpnuse1RI68i7FRkYGWYNFUcACkDA91vCK8Uo0TkdE?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d4142315-1b3d-4e76-674d-08df23865f2a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 08:46:54.0429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2c5bwyGytRMA1O2QslWgQpQaUBVDEG53Q2+UpcXd8p+nCigSoS2ZMA4rrpIUOb/Uyves0Woqs959qutOYho1Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB4983

Implement the host bridge reset_root_port() callback so PCI error
recovery can reset and reinitialize the R-Car controller. This also
provides the reset operation for the link-down handling added later.

Reinitialize without going through .deinit() and .init(), which would
release and re-acquire the clocks and the R-Car Gen5 SoC PHY: split the
SoC-specific register setup that the power reset wipes out into a
.configure callback and repeat only that, then restore the Root Port
registers and restart link training.

Rather than tracking which APP interrupt enables survive the power
reset, derive them from software state through a single helper. A flag
keeps the sources masked from the start of a reset until one succeeds,
so a failed reinitialization does not re-enable them against an
uninitialized controller.

Reject a reset while the controller is suspended, as a failed resume may
have left it powered down.

Track whether the R-Car Gen5 SoC PHY power-on has been requested so a
reset retry, or teardown after a failed reset, does not call
phy_power_off() twice. Continue to ignore the PHY power operation return
values.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Replace the per-SoC .reinit() callback with .configure and a common
    reinitialization helper, folding the former patch 8 into this one.
    (Marek)
  - Drop the mutex: the PCI core already serializes the callers through
    its device locks, and suspend/resume runs with those callers frozen
    or quiesced. See:
    https://lore.kernel.org/r/eivzz4zumuu32zrycw6wpt3orzk2dvlzuvj34krmbhjf7a3a6u@ccvu2nkupzid/
  - Reject resets while the controller is suspended, including after a
    failed resume, now that v3 is based on Marek's PM ops patch.
  - Lock explicitly in the rcar_gen4_pcie_host_msi_init() error path
    instead of mixing guard() with goto-based cleanup. (Sashiko)
  - Spell out the SoC generations in the reset_root_port() comment.
    (Marek)
  - Revise the commit message.

v2: https://lore.kernel.org/r/20260928165230.3397664-10-den@valinux.co.jp/

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 141 +++++++++++++++++++-
 1 file changed, 134 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index cbd22e6bb44b..54260e62293b 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -99,6 +99,8 @@ struct rcar_gen4_pcie;
 struct rcar_gen4_pcie_drvdata {
 	int (*init)(struct rcar_gen4_pcie *rcar);
 	void (*deinit)(struct rcar_gen4_pcie *rcar);
+	/* SoC-specific register setup, repeated after a power reset */
+	void (*configure)(struct rcar_gen4_pcie *rcar);
 	int (*ltssm_control)(struct rcar_gen4_pcie *rcar, bool enable);
 	int (*speed_control)(struct rcar_gen4_pcie *rcar);
 	enum dw_pcie_device_mode mode;
@@ -109,9 +111,17 @@ struct rcar_gen4_pcie {
 	void __iomem *base;
 	void __iomem *phy_base;
 	struct phy *phy;
+	bool phy_powered;
 	struct platform_device *pdev;
 	struct reset_control *perst;
 	const struct rcar_gen4_pcie_drvdata *drvdata;
+	/*
+	 * The controller needs reinitializing; the APP interrupt sources
+	 * stay masked until a reset succeeds.
+	 */
+	bool reinit_pending;
+	/* Protects APP interrupt enable registers and their software state. */
+	raw_spinlock_t app_lock;
 };
 #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie, dw)
 
@@ -322,6 +332,21 @@ static void rcar_gen4_pcie_common_deinit(struct rcar_gen4_pcie *rcar)
 	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
 }
 
+/* Reset and restore registers while clocks and PHY remain initialized. */
+static int rcar_gen4_pcie_common_reinit(struct rcar_gen4_pcie *rcar)
+{
+	int ret;
+
+	ret = rcar_gen4_pcie_reset(rcar);
+	if (ret)
+		return ret;
+
+	if (rcar->drvdata->configure)
+		rcar->drvdata->configure(rcar);
+
+	return 0;
+}
+
 static void rcar_gen4_v4h_v4m_pcie_configure(struct rcar_gen4_pcie *rcar)
 {
 	struct dw_pcie *dw = &rcar->dw;
@@ -513,10 +538,31 @@ static int rcar_gen4_pcie_host_msi_addr(struct dw_pcie_rp *pp, u32 *msi_addr)
 	return 0;
 }
 
+static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
+{
+	u32 val;
+
+	lockdep_assert_held(&rcar->app_lock);
+
+	val = readl(rcar->base + PCIEINTSTS0EN);
+	val &= ~MSI_CTRL_INT;
+	if (!rcar->reinit_pending && pci_msi_enabled())
+		val |= MSI_CTRL_INT;
+	writel(val, rcar->base + PCIEINTSTS0EN);
+}
+
+static void rcar_gen4_pcie_app_irq_sync(struct rcar_gen4_pcie *rcar)
+{
+	guard(raw_spinlock_irqsave)(&rcar->app_lock);
+
+	rcar_gen4_pcie_app_irq_sync_locked(rcar);
+}
+
 static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
+	unsigned long flags;
 	u32 val;
 	int ret;
 
@@ -543,12 +589,7 @@ static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
 	}
 
 	/* Configure MSI interrupt signal */
-	val = readl(rcar->base + PCIEINTSTS0EN);
-	if (pci_msi_enabled())
-		val |= MSI_CTRL_INT;
-	else
-		val &= ~MSI_CTRL_INT;
-	writel(val, rcar->base + PCIEINTSTS0EN);
+	rcar_gen4_pcie_app_irq_sync(rcar);
 
 	return 0;
 
@@ -563,9 +604,11 @@ static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
 	writel(0, rcar->base + AXIINTCCONT);
 
 	/* Deconfigure MSI interrupt signal */
+	raw_spin_lock_irqsave(&rcar->app_lock, flags);
 	val = readl(rcar->base + PCIEINTSTS0EN);
 	val &= ~MSI_CTRL_INT;
 	writel(val, rcar->base + PCIEINTSTS0EN);
+	raw_spin_unlock_irqrestore(&rcar->app_lock, flags);
 
 	return ret;
 }
@@ -661,14 +704,87 @@ static int rcar_gen4_pcie_host_setup(struct dw_pcie_rp *pp)
 	return 0;
 }
 
+static void rcar_gen4_pcie_quiesce_irqs(struct rcar_gen4_pcie *rcar)
+{
+	scoped_guard(raw_spinlock_irqsave, &rcar->app_lock) {
+		rcar->reinit_pending = true;
+		rcar_gen4_pcie_app_irq_sync_locked(rcar);
+	}
+}
+
+static void rcar_gen4_pcie_resume_irqs(struct rcar_gen4_pcie *rcar,
+				       bool recovered)
+{
+	scoped_guard(raw_spinlock_irqsave, &rcar->app_lock) {
+		rcar->reinit_pending = !recovered;
+		rcar_gen4_pcie_app_irq_sync_locked(rcar);
+	}
+}
+
+/*
+ * R-Car Gen4 SoC PCIe controllers and R-Car Gen5 SoC PCIe4 controller have
+ * a single Root Port per instance, so the 'pci_dev' is ignored and the whole
+ * controller is reset. The PCI core serializes the callers through its
+ * device locks.
+ */
+static int rcar_gen4_pcie_reset_root_port(struct pci_host_bridge *bridge,
+					  struct pci_dev *pdev)
+{
+	struct rcar_gen4_pcie *rcar = dev_get_drvdata(bridge->dev.parent);
+	struct dw_pcie *dw = &rcar->dw;
+	struct dw_pcie_rp *pp = &dw->pp;
+	struct device *dev = dw->dev;
+	int ret;
+
+	/* A failed resume may have left the controller powered down. */
+	if (dw->suspended)
+		return -EBUSY;
+
+	rcar_gen4_pcie_quiesce_irqs(rcar);
+
+	dw_pcie_stop_link(dw);
+
+	rcar_gen4_pcie_host_perst_assert(pp, true);
+
+	ret = rcar_gen4_pcie_common_reinit(rcar);
+	if (ret)
+		goto out;
+
+	ret = rcar_gen4_pcie_host_setup(pp);
+	if (ret)
+		goto out;
+
+	ret = dw_pcie_setup_rc(pp);
+	if (ret)
+		goto out;
+
+	ret = dw_pcie_start_link(dw);
+	if (ret)
+		goto out;
+
+	/* Ignore errors, the link may come up later */
+	dw_pcie_wait_for_link(dw);
+	dev_dbg(dev, "Root Port reset completed\n");
+
+out:
+	rcar_gen4_pcie_resume_irqs(rcar, !ret);
+	if (ret)
+		dev_err(dev, "Root Port reset failed (%d); interrupts stay masked until a reset succeeds\n",
+			ret);
+
+	return ret;
+}
+
 static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 	int ret;
 
-	if (pp->bridge)
+	if (pp->bridge) {
 		pp->bridge->enable_device = rcar_gen4_pcie_enable_device;
+		pp->bridge->reset_root_port = rcar_gen4_pcie_reset_root_port;
+	}
 
 	rcar_gen4_pcie_host_perst_assert(pp, true);
 
@@ -708,6 +824,8 @@ static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
 	if (!IS_ENABLED(CONFIG_PCIE_RCAR_GEN4_HOST))
 		return -ENODEV;
 
+	raw_spin_lock_init(&rcar->app_lock);
+
 	pp->num_vectors = MAX_MSI_IRQS;
 	/* Reserve an iATU window for the generic PME_Turn_Off implementation. */
 	pp->use_atu_msg = true;
@@ -944,11 +1062,17 @@ static int rcar_gen5_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable
 	}
 	writel(val, rcar->base + PCIERSTCTRL1);
 
+	/* A reset retry may find the PHY already powered off. */
+	if (enable == rcar->phy_powered)
+		return 0;
+
 	if (enable)
 		phy_power_on(rcar->phy);
 	else
 		phy_power_off(rcar->phy);
 
+	rcar->phy_powered = enable;
+
 	return 0;
 }
 
@@ -1141,6 +1265,7 @@ static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie_ep = {
 static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie = {
 	.init = rcar_gen4_v4h_v4m_pcie_init,
 	.deinit = rcar_gen4_pcie_common_deinit,
+	.configure = rcar_gen4_v4h_v4m_pcie_configure,
 	.ltssm_control = rcar_gen4_pcie_ltssm_control,
 	.speed_control = rcar_gen4_pcie_speed_control,
 	.mode = DW_PCIE_RC_TYPE,
@@ -1149,6 +1274,7 @@ static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie = {
 static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie_ep = {
 	.init = rcar_gen4_v4h_v4m_pcie_init,
 	.deinit = rcar_gen4_pcie_common_deinit,
+	.configure = rcar_gen4_v4h_v4m_pcie_configure,
 	.ltssm_control = rcar_gen4_pcie_ltssm_control,
 	.speed_control = rcar_gen4_pcie_speed_control,
 	.mode = DW_PCIE_EP_TYPE,
@@ -1157,6 +1283,7 @@ static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie_ep = {
 static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen5_pcie = {
 	.init = rcar_gen5_pcie_init,
 	.deinit = rcar_gen5_pcie_deinit,
+	.configure = rcar_gen5_pcie_configure,
 	.ltssm_control = rcar_gen5_pcie_ltssm_control,
 	.speed_control = rcar_gen5_pcie_speed_control,
 	.mode = DW_PCIE_RC_TYPE,
-- 
2.51.0

