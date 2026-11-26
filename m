Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.74
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795710271;
	b=WfHcHkbX2vpX7ktNWWC9EpK9ArLje5wrNzNcDbbuXVFvPLjhm0AZp5E9nfWjxXJ5dSYL
	 Laf6ixfbZWpBQajop9lFECp4Ov94xR8cM2Xi32/QVyXKd6SArz6s7Q5XV4ywy4OaibjBu
	 72ZTy3Py0hg4Z/sd+C2CYo5/v+5108bw1AUArrBAu6emZuDWWSnupV0VfsgRTit6eNB8I
	 44JtFYN9mvtsuYPK2bGytsklI03xwUBjRP3n9+qPsZp5/JvmJm9jd3FHuNSmwCjaqFyJp
	 vonFTlwQB/17tEMgnLc6QI2lkvH0YEf1Hw5M6hI2DWCaNCuTUJplCKj+xF+kAD3z1xg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710271;
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
	bh=c63L+lm3EQIBtkY2y4aMO1FHcqfBdKCYhjTaLMWSz6c=;
	b=sZSAP91qPj6PzpLGvIsskMd/6Bv0ZKl14c58lHKDC6LHPdYHqKWCgmmK87V2sIUwtM4y
	 mQHGS3m2e3XzHygaYBeSmQRMP7xkJ7oaeFzU06G3Lc3byO09WUmq5ZMCixy6tuS2O7kHf
	 x+It4zHpgug6iEP0bG7y8aZnlNb5qu5HpZW3Mp9RIpIhCmbrNDDoSYg+ZD6C9ipkqb23t
	 SLiC6cgoY3eTWENbb1VbNGW3E5lM5gAgpDKcXD3vEuT4ifkFZ7/HmE72/1SgTajEh9sm3
	 //MBDdos6zdI4rJckfKC/gITRLWxGlyNPvewdAx4W5KJHhzKEYGFQaRbnTmG7nfSBfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=u4eNjw7H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.74
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020074.outbound.protection.outlook.com [52.101.228.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA5C606A31C;
	Thu, 26 Nov 2026 16:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FA5C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=u4eNjw7H
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fRR8fi17+RUizC2WHKIUIhqOxRyBVrqGY5kPgfdjTySWEFaGKLlvlDtXk1IlwAMRuy109emBTbQYubmqM+cVyfYpe2vE3CyG6IrRwGkh2bBIqz16yJ/6BBV6drAUq4VIEQiZfjdgZmMvQpiJu6lEe4JUbsO7iKRwb0eeBP/l2FHzrMlukzbv2UvgjVOwsL9xPHY/QsKqAgFvWIKkGXSnBzlZNgFWlX01SJiA9DLvdRFQNKwnQf1eslowNzV1a6JlnvYfjxIHyzQCKvUvks51x7DlFAxtX4qyOkjwER0B1HTlssKvZVbMb2EJABW78Tw9N+wcX7qb+w7eHGTRdjOWDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c63L+lm3EQIBtkY2y4aMO1FHcqfBdKCYhjTaLMWSz6c=;
 b=D0ppsxbmK33t4jn21h5u8+WLGHaWC10Su8od+g2gdjAyr+I47RSW5omvT03Q7QEJAIpcFliQqTIwsn6CtqZJdPECJhGKGkFb9yhzbQuKySljKSzrwlJFyD3YN3Pt/Eg6CQJgXlvi8QEG/RMLt34CwWedpiV20Bh3kf7sRaOYxzVLuXprggHWKMsB2Sl+aECt0oT43I5/D3FFyDo77VZpO3bEVTymtEjRZ1uk57AMLqu0DaeXDNHJOUpzGGIdzzDHZSlLA9GeyY+HehCA7gjgf5EApJw9IMq0EwXTxerjb/UbyB7XcSzHn+An6IhWVAnD+bRQnrLD9nF6WPMpJ6kRqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c63L+lm3EQIBtkY2y4aMO1FHcqfBdKCYhjTaLMWSz6c=;
 b=u4eNjw7HYuXZN3203ByrKcCOYWW1SxQh98x+stSvHE/pnHNm4/oULiGe0AEMHELWEf2DFIuaWho4GETWU3wtFv7R/vEr+Rll0cEBj8xI7AeCJios+22mm4Y1xcOVyGVYiCN34nzOHBqzgQR1rU6EifZfRTgtf2yONFBOgo5DYuE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYYP286MB3872.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:152::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 16:24:27 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 16:24:26 +0000
Date: Fri, 27 Nov 2026 01:24:24 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Geert Uytterhoeven <geert@linux-m68k.org>, 
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Shawn Lin <Shawn.lin@rock-chips.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 17/17] arm64: dts: renesas: r8a779h0: Describe the
 PCIe AER interrupt
Message-ID: <awhXFPlyc3vnmjtC@z790sl>
References: <20261020031049.969895-1-den@valinux.co.jp>
 <20261020031049.969895-18-den@valinux.co.jp>
 <CAMuHMdWk9pZdJ+eh0dNHrZSMVDe84_rsvmrD=pC1Fjy9wEyp1Q@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWk9pZdJ+eh0dNHrZSMVDe84_rsvmrD=pC1Fjy9wEyp1Q@mail.gmail.com>
X-ClientProxiedBy: TYCP286CA0187.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::11) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYYP286MB3872:EE_
X-MS-Office365-Filtering-Correlation-Id: e470955a-5841-489b-c9c1-08df4bd9bd35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|10070799003|23010399003|10067099003|4143699003|56012099006|261009223027099003|261021135927099003|261021121427099003|261102123227099003|261026140227099003|261028144727099003|261022105027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KWngrQeZuNDgqFrAMhMqKRUXwaX8mLa+Wjm0EPTkw2qtfflCcchDGRKqyQUFiI4qt6AaQEEEW4Hbo6wemIOapQINO2xr7E3DOHlfTaQ57q71pA8RyioiismSvKBxZ7BB0WFIo2L3fi+Tyx/a96Sq2LiaVjEDqeKC0e2tHmEp6M7AeKU6I/VgrSBt2aIYOxu21YDeoiBJBZRnvu+I5SQrGOwAlBlr3u/DLHX+05EABI3UJPnjw1i1tXZvrSvDLcn61ODwGhXNIKC729A2LoWKS/taqWlNcKAkdPr0LeY536gT9nM/bSButv1jWQIs3K0FDuV9a3h0GsWl7Ntb6eT33vakAdlQqPY72q5ENuBBNnkRHInivaFOyZ6c/AiAEAbWDUPY6PsPEQQ3aVbG8YXtqH87a8jPbBTQO9c90BCTSAkfKN70qMm7SnBeTW9lAWlXEYxtJ63qX6K+MUOV4zRjQClYt3uLX7ABafVTL7koSC0VxA6/RnQAsrVbznjrcopTKLdacP475Q2gbHaPp3U89BmLRPJ/lk2xysoNpnOkmZBXFuYJmm4ipYVx+HO9qFVZgtArFw3fC4dPR5fAx4mpvmpzOvJU5GIKuA9L1I4Q9TPfOrgx0lcSH+YVHwfMuLAG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(10070799003)(23010399003)(10067099003)(4143699003)(56012099006)(261009223027099003)(261021135927099003)(261021121427099003)(261102123227099003)(261026140227099003)(261028144727099003)(261022105027099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f/qDRDhgW9AO/vbZse9jo2ie7oBOxLfdsE6Sk1uBu/rld6qQLzcIZRPbIj10?=
 =?us-ascii?Q?Y9qX5MU6/JbpFx0sgbYt8SXKyRl44fjM6qrpvQ2YLS7caWi39PQI4cVnjuIu?=
 =?us-ascii?Q?2zh0vAo9xxsAZJNvS69K2Ac6uacFOWjdOpcJl5y4tisYSWyzF7FflsZD1hpP?=
 =?us-ascii?Q?bnT+0+1jXn3mTRgYiNAIIWdqvWum+TlijNVl1y8RA8TCdZsf+HOTuygHWcBc?=
 =?us-ascii?Q?9phTM5czniVzOhIrpsTyWOlXxO1oVD/8kfPuU365E+sAV+T5OcfkJCyBVQ8u?=
 =?us-ascii?Q?cGoyA1Sm7uCEYeLVcyWJHwAGfPpKLiaeqM8a/rpXXk2dAod6XwQ9kciGBwKv?=
 =?us-ascii?Q?1GG4xPIibxemjCnG/Mxo01qhhfJO2evtczLh/plS2d+x4XIsrwHVuc0J9QWD?=
 =?us-ascii?Q?4roJIQw8uqepQnoXZ+FUDVB7k75Sr9BR+xWg3CeRncYEUYDAqCszJJE5c/BX?=
 =?us-ascii?Q?BXjHEVYT+mZcoUSIzb+sXT/GyeTKd9erKQc8busT/XhrxZUIs+aZkEcWSJ1Z?=
 =?us-ascii?Q?HOVJmbS/n5lutUEsNK/AHOxZLV/miz67nqyqpx45tNXtwg0FqBOT8bJgFDs1?=
 =?us-ascii?Q?c60q4JDzl9M1n0fdwCZCot2GtiXBFm9vviKfBiV/S9CP44WavzgRsJgtiDEE?=
 =?us-ascii?Q?rkbPyZPZbrqECP0Ho6tHiKEwUgPhyzyBNUUkQMBZmHyMKQjYSomIzll3qorA?=
 =?us-ascii?Q?anth3gBTus8igcKV3VL4kEP8umjZolPC8vYAz7ly7Qparb255FPRsrfWAGcJ?=
 =?us-ascii?Q?x2DQyJKHEpOovWih8aDSdkEhzhNHv+vuYCDU8euTHHxBZ5mnH6dRCedoy6Yi?=
 =?us-ascii?Q?PwGPeHSy0toM4tQWgHHUUYEw77tztZFdzwcDfJAWUUX1aR+0a9phjAI5wb+a?=
 =?us-ascii?Q?jPCwq7+u992pMWiCJ/h2tEe2wCxbTizBgWblJaU3C0HB4BUuISAb/2rtiDP+?=
 =?us-ascii?Q?SkoPv6cQRAkAZe/X92rNyOKKDgaF3uSOHOmejFNXhYKDlOK1I1qVrObZJRlV?=
 =?us-ascii?Q?lD1iEmUghHoDcKwPBr6tiqwPycXrPzOMSSEN8hbf6STr+QS10hqBAx+VlskM?=
 =?us-ascii?Q?1pZhHNSxuEJmYSol/IsKbXmsXQ+kgx3vi8i35eMJIo98ldsyqcHyfW5tUuf6?=
 =?us-ascii?Q?wqp7VZyTj97r9FPtSwDYgI7Dtw7Ww6+NE6XjwrOvhXf/YAGNZvONA+19xK3o?=
 =?us-ascii?Q?Vxn3MKrdMKRhpOVg7y4lsaqsJxFtuEKD1eF+OEzzf/DbbjslD02SsQiuEe7X?=
 =?us-ascii?Q?HJuy6zQFyNm6vkNNyPyNqoivdERUlb3+SP8UXA4o22NR5gQVUPaPGa2AHOf3?=
 =?us-ascii?Q?8hK4XNd3wWhI7BFi4CqDRvjbB2dyeK30pKMOvX0POAF85RMbWsEln1JYXSkS?=
 =?us-ascii?Q?4QRjlfwH30DnsPlvFYT3WiGjgj4XdD0QQI3ADgtbTxnORg5UJOFbXYwHVNQz?=
 =?us-ascii?Q?D9s8GxZ58sBtiCsz6JSxYad6XUX3Kauim8W/fqy5xLY6dU31s9q6sDvyvaG7?=
 =?us-ascii?Q?CQNphoacbKk7KiZQ38PtSzqUizqYTMIbahZ85yt1p4u/HZ+NzTI1BxIEJRy/?=
 =?us-ascii?Q?8ybVOqqP6Rt7QwtEWZ4kco8MyxKpI1UzpX9BvZVOB9RReyr7vjEUAvzgBS0v?=
 =?us-ascii?Q?79cRgL5LBOh0N1JhnDEGDh29LpTRHwrLTaLekZnHrInr+Gg9jBPrhPxkBhfA?=
 =?us-ascii?Q?7P96MpClFN0ISxSIyCa9F64yUzlJrDug+RutT7YKaDx6WxFwvJgWatNQKuGv?=
 =?us-ascii?Q?EJsHwyZwQKiE57jv2QV/cpjT16UwcU0NW4AptTKlsSVjBfuJ9+Eo?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e470955a-5841-489b-c9c1-08df4bd9bd35
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 16:24:26.6792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6X0DQ5VnBqX+zwrV/esFt+pJL7N3zBt6QFsDqkNPUpkPwCFDjb3YJCOxFKTuchKzk21pyOu8AD7T5tWFpnVn9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB3872

On Thu, Nov 26, 2026 at 02:10:32PM +0100, Geert Uytterhoeven wrote:
> On Tue, 20 Oct 2026 at 05:11, Koichiro Den <den@valinux.co.jp> wrote:
> > The PCIe controller reports Root Port AER notifications through SPI 454,
> > separately from the integrated MSI receiver interrupt. Describe this
> > interrupt with the "aer" name so the controller driver can use it for
> > Root Port error reporting.
> >
> > Append the new interrupt to preserve the existing interrupt indices.
> >
> > Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-devel for v7.5.

Thanks, Geert. TBH I'm worried that the rest of the series might possibly not
get picked up, in which case dtbs_check will keep warning indefinitely.

Mani, mind if I ask whether the series still in your review queue (it looks so
on patchwork [1]), or whether there's no hope of it landing for some reason?

[1] https://patchwork.kernel.org/project/linux-pci/list/?series=1189393

Best regards,
Koichiro Den

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
