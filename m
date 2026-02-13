Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012042.outbound.protection.outlook.com [52.101.66.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072C51DDC1B;
	Fri, 13 Feb 2026 04:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770955752; cv=fail; b=p88FEtR/jAlroSYEhvXfFgqHkV+9gYdqWegHhlv29UAekkZ9I3rBHPVeh905CTBYBC0HDdeaCjutEKlw50yCWVoxzYRt7AIv89KeTim1aRzSFBQQ0G/SsQkz0Dm1ImjLJpGUe+JRdGkeKYanFl8voH3ZTmnNrsb2bV+ObBZ9UBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770955752; c=relaxed/simple;
	bh=AAkUszj6SPnK2uMoevOU62XdwWErsKVAqBVjYvH/RUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sN4ILNa1GHqde20Q7KH7PmQTmYhVkhkuj2DRPt+92HldijenAKMJ5YIhv8jzyBGMHRFHcDN1EDd+2XplUwAxmM7lz5HsLXH0hMuPd9+JtmBS56Lc7QMBCALJL7VpAmPELr53krdBzJ1avKuf12mAwxbdxNUPcVSc8/PvrZoR8nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aZgI1W12; arc=fail smtp.client-ip=52.101.66.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aZgI1W12"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ouqg1G1uOxjUAQ4fttN0THI6y8HWcknN4L+dBHQZijH53lNeCmwmRc/fguwPnRH8P8b3iyDNPKQlS1mkaU5ubkTCGm7QpODvtVHLpexbelkSxpJv0cBi3r/tlUKxAXtu3CvnwMpy1+Of1NkJHkxWCYlfmc/nu/ZR1P30K5MF6MN9kS2Dto3iSKJZ+pu2AkWPZom52zj2COyKfyVQFbisga/eYOz2aI0X0iJuz0JlW8SGMOIqa2SN0gImRO52UEyVi/PcUWuldxVZDNsJcDEkSzqEoqGc6/IUqCxEp9kLi83aZvjleagZsJ872P0pQh4B2tRIrNpwfBUZur/ue4j5Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iA6HH3oT7NxLhdanoXDLc8ORR9yhZ3AIV2S3H1AIpj0=;
 b=qRxj9pQB7j/3MDdak6xnMDN0FQm8SstilpAitzRGypkQRYw+I84AVFhr+UJgMXQuTEC4RAScGrA9gH4URolAtdQD6xbeq6CvwQBNSvZLAN/aIGClUS20+JtIpmeVSpz5Q68IZloKqE9DqMJYw6xAIMUHX3j0AkW+JmODzHK0Tr97KCwJIwxa8r8MsrofO4oawF23Mho4DAtGPaWB7E2XGGN3gYcXAGpCYlnmdW7mrG5gN1BhwbAplM8jpruMku72OaG+DKgDItUGDiMU0O0fz3IThVIO5/e+utEvpx7eekFucV42TIA5E6TbyYCIm6Fmkxh8X7gPVOViKrs5UFz4sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iA6HH3oT7NxLhdanoXDLc8ORR9yhZ3AIV2S3H1AIpj0=;
 b=aZgI1W12XkGmA+ER4R5MDu7P5g3mW3/+JVle3SZ07c5Tij9lA2Nygqb9a0HJCrpQJcfugcbhpc3/w0ui9MqxKPxewwUQaeV93UHJLVW2+sJVsPJvtX4OvZf3TT6m1JrymmizkRDMkLlK04HWLByDHQwWXzfXYr3JIqY3tZF1kszT7+hQ4JVLKcjlntLkSCUD3Sh+K5NBvhiLWt0QTmslI/Z9djffysh/Tw/odEa81TJ4KTcUs91q2fPkyO2ISD1woJllfSinjcg/EWcTA8QGIAeFEChNw/37Dzkdvblacni3WaD6PTz7UkLaMZyij1WxuvnZ99N1gYZvB1Puz3UhcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DU4PR04MB11900.eurprd04.prod.outlook.com
 (2603:10a6:10:61a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 04:09:08 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 04:09:08 +0000
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
Subject: [PATCH V5 12/12] arm64: dts: imx95: Add Root Port node and PERST property
Date: Fri, 13 Feb 2026 12:08:52 +0800
Message-Id: <20260213040852.3340547-13-sherry.sun@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 48fd2b0c-af94-4cbf-9225-08de6ab5a2ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lT3Z3wA7hQdbHcKcyW0eY9OnHSK+LrTwEF3NT6WQPWc0rGIV7OrrNLLJ3NDr?=
 =?us-ascii?Q?rds5rNpotHqXhcm2qMgMNTEThOoOwvfR1agUQ4vuYNlcWv5f+ZCN2KoDVCV8?=
 =?us-ascii?Q?7/U3S9hOHtOx+25jIFPre6GT0lC7Hjl4IlnAVW/AKrZXuX9+ziHjIkE5Z2d4?=
 =?us-ascii?Q?o+dQqKPWEz5qfIGdlvTSykdYEIBTIsEAde11wnEcBOjQ6jINastV9mP8Dj5T?=
 =?us-ascii?Q?3rLH6fOBefZaIfQJ6TTa2LT2SmMJrr9hS8x6cOAVPTTUTJ4H9j+WCOMGGRPW?=
 =?us-ascii?Q?UY2nXEDdjVTiWKhGuX9WRTrdASXfJ3ZabSaWE7/uD9c5gA+H4ajOoSVU/TRc?=
 =?us-ascii?Q?TzzNwaLeQ59vVWcMv+vS/svRvPPdGO5Hbn5gwEz4VUiE1LAkEt8hsP0y+bq6?=
 =?us-ascii?Q?9e6uf1PGtgQZacsAb0pHCycjaufGMiIyH+Ww3YnJrhZFDgbQOKsAvg6Ul9Iw?=
 =?us-ascii?Q?pe55JpkjIvX9HpF2m17US+PROkdh87Nb8jTKlGnp3nU1x2HlLpTIAg5rrTdG?=
 =?us-ascii?Q?PMB/fIkcypTdWJlEVbRnFnmqm65PzPIZIw38Vv0akzt9dPTpfuqrDBzozYHo?=
 =?us-ascii?Q?dCAEUcBWN+41TLjudQqI6yiAzp/wtRkHBxh1ZzXxrNNDx7DI7zCKj2D4Iw+H?=
 =?us-ascii?Q?d2g07KZC7b2ruvYgVQE4xhfCinPQnPnpPZ0+KvbGfBGhLSILHh1MNBS60/+s?=
 =?us-ascii?Q?nPeStulYHrHgsLr5QxEnwg1GoduKVNAkheadz2N6gYA0moqhh0TSed/YXh4G?=
 =?us-ascii?Q?eFPshZhbLuuCWKz/udkP7E1TVNMzVqUn45eEWiPFXW3aB59kayS9Hgc+kElm?=
 =?us-ascii?Q?FQP93D+deH4j8nD0ZCG6ZGW9SD+jqy+J8z9dehHd/rRxE0ADfjKQuQa1CavN?=
 =?us-ascii?Q?gDpK//nBUsXxVolwuSAxamGwyo8hYEJdGezEYNhJrSNJKnsbBfI6k3fwPV2b?=
 =?us-ascii?Q?wYhoF4ZiA8rnny4Ksf2izTyt/4lCGPdVGMSwP+qIG2ZhAelq1Mg23yocbuW1?=
 =?us-ascii?Q?16t6iJgpyznhfVCNWp8BZH5H0kVhEX+Yxt1dFoo7mLh8sq9iP8J9NRUBlSeY?=
 =?us-ascii?Q?HavKfzDhX7SsPShPP7YgGKUTsaaY3s1h5NOaOMN0A46js6TqjDeBJd+4z9mK?=
 =?us-ascii?Q?Ncl8ZOXhylQ9Juh+Zw0agHedIBEyVHtSK/9FeavKj1FwNHLvm2DNc+Hu2WWA?=
 =?us-ascii?Q?3w0+u5vdHS1qQhB92egBHPk2a5cXUCmVneHnvSy1ATZiRFxhQMAdytNkwVlm?=
 =?us-ascii?Q?4XLwGRE1YpAyfjMBVQXQ6YH9H+CBwH+q4H0m9eowLxDHzf+vlOJZsMWAmUys?=
 =?us-ascii?Q?YY+ZF3vf1ZSyxdASEwm6TdlOnqxH0IEQG7WIM5WATLPGV2u0WD+tjh2AtTg+?=
 =?us-ascii?Q?dWTOepT+v9FmocbrxnZ7DcLXnL2tFgZo7E1r5SDiDERxrZM2q56O1+EWhy8K?=
 =?us-ascii?Q?778mbGjmFn2N9NzWjbaWtnTG1BqHNLa4ch+R/Qf/oS6cZCHwDnE4Qs+mSRdo?=
 =?us-ascii?Q?Vqh/NyB5aY2PFMfRKi206eUuWx2+Mafpe159lWiobYzI8xdp1liIUiztcV41?=
 =?us-ascii?Q?tKMw7MX3/rKBfdZCroWrEewk02pyEdBvex/sKvTeSUBEjty09axCM3gmcy3i?=
 =?us-ascii?Q?fw84Eyx9bltI8P/c7e6pYJXKG577/dogW2LMzXLcitlL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SiWVuyKkAXvLI1KIwzOn/PLyziRk0ibxecSjF7sAS+98pEKKZ4+g0pi2DpFX?=
 =?us-ascii?Q?3UWK/j2iWPxwTb+AtAuXowvpgfw5gY22EHGk8R9U+SVIYYfc9MKpOrGizWdR?=
 =?us-ascii?Q?lHXLNiyy4PebZ5aG4IZz0ffHnTEQ/EFSXGFAVBrJ6/vobqt+Bq7/sch3/Vh9?=
 =?us-ascii?Q?OlhICW5qwtB0FeIX5tVE5KquojpWyjHtvtPnAeIBaado4z8j98Ol6aGoorsZ?=
 =?us-ascii?Q?U1d6cJQpIpZ/mSL8kdsr1HCumMxsLx1kG2rAVNcyegsLWriRlMs9So6R579L?=
 =?us-ascii?Q?cRk1haK9qkwbw9WQsHynAQt2Abzn8+hKkDlAqPTWPgXvm7uA8JKdVRDLHRCb?=
 =?us-ascii?Q?lfTzh0crM5ifuiNvEtiaEXltD0BB7rK1XISHWSWp/s+3BWRzxaV5eB+fOtOy?=
 =?us-ascii?Q?kKWnoZ5yXECSraXP551xq+tMGcxvaOV6yh80G1p9tN2+VOPNw4gNm3l6Hf22?=
 =?us-ascii?Q?n0YVmS7MxwqM1OHYzEDssvLE4/4ZEnBfXoUmyKrHDZ0XjH2U81cvh879gLbc?=
 =?us-ascii?Q?FS2HfByEFBr5+VcKkycJLHJPpA0WtThSeykXlK35QO9i/27+hSHrU5hGH8fw?=
 =?us-ascii?Q?mDTPGEzEei7tyQ6QIME5sljHoNQywpisQmt5Eoeg/1jm/6WtuBIN1Tdw0trb?=
 =?us-ascii?Q?5aZfeYINBHn4jQzThONDsm+XplemCGWDVT0MwWehtbOkZnxksIfk9fXnxc9t?=
 =?us-ascii?Q?1RsWEVWtZrOtPNsEO5iAx4s/9zc9da0CD2bPsDNMNlay6QPFTCOkyQoyPlxI?=
 =?us-ascii?Q?v895REPp3kf1rGdPuu/0BjSP1KVvs/GjYfqNFfPDavalP94xrlcKPWsvb/l2?=
 =?us-ascii?Q?rz5Qn725VtfPcCsF1lDlvTxh+UU1tSIE6M/x6Uy6vpdx7j4rRiOSUXnJf2Wo?=
 =?us-ascii?Q?n/HLSYWdJjdbx9pWN2Z80nEXo9oGCNA2TK26k3PKogwj+5mmzxjJU1VFf9dA?=
 =?us-ascii?Q?3EFaOcIuwBOQzVKyJNvslR9fU2aXa2EQGxhVtxlPeTrQmU6httYKTJk9kKL5?=
 =?us-ascii?Q?9/srYhEgGLKy1lLEjgZlqg79SQ1AA3W5nmDXTNRFEeEC+UTxV9HDsInjTpK1?=
 =?us-ascii?Q?BEX304LJZB7hQdUVQdoRS45N9guTOf0FHNSatIeP00CYXjgg5zllvYowsNWZ?=
 =?us-ascii?Q?suKG8tbBP1b6pNwoRy7tl+CuJ0VyP9pDS6x46um4b9i6PvaR0U8YOd1m5Ezp?=
 =?us-ascii?Q?SI0T5EipCDudNAdgXFLMGraMpiqPzWtB7UQSdLrQhr3D7AYTJTrij04DabQz?=
 =?us-ascii?Q?qQ7GGfe4W5P7erSY239NZR7c4Nx67ix0jKWKoDDAJrXI+vNEgS/8gVdv6P2t?=
 =?us-ascii?Q?p1D6HHBwMVS9Xyn3jyDa5tqcv6Eu0hi+jz+aK92VqxdSVTX3d/4D+nHkHp19?=
 =?us-ascii?Q?2g0EU9HEZJBhRlwwXAN5GOEAeQ8Qq1NXo4rEd+QjYhmmUoLGYy2ETLhVvVdM?=
 =?us-ascii?Q?F63wIK5g7L9yeOmmMZGC6Dqhk7uGLZGxpCzWv1p9aloJ2s1+rrJDu6lTbBbf?=
 =?us-ascii?Q?9RyBT9vREFHPU4uIWCKTLqOquyGMvPxJYCpdIJeq3lhO9UTs2ZfRNMh1/KhQ?=
 =?us-ascii?Q?vMwY7pbkZXBnttTxP5BtJwwjKB3FmE2Rjzwora9i3rTvcZgRurxSjml6n2fG?=
 =?us-ascii?Q?a72m27QhTQ0TYFjzvWICkz+ZAAjCJvlLhjuQNTq3wMs9X44mXAqA9JikRGN3?=
 =?us-ascii?Q?OhBjt4YYjsfVdW2SoLaD5Osb6G04RfJRVzZPr9KAss84JhdK/Pnenv9sJPNz?=
 =?us-ascii?Q?Wgd/gsujCw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48fd2b0c-af94-4cbf-9225-08de6ab5a2ae
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 04:09:08.6423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SfE4BLO0MM4T7IzTO4Uah7gnA6bs4rVwttyERsvJ3JbY6PL0Y58HXlypQrPYalLxG98jw5Srg5I7cUL8C59Jcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11900

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 .../boot/dts/freescale/imx95-15x15-evk.dts    |  5 +++++
 .../boot/dts/freescale/imx95-19x19-evk.dts    | 10 +++++++++
 arch/arm64/boot/dts/freescale/imx95.dtsi      | 22 +++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
index d4184fb8b28c..42bc09e48b80 100644
--- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
@@ -554,6 +554,7 @@ &netcmix_blk_ctrl {
 &pcie0 {
 	pinctrl-0 = <&pinctrl_pcie0>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio5 13 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_m2_pwr>;
 	vpcie3v3aux-supply = <&reg_m2_pwr>;
@@ -568,6 +569,10 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+};
+
 &sai1 {
 	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
 			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 041fd838fabb..6f193cf04119 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -540,6 +540,7 @@ &netc_timer {
 &pcie0 {
 	pinctrl-0 = <&pinctrl_pcie0>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&i2c7_pcal6524 5 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie0>;
 	vpcie3v3aux-supply = <&reg_pcie0>;
@@ -554,9 +555,14 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&i2c7_pcal6524 5 GPIO_ACTIVE_LOW>;
+};
+
 &pcie1 {
 	pinctrl-0 = <&pinctrl_pcie1>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&i2c7_pcal6524 16 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_slot_pwr>;
 	vpcie3v3aux-supply = <&reg_slot_pwr>;
@@ -570,6 +576,10 @@ &pcie1_ep {
 	status = "disabled";
 };
 
+&pcie1_port0 {
+	reset-gpios = <&i2c7_pcal6524 16 GPIO_ACTIVE_LOW>;
+};
+
 &sai1 {
 	#sound-dai-cells = <0>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 55e2da094c88..7c5f350fe3a4 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1883,6 +1883,17 @@ pcie0: pcie@4c300000 {
 			iommu-map-mask = <0x1ff>;
 			fsl,max-link-speed = <3>;
 			status = "disabled";
+
+			pcie0_port0: pcie@0 {
+				compatible = "pciclass,0604";
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pcie0_ep: pcie-ep@4c300000 {
@@ -1960,6 +1971,17 @@ pcie1: pcie@4c380000 {
 			iommu-map-mask = <0x1ff>;
 			fsl,max-link-speed = <3>;
 			status = "disabled";
+
+			pcie1_port0: pcie@0 {
+				compatible = "pciclass,0604";
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pcie1_ep: pcie-ep@4c380000 {
-- 
2.37.1

