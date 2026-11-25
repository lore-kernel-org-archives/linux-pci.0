Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795623627;
	b=Thpb5roSHv28gqa8qlHWc9syoIkXOnw8huTp9kpPR4V3DLVWJDuiJYpGi3T6pznda+06
	 qUhbXyXRChyxq+p+z0E6o1IDsgj6qGwVkDW6Mhkg9se71cX1F6M+GCSSabW6j0TxSIvS+
	 mHtmeWgBVnRxxxaS7/Ekxt0er6705Xd5Kpqza/PL1m/tJ9iCXLX8wmS9oq8BgQrDL3j9Q
	 mvG4hKNIJdFqd4A9QbNatPzSZtdYxcyaTy0imTY5mr/qW8T8ofBBJKRVWB3AGRv71Zk9s
	 H1L4/0eEUZzGBZkoYnTmOhwRi2po9Ee9HPq2mWgaz17iCCK3vYJjneVuRmRatny9hDQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623627;
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
	bh=HoGHuuCJqVBarNUeKNtLkdgRV7zB7adrLppZX0CgIkQ=;
	b=RfrLtRu9obJTMhgD2lKPQPJOUlwnDFjWeM0QyMeOK9phkLQMugXv2w7Acf8giS5U+hdE
	 Sx53qtGEjF1Bkm3KNvUZbi3SfP2ausFMLU6vpeTEXQrt0Y/s1mE6hNUc/pm+UPfcOARdp
	 W67i2NpX+caAf4Ko7ZDv9MXuXf1cZyepmXCMn6oIte5ah7Qg2fxLlMGTd4GL4ZvyPma+9
	 LtriXqKP1vgGD/iZcn5z2edI9j95/XeWQK5ALrUtmTS7J1y/CaXhd7AYSXNmrMqYRLapM
	 L6xfSGurTt/rLWugfF50nz+Q3VVtSATnBdXiHynxCQmeTsXiByhHX1RBbFMjZuRJa1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=nIH9XPRi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.1
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011001.outbound.protection.outlook.com [52.101.70.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EB2606A321;
	Wed, 25 Nov 2026 16:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1EB2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=nIH9XPRi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ar97E/Z7nth9VMENNzmIJfZzyUDRxBE18LlpiwpRWi3ql7y+X79HKpZz7pUmgdso8Q242UNV5YVtN++wNMk2CdweJvWz1yhef6YB0lSfrLeLeVnCTQm3AYPhc1FUH3fFdDUKV5uLgvaJZZvywajy0q3EZd4EA7jYqX+2RSh3vbOlFmFT34AxODY58KtoQPXrbIgocNyXWNXSfEHr5JCSTcBGv5Tk99X3FpxOLrVxTGjszA34ImuD/Qjn7ReQhUVaPBHh3KAfpWAri13PGqmTINGAmDA23QGKUzi1JgnsDQvvwxKzzCS0wrs+k41eRlqUGlsYbByPjBrZluW5csB7Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HoGHuuCJqVBarNUeKNtLkdgRV7zB7adrLppZX0CgIkQ=;
 b=kAFh21huCMb8PGTLFgJbsddLIRJXGnB5cFmQGvtSTVXFTns0HkvE673L9ldfxi2FcLTP0ujUN7POQu6j1OZP+ek0rR0Lc75guhkcJs1FPYGd5vBbdNqrcmQMfHXjv9hxdloX1vvxDvjz09qaVA9oYjAWyK7MTsJ7yCQFdjEzpnVG4ETOiI/J1xzaRqZaJ6oJU9OoEWC/riW/9jele7IZpiA14kBjYOeOvW/40vB0+djj+lFmx8E4B8fwhqsj7SSvIro9yy3LHm1PEykISuHqjr9H1RtGYe4GPYJV+SakoGMD2oJukWcHfNuU3NpdklVVHCzAqmOO45yzgzhY9uGXpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoGHuuCJqVBarNUeKNtLkdgRV7zB7adrLppZX0CgIkQ=;
 b=nIH9XPRi9cAJRH2B+kDew3xXazsi8Mr9olo1aY+I7n6twoXmr1+SiAJGmNwklh3K2YwnpMDXp6SYTusas62+JHWvEvDyIPrkVZXp4Alx0zQ3l9e8GqEl1aX4DkQwzrQ0k0bQf22nybWzV6mvdkaw23FNM64lVZ540/tR8AElBu+FhSpBYL7hVqHzREX7Dpm8otipBiD702MDdUl2g93ik+1iY2waB93AYT7wM/9ldulCP6fi6G9Li+N48YiWQcOY7RfrGUzal3CY8eEcCnuge2de9CZ3zHikCJ3r1a19iGwpQcO2/RxiMwNJlywOdHoJ7LYItpavhNrNJzYHqMIgyg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GV1PR04MB11061.eurprd04.prod.outlook.com (2603:10a6:150:20d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 16:20:20 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 16:20:20 +0000
Date: Wed, 25 Nov 2026 10:20:02 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: jan.petrous@oss.nxp.com
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bogdan Hamciuc <bogdan.hamciuc@nxp.com>,
	Ionut Vicovan <ionut.vicovan@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH RFC v4 03/15] dt-bindings: PCI: nxp,s32g-pcie: One PHY
 per lane
Message-ID: <awcKsk6KvpnNTbaj@SMW015318>
References: <20261125-s32g_serdes-v4-0-3bfe0589be8d@oss.nxp.com>
 <20261125-s32g_serdes-v4-3-3bfe0589be8d@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125-s32g_serdes-v4-3-3bfe0589be8d@oss.nxp.com>
X-ClientProxiedBy: PH8P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::6) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GV1PR04MB11061:EE_
X-MS-Office365-Filtering-Correlation-Id: add0bb39-de93-4fbd-ef2c-08df4b0ffff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|19092799006|366016|10067099003|56012099006|4143699003|11063799006|261021123027099003|261026121527099003|261021121427099003|261102123227099003|261009223027099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9yYs3zwfwpbFm/IfqlIpiJReL6OQbs2UcSvE8exAceO0EOu58wZdJrF//NJiJxMpDyhYMHThDZ/xXTiRmn9Y3Ar4ryxxteMwoAFOjTbDCHlM0pE8V5/27RxLbASE7rFjzkXYUbWJYeAthTOdnhe38ink8dOn54uVmoiJL41LpD7eit5m9oLxAtKriyME19vVYMOzsXtECV35P5eVC4GGJfNYCiPfOIwODWUYj9OwTGa4zHzqSeISpysz+3kBwf2xCICPaE/aJDzPmugoefNtxKRbH8+0cBUzhlUpfMj6zplX+YxecIvN/IyZZQqEwdK5hJJrPmJWhx+A7Vn9RX1Ln+Fx6BngqNlLdOkfb/rx+1BW5jCFZAXEG4jPFWt1DTlBC62CKiFXK2xCA7ySm4TWCm5iWrSvfxMVjuHibOu/jY21Ef3GMwh6ZutPnYCLwsjDPdQG/Wn4I+JYwmRYn8i/+3gLc3clzAdVbsooyJJIEfoJdUevhP5K42XYNGmYX1t45KVr0+2YVtjyx1P3+mtSrDQxBt19BWyXgHT6ECgJATV9eUfAswiBspUx3Fr7BmvkRJKxRmWc3W+b02nMYqDnFoXov8ko37A8tsjg0/+jUVJjO+KK/XZ2npngTxS9yJ6MOeTlBLk/ri5e0Ai824/CQlAq7l99MYhHUEnyytG2JIk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(19092799006)(366016)(10067099003)(56012099006)(4143699003)(11063799006)(261021123027099003)(261026121527099003)(261021121427099003)(261102123227099003)(261009223027099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kfi6JjDoFk4/krbth9kXdAxhCkcTMDiKDecSacFRBoSiWj8jrBdN/A5vaJPb?=
 =?us-ascii?Q?Du5HfeCf4Ah3zI8WLzaYMUcj5Zc38W3Owv1L93DIC5ErqsE064b3Cguoph3+?=
 =?us-ascii?Q?tOST5Xo8BGGPiGVheNYJjlEXYBRSb6UULalmV9PEuNTofjR8lZOBztCukgV2?=
 =?us-ascii?Q?CXwqeHYxzu3v0jA/gq6iBfvNxtjJSKaLazteKweOoKRpwYEQS4nFtn3q6CmQ?=
 =?us-ascii?Q?M9WU6PAzFyTrdldOWghCgB6yHROnvRzzHZpXuZb3vvSU0FDeet3q1+jBLdLk?=
 =?us-ascii?Q?8Dqh0Jz8Gfi8s+8qJ+Q8D4e+xOqWtkNhghsS1uGV6DEUMj1T1rchVtt7kETa?=
 =?us-ascii?Q?xhlP+VmZQU82vrdHJ+Sw9aDmik6nJoxAfiAvWEKsR2jh1JxAXTqi6v2wIzKz?=
 =?us-ascii?Q?zGtVFHa/HOOZz31uiv8zlF5M5pSwQqju0TR9QADDcHdSD3rh8pfoHRWDZ3Tc?=
 =?us-ascii?Q?X2+OHmwezw5JXGs1KZsBiDsqv2+23KCF1VJuZgWKOZe0Fpjbp4DRTtz91U9M?=
 =?us-ascii?Q?OgZF/rWTuAtPiHMs2lOeEi7axd1pO++zStYaw0hVXCLkSnzdFOO4aq2J+R2W?=
 =?us-ascii?Q?I5JMNvpdgyGy1xzEyt6FQ7Swc9SbAtoaIahTUPaoSgVR1FDK9a3fpd3Eg8Q6?=
 =?us-ascii?Q?ptcukv/bSQbNQTQHK9vavGVy1YSzAOVXzlW4Cf9yZKkVxYeunRu6EqTTgELG?=
 =?us-ascii?Q?tV77VL7aDh1IuYk1u/BJmMTCAK+Q4LT08p+FD/Rm61/Zb3uYpjTWZ3yv6Iyf?=
 =?us-ascii?Q?WxxHVSf/38WRQHdfkoVNL0m+WKBGQu334IB9UX8dxUtwrp4fbQQqujoosMh7?=
 =?us-ascii?Q?aG/Nxfh7ZkRfHiCajnVkwCM///6WJAgGQy2C4nduRPe3fYsQ5Ns7oQ7xmtAF?=
 =?us-ascii?Q?AhXq7A22NaHS8DJV9ekZrX5342BnF2JBjkcPvKek19mJHwarMUJghLnBzZUg?=
 =?us-ascii?Q?GZxC89ZpD+RaMT5wnnwjAbzoqJ0XXibo5zFjo0G3lyzIYO/Seje4UCXrtoP0?=
 =?us-ascii?Q?Ic4M94cM4uD+0BnBXCuItIJ+o8X9ZZwBbQ5NUZZomqIPpDXaaFPL6VsKCBBH?=
 =?us-ascii?Q?w7tISCeUhvP2dJCR+dn94FUX10IbUtka3cUJHlhfsO6JIFVY1DXh2DnX03Cl?=
 =?us-ascii?Q?azJrckOJx30QL8KCeT+cqtjxsnQtZZdx3nedM6v5JgV+ImkxjJUYAcEwr5HF?=
 =?us-ascii?Q?x4RYnOgUjKsWCqtEdZ98CPFktX9tJ5UKBamscG6oS5Pd9UwZdEqKfWwSaObv?=
 =?us-ascii?Q?SrGVkPyKqOQ7bVvcVp2fNfqJJTvbNeTxFr72wtPxTFzG9FbhsaRLSEhS1owd?=
 =?us-ascii?Q?p/beOW5I8CwCrA6K3R/7GgKbH3krEOF68QsIlKhBLqREi/NPGHkT+ZqzHdSD?=
 =?us-ascii?Q?WWe+0zH1BSDIiSMbdxPTeW2judn27IBzkqN+GKIM58nfeIMsFDZGSKj2Ms2E?=
 =?us-ascii?Q?U9BtzFWXMcQ8rhdxAyGGLD+/EFJU2F5OzCuR+Wblz7AAl0/8ZpTXTFpqbxhO?=
 =?us-ascii?Q?M+XdkznVmwXtP/WfYDumbNaCWBCnTcIBLUe6JCkktW7n7bkf+O0hsSsgkYc/?=
 =?us-ascii?Q?fo1MlYNP0o3We4AHrMi//BqfORcBKkv3fhWO8EbJsoRv5ZTjopNzT/mxgR0+?=
 =?us-ascii?Q?EROLXC5LObTxHcNk/wyNbhEIU5/aPTYBKMIBEsldX1O94O9FfXeN2uNbuqtY?=
 =?us-ascii?Q?mrlTpZh0IQqbXn1d70OaOvFqkLvngE+/KWam/AbeewnIvG4fi5R0ZU8jzc/8?=
 =?us-ascii?Q?g6s2+aCXpiL8KrFiPXnn7DhyhnMUnVtvYzY7n2FsBZeWxl6dUK8K?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: add0bb39-de93-4fbd-ef2c-08df4b0ffff5
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:20:20.3176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NdEqgVubr9Bbaz9wU5WZmWVNeYUkvFltk4KRungNXf0rcS6Gwi8FvxRghx4LumZOUyi0cE9THtjtBbS0CqmrEP/ugUO4mDu3vlJ2+o2FFOy5eAjkhZYQy7oIULy+hCZ8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11061

On Wed, Nov 25, 2026 at 10:33:45AM +0100, Jan Petrous via B4 Relay wrote:
> From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
>
> The SerDes binding describes a link with one phys entry per lane,
> <lane PHY_TYPE_PCIE 0 0>. Allow up to two entries on the root port, and
> make the example reference lane 0 that way.
>
> Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml b/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
> index 66a050028278..b90d169f57ed 100644
> --- a/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
> @@ -57,7 +57,9 @@ properties:
>          maxItems: 1
>
>        phys:
> -        maxItems: 1
> +        minItems: 1
> +        maxItems: 2
> +        description: One entry per SerDes lane of the link.

Needn't such description, that's native means for phys.

Frank
>
>      required:
>        - reg
> @@ -124,7 +126,7 @@ examples:
>                  ranges;
>
>                  device_type = "pci";
> -                phys = <&serdes0 PHY_TYPE_PCIE 0 0>;
> +                phys = <&serdes0 0 PHY_TYPE_PCIE 0 0>;
>              };
>          };
>      };
>
> --
> 2.55.0
>
>
>
