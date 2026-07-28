Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011056.outbound.protection.outlook.com [52.101.65.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F5E3CF69C;
	Tue, 28 Jul 2026 20:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785269118; cv=fail; b=VQFme2c5OV1aZwGsR/KL6MIwy2INkrvnoxv9eCXYJA5FopkZEiu+CYIENW8Na17amLnwefEb2Vod5e/lpfTxqGeA6sux/zZ6Je1zSI/emENFq+1u/vURu+zaYlrgqWlbQ7ZvLMtBMN9kNgkQ7Qf77q31hKlDvMBQVMw46Oi/2B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785269118; c=relaxed/simple;
	bh=Fqy3TgdkPTkI4juF51AjB0kHebjsNNqZkTxpWgKkwMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s5QBLuXEIsT2mRcujPafSJJgsJMqPHhBmCxZMP4hM+/wblJv+cyvSRQqy0F3N+Yk8pp850PhWjuIDDZ9srQPPYFaHnrV0nJO/KkuMnkePEBDFkS8sL8b2YW34RpA1ILw5qM2CTDyHWKIXvcKAuJefT57WxLelGNt8TbGISo1zOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=rt+kR8Q9; arc=fail smtp.client-ip=52.101.65.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rt+kR8Q9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XaIjxAN+gB9FunLE8SmZGANl7ZcLPV1gchbNdSVjlKee7Ki+hkme0aGLCoJiRWvxoAB0hAPHPi4mqXd3LEx1MK/CPizxIzs6XsAlakd6RENX9/rnZwf28a1upoXqk0la/opJO0UfyDyUn/QwBa+C8dyMd44VEyqa3p3Dand6KLNBwGzgxgVRQYDgQJTVlenpassPE+4g8sVtd3t06FZuBetEdTg8NzzIAs08WZhMJ6+6MUyBJ/Fx7Ltt7k+HeUXa7wu5+k96g4ZgOoE9q9YUk/7LrKarjejX5OQN/nK7zVTUJNcCr5JnvoaYMudPDXtPSw2MuC+w2sxWsrfb1VkHwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AW5hiPexX6cDqxDxzBwNHKBiNCcQPDW1eqRZZpEUts=;
 b=hDqG2jVbVuUAII2JWjFgNjnBz3SaWm3JJEvGhvXU3FDjCu3UEH2K/Xzw1u9LdKDXmZDVoG0JEL82g8vknj0+Z5avf/hNHw9cUO3wUXfPs2HLA4HJ/EmMEaClBIxofppYDEKvSJrtCJktMyNYPz3RzLrJX4reHM3eLgBWS4TQdNluKdX+uNBQ1Hw5lch6Mqc2V9NjsyePYaWFM++ocpeEsRqwFl+H4KZD2jVomUSxZ1pbW2hq9DGcnndQ0dCFZFgBxDYOjYYKkFWDdj6Koq4c73PXHOd0AI3H34mDcoGWDPElN/GEb4BfS3HHIKgbhaT8EnZpzA+2UJh54MPiJhqDiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AW5hiPexX6cDqxDxzBwNHKBiNCcQPDW1eqRZZpEUts=;
 b=rt+kR8Q9Ji5jxeU8JzSlDm+QNBHl/mJ7oKB+8cmnrzSARFsdHLXr0T7LLw7KlVQ2jjSL0VVzzMjl9DhIE74ejmMr7j75F5CKRfZKhZGxO78vi/lBOHGaIuB6ukdnaFpnosRW9xDgDr281d6Z4qoe915TFSuqtYgnolVEuOFUsd0hVUETqcs+bzR+yBVbbwfSdHmwrQf0Y95ArLJ0dZNSS3SmWqxmUihXgoGFWPrBBUHLroHdiP7Jhpr1+D4SMDsy+HHAFEA+n03bbsWXhNmdUUE6nNcIkuJ46UcIF/L1Pr1WywomHLxk84i+OvS6r+OWNICdo5hF9jg5c+74r+xC6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB8446.eurprd04.prod.outlook.com (2603:10a6:10:2ce::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 20:05:13 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 20:05:13 +0000
Date: Tue, 28 Jul 2026 16:05:06 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: alexandre.belloni@bootlin.com, Frank.Li@nxp.com, rafael@kernel.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V2 5/8] i3c: master: Reject IBI requests from
 non-IBI-capable devices
Message-ID: <amkLch5Du53mgWNp@lizhi-Precision-Tower-5810>
References: <20260728155308.142713-1-adrian.hunter@intel.com>
 <20260728155308.142713-6-adrian.hunter@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728155308.142713-6-adrian.hunter@intel.com>
X-ClientProxiedBy: SA1PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::19) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB8446:EE_
X-MS-Office365-Filtering-Correlation-Id: 32f9cac3-3327-4107-3419-08deece388e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|23010399003|366016|1800799024|18002099003|22082099003|56012099006|4143699003|5023799004|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	9D+okC59Tj1l56oZ2VkN4f/PDT4VCC21HEH6f/VXmQaLgdDShrO6vt80kg6OqlRwjlT/ZBrubUkBVcQUlN3V1WolxaGEHo7BS1971KknJj/kiMkteOyGDactmM1OwnRMGvTUfh+5BMzA9MFQV6d/1viBXRxSL/C+FSu37K+2eofG5M9Zf7ICGpbI+oq3JEqkH5rpQ2nO5ADj2eAc7+yV8i2jHPaXIO0bmGYeTMNoE2JMhCYhKH1sbIHoGUsMpZNxlAKEVImHoo+sSFfl1GZQekyWQJuns8+/pfQ4O5niXsNpF8frA+WeCxaOTBtgaWJTVEuutLbIqFwhEARvWLGUPVvLvs9gAZ3pKv05EgW16Gv9zbNvg4yNuAFVpbOLtv8iElAw32MGxenaTjk9O+x6uW4aTdMJJzNb+DRg89LDfvfTdmFfz4xwpONkKj+aKts5rZjjUU0b4UvDymeKCuz1qLViL5NHsdbvk/dyb0+JaI8mtEOFeqsuZy3xPlsEM7v4hPzdukA4MwmklhMsFWKlil8lgq5uKm0pRpSS/82vXNDIYcMACJGP7opPGe9E04f7xQkZcorqq2/vqkl0Wi+7kYay76YETRZyxRNjPnekfnG73/bGjnSJ4lKlFKK/rlyxVSwVmu4PO7igV/7UnyQfV/2AkOJX0EFCr4t862A0Poc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(56012099006)(4143699003)(5023799004)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R3WZrAyXMT8rRVX8cNgho+MHc3WVhS2osUJEhthZ3528sqrqPRehou3vC8I+?=
 =?us-ascii?Q?GP/C89cBlR1M3xRIRCDqwP+e+TaDevzUYVtrTvpDnOIohyUM7lTB18ijwWtl?=
 =?us-ascii?Q?05vmhhrXGLrfm34iB84HlM3ahFofl12IV6nyqwD2R5uH1tMgVzuRmFvVK/JD?=
 =?us-ascii?Q?PSDnADcoXf90lpqyaoZDUMLeykY+MM3T2IDSqHN9Yhs0SvWdvPYCf0ol6MK4?=
 =?us-ascii?Q?5FJIcG21M1VG6X1KBbNMUKaFH9Be5VnrY0ZjQVZyCFe3w7Hfz8Zq8vVv2ay5?=
 =?us-ascii?Q?8NzkZLc7yURhZf4PZLQU+VIGb42PCMSF67AOmH8KJZdXFatZAoA3WYbaamM7?=
 =?us-ascii?Q?OHwWtoI4X+WfM3zrW6mS3FuwGJjdS55M/JlLOsAq6c8DrByT+IZDT5IxtnpT?=
 =?us-ascii?Q?Qc6icSEDMRfnGndO1bcH7htg8QI7Lno8d0/VQQXpaX/69PcHH6Uyj01autni?=
 =?us-ascii?Q?GjPnUlvB6FFFjNDImbLN5r4aUtNO/Bb4gPzJQm0n4aUuozfY2OThz2FHVi8d?=
 =?us-ascii?Q?zKhR21oh88efI1UUQptoT6S7Nb11HGskSbrb/f28Y5YkyoAke2xCc4O3UskV?=
 =?us-ascii?Q?xCyKXOdQdHOz/7joOW6VnQ5GCvAInnqRaUzeSmC1k/s2POnpJoMZb/x4cGOi?=
 =?us-ascii?Q?7pjU0xPi27Kuv9APqp3veN1P4IxGaVkbHklANekvrChFAr0EjcYh0g17g8xw?=
 =?us-ascii?Q?UbVpZFIw2pJROyu+w7MXBbO0RPnyEty1BfnzaQ9lHrshvOCdZP5fk8jv4clt?=
 =?us-ascii?Q?pwFRnOE8h3LEUp0RycoGZOYdT9FAaFtBhktyqqK6QUoSvftVtf8D69xi/hrD?=
 =?us-ascii?Q?GsCHJHOToEXNbj7xzfebTST8okXnls7mDCnj+K2GCY+nOOSHke2ht0sbYULi?=
 =?us-ascii?Q?VW3nIssE2k8jkRtem0IAY9stoy2rmHW9ufYm48smxZQyhvpCDKMy15L4hs05?=
 =?us-ascii?Q?Ku3gePNjpGChWhrXgW1w5sl5bEORBEB/+ko33RFSNsbUVDZNQVL0tmTAASpt?=
 =?us-ascii?Q?kWl3pIaL2HWUZ5RbL52OHWbWgfW8gr5jBWKtJMpoeb8FywSaMVs+nr8mO9Ot?=
 =?us-ascii?Q?MwOxMG2lOpOpW0XjYL/5oJ87KkhULNdYkBpdlgwMrGsOZN6ryA949yyDQI50?=
 =?us-ascii?Q?QiDpFj2OyivYiDZNmRNdb1VyLq6i/rXRYBwmfo9i5eAW4eX1xyroCe6gZzvf?=
 =?us-ascii?Q?8U+yr+mZOIKrx5MFMSe/C54aw55g9PqbDE6hqc1wsxXvS2ECOfIBckkbI0+b?=
 =?us-ascii?Q?bpvsBMh9x2l1eQXoCNv8QKx2SYNRzXu/2AYwVS0f3sQaXFzG2MOIt+ts00kJ?=
 =?us-ascii?Q?pkr1nerhJkupSqsoloOVxr+G5LUHTFDWfLh18XDxvY2pK97XMLAfUrV1Nn/I?=
 =?us-ascii?Q?JACZY3KyJSHV2o9VeKO9Wc9SZQAL8gFH0PDsujMWxxo3D+mO6xqJpA7v5Plo?=
 =?us-ascii?Q?rlTXXvacKrDBVx755JrtuoCQcq6ewlpyh5dPshWEcczVi6Ltf8Bsh7vlbrNN?=
 =?us-ascii?Q?0U4mxVMBhpPNFVh1Vvb4WDzlU3yKkYueMwyj2lS+nCq+MvllKCOQYDiiNEWD?=
 =?us-ascii?Q?E63CGnrt4rwkZyirj7xkbEt3mK3vEllBOiAZvQl0rhP1EXOANT7Ad/7qhFTz?=
 =?us-ascii?Q?Nx7EJtcsAumG3qTTEQm/YHCXxhqfB+Kq9T51U6SCEwDElV0WczLhvFcOazP/?=
 =?us-ascii?Q?t2W7d45X32FxnX5GeC1TVnHkOdpAqh20wBgewd7fell+Robib0G4XnyYayWe?=
 =?us-ascii?Q?E1mefNlgUHNgOEdgGKRDMObp8lBKQmDYBvpkAy1/xHFL7wbyOULf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f9cac3-3327-4107-3419-08deece388e1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 20:05:13.3161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nyd5Rzo5DgBeZLlbmx1edE/YC0W2BaI8zF295i9w862cRSCDYZmbrhhK2CuTBtv5avpg/OdCLsmOk+wOWjcjsObrHnQ4zvH++AkATfX2QqRAXmUKpkXIQOA7/DQYvKr3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8446

On Tue, Jul 28, 2026 at 06:53:05PM +0300, Adrian Hunter wrote:
> i3c_device_request_ibi() does not verify that a device advertises IBI
> support before attempting to set up IBI handling.
>
> Add a check for I3C_BCR_IBI_REQ_CAP and fail with -EOPNOTSUPP when IBI
> support is not reported by the device.  This keeps IBI setup consistent
> with other IBI-related functionality, such as exposing wakeup capability
> only for IBI-capable devices.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
>
> Changes in V2:
>
> 	None
>
>
>  drivers/i3c/device.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
> index 101eaa77de68..307ca6dc04ca 100644
> --- a/drivers/i3c/device.c
> +++ b/drivers/i3c/device.c
> @@ -205,12 +205,14 @@ int i3c_device_request_ibi(struct i3c_device *dev,
>  		return ret;
>
>  	i3c_bus_normaluse_lock(dev->bus);
> -	if (dev->desc) {
> +	if (!dev->desc) {
> +		ret = -ENOENT;
> +	} else if (!(dev->desc->info.bcr & I3C_BCR_IBI_REQ_CAP)) {
> +		ret = -EOPNOTSUPP;
> +	} else {
>  		mutex_lock(&dev->desc->ibi_lock);
>  		ret = i3c_dev_request_ibi_locked(dev->desc, req);
>  		mutex_unlock(&dev->desc->ibi_lock);
> -	} else {
> -		ret = -ENOENT;
>  	}
>  	i3c_bus_normaluse_unlock(dev->bus);
>
> --
> 2.53.0
>
