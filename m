Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021118.outbound.protection.outlook.com [40.107.74.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668E9395D8B;
	Thu, 15 Oct 2026 03:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035090; cv=fail; b=VK08dkngylM9pTvAA4dv77ZIKCplCtEMTqjT1EvllaVivbkt8gs3rATNoywI8C6+BrEWWFeYwstcoooZseb7RMB3uSMxz7sWhRe3ghlAl0tnWBigVt24x6hnLcWeF8OU8bcp+PVK8onF0nTzZ5KVzKl//liDM2gOxl380QhBTUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035090; c=relaxed/simple;
	bh=ahzvfOX+rk1YNGEVrT9kTlhx+H9mmyZzn3PxjGeudhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=th7S9pZMwjDd5jWAhYKEAboFXX5n/CfmZjz4pVObHhW6Z4xtmuetcqAT+zLaZ11RF+iM/xJlaO442sFcxXtb/I7ZQdGZJaM9OY9AUs0v9gVgzpArPcz4IxUUYEyFsEA1qAqftsQPd10zkMPjNlBPrKxE6ubj0fe1P3OKmSwdpYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=kdHEbqin; arc=fail smtp.client-ip=40.107.74.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="kdHEbqin"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFoVWhtGzKBQ1zDiRQLtlGy+7MiJqjJpB4FparE3hkz8hbRHZdqi/q32LUfpSrbHfBbtxgXUocFvgNaxPSZ9iBPcrVCYPZZC+dcmPQxfpD3YxPqgB5w0aRob1NeZZLQ47m4Kv86E44IYToeV9ZQzClrfw7SmMPT9hhW/yh58KIinyFPIbY4e3TwF1BH48WQYn0gpHvVzyVzdYCS57PQl5oB6WSIxj0cvx+vk4UDzNtkKOH+svVrLnNIaDqrf5WVITd1op2Nao1RrQe0HKfptumN+5LfVHnAlK3d+NYSX22IUtamPOE/ppLQtGJywx7JR3Lsw53frlBouqUrv80myQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0J1ANEB09/mqDGpp5U3VaXuUFKQ98lJlVU7NlnsqJc=;
 b=C4/9m7gxuNVDwSmmF6XxzRWP1IurzmccY51XdGhdOjrvrhR3d7Rc9rWiUDz/agPjJSa9L3P2gf8vHrOZAz0xrwjcx1qJsNu4hgPcoObd+jQyA2aJ9o5hGFDOm+LPW0ARPrMsbyjwk1REIQ+q82wwsgeT8IXjXOUA6Xdh2cclPzDiFskWBE72fIESJyZPRCElaP5RCFoOYRg0xKiAi4TkLh6pK3ytGsdabHpzjOlHSwKfUKsYvyUDdJmgLcyHUed9ehYM15xmr8gYXu7YM1civU719KyA396c1X3zkprLbv14ydN9CU7JDlaAh4SK9pfqpCOuepglosNdcCQswi6rWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0J1ANEB09/mqDGpp5U3VaXuUFKQ98lJlVU7NlnsqJc=;
 b=kdHEbqinRM08ITBv5jPLTRDiv/+LWSms5JV1L6Kmm/coj5fVQkQ9fp//1NXd5YHa60AKVohrPwUXXxNT0h3PN4aLMaHsZV2o8ZzE4NJvLK1qWR5nitrpsnNQT4ObwHB+jC8Ti+66l127QySXJYLNlH+Mmy6Pe5Bkzz4lICpuUfA=
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
 03:31:17 +0000
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
Subject: [PATCH v4 09/18] PCI: rcar-gen4: Add Root Port reset support
Date: Thu, 15 Oct 2026 12:30:54 +0900
Message-ID: <20261015033103.3076869-10-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261015033103.3076869-1-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0083.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::15) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYWP286MB2699:EE_
X-MS-Office365-Filtering-Correlation-Id: ecbc931d-7901-4f34-edf2-08df2a6cc5e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|7416014|366016|376014|6133799003|10067099003|22082099003|18002099003|921020|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	yqbHcua4CVG6GtTipJ2XIK5fj9ZI6hJ1CJTV/YJLINn/rdqmJhNzkE+U49e2avnnljYX4jhNU3kM90Gn43oV2r5oqVTNRVDp4N1ZR8fmJv7KB0gATAkMMARQE5utN2gprBbpcCE2n15JrVI6Cl2/rGcdNkAWKQ2oIFPUrccTGuSnsU5/1JJWLIKrAey0YV5xBzOjWgMCyqAZakm0A7kI9Ge7VDw5cTM9Sgu6zlSI8WbhglXfywBIFyU0h1uuSWnCg7RsyX3WUbPLuhjGJs5dB9Nqpu1t5qUOpbNIGrZGLgS4azN0SaDZgUYnA1qCyeCqa1u9Z1fT4oDfpgZjhwxgv1wPJkMbL23Yy9vKkwvo4WpDFnBnDC43+wpiiyU8kB+DI/3sTlvd0VyquRQ0xwn8t4dr4Sgmtjk8ET/TvW23yzYbpGYVDZ7LUw4us4TX+d35lSWIcgumDdwN+ElNlD0C2pbwYMueGdPMVXrjzr8VLEZ1YjF80QhqMegzWeVAlmRfFHjF6RNwbqycib4h/N5QD21BcU7UN+21U8wa5gKin50R3d2n+l1snbpOb+BDHeRF7kVHl5YaAAmh8bIBgdtJb2vVrCBabZ08haHrsvbi11TEaxYfWEvC/pSCotCnSE4LKZEhVeGEURGa05kAFeX3WNyNJnDN97n1bixXFx4OuKJqcvphR8VmqE+7awuLobP2UeHWHNrq2JjDVeUKqjHGNA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(7416014)(366016)(376014)(6133799003)(10067099003)(22082099003)(18002099003)(921020)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FRFxhBbJkFSzoyRyX8yrL3IqnDi8FcCNaTm+AZU9hnmtQ7NkhTRX+v/iTRRI?=
 =?us-ascii?Q?Xuhiqs1V6CP1Gb4/nHe1zbRo0IYQ7tTMOHzUsOi/7g7tD/1Y74RA5ld2Csrn?=
 =?us-ascii?Q?/ZDnAgMjJK0QnuHcaGhXZh0r1lksqDbZ2LKd03ITdMM3SzxOHD4QB0C3tZBE?=
 =?us-ascii?Q?OBAyCICuymOtclaknoxZDGW9z04q9aD2ibiSnAlqD5vo85bjJBPp9XrSlwhV?=
 =?us-ascii?Q?nr5AyLW9/2UVD+qq48xmkwN9DrFrelWob+OdbwsIrJR7OwjP+e77KAi3LOZ/?=
 =?us-ascii?Q?cynvg11L1H25DcjgrYQmU95qk3CI2y+wkaUFtdQOpLXzfP+8cO3pWUDF5Nww?=
 =?us-ascii?Q?/Lvtq8h7gUKubhUBPGF/JOBkbwMJWHIbzQaUynbQfuOmxs4JQZPrUCETlj/6?=
 =?us-ascii?Q?+eGJeQfe+WAAlBuSOQFL+5YrRb+2D8oKWlxfwM0o4f7lWiyYsaQP7B3KNx+E?=
 =?us-ascii?Q?JRYGUETVVjwgk8Pjs+CEIBRHfMxQ4ZehBENfAhpsDL1rfSqEiBe4aqV+hMSO?=
 =?us-ascii?Q?74ErQF6oMLD5BlksO1h3blkq4qd9q21JXuzA4A8d7HHPFQ7SPIIlxWRaEhZ5?=
 =?us-ascii?Q?zxglDSWGqTW0aeL8ZClSTmS4RlCjnbeT+WBVCvOlL8AeWhYtEfIYiFn0rYJO?=
 =?us-ascii?Q?nxK3FiiyW/DS3tQsLaLgOS1MGx8vkao1HWa3QRU1MbyOlxmJ3QWBxCajrNEt?=
 =?us-ascii?Q?LVuJGEGID9dnSxkK8P7BmRpd068l8vYX6e5BP3ihxQUpHDBANs3dTZh9ejPb?=
 =?us-ascii?Q?8H8N1Sr31k9RlwuwOUCc7ICkgn5MBsEIP5tsRyMKaULN35Aqczs3LGoZ2ZO8?=
 =?us-ascii?Q?9mXAhtPyohQdlpTB6BM33gGNCfEQU5WqfjfXf7M2KEVBhTweCUNg9FgeLII0?=
 =?us-ascii?Q?Ja7DkRQpUNbnBq8Zrl6ok8UqO9t7woJHymFVLbVOLstF2UyEY/HhnFlxtVOd?=
 =?us-ascii?Q?wcdipcKuJSX2TOTOe5yfbSPgaXQgGEbvptX+RG2r3eezT3bt9LzKY0Ag2Gve?=
 =?us-ascii?Q?RV0vk69bYEo9HEEvQddUYovxxqq7wU6T3qURbmMDyu35C3WqnhcRU8fHEask?=
 =?us-ascii?Q?oL3avPPbjDWNum9Cm/KHPN/VrMeP5eX4UhJbV5uDxAJqd2hsB2uW4uGCjcr/?=
 =?us-ascii?Q?6PaLcKh3tF9ifRzZgJLDNcSZLXWhaq1p7dbhynVH/xREh5fQsvzP/YHHccCh?=
 =?us-ascii?Q?WLGmwtZHZ4rXPlLFp8ea2rHOwvOblMdRwmdpieCiFMexTDYFLoSY0N9jJEll?=
 =?us-ascii?Q?OnFzHJlRy0yHUs2kO2FwBgkF+WL/kk3CdvwpScF5ME1siEPLRTYu6CoGt1TB?=
 =?us-ascii?Q?3f4IAtpKSrynkH9bAzSnPDGrVK5ATt9X4AN/4o6gDOiL9GU9vuVSTyNFRZkZ?=
 =?us-ascii?Q?ToPXgYeJtZLqJJpQUsNv3v0pugeNL6+T509Vhd6GblXEtVREv/eMzYETYiCG?=
 =?us-ascii?Q?JaiZAJB7c7nkizcsp1bfUxeC+VyLTBwFf3jC0ZXswAYcZsQZDQ+AqPFkLKr1?=
 =?us-ascii?Q?/iUEGM32B5Rn7ogU7EPS8nj5EVLagUfgGiZ6V0+CtLPSmBk+rBb8p9HaAheE?=
 =?us-ascii?Q?bRMJ+V8zFxFYIQga+6eahxEkwapuLzxw8mWYmDwF8M0n03Ct857JUtuS72Xa?=
 =?us-ascii?Q?BLSHtAmva/KkMXFIGEjKPSyMcNyc3tec3ENiIJTgxbOg8WB7uHoQgl+u3ROe?=
 =?us-ascii?Q?noXR2M4mGs0E2CP3L8nXI8UmTt5A/WS43Nwjj9gYtOOqYNSkaJPZKF9t08TN?=
 =?us-ascii?Q?uYbyYGrRtaYf2BAIAaaezPLwJTjT/PPELA/xPyTpKjr/holeZiUd?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbc931d-7901-4f34-edf2-08df2a6cc5e4
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 03:31:17.5935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rt9FJzmRRlvuONz+fh4w1O5a6H+9V6/4pzRtqqDkoWkh+fASp+0l3A3M2FvHeFumceV/wWBotTQRSBCbTiOVjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2699

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
Changes since v3:
  - No changes.

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
2.54.0

