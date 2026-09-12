Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013016.outbound.protection.outlook.com [52.101.72.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7651142885F
	for <linux-pci@vger.kernel.org>; Sat, 12 Sep 2026 16:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789230453; cv=fail; b=nG0EbPFH9DjIwraZwiCNPM8c2oV8GjPmx88WFFukZKjLFFIt7dgtXnOwu1f5BfGCd5RwskXY5xvvPWoQyDVZaUeduD2E4/HhyKjWv0mOTIR+r+ubjpmN5s7PAfH2ujyJ79o5f3A7TG/NPmAiIGES6cMKJSUMm3qGyVyONKlAXqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789230453; c=relaxed/simple;
	bh=xlDukrc96LXvM3QECam5dFJD/FS7UyUpZ7vuOb4MdSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ux0RJhPVWa4KI8cjLA2oTREvXXBzypEzKZ8soVl2bCRJwVN8jILqlSi+vML3XB1axCNADewMgfVK6V+O3Q0HhAfu4gjqLfIhJBAQsY1r2giaxWumfgf46teay4OeNQW4mvmhw85+PuJ7tiblvrw5NHmiBYM+FYR7547fYamZU0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jsup5tgX; arc=fail smtp.client-ip=52.101.72.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jsup5tgX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WjGAFG3Gc5+GlbstW9DILiw2uuBaetkcSZKLE2NcIpiRTU0DlhBKVX9qQp0X1yYuGqrUK0aKDi3NMqj9mLQAe39sNNC+p0luCiq1L8vs7CgZJLST2IxFYShEiaNGPYbOOXfr07NzaeBbUAgei2qZqfOxSlBxEafz5vqIuUdW0vt9rqGCykj7JZIzH4O8i8xzQQm50i1t1w/9+vb9sIyXjEpffKef9KTxlByYLcwuBJ2Oz0B2qC8npQf5piJg/tmvnSRvuFrRsjROu8hPB9XjOba2BlRktCMqcaK9qnZEuSXnqkMfcc45mIHOy8VYxDMSkdb81QlrAcZGWVSv/ptWsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jE2/kHRlQ/ds426zRh1GIgLf/Ne32qmPHYI7oACx9Kk=;
 b=Wu6iYPEXub2SNPZ8ZMNHoQFjyak9RuH8r+O5avlZGrpuQViEuQVh7QSnZYyZSS42rYMSg/qKnmMczfKS/wm+fokhY9NWWKcYddn63ET7dESxntTBrYnxjU1AMeKvNL4lgqUdjbBkFZAPVR9iFeiqCu7Br8yf2nN8Da6T9XX2dgRjCCA5s0u8fTSODXTaiArpKW30qPUzIYLGZOzpLnCib9UwMOOF822dy1u3z1IqOi/L8IwiuBnZ/K2Uneg/5yK0AGGcBHHW960hquXjKI9eGONgDzBxEIE9RxCxFgCz4h/nz9EhOl1bK9xTbbhY+SbK3CeTi17p0cdA/41otCFzZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jE2/kHRlQ/ds426zRh1GIgLf/Ne32qmPHYI7oACx9Kk=;
 b=jsup5tgXLK2X/6LohwE8/07Tf37WXsDx2gBR4kgbUYUyy3Ndx7wIy9Sr9mxUeoT445iW5VYKuCMi5/4Xh3VHXRDnJoQbgqAoBUpJKs6Ils8Zy0bRhDe5309aMwLMrLgEJY5hmuxThVYjs4hdDFnmh3tahJzim66lkQuRPtTxpRBdFqrD5MYySSAzF1ZA5o0+5GR2JOjmSbt7J0kLppBWv2STcAvAC0Fjdeusce1stFm7StfIBfKavp0J07oPN6IEKxST4iG9zwT64x5alyHZBbQgKBhEOcM7u+YsYU93pPZlkZWntNKz8e9XsTm33mZozSSulPkKNSqs+mE22ryVAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by DBBPR04MB7657.eurprd04.prod.outlook.com (2603:10a6:10:1f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Sat, 12 Sep
 2026 16:27:26 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0406.007; Sat, 12 Sep 2026
 16:27:26 +0000
Date: Sat, 12 Sep 2026 19:27:23 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, helgaas@kernel.org
Subject: Re: [PATCH 1/3] PCI: cadence: Remove device links to PHY
Message-ID: <20260912162723.xyiey4v2shv2k2w4@skbuf>
References: <20260912161440.1032188-1-vladimir.oltean@nxp.com>
 <20260912161440.1032188-2-vladimir.oltean@nxp.com>
 <20260912162452.AC66C1F00898@smtp.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912162452.AC66C1F00898@smtp.kernel.org>
X-ClientProxiedBy: WA2PEPF000008BE.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::691) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|DBBPR04MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: 23593988-ab8b-4999-9838-08df10eabb53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|23010399003|19092799006|1800799024|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	FJJrm3PeJpcBDjVsaqqbhCg6q11VLSmv0lGHjn1caH9Fgfa4mbNWq/9m9V3f3S4PkHYbN5lK0/O9FJSZJuSbf8pOFA9HSilX5n1vm3WkGRG9JoIowMeZT7NLOzuQtgzkIMJbbSbnP5WnCU4BK24uEae2opoj5l/nbJ+oBHMBsG7gmoHrdX4OPZpf7PY1C1qUu1Ehz3Hu+W+bcpAtjlWs5qjH8j//09TUwhTSFLmrLn2Z1QptQBDSONgAkqHNd7EW9m0tpJcv77EOpgIf2cj8ZXELBFxfLZUL4lexs5eyEbQp0vDvrRvFt7X/yZFCb54WoAeXUs2zm15R6g7/Fkd0fpEOJtKQLTBC3YxsHLG99S5z3H9EFUq27OAyPL76YYb9f5mJqiCyG3SoOR6DgOwVKbQso/2/sR/2FU8uC6lRfajhO8DKFoW+eKt8AHJMvH9U+qniR4K/yU/K+P6+QfSlQM0uOkmsmuNzq/wa1dsJCqGf8XCaFf1yOgbldU7VrYllcWSzOtd5MrM3Xa2r5EmPUvm4w+BBIEEcps5MJGchS341BgnSR29i1lDHowpBYUm1spPZxmVYDtzfUHyTwFx5v2mvAigedcs4PLwj9h+j/5jqY87SAFEfLi7SU0t6sbLlmUMx/ScdR3af+vWjw8Tt9K1cKQdMt9U5AkzCqXl314I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(23010399003)(19092799006)(1800799024)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jvDKqFKigrnHRZScueM43HdjfYb3NCQRi4AEN1WOioTUY/GCF0Gt8v9KdZaB?=
 =?us-ascii?Q?INa2JvGM4XMBAK8Y5Mg4JVLnFZS5RY0tdod/HchPaIuZ91mgRbqdGFQ8q0q0?=
 =?us-ascii?Q?nWGoryDLhDyrCUXN9uN3aT0iQWKRjMurU5f3U3KYPAUM8yL0pommaFG9MWUV?=
 =?us-ascii?Q?ww5wVIhM6P+SxNtBueFnKj2pifnh8b5VQB2pNpucI20LaheL/0BSgHwjwnbR?=
 =?us-ascii?Q?L22LIwFrQqKFTuBDLwZdy9LWYoD9CVBX4+98jL/zpgTq/zbZC6AXzqOGCdWL?=
 =?us-ascii?Q?d1TPl+ViSMtMxr3VuIEOVu8E4JUvui/zBZFpoJQuexXvoS8OcwaGSOV8+zgU?=
 =?us-ascii?Q?AIm53vl35Fexe8p03j3kzcSI7AXp1J0W9v2rqfIVL9JNX9/a04tzJdM2iIzn?=
 =?us-ascii?Q?ZOHK4JzlsT8sAMrPBTZH2D1YwVkXBsFUfRIusOesQkTvaUWiVZfv+YdqJ4gA?=
 =?us-ascii?Q?4XdzkWq8O9yIHnZk4PiExraqLDjZ8i7IC0WwmDNnUcyL77ejfB3tnYbn8b6b?=
 =?us-ascii?Q?b5NTGt6D1r+dyCpYsMgrSEOho+nyThYzYHcrhm1qnnt5QmOGXzRJ7u4y0uyL?=
 =?us-ascii?Q?OSJJPTbQbzK8C1PYaP7/kUFZ2MbnmIqJ2fDl/sZeR7YGzxXyEZ+3sSDYer2y?=
 =?us-ascii?Q?i4edpuOkyXhDdL1GYV+idokcC7UoNfczvzXTMwR5vELjYzdO2EIQ0xfI4ccf?=
 =?us-ascii?Q?dvsA3J5kLzh7f1q5u56dj2WWbT3sLVj9E9/iTBOpq24w/ad6f6rLa8MuLmBn?=
 =?us-ascii?Q?yrA1741Ac+kpE+LLTJ8tfLG0GbQ9N+0jkzzbn/ntehYbso0NrlfrIXi9TVfC?=
 =?us-ascii?Q?tGFtXl0Oasdi295zZWjQeNr1D9JPHECebwmorYbSbJ+MuBM7xGkffNLL5wEj?=
 =?us-ascii?Q?/wr54rOY5JjpUV5Qku/iJ6AXfHQKcyJe5yOoVrFGtJo3+QaTXH6zl56SI5zW?=
 =?us-ascii?Q?EVZDmzyTlKdAZbgQF1PyzmIP/luPe9VZYE4jTIq2v+yZou8+cu8nQXOdhk7V?=
 =?us-ascii?Q?XuK1/M+M7zNy91mHCAe4yu4QTm8GqsIudH+V1GPmIR8Av2HkH4ndHuCAflQM?=
 =?us-ascii?Q?wcqpzrADGAlqI3CNqMu0FKtOTl085Rye/c7rBUwQLThHC1DHfvTcDLPwAvlL?=
 =?us-ascii?Q?E+7Kr629DOXiFcI1ae76TFizbSJAx5cVUWRJjBIeJsCE5Mu8v+RYFJGI5kD5?=
 =?us-ascii?Q?lzGlX9KJGxdTeDnLiVHZDssB9t149X1/NgDWH1WHYf0/IRIoFBvdmdeGhsWx?=
 =?us-ascii?Q?FU423JQJrcN6yG8GcJ987NdzsdgzDhjh5u+k30YleJE65HJ2ujcnNo+M10Uo?=
 =?us-ascii?Q?iVysv+OE8NROgFY6BX714LJZXF75hj0aR+es6aa0eVWkx9s9ZFN5wGdLYnEZ?=
 =?us-ascii?Q?efrIgTIipnjUtVeUdWI78O7wD68UfXHCciqitYLCYKH63pcrXcn5hdrpdFHh?=
 =?us-ascii?Q?WXvtMTozKaUs5QpUVSaBVt48zxK5Xyuxz32ER5rtxn6CehqbEQzAAmr/1JiF?=
 =?us-ascii?Q?FmYEmr8bKCO6oU/EUuzNaUSLcglx8o10ibHDmSBFuhR2eZqcoX5xGZSfdSib?=
 =?us-ascii?Q?lMhlVMkZ1IgUBv8cUZATZUn2e/2+OxRT1jlBLVeBB8vQDVqcaZMb5BHH6GAN?=
 =?us-ascii?Q?yjkTJBbhau6f0vegxDIRmqux3TK+2SKultfDQSJ7VlNjK11VrH5rDv9sIknc?=
 =?us-ascii?Q?EFfakxSElKdQBaQdBJiunxgmcnnPKmAmN7j58nZLSywWtcnhB5PaRK5m9D8h?=
 =?us-ascii?Q?ETBy8Eu8mAEquJDXdorBZylxTbRq4s2MhAa7+qcZxgRjcRO7QVufEwYfF7Jp?=
X-MS-Exchange-AntiSpam-MessageData-1: sKNEqo55B4pX2uQ1XeCN+nCqw/D5GZy8ZhU=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23593988-ab8b-4999-9838-08df10eabb53
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 16:27:26.1865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OyJr2aJSXMG58qqdlTF9l1OUFV58c4GDvPiirtZq7crl2x+OTWS36RpK7D/hjZi9t74Gt5KNr+gOKZVCKk1Rsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7657

On Sat, Sep 12, 2026 at 04:24:52PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The probe function `cdns_plat_pcie_probe` unconditionally returns 0 on failure paths, masking initialization errors from the driver core.
> - [High] Shutdown and PM callbacks erroneously cast `struct cdns_plat_pcie *` to `struct cdns_pcie *`, causing severe out-of-bounds memory accesses.
> --

There is no way I'm touching the pre-existing issues, sorry.
