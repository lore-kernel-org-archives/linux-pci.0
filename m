Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795749142;
	b=0TviAfcujGIpeJmrcFZxdoMklw3cPKhqcYRqJ4UdxzEm2LStcySko4/TbSqcx4m5e5WL
	 UC7LPsYqc7jcBFUf0J2SgmdK/bgEhjouCJPXxNkqx4iGQrw86lRRELht+xNtBVaEPXknf
	 /oeEOrjMipHCW5Az0GmBNbASDd9s9UfH5riflxYytCLNEV3OoYP0ZiXTfoNvNjx36e3kS
	 U1KmctqRcP36INNoC19y4cbLwmkJIGQYy/j4cVm/PvNKx2xmSMUTQyPnG1wstQw1CtHAd
	 gTeN7J5anQ3HANyU5FgjpGG4evxW456ZslPTPDjrTCkVeJMHhM2kZXOVOp5VbwvlSGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795749142;
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
	bh=j3JBvKxNhCK9gGE/znC/Mb2IPqqtARK4XEynureihAA=;
	b=lk0YkKu6dkMOKuU5oL7ncyHA3WseROQZ1nLFJ0aAG+temSgSLBc8wuhsoS/C7/tuAnRf
	 b+xcEq9S2gystfNoY9dfLs0bLpDRWjRq/zpTEj6uaZTojAoHV+wgXg+kr+xIE6XPZEUCj
	 itB5KBfNjJhlrUXcRFEqQa0rJa7QqPqPAIpUOr5vaC0GLQC6Z67/4Y1MgogjVJMEETUOe
	 hBUBCXkBAZwLhuTNvLvaVliHNwYsYACMMlCEp9ZmF1vwk10G28ayo+32W967A+YkaWTVX
	 7g3bmLENdq2BHLj8G3NSmu3w8epWVuFrVE9/Ps/IH3vBsa05LxDA1l0mNZ6ymQYtCxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b="T/NJ8XPC";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021110.outbound.protection.outlook.com [52.101.125.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1170606A32E;
	Fri, 27 Nov 2026 03:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1170606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=T/NJ8XPC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hr8poSjs/zhNBszLCJ/eR7WdnO+N5hi6lPVY4PZM7YHF2tAa43JWtEuCeMTx81jPEoCEGw330e/tRhGqY0snSaTs1s7h4uWWDWBvF0IfsC48yEHBlZoSilJnJaN/OXNMo09v8Q3naoQcpwRXetv0XOT/KIoudz5OtGUVrxHweHwSfFd0Ex8pAWb5F44PhXaD66ZJO8nXtrtCPSVMFVatLtfZFTds2kqTXiwQXEWnd2MopD/K+Vqse9wBk30GqBdhtsW2/bUeUD9hkxvKkAISfIVwVIhpriaqBuOJ/SzPkTMeg5A0bWrYPYfVMdpBOMwUZa6FLxYJmRzwn1HbJZ622w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3JBvKxNhCK9gGE/znC/Mb2IPqqtARK4XEynureihAA=;
 b=TbOFEckseuZwajLu86bgI3H7eaDcrDqLh0airIS8O3qD0ZDu0U2/4IcN3r0Qdh6+s+GO6RymJACXyC4J6WTNNUhBKfVoorR/sLn3WVM/2grmuEyh2e7gE6AQylMmbZ02ZUQcb90ljFEhGyQ96t9UkyUslDmbgwl3DJMzOLMnuWi/hZoLx8hQwGrYwcLZvXFd7Ty1knF4mY02nsU+/PZgEHz1rlsrhIQb+WMA0Cl/risE+BtvgYQeF+mWJaXDb83vjTm3Uy3JGg+iRSea7tnQ7LPNhmV/PHcUFMHly206RRefRJ+kjB1KGTwH35J56Vxf/HpGQkGdJ4lz+BsTd2wLMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3JBvKxNhCK9gGE/znC/Mb2IPqqtARK4XEynureihAA=;
 b=T/NJ8XPCR3fSllDpQ0Dh0pNdqLVstFSgxz7BpPxh1K7npW5GpPXemCefOVvPRlCFi9oxkD6oUSAbWRbQfqPkEuTlUZB0Bwx3rPlXySx+aI6nwBdtcK8LThBA7lb8h+PzZAlZ0bZkcU8xifxkWUdq/hzHMozDUkhnQ7oKvE8295A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYYP286MB4873.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:143::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 03:12:14 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 03:12:14 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Shawn Lin <Shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Qiang Yu <qiang.yu@oss.qualcomm.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 06/17] PCI: rcar-gen4: Move deinitialization helpers before SoC initialization
Date: Fri, 27 Nov 2026 12:11:34 +0900
Message-ID: <20261127031145.2521228-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127031145.2521228-1-den@valinux.co.jp>
References: <20261127031145.2521228-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0303.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::11) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYYP286MB4873:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a5990e5-977b-4bd0-4ea4-08df4c343a7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|366016|376014|7416014|6133799003|261009223027099003|18002099003|22082099003|921020|10067099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261021123027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	o0OsUotJeklR7Sut0Q9z3kjCd8BNu/Z5GGJVME86nLUMcF14Q0arcxeersxkkegWl0l2U2QQjAG22zXc0SGSm7t3AIaODPSsD+6o5Nll8RyfVGQvjk7xG0n66RV2+QygTvBj7D0dG6DmvT3phgfczMgmOOXJf1HVV/phE2u3p09UgG+f85GBud1q9zoZ1gNHrw4IGI8rKl/OtSgmm4poOqzGocnpzs2jSLNXMU2uznVNkbgQSU9kClasxEY1RwrXJrvgFQA8IT8K2l0gzXE9FKBSSoddjTdWJkrO4cnP0Pi+4x735IlQyCgpnq1KhWvnEJGLa4VZvZ4hj3H9scaIOQzkyIUNXnhpmTpia4gngvJFDBLHPKcnvvFGg4W2DiPI6T7mcjQkBtz3ydR+t3SBRCt3HUPLAxq+dfHluIvA0PojCkJjsBvs8Xnu43ZFMVIl46Kdxfon+DQlSUqphmkw9aXd7iLw271QfrFBKxZW0O7+TbUx2162QcaEYHFffp64qP36En3aHffrK6yzEW1U/YCdE5xUmZrfsQuyVInMAI0QsS8SfjF+crp0oC9InyfHjpNjXlCjBPnoDZ69RRDwIhmTzwgN32VY14i/5k6upN2H/kkBOE8S4WwxTyhNbreyaJ9CA0xji9vM35XZppoDtxhsLlzJ/3f3/bAiu19eODVXgKIbF0kuecPCUrB4nGc/MiohCAJRkZ1JBinJCBc+UA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(366016)(376014)(7416014)(6133799003)(261009223027099003)(18002099003)(22082099003)(921020)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022105027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tmzw9rQj8tGmWZwhBFKeMqt9tLBPKG6QOXWML0TFmUVIu+AcpwgXJbYCaeI8?=
 =?us-ascii?Q?4E3EWfIRbXvtzK6Ajty34LQfEHsy40t2s6a0BBlsQVbNfRPCJXGsPz51n/t+?=
 =?us-ascii?Q?Q1MRUsxcebHv6IDMCqmCNnT7XIfiovcdJtcAVIRUcT/dM4R6myJ/LjJahjbT?=
 =?us-ascii?Q?eaFldxoM8iNK/cZCoEQNICzmmSNsHYWq8tBvYaDWqqGlN2/qCL9hGFi0ipK2?=
 =?us-ascii?Q?u0+oeilon+bcIP6X+IsCMya+78hwPFtPGkGjcI0ol2yJsM/NvqEQUCAnXJG5?=
 =?us-ascii?Q?zk0h07YajYQLnDnYxxa1S4/Ap67IjfTdUq58GIiPsTLftqruzYXHvEUs6HAj?=
 =?us-ascii?Q?iMCy5I39Trmm/+1lgPn2O9btM98loEvGjsyI74ofOQh7CNDw9sllRPLnk7Py?=
 =?us-ascii?Q?uyNjqpMcXZp/ochfQPCoZdO+nre/qMdv4YffKE/w+HDg95JKJJ/wzUoEf4vU?=
 =?us-ascii?Q?jt9MOujya3uaOFL9CKQeDWUb+1EJrp4jMV8AeEoX5LJvV8V63dX9t+yjb4/C?=
 =?us-ascii?Q?PH5cuO1QQ9y7H/8MEZc8oEXXE0dWK9GH1dTM4WfeeLyPSAw/egJpkC/ZzBo4?=
 =?us-ascii?Q?PKI5h3EG+S2XT0Y1EAtBk/bnyz7d1JYHviJbQrluMt70qIwQmt12nN1hNLrO?=
 =?us-ascii?Q?dfSaMTEEWla+l/wQch9qEK0tapX6Hz4VNbf/9bC2XFJdSmXAnctnWQMR0b7u?=
 =?us-ascii?Q?qOA/SdxcCNReRnVLNgR0K/oCPOiK5aupLr131evBALIflbpuPYPaBHMBi4Gc?=
 =?us-ascii?Q?GIK88Fwjq2OuBfOWB/a3u80j2YJyUwJaprgO4M5gx6MZKRYAlGZaTQDLeYfS?=
 =?us-ascii?Q?WDrT3/lMp6GyROGsMD5kFuS3okfs0U65pmROfaE6Ecjs3dTP7BKtQ4njk0YM?=
 =?us-ascii?Q?QNXG9vb4gI4x/BGVaCs5yVvotHx/u7/9RTE4yVGt8S4Lpa3XWz6tuIkd0+wu?=
 =?us-ascii?Q?wQyPi+5ZNtK9FVvMdZD+CX0vhoxf76jnKEQM+lfDEg1+QixmJ/Q66/m5E0Nq?=
 =?us-ascii?Q?mvXLtttHhhQXc+kIyAbRRAitHCNiwqMXMsCrrcwRG+b5PpdzWmZLsaU1WJG7?=
 =?us-ascii?Q?KaXn9s4sr3DXLhzPcniyY05Epy1KL6SVOxMoPcCVUO0t4M/PL7B9FehlxlYM?=
 =?us-ascii?Q?jlnddyDrc0XV/nNqif6nn1+ltVJ1NKAna+26RDYma6Sabl9/cpTLr+3OpGkW?=
 =?us-ascii?Q?ah9DA8XGBFZRmMr4Z68bZWSOOF4sYxMgoEitmb0htmh7vKyXcdmjGv6dfEhM?=
 =?us-ascii?Q?eXtLr9H5C40dWMBaKbG2/gp8Shrn6JL5GuiOxBSbEDi6p3N3ad2UmfQIxofg?=
 =?us-ascii?Q?ekQ3iIdXSnQjqokdCaVSRAlKyODf+3nIs3DroVDxAPoMGazDcFLThPebMPJN?=
 =?us-ascii?Q?VC5Jc9HrX6wOKB/pdhE5aso+urkzuZpXbGgdDD4xQ5M3jm2jWzaXHH4uCamt?=
 =?us-ascii?Q?XgUrtgHvaGv9hnWMgscthZtqqpYEMeCWOS22R2kGIH29kNGoFa8p/OHr6DzF?=
 =?us-ascii?Q?F1wyeFQwesEhk38Zvjb/S4WbiMQOs6qZj9fFoYyrGz/Rj/FLWuU9laAgRGsk?=
 =?us-ascii?Q?6eJRRXpKYjW3hst3qwRBSeJkahbeZ8nzMldcgcIs900pJRqkeYw4SIdt4kpm?=
 =?us-ascii?Q?IALRmPqoivdsNezBmf0VjD/uPfKFimJtxVkaNRa9+CekpauIWWrDVaAcpx1c?=
 =?us-ascii?Q?CQ302Gkkg/H5zAVPKQmMk7QF2oSdOjcjV+l1GNm5W+ue7H2lmSkCe6KRjRcY?=
 =?us-ascii?Q?PF0MTSKIBAWTausf0xD7pixjkMIzh+9XSoZEb/cz6ceiCkPbsMSQ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5990e5-977b-4bd0-4ea4-08df4c343a7a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 03:12:11.5376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I9JfjvPWiMeS3Sf0wqZDYHv2m3F2MYp0rqpNEUu3OGdwS32Wn6cTfxlKKM8h/hO1sKTF/kalXjejhxcbz7gXtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4873

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
  - None.

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 30 ++++++++++-----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index c9ccdd0a7ee5..f0ff94898951 100644
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

