Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795452571;
	b=ghsUCftRwjwOQ0vdYelZuV+c2qU7+nBzhT9BNmaghY0mHWgZjsTr47hS6pa1m9sk/Xci
	 y6pWwrZkvv0tpl7tz/ZnJFLzAlnzLKOX7C2DbK/zQALnK04JMX3ZLc/n3vKX2YDerLMiF
	 HYc3ZCal/TjSZ/t6OJkOAYqbH/9qvR8Pxbm1PQQkReUFCIJBpM+WMudbC2kKf5tPHcKug
	 MxnIvFrr4W1A69Jhik4+LzCdx9u//Ayq86CFCMzEXadxujKlT0qdoSi8lRAyeqS7wJMll
	 hro9LajqJ8IUK252a+L2QeRuSfEZyhEFv4lDlrXr5TP2TTXV4xVfKLSa78fplU8PMAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452571;
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
	bh=ZNFeL1VFN00i/KtF+wgOwLN0zk6RdAc6r9aBhDbd/NM=;
	b=TN6t9cWXJrAMvMhSvjLV9W/cySdTDa7JRnWUFDiIQCBq9YeNHoLbat5WKztnv6T8pzDG
	 S6G3uIMQQKrcJPue9b+tJECb5+kjm7D/UgYn6fW1TsQyil7rO51LjVv1+ivHVXn9RmwOo
	 WPZbX3T04uW5LZuk4ONnChD1ix2E1GVQpu9v5Td3pFk9gmOu3SkCovGu2qoM47/Tz7I4v
	 Iy3+Uqnn13JgmveiA9+suL6cAoKk7rOvOTNMWa7W9vqzDpORjs9HP2PIzbnQNLpVYkPGc
	 jYlk/jWggPxjrdZoWslQvSM9KodNYe1ynClYlDezAS27V+yYxF+8jbyLNBO7UpX+F4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Jf1991mP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.43
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013043.outbound.protection.outlook.com [40.107.159.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D341606A69A;
	Mon, 23 Nov 2026 16:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D341606A69A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Jf1991mP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQzhYX4Bqi0Q+N8m99Y5gogEmSbih3yn6L7Fppg5I/fP5Z4C1fGx964DKAQ8iyBsQRusM0N98o7mgo+lJgKY7C0NtjfvOahIMmviJIVvc/lJ9ekbCWFjv47nhtzwAjWflRRaBNlXgZBMOnecJ6YvHSvwqgF4UK9kkhsIavdUtMVDSGvAoeBStsjcAWHzB5OCvw/nKNKl7nQzEVbO+m5brxcJIlTgeZpukvfoLxZzK3Bq4evH2Qqn5ZXmXFquDGzSUq/uhCWreCeHzlsE8jxl5X8LzBIsAcN+Zre+1cSB1B+6hykJR5itiiADK2CBmVej9rexcRJL4FbTPei6mJ7zSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNFeL1VFN00i/KtF+wgOwLN0zk6RdAc6r9aBhDbd/NM=;
 b=iS9VFeMxemBssnSYyOkfFcf87TaneWKrAMTvNg0AyRWrF2bQRjsidJ0S2RzhLPJ6eKt8MBzl1jpZUDnP5PdKBQIfnGQyPcRv9bq9QK9lvWmdXU1Cnf08WyLBeAnPAzxcB76iZ0CQKDMQ0VT404CQfAZuZPrTX2wUT1uAUXFmBGSWU8ATDRKSBNjN5A+W2aQKYqh0Z2PzXq3Tgw/a3yjYfQtaRX4o8QoFBiq6R8wh32BhuuDGYM/XNjd8A/y0Odbn+vIz3yNaf0dN0gSxf1hogvPtg1+4T4dSYIwew5aB8fVVAmBsKaFWxQ8ssDQdsP0zPIwQiDPtT7yiBpJH3G1cDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNFeL1VFN00i/KtF+wgOwLN0zk6RdAc6r9aBhDbd/NM=;
 b=Jf1991mPzpYn/plMDzQ/xQfFUrIfnR+UZ8dtnycJ2m1wAn0enTLr5XscRHWB13Xb1cFWE08Zz94YGwF56gy1V09UYZztezbtHM/CMPBLWV5ABBy6bByXsFryqPTBHHxOO6X4SksWYNekVeqg1bffKG1XoSOdMnGTrdd1193zOZHDgKYy7HnkIylkNE0Js2CPr6CqgqFOqUh6emdPCz3s74k0mm17fLha/Ocy+oTOyktQEZei7Zomqi59lof3s5HfKh/piX/E82aeQSUBm5p5MNd2Wwf630lrC+VipUzIe4g/wBfIsGIuWiQ+junwLBgIrDpBHK5Ri7IAIgvVrWoMMg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DUZPR04MB9796.eurprd04.prod.outlook.com (2603:10a6:10:4e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Mon, 23 Nov
 2026 16:49:25 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 16:49:23 +0000
Date: Mon, 23 Nov 2026 10:49:12 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH 04/11] PCI: dwc: Preserve glue-provided eDMA HDMA channel
 separation
Message-ID: <awRuiDDyydE4Xxvj@SMW015318>
References: <20261122-nord_ep-v1-0-6d8839ffa9aa@oss.qualcomm.com>
 <20261122-nord_ep-v1-4-6d8839ffa9aa@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261122-nord_ep-v1-4-6d8839ffa9aa@oss.qualcomm.com>
X-ClientProxiedBy: PH7P221CA0016.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::20) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DUZPR04MB9796:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e5b17e8-6962-48a7-636f-08df4981ba4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|23010399003|18002099003|22082099003|10067099003|11063799006|56012099006|4143699003|261021121427099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003|261021123027099003|261022105027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	69w8foCi6Hf4UAAqCW4FYu5d+dlayni3cT9KlXLMqGfQxAoEnq/Kti9B09OJNpGelTEKSg9PPFd4maVGx3RvreujeS1Cqu2oFbSf8JHyQTGqIeQAKXS2Ou3pedf2TuDh/fkSQWfib/pIz3+vibKe2b9tVH8wUIIRbVrl038vNJKmUSTnpbRkH5raewfNgDoaSZtcyVNPBM936FE1ixtLseQSXWjS/zBMjxDiOcAzyaFB0+Lwl609Z0LWW1p6SJxSzRJoclOu+6w+JC2IxMNIG4gg6zR5Rz6bDinQ2CWyhhvsV0o88PiSHs+3cMhZIN8/Vy26D7sCJiXCP8bvUYIUKzuk4QuNy2lTM8yLm9xhRETT+aXf28JCwp7pRNYw+eoK85W9kp/Ql7oHFGscudcP55oRnRvFiluoslh5YM6Q40TLaWUI5iSjGYP1G/+VdM4Hst1j4/W6uF/boSocpimEcgdG3jrvSz3JQCzpLKBWttTsaUMLYx7adZsvaK0yMRzaMNwMNel6SFn9EgKRMk3oiLwwsus8pztKO/StWlHexJNTSWgFqfhM8QQkgi9B/P266fYG+vS6U7xRzWOudMpvVXawU0Iq7JRMyt5vRn2iG/CR529hjMxZG6KNSxaD3oe3Z/c4oAIoOY1kow9bxNwB7B5ElpyJjupHZxzX2+CZONk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(4143699003)(261021121427099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261021123027099003)(261022105027099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B9FADv0OeSJx4eRp3T8F5UMqR0n06rLyx8druXHnPfkzvsT3K1b4getgQzF7?=
 =?us-ascii?Q?Yf0rkhRk6BznxBVkyL4h2PT6QCblICP1cG0ErnyMyNKPN/7c6cpsT6tEcIlJ?=
 =?us-ascii?Q?cZn5FMjzACw+D4jL/xnmxa9FNAB56/7T1qPWTIEZry/iEtDcPtKoalZ6dGz7?=
 =?us-ascii?Q?isS4oTLT/8Onp2ffnaCKPMAJciEAzEFb1tjIzSCY8U4puU8teux+b1sPdkLy?=
 =?us-ascii?Q?aLn6PEIP0FJP2ZyYzz+trUDsD9Yiwd+yWrnu98z3Y8Q+woD656j4TYYcdJJ8?=
 =?us-ascii?Q?+CWah5g2nbS+S56LKyYXDVPFkA+Pgn5kH4sdLPNX43cIK04CxiHa367L8OLI?=
 =?us-ascii?Q?YAu96UUnPqEOtxs/lBDuuVTh3XqeoaXb8xxWdLnDbM2yr96gKMVnPPNATkYQ?=
 =?us-ascii?Q?npeoxmJhqJ/9nPvCy7tIlfW6HXbLeXHVZ0X6VpzmHqrWzbObhrkAx/L6iwpA?=
 =?us-ascii?Q?1yYKjOyKnis0s68Lf9eLidWT+qC/izF1VRVLujQJNdygFkcGSF1WFQ5bsvWO?=
 =?us-ascii?Q?fcQvobH8yNtpcw8vqyCbu4wLTT2pZVGUp6Uh2F2KgYwss/7B2DmQ94mmjG2l?=
 =?us-ascii?Q?pOI9ZNUbwuC3f8nDCVr3EpWkxBAtO1tn3faISLaJwXZkvY9CU7hNj9vqrAMb?=
 =?us-ascii?Q?fto+h+ldJh2SyEv9MGqgEHV/8IzUJupcZZg2iF7wAVMR0klhhx3lhzSNRpfL?=
 =?us-ascii?Q?qiesqcRPHmZYqUZFY4wTWuCw2wnOjtn+SyCmQ4BRxIDykWNrV+AmnWXPvOhy?=
 =?us-ascii?Q?xlKyAs40aCFPLX1LVFRODzfB7VrYp5NWI52El9OIFLk3SC55a4k4nRbiqtnz?=
 =?us-ascii?Q?qx4XX7w12iPyF8ViAms/c5AdfLAgjxLyELpDvpE4k5IjYYrzyKNtFm0RVd7C?=
 =?us-ascii?Q?QXjDdi1nJRFO6h6P7BoDBnS/2AweZmI7DNbiu/VDRc/pnY/NWbZ+owxeFCyq?=
 =?us-ascii?Q?qe2U3upZbYwP+qo2SjcKNf8EEyAMNFk6tqwVmRvqMT0JYxgqVAje2c9GeYWR?=
 =?us-ascii?Q?oQPlwT6cJbhEYAlXXIK5Gl+vQeO30C+c9aXiko/JLRusTJH8tx2MQfuJoMjC?=
 =?us-ascii?Q?QIZYJe0lNmOCctdsFI8oHclf2RO6nVVv+HyRW2Idg7ePkJg3Xs9+jIOC+5Ey?=
 =?us-ascii?Q?zZRd+gpzkhtml2p46XOL0bzG4TtrzrDFHwv7YwtmFJyUDrHLbyTysQYreCE8?=
 =?us-ascii?Q?PBxOZM8TUakM0+Nmzl+BnA4NnGRhDCDY29zhHv8NsfBaHzY5BTggqepgK1xW?=
 =?us-ascii?Q?ikSwKVRXWq8x9/jmsboRI3vCd9h6rn+xC7k+xC+y0s+PeZ3PGIGGbJZO06Bg?=
 =?us-ascii?Q?iBhEKGcQHVKoJtBLF/jbJPCP5YC8ImwoS+FGLSUTJnBU9iSsDqZXXAHD+Mb/?=
 =?us-ascii?Q?odNaobS6xsNmVPlzWUvI1NCxJzRe8SBpRimWNE9M3jvPRImm4yae5R/vWNVc?=
 =?us-ascii?Q?bmHrjfkVrXxXR3ETdLOJtBLWnzMu5GskCI5MG7TAAeP49PvIJKaBxGyZC/2s?=
 =?us-ascii?Q?liWGzJXmIPixafNP1gXZcCZbnflWSrFPJpWcXIiysWPHDwPhMuRSjpenV5W/?=
 =?us-ascii?Q?j0FKQpq7m6+aCmFS72Y7LW9Atvj9/Y33b08EDS7WSjgi7OtbyS0WQQ26P06D?=
 =?us-ascii?Q?w/dGlRud/CXFF9gQaowKCSA/ZETLZNGqPqWyF4QSIJ6TZrVO0c+7lecy+Ikk?=
 =?us-ascii?Q?KRNq2EIFclKra808CuxwohavoI9367ovjPQiyWlBGNIW1yr8PYEra0/SXyWP?=
 =?us-ascii?Q?CkD5dn0Tmflv+94QxFMrhjlv3V4XIv4QqvLMvvu9I4YxCl+Z6XB1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5b17e8-6962-48a7-636f-08df4981ba4e
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 16:49:23.7264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7XomWk0w2dV9vP9DBaK0BJJrzbWQZy5kjKVvAsB8jsslrwdI6EkIb8SsUEYZYmpT8SZ/M/4C/U+uZRqlqF3Wen3uPHxdLa/KuQ63QScW0ANaWFjlwEn8K1iKMv4N2HuV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9796

On Sun, Nov 22, 2026 at 08:26:17AM +0530, Krishna Chaitanya Chundru wrote:
> [You don't often get email from krishna.chundru@oss.qualcomm.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> dw_pcie_edma_init_data() unconditionally programs the HDMA channel
> register space size (ch_space_sz) to 256 bytes. Some controllers space
> their per-channel HDMA register blocks further apart, and a glue driver
> knows the correct separation for its hardware.
>
> Only apply the 256-byte default when the glue driver has not already set
> ch_space_sz, so a glue-provided value is preserved. No functional change
> for existing drivers, which do not set it.
>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/controller/dwc/pcie-designware.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 12f102f48d5d..d55d4213be33 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -1041,7 +1041,10 @@ static void dw_pcie_edma_init_data(struct dw_pcie *pci)
>                 pci->edma.ops = &dw_pcie_edma_ops;
>
>         pci->edma.flags |= DW_EDMA_CHIP_LOCAL;
> -       pci->edma.ch_space_sz = 256;
> +
> +       /* Default unless a glue driver programmed a different separation */
> +       if (!pci->edma.ch_space_sz)
> +               pci->edma.ch_space_sz = 256;
>  }
>
>  static int dw_pcie_edma_find_mf(struct dw_pcie *pci)
>
> --
> 2.34.1
>
