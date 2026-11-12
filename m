Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794519487;
	b=4mvmlCyFR63wTUK1fJWuvS69CY8N7S+UabHpl1Vtg8lxM9mNGw2k/clWZWkkAqXAfynT
	 PCUNZmwxEVCFcMSqadiWNlJBbOkh9CcjLnjsp7QehId9OsoywkznzvS8OHRurVn47kTCK
	 qnSKaN5wd4UF53qsoBEkvifisyRPeq2Pe0tvWEjmlf14INil0rX6ohIvsA5661aSDszwZ
	 CJZJYIBylHjEy/PszViz5V2QdP5l4iLkPdnwk/LRRbhDwTB6Q58N8I1sp51OPGaKNW7W+
	 8jf1vErU8Rv1cIMbFZvTcEtdgc1eZMREEShsWXKzMn4j5WTH9S9HsCeZlXQNqi4AENg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794519487;
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
	bh=NjSTPdxpwJmZ3OTNZ0TT9yxnWZFy+RKcVhLO2CmBamE=;
	b=I0ieDHpKXANL8ZJyDdvnMe1toqxFcihiG/A8mp75dP6okRErw7vnv7ET2MjvhZSaGeOP
	 JOgUUGQd0t0yupxMT2KkB/0JrXH1OYLlIg7HtXlPt3SKYEJRyrMYkycD+BKFkqDaJqIR7
	 sfU72BnHxiFd7CZzVGQWSkDEtklBi+eaFimVy54YhZEFdNm0aDB/qGG9AfA+aakUuSRu7
	 Hs3XwumL5YP0AXBmsRL/GJaaQSGdmlyzaKsshFBueOshLexDQkgsuN3yJ0GgCOVauDOMM
	 DiOvbOLdEkSs9oAx5vylWhvaqxN45F/kh29p3a6sV0vhURJA3Ln+hDeJF2WCRvjvc2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=PQxEm4YO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.10
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013010.outbound.protection.outlook.com [52.101.83.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2F1606A31C;
	Thu, 12 Nov 2026 21:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A2F1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=PQxEm4YO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+dolexQxgIMdL85KHPGR/bO2NMyLomItnhfSSe9dE2ol0jC2zdbps2Ys3XJgws5TWzylbe1ifCzAXBuGhlcenMUfGpxboIgTM0wMciEcPz+/2V0RHzb2IGMZTsDRYxYbfIC3YofE3os8NKDZPL/JOIDUwjJvHwfmKA4L4PZZIkKSVqFWya6TSdXAqzuwvYOMQJy6IXYhgqc1YJGSVzSMrObXu9rcnEezvmEyF0I/y+V84GbiFHuK8Kq9muw22xwdneA4TSuu8U5jNc0mFedL2ndXurY+gW7NEGp4vqEmzL/hXqe3nhifHS9000JwALN2OfdF32AM6jKU/WBQMQO3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjSTPdxpwJmZ3OTNZ0TT9yxnWZFy+RKcVhLO2CmBamE=;
 b=uZ3MO4AnBfum3qnoMA2/3dudzEGF0BCikfmFGXLk1V0Djph9QrP7otO86EkhXTidS9JoVIHP0rOka2DSy348006s14LORCuKyRgOqrP9f37MSpVEiaL2V67NFklLim7E64ritzGcZm9oaWlgJC29X8SkC9xnvB44EcT5/v+wdheVHZX4yAiG1/xHvuuUWILVEsieHPheuyb17x3mffdzmq0OAFIU2nHFwlaiz5JjZLJQj2Av9uo0SHhP6f6U5rAhXi/T9QLlWHPv3nNkg9qk5c0LUYZl3O5ivVSEjEYaE670p9MZp1Ayz3OKusF3BuOngaHuwJZVviZj28GjZXrldg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjSTPdxpwJmZ3OTNZ0TT9yxnWZFy+RKcVhLO2CmBamE=;
 b=PQxEm4YOW/07ZB15xXoiw5xBJVPfiM6XsfRftEGAkGI1JJNAk4V0p8dShVpLogciIwQOdPZVEh/CeGRrIP8mW/kVnqMmtsIexoiMljAaSwLEdlXZaT+FkN/lhRTYyPPMVJ+M49OPLMkJtVm9EXPAy2VI4Wwwd2TvXXpM3UgwePIADXwA+LGbLlNwQBWioBqEFj4dHiD2jKtBc7gbKsr1yQIlXVj3Qg2IR/XPU+XckZjnBJs8fgtH2GVFAZETwHIL1Nl9tREIuDyPfc3B+oKIJWlNfFc2MjwB+gQveQ73wVwHmbiKQOQA5CqAYmdbLuQCBatYiuGl+BeAchhmM/aHvw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GV1PR04MB10702.eurprd04.prod.outlook.com (2603:10a6:150:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Thu, 12 Nov
 2026 21:33:03 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 21:33:03 +0000
Date: Thu, 12 Nov 2026 15:32:26 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: nathan.lynch@amd.com
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Rientjes <rientjes@google.com>, John.Kariuki@amd.com,
	Jonathan Cameron <jic23@kernel.org>,
	Kinsey Ho <kinseyho@google.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	PradeepVineshReddy.Kodamati@amd.com,
	Shivank Garg <shivankg@amd.com>,
	Stephen Bates <Stephen.Bates@amd.com>,
	Tycho Andersen <tycho@kernel.org>, Wei Huang <wei.huang2@amd.com>,
	Wei Xu <weixugc@google.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 05/25] dmaengine: sdxi: Feature discovery and initial
 configuration
Message-ID: <avYv0Bqqlb1XToLU@SMW015318>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-5-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-sdxi-base-v4-5-3668ccc7aab8@amd.com>
X-ClientProxiedBy: VI1PR06CA0101.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::30) To AMBPR04MB12445.eurprd04.prod.outlook.com
 (2603:10a6:20b:75e::21)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GV1PR04MB10702:EE_
X-MS-Office365-Filtering-Correlation-Id: 2941a568-bb95-488e-b694-08df410487ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|23010399003|7416014|366016|1800799024|4143699003|11063799006|261026121527099003|56012099006|261021121427099003|261022075727099003|261102123227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	gbSUUlO4MvzdyZxR2uX4cKq0mVvrsoz2JGR6KGJWX4XnmBbVH/x3IGxZJFrkJfWgfYromCg59h7VrdUkUhrbLqlpN7Fo1OvEBY8gRprK72NVn9vK5BUdUk4eo3Gw0lSvkj1YLT7bRF8WH4z3RA5NsdP/UjCmDn3/BWd064/8mmjomOUDxWLCriHuzIYF458MvEyphbUpiLaulg0dpoXvkLWIep8nJ1sc7HJBlRrfZ10nh+Q1Z9JpFrqDGyShX0sGIvTCNc0SA3jIKHdCA4ZpEzL6cPZZFCgsvKMQa7l5kcfqE5ed3k0UqRmjzs5FFQJMMiRu3ZJFbWwcSyktJ5GkjLjtgt8o8YOY2Skfya2td9l1V228bD9X4r23SlWt3G1NvKB9Cxreb01dj9cQls3HzsMVpTzBdlxxBsvhMPIXt9EdWMB71KnYqBAevMAZl0aggFgGX+XyQSoXuLk3VChAO/YcQh6puxxB8CA95lF7XVUz0TUIsCWr0mXjlgl8wbPTOgUP2ynS+n0WM97EIEc8kxfZVLjolVDD4yg7dcAg3lMULg8M7l2fLjqMhbTWHsQ+3OJNbAHVBKv4HkhgAbkagDzkq9zdnwhHKT94cUCbs7zl+8S8954iYPe2gu8rgrtG5iZdCFLnYSMAf47DHMwa7hLSLhL77KoaOBFiEvz+MS0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(23010399003)(7416014)(366016)(1800799024)(4143699003)(11063799006)(261026121527099003)(56012099006)(261021121427099003)(261022075727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ntRsJfmIyRe/Ij6reGM4kkneH5f6OgzLr4xrXB1nLDX5r+Gu76ZXt+Wa1Xv+?=
 =?us-ascii?Q?ebRbh+HDVhYalcZmMikkI0WmylOtTx4Rr5A0pp8QsLqo4VPrQMjY4NAGdWKn?=
 =?us-ascii?Q?n2gtDQ3WXtpBTcWFzSFdGz5+wZtK1ACyKXUrrTTKWecE80XmKPDIlMF407pI?=
 =?us-ascii?Q?Xx13tLFEP9vo+0INHQlDsyJtwSfQCjYqeeAeLA0lKWsRJw8axYo9i0Crm46S?=
 =?us-ascii?Q?q0ToIQj0MzTaaHjMWScXpOgadyF65Mez+clJ1vZrDtNS+XjvtmCH/YWFnyCP?=
 =?us-ascii?Q?3G+YZABuDI+kDewUr4O4iBcP3cR80s/h6i4c1PV6+9V9X0x8vNxFdwvG0Itk?=
 =?us-ascii?Q?HjRDEK5ZjGvBW8bU7LPlkR0y16EAtV1Wdmn8hocR2RwlA9E2jUjJskfftqza?=
 =?us-ascii?Q?svX+oGRPufyZOYOFqFedAr/k/QqFRKFhazjetfFoIXI+vtL6ZqJ/Cd5zD8Uj?=
 =?us-ascii?Q?/+Torz9pWhiGHiEJTOdV77JURGj3yBxnpZcDTPWfknlN/YNIUjDESsXnYrvU?=
 =?us-ascii?Q?MY0pw1QLiWYdPOQzPCb9mY+6H40gmu4uRgn/8FpqELNPTFCIMJoyqjS3ACBt?=
 =?us-ascii?Q?d01Z/aF4eYCdamk7HikDM7/1IHSnanHKjD/jxi29+d57Wh+dY9/aDVp1yAu1?=
 =?us-ascii?Q?TWCSFln7EB2KwHMqvlWFtOdXczVww5+Uw/hME6mHOjqY3Z38IF3MPZysXA4w?=
 =?us-ascii?Q?YNGzCdANnPNSgAnfQNU0HJxg43540UNlCHDvpOq/PRTTwkPPtn+FeVr4smGK?=
 =?us-ascii?Q?6XlTQ2TFFgpePeowgwJkKREHcxDKqJciNPUdxqR7Az2s9mlRpWEN/LmcIc/2?=
 =?us-ascii?Q?Whocw9US4wFKWYWiPnRl03hwAdb3rXfKUr2k7bPJkNhttiQsF9qRMsz5lkfL?=
 =?us-ascii?Q?Q7SYfLSaedgILvIlOzcv/T58hh9Em+XDCJSXAXRiYkuXX3+gk+7C1UnBIOao?=
 =?us-ascii?Q?46azGAyWuB85CSTHMgO4zYOk/SG1muvCfjhimFAybLOScSqqKIHG9DttZlpO?=
 =?us-ascii?Q?2BdnIv80s0NvIRwO8Y8Vbbm2LCLW0arsQb1rw5LdpxCt9lmYyHe31MxQZxUZ?=
 =?us-ascii?Q?ra2EWjpKtN16R3UxdgI42B3AZjLNgkjYUjBGnvkBxF2nYQjJpA1HQJZaNkaq?=
 =?us-ascii?Q?iEFA5zJ4ZB4iJiYM4mOovvpEPPuPuGVRehNHJVvCrIAiVnScixyJRUwta5Hn?=
 =?us-ascii?Q?8dv632//EBxPGDagkf1E46V7lkqiWHL5i4J2+P+84P/2AmnmtsMkcalBAGsc?=
 =?us-ascii?Q?EBLys9qBsmeSC49DEDbs+4BNE7gc3AxG457t74wraTMz5Sf0QIN8jeZYpqL/?=
 =?us-ascii?Q?LKr8Z+empFi6X1OZ96/vZeANLT0nX0xE4v4g2FAl/hQJ6q/Q+9D5Mm+8cnj6?=
 =?us-ascii?Q?5pUNXINXhWfeKCf+iN55pZfHJwNWLYcGFrQnXAg4mH64Ajh3TzTUxxhpPg05?=
 =?us-ascii?Q?8lt7FRyBehhTxpMlH2JMbNeJTKAv34xzerZXrJnYqCNA6FVl14kFdr8yhHtC?=
 =?us-ascii?Q?3P799+msgSY24K2NEcKFtgXeNaiDG8Sg62mljy6krti1gp+A7FRdOblDGuJD?=
 =?us-ascii?Q?Jz0dwI7Miqa6R3Ftjbmno25cA6aMGMHNcWpEkqbQgHyd7fk5wrilt7RTC5qK?=
 =?us-ascii?Q?M4ysGnYfn8mrhJyHDuZSZbg7VT40y4ZluOZSt5JQS1e697U+Vwhk+I4/KRMo?=
 =?us-ascii?Q?VhHYOH9js8my3QoNFFj5xg+o8ML6jRB+cvyzrsNaCq+fjrABLR96BH/0B5FL?=
 =?us-ascii?Q?37ooqgzLhKrlIeQX5ygerW/XnPbxU6HwFnJnsU4R3G9hTTrScCSe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2941a568-bb95-488e-b694-08df410487ed
X-MS-Exchange-CrossTenant-AuthSource: AMBPR04MB12445.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 21:33:03.2423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yxu6BCu+4VT39M1ZXQINgwHXeACzTU/o6zSkB5KR2jIdwD4widugPc6XaRQroKmMa+I1LyFcQVOH0WePRsuUWRy1rCuuv0yJsJYsup6HLjC/b8x2dR4PBquOgPs8ZotL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10702

On Tue, Nov 03, 2026 at 08:49:46PM -0600, Nathan Lynch via B4 Relay wrote:
> From: Nathan Lynch <nathan.lynch@amd.com>
>
> Discover the stopped function's version, doorbell stride, supported
> operation groups, and context and buffer limits. Apply the driver
> configuration to MMIO_CTL2 after function preparation has removed
> inherited state.
>
> Add capability fields and device bookkeeping. Report the SDXI version implemented by the function.


wrap commit message at 75 char

Frank

>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---
