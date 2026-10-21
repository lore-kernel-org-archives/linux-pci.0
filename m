Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792597425;
	b=pG/wDvXnvDvNktynx0qJWFNjbCrKr6nluHnFUU/zdao7Ib2CXrlDx+wGON2/euJcr4gT
	 4GcO0Obh7riVIjDQUlbI9fyaAIGieocqrfkPGJJO7MBY8HGurCn7DcEsOnnLMqv0N+Dm2
	 WAxkOXJdjYOicFw70LPfYExM6aUdsfdSuTeUaphmyFu2tiz6tpDEv25Z1oQ6tOkkyPfco
	 uWiKH0QZM1gZ+Eq+oUZzMBShpI55r+OQDqE3hWScS6xuuxfEGdlBmTpx/wmuI7uAOiUnQ
	 UrSFiS8WkV9bgSqCQvugozaiSiwbmSq7MaPzxTJKxYp9JL4w0JtAUF1ghcABP4bMq+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597425;
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
	bh=kHii8f14H9f2GlAXEq94y1Sg4Xrrc8XE4uliTeNT+4c=;
	b=deFIqYQkpiK6nvDe7FTeqjJW2tB2pIcz0SIoQKqBO4tbBmOwnaX2a298YHBst+ckx3nU
	 oJwudto/bivEFzL5lY4mzgJpoN4HihMdxbA81BU3O/MT5xI4qKnb9uCAMiiDYLFMxWB++
	 ncfqGifXf/3VlWIz+pTt/6w01NEU06MByFM6sKxfQDsqRKaGkk5BhyWtg20FsgzR0kFG8
	 72SyXLBixGt/gT1eqWkcDBZa5srucska1TNmtmcqehU/1A2yb6FrAFTEGSlviUMnS6uRD
	 TtQMgVapG8yjKa93woLaz97gA4NBQNucKHfF1OOEXO20W6QLILZ4Gh5rFMjG4h79uaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=mIaGdtf4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.20
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013020.outbound.protection.outlook.com [52.101.72.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D2460A5BD3;
	Wed, 21 Oct 2026 15:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8D2460A5BD3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=mIaGdtf4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXiz000sihD+lUTmOxTUQhkmX0fFdtovbhX7oTTWIBsjXGmx/DpObVKLHFDksyoUnr6oWJYJZYKO2ettjvYHhqVakmK1EjPj8KGfW76wHYv/lz9GtoiD1ZF7w6GKk8xqO2xYCxK/VV4/Ix/FQ/UGXl8bUqXCW0mXyVAMye9LahFVrQjiYj2JZxvafUQ98lAFoqC0HGrixVM0R6h5B5iBTnAcjpQmnVoBpqDlnSSDkiXNCOrAusPu91oFlJ7oTryRfvFs8rLLLibFxFgHVZ1NsqMjC/F5tSafN0ggAFbhreFWLmW7HnIlr3XHSeKvkplfMzEcSOh/IDNfVwSqck/4aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHii8f14H9f2GlAXEq94y1Sg4Xrrc8XE4uliTeNT+4c=;
 b=VOZe8l5td3AuVLQOy26U3C9wCzZgEYpvz12no38eX/rSHeBMVOr/N4T+ZrokGhE/QoFuwPL+mGqTThLAMkji2b6kBYzID0/xgGlzC5q5OdRi+x9QhjAqULFc4kGUmt5q10nswzC6R7k3i5Rw9FIdRzOpL2GvSYEunXAbqFruahYgBTIy303GmhVa2hyj99rT2bfcMWIu3N0jtXWFqmCDeD6Vj8C8VQZT0SBfGclPrRc9N4yzNBzw5jMRMoxru3YYLgWn0reYE5gyQ26mtGDw3sLcaMV1lG1GQMNaeAnJe33rpFZmeyYh9nFxjZFv2dz8AbGnmfXYjYc/5oO0dbS9/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHii8f14H9f2GlAXEq94y1Sg4Xrrc8XE4uliTeNT+4c=;
 b=mIaGdtf4HTfJLOiKO2dhomfNTBtLRPa6bCBWNsxvOddZ/LI0rF89/qg3Jdksh9t5jRgLnrYafurfYRXRAxixyItc19/WLpZSaNdFJ9rmDqbekP8iUzj1ny2lYE1yPpMfXxHKJP/6phabvjIaFAIP/ZLg+AGz/lePqiYZ27FLWRLd6snZkyNaL7nwDDoDKpd3+d97hRN2noizIra8kTsRarkBZ0pDnmG9UXbHndgopIL5enDV6W+IY0DUTEm1Bc4q/ESSnjDtVTCI1yJ9sdi5SmAgaboB/lI57HcZVFoHgIofDMPc1p7K5G7E4oro1wR+R5e9Xia/9RXLH3JAOwu0zw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GV1PR04MB10534.eurprd04.prod.outlook.com (2603:10a6:150:205::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 15:43:32 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 15:43:32 +0000
Date: Wed, 21 Oct 2026 10:43:22 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org, robh@kernel.org,
	thierry.reding@kernel.org, jonathanh@nvidia.com, kishon@kernel.org,
	Frank.Li@kernel.org, vidyas@nvidia.com, cassel@kernel.org,
	den@valinux.co.jp, marco.crivellari@suse.com,
	andriy.shevchenko@linux.intel.com, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/10] PCI: tegra194: Balance core monitor clock on
 failures
Message-ID: <atjdmjX4-Hv2hGVq@SMW015318>
References: <20261021061349.1265704-1-mmaddireddy@nvidia.com>
 <20261021061349.1265704-10-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021061349.1265704-10-mmaddireddy@nvidia.com>
X-ClientProxiedBy: PH7PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:510:339::16) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GV1PR04MB10534:EE_
X-MS-Office365-Filtering-Correlation-Id: f3a11ae6-e843-4d64-bb56-08df2f8a0fc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|376014|23010399003|22082099003|18002099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	VoiO/Ilz1wufHLV0AjHVdUokgjod3pyNV1zxFOXKXI6eLfsa6BpM8gTHwUqD+JozTpERnX3usG6ejddTW3PbWWmyDUVtwcotthNJ3bgP8krc6Ke/RMzWxiHlFT27MBOjZ+lgfWQLU9G2cuLcKT07C8UVGvMoKHLARGaCSLEQNHDkQFro2klT20vBP1uoGuyudbpwdvXM1GrQuM7+V5tjh5MZ+Yv3VvgMP+tJQM3rOYy3rZYdaNmfZGt02yzFxRLYuGioRb6Pufs6XyD29crl/57js47tXRU5YXB7LOlutUVuGwchGOlcjNEycXDGkMye5cKu8DWEvcVATM84Jb5J8nTZfcKouWv3jCuaK+Twf2mq3uLeVTb30f93aSQkXx3oRaf8cUowlndLTgDosBcKXTzK9CUHSsDDLhAaeECoyz2oT2yMg1YipoMsPwNMGW6TIDDrKZvi5jwI9HemWlbF2k2l72d1j9KckiFlHR72C+yfRlOqNZGaHKcxsjBdhpK54E01MDx3M/5eMN7eMwAnlhojqHgIZHoxf+Mnlh+dglA4rr0s9cTAKdAe/R2DZNYQtW0m8XyzIVgrpGjCRr75wNyLknMmy1IfXvp4jU4kZ0uO7NZb6T0Pi0MIrAWOmCxw+nwh9+HMluZDwCNTX5B0yn+mrWMP8uZ0gTublp/tEJM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AXkmWT/CsJq3m8aqXDuBySYId//6nhLZsVAXEhOCGPcQC3rWqfCwcI3n6uRY?=
 =?us-ascii?Q?uVt1rj0YTAW82N69ZvTKniK98m0LcHY6UZtoHfIy7MTmG3tZePnEBr+TD3Dt?=
 =?us-ascii?Q?VhRfYSDuSJcoJJ+REbltPGrec+/mSX2YrQyAvOn8hC2HuNfVQEySbfDb+Uwf?=
 =?us-ascii?Q?+1XLFRacQ9E46dp7mbMJhabhb18+Av7gq3GwLr1c3NBadlubc2NP0o5tTaOK?=
 =?us-ascii?Q?WgxjWzOt3AjbnLQHOBFe8Bya7rqfUjifTqhrJZPM8Gae3zsOoVhCgx2hAokv?=
 =?us-ascii?Q?Gu/hIIk1Y/EiAHwaEI9W4Yjr7HBjF3NhpijuptLi7SSeADS+EbgYsLkVW52H?=
 =?us-ascii?Q?EeC6IPuyQlkPASXdelM/y3FTQRGMjN/yFtuJ4db43HoALAemxkacd3be3NsQ?=
 =?us-ascii?Q?A8PpRRtmw4R7diQdwQpwBT40P2uHFWSYJFK+H4Kmwu3ICGizN4sw/RO6MJd8?=
 =?us-ascii?Q?ASrPhA8ISbARQe6dpm+jEGj2fn4fIV08HGSPeBfsEIXNoWw3w7jVyUnYt+cA?=
 =?us-ascii?Q?kCOkoaYojTUJw2LitnoRij39TD9BAsaTrNA5lVFesmE5mBtxHpIKS4GrhfXt?=
 =?us-ascii?Q?88B45NaU/WM1yiXW9IYB0OaQfgLtd+1AK36d+s6Hp0GHySP0IBm6z5y18euu?=
 =?us-ascii?Q?OAKz3vG3ND6n6JOXL2DFg46DLQDf3ayZlyqJ3tV7kRu53xXuw0oans74IdBa?=
 =?us-ascii?Q?1zlX8cFZFPd2YrJ5VLdW6Th9SsWeeqgT7ix/6K7mq2cvmRuqbpkbIQ0t0s1j?=
 =?us-ascii?Q?Ce6q0aUPJxFapZilKUzn7y6+Ru2sbl9x9zC0+yWuBzl+9CMl0Afhs4muTJel?=
 =?us-ascii?Q?nwYZsw2QM6A7z6/OTUN9b4X8E8kJGwd4M8gtnlQsmqcjIrxIZGXKD1GZkLn+?=
 =?us-ascii?Q?Tj4qI7ebAE6udISAxevyJmVI2wo3KrqSgOsm6PJt6dUGSXVBp5oDFA87xKGu?=
 =?us-ascii?Q?sHQhgnC4sKIDovVCZmsH4mVZcYyjgXhjVlbs/5ealHBIKjLvTE2xS5X+sNON?=
 =?us-ascii?Q?ZRq6rKgULOjM9VSaUBvHsUPRYeXa5B+KECw5LCiZ/wPxrkaVOScN7rcSWwf7?=
 =?us-ascii?Q?CBYNWA3V3uSC1tO6vLCBpVtDUF8uHhqvDvquR2V+8jD+l3MNat3uvZMnbe2+?=
 =?us-ascii?Q?9/bSORBnFmvWnToNLNRVVQwyKDfRHj/X3LhhK5/A/J0aiziMwSGX6oTjrZor?=
 =?us-ascii?Q?AMkwMeaQHMGV6FMh7mWRvdlKtyWoiF/Akelj4eyxN3AxWSLuqu1Dz8Q0jbwN?=
 =?us-ascii?Q?NpvIWbY2s5JoitOSooE/t1iPZR32/mIbFDlM6LCGealvHTBND1+adKr9jeLc?=
 =?us-ascii?Q?w9NyytZ1IWr9XcsY51IF39mixGxTth8cTKC4kMGErNffou6SPAF+ZHsuUoN8?=
 =?us-ascii?Q?D/TehIOLoLFytI7qeizq/CVDIzi5J2pcOtkl6BM4J5AxVR6B2B5AbYjyTXa+?=
 =?us-ascii?Q?fB+54ubrXxS7hHJPziB0BLFqwqwfWFCs4CFE0iu38WZvFJ84hmYT2Lg0FfxB?=
 =?us-ascii?Q?w9ZTxBGQ45qNU2QV5hGXt5sqctqyC4reLivUr+2Wh0bkLeBXp0QP8e05VR1O?=
 =?us-ascii?Q?MXlpE97wHq6MQV0Uq5U2jEJuxJUBErNP0qmbcXCU7O2w2ijOi23L/5TvBIpJ?=
 =?us-ascii?Q?Yo3PLIojgpTUdUWNw4OpGXJz7YSbOlNntQQzy0MdvPCADXhbfbMmfL4KBA+a?=
 =?us-ascii?Q?Bq3bqToUsdhbmJQnP1Mb2kMqpvm12wdf2jY0VYvMTfAFCzkaaf5wqktuNsY7?=
 =?us-ascii?Q?75x7Gy7g4iw9gFW24JF1vQqMonJea74rtqoDL07r0/NRSzynuUBg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a11ae6-e843-4d64-bb56-08df2f8a0fc5
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 15:43:32.7267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e36Zm09nj3UUUdr9zakilwV4eyYqNw0vI4Twe9tkrBgO/QSA5PgpUwCXEkiB908qNuy0yPmKMPwKO1q9OM0PzbkhUeMwIlX5Dxn0DjgtNEVFgDBxALbZ8I+szo7CF1kd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10534

On Wed, Oct 21, 2026 at 11:43:48AM +0530, Manikanta Maddireddy wrote:
> tegra_pcie_dw_host_init() enables core_clk_m, but failure paths that leave
> after the host init callback can unconfigure the controller without
> disabling that clock. The enable error is also only logged, so later
> cleanup can try to disable a clock that was never enabled.
>
> Track the monitor clock state, return enable failures, and use a common
> helper on retry, remove, suspend, shutdown and host-init failure paths so
> the clock is disabled exactly when it was enabled.

Feel like checking core_clk_m_enabled for clock is not good desgin. Do you
disable clock when linkdown?

Frank
