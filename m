Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021122.outbound.protection.outlook.com [40.107.74.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E3510785;
	Mon,  5 Oct 2026 04:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791174682; cv=fail; b=TxXHYyopUjUyb2BXkCqfTS0pM4L2FQJpNlNk2ShU9sFxtpeAKACks4bW9B2M/b/+PD1QvYPOz//5imkEddrUUftKQQExM4h+f4cDLJKDwCiJgcqTvI59sI1l84znEIqCzFMZpJXUeYA7qJRlEduWDyCysmR2DMGGu2VMNm+UMRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791174682; c=relaxed/simple;
	bh=xLCip7zHEq4FLswqL+8GofEATPcxexxOAHx/7crxiLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s4vQSWgAldxPtdpO7xbdXavv5q6u9Q7Anc7T8cHgmDCL36QbB8XCfmG33hTinzhhuXLvOT2j2aYWogAK4RL/yBhXUtamR2vWtpbyBlfD2d3I5fQ6HvTBGQkDLeOz3lNRjlg9D+mHXhYOS0tSJyvwY9BIvTwgiaSFwJxw66N9G/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=JS285zjU; arc=fail smtp.client-ip=40.107.74.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="JS285zjU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ab3sdAMpWJHCjqyv5my98za4jRnMkdhbYxJKQmgQZnH3HZDBzS2CeLAFKVteXD6cZfEKvVo/pvwlyPkAj6LanILPeZrH+rPf0C2iHUt1BlBmIBkC3DHECcRAD72r03rN+kfoLX/OyH2NpXbfVJN4U2mco0xUjq9SN0KO2QOnz19gQK8pRO/vSOQDzVuxIcXqaT1UZoiMfKvHu9hTr69zVt+2XPNS/myJCoevmnIaJeXM2sDjrNDITHuxynxu1ApOwOV8BTJw6R2KZwW55AJ36lsOydZVZ1u2n8xPuMerJVEL7QSSRsU3dw/Y4YDUAK1APtOG/408l8nsqbB+YtiwJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyfWPA9lE17QLfJmbHbiKAPh1560kHYOCffg3kgi/cU=;
 b=nNFX5lyft1QtydSDYuplA9Ac7thEqLegtasfHhKzWm+jj4cNexxeChPVdll/PMJqveYH012ebOfyN28mzNitBMAx/viC8t2Waa+9OG6y4jEZYvShk8AbmStPKJeg0MdtS6dHJIg1yCN1snePA+6CLFHhbmRz9audRPm6YUJk69CKfKAssb4Mv6geeFxsSNBEkDWeq56RmcOGnuYYHNrk7Vuk2K/tuUF++gl2VcNN4Y4NrlyNfb8HF0sYUof8JF4BIJKcY3bHbLQDdh9JWo3tQxYzADShuZkja/EMGZXuAoneN/ojGgYMgSAgzOf0Wdv8NdYzjDgUGEPR8CmSO6ToCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyfWPA9lE17QLfJmbHbiKAPh1560kHYOCffg3kgi/cU=;
 b=JS285zjUBR7R47tX2Ntl5qaWZwXMKuoDscrHZJfdka84rtcclF5CQwObF7RuGQZ0xAXwXGxF4bl90vI1ofnY0WEtO7KUNd7yRllyuUNDImJO/+jHL1bbNw642l50XIPheY1+jb3RyYltHpKJQOze0mYlw2QYcnsdcxeZR36N1kg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS3P286MB2440.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:152::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 04:31:16 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 04:31:16 +0000
Date: Mon, 5 Oct 2026 13:31:15 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/15] PCI: rcar-gen4: Add a controller
 reinitialization callback
Message-ID: <oos5utxsjiyervrcw3amvlbhtwiyyaarfidpatckvgyvmqpuav@fcoqtimyp6wv>
References: <20260928165230.3397664-1-den@valinux.co.jp>
 <20260928165230.3397664-9-den@valinux.co.jp>
 <6e10fdf0-956a-4ec7-9f24-fa82317be297@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e10fdf0-956a-4ec7-9f24-fa82317be297@mailbox.org>
X-ClientProxiedBy: TYCP286CA0293.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::11) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS3P286MB2440:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f85dde5-f021-4dde-e06e-08df22997efa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|10070799003|6133799003|18002099003|22082099003|10067099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	suw0pj692eqbuKaycAhDYlh4VLi4k9PbJhdblBnWZoboCKX4zIffJB1GtZHuCj/o+9s8lWYwFdbmykMDlb3yeBVhfBApP85hXK/7q39Xs2Q1PGgEnJQjeV6HaYElc763FlNCGqYzklQ8fKH0agdGEFxs7ekrUuURtA+FSAJAJajLCC3UM8lDic8jJ2ngS/QcR4TNuCL/tWzsPgr6KYNZJopRjfySTfZsmoBjnPLMTPeuWr1noeAuD3VEdm93pfROY4XOaCBGZZdvkg8dM0n+6sJkjHcROtWl+udHTnlLhOAdE1lPAG7Ze2QBc5BHKRkK5zKQQiKoHejV4l58NqcBn+JVhHNENAX5521lJs6mFkflHWEeH3sD+CfCBdzMa+GpVqMUfdBowMXiKiQmmEIfe0BHpw5dTmClE1udex0y8vloV8idDMljVaf+O0jcKhtgqmXu8uzkrPNVSWN+MAxeMkJhrsgcWoZgOz6GmIy3AKGjS4tD3fwrYj+6y0NisBwzn+P9UK71GkKEbxNHpmW8QAivGCCBlB3V8mqjskaKl3uHhgAwYL8lImqBsWRORUf/Kq/+43BJ+Q4QsK8mqd9DCxvH+q5kv6TAp3qSQhjuhot/Y8QBy2/7XWCUCbI15djWCBIxxv88+SgRulvMYcGp2GrxkKfIBKC54TQzYOVLa0E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(10070799003)(6133799003)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TAYY33HzXtCIJICKiWSwEP5aKxXpTQtP16ZBkP5GtuVmTHpVv1ESEKtd1Hz6?=
 =?us-ascii?Q?eSXPA8Lp+QQodFNMvbFp8DKdsV61bTRBDQDAIghbjlQGuhc9ZLNtB0pwXwtJ?=
 =?us-ascii?Q?ri+XUM2fcEVgGvS0zya+/dvSj115m4mWuUNRc+2JwnhDEEr6bvOk2Got/mTl?=
 =?us-ascii?Q?9GDdn6rZRhxjY+9x9Km1hvDNnGBacG5SYDr1a4x+vMsO9dA5aqf+ERQX56TH?=
 =?us-ascii?Q?bvfBJQUAhIEuXZQFvQMZNvwpK5pxMIBA0sp3gP+yrI9IB9f6as49rRHASAGm?=
 =?us-ascii?Q?aAAa3LfY9LulLzjxnmdWSWv+O437PofcWy9UIZlRlM9049vmrgCp1OTbbJqW?=
 =?us-ascii?Q?iFPqp4H9XYBurt+AfV8lyllbODwULNJx6keCmXUNCD1BNeo6hVrvvcIC5r5u?=
 =?us-ascii?Q?sb69XKr4C0Yc7/rPfgA+3Yp1iKIloPql7moOGrG2T0ZSPnFcQe7YPyKEfgwj?=
 =?us-ascii?Q?SBII5TlHBEL3jiI9Q1j1GXkYPrRkGaj6XkV/HAJRFp56bXo/o/KR1j7naC9V?=
 =?us-ascii?Q?hgx+vqh4oroZjpkZRX7QKcNWkcF1olv2WShMkyjylQ7BX0Y6BdJJ83B5dF1h?=
 =?us-ascii?Q?l3fBJGXEvfmvNwcSe2b2GilC9pnglnpWnd5qeIHyBqiWj8Av4lLLk5w6LKdL?=
 =?us-ascii?Q?8PlVhh2pJ5kjTtRPr+ZWU+nMgbfoxZdLcLi9RxaD3hKNImpcvB3JwSat68PC?=
 =?us-ascii?Q?qvLRJTQ5Mgk1xO44zvGBPuRgmLGbiT4aGK7Y0Gq2YJH/Afl6zKQsgbXg9ntn?=
 =?us-ascii?Q?yjFWOteF3b2PTEee/EqOKr9XcFuX7nFDAG0gl2nKWLw8oHQ/lA3FaoGcqK57?=
 =?us-ascii?Q?uK4qvz+tLKU4xMJcUXf8yKQ7OssaL333duofWflhfKT8uTEtHDAsQQ0lBYS5?=
 =?us-ascii?Q?WmYOrUcFJNtNzJvFZqG50JNLTuTAQVA7xP4T0FJPWDLox0K0JLClEaw886cC?=
 =?us-ascii?Q?joeEH+I4FkM83FTPyQDyXYNcBunRj/tqj3KFcodLts5dwGUabTdR6Ilafp9J?=
 =?us-ascii?Q?fnLvZHIZotMUfhsDcWpGAWX0fR4fOa5FX9ZG49pijPcmDzR8hwUuEaiM3kBu?=
 =?us-ascii?Q?zXtPkK2k7ZusyF5/efowK3gSrJAU//crE7JG4tKXKWOzbPuO49xe//K8pWVe?=
 =?us-ascii?Q?NYPFxsLoOzcQGQuZ4wftU400kZKiNs+HJP7ckKyEjowwHw5k95pVWU0iysDB?=
 =?us-ascii?Q?h/aA7EvcJBx0k1Rd53Apb2ixRIAnt9fv3xtlss8ZrvDH209B0uvCL+dOrrvM?=
 =?us-ascii?Q?dlifzJIZLmsmWWUzLBKhoGaKYjrg38lxdqY/tjt6sHgmfheUwyEoIIYnLmoq?=
 =?us-ascii?Q?Gn1kn3WN1Q8bfjeM/GdfrghmoViu2nVaiNVBYTnayCjcNibrEKlckt9ZpAci?=
 =?us-ascii?Q?wvHWAqLIOaMwAkzaghkRfU557L5Eihg+3fALH0zJSPW28ZNyE0QPjZhlIdOl?=
 =?us-ascii?Q?tb4vLWD8OucOnCYInnUr26d7wcDg1L60C3wmTa7YvIOdlWN+8wOP3YrfGiL8?=
 =?us-ascii?Q?Z1s5iVg+9zxxPfPMFijpSAxOZNSDXwsQ+Uq+hzurGnM6VhDyXz2j7VZVjP/b?=
 =?us-ascii?Q?OgRJjeJ530eJLdkYUkNls3rZbjry0hSUwbLv1DE04B2pyDgjleq4yGDAYvF2?=
 =?us-ascii?Q?tal++PV4k9v/awDefQiZViBfx+2W8RaTRqN+fbN7NTaTx2yz7WLErVrfrSbq?=
 =?us-ascii?Q?XFJvllNBWMsfM+/ZkO0rLqRxSGRvwUQqBAaZ5jBQTeKFIrdX6mT01yEu/Bk3?=
 =?us-ascii?Q?bs0zRjgwAMzL0YRRKxM2ik2ddjpAAZYIUWjgJbUCPU7wcXzWQa+c?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f85dde5-f021-4dde-e06e-08df22997efa
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 04:31:16.7449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /3PCpm7SHhiDnck0cbAfz7GLOTBJVsfDXJr1X6BthPrWyXuQyAgDfDU2IOYFf8LXm3v/atlZJ1ueTAElieMU3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2440

On Sun, Oct 04, 2026 at 01:54:59AM +0200, Marek Vasut wrote:
> On 9/28/26 6:52 PM, Koichiro Den wrote:
> > Root Port recovery needs to reset and restore the controller while
> > keeping the clocks enabled and the Gen5 PHY initialized. Reusing .init()
> > would acquire these resources again, while calling .deinit() first would
> > make the APP registers inaccessible to interrupt handling.
> > 
> > Add a per-SoC .reinit() callback that repeats the power reset and register
> > setup without acquiring or releasing resources. Use the same reset and
> > register setup helpers as .init().
> > 
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Changes in v2:
> >    - Adapt to the per-SoC .init()/.deinit() callbacks in next-20260925.
> >      Add .reinit() for recovery without changing their resource ownership
> >      or taking another PHY initialization reference.
> >    - Move hardware setup extraction and Gen5 initialization cleanup into
> >      preceding patches. This patch only adds the callback and its
> >      implementations.
> Could we introduce .configure callback instead, and deduplicate the two
> rcar_{gen4_v4h_v4m,gen5}_pcie_reinit() functions ? What do you think ?

Agreed, that is cleaner. Thanks for the suggestion.

> 
> This kind of a change (this would likely require folding this patch into
> 09/15):

Yes. With that change rcar_gen4_pcie_common_reinit() would have no caller in
this patch and compiler would complain, so yes, I'll fold this patch into 09/15.

Thanks for the review!

Best regards,
Koichiro Den

> 
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index 3d667f25fb32e..3691c2ddbf6bc 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -100,7 +100,7 @@ struct rcar_gen4_pcie_drvdata {
>         int (*init)(struct rcar_gen4_pcie *rcar);
>         void (*deinit)(struct rcar_gen4_pcie *rcar);
>         /* Reset and restore registers while clocks and PHY remain
> initialized. */
> -       int (*reinit)(struct rcar_gen4_pcie *rcar);
> +       void (*configure)(struct rcar_gen4_pcie *rcar);
>         int (*ltssm_control)(struct rcar_gen4_pcie *rcar, bool enable);
>         int (*speed_control)(struct rcar_gen4_pcie *rcar);
>         enum dw_pcie_device_mode mode;
> @@ -326,6 +326,20 @@ static void rcar_gen4_pcie_common_deinit(struct
> rcar_gen4_pcie *rcar)
>         clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
>  }
> 
> +static int rcar_gen4_pcie_common_reinit(struct rcar_gen4_pcie *rcar)
> +{
> +       int ret;
> +
> +       ret = rcar_gen4_pcie_reset(rcar);
> +       if (ret)
> +               return ret;
> +
> +       if (rcar->drvdata->configure)
> +               rcar->drvdata->configure(rcar);
> +
> +       return 0;
> +}
> +
>  static void rcar_gen4_v4h_v4m_pcie_configure(struct rcar_gen4_pcie *rcar)
>  {
>         struct dw_pcie *dw = &rcar->dw;
> @@ -343,19 +357,6 @@ static void rcar_gen4_v4h_v4m_pcie_configure(struct
> rcar_gen4_pcie *rcar)
>         writel(val, rcar->base + PCIEPWRMNGCTRL);
>  }
> 
> -static int rcar_gen4_v4h_v4m_pcie_reinit(struct rcar_gen4_pcie *rcar)
> -{
> -       int ret;
> -
> -       ret = rcar_gen4_pcie_reset(rcar);
> -       if (ret)
> -               return ret;
> -
> -       rcar_gen4_v4h_v4m_pcie_configure(rcar);
> -
> -       return 0;
> -}
> -
>  static int rcar_gen4_v4h_v4m_pcie_init(struct rcar_gen4_pcie *rcar)
>  {
>         int ret;
> @@ -400,19 +401,6 @@ static void rcar_gen5_pcie_configure(struct
> rcar_gen4_pcie *rcar)
>         writel(val, rcar->base + PCIEPWRMNGCTRL);
>  }
> 
> -static int rcar_gen5_pcie_reinit(struct rcar_gen4_pcie *rcar)
> -{
> -       int ret;
> -
> -       ret = rcar_gen4_pcie_reset(rcar);
> -       if (ret)
> -               return ret;
> -
> -       rcar_gen5_pcie_configure(rcar);
> -
> -       return 0;
> -}
> -
>  static int rcar_gen5_pcie_init(struct rcar_gen4_pcie *rcar)
>  {
>         int ret;
> @@ -1133,7 +1121,6 @@ static int rcar_gen4_pcie_ltssm_control(struct
> rcar_gen4_pcie *rcar, bool enable
>  static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie = {
>         .init = rcar_gen4_pcie_common_init,
>         .deinit = rcar_gen4_pcie_common_deinit,
> -       .reinit = rcar_gen4_pcie_reset,
>         .ltssm_control = r8a779f0_pcie_ltssm_control,
>         .speed_control = rcar_gen4_pcie_speed_control,
>         .mode = DW_PCIE_RC_TYPE,
> @@ -1142,7 +1129,6 @@ static struct rcar_gen4_pcie_drvdata
> drvdata_r8a779f0_pcie = {
>  static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie_ep = {
>         .init = rcar_gen4_pcie_common_init,
>         .deinit = rcar_gen4_pcie_common_deinit,
> -       .reinit = rcar_gen4_pcie_reset,
>         .ltssm_control = r8a779f0_pcie_ltssm_control,
>         .speed_control = rcar_gen4_pcie_speed_control,
>         .mode = DW_PCIE_EP_TYPE,
> @@ -1151,7 +1137,7 @@ static struct rcar_gen4_pcie_drvdata
> drvdata_r8a779f0_pcie_ep = {
>  static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie = {
>         .init = rcar_gen4_v4h_v4m_pcie_init,
>         .deinit = rcar_gen4_pcie_common_deinit,
> -       .reinit = rcar_gen4_v4h_v4m_pcie_reinit,
> +       .configure = rcar_gen4_v4h_v4m_pcie_configure,
>         .ltssm_control = rcar_gen4_pcie_ltssm_control,
>         .speed_control = rcar_gen4_pcie_speed_control,
>         .mode = DW_PCIE_RC_TYPE,
> @@ -1160,7 +1146,7 @@ static struct rcar_gen4_pcie_drvdata
> drvdata_rcar_gen4_pcie = {
>  static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie_ep = {
>         .init = rcar_gen4_v4h_v4m_pcie_init,
>         .deinit = rcar_gen4_pcie_common_deinit,
> -       .reinit = rcar_gen4_v4h_v4m_pcie_reinit,
> +       .configure = rcar_gen4_v4h_v4m_pcie_configure,
>         .ltssm_control = rcar_gen4_pcie_ltssm_control,
>         .speed_control = rcar_gen4_pcie_speed_control,
>         .mode = DW_PCIE_EP_TYPE,
> @@ -1169,7 +1155,7 @@ static struct rcar_gen4_pcie_drvdata
> drvdata_rcar_gen4_pcie_ep = {
>  static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen5_pcie = {
>         .init = rcar_gen5_pcie_init,
>         .deinit = rcar_gen5_pcie_deinit,
> -       .reinit = rcar_gen5_pcie_reinit,
> +       .configure = rcar_gen5_pcie_configure,
>         .ltssm_control = rcar_gen5_pcie_ltssm_control,
>         .speed_control = rcar_gen5_pcie_speed_control,
>         .mode = DW_PCIE_RC_TYPE,
> 
