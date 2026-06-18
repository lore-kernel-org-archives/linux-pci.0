Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011046.outbound.protection.outlook.com [52.101.65.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822D53C4B89;
	Thu, 18 Jun 2026 10:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781777370; cv=fail; b=K6vgEzbJtHWd65MeB3zy+GHi5VSfEiVVoKxD8PFi/15zlqISTMwnqX75zk7gWsC4WJesLBi9s3JsWxCyGNBP69JgoWwwT0sglB+kw+figPQoYVA1C6L4W9aOmO2Pk5QYOeQT+EYOyhEhBorehyLcelAyrBwjepKpGuwLPfz/d7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781777370; c=relaxed/simple;
	bh=tMGNqJ75nBjqujhcHtKKTpSp7iFjiRyAnfY2CFXBUAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P4vp0KxAd5mgLTCRch9J46wBGNpX98p+mtTlU56mujF8dMtQTr4TYUq8grCHshE/YWGf/WxSesVct3Az6LbN7GpoboJ5l5UxnmNBmQjktACdH+QuXS9tRSyXVgDALwhfkXdi83zrdk+uFY2nRwhWNnKTJhb0uI3szjMFbdYq9+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jg/OP3h7; arc=fail smtp.client-ip=52.101.65.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jg/OP3h7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xoHMu5fuW+ZkCfLitpEFEl9rfA51qlE/xrRMrTaoPuroZ/5Fmg1AtIfxYzcWCPsB911CopCcN1DzQpEKBErk74X6bYGlchGMqCbQ971md6G9h7+9TldpfOs6Auiv200yzgcw5WzEFzdTaOQMD0Mdpjh3qh4dQwblRlf7luS83U4zlWQRNmBMwF3juMd+mWQ0qB1FU/tkOdfTZ014TWTdGEsgfxOUgXk4dkhTZVrp5lFhA6aDn32xJBpuFnDBXgf0/5tiGLF72UNBswkjeovVn691x/XNb9AZepNPruFS/8XygYJbKQk6+tZgAiyzkQrKQRpkRhds+6PguypQqJY8zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3JY82sGT6mGd4Eehns/4ctBimy8A4JopmnuLu9zBd8=;
 b=kLnrLHe7IehGZPyfRdnrmrkutgkjGd5y7iIEeaVxRlyVJPIzycU1YQ6o8+JkpHIvbp5AbMm90+c5qLCY7abzbKJNEYh4oOJBZcPWA/Wn+ODWBnI9BAx2YBYnpHQTudy2m693cmHhk2NPZ2Ptk0l9uhnVxxHZlj5gUWscFLmb4o6SqRjJShiNzQvnzOKRXBQLxpMZSSTPlEmxr3g3fPrIEYD2MWoIKyFEOaxvdMmwRxpJ4YJP01+XUAVn1urX0BtZsIPzlYsvZys6wtqB3imuKf09E8VDu3Acf6xSwsC4OzQBx7JnYyiocUI0UVGievGF6X4vJwbBaOc7993tqeRXeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3JY82sGT6mGd4Eehns/4ctBimy8A4JopmnuLu9zBd8=;
 b=jg/OP3h72tpay9Hkfy2eN/FAhntixd8VCgIF+Q0fJbMjdPDQsshpxw1xzY0CIFoH+rEqzp86SrQhrw0Xp6GCWETsd0TS8RMn4ZqwDQmcojPqVhZYtioFrUGza1CWpFtW6839zp7HEuh6Y11jwvd2tWf+C5bWyPenLNuQqs614nHr++xWxu12gHsMfoz6hzpcb1e2jVot33153EINs8GOi+WQgctZxLjpDBFDSZ6zVWL1XT4LSM0a+ZHYeoIvADz5K1yu1BfR7Wlxhrg6cAusXUpXn59UJLJvXc/FEHbeoICoRP/y0j2AjacWzdv9DFzgzAfiRXHS42PuXe/xjKCchA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by VI1PR04MB9905.eurprd04.prod.outlook.com (2603:10a6:800:1df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 10:09:22 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 10:09:22 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	brgl@kernel.org
Cc: imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-pm@vger.kernel.org,
	sherry.sun@nxp.com
Subject: [PATCH 4/8] arm64: dts: imx8mq-evk: Describe the PCIe M.2 Key E connector
Date: Thu, 18 Jun 2026 18:10:43 +0800
Message-ID: <20260618101047.4185497-5-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260618101047.4185497-1-sherry.sun@oss.nxp.com>
References: <20260618101047.4185497-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0163.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::11) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|VI1PR04MB9905:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c5592b-c65c-4de3-dcf4-08decd21aadf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|19092799006|23010399003|1800799024|921020|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	ViMOWqUZXV9N8qtMiqwtYIGIzuMfPhdS4g0BR4F522XawNPb/qLPi0AX67PTJVS1OrdlO0JJdmoTbH1Hn4iEPyJSVtylnpna9LMvOrklVR+3hPOgDg+5p/OcPTI+TEkOmx7WCt2+cuORSpeYfM0joLoZuGNRQnEcwOQ+TQrgIprPeLSPDl4cV6mpUIH3cWQl6tbHS+sgX2iY5XtYF3EMFb/BAw7b901LevKxSZVQnCy/ZnTw9P6vnM/pf+SJk2qk54yTyUOodrJpa3g7bqXCDJAtF5X6WvWt0pQ2Smtlaug2HtsHWEm3B/wMrxCbZZmEQooJOu1S2E0TXqF7AWWu20HsYEwCXNskmZvCzeF8X1xbfKxAwqpWo4Rs19YvYgdx4XRMr+TE8pzn4TayycxLBYNtiagqeRG05YyGDLYCV5rfEOl8nQp1zN8zTvgu1JG7pjijVHcfIjbf67qHficf1hT1KYbZGEM1IX9EHFR5F3I5RQgYaj19onXASp3UiL9eNviSbXC0JjZgiW6dan3Jqnm1XWCnhKpu/WWy/2p5bTnChL2a+QpZ+qJ8V4md4RqwZQILOUJma1bKh1dGNnGQqEjfn/Mk/SQYbZoV/fPLbkdUUcU06RVS+IXFCb+fGPtYhcHuI7CkH4nvoTAUr7RJpQdR+Zf7p6nrOvpb/32XHNddQPy2voiaRVcQyAaM6kV00gAcAWFVdHP9ngLkXV5cC0QxC4jD28xU8h0xikUV8Xo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(19092799006)(23010399003)(1800799024)(921020)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xt98JVyZ7mYQUD6w5LWZWQCZ21JkpyUhLuA0Rtqwjq8hzKbRuoxSI1Bf21dx?=
 =?us-ascii?Q?rnRRQN1gVWXjXtMOCw2175Sa+unX7NEgXqS7uz+SYt0fygyqOjimjbwQLxZH?=
 =?us-ascii?Q?MaEvmEOjw5OM9PaYadRMDPgLyuqgjtda4/VKuEPl+WH80S/foUcNAKpd5isC?=
 =?us-ascii?Q?KsMJVaSVx0QzedqNC8qSAHDD7mhQN4E4q8xKca+8FTWaXwW3of4Hq3UOYVBp?=
 =?us-ascii?Q?jLyIt/OpQsrnz+PSDSTlwTx5hYMQS2aLgmFPenmpRGGfjHgen6/y8eLyHaFv?=
 =?us-ascii?Q?Ab1eCcCpA9zlrMtHVuhlcRW0M03UP+CJ8ANfMsaPqeVao15CUj98psb7Rlx3?=
 =?us-ascii?Q?OmQ0omMg4scd4dhnX0w6XqjuOF6RSNj5/co7n2Jh2osq2tJV3Y5+iLPsArNm?=
 =?us-ascii?Q?NiYU28E0fBanKajQFTKeZzpdpPR986IVrsgnDlV9p0+BYZnOnsITLMrK2EEU?=
 =?us-ascii?Q?usVXRZCY0gGqkyos3msFleQufRROhxkTKUalfre/pa+fXr7cS4k7e+C/Y/zu?=
 =?us-ascii?Q?R8nK1V6idadA8h7bnZmIDjDazZqJ7amhKS7JEzkleFwyCsCmyn2DA90gUHD6?=
 =?us-ascii?Q?SmG4GISHhDnbIrXRC76CZeXOULWjU5/CrTW7fJ1o/NYPapyQJe0TwkxMnKso?=
 =?us-ascii?Q?KLC13TwTiuvda7JXttbfPDAGKgzzIWje5sWP22Rj+fNoN3kC91xNWwRigfYM?=
 =?us-ascii?Q?xSayVRIjuCoDXpQzHzt467HpZ7+VpQHRWLFlJLmxsNDxhK+QToU8x7/ABR4n?=
 =?us-ascii?Q?4/pnfoiu3Mzx4c3+NT9A6wqR3zy/+IgAq+TGHHmxKhmOyKt3LatJyflbU1hv?=
 =?us-ascii?Q?6c783Ugf/CRxTi2TpkqPkfujUZeajZwTugU6r0L/jwPh7jFZ8p4JKhmY/+3z?=
 =?us-ascii?Q?mXRDpXGgBBRy5UPSTPSKFiMO8SAAD4tLihNnyE4GO+yiUzyJTOyzSgg78GS4?=
 =?us-ascii?Q?7MHdEp37b4msNlJk0Pxeo73Itlr18JAbVL1MJjfi1p6y09p1uflX+0AR+ONe?=
 =?us-ascii?Q?cndv7jS+n4rO7z4BOhsidiSZydi+qJVM/r4LuSt03M1S8RldSqLw9/zRj2kw?=
 =?us-ascii?Q?Mu6dxZ9bV8oIEI/phaZbedZwpM62ZSzlVrF97AwiSZjHzTFeu/azIy1E8zB+?=
 =?us-ascii?Q?rGn82s+SjbobLNpHPf4UjZ2x0WjCfpRu7CrvKhdPXrsPLv1N9Y60pBBzY88b?=
 =?us-ascii?Q?HBXWOeLr5lqq6xzIGFALutz2OjD/vZpqFipsxVBiHUrnmE/CRuk0K842L2YV?=
 =?us-ascii?Q?VPxYG7r2QPX7BHeyocbVT3WgyXEahtrwKZCzSJJrd98Ua3LZ2HcKzP+9WjvA?=
 =?us-ascii?Q?iXr+/4cCaemEkZEzkdykHcAKS9kwcAEMlD/1aMzKD2Ab5QSIZa+MGznNCucp?=
 =?us-ascii?Q?jcPwdl+TKx2WuIFtkJSULO5TAqMO3rmr8texvPNzcjy6ctte6TipVyO9CCfX?=
 =?us-ascii?Q?sAlapYApjAD0d/PvQWgL72Dbxq4xIAQVCNWjqMVgu1sECSsKmXrr63XDxGoJ?=
 =?us-ascii?Q?d47PKoDGsykuOZ80Ly+d/aZuxTAFKDJcrmdmmqpDWW9vdT+2qmtjg8x29uMl?=
 =?us-ascii?Q?lrmJPO1QU1GOHDfRW1rZWqbEF/WraFqdJNWTtORNntsGi5gys9/oDUqMy6in?=
 =?us-ascii?Q?U01WrpD3OrmMyZ/ShWulpuTU4p4J6V+VJWCiaQJcHRy8BNEFtH5y0ay5FTtM?=
 =?us-ascii?Q?+IKVIguMh3D00+d5D8NLQGGcc5idt/59BdNXiy8k4MHozM7XdH05wfadrWVw?=
 =?us-ascii?Q?l/mig7gsocVo0piRE2sZ4NBhPvN8Z23+nK+ibIA98+KGlDq5mFdj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c5592b-c65c-4de3-dcf4-08decd21aadf
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 10:09:21.9654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+RWE77ItfM3B9iX+gDOP1OogwGe2wm1eBiXjmG+EEgb+QuwAFaLwKzx+u9SgnpWYDA04JfXpzA64ruOPOhW9sEpPmsvAddU0207ddxxwaaDLIhgnxOjMRYy/owokXY2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9905

From: Sherry Sun <sherry.sun@nxp.com>

The i.MX8MQ-EVK has the PCIe M.2 Mechanical Key E connector to connect
wireless connectivity cards over PCIe and UART interfaces. Hence,
describe the connector node and link it with the PCIe 1 Root Port and
UART3 nodes through graph port/endpoint.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 44 ++++++++++++++++++--
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index 71504a0af87f..482e5203e879 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -21,6 +21,36 @@ memory@40000000 {
 		reg = <0x00000000 0x40000000 0 0xc0000000>;
 	};
 
+	m2-connector {
+		compatible = "pcie-m2-e-connector";
+		vpcie3v3-supply = <&reg_pcie1>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0>;
+				m2_e_pcie_ep: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&pcie1_port0_ep>;
+				};
+			};
+
+			port@3 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <3>;
+				m2_e_uart_ep: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&uart3_ep>;
+				};
+			};
+		};
+	};
+
 	pcie0_refclk: pcie0-refclk {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -420,8 +450,12 @@ &pcie1_ep {
 
 &pcie1_port0 {
 	reset-gpios = <&gpio5 12 GPIO_ACTIVE_LOW>;
-	vpcie-supply = <&reg_pcie1>;
-	vpcie3v3aux-supply = <&reg_pcie1>;
+
+	port {
+		pcie1_port0_ep: endpoint {
+			remote-endpoint = <&m2_e_pcie_ep>;
+		};
+	};
 };
 
 &pgc_gpu {
@@ -506,8 +540,10 @@ &uart3 { /* BT */
 	uart-has-rtscts;
 	status = "okay";
 
-	bluetooth {
-		compatible = "nxp,88w8987-bt";
+	port {
+		uart3_ep: endpoint {
+			remote-endpoint = <&m2_e_uart_ep>;
+		};
 	};
 };
 
-- 
2.50.1

