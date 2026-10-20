Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.109
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792503986;
	b=SZlBg/J95fnhbv8XF9h6EYRvGbPdCo48JSOnxu/tD2mNr8VpEuTaIdZPrB1ABNUzwZJY
	 gMJtfUJwybsRq2fQBTZJLBopU0tDux2SwpE4enEsbxbUpelPbdQgkXb5LHnqiKOV4AZbp
	 6moZcw9qA2etm11eVsJPLNce9XiXHCeYmfX/FtEya3Ud3hDDHw4oYl2CR6aXg/Aqmzsb3
	 81aRLV0qiaU5vc3mexmxhLc34srbombr74DCzUCmSuwkXHOgEq3OuXwZGljcQqI/nmApY
	 gItUdzQj5Ve5G184zNA04alUiJRJoscsEDmgB5x3LdYXlESk+rCpNLBz8Tvf5pW2ogw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503986;
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
	bh=ohxtpPEB0GujAkRh5xWBozRhQNX2xo1JQx/fiZFRbs8=;
	b=CXULsm4bbFR5VnqLk7MxKFHeR3XkD9db8N2ux95H3BdqUv3fTjpkcXYWIsm1nIY1HGR7
	 7B+5ZbRxwFEl5D5jXzIKHTLZS4y4PCn2I/uEKBg+Uf3PSNSjbY9KTOsyFOW9DqbBDUls4
	 2JpRAgwWbLZhc0Dt2FOmGwxG13r3dTrQSFsFRhcc/oltxChSBPmbBj72lv0ljzAdgQBNA
	 rIT/6hlnmpGEwX/Awu7ZRUjiHJaSMAZpNbYKTPMfnYz4t+MhWdM3JbRWd+0mhdRCdgqEe
	 8wyI5R2sV+VImUV/7s68NZJRoh2G9Obhnjyqet0mx1vNA0n+qbrnGSBN4oaX0XAr6jA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=MoVWrOtD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.109
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020109.outbound.protection.outlook.com [52.101.228.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B492606AB36;
	Tue, 20 Oct 2026 13:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B492606AB36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=MoVWrOtD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ABZEV5+APAUxBI0OJWw+hMYvPeRhRZtOTvCFUwRC2Hlfgr4rYCYvr5W4++7ZsShghrEcRvpw73IKOVh7wzbt/DxZNDMKo3j87nqcswQRqfQvRGyH9gqfR5Bl1DOOWxbEFQXpS8LFXfrM1jC9d7LyN4iSW7srSotJsPsuEdE3648mCwPvcIpbj848n5g4gmP1ty2ycp3amyHqIaGiuwAKFPjkGuxTNz2IiazuO+6iyPje0dnE6Oy0mOJQaaaJuV1OAi7m7LxJtZTAped+mY2P8h6+uSAgawWvxKyF+s9vxyC2XUGBHiIITSV4MQop65yVuyx60DIpUICS2TARr+PH9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohxtpPEB0GujAkRh5xWBozRhQNX2xo1JQx/fiZFRbs8=;
 b=im0nXGx1Oqds2M/B5etpiXpmIYFvlnHik/9KcOs8GGvlFktyZAISnJT7dcB8KRE3GF8zMXFMKEr0bB2CbTwhk5/GqLrLccUAa2Vgh5V2ym4+L7BgPexnb2S0hoqfOWKIKzVZNsFT0aUmQJF1zHgUQTjyHs5AFx8bMYssS6UVoEjfSp3sO6sdQ0jWzSKe4IGmrbjYz3qleoPLljH7xjAWlSIyi3FsAaqdssuUCKy7i2IsVQTSWfc4t97Kn853+wL+3q7JqDuGdILgcaQ67TTy1EKCASB6V0n14cV0O19pVdbYU1NWqKdm9YV8Vfpg1qnRyDrZSZDb977yRMchWwQdrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohxtpPEB0GujAkRh5xWBozRhQNX2xo1JQx/fiZFRbs8=;
 b=MoVWrOtD411A0GbuiiHZwDBrS/8QFk1eFFAZdCMs+lRF4V/duK70EiAjowAwkqq/XwdTj3QDJNcbS9X0QRvzFE8JwSd5nFE2GOgeFdYgXc9Mco82Fz7LDjU9sxdUfe+sxe2e0PZJTWMDZTDicJCZb3YyngYTYUGMIfssorykaco=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB5194.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:34c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 13:45:22 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 13:45:22 +0000
Date: Tue, 20 Oct 2026 22:45:21 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Shawn Lin <Shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/17] PCI: dwc: Free the MSI domain after the host
 .deinit() callback
Message-ID: <aqjnpvg6mupkoyl5ripnwd4togg6wktbui2cp7yjpjcuv5r2lw@t7blhltn7242>
References: <20261020031049.969895-1-den@valinux.co.jp>
 <20261020031049.969895-11-den@valinux.co.jp>
 <CAMuHMdV2wTNjaT3HacNiAAwSNU9MtvXqdFg6uSk-pZUBh+9tXQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdV2wTNjaT3HacNiAAwSNU9MtvXqdFg6uSk-pZUBh+9tXQ@mail.gmail.com>
X-ClientProxiedBy: TYCP301CA0017.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::8) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB5194:EE_
X-MS-Office365-Filtering-Correlation-Id: b3e4006c-323b-4701-03bf-08df2eb06311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|23010399003|7416014|376014|22082099003|18002099003|10067099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	3BIEdhQJv6UgZ2Njvlk2/P9BxfIaWcSOfNJTL4Dp08+5hT5ir2NHG+dUaiVSp5dLCTchsDgo9SOAr4nhXpHoszcctIVJn7wLUE6bH1u/z4CwVZIFpiadBSRjV6OEgOzd3Tiap/JLfDKgKZXyP/KL77/AAVaqUlkH8FVIzAqLEvxidYF/GNN/Ztr7hdzWdk+JyWO3teGNu4vKs/dMixnxmmWfPoJEMl+iBI+du2WdOSCjRYx/kPTFXXbqAX738wnm+RnNszXCpm85XLG0oz7sHA6uz88JzgWb7ZCajYVtlcNTiz3reqLgmwK10JS0Ddo+B+pAQsjFLhFu9eVMdfYOrCevvtm/ZNxYQPOTCk6G6sf0wT+lp6RWw0hy0xw4Z0PZFBVUHT4bhifIidQPLncsIsF0ZDuHBUyCHc3WiNfkTpoCnD5Gn4dET4eTIoAzALwmtSleM3wJryIdgjf+MpdssMr+oPgJEIfymxbRerLuDuLmQXTHXf1fCQnfyqwQ3YrDviMi0F9PU9Elyd9sMpTPHNuGaZt+x07UfO3j69ZbVfCtxy0kKoFVqPNxoz9Xq8MjyUUXhwq0w7hthA6p/ADDHAPcl0Q/4Lgyuxfn1AI23ajCDTy4HwcW+XJ6mHrtgnC9RLokPYNriZ4E+LEkmxrZs9/fKYkiQl2hVy2lyS1GAFM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(23010399003)(7416014)(376014)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zQusJKiK8d6ic5FDc+NVCbOmwV7gt/L7K3xdYskj/MFYy2A4DZ2fqVHqTxTO?=
 =?us-ascii?Q?i1hdfc4gMDkLB0+Onv0DS3g0234Thqhg/bwGyOZKj3GwayIPRPP8BwSSDHIV?=
 =?us-ascii?Q?tVcmTSo+es5/K+fEaQywo/Sshuz+i0OqcW9UiiucBXeIrNHrBUUkN6XTF+Y0?=
 =?us-ascii?Q?Xi4qUruNonp5xcjIsr4EHqI8ynNkDJ91aLmHCCBC14mN3iyVWa/6Jr6//tQn?=
 =?us-ascii?Q?LHX4qXE0UDTAeKorIX3DrxDVi3qvWU6ll7iz4FC5kEUkpZVt68u6Gn2sSNIg?=
 =?us-ascii?Q?68YkwpZjUcENRSFC9n5nko0yUwe9Udhlxs0syLwZNmiQIBwOR/j/HNeVOyhU?=
 =?us-ascii?Q?/cZeU3NzXnkqBScOJUsBgmJa+OSBsnwszg3S3arjfWu+kOPirhNB0YTWy1qP?=
 =?us-ascii?Q?VvVHygvXNqRZ5Y88z91N0Ibh5iVqJ8qYE53+52wnE5oyZUtOoroJKI96j9rs?=
 =?us-ascii?Q?2KSvRPXSzduCKa+QKQiFduxdFvSGk/JPYxx3Ls8NoOuyaIpFZAwu2Ub4xZPt?=
 =?us-ascii?Q?Cg/kmPUknE51Bg6ZSXxNlEdHunnB+nJSo/LAri76wH+y61j+DSd9jYCHgCtI?=
 =?us-ascii?Q?PRQYd2hiIi+CUCosHKR7KVLOwDz4iPwJ+eOeHELUTONMnGia/Abyn4uKFIfi?=
 =?us-ascii?Q?BSolbaUBNDcLo10lxb2wj6xVsiicY/etpfVLtBsbbXGV19nNUXblDO97WunW?=
 =?us-ascii?Q?8KALp6U8AijqqMqiyzPWo04J3jUrfafPCiqakmIhdhbys+1Fe13Zl9F8V18y?=
 =?us-ascii?Q?bzYXNwhRX241oFHvS5L4fkQ/phnLfNJS3bYKmt/tm1a7Nfi9UzUHBf/W2TJs?=
 =?us-ascii?Q?O4SuW4K8RkIqCaxsX4ObUHssISft9guBLaAyPJ7+TdcT6EJfvnnV46XKBD4Z?=
 =?us-ascii?Q?J0b9SJm30I6F6JUKzp90ImDuathM2VKj3IJPXATjz+C4KR5EOkqG0Bv6+34G?=
 =?us-ascii?Q?ilUHINkuRQuKW+mx2GKnwMN17ov7w7qGWkpPILFisRK/fmklhCovBD4bTJYY?=
 =?us-ascii?Q?fRXUrmhw3ucBG+Bcpm2B4sLagODttHpGcAp5SRE1k8I5EN32KcW3+D8VII2j?=
 =?us-ascii?Q?paVoZmWjVsBp4z4vE0OKRABfDxlEnfEZeIvgT7NCNqFn2Sf6iO4OuGPAEJM7?=
 =?us-ascii?Q?xrkqveYnNR+roN/YSJcxSMQTDjA4DXloMngBZW/oeMp8S6+Hi5rV9LHlbHsm?=
 =?us-ascii?Q?IZnRYj9JJIJPmGY0N5gAxmvZtfLIsuZOWpNRCFIDjurM0JSilE0EA2gUSxR4?=
 =?us-ascii?Q?jy9SH8tH+0uRUEXCwFxilZ3gUI74kOjGbzbRrHC1MCrg3d2t+AAYNXZlwr34?=
 =?us-ascii?Q?DFOaphusp3iw3E7OECofD19AY/6CoPqCmetAqArDvQTJziwPZkGiyytwWiu1?=
 =?us-ascii?Q?nGJqp8J3yARdNefXk1osoR25DevKYJdO+Q78QPKzWYW0fTbBjiHZOxdkfL3g?=
 =?us-ascii?Q?1hVxkpWPUC6AxVFE/W/IMBI5muf+u3xat90+Y0C4yUXYelXbZWOnX189H48E?=
 =?us-ascii?Q?ViNOWJl/5aa1eTTt2ocDXxS6I0HtFhOc7YyDeMXWVxO2DohJxEKDT4rzpxX4?=
 =?us-ascii?Q?22OBlO/aeScckQMibjoNPTQfuQ3kS8YesYh/X9DMwmyXj86K3ks8RYICmlc8?=
 =?us-ascii?Q?za/uD1Appxkl1Z1n4myOEhudrdgofzdlwdUKFMfeeig3KuNrHl9C6/LkFnCl?=
 =?us-ascii?Q?TnOrEbQc2goLD2rBXimml6ie3+UfPp3G6veqj+375ECWznSpvpYUc7hnGdKq?=
 =?us-ascii?Q?DoKiewYZ+/7y2bzw07MyfUBDvdOjlvFJVS2Yd5AofOjwSKlkh8w7?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e4006c-323b-4701-03bf-08df2eb06311
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 13:45:22.1855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHtu4ZfrGETd5R3lmBUplFSGVvc5dQCIWa91GhmO3S7D/r9rne5XKTVvbemH8jzsnDmCt5VtfUDpeMo7bCTFJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5194

On Tue, Oct 20, 2026 at 01:47:22PM +0200, Geert Uytterhoeven wrote:
> Hi Den-san,
> 
> On Tue, 20 Oct 2026 at 05:11, Koichiro Den <den@valinux.co.jp> wrote:
> > dw_pcie_host_deinit() frees the iMSI-RX domain before calling the host
> > .deinit() callback. For a core-owned parent interrupt,
> > dw_pcie_free_msi() removes the chained handler right before the domain.
> > A glue driver that owns the parent interrupt and demultiplexes the MSIs
> > itself through dw_handle_msi_irq() can only stop its handler in
> > .deinit(), after the domain is gone, so a late interrupt can still
> > dispatch into the freed domain.
> >
> > Remove the domain after .deinit(), in dw_pcie_host_deinit() and in the
> > dw_pcie_host_init() unwind. Keep removing the chained handlers of
> > core-owned interrupts before .deinit(), which powers the controller
> > down. Clear pp->irq_domain when the domain is removed so the unwind can
> 
> FTR, this is now pp->msi_irq_domain since commit 8f0b8cc3a655f56b
> ("PCI: dwc: Rename pp->irq_domain to pp->msi_irq_domain") in pci/next.

Yes, thanks! Shawn also pointed that out. I'll rebase once those changes reach
linux-next, and update the commit message too.

Best regards,
Koichiro Den

> 
> > tell whether it exists.
> >
> > Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
