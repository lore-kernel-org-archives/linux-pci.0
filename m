Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012026.outbound.protection.outlook.com [52.101.66.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F6B25C818;
	Fri, 13 Feb 2026 04:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770955746; cv=fail; b=KhevdB7jIopT42kMyDP50Pxqp1DSwVXkkV88K3LVaB6R73Kj89UthPvWCnksRpl9KhFIMZR+Gk0EyQ8tszGchMgTn8QqPIpALrvaNhtXoHV3aNtNkM2dgR3kWY85OT2kuJ3QIinAlXXgBSP8EZrhiWrG3puodY4ae64NBnV5MtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770955746; c=relaxed/simple;
	bh=JzAh4R/6Uc+iZaymM5PvLQQ9CaVnvghTAw3BGlqR0xw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sol/IgI9IWAUo8UZq9JU5CG8KHaACmBLndrVrqhW0j5y/hoVAiqaVrEANKKmt8QhWtqG+LVIM6Xii2xscZh6PBx1DxFe2vWOpseBG7BBhntLkl2DWrOKlY+0bXS6fgHdy8WaNnW66kAqYP20KyiNoD+eLoD1t44TDEwhZ6Zfh2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hs36aCvC; arc=fail smtp.client-ip=52.101.66.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hs36aCvC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxk9i8Oetx/aZ64zlduBa990mgNJQY/r3PIVEMGAss45GLhqGnpNI1SYbgrwki7PlGEpH4oM2zBq9NxwfNB3Rw+7pL1e1DDyyI+EN7uhYYdjd+Scjqduf9yXL+m9aXM4htCAyDFXJhtgyM+e1Kcb2qAnO2EpfldxLBhqWKJn6eWj/1YEd0NdFByNALolAUdhegxDJaITYYVnTkbTdzhKjPsL+KVH24+l4l7xCslGdDCHGyUAhFp9Yaf1kPwt3C/znv0N7gMd2awrpUefyGStN0YpQytTz1iJe4yfVmfio5KMmC4meJrU/A3VeoldAhIkDdhmZ6smxc+xwgT5hJmZxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f27SUcPc/7GNnkQnoPRzUdp6Y0/1ifunguGbldvZAMc=;
 b=K4MlPwuPBZkf47SwgvYLcRxpw2ax+omMSP4GlQnP6BJ3YBp9NbsFjM/+hpTdghPZMEn/xSk4AIFNErk2yiv05ezgL3rIqeB3M80+fq69Wr2fddutm2wlE/UmxDl2YHx+ZhmAR87uWefSVC4Y4hia8YiQzL0uztTCqgKllZuTC5L0/iY/cNemDews+MdoVMXBtBcOsfEDv93R1S6kvqWychJQR1XLJzmnmF2+3Er6t8vbEaEBrjHdhdHVWwLeVr+3TKPQgyoO/pKUoKk4OVUddTygjU8IwsSMVfv2jtJtIUOftFeP2jjjoNp9stHw7H1AL7GwqZIR7XJqLDtO9VeOYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f27SUcPc/7GNnkQnoPRzUdp6Y0/1ifunguGbldvZAMc=;
 b=hs36aCvCYr27aQexVq0NoEjBTzDnf+NHsZAyFX7qaB/HZtrZfknyYtxSmNS6TiB8Df7y/CazDIutCcIi5Le5XHpMx6uGepi+4yck5RwrH3iJdpMn+RsTnKb5YuAEVI+BkUMs8y0sm9GcksyOTuYFZFr3g0mxx07gEvL4C3RD3ZqhBLjbqDA5CQ0taeiHSPQ+bLRBeahk6wcwFj/861ahkFsnn4ae1E2P/H/iobu20Z63scI1yUpUJGAme6P5vKPv+mwfXsWnyjjS2wy2MZLqISSzTdTTvboMJ6NWsuEeTVWfG3f8N+X+PlNDSHjR731QlGCR66qI9y/+qwYbcpAG/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DU4PR04MB11900.eurprd04.prod.outlook.com
 (2603:10a6:10:61a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 04:09:02 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 04:09:02 +0000
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
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V5 11/12] arm64: dts: imx8dxl/qm/qxp: Add Root Port node and PERST property
Date: Fri, 13 Feb 2026 12:08:51 +0800
Message-Id: <20260213040852.3340547-12-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260213040852.3340547-1-sherry.sun@nxp.com>
References: <20260213040852.3340547-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0206.apcprd06.prod.outlook.com
 (2603:1096:4:68::14) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DU4PR04MB11900:EE_
X-MS-Office365-Filtering-Correlation-Id: 237eca30-1dec-44aa-3d40-08de6ab59f11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3UASPohd+2lFiGLIOfnhgeHiLKmFmmZphxl2UhjrZaFiW5SyVBQyXtq4/ttk?=
 =?us-ascii?Q?CR3w8aSaZ9DLTLjA2AG//9IFV0ZFPOfuMLuv/VqC5ron1IkSaBzSEqWnkctF?=
 =?us-ascii?Q?2U3Vqo0nIJI9vNDMhM24gjl0IO0LHKLi8JYQHFutXhbQ9Jj8JLQAvOiU4dQ2?=
 =?us-ascii?Q?kcJTewygghjgDKqSxW7s7jJ1MFx/NgIITxkCBkQAcT7z5zr5Se7SjRp7lxBQ?=
 =?us-ascii?Q?C06CK/VvQaCvx3HHxXw06ujrgmpT813G4Xpf2cQMqoOICKVsmp4Nm9DDwHvM?=
 =?us-ascii?Q?fH4A3DOceAv6pXgivFIxUJgaHztk7rNRo7G9nNRyP7xTcV7E8KGxbuQ9DPYM?=
 =?us-ascii?Q?pTt2HqlgXcqBLYgLCfJDrpfq80EQ3+YXgBgSF6kxhKKN9J+k2JEIlQs79YMY?=
 =?us-ascii?Q?QwGJKrjsh+LRQjkycwzAsySssPfqYLvyrG/+TaLSzUdCBHpQYnbLNBFDHq8W?=
 =?us-ascii?Q?ev4sGEMcViCHaFBBTaQ1dcukgkGAMQ27H5AXZiBaPQ/LOzzv0jOUvTslewLd?=
 =?us-ascii?Q?K33S7nNDghvPfrkkpd+aXWQFGKdXELBfRcC8rGQiDN2Q4bqxzJ97yi70jUo0?=
 =?us-ascii?Q?peOmCM1fsl+Fd/w1QbGW5usrxAk27v/r0y5sk7ufx0kok/9k5g0ESyIKTdzl?=
 =?us-ascii?Q?miMzktwSOccl66U9fGKsM+3HGwLSvJZStbmQPDxoJGXWsu3mdFOvIEWJWTaH?=
 =?us-ascii?Q?IB7s8jxqEgXzmsa2/YOCXD7RilK/W8y8UqUFfew4917275vwYYICuL+Phm52?=
 =?us-ascii?Q?1+00QI7qXPtkHSZ8bzei4xTWJHKvdWWdL92Txg6FBqIW3MHxU0TIj4OvqT3z?=
 =?us-ascii?Q?NT8oXnepNWzOYRo8e2unhMISPuZGD2/VKgOAjNpzcd1wqyky8VqpowRtdJ/X?=
 =?us-ascii?Q?1VOvLLRNRJ+nXwe8oVIyYDCnB+uSqISFZukS0SZlPkSFXVw6kQoFN7sETpMZ?=
 =?us-ascii?Q?qq09D2pWlczS2TCMECxWmYLooXPY/Af6jbB9BvLRS1rUOKfgXMmmjcVobueY?=
 =?us-ascii?Q?XSb+15wUVOQJtKXEX5r9RtD8wt0XhmUUQKF8z3OXqtqiIsSBc2hwBoM2WfXt?=
 =?us-ascii?Q?mrf7QMBBOBCVcUDJJRCJzkHEBszmndqn97RNGPFzmT/Abo9lVZKOc5PDfzrL?=
 =?us-ascii?Q?afyDX+TzOPiDTTjw9jmxnqGb6fRL5TUaxDhVQ++H3rjmNO7A+4luGSbO2A98?=
 =?us-ascii?Q?21I490chu8pLM+ojhzISNWOwPfLvmspCkkvwuDnuDBJy4HwPE0Qr/vWia5yP?=
 =?us-ascii?Q?BFn33SZUGCxlKN/+PwU7n9Gfrdu7VCLByL4Fbgs3XhI4VE6YT+yBWmvGSuQi?=
 =?us-ascii?Q?t1iMBK3XyROKqME0oYbHMd2Pzr/TBSF9wV7UzB54btcOk4v4BWgtsyy8JiaP?=
 =?us-ascii?Q?IrsgAKSwk2qVgEkEvT+TlKtAkkCVWXgUlcTX0AqcXuzxz8PLQM98JIyvhXa+?=
 =?us-ascii?Q?9YXBMiOQHr7df+MCYgfcExFJbTL+Oho/FK98hvzOzXTxrbXg76qgx0i5gYwx?=
 =?us-ascii?Q?pAjxSdxTv1m56yp2mUPcfgvpRzFOqd0hOXyynxBeqpmpOff9FG/rOYOKj/6C?=
 =?us-ascii?Q?NWwaDYkN7LTiU1+VWKShYTZ+IkNroPiLbcxy0XAGwvvzE34vN2HXFKIE+V64?=
 =?us-ascii?Q?iLakSWMNbHU/9TzvoD1TW9Wh75pHGVKBg4f5hFK61aPs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nt858TYSX9t5E71UYP5RrVhay8OGDEI05uT/swN58OpkicHIY2UXFfdOyT+h?=
 =?us-ascii?Q?BBFFvvIWY8At9fQDVOIVWq7zIn/P6Wrvun621qMoGz9uyG64/Jn8EG2Mf1xR?=
 =?us-ascii?Q?3vDIEGpDvidrYiNTQsJnFnQ299oVAwQQ9Dbyj+NH6d9c5RYuTn1aEPQXSfrY?=
 =?us-ascii?Q?La4A81UZGyxljTy7UBE1xpYIyrdmRgprUGJ28ULg07h4LUmE9Y9IXBAERSjB?=
 =?us-ascii?Q?XD8hOl5BBlGJkRkpzFm/qyDZMcJapUwHmqaKyaXD3RIMS83Il9eXdElwyAn1?=
 =?us-ascii?Q?fGrYp7R/jL/HixoT1wvIyU9MvhbEXJMznbIDA9k8L5JRzVX74O9LbvGImR0n?=
 =?us-ascii?Q?sUVccEIUcxpG7j7uAn+PRaG7gVT9ZZZsl2V2EsoyNqt6+VitkcQJppr9ggZm?=
 =?us-ascii?Q?uOXCh0ruO9B+5DfO5t6SmtZhwzDOqvSRes4G7pk+pnQEXgNXLs0dZdsYZBNe?=
 =?us-ascii?Q?VQVvfSwUoJgNNT2N21ZdzVXSrwqyY5iWAuCUgiJZpu0XH/cecWiAKig95QGT?=
 =?us-ascii?Q?4jTepNZh2NhS8ipKIivZPQZKR/ogBMrw0M6RKJB6/lSG1tgxcdL4V/98asqn?=
 =?us-ascii?Q?NDPQUyFCn0TA1y05k3UVMYG8EqiPeXeiynQFPuRtd7jGrCMx7eFGNEi0FlKA?=
 =?us-ascii?Q?bPo3lK1balJU44Nj3sZLlwEoUfOTSfY7GMhQ+wNFtl9+pXmKMvq3kDDaW1XE?=
 =?us-ascii?Q?OWNjO0hyxuyZpqIkj0VGsjOY5nL/4lx9Rujb3nnlqMTzWvHepIYhEFfATI4c?=
 =?us-ascii?Q?9dbByHcn0PslsLpGCPn292IkZM7zValTeOHdhvUlGtbj0JCAwQEVDMBdSQ1m?=
 =?us-ascii?Q?5b5M15QtV0bBk8/DXXU3Ktf4U4jtD02v7VosOU+qLRaA9IEnjQXP667ASsc5?=
 =?us-ascii?Q?wHMO9c0oq9azeV2dr+b/SgEsi90mFo2ihC0cO+xW3XoDrS/GWg+dmkCPwQ5g?=
 =?us-ascii?Q?hGf70ezvIhAndThJphrtnRexHe/y9h8VybbkrLJv60gOqv/8etm7gT22G1h0?=
 =?us-ascii?Q?/SO+btbiu7GJfX1Lsett0R5vinwh3wVg7D1MpsZNIsQDfbCRlW0tFPaPtAhy?=
 =?us-ascii?Q?d3gJK+8Kmcg8ihuixCalqwAxKNJSy2uwmMvfg6B7ebSvB5jnARE7nAu8kQWk?=
 =?us-ascii?Q?duIWmO37Ua5d+xXC7ynDl6TEXWqhBNuGCWaA3cwK0PLZI8ug6d9z8kYb79Ri?=
 =?us-ascii?Q?PMxxy7BKSx16jfz0Va2YspSlyWwKTBf8LuYck47JNNcJGDdLJ5LnFa9vts+D?=
 =?us-ascii?Q?ax7S8MJWjuh3ky5N/2YDAn/70+CX+BEwEYfqsDrOxntngWCZ83+EzjA+kJeP?=
 =?us-ascii?Q?gBoLo8MKiLyYvWxg8BITb/hfStyAi0CxEUX9dseo/iRaFbr9l1w6UhR8Jpfz?=
 =?us-ascii?Q?0C8K59Men+hk87HsAxU1gIe5TFDz1f/AFGU291kBm8ET6OdJs+Yeus72w99U?=
 =?us-ascii?Q?IftdKSwrlb5Dp4iBJngpLNMlFd65N9++LZIfCpgVk72f00r12m3sIl8wyrLE?=
 =?us-ascii?Q?gVs8cDdEHnnZulIri66vIic/4Lzrc4CLWReqUinFX1292celPqZKwg2/PdKR?=
 =?us-ascii?Q?jdPITTN8PrzenuGUqrjgQN5ZXcWuqchxMHR4/rrJFKiUOM6s24YUvwuY3rPg?=
 =?us-ascii?Q?tc8hxqPyIMrQDJj5EUhQ5N3b9wDQ9bIdC/fWUea4cdIJNdiBMl90zL2B1pAz?=
 =?us-ascii?Q?Wx/8pXhEsz1j/AV4+kORzZ4A5cQdPvTJwpg6NtMxzTY4Q8DWTV8BJxtljhzY?=
 =?us-ascii?Q?MT8M/c2E2A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 237eca30-1dec-44aa-3d40-08de6ab59f11
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 04:09:02.4143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPplaZ5pmd4C3elRT3hkQ9a/LgWCOe+94sSpGLVngEz5N/r5YSZr+vQyZiIu5DYHWWE0EDGuoqbWarOHiuBb0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11900

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 .../boot/dts/freescale/imx8-ss-hsio.dtsi      | 11 ++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts |  5 +++++
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts  | 10 +++++++++
 .../boot/dts/freescale/imx8qm-ss-hsio.dtsi    | 22 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |  5 +++++
 5 files changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
index 469de8b536b5..009990b2e559 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
@@ -78,6 +78,17 @@ pcieb: pcie@5f010000 {
 		power-domains = <&pd IMX_SC_R_PCIE_B>;
 		fsl,max-link-speed = <3>;
 		status = "disabled";
+
+		pcieb_port0: pcie@0 {
+			compatible = "pciclass,0604";
+			device_type = "pci";
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			bus-range = <0x01 0xff>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+		};
 	};
 
 	pcieb_ep: pcie-ep@5f010000 {
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 5c68d33e19f2..8f2c2bd00cde 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -651,6 +651,7 @@ &pcie0 {
 	phy-names = "pcie-phy";
 	pinctrl-0 = <&pinctrl_pcieb>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcieb>;
 	vpcie3v3aux-supply = <&reg_pcieb>;
@@ -667,6 +668,10 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcieb_port0 {
+	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
+};
+
 &sai0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai0>;
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index dadc136aec6e..02f7589bd860 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -802,6 +802,7 @@ &pciea {
 	phy-names = "pcie-phy";
 	pinctrl-0 = <&pinctrl_pciea>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&lsio_gpio4 29 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pciea>;
 	vpcie3v3aux-supply = <&reg_pciea>;
@@ -809,15 +810,24 @@ &pciea {
 	status = "okay";
 };
 
+&pciea_port0 {
+	reset-gpios = <&lsio_gpio4 29 GPIO_ACTIVE_LOW>;
+};
+
 &pcieb {
 	phys = <&hsio_phy 1 PHY_TYPE_PCIE 1>;
 	phy-names = "pcie-phy";
 	pinctrl-0 = <&pinctrl_pcieb>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&lsio_gpio5 0 GPIO_ACTIVE_LOW>;
 	status = "disabled";
 };
 
+&pcieb_port0 {
+	reset-gpios = <&lsio_gpio5 0 GPIO_ACTIVE_LOW>;
+};
+
 &qm_pwm_lvds0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm_lvds0>;
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
index bd6e0aa27efe..48c29c2cfe8b 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
@@ -40,6 +40,17 @@ pcie0: pciea: pcie@5f000000 {
 		power-domains = <&pd IMX_SC_R_PCIE_A>;
 		fsl,max-link-speed = <3>;
 		status = "disabled";
+
+		pciea_port0: pcie@0 {
+			compatible = "pciclass,0604";
+			device_type = "pci";
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			bus-range = <0x01 0xff>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+		};
 	};
 
 	pcie0_ep: pciea_ep: pcie-ep@5f000000 {
@@ -90,6 +101,17 @@ pcie1: pcieb: pcie@5f010000 {
 		power-domains = <&pd IMX_SC_R_PCIE_B>;
 		fsl,max-link-speed = <3>;
 		status = "disabled";
+
+		pcieb_port0: pcie@0 {
+			compatible = "pciclass,0604";
+			device_type = "pci";
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			bus-range = <0x01 0xff>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+		};
 	};
 
 	sata: sata@5f020000 {
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 40a0bc9f4e84..cd127d0a0a75 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -722,6 +722,7 @@ &pcie0 {
 	phy-names = "pcie-phy";
 	pinctrl-0 = <&pinctrl_pcieb>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcieb>;
 	vpcie3v3aux-supply = <&reg_pcieb>;
@@ -738,6 +739,10 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcieb_port0 {
+	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
+};
+
 &scu_key {
 	status = "okay";
 };
-- 
2.37.1

