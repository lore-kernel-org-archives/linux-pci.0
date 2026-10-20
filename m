Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.142
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792485943;
	b=MvfnZDO3oFy0CoNpiV7XdLACKdwXJDJ8EsRbRb+cshLyKNvxX9OUUNTRRF41Fe+vyacy
	 R79QWD5XMrz6AuIpcDUeQt/vt8ZsCdDgZ8Rr269R8ZIYKj8wQPjUqJ1RXgqaSXVCU5KYq
	 fw8+q+eUUybTdWRKdZM3W7DnbvqPFL0qMj3u16zYxZNYs50+E6INrWmiddl56Dh70PeDy
	 nQvN5h0j6E9x3ZlS/2Y+mgFGl/WaqLvFmmUsdHAbp0lsw5d7wmUuugPZu/pM9SSHhVOVs
	 zQ+XYL7nXXhzPgf/mIZvZlFqkelOjrCqagjsU/USH17UUOxi/azKfKIpTwfMWXKwovA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792485943;
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
	bh=5Xg8LUktunNdRb0iTz2y3cmnR9cPfmDvTeRx7sP/vhg=;
	b=aXWBrFatnYxkLc+GzACcltIxJTkavEXDIh6xtZw0d8EanJgmfQo+4E6SRQjnlIxTvPJN
	 FWLlBafcDsMRG8Ae7G19gnlYrAc7pEmSAi786u/wQOBlxoISxvaUjWrh0spWUs2UzoA8a
	 dd/jBmFi+ZrmOrHFgE3++BBV9+qBWi8aHDPYViKA7sdJlpBeaxouh8vG8CeGIl5erCNBP
	 7S7yuldR7R+ZixKICF6pNUBYNODA3DOzMDsuM2YHp2RClTq/zApnDBlHHMWEr06EprLS9
	 QwwrxX3gOyV97FA3Gv8cCT6zv7EeK4kd9IVa01gkFSaBE8nuD+VfWL/7bDaGQKcYy2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b="Kf68K/Z4";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.142
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020142.outbound.protection.outlook.com [52.101.228.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C7B606A31D;
	Tue, 20 Oct 2026 08:45:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63C7B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=Kf68K/Z4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F63ZKciErGUN/61348PGlFlnS6daAFAX/Q7P6b5JaeaDA98gjjKByidhKB0JoBkblaRjQct17Au9ZsoxJNFvO5Gq+zSq11/HewCtwySgp/E+2IJJKwhWgTPkTBDWeI3ctHYAy0eX5ZXZVbinVayNKcwGUAt6xPTS8AYsKxHpYUkE2ojxMq8nR6o6USpEFQ4OPoOppOoQyYS/SgtTJz5qDoStS5kG25a7/Xzj0AkrkjkBZm5LUFxkiRPwXiNCjsSfwo9xqbo0LmdXoEkmaUmfYhFli2Rq3573QyGfI/PF38cTt1GWqtCLs+KTh7jzqcn/EEmGhS0c1vA1oT5arbgHbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Xg8LUktunNdRb0iTz2y3cmnR9cPfmDvTeRx7sP/vhg=;
 b=HrzgCNite69Bjer1Iy31AJB9s3USy7i6kB+IR9yT8VmzWJJcwHuPa04BodPAphwmMF+j/sAByVyZxSNkF4qpkALNLfOdpiQQLt3LTLWXZ1U9FVw0b5z3z/gBwckxBfah2AFcuKGz36EFiliJaH2+fduBRwQGVWgamh09U5IVIExGeO9OjehC8rXJV4g9Hzs1I1dlqGRit0y4y1vNCqUBrP3XBmoNYpQrY2XX5xZK90jTN7zn3/lzX+PzT+KofH/of3zqc4IN80m414J8KRjCQw4xWy6O/w9IsILXJZlrUEdTcQhDLP49iwnyJJ5MN0F+7MJA8HzQT6MFZqPbiYmBRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Xg8LUktunNdRb0iTz2y3cmnR9cPfmDvTeRx7sP/vhg=;
 b=Kf68K/Z4DiIPmTE7nlAyAuFq7I3lZli6Ec6HHe50LlpNoUaRyurauE+eiDmlEcydc/gqGDVwv9I1Js0WNlbp7rChFIlljxUTdM22IRbkcqnYVxJJg/HQBGUiqjiv6A2PrG7Cg6URIE0DJyIpG7Ve8G6b/frth+FildVAb1XteRY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYWP286MB2860.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2fb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 08:45:35 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 08:45:35 +0000
Date: Tue, 20 Oct 2026 17:45:34 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Shawn Lin <Shawn.lin@rock-chips.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/17] PCI: rcar-gen4: Recover from link down and
 route Root Port interrupts
Message-ID: <xhby2j3bznnsclxuba2txlyz6x7imty3smthxi3nrfmfrx2dks@wuqeqgkom5gk>
References: <20261020031049.969895-1-den@valinux.co.jp>
 <CAMuHMdW=CEC8_Ta11oLmKWs9rkGsy20C_g9K+n9ej6qsNF6=zg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdW=CEC8_Ta11oLmKWs9rkGsy20C_g9K+n9ej6qsNF6=zg@mail.gmail.com>
X-ClientProxiedBy: TYCP286CA0309.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::10) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYWP286MB2860:EE_
X-MS-Office365-Filtering-Correlation-Id: a93878d0-10bb-40cc-5fc1-08df2e868250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|7416014|1800799024|23010399003|366016|18002099003|10067099003|22082099003|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	op3gHnEd5NdtDxD/ylIonOC8Ml/XMI9kYW65mVhvuezbio2nuCx0R3s5dP2j4mMgSylNzKKeCP236zNyQ/QMZMqff7oSQ2B974KwWcIOYPT4vfoGvPPoh5V5vf0KOSeQkpTW0qHEGZdGAppqu7wuQN+z00PVznkBVozGMaEjyZhZBm34V1pIQCt3GUzdjltMSk8+mt2BcB0FIfuFM+nMq/hdo9/VsDuv4dMs2bMJ7FWhOuZVOY7tn9SCNg3whlVk5Uf/bJ2xe286a7vxgoECgNpWEIxv6THRQg5LPvUpu1DDgQmZ/FZTh1Ax0i3DOkEqb5t6hUi+8EzSno45dpnLolTPfgt6BCeBAXCp+Pb142PyXxCt+KMrlKURnx0c5XmhNEvSm7AYWsl5xcZ1KvM0pfaGY0Px6U38vnkMmqKLv12pe1Fv3U4SyHwpGDamZw0CwfxRjdM6rrHCRBWer2Rw0pQXnO45hTa/lxovQmcnit4OKreALhDl1CseaOFQlFvKN26bpuVLYUIQ54WcWYbiTI8SBnM8vOWolt8jAoG5QQsu6BY2T5/1WAZk6yD35l//0ulyjqWF3Pu7DFkt+VdkBmkPXPWh2J1py6I3Rxhqgmbid4pb4l9wIc5YgFlePc/W3mkWj0f0HvgOJUZa4ibl70/sDyL6eEsKE7PWS+9/g2M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(7416014)(1800799024)(23010399003)(366016)(18002099003)(10067099003)(22082099003)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h/ceo36Gues/ESpiA/GqFpgGVuX8zHtWmRUWay/gbCw3OMKrm3oET/cpKiTv?=
 =?us-ascii?Q?XKiOAbUWi1cko82dk6QQOSrISSRrixunyOhWWmFv5becOXxczpnRWddSaUUD?=
 =?us-ascii?Q?wvQ7Bz4X2UJiDcbgCB1bY/gI9uKMI+duwEiJ8tOcwaAMSclQDVk1Po4JkMUa?=
 =?us-ascii?Q?QaABtgog+W/EeBSXsB3WTpEXwG8/uf6PQltvHcxx4CPyDkfxgJoYUYy1INX/?=
 =?us-ascii?Q?rjWr7Bc9Flpg9V5PloXO1Puubk8AktMPZTuDnP7hhKcAMJVZmFGQBoaqAh30?=
 =?us-ascii?Q?Qlgd4KqNC4N8jFLpXrxCFNZ5hIKdbIO7tac58p9KwCeff2Coa3CoTaxa3p9N?=
 =?us-ascii?Q?nktkOHVnZDzBf0t/JrsKLjrhK/SRdV/gvIs2Xl68K66yut3sVn8mpmEUiVGY?=
 =?us-ascii?Q?YbnYNogTkN8pUuClvZHveqY7p90qIkLj1kS7L60HgplqKGppCy+4vfoqCZdZ?=
 =?us-ascii?Q?pr2XPmucBnr3zzj74L0clS7/P71wa7ykiPmw+IIipslMC1VfQV4aF4L4r+dB?=
 =?us-ascii?Q?6oV8wUndiKFNm+ulBy9VHY2zw/9gDXhmY8aohuLlMKu2dmBatKjuMBLisjE+?=
 =?us-ascii?Q?UESENQqpnjR2LTz/v1fCgN2MxQDWJIb5kAJUMXu/RaP5/jdQ196aGT2NvmdV?=
 =?us-ascii?Q?yslBlvR2YC3IS/zlU9JHwUr6qddjsyKlDkRxs1dQQMlbwQQbdbeNGgXwlYYU?=
 =?us-ascii?Q?JqW8ajJEhm/SAva3JmzlZHEgbtjfemE4FFJXxWhgKgd4cYtw+D32gHYiZvah?=
 =?us-ascii?Q?uarxH3y2nxrZBRlWkJuUKJ8X/aOYqub6DR58TIpC7zDTZA2iaMbQK/hMo2C2?=
 =?us-ascii?Q?+8jRdV72tFMOq6ftGFM7ko95BTuzuav6axjDHuheR6DCOtBm6bt8n0VDI67e?=
 =?us-ascii?Q?kVsfyQHV7hHgg8i+A+L3tEDWjSoY6amznbd+U4DMsv78qdUrMYu0041fBfqn?=
 =?us-ascii?Q?vro8ywT8Ctv63qBt3BE7la6+WfV0V2awjLmTw5ZIcN6XJ78zZPUHisi2tnXW?=
 =?us-ascii?Q?zqz4Oi6nMA8FEzstv/vK4Hhu5sph8BlpZJm16BzU3SqpYRoIWcl01Y34uBQE?=
 =?us-ascii?Q?qD3kwjocGVeNRJVH2TiEx0rKhNkk+afr1QYzzxkSYdx0kO+tDGK2+hn28Eu2?=
 =?us-ascii?Q?00jlNPJPOINP007gvWAl2/ju+vlWQtH7fCVnuh/feG7C1X9MuHut4t4MLiFC?=
 =?us-ascii?Q?YyEsDuPku0LD+fTN7uRKN+a+yzmBKj6qPDEyzkbxeztYQrVm7/kFZuNJvYVJ?=
 =?us-ascii?Q?JyNWVn0iF98jMANQriwWK7ttiYEBIJ2NN/v3q+oH4pTrv14L9uZsBnltI2KB?=
 =?us-ascii?Q?GNtchKsvwbZRAmKXLzi1FI3wty/+yFTzX0Q01TA7R/AyzcAklr0jiW/Z9pds?=
 =?us-ascii?Q?QTN6bjYnVOnclx8atY14hzftW5lMNlDxZwaO+QUXU9wDbQze5t96j9sAWTfz?=
 =?us-ascii?Q?EoP3OA4vb4U9cyidTLK1FgDxyOrLAKNebvf6Otm0hMF6hNik7zxCwt51YCaX?=
 =?us-ascii?Q?kjJhWAILw6487+C4vuCbo4mVMmO+++Q9P1XIWH4XKOyFVnG5xMOynGLvW2dm?=
 =?us-ascii?Q?AY5GIsI30vJBIork1kZf9y7qixzF5G+9tKRz79BVAh7eusoyWXlq+xizTMfK?=
 =?us-ascii?Q?vY3WxGQEw6CayaYN2b6dQU3PwOGJCis5ncQc1R/9rCBmah2TSLJ1FD4MSwdR?=
 =?us-ascii?Q?/RQGKOQuQQakOduvwenocC212l1Lqc9agNwnS+nrfyDc6a0wcDrQ/k8I5WCV?=
 =?us-ascii?Q?z8T777mciW/zC3nRxsj9YJJ5m9h3OeQN+O8oemNp8DbBbc/0Dywp?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a93878d0-10bb-40cc-5fc1-08df2e868250
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 08:45:35.7696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +dQ0a3YwDE4yyAVku07ZDtBDKtpYVvPD5LqfWvwlHeSq0q/GVS78K6TWJLFYaHnK3rQwluZbk2T191ibQ/mLEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2860

On Tue, Oct 20, 2026 at 10:03:23AM +0200, Geert Uytterhoeven wrote:
> Hi Den-san,
> 
> Thanks for your series!
> 
> On Tue, 20 Oct 2026 at 05:11, Koichiro Den <den@valinux.co.jp> wrote:
> > Proposed merge plan
> > -------------------
> >
> > With v5, this series seems to have almost converged, so I'd like to ask
> > how maintainers would prefer to merge it. Any advice would be greatly
> > appreciated. Here's what I have in mind:
> >
> > To Mani:
> >
> >   I'd expect patches 1-14 to go through the PCI tree.
> >   One option would be a two-stage approach like:
> >
> >   1. Take patches 1/2/5/10 through controller/dwc ("PCI: dwc:" patches).
> >   2. Once those patches are available in controller/dwc-rcar-gen4,
> >      take the remaining patches 3/4/6-9/11-14 there
> >      (the R-Car driver and binding patches).
> >
> > To Geert:
> >
> >   Once patch 4 is available in renesas-devel, I'd like to ask you to
                                   ^^^^^^^^^^^^^(a)
> >   take patches 15-17 together.
> 
> I don't think I have to wait that long, as there is no hard dependency?
> As soon as the DT bindings (patch 4) are accepted in pci/next, I can
> queue the DTS patches in renesas-devel?

Hm, you're absolutely right, waiting for patch 4 to be accepted in pci/next is
enough. Let me correct that part as you suggest, i.e. s#renesas-devel#pci/next#
at (a) above.

Thank you!

Best regards,
Koichiro Den

> 
> Thanks!
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
