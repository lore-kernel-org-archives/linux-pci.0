Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011001.outbound.protection.outlook.com [52.101.70.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89169401498;
	Thu, 12 Mar 2026 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773342839; cv=fail; b=B3I51/ICAFHLRZk8qsjpyYNqjAo6+wOFEVYFvHwsq81F+WFtwMfbUQ4weREK3WmFYaCNy1b2sRFoEQ/Evz9SU2NpnWgGqnN1BimlhMNOxajEauDCsR4eKCy9/372KnXADkRwW/LJ+b3EPPWRfKNeRF2P53qGwuy2bZSAAn8iHUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773342839; c=relaxed/simple;
	bh=dxQLAcW/HwRoQkkMdEHAenmyQ98hxsZ2CGuuucVixcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=coWBKbjrnmAVfySF1DGleaaTHCbxHzpicNiDp+APbH6JqesCUUTv2g8rqD70z2WSPghtYgUP3aZ20AcsXVLLwNRjOxvCZOaV9kwVgoUc2TGBYsYB3r1jfV9vCcMFW88Qd/hhv7J1k0ujxF23ygTwAPkxwQ9Qprqa530t7ro8H44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E9dgEqxN; arc=fail smtp.client-ip=52.101.70.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E9dgEqxN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMwSZXguht+bNw+zE/Azv7IzApH1GjGRXiE/k7YECCBn8zEFsgykhPg46A+QOSoWhHBdXiSucprJ2yG4pMeiqMIIvsSPT3AX/elTJ1rFd22DKgletp8bry7IP8edzESudXScbLkoczi/Kk00SEvmHPHq1pnATCFlm+U2HLI4KdMqFCKCnLONmU73yjcv5h1G9SDsED4EAygfEUL19FSzVxNxuO0NxccExL//Ff5yxbeBkWpPPZr/aUdWoV4TObFsJcoyYZGalXjeZ6p1RKO2gkj2/YUh0QhCB0dM/dMok3U3TX40CafyIdsN97Z5hyK85weWHsHK83f/LQ1Hk47ysQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vi2x/PAsbGQMSdNCuMzYP/IPgcG+NUlHm4qA77xxBk8=;
 b=sk6fNy4mplKjUCgxrkPGYn1YbK/f8zrb3IUSsRgu6tcG4tgY1mQdx3HzHpsoYOBC3neUPm8BDaqosQJwHd6NCkfVdkkADg7dgskxmpXihO4QJ/u97f7O3h98T7qWQrScCJsxrjaJ4N3ULSko/PgwDgxio+ua5UskB2+6WixmFyAOSAsU12wIL2MCm/6tt9YhObBKR7AuaIZz4mksjRzkxcGzqNdBV98pHkS4tUT7HYUBF/HxvRu/pCvJXskn1xamVs7vhClM1ZkAMvo0Y917ZWhEVKf6Tvd3xcN9pOttbjqoZQ6wK9bedb8GoavN1on+JNO2LbOpc1H1wq3tBjjv7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vi2x/PAsbGQMSdNCuMzYP/IPgcG+NUlHm4qA77xxBk8=;
 b=E9dgEqxNRBQ/1CEypz4QJ44oSzbc/Z+Tf5v3p6gxcxLva147xZ02N26qol1Gn5Z905BsOSMK2I2DqrTXirNL8dv7xY55Cn2FUeylYNGYJMo1CX9xRucB47w0/dzW7qsyPbxkBPRWbH8F/BFXWRpn38mH7sHpjuXA6qpFyO2a59hboO6IOUu7qa3J7EngMZPW1q5bKiWWOASfy9002d9+tTRf4McGymYTSOHk0udyWccSjoS2C7Fw8mF3QDqu2GWW2w9mn+lBj1E6pr0/W9BcfrEe2gymdkAoy8lnfXhiwBtwb7nHOROjAbMbjydhMQ38epdg0J6rR14PYw3gFAYl3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB9124.eurprd04.prod.outlook.com (2603:10a6:102:22f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 19:13:53 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 19:13:53 +0000
From: Frank Li <Frank.Li@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v5 3/5] arm64: dts: imx94: add pcie0 and pcie0-ep supports
Date: Thu, 12 Mar 2026 15:13:39 -0400
Message-ID: <20260312191341.3479958-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312092745.295578-4-hongxing.zhu@nxp.com>
References: <20260312092745.295578-4-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0079.namprd13.prod.outlook.com
 (2603:10b6:806:23::24) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB9124:EE_
X-MS-Office365-Filtering-Correlation-Id: 946647a9-efcb-421d-6a15-08de806b801d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014|52116014|38350700014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XNLry3DGRrFdgrJBcWhp9slKei9fisMIIaXhcMrSgz70QuUZdg/9YOhH1PriGTNDukB0O78HE+w/RB68fjFh5MZYsnQu4+puqm2xT13j11K2Dtz84KPq8sbV83ZDEjJXotk+5bkqeqwG+Q7cJg9ztQBeTvXnEXFvho2ZT9god+8Z2gqH9K+ldWCvm55InA9om1c4rc9CEZbxEprdL1qtELHdQvc84CeFqPH6hEyHF8JOFemGEICZfSfpoU67tj5DaHusD4bmCcOrkXQmCkqguZ/N2DoF8/bAUxUTxQB04zqT07zdd04M+gFwmoVNX0qMBOfJZJsFoROS4iFZUZrWYrqecCoxxXekm2nTPiJvdMY5KI7bX9nq+2XBusDQ0yCQZDIIIRJbCqxzY1m8D96uWsKuUefmHMfI6IZSMWgf0ZmNFOkCuCC5q8Bef+pPwJ+xb3yvobKbYMCi5/I4S/wHs23n0FI5de3z5GcQZw8RBeOx1sAH1UzoZZK209OqijY191T/MeewcTqwg5JadLXBcD8lPKgulGbFlFWuRJQPr8Hd4SCKfHOEPDTDGC+Y4bWFqEPtYg2p1w0shZzy9LKVUv68+3/FYLDe96CDQWoIUlVv4xaUMtloVZhSY2V73w3N2fFLmpikfdSdnIzNXn93GQLLhRkHVMQpB+ojdJO1d4zCIPj/wEudd/hk9WNXrq6a3gsRD1Tr2SCtLY5ZSuuKHXmkbZDeB7kqB8vygYrLjcz4mbG6YM1nv3RvIX/6Z+NmMBmORw4WsM3bRgDNlwYlrn+QGP/K9KMB53jBuckNXWnwNtbkIqpbBFetyYRskvXJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?enS/IGzccxDGlQZW6vYgWMnrar/zmdZcBXK9w25FlC/UF05zX+HCT3Co8bW2?=
 =?us-ascii?Q?x/PKJwEWJvc0V/L1gZmDT0qLUUpAb/7tY/NGPQNG2X3N2izJTDofbOwvjxvp?=
 =?us-ascii?Q?2ffn0aYQocXqjpDNQDd9IMEBUkOvvO5y+GXzkUh/TuRWaE1zt7FBrELu88lk?=
 =?us-ascii?Q?UkjOHtLgSnh373qqfmNp/fEGzEoolf7DQfygSy4CtaTVptmyN2LzWvQTONAP?=
 =?us-ascii?Q?i6038cz/wOIn+SEX+HzUX07xHA1G28kdpHbXkOTlnJQxNTEIAklA5JPtoJWt?=
 =?us-ascii?Q?JIUdUiyl7XAqgR0aw5p1DyAUlSuL1Ll+Y9v3j0t/BiRYLCIHejF2eqNYlUN6?=
 =?us-ascii?Q?BTs9iWLlH1ktsGu1+MfJwJiYV6GQZ9x/k8Fp2XldgAk5qzxaeVZ56Bv65/BL?=
 =?us-ascii?Q?HbycBA3fAwmzB34LK/9JJbVM/i5yDwFmhD83XtLZA18iktbf5NiZwh+ZZNir?=
 =?us-ascii?Q?rRZkKyvOiR8brraVFXBHhcazQJ9hTUO+OUNkxowCD6gvT3dwyN8tNrHq/8rE?=
 =?us-ascii?Q?gMyPqPBCUjQRXOnzxpJHrRU0yq/4wv2vgxuf4I+ZwEYgrcFVRptvMW4oeQ7F?=
 =?us-ascii?Q?CsRUDHvbCQ2W+B0+8aCYPEU8WUSrZlgxBTE4st0oMZp6ie48yF8Q+nqxj95G?=
 =?us-ascii?Q?LACngeJOOc2m2GCbthCVTmuoSknwNgALXIuNS8xxsMkTWfseooIViU/4TQ53?=
 =?us-ascii?Q?lFdM/3ki/oQ6aDuQzhzk+QSO3nBywzzWG3cVjmMT2Ouk8nJSdm1qvzV2mPYS?=
 =?us-ascii?Q?J4DgFy8Y2Lenh5dPIeRET2xG6SQkNjQJP6Zr9xhRWQu6Gwmxwq4n1jKjOGtJ?=
 =?us-ascii?Q?70L8j9KWfp7QF8m8NbNWpk6puNxCxbvSGBjcBmJHDeaNk3Cruw9BtTW7deoy?=
 =?us-ascii?Q?VNvSBroXnkhjGzIlkB/y5MU9Q9/qZUMCzYp/2dcUHBRSmpDRbonSFleOlL5v?=
 =?us-ascii?Q?5bNndq1exYkaHOIUS64ehvuPVNWBZOS1VYxg7N4kzjCuNfgT255tnOGOc/po?=
 =?us-ascii?Q?zSp+nnv6YMW2EIonHS5DOozcKE4W2OGAM32JjQdF1FPNFvYO3aXnX/qBUlUz?=
 =?us-ascii?Q?c5XrrxwOuTU+ykYgQgGFbkY2AlrVY5+QVmp/nALbzw5qnY6ZIGcF+Bcqz3Sr?=
 =?us-ascii?Q?X8q8brIN1445wZc+OlXw41tAxcZRoqzR04uqCzSCa8vNqP4R6siX4s9msErd?=
 =?us-ascii?Q?qx9EDjDs/hiJjlQ7bsb5ais3+zHqwsLNjjoE0ezFO/eQnVD01Ei2Ke5rp+Nu?=
 =?us-ascii?Q?gO6aGcdIwI488DaThxs0aOhiQtISTStWCPGb+cU354jaTNUkYxgucYvfUDO1?=
 =?us-ascii?Q?BiqmlpQTQ3yMpp0TloXWILQVRySqmx81AlQaW2vGng0u6tywt3DhjJZVFHqh?=
 =?us-ascii?Q?UAEgYczbFJYzi5FOzXrKefZ1ygmxhm+xqrINT06x6NUZB1HgjbLWsCpcLJvu?=
 =?us-ascii?Q?XM9nC3pQbI3mwjiyR4xtfSavxmxHmOMLm0A9e7M8jsJeIRfc0xg7e3fT0pHH?=
 =?us-ascii?Q?+4o3kkHHfgsnIQy/B2Ne4kYAhRxS4Gr0MVvvNvByUuLuMRs6dF7gKnKJrSYJ?=
 =?us-ascii?Q?QeJ74dnrZ1EXcHVymnPxDWodHm1kCYxBhjLEGeTfYYIfXHoBqcdMMe44eKjO?=
 =?us-ascii?Q?KQv7Hd+KL2bE42p3GsRp5ns5/UiB10nxRl7tefis4S48Lf7TrRe+u48a8wrT?=
 =?us-ascii?Q?hBmD+d/jwpvY3o/XYi9Xp6d/iTfxfn8nGsp1xhMvOAdlIeq8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 946647a9-efcb-421d-6a15-08de806b801d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 19:13:53.5379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H60njgQjtYnmTHFmmQ5KeMcZKNQ2edc/vwehXHgSDZdV//lGm/5lF7mYPKF5altTE+iAfIdngNSrRQH/G12p1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9124

From: Frank Li (AI-BOT) <frank.li@nxp.com>

> +		assigned-clocks =<&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
AI: Missing space after '=' before '<'.

Frank
