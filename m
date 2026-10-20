Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792522204;
	b=4/h0+ZndUZm8ytSsKBDy84cQ2lKk6lERoALZ5lz2brAg9FTaqMWYVbLu9+2xELuzPdzt
	 Iuy0uvzo5PB4WY/daxzizEQH+pxDV5zrTQTU6HCf32IXLysFHp9E6/x/2ILnqvmAxsvH1
	 OXHXyqdynAWDp8117nJ/694AUjGBYG8BF1pgLjFpd4aSszO/wxmjxshLq8zFJ/omXoGvp
	 RUq1VnIm6EIiZTRrLbtV8/pZ+rkIz7NGRjHTiozOsq5HVToWGryhMJ74g8FF77KQHKtIo
	 lRISQNHGlkOXXC0HhNFAzPIs0S98om2MZ8MPkzeKyXokcJJXy9j3BcufUJW21x6bGCQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522204;
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
	bh=HDdeR803JMM5w9ACWaoE/kBiGqrdTCLIg23piUn/CNY=;
	b=X5sM9ScUeABoOsVJW8OLeRxOnhBY6QDRCNzkuuLQbtC97+j6ccL0ZhD14QWIgjp0XWL1
	 POXheLKZ3e2xqh2Yzv5Tq+R1wAwlRvk8Y/5s+8Lq3esmkatN4n0+oPA4p6sDUruEVFdZ0
	 xC1Io9OWpsWwjiFIaHYHQvljKdsOPFWa38qoCb7kkRA97troUrXsrW8RYW5PIMFQ1J8Pg
	 oHqn6ihG2DGknrldO25qjDXUruBHyV62b0V/UuE9KZNE8myWdXmmpt4Vbd66171ZTNr6o
	 c3JwHQKoDZCUo+EopUEOa9AJq/uFYUB5pMRsdY3IF77P3nHO3wMFtZJKg+zifjZvpEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=alyV8aYu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.33
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013033.outbound.protection.outlook.com [40.107.162.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E6A606A31A;
	Tue, 20 Oct 2026 18:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89E6A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=alyV8aYu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ea3QuZ7CWo2uaYGkGl1RGj8nPHPhQuMcugph8WgQH1RroSTvaqYahx0IK2uzeysF4Xs5KW7a/L02fmoNGlpfi2YMvsDAHAjVSiWtIU3sR2OQlX6IQ7m/c+xsT7jo3+nEU6n+kzNhyLpvomsyD+zxOk6LTIzGknAW1ZjV2J9UaDBL0/Ol/xToxd8NB/7AlNEF13fDHA4Fqr+NEaoBJ+EUqJCL3+rZelfHmRlhMCG6RF+NQP2aQgTmQmd4LvP7SJUBAZ4I+C8qI0ZsISoCQfYsl0SqrtDvx3prRBjlQbdZ5463hCGnQYTXhN37Ipt9wPt/q0ET6CaBID6YoxPRwnO3ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDdeR803JMM5w9ACWaoE/kBiGqrdTCLIg23piUn/CNY=;
 b=tlbXXABMQCyhVi6Osti0j7XGoo0cUDL3p4twYTKRlEnbDyaoUDs82VuCCq6hkIWKjOgXcS2+pyh1qX1CqOpCM3snJrxLshwwM6gMs1Y0+Los0qbCtG9ECheFMOR5M9+uLI7c6qvoLqpSYUJhsja7xmH2b9iRBvmCDccKqI5D0RZRNJ8O+CNfZbyMK5Uoy8now9D42S/0yUcECFLUewKgoffulG8PErdeHDWsL0TvordSmETwllWO4nMBMkQAiSx0oxls3D5+RjspAZDucx3ppWkoVwAMUpJ68O1NhjQ5t+dpBZCvEBXW1bIi6xAlU2DhurG5JNifTWbWPMQjHqhPwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDdeR803JMM5w9ACWaoE/kBiGqrdTCLIg23piUn/CNY=;
 b=alyV8aYuBv3gfeljShqc9CnxPGFO8h32ui7oglGFGSxf1wD4uyPmO23c/IyoEBW/tS2E7lJrWyrETHpNbxn8Vd0VE44CEec3N8pTwGrDNdNlMd7nrbUpIDdoU6EVhs2zuOvPYn2NXGgr+hDagX4feS1wsAGwoZMu95jV0RaLylhA28c5tDYhlgmZLVKo1Mc1qKSPs9F7MKtuBgf6mZVhRr1ClbgFdu5XEFho6vmVkmCoG7ht6WqXgCxElq39IXftoCxi5UDb+ZOiZ9H6aAdU/cAUPZdl02JCUwESmkp/W+Ii1BLrO8m9kGh8wWnrbRqdJ2mwDcMG/kMuExS5Xkms4Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM9PR04MB8939.eurprd04.prod.outlook.com (2603:10a6:20b:40a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 18:50:00 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 18:50:00 +0000
Date: Tue, 20 Oct 2026 13:49:50 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Frank Li <Frank.Li@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>, Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v6 8/8] Documentation: PCI: endpoint: Document vNTB DMA
 export
Message-ID: <ate3zkYAu4fGN06j@SMW015318>
References: <20261020054948.1218370-1-den@valinux.co.jp>
 <20261020054948.1218370-9-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020054948.1218370-9-den@valinux.co.jp>
X-ClientProxiedBy: DS3P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:45f::18) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM9PR04MB8939:EE_
X-MS-Office365-Filtering-Correlation-Id: 1896921c-b7d6-47ad-44f3-08df2edaf1e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|19092799006|1800799024|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	MMCe2ejClRUexOWpjjzHCvy7/ioNPWp1rT5fYsLmQwpvXUbcHkO1d6qF4VlPF3oe+/pr2q6TtZXTyGMQRw3MEF4ZcVrfnQ+hH0QEaujqNzwx8stUa4UXHlmYb98WBCD1jenVSlnozYtg3lmeM5rytAr/psLe4Ib7ZS7mY09y7HfxhmGAHdgzLf4HbDBK/8fy7ykImIXtL4nQ/ybBLgS/SMh+geyhqMHjyvX4yY6V6m7su/ZU71VXNptCAPsSqP33Pi/l3sBOrPW32kQDkq9kY0suW62ZArz/JQlXk3/SKITX1R/O8+sKRLjk/ku5iUIKRUB9DiNEmqATscj1J5nuEMN/SXGmrK/uQP6yXnhotBS8D8DF2LozmFAEIc0RbgfOMbz7yQN2lD/6/OiLJ1ORqk28QkYQl2TzYy8RYLhdyQlTUPs5b3/1+C8cKfFVlb9OvYFBa77LOnZtpjUthTrKgyjtxQYRWNAORwyWC6eu+WAYaz9HbO09y9HkhRB5AFfoBfOK67zuhLyPNVfWC95UqcuIbNeO1hH9+n2++xDcpeGmnHzzoPVqspToktuw15nBLq4hvWlgJV6TdaQm77Nm+u0n+izMkfsScYuXIpKBFT4ns3hlhx0xyT6HHQxxDOc+AxZmI9Dl9ggFCfX/nJDVFxkPLt3P5hmdL3IGz1VbJkM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(19092799006)(1800799024)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RWdVZJZz5wHPNxARGTgIfHN7dhPbaK9nVoJBbVOd/VXIaTYFqZm2D83aTNDQ?=
 =?us-ascii?Q?4UZ+QRTIAKCqe4XIs25Vcm65pyvENTYfHt/qy1ZSWyVuRROL2GMbO6z9rvAv?=
 =?us-ascii?Q?DKzvOrLngpQGjJeutu5Kr33p0V5AQbnVrXIHq9GkOnhT196T4VDdR1/D5Ury?=
 =?us-ascii?Q?3irAvSTbvpq57fuIZC9rA+Pp/Fj/KApypjH3I6vbky+3DxxhzfGLCRPTOwfe?=
 =?us-ascii?Q?XGPCR/0tmN8h0+gr5erOhrr+np8ialFWibpp3o20W+lRO1xPuxfKnrEBrqTi?=
 =?us-ascii?Q?B5XCuBOWta2nNKzR9VNcMRReg5ArQ33I6zS8cgfsh38U8dE2FvXzMeoUYoaE?=
 =?us-ascii?Q?Py2JLEDioYyQs2vIjuvT6zEteWzg+JlzYyyGhxonc1o3TkcLIdBrHELGXhnA?=
 =?us-ascii?Q?G7HOu/Y5h7vYzwFbTWRnYO6D5HCamCIuGmpq/lsxm7G9wnKvSIphUUHJ6g92?=
 =?us-ascii?Q?wH/SF2072/czCQSSr1BFqMmWAWa1fkrwbFoflX1U61TpzPMGUSSwnK2JWy+q?=
 =?us-ascii?Q?1XMuY50VJ6bt6+SSCNFb1lBjk3XYSjfZ9owfR86isO0GXvU8i+U1zve6bJ6w?=
 =?us-ascii?Q?cdIGugHiAk4e7wXKUkvlDWCFthg2CQqFZ9YJLGSGJ0YPByf/6013SOBe/QGw?=
 =?us-ascii?Q?zAZDuIAwXWinxTjUIUg6LCMgH5yHQTsm6SBGRlQYNngIB64jquJjMKMJylIp?=
 =?us-ascii?Q?KuGvjd6PlqbY7+4Wi+OwN9nFUq/m6ebqGnSYymMTorHaV1Jl11KRn2usVUT4?=
 =?us-ascii?Q?jo4BDjMLkceVSWZx6/RTf4r7o5OAyiXAQeIKQFUrBbl3Nkat9Z31AjlW93ZM?=
 =?us-ascii?Q?5RTjiaAnjC0bniMPN3nKHkSjly62cY2tI8meaimnbODwLJHna4m92yIrScMC?=
 =?us-ascii?Q?xMCiAhcMAn7LCnh+gKAIu06wPz/CsQ099wCJr9Tq6PgYnlkzT+SEJrcVUzqt?=
 =?us-ascii?Q?2RYYtuZAEnKBGfVcr+ziFdrgORYBi0JUh7VL1H4MliG6ZqzUxSY5LgTnuTA6?=
 =?us-ascii?Q?n6gezGRX3G544Rli0aT+F++xZ8AY4T0NlBhctZk6kE7j+KcHHM8CBzNWSLAK?=
 =?us-ascii?Q?EeQUhwCr6r/x4VMROupmSIzv0UUBahtkwNoetZzLWolJlbVz4DtNkeQT+bW4?=
 =?us-ascii?Q?bKg+Xs4n2VRi0d6XogiLiRvRI52QxoLUI09v+GTyczGCQLZhrgkYWUDrzf78?=
 =?us-ascii?Q?fsJPD1wQ8tN5PvPiWGyo1JWZSPqk2UYE9YgeX/qEsqnTag89wEjtre2dAxUP?=
 =?us-ascii?Q?nDrtN7xLI4OTH7I2eWxdi3j6IpEH5TXEqfo+tszcrEdE23wyc/Fu1f7X7UBL?=
 =?us-ascii?Q?tzWjApS53ZQr8/n5cLRbbY+gIDBP41uvtfOBRe9tsn55Kj8FLCxVZYPI3DXw?=
 =?us-ascii?Q?lN6/ZearA3wHH7i6OPOzvqgNAjBDP7dBTxiibmVI3O7nK2GhtLvbZ7jWmsQy?=
 =?us-ascii?Q?3JNFxUN1LcyvBANmYZOEjx6t5a1n6VqLD7p1k3sIpF9+tY1E7aBGYaqWRJkF?=
 =?us-ascii?Q?7luPFFIJ/C69Mp8R9tIAfh5dNXSlgzjaR5N4K+pCiq2REWHa46QPZTdzEXAm?=
 =?us-ascii?Q?ZiZFF9bZgLEQlm4F1eihSVdJPkYjDQ1m2Uyzo+fSg/+LziaKSHkIqH35cJdR?=
 =?us-ascii?Q?TjrgEs8/vF/MFq/4H5tJMBdZ7LjlxVRhVFK8b4/jiUTyWdtmcV8MmNqAh8M5?=
 =?us-ascii?Q?T1RIi+EoEjEM7fWJO2zFTr7uGMqe5H3CORX8cyRQKTlbuUAi6toSb+tBXzj3?=
 =?us-ascii?Q?TJpg7qAtVnRMP+1B86xlYFOY1I47fvrqmxo5HZa7CEGGKIv5UWOe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1896921c-b7d6-47ad-44f3-08df2edaf1e7
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 18:50:00.7909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ESc/pBdk4zs8UJpKYCdi7j8wM8r5HSiYdBh51EAcjflYcbMtyhvTPHafZw8HjJWPAfJqyA8arCnT/PiUQEEjRpu0+bHdlNIyg/qPeKpUkc3m2RcyCpVpZU+Ner19VBkx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8939

On Tue, Oct 20, 2026 at 02:49:48PM +0900, Koichiro Den wrote:
> Document the dma_bar attribute and the requirements for exporting
> endpoint DMA channels. Also document how the selected BAR may be shared
> with an MW.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes since v5:
>   - No changes.
>
>  Documentation/PCI/endpoint/pci-vntb-howto.rst | 31 +++++++++++++++++--
>  1 file changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/PCI/endpoint/pci-vntb-howto.rst b/Documentation/PCI/endpoint/pci-vntb-howto.rst
> index 3679f5c30254..7ca4e1ff095c 100644
> --- a/Documentation/PCI/endpoint/pci-vntb-howto.rst
> +++ b/Documentation/PCI/endpoint/pci-vntb-howto.rst
> @@ -90,9 +90,9 @@ of the function device and is populated with the following NTB specific
>  attributes that can be configured by the user::
>
>  	# ls functions/pci_epf_vntb/func1/pci_epf_vntb.0/
> -	ctrl_bar  db_count  mw1_bar  mw2_bar  mw3_bar  mw4_bar	spad_count
> -	db_bar	  mw1	    mw2      mw3      mw4      num_mws	vbus_number
> -	vntb_vid  vntb_pid
> +	ctrl_bar  dma_bar  mw2      mw3_bar  num_mws     vntb_pid
> +	db_bar    mw1      mw2_bar  mw4      spad_count  vntb_vid
> +	db_count  mw1_bar  mw3      mw4_bar  vbus_number
>
>  A sample configuration for NTB function is given below::
>
> @@ -105,6 +105,31 @@ By default, each construct is assigned a BAR, as needed and in order.
>  Should a specific BAR setup be required by the platform, BAR may be assigned
>  to each construct using the related ``XYZ_bar`` entry.
>
> +To export DMA channels, set ``dma_bar`` before binding the function.
> +For example::
> +
> +	# echo 5 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/dma_bar
> +
> +This currently supports the unrolled DesignWare eDMA layout. The EPC must
> +support subrange and dynamic inbound mappings.
> +
> +``dma_bar`` cannot select the control or doorbell BAR.
> +Any rounded-up BAR tail is scratch-backed.
> +
> +Leaving ``dma_bar`` unassigned disables DMA export.
> +With a separate DMA BAR, an older ``ntb_hw_epf`` peer can ignore the extension
> +and continue without DMA. A peer that understands the extension also continues
> +without DMA if the advertised type is unavailable or no DMA IRQ can be
> +allocated.
> +
> +If no spare BAR is available, ``dma_bar`` can select the BAR of one MW instead.
> +DMA resources then follow that MW. In this configuration:
> +
> +* The shared MW size must be a power of two and its translation must cover the
> +  full configured size.
> +* An updated peer is required because older peers treat the whole BAR as an
> +  MW.
> +
>  A sample configuration for virtual NTB driver for virtual PCI bus::
>
>  	# echo 0x1957 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_vid
> --
> 2.54.0
>
