Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011062.outbound.protection.outlook.com [52.101.65.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3245139657C;
	Wed, 25 Mar 2026 11:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774436494; cv=fail; b=LD8ieYW4/b1NQOSw+/vEnaUwzuGCM9fILUgIy/hA2bNhiKhOGIb7Am/rk00yaF0wsgTxmDMXgyFzaf2FZXVaGJsPy1XtsDFb9byFQwSDwbvpB6ZFGlJRdeJdHjz0RtD0iWYHqby3uz+UDaZRkbdjbjwmarrbmBVdxEMOTEnI1vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774436494; c=relaxed/simple;
	bh=XMoCZ9PvdukFHLgeKUXyXgSYimHLunDq310RbLkiNtY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bDtaEU9DVd0LCCDVUOVDvHZ3H9nIE7BgCWPMv2pFRACWvAiWB25+Q8kX0x/k9jzYBwvR75JWCjIox1CXIWevZ8ml5cDVH/8B05p6ZD+YLwLtD9s86n2uRgMpx6/+ZKABFvFplm8qb9ePlzdgwjR7rsCwu0Gi+wqaFheVPucyv90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V71yR2+5; arc=fail smtp.client-ip=52.101.65.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V71yR2+5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMOijFys/ynEinOajr8XIWAmt0NW9O+hNyvM+3c/XQOJUs8utCuMpUYAyqH9Gkj6IubmaWzgzjIthrOVPZdDba4udyZEPUp9Cet8GUoIvblchDENxmq+w9h2UZmNlGSaoYeZh5Xdo2STocoiQcc7bFkIafVQkN2WaLQuj1rpbo63lPSwYZbbGIGmE9D4RRHVII6qnfTMVQGU4D+08A6vvtdZ5A0gfUXcW4+AYdHRzg3JDbljnLt0VPywWXDJrlLALp+KnosAGWnxAsesLsWM7j4ZcCby2XPBvRF7Vg+eWc8lWvU1g4qJTL0xkXGFrvVK8hWRKcbHcyUy0Oyvc3tbRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKPb+/ilMfuO9hUVmtTBl8B0kNYfVGuzOTBQx2pjacU=;
 b=IzLjDMbqU2EA4HpKQe08epYyVYTbvabjtDxYcV2sKZhVoDFN4ct1VZyIpvEA3J78PBXngiQ2oJw2fSR39P1SnD59eHP7uRXxv18ISJPeJXknQkXAzUw3IeF7DZuK4+oZOOWpE3+ujFRXPM2kp3mM0/F7nFCL6+TIC9QnYmOK1kw6AGvLS7UXyRf20BfsWotWCbdt0f89LciiYl4sjCrNinirrf3UNOWlagIK4Qu0W55UrQO0JjMMoza1mG/My00E0p5BcEAC9PbdTPPWQ/UUi82fx8lOTWe8SShgV41okCkfNkc6U5XwIlE5Y5RTYVqygEmZkxnsXomgaOR2Bqjzkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKPb+/ilMfuO9hUVmtTBl8B0kNYfVGuzOTBQx2pjacU=;
 b=V71yR2+5fWUlUJqbkF9KgRn3ivmqJQx4gs6nc4CPwyc15V0fSbuwkkwzjBAm0ZsTuO8PIZgJLAERngLeoep+dPHSQEFHmCENJN1KgNMXSLOkEYlsKhnXGOubwOuLZ94gikCAPG42Qh2ZOsSpq/VAVyezObC6jPLHR+JLrLEpfug+YWsUfJqc1HSiPuG9OBL2/xVHPs8GA1+smyWm2uqYcPyV2wxEVXlPkpKA8KA2SIrOW41TOvcyg7joPHhfqZqwlh/Ew/UHF564pawje3Z3X4lK6y2qukUdh7oJdSblKhLZEALQoztQCVJHfHBN/l0RDk7XwwV38Vq6qATuOALOiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GV2PR04MB11096.eurprd04.prod.outlook.com
 (2603:10a6:150:27b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 11:01:29 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 11:01:29 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	hongxing.zhu@nxp.com,
	l.stach@pengutronix.de
Cc: imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] arm: dts: imx6sx-sdb: Move power supply property to Root Port node
Date: Wed, 25 Mar 2026 19:00:53 +0800
Message-Id: <20260325110058.2854742-4-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260325110058.2854742-1-sherry.sun@nxp.com>
References: <20260325110058.2854742-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0174.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::12) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|GV2PR04MB11096:EE_
X-MS-Office365-Filtering-Correlation-Id: 05bf09b8-1ff5-4abd-b73c-08de8a5ddde0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|7416014|376014|366016|52116014|921020|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	89aSNfc9XN3z+kxZRPpZ04a46yaiMfcUE7nQ3D0UBwsJoL3eJTZHIIw2hjtJVRpysg7jVqltaAiYKxDHJHPNQ/mLFCXV2If5qNxHa44tRlDfzj6iLQzjHFtKMpmDvCLm6JlH9tRYQecstyXDxePTKov6Vrh8kNET4HkICxzUeqBhQ3Z706aacPMLoNIhiHbcviU5iajpb2ws00/FssUPaPe/DDIBGw+fSkdA7OlJ1+rkglgnGlPo1JS/YY4ssJfjPF3/8w6qhm34BjPg57knDK1BBlxuGG0xHsF/b6S5PufAkNh5CoHthKxMM2vQ04uPgfM+ERJouIDaBG9zmeL2eZLLRH06Okw2DRZB4nCIb93MK7AnM86O1ubKa39Hr5DGmbqQ6EwSCqjhGb1Ixk+mBdcKs7FiDaisfzrPY8ZfELxkrho0K0WkCt8uwSD5UeeoKlTxZeZ4sKCtE5fgbjdE1yy4Ihb7MscnaSTtxL5c5cLdZykGsQZexmzzmzactKERVRXzQW6rYJoSTrqrtGopllkJXP44hbgEJtJk2MLDSSaV7wp5ds9/RXJIHtWsvNCHmQ82tN2mkVpFnrI4KQVG+DtEn9dULFQlRu+0n1vljxNmdFVraGHlXVmpDFa2JkA4z7Ylt0t7EkHemSKFxPPHNRG0u7UfOZ+tVNsOtePGpqIDMRS81EQHYFcmswTUO2oQJl7fDE8U+77ty1C7YtOAmtuW19SEqC5jL8cyGQpA/X0+SXFNkyhYQg74m8ZZqJUYdw+U/co5DiLCVdY7wiQjH4NmnXc9r2wytHRRTP1sn17HryhbGOwHUg5e/1+Z/tm4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(366016)(52116014)(921020)(38350700014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IHG17FghdHZK9ObPus00sMAPfwa2sdRNWE6GmS0SpDaKjmM8oHes7XhgmBih?=
 =?us-ascii?Q?P3nhxFExcw4YO4Hlg2eJ5Y4QwDlmjZz26p17gGe0CEPVfYDP0trhBjaiVnPf?=
 =?us-ascii?Q?txzXxjCZSSv6LejpdQm6c+3FDCV6vuMKo4y+3N7knzGbG5ULOyBozfYRgt2m?=
 =?us-ascii?Q?bt1cIMwvu5gI85C/uWuPQNoZ4OBFB664IXka4mycGsOXXDHWrDxxk3phIMYt?=
 =?us-ascii?Q?O4kGMiEG0XPRwZEMXBwCTucUCaIXSK8M94AjCw6WK+XBDH3ev329i8zUerGz?=
 =?us-ascii?Q?U9E+GyRznK1fIY6Dz6qlPmIUyYYR11EsDkmCqn+7UH9RqwJGcgTH2bFUrp2Q?=
 =?us-ascii?Q?+8+YP/3Bv1ckfGJTK/EIDN8GWsvAR7A+LZx3PNfa3TY0WsnaQDrGwv8HPVOq?=
 =?us-ascii?Q?k7wQ6hHi7HNdjEQv5u3B5KWkacjj0nx/a07bRTUdvjlelBQpVNToQWJ99+fy?=
 =?us-ascii?Q?C6ZKKidjhm278/NO4LXq83xgekiW8gRDqg+/jKHrTWXoYnqiuk/+aetyyXZo?=
 =?us-ascii?Q?JIzfIHRqcfMvoITu2N/WJfKNnto7YI3X4AL27bJHUKxSp973owQZjgXEaXk+?=
 =?us-ascii?Q?sDkofbmb9cJTT+V2sbhDcE0AEveqAJQA+RhbiVhxqUFQ9T4wWKiFmx+tFv4S?=
 =?us-ascii?Q?rKqHLCjSspI5s6WmeZfzDBW0NBt2BuxrR6z06AIQsJdf2q7t6gWinMTLqrnj?=
 =?us-ascii?Q?jpOe6+/DIMVHrjJrO/B1bxjBTTFnMxJhMqS0bFQBPPOv4A32flQT63RxLaRb?=
 =?us-ascii?Q?sRarFe1sQyZ747EpczRbYSxG673nA+WxJUlFYZBBJq2s3Xbk+biqKL1PQDay?=
 =?us-ascii?Q?Gp/YcXoyBHJKHUOcWqXvGLcAsPN4b/9mmclc2bnYtXs23RFOmAs8Ixgv/rL6?=
 =?us-ascii?Q?XlJIAUMOFMmWCek+ArK7isuRlt7Yk3792hoo0CYJhj2vKOUmJJjhNj5fwSvv?=
 =?us-ascii?Q?kv0sDyQMfsEiLE3+B4Q6fhqBuMq0VpTJAcm7PNof9fZmatXnEv+5CZJf4oJo?=
 =?us-ascii?Q?WVIpKcRTLcAQyPUlNjXLQC3+r0HwTI1Jza20hn6imXRdD8dZpYrLK+Fp/gAs?=
 =?us-ascii?Q?6VTVqe+sdq/A2WnCLU01oRlRkZkYuFTVCbXHbKx0jvzIX56WEBTBRxqXcGtA?=
 =?us-ascii?Q?3ggVGD3pflPZ2LfHKszHzF9s+0QjJkoinBJ5ff4tnGdzHjW8YOqdlxAzx7IY?=
 =?us-ascii?Q?MkvjTZygbS5syNSPjLwttEvigj2Tp/LACL54KwJ3MaPWVjghZYH1fD9HPHrg?=
 =?us-ascii?Q?IEnkNxzY8/1LwmDw96JZTE9bsVQGeFJCob9+ruaJeAepnA0dT12ROykDc5ff?=
 =?us-ascii?Q?rZ6ytUOqde59HoCDWyql89CzWdRzFWuJWFLutjOMcxkgwgl/LbhbWD5cKQvU?=
 =?us-ascii?Q?uG7nllB7HigRIZaRDvrigfs5xqg8bPk0H9WuGmuZ57El5LQ+Yf9XFfkG3O0d?=
 =?us-ascii?Q?FBGxtRvbHs+UhczDr8AOZ+z5bdUASnlwtI2LEzklxsehTJyzforPqq39e2Gb?=
 =?us-ascii?Q?W4UyGWkJXfScFqflfWSGEq8TqbVpApv/oj888s5o+HO/qm4z8tR4gcN9l2Iq?=
 =?us-ascii?Q?CVX9YCzbRjEMOq4AE7/+SdnITaY+sz4P947WFH1DFfiV+P1DoV4+OXjLK9Zz?=
 =?us-ascii?Q?VzRIoKzW9BB+IJqhdtHQtF3rtJbYQqeIyiqasC3hx8Ac6MKzHJIKBrRABzE0?=
 =?us-ascii?Q?bUst54wYyJ6twO3Yi09PddeXWhPGTwI6ypK2xsxqASV8n7IuCbTVVhaOzGMB?=
 =?us-ascii?Q?f0AuSuo5hQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05bf09b8-1ff5-4abd-b73c-08de8a5ddde0
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 11:01:29.3008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9gP70f7m8wv+VrkKTjyZTbkSkFG252osW4u6KVi/yn8Plgh0cf66HtZ+vu6AqTT366p9RRSXl3eabonvBJOpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11096

Move the vpcie-supply property from the PCIe controller node to the Root
Port child node to support the new PCI pwrctrl framework.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
index 338de4d144b2..7633ba2139d3 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
@@ -284,12 +284,12 @@ &pcie {
 	pinctrl-0 = <&pinctrl_pcie>;
 	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio2 0 GPIO_ACTIVE_LOW>;
-	vpcie-supply = <&reg_pcie_gpio>;
 	status = "okay";
 };
 
 &pcie_port0 {
 	reset-gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pcie_gpio>;
 };
 
 &lcdif1 {
-- 
2.37.1

