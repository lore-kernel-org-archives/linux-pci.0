Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=52.101.228.102
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794286107;
	b=waC5weDGPQNNEjNniocPLShLZOYO9R8zxtgTBPQuPojcW2i7jX0kaBSHzHXQ5tlNwbKZ
	 3H4Jt1CDfucII+XXcUnj/ut7QRvnUQeKfKK7AFSP1q+zHBD5tEN+aiudjgWajVLTBw79A
	 2S9Xx7FXegDFh9TSfb8nikt0CgBfe/44Pfu2bqKwtXmNu0m5gWigqKcRJto86J6g/nVEE
	 5IthVu/tj1ePREb3cILys4UneC7kbtsuR373IPic1M7vaz6RuHBCzqBSzEgWTMgI7IhsA
	 xDYsHEVenN5uCvG9MBaQG3PQVeAub+kb1IaDW217lkMen9jRNvhyhTs4bXMSMeGuiuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286107;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=c1ejmBa5iIhKoGsz/adUpkVCxgtyIkf0/u1cPyQp0q0=;
	b=P8AhQK1PAYpuUOJuSs+YFT3tFU4WvFNq5TuX/4Y1wquiwWZHApQ4xVVnPG7kgsONcWsc
	 dMGGkExo2dgTLAA2jbVXRa9zj6o7knwyw/qOa7vAHyc2JueitS14V6vyOwhTa1UA3UwwJ
	 TUhLC6vKCCG7yGNZ7EuwKNMC12D8frRIlC4qp1dd5HZo4fd/+y11lGxcDS6Lk+3dOyz9l
	 uaoX24RH3iPz6NTZrdfXp7wkxvIOoH6VrThVQ6mZz/cz9nPCyl+Z8hZrK2zQ9hyqYm3OB
	 qcD+Hx5I+YCMdO8A9MiqxKP8NtG4owE9eVF8VPzLFQ0qnCS9ZY273sPZ8DblUD41beA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=fail reason="signature verification failed" header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=Mml0Ax9D;
	arc=fail smtp.remote-ip=52.101.228.102
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020102.outbound.protection.outlook.com [52.101.228.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5B1606A31C
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 04:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E5B1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=Mml0Ax9D
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnkHRdEzJO6Ck5HegpYH/reNKehkPkY8ghLD1szkhDaPTkYIol0aa7v1sf+FCYXUDCTzQw2C3fulG4TpYj4J4Auf0y2X4UuIEd3WYsRNgDwFBkzBDmau1ADSIwpHg5Ul+EYOusPZPN2BPhCfFE7nRLCC8/2vOi+8m8XnjxLjVhUyRhlcbojAYq49RZpNE1m8yo4dw057k3xoV6J9KLE9i228iM5MRsiR4ph19gSMSf6J0KWLMhEBaUq3nP56UsOch1S9iwkU1Lqv8GS/yr65oPQl9bprpc8QcBRW3VO2yoslrz7SI7DKuTG5wMqd2XiVTZsZOTNBRl4sMklkvmbRmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5VrvDB60lHxCcq+rwFkI3BHDQ20tYmLlZz8Lc2u/Ig=;
 b=A39PcS0P37GdXQOmHgw9jRG2IUTzdyT+csyWYh8ce5F8B+XDRzoEmbGVchkgbCEAqPMk2ibuyXuwbm92XUFZEVLh2kLj8nmYA+XzgHeN8A+p3h3NJsF8Dd9b1uZTlu2Xsx5DZ+9Ia0zAC4BBnwfGtcw1Ciu+TZK7BZsitKKhrKcgl7jWbQHlA7kp947BI9Tt9mY5SC1MTRmPd8P83Jz0qF3imP/wZr26vGfdfFWRnVma4wGC+x//IMhhLWzceM/e79tLcimgDCgIDHzLty1x+PH8kG6gfQW32iVYqWtgrQYrd8PyZ/0wEsM/NLmqoCsBAPgsCvdYgOZcp1OY9+6P+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5VrvDB60lHxCcq+rwFkI3BHDQ20tYmLlZz8Lc2u/Ig=;
 b=Mml0Ax9Dn4MzP7lPRMWIIj4+6mydd1lpUK+Yj2WDkTj9jj5yV4LKYSKdaW+EPGt/GDJdgQuD8Ljc3jiw48ih1mPvIrvJqfOoP06MqbW+7BUV7PIJeDWwiF1MMyeIRNf1umPydUVqorZ9otbFRMeoODZJlS3H6aFBdVESj9JwVrQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS3P286MB1591.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:160::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 04:48:24 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 04:48:23 +0000
Date: Tue, 10 Nov 2026 13:48:22 +0900
From: Koichiro Den <den@valinux.co.jp>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v8 05/10] PCI: endpoint: pci-epf-vntb: Export endpoint
 DMA channels
Message-ID: <y346l5tlv2abdjvjqbqitmi7xmi46trm2dvmbgihlbieal4hz7@rc2dcugxd5aq>
References: <20261022082230.3164834-1-den@valinux.co.jp>
 <20261022082230.3164834-6-den@valinux.co.jp>
 <sashiko-outbox-181210@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-181210@kernel.org>
X-ClientProxiedBy: TYCPR01CA0197.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::10) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS3P286MB1591:EE_
X-MS-Office365-Filtering-Correlation-Id: a2ed7b6d-21dd-4841-afee-08df3ee5d9f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|23010399003|4143699003|56012099006|261022105027099003|261021121427099003|261026121527099003|261026135527099003|10067099003|261026140227099003|261102130727099003|261028144727099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	D3b7AVdxti+5Fmfht72ffACIJP86g4ifQ7rtGPIPvGNiF/wQIVUqLomNwKpiJmos8Wmdj7KCEYWS1QliQ1SOHBYsb7Qt8FnBC+7fVYiC5tah705G+47erIay+1SH2CqGc360u3RpqFwma5HdsjoAM1yZwlkE9rWrillZmRXspNfltDkg+ks0fygm7KUCBnXukMIvPL1eiwJPJG48MzABZa+4BcdPjXEwT9J4satwIFrfdERpOtrlDGVvYu3+Tn/bZpsk7Y5xsw+0S1TeVGk+oijIzPOmUNUqWuHpnqatgmSRWKz/ac2n3DAvJZfF02SUiUfAUwODPGwHbtJAGSmuiYe/UAVDv0IuQ0P/mvMI0We6oIZ84Mzg3HqwhAvWKE2eF6jR6vV+19+TdedR0ZWU1S+RbRwuK732AHxZHb3jkeaYhiCys+b6XW9CN5C0TFVkl1vcEXDF3xzh9HVFe8pz03tn7wRULR+DkaKyLfJrsDgpFjQZxIdG5FsBpOAdGmSIvnHS1V0WIU177zQhi51wp1AySjgdQc6KFtBV3jqAwQX2ESo+fxNjrMFoR5octApmGfi8c2oARpdKaXZS316bmOes8midCpJKnhMjhi9EjVQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(23010399003)(4143699003)(56012099006)(261022105027099003)(261021121427099003)(261026121527099003)(261026135527099003)(10067099003)(261026140227099003)(261102130727099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?C6rGZBw1RnoKrxeQq4KXZy4u0db7voWgD04H1jUT1nFZcxq+tP09uvfYPF?=
 =?iso-8859-1?Q?x0XssGOPfoCZ62InhtQf8aUwT+Pxy9ko2I2YKvZEY5AVo5LYYE/hfZ0BfA?=
 =?iso-8859-1?Q?wI8Df0oTJitzi90RaxcrveqfnVnJduzLb12bFPUvcm3iVTJ0Vo2rnyXDJz?=
 =?iso-8859-1?Q?nPvwLKAGaPv1bZ2T0muJgkYNaqGLnAT3C2QFVqKmGGUnqtaxg9KlevhHXJ?=
 =?iso-8859-1?Q?lxKzrtVOZ7wvaCsTOeKyqgixxaJKn7MN6kPNbG7mGS4AyO8bIxXHLzaUOY?=
 =?iso-8859-1?Q?tcfQsip3Yn36VzpkGRgBFkfGdL6Wy1bj0TC9RjQYRhP2iFZpi4AOtly2H8?=
 =?iso-8859-1?Q?U5TwAzfiidbobTaR2kHpm7NGr8fU8qYAVTfqosVYGsSXke00I7kMO1Kfyb?=
 =?iso-8859-1?Q?WsZ2AMT7NnHm5uscziza2s49hq2Kh+Frl8Jn6s4+SVNTLsvuxVegquObMn?=
 =?iso-8859-1?Q?vBPF5ZhWt3mSI1ElyZGuI2TLXpclOe8cnyz1Kltg5TBAOaUkcygWIuC7dx?=
 =?iso-8859-1?Q?+i/SYjY7T8lok2TEMF/6FbY4tdB66HU2itmt7iLLKWwWsn+ZM75qcptcHO?=
 =?iso-8859-1?Q?BjHAdCEAZEy6I1rhBKtdJUj1EVseLRbVHSpjuZ7wHYfG7bjYMySoIGwhuq?=
 =?iso-8859-1?Q?Ufo800YZOjgEcSmdvh5Cbqs9zuQYFP9fqCCbd2/pcbz6G/eZlNiCJKVGVb?=
 =?iso-8859-1?Q?gat0AtCqXsrZikjzlY4Z8P0LAMOT3dt2WyNzIk5t9FAgmuJJTKwMA7TWFj?=
 =?iso-8859-1?Q?IUMc9XV6SQ2T6UiQOKdOlDMl2HZzD0Pt7XSf5NWt+9m5pip8BIJbs1hHQE?=
 =?iso-8859-1?Q?K7isqAJTOVApdxnPl7I2UYzcHOGlmP/jAKlamkl8FUqZGtq5JZOdUA18k2?=
 =?iso-8859-1?Q?gsaRG3MKhDl4OkpC2ld0el/KPH5pPK3he/1x+2jz6+UNZibdMS4guHxwAD?=
 =?iso-8859-1?Q?/4/UsiXHMlDywgUCdLfnB4ikzkqCdg3EyQorVBUJMpzDvkJqy2HQT5ehTG?=
 =?iso-8859-1?Q?U+Gp5s6yHWs1DIFG+LIbN0DbAva+5jfOmwdRqT3huKj1bqJ7RG/94D557D?=
 =?iso-8859-1?Q?2vMy9p7e6VfqeToBgGaAqO5cWcsFFvNa3eSEUV6vgXsHa70GhKJR5314CM?=
 =?iso-8859-1?Q?xbuVSqn3E+M3wQOl34++hWl8c11/OQcoYhukTDc64BI8BQjDWmTllaRI5t?=
 =?iso-8859-1?Q?5+GrTmhYUzkp+8NCsfYjkfyezvBM0KOj2NheohyX2YYNhe+P2H9JNxrXRy?=
 =?iso-8859-1?Q?484pXNzyke+i9u964ggr18vMxwVENgOMivaGotq6h+eNQ9jlp48+C+tFd+?=
 =?iso-8859-1?Q?RRxigSEUvB3q5JHxCxyQvzh61NLgAUE0rC7R/nUn1a9bTQlW/zQyj+SVGk?=
 =?iso-8859-1?Q?/X9OuESf459dmUaoBotr7MmU6TFIZtXMKO1NyTsFGX4lH75kIET3OCi4Fd?=
 =?iso-8859-1?Q?USjblCtXB0rYh8akSry3K3LV4WLdXx4PlPerbD1iytFUUwTkP0+zKoEEf3?=
 =?iso-8859-1?Q?3QboUcWHUThjsBUjk6gK2yrpiHlGUquvgSWdVG2aPGagr3zFDlFQoEFU5c?=
 =?iso-8859-1?Q?criS2jVAKrri6CMvUiVHX+AfW79bbOZ/KN2LRJqVTrFlysvLERcmvRpEt0?=
 =?iso-8859-1?Q?6gaPIT7OlNry5A00bNSXiAsT1OIk6TqNiFAYbKhAXRGXq1JNI+rLjsE/gz?=
 =?iso-8859-1?Q?lFRcks0snYZgoDyof02uhXRfXwy8bI5K0IOvS6Dba8lfQ/hechc/MLDejZ?=
 =?iso-8859-1?Q?02Rl+FHqvFmDf3R8M+6iiYI6qXeIzIjBYYCepjwHI0RRL9nvIMfe7Zk5fB?=
 =?iso-8859-1?Q?vsPV7vcOX2WkoFbORuqZQf4bJ3sVBu5pAyIK3f8T7F07jBH4+I4k?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ed7b6d-21dd-4841-afee-08df3ee5d9f7
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 04:48:23.6151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pvY0Obs6cSUM6kGZB99aHlh2N0ypFqBUPYYehe83SjksYkpboZ+A2WDt7oRRYMxMMe1HJW7TywQUcdB3wm+YiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1591

On Thu, Oct 22, 2026 at 08:53:00AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] PCI: endpoint: pci-epf-vntb: epf_ntb_dma_set_bar() returns 0 when DMA is disabled
> --
> 
> commit 2da1c2a8d12099e9d914603258e8edaefa818fbc
> Author: Koichiro Den <den@valinux.co.jp>
> 
> PCI: endpoint: pci-epf-vntb: Export endpoint DMA channels
> 
> This commit adds support for exporting endpoint-local eDMA read channels to
> the root complex through a configurable dma_bar configfs attribute and a
> control-region extension in pci-epf-vntb.
> 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index 3adbaa9d85db2..ac83af54122f7 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> 
> [ ... ]
> 
> > +static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
> > +{
> > +	struct pci_epf_bar_submap *old_submap;
> > +	struct epf_ntb_dma *dma = ntb->dma;
> > +	unsigned int old_num_submap;
> > +	struct pci_epf_bar *bar;
> > +	int restore, ret;
> > +
> > +	if (!dma)
> > +		return 0;
                       ^^(a)
> > +
> > +	bar = &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
> > +
> > +	old_submap = bar->submap;
> > +	old_num_submap = bar->num_submap;
> > +	bar->submap = dma->submap;
> > +	bar->num_submap = dma->num_submap;
> > +
> > +	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
> > +			      ntb->epf->vfunc_no, bar);
> > +	if (!ret)
> > +		return 0;
> > +
> > +	/* A failed dynamic update may have already removed the old mapping. */
> > +	bar->submap = old_submap;
> > +	bar->num_submap = old_num_submap;
> > +	restore = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
> > +				  ntb->epf->vfunc_no, bar);
> > +	if (restore)
> > +		dev_warn(&ntb->epf->dev,
> > +			 "failed to restore DMA BAR mapping: %d\n", restore);
> > +
> > +	return ret;
> > +}
> > +
> >  /**
> >   * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
> >   *   to access the memory window of HOST
> > @@ -342,6 +774,11 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
> >  		epf_ntb_teardown_mw(ntb, argument);
> >  		ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
> >  		break;
> > +	case EPF_NTB_COMMAND_SETUP_DMA_BAR:
> > +		ret = epf_ntb_dma_set_bar(ntb);
> > +		ctrl->command_status = ret ? EPF_NTB_COMMAND_STATUS_ERROR :
> > +					     EPF_NTB_COMMAND_STATUS_OK;
> > +		break;
> 
> [Severity: Medium]
> When dma_bar is left unassigned (NO_BAR), epf_ntb_dma_collect() returns 0
> without allocating ntb->dma, leaving ntb->dma as NULL.
> 
> If the peer subsequently writes EPF_NTB_COMMAND_SETUP_DMA_BAR to
> ctrl->command, epf_ntb_cmd_handler() calls epf_ntb_dma_set_bar(ntb), which
> checks if (!dma) and returns 0. epf_ntb_cmd_handler() then sets
> ctrl->command_status to EPF_NTB_COMMAND_STATUS_OK even though DMA export is
> disabled and no DMA BAR or subrange mapping was configured.
> 
> Should epf_ntb_dma_set_bar() in drivers/pci/endpoint/functions/pci-epf-vntb.c
> return a negative error code (such as -EINVAL or -EOPNOTSUPP) when ntb->dma
> is NULL so that ctrl->command_status is set to EPF_NTB_COMMAND_STATUS_ERROR?
> 
> >  	case EPF_NTB_COMMAND_LINK_UP:
> >  		ret = epf_ntb_set_link_enabled(ntb, true);
> >  		if (ret < 0)

Thanks for the catch. Will change the return value at (a) to -EOPNOTSUPP in v9.

Best regards,
Koichiro Den

> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261022082230.3164834-1-den@valinux.co.jp?part=5
