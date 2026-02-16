Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011033.outbound.protection.outlook.com [40.107.130.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91115331237;
	Mon, 16 Feb 2026 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771257389; cv=fail; b=A/yx4OoPwVO8KwH5M+l+lJln/9gxDLGzhWy8gzpzj79UH7+GuTKXJteGtuERQVwmdaNmvqO2UpuEDsehBVP8IvQpiNHCfwz7wKUxB8tt3i0z+XRmBEzZXbNlssB3uAkzjwZ/ku2lDq0D1KLIpGP/FFbpZOhD5cW7VUnTUHDXwK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771257389; c=relaxed/simple;
	bh=mDRkrfMhXFawGBCbzS3SfmztcfH6qPL6Ffmf06dcGm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mvXgx7huNQRXZ8jOFFbGhJvjIzvEp1RAMbWRPJc1ygYe3qi7AKHyPDXbDPR3DEHMC28PpEguio/cvem1yBYgy9Rh/rJKdf/6hEEG8w9jrsGKw0325kYKptRVkbMXO1LekrAFbFLH4Rs5VkosKgSpoL+zHjHMu48Sp3OoWdHYnbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LsgllSeN; arc=fail smtp.client-ip=40.107.130.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LsgllSeN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eR4DZLOgDH1yBzmRPhz0HBwKSLehAT//n4ozxYDbG9GREUYbVcxNxs/5iXVSnUnlnvx+ThuoWNmMUXJrtrHIl9oqGjqsjk7YkqZDQ5mTP6zJWSbq79Z9kfw95speNdpX7jFHdcNcq66hFgfk+XOXKRh4b63fQEbXi7+3ksnLZJYAvk8eytTZZkL3+SA0ID3MoeJAuHu/aoU74kXg0zwY3osCKpblEmu87rN2cuUjQq/yRE9Gqh0XWSk7foFv0pCXgqkLnN0d7WZV4N2SLyyC13Vd7DhvmCtaRMFsbwhF49O6lzRXGV6LqkcgeibcQMu5nyKbl4nOcLLT5Blr/HgV3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1UAHd6WHlSK06Ajhui5jk60lZ8zNg3D5D+/WDmuU/c=;
 b=KfNnevn9pB43Y+BVDgL4NEV0MLQL4WILBqqURLn2y6A5MS0hCu0d8FgAE6tL4SafFsbL8jfLXsiY7bNLLJ4SW/C3kZgwfra7/XFScyBIAGObY/lQh+C8dgw2PeXaMFG4/eKOGWWiHNsqa0CqMjcw0EVsCiFDv+Gg/CHUIRRNFKDOG+B4NFAxZwz0ALlAXDNd98VTCvpxL3zqe/3fKpfe6Xz33IP0lXDHgHoVhChao0uRfvMmIgkIp0QUdFuYMsFClnFTwu/pCCwUKpeg82ZQvsulE4q7vB52dKDSGLbsk6589LG55AgZ+tJt1cmLq0vDET4Z2v+kklbFhEZ+DEqi8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1UAHd6WHlSK06Ajhui5jk60lZ8zNg3D5D+/WDmuU/c=;
 b=LsgllSeNibZWRPfgXpxgwRMJ7EBBu3ww/Ds1xeIDWnzlofqp4V0Ric8yn2pJrI6Q2IsFYGZid4Q49AenASMjV2pvMVS0gIQ5IZwrurYMmPnqQSRP6porX1WJexc0Qu0RdW1MFciHTAuf6q2K/Kr7ni2WLoZylCAPbUT4I3fwKNVlTjCf4pPsQgWhsKcA7zB3w5i7u+WkOOYyXsOoqrDT0z5ApuQuowqNeB5XhLodNA8AlqiLrWiIf+24AtvQr8Vt1xFQQ7M2PE3eoFNSDYAa46udn491Cq5suM2Od0TvJ5JRL6Ol/D8yXgMsHvjKqolHHNyCFS1/XVhlDnJ30NZOuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DBBPR04MB7961.eurprd04.prod.outlook.com (2603:10a6:10:1ee::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 15:56:23 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 15:56:23 +0000
Date: Mon, 16 Feb 2026 10:56:14 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	heiko@sntech.de, kishon@kernel.org, jdmason@kudzu.us,
	dave.jiang@intel.com, allenbh@gmail.com, cassel@kernel.org,
	shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, ntb@lists.linux.dev
Subject: Re: [PATCH v7 3/9] PCI: endpoint: Add auxiliary resource query API
Message-ID: <aZM-HsMHFLycyNAE@lizhi-Precision-Tower-5810>
References: <20260215163847.3522572-1-den@valinux.co.jp>
 <20260215163847.3522572-4-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215163847.3522572-4-den@valinux.co.jp>
X-ClientProxiedBy: PH7P223CA0003.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::34) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DBBPR04MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f3ae61-73f4-4cf5-6c84-08de6d73ef14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|7416014|376014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yXgAFZtsoTH/XOlwOeJQWvdCCHC34ddTbUphGDDaD1Gl89GPPks6LguS3h3r?=
 =?us-ascii?Q?cE1XeqK95iptGgaQtClxjfcKEGZ+kOWjO2uS223z7V/+Sw3rP/yhuwegLb0U?=
 =?us-ascii?Q?YxNWHFMYz3+KkbDd6mlE0aCbSzI2o2vEW39bEm2osbKnwesit0M4/D4hDpET?=
 =?us-ascii?Q?0VXIK9RrClgtAECV/oFZeMg3fDH+fBGBHUcrbD0dMznKlFh3adFSj7TZbYr0?=
 =?us-ascii?Q?RISmEHF4zfk770Z+qzflywvDO1MGTL0MDBEEUUqbFKDVI9BjSOR++iJccYGA?=
 =?us-ascii?Q?XzyUZsQNeanj7NxJ507quZyB10lT7OBst/XUYLP1l+81XN264m1gwsn49WDq?=
 =?us-ascii?Q?d35m/1N6DvAyHciLljgOAM6RXkZK7SHoh9xVVv5/cXYZeaJpjIQdMmqRSTxM?=
 =?us-ascii?Q?gS6ZPln2qxbZdv7ZWuUEHhRYCklIBEj+sk5jfj/MI5++wBZWWWnFWUf5RS+3?=
 =?us-ascii?Q?FCSG5QTsWvpV5wfiZYh76spKRIL8A10fQKgedIBWolVUtwt7OqI7PWY9xtyX?=
 =?us-ascii?Q?myRLAHCWGJKYOFfB+JqJcfy+89TY9jJ8G4o7HtcvIXxOXvG77eJLOEM4Uiuw?=
 =?us-ascii?Q?do9OHcDRLtY7PyuhQiUxKbhKv3u27n0b6nWj4M0cx5+KkF0lDs8Jl15ojFd2?=
 =?us-ascii?Q?Zxh67PnqXrXgpTNXUQFKTdIRnd5EIvbv/kEVkA7GQ8mZ35n/+NOmQp/cXL5o?=
 =?us-ascii?Q?muCbmquU9ZR3S7FSbUv5f43JJe+xuXOCYWYhZ23Kg0kSZwmojM+XnhE/TEsP?=
 =?us-ascii?Q?8ZR+RL8vYBNN7vRnCqwG/bp5b6Vvsxprs4ZJrfzsRrX9JYctGySMIW2fmr8F?=
 =?us-ascii?Q?EoNcnHD5lNh3LTSJHcV8mio4cCsMCDwHPLDQl0lvA8eX4ExsOnaH6vrTqbmb?=
 =?us-ascii?Q?ai+X+8vngwJvtTHCnYxCWFlmJYu+uSYv6kxZaCjvhbjRoSUlaG4IdLJjB0IG?=
 =?us-ascii?Q?yC5pcQA6etSq7XGnb6RhEKrVHk0D2iH9e8kDT8FRfeIb5lZgPskGY/5fbX61?=
 =?us-ascii?Q?V7FbJmloMwBSQM8Qx8dsF8ZPnZfJrpd6Yj14eDQTNPy7mZYBzEE+QAc5cleo?=
 =?us-ascii?Q?WcYRbQjHkgDoa/35OubOr16TexHmi9QFLk3wEwRkzoSx86tNzt7IPPaP+UUo?=
 =?us-ascii?Q?LH6pq1+CzpMGascP9cjhwU/cdoDErnZp4c8p6HW9pqvUgGWFqUzb/Fo8WZYH?=
 =?us-ascii?Q?MarX136p/4OV6rsDwE+zC7cem6NhzYcyrIrlyCesgPc9z5S8GvWVh/PK/rqL?=
 =?us-ascii?Q?mjw/wRJ7jGXW1xeW+qje9BVf0aTHQ1/MrvrIQW3P2nDlGjs1kQq7c53sXIU1?=
 =?us-ascii?Q?nJ0wTC5BeI6hqPbZauIwDDuDnSLTjOKiCiPlr1daIBy8RjniRcbRuLR8zzOA?=
 =?us-ascii?Q?uu0uwN71w2igWkeJ+CdPF0vmj4Ny9GgGjRpza2cklfgQSNSHvP4FOe3RTV3d?=
 =?us-ascii?Q?5Ys5XOK1jb2s6JBqwmJ2n5xB+zcgTto5SVXqkw4KgnRRQW0c2337W/p3wy3n?=
 =?us-ascii?Q?nB1FBpRDrtGZSb4vOb/esvYARwKdP0MDFZlx1MkHX/lufI1NUoUtlnAAMxFw?=
 =?us-ascii?Q?qANHCFBKhG/7Q2wIX/hEijF1xWokoJ33/n15g4Ip5ol1oLc0rWPQSxblX+xZ?=
 =?us-ascii?Q?dADrWDu2LUz+w3OMz3Oj6fU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8w8ZgxmhabxM7IYPTQ31XeXUkNbjp4x0owuYXIJCdzRlSgjkUokKtFKcJBXP?=
 =?us-ascii?Q?tDyvSwyq/+GOvSYB6RapiaG6fYzvB7oYzSyVEfPzvc5kHSUD5X2UiLDl+c77?=
 =?us-ascii?Q?rJ/ZGnWQwKNGz3Yvz4I/b1UeuGERaEJYByWrBRFxuia9zKGoYzKZJ1cdVLWQ?=
 =?us-ascii?Q?bwKSvNeRvlA7AseExjdMowugJEuiEUTmcVAuFov4gU53NV43WNoVHTQoNT/X?=
 =?us-ascii?Q?aznPwDGwWFeNOSJQJnHuWqY6yHd9mje5SjVq8yb/HlJK8IBq/M60sS2IdsdE?=
 =?us-ascii?Q?OU1uhup2wEMrSrsQ3KHYgs4ZblrFQNQ+Oak1s79Z9eJeq8JAkV7umOTHxpYy?=
 =?us-ascii?Q?OCzVDQauJMW5kc3tNSvM2llG4YS7hizL09lABj77BFaTRs2K2mTdRzKh2Ngv?=
 =?us-ascii?Q?y54UShWyQKlaGyqAvaJAL35se0j256RPSqxQV6lrJFUCbJVCj5FiVca1xorl?=
 =?us-ascii?Q?Bi5FVt+sMgkTZhV780ZLjXGjHAcYZAhGl3MEEGetx6sCc/BVUFqRO7HDpdUG?=
 =?us-ascii?Q?Ev/bkxGvkTGc7AQ6A5hq8KuZMb+6cqnWGNSsHyLpeWtZtlygfK3R26g4lzON?=
 =?us-ascii?Q?zlp8zyvK+/90zOZpJJijCd1FVnJh8WXXE0qk9mrp7W/yeca4AFpOTM4+3hUb?=
 =?us-ascii?Q?corURBhykSrCuNT7cnHNlnXzAX779TdIiTCOl2bkqh11UpfLNwsilqMFfxaj?=
 =?us-ascii?Q?r55yJIf7ISyJKBbYIdd/KOYFOM4rh/VzgDjhfiXvLdSZsh3VankV43DokdSp?=
 =?us-ascii?Q?i5nGrKwUsWBxEYw1+/FzeCm7UhzAcsRdFlGxeVYuywoneLRzPqfEb1oi7jOr?=
 =?us-ascii?Q?nDcqSvLmObpC4Pu8+HjmHGAnzSEoOOPHucL4Vwwl8rBjl+x4kXZkj8UROUJG?=
 =?us-ascii?Q?UlmX6Cdr52LwDeejkN/IdY28S0pXRE9AX8xe2+W/5yQ+XEX1UQ4glhdj6EuQ?=
 =?us-ascii?Q?FYGRkFAANu4l9N8nwRSspBqixfKMUfCkSRlDl+P+7ViTP5M4EbjqD9oULXmn?=
 =?us-ascii?Q?zAGtVGGFyI9b0Ur+XPXTmgo68NTaj3U+Ozqa0Ut7zH2wWo6lgya4e49wfUhN?=
 =?us-ascii?Q?3YV1CdHYRRZw6JQVIPgzCtxG4TbJr5o0FxJPLsiYr16fWUGS9wwoOfoPgw2h?=
 =?us-ascii?Q?XEKFRZq23GVyVluxFttJbuyVIY1eF5wQtd3UqHD/Q28qgI0ALw4JUZf1gkg8?=
 =?us-ascii?Q?4XjeOXcjdNbZfkHLeklRB1TTOm0oUQip0fuHnHXYGNFhw7PkxndFDFQS6NC4?=
 =?us-ascii?Q?S9IFz96EX/dAgtuiMO96e7MQgAhXBIG52zmo0CIbSkr54eTNnSsMLAcTYOc1?=
 =?us-ascii?Q?O68bBzvwhJgFtllzOe+LYmc17ZrPrMar/x/qDj34Xgo3ZhraehFc6WQoEsWi?=
 =?us-ascii?Q?wH2GubjuFPh73Zmx0GoYW0fSHlH4cw0dMgK/oUclksq0al4tUL6QQ3rAnzt5?=
 =?us-ascii?Q?+JeFnhJtmwFMs/XN2zgze6MJNQJCKB4QrUTkJvjLOR03CqUTA8BJyJvtm7FV?=
 =?us-ascii?Q?xdnrPKYa2n1qJUUQ36MdM0Phdu2VLyAOqay5ZkLCV2WISk53hNw5IcUo7KPp?=
 =?us-ascii?Q?bp92s4eXWjPE4CwCWNHlJgb7zXnToC1lpxl32kMH27KtISieYW05Bg7tvMfv?=
 =?us-ascii?Q?9+y88CqhrGHg3XLDfYgc81kVpqEFEfSi1wEh/9+bIXe4uQYz5KeLPLYQuJTT?=
 =?us-ascii?Q?F8LrI4IrmrMc+De9kNWCkfuMeAsnE/AH4LmmPCVM9kPxe0B3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f3ae61-73f4-4cf5-6c84-08de6d73ef14
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 15:56:23.4676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WsV3svqv08V3a4/xfNOlrdDHaHJr10nP9+BBJEB14MJNac843aMiyPBQqgrAYqi1gh/oAe/sR1t9NerjnPzd8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7961

On Mon, Feb 16, 2026 at 01:38:41AM +0900, Koichiro Den wrote:
> Endpoint controller drivers may integrate auxiliary blocks (e.g. DMA
> engines) whose register windows and descriptor memories metadata need to
> be exposed to a remote peer. Endpoint function drivers need a generic
> way to discover such resources without hard-coding controller-specific
> helpers.
>
> Add pci_epc_get_aux_resources() and the corresponding pci_epc_ops
> get_aux_resources() callback. The API returns a list of resources
> described by type, physical address and size, plus type-specific
> metadata.
>
> Passing resources == NULL (or num_resources == 0) returns the required
> number of entries.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/pci/endpoint/pci-epc-core.c | 41 +++++++++++++++++++++++
>  include/linux/pci-epc.h             | 51 +++++++++++++++++++++++++++++
>  2 files changed, 92 insertions(+)
>
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 068155819c57..01de4bd5047a 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -155,6 +155,47 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_get_features);
>
> +/**
> + * pci_epc_get_aux_resources() - query EPC-provided auxiliary resources
> + * @epc: EPC device
> + * @func_no: function number
> + * @vfunc_no: virtual function number
> + * @resources: output array (may be NULL to query required count)
> + * @num_resources: size of @resources array in entries (0 when querying count)
> + *
> + * Some EPC backends integrate auxiliary blocks (e.g. DMA engines) whose control
> + * registers and/or descriptor memories can be exposed to the host by mapping
> + * them into BAR space. This helper queries the backend for such resources.
> + *
> + * Return:
> + *   * >= 0: number of resources returned (or required, if @resources is NULL)
> + *   * -EOPNOTSUPP: backend does not support auxiliary resource queries
> + *   * other -errno on failure
> + */
> +int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +			      struct pci_epc_aux_resource *resources,
> +			      int num_resources)
> +{
> +	int ret;
> +
> +	if (!epc || !epc->ops)
> +		return -EINVAL;
> +
> +	if (func_no >= epc->max_functions)
> +		return -EINVAL;
> +
> +	if (!epc->ops->get_aux_resources)
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&epc->lock);
> +	ret = epc->ops->get_aux_resources(epc, func_no, vfunc_no, resources,
> +					  num_resources);
> +	mutex_unlock(&epc->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_get_aux_resources);
> +
>  /**
>   * pci_epc_stop() - stop the PCI link
>   * @epc: the link of the EPC device that has to be stopped
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 7a87f5962dd0..fd79784b31db 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -61,6 +61,50 @@ struct pci_epc_map {
>  	void __iomem	*virt_addr;
>  };
>
> +/**
> + * enum pci_epc_aux_resource_type - auxiliary resource type identifiers
> + * @PCI_EPC_AUX_DMA_CTRL_MMIO: Integrated DMA controller register window (MMIO)
> + * @PCI_EPC_AUX_DMA_CHAN_DESC: Per-channel DMA descriptor
> + * @PCI_EPC_AUX_DOORBELL_MMIO: Doorbell MMIO, that might be outside the DMA
> + *                             controller register window
> + *
> + * EPC backends may expose auxiliary blocks (e.g. DMA engines) by mapping their
> + * register windows and descriptor memories into BAR space. This enum
> + * identifies the type of each exposable resource.
> + */
> +enum pci_epc_aux_resource_type {
> +	PCI_EPC_AUX_DMA_CTRL_MMIO,
> +	PCI_EPC_AUX_DMA_CHAN_DESC,
> +	PCI_EPC_AUX_DOORBELL_MMIO,
> +};
> +
> +/**
> + * struct pci_epc_aux_resource - a physical auxiliary resource that may be
> + *                               exposed for peer use
> + * @type:       resource type, see enum pci_epc_aux_resource_type
> + * @phys_addr:  physical base address of the resource
> + * @size:       size of the resource in bytes
> + * @bar:        BAR number where this resource is already exposed to the RC
> + *              (NO_BAR if not)
> + * @bar_offset: offset within @bar where the resource starts (valid iff
> + *              @bar != NO_BAR)
> + * @u:          type-specific metadata
> + */
> +struct pci_epc_aux_resource {
> +	enum pci_epc_aux_resource_type type;
> +	phys_addr_t phys_addr;
> +	resource_size_t size;
> +	enum pci_barno bar;
> +	resource_size_t bar_offset;
> +
> +	union {
> +		/* PCI_EPC_AUX_DOORBELL_MMIO */
> +		struct {
> +			int irq;
> +		} db_mmio;
> +	} u;
> +};
> +
>  /**
>   * struct pci_epc_ops - set of function pointers for performing EPC operations
>   * @write_header: ops to populate configuration space header
> @@ -84,6 +128,7 @@ struct pci_epc_map {
>   * @start: ops to start the PCI link
>   * @stop: ops to stop the PCI link
>   * @get_features: ops to get the features supported by the EPC
> + * @get_aux_resources: ops to retrieve controller-owned auxiliary resources
>   * @owner: the module owner containing the ops
>   */
>  struct pci_epc_ops {
> @@ -115,6 +160,9 @@ struct pci_epc_ops {
>  	void	(*stop)(struct pci_epc *epc);
>  	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
>  						       u8 func_no, u8 vfunc_no);
> +	int	(*get_aux_resources)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +				     struct pci_epc_aux_resource *resources,
> +				     int num_resources);
>  	struct module *owner;
>  };
>
> @@ -337,6 +385,9 @@ int pci_epc_start(struct pci_epc *epc);
>  void pci_epc_stop(struct pci_epc *epc);
>  const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
>  						    u8 func_no, u8 vfunc_no);
> +int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +			      struct pci_epc_aux_resource *resources,
> +			      int num_resources);
>  enum pci_barno
>  pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
>  enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
> --
> 2.51.0
>
