Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792595705;
	b=WkifNSm540GyL71aQIaLEsCrESWu3mDwep1LuUWgHW0B4xDZbYkXVf/oaaW4fjHg9CM6
	 pouC9fTW/qvJsgAjLxwM863zfz8/4kCHpu1Wd7bkvwVCMPhiNGjf9Cb/B/gH4foadXfd3
	 uRVn33CkyrAVlDPYOSAl3xwlnRli+U/kzDYo1tgkQCwWk4drM102JitJ1CMCbmYSPTEbF
	 T711ZB2pP2Vev7FlHo7Aj20I/2uhJ/3Vh4xweftT3uwK0Ips0GjQKXZmFsN72kMhpaukI
	 7cyhZxPWVyOrr2St8LYGXDKu8f4BOjiVuJPQt4z+nPDO6OptNNQVMvauftXmlMdRl7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595705;
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
	bh=QuTk6DzVmcrBI6hNwnMFkLyxQcIWffWjNpXv8Ct1AM0=;
	b=lb3yTjRIq6wNK10EH+SFMvWk0vk00Qm+HfUy9QrS/qU79fWWS1uRUfIKaCtxEmVQPw/r
	 +G1VeeEkVFioGv2ZIpLxh2N+wri4WPglPd/PMkQ11kZX9oaghi6cSg6y36blC9DnycJNw
	 mjxFun6ml3F0nE/3ALrr9/KOCnzt7l5ZlKGJuXL/TaW8Z68wSm73iobvBpk73BDF0Utz/
	 y4qxLw0O2KmqaL3Q22RUPkKIrXtYQ9Jyv/8RPVTdn5sNvdZ8k9Tl3eaqJlyKz17yn1LZN
	 bQS0DAapEjQgXr/aZFbQLfvmJ6gNsa502HQXZMs2NqvRbcXOZPrkQVQZqXENfkXEJ1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=MDZBqNKI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.54
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011054.outbound.protection.outlook.com [52.101.65.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A770B606A31B;
	Wed, 21 Oct 2026 15:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A770B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=MDZBqNKI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrSNReVVgr6uw2m4PH68qGgaQRmnGxVEPGx9RuyTdU+H0rjecSiNEAJdbaQjCUZ+upb3LNdZO4omQOzvnUHXwi1k4OLlyZx5wLjUaM/bfd+xmqjqC3FtIgOJMuDExc32wE3JMOFZVUCzSd23YLtKwH842ihpw7oTg+O/vkMGJTPKlNCliqZbXj03Xk1Lt5O6ZS4uBAcuaWY0nnDxjP15Qb8F10f+1ohrRI0roM1qE9LKm6s6dnCr8tmvBE2CyDVbvBvHi7Z0xrY/zsQh0Td0Hi3+WcgwNM0lNvc6zZlnlQlWLtX6VX3aVEHPKtS/RMGRCtVWIz0l1ZWla4qrAXOxlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuTk6DzVmcrBI6hNwnMFkLyxQcIWffWjNpXv8Ct1AM0=;
 b=kzK+I6oBPjMX6qGM5BAOXAucYTujIPlKjszSvLGipd/dHPLULQO5zq10+H3P0PmVJ9dU+zhZVAFUESJeKi3/dkD9SHSS/5+UrPij1KiXz1amjdDUqc+ZA+/sjRyqGfgWuKC9Zlx2yMS5MrQ22IgsJv2XlSat4CQpBd+PnNc9X05SWst3Ry2kgLTwVQx428pFKaAIXToBU6SY/p6H1EprhFQYKjTzjhX4uB/JSl6/j4J72miRbNRvLznz7MzSAOfYlUCt+B0aGoEduM69AXoTogPuvW/kC2rXx2bgj+AopYg4Jvp8EnV7AXAJwLss67za0OBQj5p9GKaswloUjfhq3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuTk6DzVmcrBI6hNwnMFkLyxQcIWffWjNpXv8Ct1AM0=;
 b=MDZBqNKI0XX97D1sRwMe/aF3i6j06wPw3QGuS6JVUgwg20IXHuE+UWfSzJXqUAKAGQFpWIJxQUHttyxsVDevgca38St5JwdjxJslPNGXuDu9iSloP4wyy8/NFI4xHJWCJZKJKFOoR+lnmWxht910gRaSpvveM55cWHkPBxM+lmgcHKGEWpH7gnaUBR6ZdsyWMcKBZP5iS7fjk1KCtQ3k/dB6VKVRwwglICV4upFrWQyRKKbGzygxTDW52AiEOtSv9ziaAprj42qwWaUSpUeOSAzVdmZKzXxdVlJUQKPhV8IUuN7gRRY9MvQQYgPP4BEsrX1yoXuxmxfCO8IA+gbJIQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DUYPR04MB12692.eurprd04.prod.outlook.com (2603:10a6:10:65d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Wed, 21 Oct
 2026 15:15:01 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 15:15:01 +0000
Date: Wed, 21 Oct 2026 10:14:51 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org, robh@kernel.org,
	thierry.reding@kernel.org, jonathanh@nvidia.com, kishon@kernel.org,
	Frank.Li@kernel.org, vidyas@nvidia.com, cassel@kernel.org,
	den@valinux.co.jp, marco.crivellari@suse.com,
	andriy.shevchenko@linux.intel.com, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] PCI: tegra194: Propagate REFCLK select GPIO
 errors
Message-ID: <atjW62YB5hGU0I4C@SMW015318>
References: <20261021061349.1265704-1-mmaddireddy@nvidia.com>
 <20261021061349.1265704-2-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021061349.1265704-2-mmaddireddy@nvidia.com>
X-ClientProxiedBy: PH7PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:510:33d::33) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DUYPR04MB12692:EE_
X-MS-Office365-Filtering-Correlation-Id: 72583b50-34a4-439d-622e-08df2f8613f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|19092799006|1800799024|56012099006|11063799006|4143699003|261009223027099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	fqK/+A2vKvv+5N5uEevfjYz9Phqqb5/fOfVdLboP/Aup5RplvcqJBqYDaVPikRESSwQ6uHwgV135pgzlJKVWyAs3Z5JsCZ+H17ybifqhCqCFefls80jvLXCLXNrgx0WHEIRds5Rg40e+9C+4ldChkgO7MhCnpYbOXY3h2JS4K4tra3V5JC3hnmvvJ5m7Kd0Vd3JTRe7srzte+G5DUbJZjddQUCH68CDaAu6Z8b4V5xdUgVcrLBt4Za/y01pyXgeha8NBqcpB9algV8ftk7+mC8Bh6dr3Ba+8Env5SIKRXPCpZUM2tXk7G7v4+wshNY/p7xJ5I/hZz6le9aXIvB+iaSJ7SU7z+MDxloO6cxziQcUIxA09nwgwxdxN96ug03BNORqgf1fe0Xm5fMybqUP55ZQImDB3EsKhKFbYPqugLu0JumG24HtpkBc8jrCAIXEGEuaARJ1ROXKAeTp4yksYMJNCifxD+4xj/UHhwWYY778jeVChtk7rWb0xwB68NjRz+htQMCsrIwIEfuN/4TIXTO5Y1IRXpO6QcYH5kHoNYuK+jP15PXPW73OHervDKDk0HztsENX8+Gk5VsrWONhoDgUFMQ2l2s9u89gVwRGK8O0VR4kcbTn2wYvDPyJX3nBvfhgQ2Ov8r6RKFLLjIT7JQfkFerbxzvtDPQou3ziY0bo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(19092799006)(1800799024)(56012099006)(11063799006)(4143699003)(261009223027099003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5rFFP3V9KzskJzI/EqGmrxzGsRBvA0uhAxiCfZV8BcFFuh8onn5nyUWbXrNO?=
 =?us-ascii?Q?E313EPfj3Ai5O4UYjqTSBvyKRyvnEF3w/WLi2ubtgxfnyluG26hKsFLup+as?=
 =?us-ascii?Q?TCyz4y+cPBRgWwd9k7E+OY66z6QECWUAPqnRfDuQF0I0UMwqzw7b4ebU2yfs?=
 =?us-ascii?Q?LhkPi5pgNclnJEzSrJ+hxdJdqB/bt6hYqxTxff37NY3ZmyP0gafW1M5l2Ic2?=
 =?us-ascii?Q?4iQuV7X0cGoNfRi3lYb0VYKIkBoqIvss4TiKcEkH7MyYR5g2IcL2nmsPQYkB?=
 =?us-ascii?Q?wRJDN4JBBzAbbp6be8F0y7qfPj/GbjAmh7Vw026RdnEcm+K2BUz8nrhmyZDK?=
 =?us-ascii?Q?m6c0iCvpnDdZ75/Y5svvcbpFfwCPk32nlNq9+vBahNlvOh+e6X7X84YxYFhC?=
 =?us-ascii?Q?P2prU95cP6iOnB0hxRMd/Z7BhkagK2P60AHizTd0xU5+wrc6FKMYaqcuL5Fs?=
 =?us-ascii?Q?tQd5s7Y0aGVXggfP/F7WSNJP6+He83eLpcnp6Oe3Mj/TjjZng6yILw4aVhH2?=
 =?us-ascii?Q?Cj/dz31g+dqVoLgUC8B7uLHLdCHF9sA8e8v3k9yn1oXFPiT9ohTl3Gils4XH?=
 =?us-ascii?Q?KpngjuaT0NRUaOZQJVwLNm9sv4eoRj0tGl+yUdaZnyRyoWs+fkS4fGC35Nc8?=
 =?us-ascii?Q?KRYXtHPTkkN0Bvg0cQ2d/HP0rNmjpM8ENdgkwjsKvnmtM8f9AMgJWKmWO+vu?=
 =?us-ascii?Q?Ai7Jj0x8ZzltICugwOB88UsovYgD/YuZtcY77gISvw9G3Tas11cHRYpqEl9G?=
 =?us-ascii?Q?oZsGmIvPJnGtOxFpaQV9uRXwYsIBcTzS3YW4k4bnsRs7ipH3hiZbvXaTwhE7?=
 =?us-ascii?Q?/Nag5vE8Abn00LY7vgqM0F2UNNG/b6tZRiFdwVOK2aVMTxmu3AL8/vEbQ1Av?=
 =?us-ascii?Q?Dfc781hDRd96rqlYT78lNg+oWN1wttCoPBY2xwo6vh9JUClhHSyis2YlHvLc?=
 =?us-ascii?Q?alnQYSbvuvvOsasMCO+fI9zJauWc/not3RK3ySXJQ10xno3ht2ZzvKtX6Xwe?=
 =?us-ascii?Q?GGHbWOjZREvRTls/JvzdVQDO/qyBFqKXX+NNYMBx0c55ZqEFZojrPkYowB47?=
 =?us-ascii?Q?/DKIhy+9pBWUeePuEkXiSiSGfcyFKiaM7YfLJ/L9fjsREIVMlQfRWym5w3n8?=
 =?us-ascii?Q?eRgGElpUvoEmk55HFAq3XvpE9DzhaG7CBBnwIpLITRjj1n/AMRSPJEZTF3c3?=
 =?us-ascii?Q?VVJy41XJgTYiNp4dig4f/00LqHRjgjmOvXNunvbQbqDAfvCX372pBfosNMeY?=
 =?us-ascii?Q?O/3pvkHl3ajz3emox6vbUvFMTxMv3gB0XFXi2UnxB2yLRBqCXNrUnKLRDKX8?=
 =?us-ascii?Q?RyJ70UJVkA7p8fDr48f6uBLSS0iu7r0vEcUV1pdyCkELlyVjNxriDeDcMzbH?=
 =?us-ascii?Q?OqntNLDDnNrANZwbh0MooUY8Hbs12KX9loH8wQGLJFX2OeID7fNm6X8jKkKk?=
 =?us-ascii?Q?OaJ/TdfVcoK3cJyM7sO3/9/4HZ3K5X+1GhkA+7N/sVwVpvnOsQWf7wM7Q7+V?=
 =?us-ascii?Q?KN1KwYAuMDcsm7VdzWFZByRu1/BY8w7+u64lgcLpifolPcKSVOaWDiPgFnUX?=
 =?us-ascii?Q?PjYqoxvIQd93A3A2RZ8QNkgQ+UPJHRVF8e0m0r09EvbQ7/P2D7SXQ7DnUWts?=
 =?us-ascii?Q?B+li155WB/vt8jKsdrZVhae0XHTgsMVaZREUUoaV0NSVY7zuf1XjkO8HNRE1?=
 =?us-ascii?Q?D8lyu55u8I4WvfMorWhjFzpY6C33mrIm4ltv94ywLsEbq81vPhD8QAaM/LtF?=
 =?us-ascii?Q?u+fsnT/50mPKRPBuYhX1sW+jCJxQQVjiTJHfDUTQmq6XKzub6Toq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72583b50-34a4-439d-622e-08df2f8613f8
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 15:15:01.9213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6OwZLnCrD8Q1BrwQK8kL2TxY+h5uR738koIOFZ7tyaIj/TuE2+vIow5ESuHbjD1RC6Z3qmCuNbueK8aCbRMn1GVIR7SDOKWAxfX92QYMmkCU8HOOIeaZLUPKSmB4rra
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUYPR04MB12692

On Wed, Oct 21, 2026 at 11:43:40AM +0530, Manikanta Maddireddy wrote:
> devm_gpiod_get_optional() returns NULL only when the optional GPIO is
> absent. Other error pointers, including -EPROBE_DEFER, describe real
> failures and should not be converted to NULL.
>
> Return dev_err_probe() errors for nvidia,refclk-select so probe does not
> continue without a GPIO that exists but is not ready or could not be
> requested.
>
> Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes V1 -> V2: None
>
>  drivers/pci/controller/dwc/pcie-tegra194.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 9b349b3430f1..6104a22d930e 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1206,18 +1206,9 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
>  	pcie->pex_refclk_sel_gpiod = devm_gpiod_get_optional(pcie->dev,
>  							     "nvidia,refclk-select",
>  							     GPIOD_OUT_HIGH);
> -	if (IS_ERR(pcie->pex_refclk_sel_gpiod)) {
> -		int err = PTR_ERR(pcie->pex_refclk_sel_gpiod);
> -		const char *level = KERN_ERR;
> -
> -		if (err == -EPROBE_DEFER)
> -			level = KERN_DEBUG;
> -
> -		dev_printk(level, pcie->dev,
> -			   dev_fmt("Failed to get REFCLK select GPIOs: %d\n"),
> -			   err);
> -		pcie->pex_refclk_sel_gpiod = NULL;
> -	}
> +	if (IS_ERR(pcie->pex_refclk_sel_gpiod))
> +		return dev_err_probe(pcie->dev, PTR_ERR(pcie->pex_refclk_sel_gpiod),
> +				     "Failed to get REFCLK select GPIO\n");
>
>  	return 0;
>  }
> --
> 2.34.1
>
