Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794589666;
	b=DzaJp+VhE6v7p0Ms1spamthldw9e/3rbfAaJEFWhskiQVaCZqIw5Oy9tytSQK5EMaR9h
	 hzksqqR2DN8Ehm9ZQKmqzWLclPhHOGajgcGrpC3+RN0tSSjVFy+YnbuxOMGZ97fhUnSKu
	 cbjscwPQCnRjny+nNIW39MwYHg4b9Gf7sYPtszS4zHmtZuTaAavxUE+/ubSiWaZ86V6Bq
	 kHhr9fa0yonajemnistCBY6sRdKZnxS6Df4iibTh23QiKidxME7k7iH1weQALfUKKCbA9
	 ksNFnZ4Dg46MG9a8Hunc+24GUuG9r2aYEDjlrMT2FNWBvOheJn473YN8sfoKLU97NMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589666;
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
	bh=jnA4MIlxtqzgDDWSwyL5/KqzIvm6wNl9Ef1FslO5GiQ=;
	b=Z81zJHhmPobkHh0wKb0VOOzBgOn/W1Qznh1YHwfc6iNbB05l/cFQYXjRQTrWXd9anyPY
	 tHvGye5yfQuGxKowFpmIMNXwL0VGcXwZhMj6ETmnqv5dnCfy4mhBNL+Ue2Rc1bFF/hrWR
	 aR5Q7Yr7mkCc4fqEUz4Y9xScUWe6Y1k5gKZp/zgizkIM5mu24OHX+hLZx/vHcT1a/2nG8
	 4nYgUgCg6dhMwzw+I1crsGsp5s9gnmUreCXDP9iPLDbnANEHJaCcWwxYujI+9jUzt2j7j
	 IczpI59scsr4I2TWkR+MXFUoh0deMQyAsFreV7SHDLMw1iWle1/5lwQ73APqfT7vFFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=dffoD3lU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.26
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013026.outbound.protection.outlook.com [40.107.159.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4DC606A882;
	Fri, 13 Nov 2026 17:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B4DC606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=dffoD3lU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T6u1rH90+xw+6wLIvcxURxz4YjHlpCAWtmrnxcua+ndviF9fuBmIMmoB0iQ2C8phDOnR5rtuwLhn6cDIJeWc2+c3rxinROV9E7bYEzknH5eh60OaWyj5Ulk1ZbuP5qhRopx91+46silDuh63k+y/M2MyWc6I4eh/eEqauLKYdT7AZA4eImRKixBL/px4WAaUI9cuYltg2wKO7a7Z3fSCycRqpVkB/fVkXbQjhH/pUbrkv+Vpj2pXj/7n8AtHqp0ZC7KPPrifiXDSWzcqd9QZDv03clIBusd7OF+ob5+TAmDdFH4SBWSxvCQXzKORwbuqEtuskXnLtmzt752nuuzJIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnA4MIlxtqzgDDWSwyL5/KqzIvm6wNl9Ef1FslO5GiQ=;
 b=CAa+3+kE0Ug7VxFSy8GxqAquv6uNjRpp4k4W6Hj9N81M6pUxWAN3NfTGdOdPkBUds0HPx3fNO5sXGEholQ21/qocvUXGfnhlV5/IsCGUZHuc1drnOzbBFbKHSeOF1Jwbja8e9rJA2QITsjsiqzlWaKzt0SqW54KidgDWNPy6z/9i4K5WKNDiB3vDyahuK6CqFfZzqWS9Q3PasJz5bP74KsCGO8hkIEFlJGMXjYafbS7Bs0NhBewpzuxDncC0l44AuL1WpNNrLxgSF/ii5Wr+URqr/9/wztO52BjKb9g/H/94/gn62ozKcvlowwZawQWtHMF/hc8wJch9DSYbBZ0W2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnA4MIlxtqzgDDWSwyL5/KqzIvm6wNl9Ef1FslO5GiQ=;
 b=dffoD3lUtQOHf010ja76E2LvJWVyRcydU9+aQ5TztJHENyuRqJgydUfSNiEsAoY+kYSwKJmUFcmJY31uYunjYCC7fWksCI/WCgRuUjPO/vMHuDG9iC0eVii5Z8ZEBc+giQD7QmxUGSBTPILHNhwDgBjAUf9M+BovMyNBh86V2YKn5XoXWnwLVIzQrEbjpGkWBiW+9GS7BUn4Rf80qPL68b/vuNxVuBnHIPS45vxxCPRZau7l1rZLxpymeXLRHeCiiTgV+dz9TbNr8Mh9952uCEJ+wkJkR8APRPv0ivkwB4U1Divd3kPOWchThFRLknfbpPTfhYcYwYtyLjgtX+mmNA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PA4PR04MB7599.eurprd04.prod.outlook.com (2603:10a6:102:ea::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 17:07:41 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 17:07:41 +0000
Date: Fri, 13 Nov 2026 12:07:33 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Nathan Lynch <nathan.lynch@amd.com>
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
Subject: Re: [PATCH v4 17/25] dmaengine: sdxi: Add unit tests for completion
 pool ownership
Message-ID: <avdD1faSh_kDUWpA@lizhi-Precision-Tower-5810>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-17-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-sdxi-base-v4-17-3668ccc7aab8@amd.com>
X-ClientProxiedBy: DS1PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:8:456::6) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PA4PR04MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: 68594ecc-d6b2-4385-9492-08df41a8a05c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|23010399003|7416014|366016|18002099003|22082099003|6133799003|261009223027099003|56012099006|11063799006|5023799004|4143699003|261102123227099003|261102130727099003|261026140227099003|261026121527099003|261022105027099003|261022075727099003|261028144727099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	jyAwOD0hotEZT5PYboMGmDzqeb2lC8bLwJyhxgqANnCEKh4bpuEgP4ecpgnGSSPwwic4QcAIkh2BHvB9jCVTiww4wcaNwwjnl1j7jXpLeUsFH6QdRrGlEAJ57AiqgGUR32tY0dgUTtMhKdmVuScfsZsCkEOaLQpodjIqbr4eZ3mI7DObXnOwq7/EycjgdK/Cf22oPC3b5P6cvDTxBtvABr3m90OMJ8iDkHlQlpYJ1yP7G9zLQgiBukR3t6RhmxX81P+8qImwPXdj1fOaOYCZqhveTkcEkHfxU3tc+4LUimzv6+FtfdxY9zbYeLHbMvlvhbgRFHlD5Od7nnmSaqO4SuKFdqscA9PMj2HClG4+/MJbztvHyB4rsFepeZ5H7rRMdUONZc7+7agbbVarWeBMElCjhcGVOCqYrKED6ZHD2ivHMQz6Gp2k1P54Uzr6/otc455nWKOanj2/IpBg2IQoeeaUgV2+p/Rl+DQwis7dXJ4Fd6dFDQKeOtTnxIE5lxc3fhw4Md9x2Tjp8Ddia9e8ZhkVco6ehZuCs47cNV2eabfPnkjujAF7yTfF5p1CRejBTruZcdTVQMgxkWq5UEt9+H7hKBIA0Vymj53P7J77fURQevST/YWcgv1nQauXfi5S66tjFCPhrdMMkrGLjlCYbhMjcXkcHXIkyxnkE1aTqBc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(23010399003)(7416014)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(56012099006)(11063799006)(5023799004)(4143699003)(261102123227099003)(261102130727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261028144727099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4efONOVn5a/F4XvZt6q0ME7TgsPLwFEaM82IFLWVQRIX20LGncZmVDVm3Hpu?=
 =?us-ascii?Q?jx1nLXsFIcitDzFjSyj1WT5b04TYBeUtBOHQTTCayeWMgx7jvcidh4Tsj6Q+?=
 =?us-ascii?Q?UO6ycFUgiNU8nFwPZ1C/s4Kk5vvEIrbJ2Y9rInwmglbn7TM3raLM8ndQ0m3Q?=
 =?us-ascii?Q?4GMiQbjZnXrvbOwYSI2NXl9hyB6E0YHylyYjX+MZNSjHBDMhp+r7KhL2ghil?=
 =?us-ascii?Q?m0Vd7vnU92vRFbmiDf44sA5gSlMh1RHrUL5KuiKe2hGmF0qd8fF7ZYx+nG2L?=
 =?us-ascii?Q?SYSp9LZRuMFrKCE3MUvSm2oxjWGV2TnNH3FH9zlHIG6THb9zsyQ80plxEibK?=
 =?us-ascii?Q?9f8Wx/qQ/jWjUhRKHf8I528r9FMphPproBzUC0n7rBIH13lZh3a8Y2S0J66T?=
 =?us-ascii?Q?XxTy46Itxr7Nce7hVph5ctwSYhcCe/afEEwi4tZ0VoqVUNFNT6vX2+Wpt7dH?=
 =?us-ascii?Q?dpuxpB5fpDvGPUS7+Ss4hDN+9MNrRTJC3f/kp48FAtJ7APqPCjOVwrNVybQa?=
 =?us-ascii?Q?WAtNeUCnjGGkxBXRij6SosiLGTKs6cCxt/hhZndSEC3tAE2n6hN89vqK0+5Y?=
 =?us-ascii?Q?6ATAnDcQmV/3xmNy4xcZZyQwyVrCxYWoOSWJ9sctuSnX+UF1TJAaKLjXbcXu?=
 =?us-ascii?Q?gsqMM0FxiPk6Z5SSuf/wgwTdSCAcygWf+otiXRhb3m5aorI3kEX8d7aBLdxx?=
 =?us-ascii?Q?TxQVOaQN/vPFzuO1yeKv7QboYFK9BHNAzVN5bu2Txeu/EP/w9Fo6yvxU9uwf?=
 =?us-ascii?Q?9P/XgX9nF+nKay/fXR8cn2JDx3RuUe/SNyn0IZ2ZjP4uNEjhAvgjNuYXFQYw?=
 =?us-ascii?Q?kRy0GWNy6yR1lTc9VlvYQCq7XdROxkGqFDKPj9kyMIa5HAOMZF5oPGON5d1Q?=
 =?us-ascii?Q?HCriQYugztEPAhlNvEPZfmsFJBpDjJ8cLA/Dy5rC5Tqu1Ef8NHSBZCqSNayC?=
 =?us-ascii?Q?mNMFjaLCc01EXXCbb/ZfzgRys79HXRWDe4uoxR2I6Bv5e2OQUNwdgr6QjR03?=
 =?us-ascii?Q?A4V1OWqVOUcEHIb4XLTDLHtrDUjn2IJnHFG0Yz0KAI0TSeKDz422hkoPKpCL?=
 =?us-ascii?Q?76uszpjgn7nDfZJ6PqFO9gLI4TbKkg6eRoeMbszwXzCakUnF8NPFTFbhByXN?=
 =?us-ascii?Q?Nfbj/TsKuNLWai3/gO7WfM48rQhCybrG4WauPD2csSf7ldU5rE6BueC5/WTV?=
 =?us-ascii?Q?WwYhc5tjJg9hNvzAjApAa8kY3Ay1Kh45VG9dXzQGXC6TPhYYCEPFVUEDpAEI?=
 =?us-ascii?Q?jZdfVtlkVB5YTCBgrLVuiV+MDLY3SwBnk02hLxTS1FOp7eZqdrPMAlBS+C6X?=
 =?us-ascii?Q?kaS9U643pkJon4tJlbutDvUSrlw3OMcT/SfGxueAKSxno//8nMtR+2dXtvn/?=
 =?us-ascii?Q?j3YajKGc+wR/C7q1ybhDuvYv07eGImsazuRlmbfQpZm2OTiamgOllZ57adX1?=
 =?us-ascii?Q?3EymMVoSHU/eZp1uz0rSWgImTKLXoxPSE879eGcYj5hrGvkooqd1Rfavwqe8?=
 =?us-ascii?Q?clKH4UVi8AkMu6llGbddCwQmY0yVjmlu17o9Ee8+INeLu9zP6MNIzDVs7CnQ?=
 =?us-ascii?Q?UWbYWfXZBrEwA2P3jrcQnQnUMNq2wDvgXiyPunyt6RYniKyrMmhftCKTV8XY?=
 =?us-ascii?Q?38nifnX852qz+kbiqIal7NyCpbJzDdkug34PzjU652l3YqFA69rHu+pThyOk?=
 =?us-ascii?Q?G8Vih25oOLe/5IApixhJnmTImGN00oLUsUm58DQLngNgojPHo95BmdG/sUhF?=
 =?us-ascii?Q?cMy3oKCxJsdvNM1TgTTJS2OgfyJquldKdgCqflPuiUlxvqzyf5SC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68594ecc-d6b2-4385-9492-08df41a8a05c
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:07:41.1505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDhOd5hq7ausE9bULNXdxfZ53h4roMgHdLCYoFkCm8zh8kXbmgK3YAtHj3tTKlymEDKalh5XMMaoLy3gdQi4d6fK2Kt7bGxxnRPLurMTB3bEO8nvpkqGWPo3TTJ/6F8X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7599

On Tue, Nov 03, 2026 at 08:49:58PM -0600, Nathan Lynch wrote:
> Add hardware-independent KUnit coverage for completion-pool exhaustion
> across a bitmap word boundary, arbitrary release and reuse, reinitialization
> of reused status blocks. Verify that a claimed block remains unavailable
> until explicitly released, including after a simulated late device completion.
> Also cover release of an unpublished claim.
>
> Provide test allocation helpers and KUnit-only exports so the tests exercise
> the production claim and release paths without a coherent-DMA device.
>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/sdxi/Makefile           |   1 +
>  drivers/dma/sdxi/completion.c       |  37 ++++++++++
>  drivers/dma/sdxi/completion.h       |   4 ++
>  drivers/dma/sdxi/completion_kunit.c | 131 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 173 insertions(+)
>
> diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
> index eacad504a816..d12eebe03870 100644
> --- a/drivers/dma/sdxi/Makefile
> +++ b/drivers/dma/sdxi/Makefile
> @@ -10,4 +10,5 @@ obj-$(CONFIG_SDXI_PCI) += sdxi-pci.o
>  sdxi-pci-y := pci.o
>
>  obj-$(CONFIG_SDXI_KUNIT_TEST) += \
> +	completion_kunit.o    \
>  	ring_kunit.o
> diff --git a/drivers/dma/sdxi/completion.c b/drivers/dma/sdxi/completion.c
> index c07a0fc101c8..dacd1cac6303 100644
> --- a/drivers/dma/sdxi/completion.c
> +++ b/drivers/dma/sdxi/completion.c
> @@ -4,6 +4,7 @@
>   *
>   * Copyright Advanced Micro Devices, Inc.
>   */
> +#include <kunit/visibility.h>
>  #include <linux/bitfield.h>
>  #include <linux/bitmap.h>
>  #include <linux/dma-mapping.h>
> @@ -90,6 +91,7 @@ bool sdxi_cst_pool_get(struct sdxi_cst_pool *pool, struct sdxi_completion *comp)
>  	sdxi_cst_blk_init(comp->cst_blk);
>  	return true;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(sdxi_cst_pool_get);
>
>  int sdxi_cst_pool_get_wait(struct sdxi_cst_pool *pool,
>  			 struct sdxi_completion *comp)
> @@ -116,7 +118,42 @@ void sdxi_cst_pool_put(struct sdxi_cst_pool *pool, struct sdxi_cst_blk *cst)
>  	spin_unlock_irqrestore(&pool->lock, flags);
>  	wake_up_all(&pool->wait);
>  }
> +EXPORT_SYMBOL_IF_KUNIT(sdxi_cst_pool_put);
>
> +#if IS_ENABLED(CONFIG_SDXI_KUNIT_TEST)
> +/* Exercise allocation without requiring a device capable of coherent DMA. */
> +struct sdxi_cst_pool *sdxi_cst_pool_test_create(unsigned int count)
> +{
> +	struct sdxi_cst_pool *pool;
> +
> +	pool = kzalloc_obj(*pool, GFP_KERNEL);
> +	if (!pool)
> +		return NULL;
> +	pool->allocated = bitmap_zalloc(count, GFP_KERNEL);
> +	if (!pool->allocated) {
> +		kfree(pool);
> +		return NULL;
> +	}
> +	pool->blocks = kcalloc(count, sizeof(*pool->blocks), GFP_KERNEL);
> +	if (!pool->blocks) {
> +		bitmap_free(pool->allocated);
> +		kfree(pool);
> +		return NULL;
> +	}
> +	pool->dma = 0x1000;
> +	sdxi_cst_pool_init(pool, count);
> +	return pool;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(sdxi_cst_pool_test_create);
> +
> +void sdxi_cst_pool_test_destroy(struct sdxi_cst_pool *pool)
> +{
> +	kfree(pool->blocks);
> +	bitmap_free(pool->allocated);
> +	kfree(pool);
> +}
> +EXPORT_SYMBOL_IF_KUNIT(sdxi_cst_pool_test_destroy);
> +#endif
>
>  enum sdxi_completion_state sdxi_cst_blk_check(const struct sdxi_cst_blk *cst)
>  {
> diff --git a/drivers/dma/sdxi/completion.h b/drivers/dma/sdxi/completion.h
> index f91f44b9b516..18c89701d1d6 100644
> --- a/drivers/dma/sdxi/completion.h
> +++ b/drivers/dma/sdxi/completion.h
> @@ -34,6 +34,10 @@ int sdxi_cst_pool_get_wait(struct sdxi_cst_pool *pool,
>  /* Release only after consumption, unpublished rollback, or hardware quiescence. */
>  void sdxi_cst_pool_put(struct sdxi_cst_pool *pool, struct sdxi_cst_blk *cst);
>
> +#if IS_ENABLED(CONFIG_SDXI_KUNIT_TEST)
> +struct sdxi_cst_pool *sdxi_cst_pool_test_create(unsigned int count);
> +void sdxi_cst_pool_test_destroy(struct sdxi_cst_pool *pool);
> +#endif
>
>  static inline void sdxi_cst_blk_init(struct sdxi_cst_blk *cst)
>  {
> diff --git a/drivers/dma/sdxi/completion_kunit.c b/drivers/dma/sdxi/completion_kunit.c
> new file mode 100644
> index 000000000000..326e3d84da0d
> --- /dev/null
> +++ b/drivers/dma/sdxi/completion_kunit.c
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright Advanced Micro Devices, Inc. */
> +#include <kunit/test.h>
> +#include <linux/module.h>
> +
> +#include "completion.h"
> +
> +MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
> +
> +static void destroy_pool(void *pool)
> +{
> +	sdxi_cst_pool_test_destroy(pool);
> +}
> +
> +static struct sdxi_cst_pool *alloc_pool(struct kunit *test, unsigned int count)
> +{
> +	struct sdxi_cst_pool *pool = sdxi_cst_pool_test_create(count);
> +
> +	if (!pool || kunit_add_action_or_reset(test, destroy_pool, pool))
> +		return NULL;
> +	return pool;
> +}
> +
> +static void exhaustion(struct kunit *test)
> +{
> +	/* Cross a bitmap word boundary without filling the final word. */
> +	const unsigned int count = BITS_PER_LONG + 3;
> +	struct sdxi_completion *held, extra = {};
> +	struct sdxi_cst_pool *pool;
> +
> +	pool = alloc_pool(test, count);
> +	KUNIT_ASSERT_NOT_NULL(test, pool);
> +	held = kunit_kcalloc(test, count, sizeof(*held), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, held);
> +	for (unsigned int i = 0; i < count; i++) {
> +		KUNIT_ASSERT_TRUE(test, sdxi_cst_pool_get(pool, &held[i]));
> +		KUNIT_EXPECT_EQ(test, held[i].cst_blk_dma % 32, 0);
> +		KUNIT_EXPECT_EQ(test, le64_to_cpu(held[i].cst_blk->signal),
> +				(u64)SDXI_CST_BLK_SIGNAL_INIT);
> +		for (unsigned int j = 0; j < i; j++) {
> +			KUNIT_EXPECT_PTR_NE(test, held[i].cst_blk, held[j].cst_blk);
> +			KUNIT_EXPECT_NE(test, held[i].cst_blk_dma, held[j].cst_blk_dma);
> +		}
> +	}
> +	KUNIT_EXPECT_FALSE(test, sdxi_cst_pool_get(pool, &extra));
> +	KUNIT_EXPECT_PTR_EQ(test, extra.cst_blk, NULL);
> +	for (unsigned int i = 0; i < count; i++)
> +		sdxi_cst_pool_put(pool, held[i].cst_blk);
> +}
> +
> +static void arbitrary_release(struct kunit *test)
> +{
> +	struct sdxi_completion held[5], comp;
> +	struct sdxi_cst_pool *pool;
> +	const unsigned int order[] = { 3, 1, 4, 0, 2 };
> +
> +	pool = alloc_pool(test, ARRAY_SIZE(held));
> +	KUNIT_ASSERT_NOT_NULL(test, pool);
> +	for (unsigned int i = 0; i < ARRAY_SIZE(held); i++)
> +		KUNIT_ASSERT_TRUE(test, sdxi_cst_pool_get(pool, &held[i]));
> +
> +	/* A released block is reusable while all other owners retain theirs. */
> +	for (unsigned int i = 0; i < ARRAY_SIZE(order); i++) {
> +		unsigned int index = order[i];
> +
> +		sdxi_cst_pool_put(pool, held[index].cst_blk);
> +		KUNIT_ASSERT_TRUE(test, sdxi_cst_pool_get(pool, &comp));
> +		KUNIT_EXPECT_PTR_EQ(test, comp.cst_blk, held[index].cst_blk);
> +		KUNIT_EXPECT_EQ(test, comp.cst_blk_dma, held[index].cst_blk_dma);
> +		KUNIT_EXPECT_FALSE(test, sdxi_cst_pool_get(pool, &comp));
> +	}
> +	for (unsigned int i = 0; i < ARRAY_SIZE(held); i++)
> +		sdxi_cst_pool_put(pool, held[i].cst_blk);
> +}
> +
> +static void reuse_initializes_status(struct kunit *test)
> +{
> +	const struct sdxi_cst_blk initial = {
> +		.signal = cpu_to_le64(SDXI_CST_BLK_SIGNAL_INIT),
> +	};
> +	struct sdxi_completion first, second;
> +	struct sdxi_cst_pool *pool;
> +
> +	pool = alloc_pool(test, 1);
> +	KUNIT_ASSERT_NOT_NULL(test, pool);
> +	KUNIT_ASSERT_TRUE(test, sdxi_cst_pool_get(pool, &first));
> +	memset(first.cst_blk, 0xff, sizeof(*first.cst_blk));
> +	first.cst_blk->signal = cpu_to_le64(SDXI_CST_BLK_SIGNAL_TERMINAL);
> +	sdxi_cst_pool_put(pool, first.cst_blk);
> +	KUNIT_ASSERT_TRUE(test, sdxi_cst_pool_get(pool, &second));
> +	KUNIT_EXPECT_PTR_EQ(test, first.cst_blk, second.cst_blk);
> +	KUNIT_EXPECT_MEMEQ(test, second.cst_blk, &initial, sizeof(initial));
> +	sdxi_cst_pool_put(pool, second.cst_blk);
> +}
> +
> +static void retained_completion(struct kunit *test)
> +{
> +	struct sdxi_completion timed_out, other;
> +	struct sdxi_cst_pool *pool;
> +
> +	pool = alloc_pool(test, 1);
> +	KUNIT_ASSERT_NOT_NULL(test, pool);
> +	KUNIT_ASSERT_TRUE(test, sdxi_cst_pool_get(pool, &timed_out));
> +	KUNIT_EXPECT_FALSE(test, sdxi_cst_pool_get(pool, &other));
> +	/* Even a late completion remains allocated until its owner releases it. */
> +	timed_out.cst_blk->signal = cpu_to_le64(SDXI_CST_BLK_SIGNAL_TERMINAL);
> +	KUNIT_EXPECT_FALSE(test, sdxi_cst_pool_get(pool, &other));
> +	sdxi_cst_pool_put(pool, timed_out.cst_blk);
> +	KUNIT_ASSERT_TRUE(test, sdxi_cst_pool_get(pool, &other));
> +	/* A never-published claim can be returned without a terminal signal. */
> +	sdxi_cst_pool_put(pool, other.cst_blk);
> +	KUNIT_ASSERT_TRUE(test, sdxi_cst_pool_get(pool, &other));
> +	sdxi_cst_pool_put(pool, other.cst_blk);
> +}
> +
> +static struct kunit_case completion_testcases[] = {
> +	KUNIT_CASE(exhaustion),
> +	KUNIT_CASE(arbitrary_release),
> +	KUNIT_CASE(reuse_initializes_status),
> +	KUNIT_CASE(retained_completion),
> +	{}
> +};
> +
> +static struct kunit_suite completion_tests = {
> +	.name = "SDXI completion pool",
> +	.test_cases = completion_testcases,
> +};
> +kunit_test_suite(completion_tests);
> +
> +MODULE_DESCRIPTION("SDXI completion pool tests");
> +MODULE_LICENSE("GPL");
>
> --
> 2.56.0
>
