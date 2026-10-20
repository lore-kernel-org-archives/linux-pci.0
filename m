Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792465867;
	b=qOAtkJD9+HBjijkMt4bMozRGXZclU7eIOeAwkLplYBw2RMSslDNrIAXtHu1rdR0vhXcQ
	 lvwD3X9XnvY2AW46xHMjQq874fIxX9COb7HuJjqrB6DUyxnrIZqNskL+fqTA/Z5lepbKb
	 J34p/e0s2VtWw3YBZmUZQJcr5iynA1qF581h+VjADggBzRlT6Cvgt3nIiaNWzAUnnObVG
	 qC3yFrGrbVt/VTiu649+zXWkMYVuy/vl1q8DXSQxeI2E0Mey5Xza8IQSIK4dL29P+vdv9
	 BnvlCjYFsKznaa4NPApLeS/a6rgl7WUrnbilbJn4AyvXLvhbwQuR/T0zgWf9D83UnuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465867;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=hbKGCCmMaSE9Zjbgq38EOf9yj5AMxZ8Nrj9UYb9+c0w=;
	b=E1qPHokMLc1tJy/tklmb13uX1AFsb/O/QlxmLP+9W6OAbw/ukRI0I2h7N02DTGjKpVPe
	 F/gyCEzrsZle1ceM5Vbp8r7f4yvOHSRCSoj77CZxbYXbroeO4eTx7brXj2KzAAVUtvQ1Y
	 iYROIcFW67mswS+ZXRxLJ8WhET0xj5L67oJiwRjIwE27KCw0UIcfkZ/9O+qmiVnHtVYB7
	 duGYX1nK4ce26raWJCnNvD/CpO/mQL9csisoQCNspO4DyR7vq3tuoKaukVGy00Td/0mjx
	 gj673dg+j+kunDjkETKzC5ksTdpdoUlk8LUyBpqkusOqy5VQ1/P95zuWD+RXydtYFXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=v9O891vm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020113.outbound.protection.outlook.com [52.101.229.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F328F606AF6F;
	Tue, 20 Oct 2026 03:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F328F606AF6F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=v9O891vm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGjfoUBx1AvwNkC6D/nEwuGyRJ8MD244RlvCIeVlximpA99AazFEtjkBimOSfp9jegj67mnNI9ICRo+kuKIbiS5p0LykVMux/1lqo/tSQYHe7WEguqLg3rK0U8zeoG1BySPy0QAoxZSMyRlWGf5QZH+Fc1C+c7uXBsmEZiiIQ8ZihbUKYi8p52V4u/AMzYsBGAJdpu/cjdqOXypLY0H9cquwNsDF0P56fFi2fJh4nmD/Nkhn2KsHdPQ1Rm/vJvVH/R5VQqjxF55JbBeP34sgaEdZvrDXfwDrz0g16dxLoPC+XBSsJfa79re/IxzIKZZOwoXtIYY13Puj5PN+7cs9vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbKGCCmMaSE9Zjbgq38EOf9yj5AMxZ8Nrj9UYb9+c0w=;
 b=L55U9Vyd5nzuc5CNkIo9SYZ/ha66dfoeHOsjyph921dH6eCkBxZ8rbaX8uZXv1tgOzHz/ILnghSyEaJXAbHbe4ujoBeum8EWJVX0mxPqac67G858khhYtr4QBVPtQ3lPBFUHLGxlpJk3hdEkv2uxbt4q7c8AwWPQ/kZFueb4w9QT8CRTXwpUVFkhjIxXcaGHcAQmoInptjXMSg1+BJXjnPh2mscZcZ7181NmCnKkwYZNbKPYuCLeNK5D1EFpzC+/1WoTv+yOpuQLswF3Jc0MUjJ8mLzkWZwoP3nfNeudgLXZtKcj5Yui0HkQNlVBFzHKZCzl3ctB2l5rAGeQ3xLqXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbKGCCmMaSE9Zjbgq38EOf9yj5AMxZ8Nrj9UYb9+c0w=;
 b=v9O891vmYQPVf0q1slfClal6UYiKxAH9g18O6bIpm+l7lRz/1b/0V2snv2qpjv2CM/E4FShj1yx7P8VLNgYEAAfSd7y2XqzFsIKRKz61hZhhbvCaq7oNtVEuxdTeYos0D7YVHBatUw6CYuIsQsDwNfcVPnOC3psDlIbqdn0+S8A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB7503.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:44f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 03:11:03 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 03:11:03 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Shawn Lin <Shawn.lin@rock-chips.com>,
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
Subject: [PATCH v5 06/17] PCI: rcar-gen4: Move deinitialization helpers before SoC initialization
Date: Tue, 20 Oct 2026 12:10:38 +0900
Message-ID: <20261020031049.969895-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020031049.969895-1-den@valinux.co.jp>
References: <20261020031049.969895-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0103.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::13) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: 6460f543-c96d-4647-b0f7-08df2e57c666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|10070799003|6133799003|22082099003|18002099003|921020|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	XIiNbOeuJIDl+MnSCECb58LK5McS6DD4zGtLh2p83BLOFvz1T6uQ8pV4oM9QIBtc1kTRlG6KwfURjq/k6RSZ83DoLFDZbvDQwKYfm2XaKs/T9igR9fG2JaE8qpMjg90HgSW1Rda4Lqp3EIoBEB7FLXYogfGAy1aolh1kdXpDb6o9OkFBUa5+MkakTbZf5s75BioMnVPhl21Xyz1H5AejRE3yMxodjlN2ymn94/GO0hwwxpsuWZUcMHS1MQU3dGVNwsw93g4Xk0qoXbZI+hlsl/cbythCX8KVRes5CHGlBk5ul729AoZldlid6AROIQJ6oFtNCmFgbT1QEz5CGVExpOkqO3zP3kIHL39g0/xATO557W6jma2I94olVLJneXoWB4AGesxwWhSjjPt1T4LmH/olTn6Z7smUZ38yK7T/8dxhROKEssh3Hp34fOYAhDTx++VeGsruzS2f2YOQ43DO+SghZm6Y+UJgO9ibZd9EkoWku5U4W1llY5WpTC/Rzo/AxV+z9rmImNFmbbEpgaolGM08mysv/bsIyIuc0jPTT7rz8TYHBJ8i3RDtqhOg9a68s8T3ER8EDl7SkO6fm5M+Sx+jS0Wdskpvp55CyD7EQTxZnPFJklay5C9+FoO2U2JssvnGDmG4IyZ0UYTF5dBWfUi16sr/5+2uAiCpsjVzVlQv87HTaY0aXwCu90V3uDOG+60yW5k07E0kjGv3MNnjlw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(10070799003)(6133799003)(22082099003)(18002099003)(921020)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Lle2P2mRpsNqTI50H+bMXz5NRSSdh69B8J7NDayZ8H2swx2Kp6d7X/sTulR?=
 =?us-ascii?Q?BthHIfQyZxo+Zyw5nK8z6kP+gC4ffYF3HWjf8Nm+XsvOdMVSnd8cQb0N/QL6?=
 =?us-ascii?Q?fXzSv6OIciwB8jBs9j+QO9Y8caWOwFAl2b4KH9tWA4/WsF6l2U/wothSiCWF?=
 =?us-ascii?Q?qMx8bmnks0Y4Ev4C5+lSme8EQAF7xTW1VYoD9XEr3mSXWeuHFXM7IxG8ubQ7?=
 =?us-ascii?Q?snRese7tc5QlCUuWSSud2PkGQ7DVyJiQxfXsBaL346AWiR9knAS42WHSctT2?=
 =?us-ascii?Q?oBdPIvbLHyT8/no1E8iqp8+8/VRJrYttsXuX5sw52mA6+nodIsBRhTxTzdML?=
 =?us-ascii?Q?MumkyiOdq8LeiiRoy18eEbV5FmLG02mMJQ1kftmggjcaQEn1uRz/up/3oWSg?=
 =?us-ascii?Q?bxxwsO4EZeOJ4B35WWTCIwsaD1NvD/vzHr13TOS+1lfZVSUfgT08+9sxOegO?=
 =?us-ascii?Q?9jLHUKmFuBxpzn7EVkq6ZWQW4y3tIsaaKMhUQheBxhmkwcAnXL17+PtQFYrs?=
 =?us-ascii?Q?NlSzGtDVDXFq1lyCwhh16J988GoxiPMnNMSm2ZX8F4sEHR7ghG+V6dpghe6i?=
 =?us-ascii?Q?/IWbDw+kFmcUoEM2ZUrY8bDNtUvUEObo1d8zJN8cFwAFdool/inonSAiGzkX?=
 =?us-ascii?Q?6Y/awBsIN1YTI4K0jQJIuuxhPEcRZCdYQrmR0cfdYSUnNeWeo52gVjNC0REw?=
 =?us-ascii?Q?Ki3rzxWTKcYq41O6cQLZbVKGQIE5BlZIPW77A82+XaOSPyRCK+BbyzCAw7ie?=
 =?us-ascii?Q?IfMdgy1iWy4TcwZBu4SWO6/ca8wR5OApg3jdc0/vOLsm4dfdZyPvmelxSlRu?=
 =?us-ascii?Q?RtpqLYFozpqjlnFAW7Kxe88BZT2nF9Li9Oo/zQlC1ORsQF7snA7hR2ADWfbt?=
 =?us-ascii?Q?MoPOqQ/jqj2jUC7b+b3gX93UbkIEY0G1NMdosPY/d0hA96IpVyJpnKf2JTu0?=
 =?us-ascii?Q?U0+/sBVwTpRPPA6zTxhrjxl2oJaBYgZcNdBiezFOVHIdtXo6tgkrs9YdDDOG?=
 =?us-ascii?Q?gPPj7dOWvO/pJ2aygvHW3i++JVEAl8gqCJ9aoWpgr9Yvd19bccEx+K4SvaAY?=
 =?us-ascii?Q?1Y/PK0Z81gxrX2w3yVS11tLppte9c+AOxh1WAQlTVVM7ryXCebZfjbTNy4IO?=
 =?us-ascii?Q?eOZlifTse61M/33v8kE+mcxq/H5Qm0zv0mRmR5wAlOjLzvsw+B4lucdEQ/On?=
 =?us-ascii?Q?1UELCp6GMjdbWHaD6QeZ5i95H4Ya6SewL6sOHp5tpt/IkZvRXnfj1Ru1sNDI?=
 =?us-ascii?Q?wYitFDbqHLGxcD9de2Ig3K9oPAHC2RUgO66BlAizHOPL9TVGxiZSeSgUHRn6?=
 =?us-ascii?Q?U+GUKLEUnpvlJakGeUKrl1vC0fwcwSvbR2FX5cAh2tWcka02+y5FM+QbUsqz?=
 =?us-ascii?Q?nYGGFZy74IGWmpEQrt1fqMYL47ne0/8hlsPhL7+iV+XmFHt7104Ac+N+2DAF?=
 =?us-ascii?Q?aO1B4X6NUyZqSUFr+5uUDJwdon1kxwGEuxcUj/TtQdkAKhDBW30WXj0kHSTQ?=
 =?us-ascii?Q?2oGkj+pXJfOW/pCuBrZLM/+O6AuExygU8BCW2IBwrVCM54nZcgjRCqswW7dR?=
 =?us-ascii?Q?noECvvaEhdMh/yVrRQj3T0W29yeqq0S4SOzAK4sLc5Gyeare3fUywdXC2PQK?=
 =?us-ascii?Q?7EO+pfFECN0Htb351GfUPaYFslEPcIf4yOldegEtU5s8uPTEBeDBMFy7QmuH?=
 =?us-ascii?Q?uDob9ebWlrKXHBTB2gtQGrjGZ9b7JgzQwHCAYGtW9HLo2/4y0w70pRiqZvJC?=
 =?us-ascii?Q?5ZmgQ4EP+X4UPKsgM8woAJ3CO8UTKwS5WY+ntqsr2kli8KEz0IrK?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6460f543-c96d-4647-b0f7-08df2e57c666
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 03:11:03.6391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: knVblASXld6w/saLKHoyh7Q12a/vStTooU8KsDFpL8k77oPQs2/2IVsK5sEY+MOcNVaI9dV+kJID1nCRS/hfSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7503

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

