Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013023.outbound.protection.outlook.com [40.107.159.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7596535CB87;
	Fri, 13 Feb 2026 15:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770996574; cv=fail; b=Y8UH+sw/RJWXzRG02E3nNF+nFmI2iZitCY2Ude+b/UZQfLwzFKfJ4XDUJYotRYEDe2FgwjE5uC9u5a1wIM8QlGmqzvliPfIG+8OR0L26SRRt2qiRdEREbz42qDJ27mt3a7VcPH/zhdsEOlfOllFlliZ7nasmZvLw6tl02nMQj/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770996574; c=relaxed/simple;
	bh=hrYa0lGB8N6PIUdl5MR2/3gikq7bxlpkNSeafUJxiPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aBFISmaBH/Xd+mXuEsb8CFqDKaNe5Pj6ZrHWUijBzyFOM1ss8dvZzmrdPpVggyCckj+lEX5e++2oQEtAHiQcF2PZtnqY9Cg563E5seqssSRTFpSxbcI8HIlJvo8ZJjF+lFJlHso8L6yjuW3/UubzqDbptnViVU87BLRDtO7kISw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nyJ3iY8h; arc=fail smtp.client-ip=40.107.159.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nyJ3iY8h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJTkduY22SqBeMiEkqrrViBbhrAQ2pmx6U6uX9cEjfIWdY/n76Aw62N5E0QMOIFyYWmo1PUXdLFh10m+tvAWB3j2H/UBZ38sf947YK3cgjyjBqow5sbjx9V8bFMquf3nwMCE95DctheXjS9+33uDxObVFp+SPk5oJb9KuJC8Y88EdEwCcHBVxyqJsRRMS2P+OUGY134I7f9pEB/W1ZtIAuL10JTBAvHnRnBJQ6s/0SqOE2Sv2BPAH/+PirhRQwqge7zTZJIJET9X0qfPZCA+UEK0j6wR81KdgY7axMIXYeKRktCCbf6oWaMbkqRB7umx8bz2OVz7DMSbnRa4n9bi6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PeQg+e3AMSUoTAZDw6UmTpe0CNCgeqQcEhAv8xqXR3A=;
 b=vn0ov7Fm2PEwfLLeg06ANKurbJp1t8ypYyro4CpDtNPZvmZTojag7JzuTuC7GaUFJLXLKdvV4PyMtCY8RvXqS1jvlReYjSovuKkEGtl34bprjMs1eNX6/rCP9WT7hyfVFbQG5XNiaWYmMmpQJ/SrgURUpEihuOkyzaUuy0W8lxL1VuknllPhQHP71T4g9lVIEXq7mGyLiMHfWTP6yTwbWDXIFY3xFXqbjXJJ22lspOr/269IAn0r2PD1JA+3nwDO0CYdmH8xy2BQhSbN48mnbheCheFVhFw+qMzyYDgU5e8C1sI3VJYdQ6HWHNYejxDZpdQR3EBfbVXxpRVd4w/2XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeQg+e3AMSUoTAZDw6UmTpe0CNCgeqQcEhAv8xqXR3A=;
 b=nyJ3iY8hdBjsCwtoZx1tuCgBTlDSRoWj7xcil/TfrOFC1vUk3wn76Ev+MqPho6npiz2/NWAzr3jQHbDkIQXO/nKP3h+nd8Tuluql8HhIaaKf8tp4QzbuIYcOHaOSCtMy6eE4EiwNito7vq8igXt/rAxg28xf/H+e5SKQVjLrOujCQDSxUJv/aCYwiBpoXt2P08TiDTp0yzV4f7qaMDJ4nwL3BFGA3/BM64tSDg3Na38ZMYUrLTSR5TjnpFqA3YPA6xAfH65T8VF8g3V2/jQrq9Zu7Vm9cg+fuzbQALQJ2TTJB0G1prG/IrmhuYE8ZuWuwT8cv3rEGPxHQi4PfjYEqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS8PR04MB7637.eurprd04.prod.outlook.com (2603:10a6:20b:29d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 15:29:26 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 15:29:21 +0000
Date: Fri, 13 Feb 2026 10:29:12 -0500
From: Frank Li <Frank.li@nxp.com>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev,
	kernel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 03/12] PCI: dwc: Allow external allocation of
 pci_host_bridge
Message-ID: <aY9DSPaTCMhcR8GC@lizhi-Precision-Tower-5810>
References: <20260213040852.3340547-1-sherry.sun@nxp.com>
 <20260213040852.3340547-4-sherry.sun@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213040852.3340547-4-sherry.sun@nxp.com>
X-ClientProxiedBy: PH8PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::23) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS8PR04MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: 054bc426-f90e-4874-0ba5-08de6b14a909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|7416014|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9Aff49LVwWjcd7O+d39coCCGsKImUq5aI3sE7iJy6qqwYyt5za5YPZfyTjZV?=
 =?us-ascii?Q?PqWfKiHir1mJnDcLiv7BifeG6QHz/YPDAeUDxoU7KY5L57tTI3c1hspHupIH?=
 =?us-ascii?Q?K9BXJOukdLE2anGPWIQLjjbKI2HjVLQ9RdbE/LdL2z5nWQ58GXEaSxJYzBH6?=
 =?us-ascii?Q?e+vITxuD4JZ+A99nxvgyelWUh7OC+GCJJ+ukETBqQgGtR7Kj/OTi2DklBmeZ?=
 =?us-ascii?Q?CTs+vzA8P2aulgI+ng61FadXp9OyzZ1gUR183RP8aYGS1Y5YXsht09s7RpSE?=
 =?us-ascii?Q?5La5jyDuUtZJOuBl1WX5SoOJCul1fj4z7zMxGZRlNhsqjegXaF52I/AKmW4o?=
 =?us-ascii?Q?w7p57l3JmQBdaYTsTvsCIkBkxZDSZezXZ0+PjLB5Ld5bbL/uQeGy0Fb8vuHC?=
 =?us-ascii?Q?v5zHlj0W86gDNT5ArG4ijRW9cUrLZsXP2FoagQR+6nwft3EFI9BrLs8AP2vz?=
 =?us-ascii?Q?WE6j7QhqKQors/SNV53MQuBpXtLbNAGc4UHmZLNA+laBpUmXgVrcrBRAXVzH?=
 =?us-ascii?Q?W2pF74cJNYLlMg3hbf+6U8Eumm+pWg58mMo82iUHKV2ZHRgFu5cCNv6oUVJI?=
 =?us-ascii?Q?P0IpcmDixNYOH2UF1q0W5CGdMuXG2G4ELgAg7iyFt0FsufUYDIPHIuANdEF9?=
 =?us-ascii?Q?3x7ll6LVSoc9jFfm02Mj+7UGOpJ7QlZjR3wmmS2ZSQla/7Ilsa3/iB5K3Z7T?=
 =?us-ascii?Q?BlUjvxoU1eJVM+FYW5bidNZ0YkHN40dkXpXqJtQOWQgH0iRJfOaOXlXz5Z8T?=
 =?us-ascii?Q?+SD7B3Z/x+B+/kCZ0zHm1+rNIQtPrFG8+zuRpt/3I0fQYA3phRN27DxM2yMy?=
 =?us-ascii?Q?p+PV2ewGhL4MZj8mGrOnhVlvgmnldJv78gsFNLy3Ygh1um5erCea3GX7VcvZ?=
 =?us-ascii?Q?t55dD2Mf4wiF2oDoBPpYepqrIF09JUp08dV8I1SQcVYKt+63ltenm3+Qfk9Q?=
 =?us-ascii?Q?eKiw7NWTSH44FOrgam1iypvvgsrJwPRc/BE+E8Rspzv5svxFcCEHfXvf3ioA?=
 =?us-ascii?Q?XZE9Ge7vhWKvh/oA1+LQWmGiPfS6W6EXFFp34Mfj4wHNDSvEWoFvyIU6zraP?=
 =?us-ascii?Q?mfvKnHt4PTU7mrYe2jn7PQaqZw7nqTenfLBFnswp8qjMpKNb1k4FqbcMcgkP?=
 =?us-ascii?Q?BxXdz/QjlGtHiam+z5IEKzx84oAEj8NfI4I00QrODCZapahcZz08jkxIAavQ?=
 =?us-ascii?Q?9K+kWPqzkKgMpn+b0DZ67NZGvsyLz6PyQUUQI+x40tn8Io1RYbDmff7dbn5M?=
 =?us-ascii?Q?qUxIZQyb6vVUtBgcSuDBA/rsx9eVTp4VdDzhRLtMe0ULxhOYSnrdTfJk+Odj?=
 =?us-ascii?Q?7Xv/ZrLrJsDV29tARKch1ZtlGHv9qNNAxxUfOFRQzSNoSXpYzJcTQZVwpoqE?=
 =?us-ascii?Q?RBpRP/eoC8KccrBqOIByu4+IMWlQW3BqlR5xXAAjIePT7Qiovg9V9bpYn8FQ?=
 =?us-ascii?Q?dw8tqz1nd4zegcYuLgyhu0rHxn+YjNzWRnlg0VFNpZ9o0rtG3haP2bPZidMa?=
 =?us-ascii?Q?Nt0KhbiA0tMlI5rahrXw+uHLMXrGzLSXpbgGheeOBpqVZ94KYj98G2JgxADt?=
 =?us-ascii?Q?7bM0dfDpoBoYQPcAoX6SS1wZEiuGIRB32mjGKKtqsPrgev99nST5bofh9eeM?=
 =?us-ascii?Q?sCkDRYKBKgroXQgBC603KpA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(7416014)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gzbMW4G+hQWgsll8uTK+dShZGyzk2J6AHBBRPddu6QdHSf7LaIwK9PLcgSNt?=
 =?us-ascii?Q?hxCIKM4tELO14S/9Y5cGz2aO8NR+3lLfjCzjrlqbS1losYhiOcVlknkz5drl?=
 =?us-ascii?Q?D/Zlp7KKB2+Y5R6SJi5hInMgkPkjJx7I8NlahzcyPnEXmyQbhpgIVGODeC3i?=
 =?us-ascii?Q?O6goxuG/zODenv/rYvOceYsuK8BvOLsnp9shg21/l1Z9kPW3rfGv/sl9mXUL?=
 =?us-ascii?Q?qrlL31e69CZNnTYHVKO8izeRh49rit57aZbgZeY7rz8Lp6qFhleD1zi9w5ek?=
 =?us-ascii?Q?QZnnpoFxU+eP9O7LGgC/x8jzePW2+v3eNOOFxtae5IGtPDhuQrGhEJcAE5eT?=
 =?us-ascii?Q?1wYfRoMkUVZ5DXRbZmOTv6gRHsn0wwzmHU1JGup67QvJFFxg1CO4vSWeMyiH?=
 =?us-ascii?Q?G8EVr3xN+lB4qiKZ/g6ViZV7SrkkNxR36mm5gAhp9qRs6brlddZjuMPivCD7?=
 =?us-ascii?Q?w7OPfWIvGKtJK/c8nxk8ICJmFnxpTJqcy/ketEbODjHlzblA7f+acWY+nbFK?=
 =?us-ascii?Q?kQBvzHiyaxcME+jfMcrpIfk8mHOaakubP0MFhLy9/VJMC3/+hl8jsw0ZW7qT?=
 =?us-ascii?Q?GTQ+WEs6/+zVXczhhXiqqtPIaSXeSZu3ZWDF8DqDpW82doTYkMBSFNVKJyyS?=
 =?us-ascii?Q?qip1AxI6MoIToy49QrLMAocTsVcBaVmgXObVfhBd1MH2LgmRX66zRC/phWjG?=
 =?us-ascii?Q?XOJTR+qiLlDi7sa3+HHkdMWomaRuS7NRGFIqfF/JLDUO58ZIiTRqD1Kg/pDO?=
 =?us-ascii?Q?9uBwB9I5jTzk2Et+aIsLz+qqZGogRwbQ+R30N6Lb3p8X8rtbDltGyPC+Yre4?=
 =?us-ascii?Q?FabP/XjvYrFXn+aCjqbCpRWaSd9C0pszKzDgKy57n/2O9ELMJYop2kb4wGZ6?=
 =?us-ascii?Q?0oe4xzdNi9crWubZVLKy0en86o6+kvB2bAmq72oxKCTTS+azpd3rY+gSIcrl?=
 =?us-ascii?Q?h3UjsONP6YYFABVmr5M/UxMcROIREt1Y7j6W++fUPF/79C/W0VzfC0d08WLI?=
 =?us-ascii?Q?RikKQ9dTr7fvSYKjyoAl4NEN8y8xGyyNJyBWiIO0CHouqWkxHhvKC31PUFxX?=
 =?us-ascii?Q?Dmund0HntTkdTvf5kuvLMYu2DxTAoUuKFiUlx2r2yu4tjqsb7fUBet1cnB7Q?=
 =?us-ascii?Q?Hy0s8WOeWoq2C7MpIYny/hbNwN+7whH8l+ARHhepiRhwaoch2G7nLHWd1SUm?=
 =?us-ascii?Q?QxXC7+x7o7OB5BkXRG80sO17ogRCYN1xzhj9qIFDUza8diwg4qdrpzZ76/tU?=
 =?us-ascii?Q?obr9t7q3Wlhnjlk03uGVLvlfJUZwASEtjX6afFtOhx+4E9gTeNtdz5lVPOUF?=
 =?us-ascii?Q?PS4b+eyDnogaf+bq9jTEJZuiVBUWEvCAoxZ0gEcQaZG4wh4nBa9r63v6Y+jW?=
 =?us-ascii?Q?0HjZcHifUgxiQ5rnEZo/jhGT1AQHBGfybWL1VeLWzEJGmqOj/jp3LJyC++4Q?=
 =?us-ascii?Q?YEJBZxk60Xs/SLgb7WNlUuCZvOPc2uIwot/FWa9eVxVRgYIOUMY0I016dSAz?=
 =?us-ascii?Q?RXteojsUwg2zckXmFLhf1aDeN/ovDmamExRo79Z+ztYuznip/tH825sXrjJq?=
 =?us-ascii?Q?hNkUVLEBhBqA7sekYYYN0yOSV81ybfCe8j152vyUEZXy2jEbhLTUPboyLd8z?=
 =?us-ascii?Q?hm23PiYPlVxjgijhnzexMoKFymXfcFTguiZiCnpMQY3nneQDfKhvDI1H4LMo?=
 =?us-ascii?Q?q4/ptfpoN6adP32QmC2nnG45IKGBIOeW4JIfTO5C95ul4QmS9mXTZ175ywHW?=
 =?us-ascii?Q?QRXdvcS4CQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 054bc426-f90e-4874-0ba5-08de6b14a909
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 15:29:21.5353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kTFzVFjtExqcSoVoHfdANz4sjq518DhVyteq2gQq9uaAyur0YlleA5Er30azQ7WzfJ9OUB3kXYwG59XSBslBPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7637

On Fri, Feb 13, 2026 at 12:08:43PM +0800, Sherry Sun wrote:
> Currently, dw_pcie_host_init() always allocates a new pci_host_bridge
> structure internally using devm_pci_alloc_host_bridge(). This prevents
> drivers from pre-allocating the bridge structure when needed.
>
> Modify dw_pcie_host_init() to check if pp->bridge is already set. If
> set, use the pre-allocated bridge instead of allocating a new one. This
> maintains backward compatibility with existing drivers that don't set
> pp->bridge, while allowing new drivers to pre-allocate when needed.
>
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 6ae6189e9b8a..c2de9830e1e9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -575,11 +575,15 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>
>  	raw_spin_lock_init(&pp->lock);
>
> -	bridge = devm_pci_alloc_host_bridge(dev, 0);
> -	if (!bridge)
> -		return -ENOMEM;
> +	if (!pp->bridge) {
> +		bridge = devm_pci_alloc_host_bridge(dev, 0);

It'd better call parse port here, or in devm_pci_alloc_host_bridge().

If that, needn't check pp->bridge.

Frank
> +		if (!bridge)
> +			return -ENOMEM;
>
> -	pp->bridge = bridge;
> +		pp->bridge = bridge;
> +	} else {
> +		bridge = pp->bridge;
> +	}
>
>  	ret = dw_pcie_host_get_resources(pp);
>  	if (ret)
> --
> 2.37.1
>
