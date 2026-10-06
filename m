Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020121.outbound.protection.outlook.com [52.101.228.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E80A3C10AE;
	Tue,  6 Oct 2026 08:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276424; cv=fail; b=VAIfnEpJvPmfOORrdimrQ+o9UH1seZY2gahYff968tIxxQeYRzA54KmgQ1qxabiKHvWvFAu/o3oQ0IYdRgAO2iC4CVtZcn3FlpPY2+hjDHf9e5k31/zuEsThqb4Z2bk431qgzQgL6SJRwmotBfmdUWNOK+OS2id0+TKMuyh8AXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276424; c=relaxed/simple;
	bh=uzZMHO5vKlFKly061tJM7E4bH6MWOFMMKd6EIL/QtME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nY4NIN/G9BPKQwHVK680hQwNohyLo0HcweXz2z9yDCTJSBVcMJY6Jx6tK618b0oh+lbmjX7rnxKIm+mbJAxPGZyKxg+uahntnSBxrKwPCiCoQTlcMHzBUqoz6r2Uj0rNzdF91Nr8erHqhyaHKMnMWefJ8o1EM768ROML/6ZwJis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=p7MQf2YY; arc=fail smtp.client-ip=52.101.228.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="p7MQf2YY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNjFOmDf9s4JQkNv976rX1zKwiRKda8JZ2DGwsWiBZze9Iy6qUlJ+jB5DvksZ7Spwu7s2GrdcZIxcD7Od5u+ZiHiAaV2gu7ftcQwkypBaIGk3Sg+1hO86ZJ4Mot4q+1sh1NGc7kqBm7Sm5Ke871iZjpNdn//UjA+ZSb1UXIzugnw/73OKRcUayx8gCFZKhNEhrpprf1Nw9Rp3Jnk4pI9h/LgfLKKjTs5J31BVF/UAR6DYH+/A8wGA7XOH47gWC5cKWi+N2whLy7U4tItE1ZSjC6yERt0rEJST9qojDtcIXuNY16gB0kDg862bcDxo0KbRaNmfKcYcWfhnPk8MWe8HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKAEyM/L+/BPzSEVtrMuLQwiQMKJUiaQHsp8EAX665Q=;
 b=Vjy6xmZkpar7d+ENYctmOx4PShFolc2I71Otxl1LnWU8aun6JobpcnrDAnzgT/Z4/B4pA8cz/pB/dXUUL1N7c6NZ2YQDMRDX978VrFczxHkxEeYWjkfPaEMPcPWzxqQKt77sWe8r1Yyb8Gxl696TcGVypj/vnQW20sIvtRGpHJsC2tdJUU0eQogHt/Imu5zOmfKGANECUdvHYqVOh+NAjaTBrrmSKfSG5iarMIFzxnQPV3SL81l30E5DN0URdmZ0xpc7bSVemo14S2i5Gke3riflhdLK5yDB8o9U/hmWZYXvjx+W+wbuLV02Bwjnaez/ilG9oFzB4jyRgzG2GzvATA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKAEyM/L+/BPzSEVtrMuLQwiQMKJUiaQHsp8EAX665Q=;
 b=p7MQf2YYaIU1ZWnkuip/TKmVirl7vEId+UAVZS8lozN4ABo85dD3wEXQSwougEVRuZgHqtwOxHHjkoIuQC+V+/lnwbtRIiO0ihvujFMGM1ieq7It7+LFzPKl7wNOw5n2AdQhlK02xCeyYW9MYul0wcqh8jieY167uTaolaKcqfg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB4983.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 08:46:53 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 08:46:53 +0000
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
Subject: [PATCH v3 08/18] PCI: rcar-gen4: Separate hardware setup from resource acquisition
Date: Tue,  6 Oct 2026 17:46:28 +0900
Message-ID: <20261006084638.3821710-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261006084638.3821710-1-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0305.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::16) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB4983:EE_
X-MS-Office365-Filtering-Correlation-Id: 99126cd3-0653-45b6-5af4-08df23865ea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|23010399003|1800799024|10067099003|56012099006|6133799003|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4RmIa28k+JOMXjc7N7Ob8JUP7w8LQAN+NCThEJtFCay3XY8ToU3mTC4RjLG4U1FcVAXAPlvkGjYchD5es7mwbSZT021ugaosKCLxaa8Qa/U5saLXYf5inGjMIJ4i3LYBinO9IVPM1nXkZjne0eLtVtm6KAZGlm4R0juRvU5V8cHkWodlloM7bAh5LcI2igDIz8cUSNh3Sh9jvtgo6LS/5LZWIfhTo3v3/ZpKC4kl9u64wL9yuABuwOLLSDs+28MQE91qMQk42hCA2bVR/C9EvrNr0cJHsNc5UimrrJyOTeB7T6k5KQr0u3wzByswp8KA4HkbOJhjXrgMfXQ+SSTnHJ4YkbZlyEnKtn3AlizaLKn2nm77BIYZubeOC9nKEWeCsLpeklfvT8CRMEqamwOv7jQrkIl8Ps5ajC/BGNzSGdGQfARBPR41OJ2m/LDxdXefDiBxXBJQyR8uVIGvHVVNYesk1HAv7f6vwVmQiWkb7enko9e4/vBLBQEX07ss/TL4TWixskRXPRHazpNxFXVp4ncS6QAkc3Kh1r4jmeuUBPlL0SAF6WAAJ1I35V96bSI/YGGCwv6lY5ioAN8ClPO93HDYUTNm0biotGZic5t/qocH3ifHD+Kc0s9KmoZ3hIwCSuxWvS+WsM/neWWqBCAE4Z0xf4T3vAOGf/FJbyF+f20=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(23010399003)(1800799024)(10067099003)(56012099006)(6133799003)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?igYPJutJfTFLDX7TVEn0AoJ37GwZLB4Cx0wy36wZQJwjNblatcqhdO7b/DzD?=
 =?us-ascii?Q?iQf505V6aGb21wnlkPOAEpZQ6kfVjsjEhRSbXefu55xbxaLZXYVZx6aV9IpT?=
 =?us-ascii?Q?tHy+ugvUVgNaiIl+HIdvlEJr0baUDgoOQkUqI8BnuPneYxsLzbWXkpD3MWh3?=
 =?us-ascii?Q?JagdBso7DzFPNpJpOqtILU4O37X0laTFRgwveraFugPYOVnWJ0G9A2Vm8Mj+?=
 =?us-ascii?Q?mMzgQmQu5LLBrU28ONBlOOgKpouSSqblwZ2xvEgZNrP1JjLstOP3VEBKIGaF?=
 =?us-ascii?Q?hUL6brcn9LQRAC+Jpwmp96q1otZ9NXpbaaW2r/NLi7ccMSPpmPn0Pg1xSrnP?=
 =?us-ascii?Q?dymttbxvAZyXVx4cEGtHhpOTi3sWWGZEIdrQ2ZO9EBWjCZi0GoY4w9krbt4H?=
 =?us-ascii?Q?ieUR8cOAmdwhQ7J9tknBe9iD2nOqmATtRp8VCjfn81d6CE3BtHY8uNuu9fpQ?=
 =?us-ascii?Q?IyltIZs7vQsTQ77Skweev8oHG7dTmn71i37+yI5sz0ytpQt3Y+T7yKW0D8Wf?=
 =?us-ascii?Q?z+ljrCJJTOiBg1Y7D8HSCKWelQj4MRiSNuIrjNuu+wPZs3nTvUV96hljITUn?=
 =?us-ascii?Q?5L02gNNBvDIhoM6EE5AWhEqZM8bE2r0nMuJszHHp46OAy2IUa2crhEmB7X/p?=
 =?us-ascii?Q?CaESri1BuTQBuzlpl/Ns6pnnoiOEscErmabGxEUgTWS2Gv10CFrtSoUr9v+O?=
 =?us-ascii?Q?5Syt//2VV9cXmFGm3IZ4pFu0iVhL25XCyq/R6AnRPJYCXH32lsGtr+j+SSnL?=
 =?us-ascii?Q?mQsvagha/4STK78AGyZGZDm3bVB1mWlN1TK6eNgpekdc1QKYiMhn3Nlx/Icf?=
 =?us-ascii?Q?rYomM472ucnKmFPDtNHkFlw+KTnaBY+UDw+FrX2AEG/xMD0LXxhtMPzNxaK5?=
 =?us-ascii?Q?j7Wpf8RJYTvumt08M4ngMynp+mEeFrRpkU3F3RBNnIZSQ3yOf2KsFcUWxUGv?=
 =?us-ascii?Q?T91oAQY4qc1TTI2SoyYKeIS1OR18+75VQCSGRJUHQgJHIZQ7d1QgnYdubB6T?=
 =?us-ascii?Q?LHhmWWnHUYK3VWppdq+GezthJ5ElDVZLiHCCI06So91fLg5RLI90laIf+B/1?=
 =?us-ascii?Q?CSj+YLcb1gT0tekvceHgHVTzEfspyoLH1SUkDdKa7gf5LKVO5M3e7PVFrXxL?=
 =?us-ascii?Q?BSzaj37uek5Tw0aXEGdu0V3NQLW4mCIbM0IdpW8+2XCeO68aDol1hvCZlotX?=
 =?us-ascii?Q?GPc1LMlxYRtpIJdhagb/Tje+gJ07rUQNIBqYYqiL1W/JyMlSxZ4GdSX9H4e0?=
 =?us-ascii?Q?mNgEmKohzlwWPopPfyJ+a4vPz2MHH5k+uPrpTGcNtgK61Q6/b9EEujBxwXiJ?=
 =?us-ascii?Q?k/79ngPNMF5cqrhir1ddoaKbPpoZVx19UuFF1R3fzvIKOIKhDjRg3V5jhZKD?=
 =?us-ascii?Q?V8r2mZTZHC+aMszXI3QDtz8/atEjdi5FY+RZciUiFDQSKQfufuNjbMc56tzo?=
 =?us-ascii?Q?O0o3BE2h5Be0+Duy5CbO9VuXiV65knwbUCvC5XK6p2p7ImW+qD2H/Rso13Qw?=
 =?us-ascii?Q?I3bjlxuwQKHPhs+bXEnK3rYoJ9+fbIN/CwYQfjCgAOSksQBYTZXVQ1IckClJ?=
 =?us-ascii?Q?kgFwSu71J80LwK51VggvGH5mBEz39xLu1lyBDlDlcOWHQVSJxmmtbUJN8rbu?=
 =?us-ascii?Q?VfYCQezHEm+tro5U3234uaMIKG+HOCt61Sz9In9m/XEd7hOGKAYfthUSVT4z?=
 =?us-ascii?Q?t+IwLvTiGL6uBDw6clAH7W1Ax0Emln0lPYf5XLFNS5G7jq7nxMi5JL8AKgKO?=
 =?us-ascii?Q?/pzR9DY1rVC2Os9P0whXHm1Ssft4//p7msmBkZ1T54YOVwf/Xw2H?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 99126cd3-0653-45b6-5af4-08df23865ea0
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 08:46:53.0998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qlHTVgL0bmaDRSUXSHVNgGkFXl9LC4VWdv9CwMzeXAfveQYKzDUfO8z1UllLloPtFn7LAkKjrYuD33HZNC4saw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB4983

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
Changes in v3:
  - Add Marek's R-b tag.
  - Clarify the SoC generation and name the .init() functions in the
    commit message. No code changes.

v2: https://lore.kernel.org/r/20260928165230.3397664-8-den@valinux.co.jp/

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
2.51.0

