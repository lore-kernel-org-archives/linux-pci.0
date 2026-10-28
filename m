Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793197603;
	b=G77mkdDU9zVH1bPJpgI3ho9XKYUbqxq/ZyCeV+hoWJ7WoU72YeanpAZ2/PNNmen74aEg
	 uAf/p7oj5KaleLCMoAhiycafDeI8UyNDKvPLmwNB6aMIClgWKVt5qip83JOn6jsi5Khoe
	 2afzyaWIouhhFsM0ZMgF/ypFTtITzbYjhDnI5REIrzIV3nej1p5RpFZ8tJAZ5wko1Q5oM
	 rsslzOyQH5jFSJPeBaEjkPnCcs0IRr09PtNpF88GvAAjBaKnOA4V+G4MW1qk4elbw/PaS
	 TNsx9RgSPYpvknO1wmeTCzu/pnxQxsHfTLrMrrVjZreZT07laIboqZuFrbCkIegHZnw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197603;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=PugH5ADTgWBNgCzo2c+KFwnk0r1PS5zDUpNv2SsWnUo=;
	b=e2YwDzOM4V+sC9NuoKhk2XkbWltNXlMh4wc3DnXzM02Q6qUTUxRjBL+ULtyrrbSQP0ja
	 USQ89hwOQrLaNAgvJd06ooKONhpOjkSqWJeSV779Ll+hZw512Jp8OgHgSz1a1lLz8yml0
	 kW3sL/pv0E4DBhKvSKtb/A0Gq8LVYthzmYz3sFOP/HhsAHWe3xY1ccgBpxkPgNH8n6+0x
	 fdly20ws2wwzy0X+iPT/XrXsAyU4RyKSJiXGZ2XZQuUfwlJsal/+lrCEifMcC3YnDpuqs
	 L9850BWpcuNuFRS7R5m6J6isO+5QcuGqhp+gUHRy8dRTo+6oXBX2S4E6lJCcT9uOeGg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=iWAMacif;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.21
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013021.outbound.protection.outlook.com [52.101.83.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D739606A327;
	Wed, 28 Oct 2026 14:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D739606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=iWAMacif
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EUzwkxM+5U4c4djubNdkw5RXK63QafpWqgHpEtrm0fB5uAsxWrwmazQpKzNwQxPUVBDDCz6BVTiAqFuNGaF8kLJqDzY2LFJlU3nSjFHYvJr9yRgfZG83AcuyjjEcnrg/l/G1o98ikYXsdXWpHZH2H7sqB9fFXfT4zEVf0Bkd8NhNGUW8WwEABmVD7f4ZP6hNtRSWsXVJycIzu9zNS+llo/+5yhFGnH3xnpOP8N/brtbFQefVDOlYH6fBCuooh9Vccb79i/9BGUwIL2ofT+0zg0QAfav/N7B2U3+VD6+PyzUQZ+PVdyin/3eT1UH4BANC/CqW+yKQ+gDCwhr4DMu7yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PugH5ADTgWBNgCzo2c+KFwnk0r1PS5zDUpNv2SsWnUo=;
 b=JQVpgOrqGZHrVNs3QTVt/HbATgeZfHtJ9PnI3eXo63FfaG6+8FrdQTiFPYg9VGIBUlEakFTMP9UR90QodP8KS5UHgXtd7Ob7HqWex7BJxFX7aSiU1hYdQZtXuXiojj9SkELkMEIiY7EjLNuuuYx0sKb0qYcjMHiCiQH6KZUh2lWMC7JOrB1WDJumNTw5O6Run61xTI7YDuNNSnB5iTDiaPP/nyDEcYig1v0fmAkTbvm+Uut1w7ZPLC16CwFUA9JLCbauy1lv4jGFp8xE0hbUpP5nASzwvBaQ/CL9R62TRQnNg+8/7OOks+hmeIyGJ7UHtOmfWUHEXedfEze41eOEug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PugH5ADTgWBNgCzo2c+KFwnk0r1PS5zDUpNv2SsWnUo=;
 b=iWAMacifbwocz+lHil0qO84MTMkMOvglnubW7bzl47kSj8aDd/2iJBVrA0AMZXLeOWpYpL1FngTp/a/DVauU9sHv2cwkDIQdvc/zSe96Vv9BV7o5/ztL7qeb5o9UGh+CfwlLY1c24Y8s7sq2ClColacayPq6oRGDMU9Lsf+cau0+iTPd+NvPDgt+1oYH2DgFfb9rLGSMx2lVizp8slVdtYwuEYnppE13e2paZvpU4TJvtAPC5NjcJTe6682OuHhdu3nO070j3rAwPrnlkd786Z/ryrx31b9WrEDMMwSZIj5V/aX7fYfMPVWNVnI2ffGsXF9IO+d1moDU4MP68ODO3g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 14:26:37 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 14:26:36 +0000
Date: Wed, 28 Oct 2026 09:26:13 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Yinbo Zhu <zhuyinbo@loongson.cn>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Tiffany Lin <tiffany.lin@mediatek.com>,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
	Yunfei Dong <yunfei.dong@mediatek.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Eric Anholt <eric@anholt.net>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Peng Fan <peng.fan@nxp.com>,
	Aakarsh Jain <aakarsh.jain@samsung.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	freedreno@lists.freedesktop.org, imx@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: Fix property name typos in if/then schemas
Message-ID: <auIGBc2Wo21H6Rdm@SMW015318>
References: <20261028120216.2657397-1-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028120216.2657397-1-robh@kernel.org>
X-ClientProxiedBy: PH7PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:510:33d::28) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PAXPR04MB9186:EE_
X-MS-Office365-Filtering-Correlation-Id: ee112b64-b16e-4703-361e-08df34ff7912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|19092799006|7416014|1800799024|261026140227099003|11063799006|56012099006|261026121527099003|261022105027099003|261022075727099003|261021121427099003|261021123027099003|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	PJnUc1WGA8a9fo4wsN9yLiJ6vA5jbebBB+U2liGAOGkTaLqzc0fWb10tCiLjM+PF0yRnGzgQiNOWoSMDuKujWM3xjbJA6IVi9NRE/dO5lLDsDFuBmfACI3ffyL0XkEZ/xlItnJ67Y4Ha0xSMz9+FYO0EpiSULbJdz/HyuG0CHYgCAxnr4Mpq7eK5DldLlG6ieUrgtIR+peeX/B3VHg7e/A6NrJrtluh4szGpg8NRmKHyLVPL61pUHNX5Gmq8iNNZVCT+UXLonwxybLqKBxSLIvqujHrPfMcceSIYn2HOBlQz4CTjRrRYPon1QgttoLy1ZOmYYrAHGFtWRctZ1DwxXgyrOLR+EC1kNPbXDd1asyBBYGRzFd9nOQN9aXi8d19wiphqDemPt7KMbMTgM10sA9zsZ1bpULDbGdFUEumnzPVJ4XRWuzz6/uUnn7XATiPeOMe9S9SKsfeo+DkambXEmRxt9Xutj2bpMe1WTI26z33ni/vrf/C+03GWnXzx5HHB5AlnOukvwgpf12LTEPc6ORhOOsAuP9B4tAco03CEg2JxkLhdgRJ14QjDKGfY+TFR1QfhL63l6W84q2EkVc0dfKIrj2kTvrHW5XzY+YbjrDcLTlERuxAdA85BwC1U6GdzJNCOULrhRJuWV6xFpK49Vjn0HpJwA67A9d14uN5sMao=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(19092799006)(7416014)(1800799024)(261026140227099003)(11063799006)(56012099006)(261026121527099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yhoz00PVsJqtF9EPEGywCcxhtZzWfcPJ2a+fSI+CijO6DYTWCvNdLXi+bPrn?=
 =?us-ascii?Q?ZeKh1fIb0GP+Ummi+pEAjQls/FlH+Ad7FEMSo092qWc02Bak1tfgK/u2V3ka?=
 =?us-ascii?Q?BDo1wVM+Ol2lHwOpGD4BijqT9l5cuKnZsRg4oPOaOrkpq/Sx/x3pX22AFbGb?=
 =?us-ascii?Q?lNwJ58LQgM3x/PYjuCD7uOIVk1KalCYg2NWMjEWhDboCjEcYi04A8K865dbG?=
 =?us-ascii?Q?YrQiocw+U3/PvvEiHkxs8l4Wkpc4cyoWB0OBhcnjXO9TCs3R4t7kW3Pn0nJO?=
 =?us-ascii?Q?YbLS8uJsgFmoiP5kM8mCvXrg7yG9KQQvYtnVuMLRiU0juAaOnmFvxGdR9N2B?=
 =?us-ascii?Q?Ghhx05bRvwK8vxSiry9NEJW0ZSx0yRNrmSkfTv9g9FbnDNYwz+DTZe2QNyL1?=
 =?us-ascii?Q?B7radpUCui8gAMsbtKAgrWpPGimcDJqjj5osDs2/PUGyGqLM0YVkCY3DbGxp?=
 =?us-ascii?Q?2dtRofJqYRg84QCxQvk2VrVVEA/WBrgJgkIMytJB5x3wX5Q3MNHYjwwBYnfk?=
 =?us-ascii?Q?2ALEbNV3i+KzF0Pj0eqydxYwWMm3UTzim1htmPTLKchI+OP2HKDGvQ+Ohwla?=
 =?us-ascii?Q?w6lTA15BaP46alY0xfFr2SGNX1gGfQP6RAmPwHf2jOyS1I3gUDQyfxuAb/ub?=
 =?us-ascii?Q?KxWOW/7WXvJJJRWyERMjyxjPrJ5F0SpGo7kzY8ktCDOEgxp2l68VyFNdN8Ej?=
 =?us-ascii?Q?icQufBWl9ibG5SXMJS1l5Xv7B4nxGD4B/zM0+1I53UtU+A3AEuKIeBju2id2?=
 =?us-ascii?Q?X47vCHaO6QON+9yxQUAkUA60GlsiyUZEdOGywnDVTAlP5JRWsYTAdUSw09K9?=
 =?us-ascii?Q?eV0gJw+s7LdP/SPj5AvY0nbMAREN5L/hKf/GdB9eniNOtQ3qCluDNDjshpTi?=
 =?us-ascii?Q?K832WPxVIQ2eNy2mJZ2TPH52cGmKm+/wZwMPGyi2uHd2um1lvM4rQZ2FNZ5X?=
 =?us-ascii?Q?swyeD1c1MXhKbMiJEYAKcItRhVC/94cauWDUVVWujZbfMieGv4sDJRPtLjGl?=
 =?us-ascii?Q?n/66c7UWc/k5hUjIUV/7NnyznpkJ97C502iOz2eU1ZOK3l6qsEaH/HwbUh6g?=
 =?us-ascii?Q?TdTmie/iU8eKDSd2N3xtL+h00IStPlZND/eem85Y/zJFxK4G0R5LreUL3ANp?=
 =?us-ascii?Q?yQSzyyTvJW9ltrGUVpTjDDdr1drGRKjIuhexOF1b/bFBJExTrUUjnJcDcKGS?=
 =?us-ascii?Q?9xDz59VM3PapXAL6dE3vd5iDby3TZzJtNAFdHsJ/j4NVkHYS4pvclaeW+mx7?=
 =?us-ascii?Q?rynV/rKj2Kqz/rLdbRLnWUD2DyW7gsfZzF5it0yVFQI4DhTlKkLus8K9xh/t?=
 =?us-ascii?Q?Loxo1CYtDQEir6vQEzA5Fkq53rihfyDYPgpM0vSLCTC4QL+oZ7dJ1h2cFRNO?=
 =?us-ascii?Q?AsLLXWCovcCX+0cSQa32ja0rSe1XjONdqIcrCyBJQjsy13618dMiKIp0DoHv?=
 =?us-ascii?Q?kdHcr9J/e348pElrKJzUgXNv2UZvnGFZaJ19sBWCbop2tasK/bapL7iXMrP3?=
 =?us-ascii?Q?/Tc+e6sH84p7OHRrxFZj2bHZs9E4ANbG5Khv0PZ7RwpT+BjfDBLSoZht3Qok?=
 =?us-ascii?Q?TMwmGoggaCWkowZNqzQ0+ZNvXKZz12AWOMN9XIjkDNn05/3dDRPFgjRJNvRT?=
 =?us-ascii?Q?+6moCkdl500/4XQUaE28rAzSkv9AvzOJ4q2IXjLCzvNxXovL5KmDTCuiLMPH?=
 =?us-ascii?Q?uxjOrKGHTFDcdB57snUoBua/nYypyM/OCICX2xm5Ypq/RAksaW+hbBxYxlF2?=
 =?us-ascii?Q?JiVQzMzKGVIAAUNgBLWs8LmwMuHZdZ8rUDcuVFV5SXN7t1QhNkQv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee112b64-b16e-4703-361e-08df34ff7912
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 14:26:36.4955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZH/uQIX74lyS4VQF0juYZ9Pq0oADROx4SlEDjn+RN7+ybXxf6O0CUlCrijxHFlbr6RQysbMT6euZyhNsqJNUkY84246+IuBVQr6rei29eBcSZtkNXqcpcgdGna8PnrEF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9186

On Wed, Oct 28, 2026 at 07:02:12AM -0500, Rob Herring (Arm) wrote:
> Property names within if/then schemas currently go unchecked whether
> they have a type defined or match what's in the top-level schema. Adding
> a check finds a number of instances of typos. The typos result in the
> schema having no effect on constraints.
>
> With this, fix the mediatek,vcodec-encoder 'clocks' count constraint
> exposed by the name correction.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../devicetree/bindings/clock/qcom,kpss-gcc.yaml     |  2 +-
>  .../bindings/display/brcm,bcm2711-hdmi.yaml          |  2 +-
>  .../bindings/display/msm/dp-controller.yaml          |  2 +-
>  .../devicetree/bindings/display/msm/hdmi.yaml        |  4 ++--
>  Documentation/devicetree/bindings/dma/fsl,edma.yaml  |  2 +-
>  .../devicetree/bindings/gpio/loongson,ls-gpio.yaml   |  2 +-
>  .../bindings/iio/adc/amlogic,meson-saradc.yaml       |  2 +-
>  .../bindings/media/mediatek,vcodec-encoder.yaml      | 12 ++++--------
>  .../devicetree/bindings/media/samsung,s5p-mfc.yaml   |  2 +-
>  .../devicetree/bindings/pci/mediatek-pcie.yaml       | 12 ++++++------
>  10 files changed, 19 insertions(+), 23 deletions(-)

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> diff --git a/Documentation/devicetree/bindings/clock/qcom,kpss-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,kpss-gcc.yaml
> index 88b7672123a0..ed347096df46 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,kpss-gcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,kpss-gcc.yaml
> @@ -62,7 +62,7 @@ then:
>      - '#clock-cells'
>  else:
>    properties:
> -    clock: false
> +    clocks: false
>      clock-names: false
>      '#clock-cells': false
>
> diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
> index c1cefd547391..fd4d598f6ff8 100644
> --- a/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
> +++ b/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
> @@ -145,7 +145,7 @@ allOf:
>              - description: CEC stuck at low interrupt
>              - description: Hotplug connected interrupt
>              - description: Hotplug removed interrupt
> -        interrupts-names:
> +        interrupt-names:
>            items:
>              - const: cec-tx
>              - const: cec-rx
> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index 094a6383bb77..f72d1b354007 100644
> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> @@ -304,7 +304,7 @@ allOf:
>          clocks:
>            minItems: 6
>            maxItems: 6
> -        clocks-names:
> +        clock-names:
>            minItems: 6
>            maxItems: 6
>
> diff --git a/Documentation/devicetree/bindings/display/msm/hdmi.yaml b/Documentation/devicetree/bindings/display/msm/hdmi.yaml
> index dfec6c3480f3..02d27ccad024 100644
> --- a/Documentation/devicetree/bindings/display/msm/hdmi.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/hdmi.yaml
> @@ -113,7 +113,7 @@ allOf:
>              - const: core
>              - const: master_iface
>              - const: slave_iface
> -        core-vcc-supplies: false
> +        core-vcc-supply: false
>
>    - if:
>        properties:
> @@ -136,7 +136,7 @@ allOf:
>              - const: core
>              - const: alt_iface
>              - const: extp
> -        hdmi-mux-supplies: false
> +        hdmi-mux-supply: false
>
>    - if:
>        properties:
> diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> index f609038e35ae..0260d177c7d0 100644
> --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> @@ -172,7 +172,7 @@ allOf:
>              const: fsl,imx7ulp-edma
>      then:
>        properties:
> -        clock:
> +        clocks:
>            minItems: 2
>            maxItems: 2
>          clock-names:
> diff --git a/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml b/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
> index 69852444df23..07c8b233c6bd 100644
> --- a/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
> @@ -80,7 +80,7 @@ allOf:
>          - resets
>      else:
>        properties:
> -        "#interrupts-cells": false
> +        "#interrupt-cells": false
>          interrupt-controller: false
>          resets: false
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
> index 70ab4e140e71..535213ba0c5e 100644
> --- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
> @@ -92,7 +92,7 @@ allOf:
>      else:
>        properties:
>          nvmem-cells: false
> -        mvmem-cel-names: false
> +        nvmem-cell-names: false
>          clocks:
>            minItems: 4
>          clock-names:
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> index 4505e66876a2..52f471a070d5 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> @@ -110,19 +110,15 @@ allOf:
>
>      then:
>        properties:
> -        clock:
> -          items:
> -            minItems: 1
> -            maxItems: 1
> +        clocks:
> +          maxItems: 1
>          clock-names:
>            items:
>              - const: venc_lt_sel
>      else:
>        properties:
> -        clock:
> -          items:
> -            minItems: 1
> -            maxItems: 1
> +        clocks:
> +          maxItems: 1
>          clock-names:
>            items:
>              - const: venc_sel
> diff --git a/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> index b46cc780703c..4488d5ca9b9c 100644
> --- a/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> +++ b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> @@ -174,7 +174,7 @@ allOf:
>              - const: mfc
>          iommus:
>            maxItems: 2
> -        iommus-names: false
> +        iommu-names: false
>
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
> index c009a7a52bc6..7c40361f95ec 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
> @@ -127,7 +127,7 @@ allOf:
>          phy-names:
>            const: pcie-phy1
>
> -        power-domain: false
> +        power-domains: false
>
>        required:
>          - resets
> @@ -150,7 +150,7 @@ allOf:
>            minItems: 2
>            maxItems: 2
>
> -        reset: false
> +        resets: false
>
>          reset-names: false
>
> @@ -171,7 +171,7 @@ allOf:
>          clocks:
>            minItems: 6
>
> -        reset: false
> +        resets: false
>
>          reset-names: false
>
> @@ -193,7 +193,7 @@ allOf:
>          clocks:
>            minItems: 6
>
> -        reset: false
> +        resets: false
>
>          reset-names: false
>
> @@ -215,7 +215,7 @@ allOf:
>          clock-names:
>            maxItems: 1
>
> -        reset: false
> +        resets: false
>
>          reset-names: false
>
> @@ -223,7 +223,7 @@ allOf:
>
>          phy-names: false
>
> -        power-domain: false
> +        power-domains: false
>
>          mediatek,pbus-csr: false
>
> --
> 2.53.0
>
>
