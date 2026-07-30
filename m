Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020105.outbound.protection.outlook.com [52.101.229.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5441E3769F5
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 15:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785424675; cv=fail; b=mPAjwRQGbP50ZTAOCfmd94ZairNEb87iFmKGKqMyXNlRBTCBnkSinyL4kYguHRhQtk0vlkfsr5v6vzf5IS80o2lOHws2r/I4E5UB8HrbR+7Qkd13DyLoqmcA4XWd0F2O5dQ3gwKOp6bXZ0Y+jGU1m5rWfvKjD/GEfxnaV/un33Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785424675; c=relaxed/simple;
	bh=dttWyTGNTU78jDq/FRBgc9jnuoDWDF8hnmFN2y96Zjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k2zHQcdoJ4A9MSwLvlRNal28Keu+EC1MLbV9j7JtTzIwgCFYNabOHiHwksgGkYRJtM9hVewoYbRE/rKPe6SkWei0clrRFBP50Hq1nJxdLwTNEmKAxEiLLhPGNhhws3L2RCh31dXw8LcwMv8deQ63U5He7d2khxGoF09vfqY0Hbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ZENdayb9; arc=fail smtp.client-ip=52.101.229.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ZENdayb9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVH9XchdgSIO3vt2D6q2Sa88gV9M5vg+Ek67hyFLoYyiKa/gRKAfzDwQnDovQ0PhvtpTMzoE+eqijJQyRBnVsuQAuEvUlQb7KjJvQSxUI3szbLbvZYGPM6DkdbfwgplfnG8jFxDfmBwV1mT+DXEL7Mt98Eq9vEQmy69s2qc9YZDPWuCU2WPlNm0Z4quFnNl9OjvKXHBhUWSkcU3Ch6tlT+Z3UVSdt8QBw8USN6cUlfv3M8Ir/MYDRIHgW5pAuH+ekUeXSkT/9+0t0vXmBtLtl5guzX0efV4kMuEoJ3e5nKc4Xk6jGzPePX8SDw0JjgeV4i95HKpPqTux17VXTcsIlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3zc5+mbP18Y3sOxw+Gh/JriQKS0RZXE1IrQuU/FkWw=;
 b=Lytt7ptNaOoNxVGv49UiHc4MP+tS9nQyOTPt3KTFbfqYRT8u6DDNGiquw+NjGheOoEVS1x17DSEuasrZF9jWDnWsRFOdR7h2Anrbxgp0YBSzX2JYjr8Czo2eBjWbPh1SESSld3parpPL0tDvcHkiyJ4+/1TCjn/Rg+i1v18a/xyLaVUWt6tVzSDCgLxq9idwRUNHKz93F7qKfM98qMGftjTadddlEYZrhx9y+0J3ay8q+n4uwSRDsV8fb2dIGrVGDz+OIRFE4jgRm/JKISRPY1b9O5I57ti7eE5LKlL/ra7CCTPRC1fvFYaFh2rXhV16n12vqWQH+P4dIS3MHuMryQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3zc5+mbP18Y3sOxw+Gh/JriQKS0RZXE1IrQuU/FkWw=;
 b=ZENdayb95HNs6wpdFOdDNLE8ab/dL1aXVqM3iKGgZGy+AHyfnviDgy/fY24VYfEBpUPx2IzZESlMoR3qYGTj2X0xWaoOqwb5VITgnH4jQFfainzwcnIIDoiziz8ZveGNMwvKegXXRY+jUuraICaGNSIBjcVyHKuDTZ9uUhDKY9s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7815.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:3a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 15:17:50 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 15:17:50 +0000
Date: Fri, 31 Jul 2026 00:17:48 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: DWC eDMA weirdness
Message-ID: <egskztabtg4ldeb7nklxbgwhvzjbly7t2553kvh4hs7j7x3mhc@b6uefnxati6s>
References: <20260729202821.1153443-2-cassel@kernel.org>
 <ampndLtU32ODmncX@ryzen>
 <egai6rd3umstjhkuelrnemr2ywjlfccfk4tipaxodav426wxex@kuu76gvznusa>
 <amsqyOvAHU8uD2Wa@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amsqyOvAHU8uD2Wa@ryzen>
X-ClientProxiedBy: TY6PR01CA0008.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aa7a42b-3874-4772-a706-08deee4db80d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|23010399003|366016|4143699003|6133799003|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	dmLVk+kIhfP8jmew63U5/6d8WELPBA4xYEv5wWJtqvrKLX9tSwBjX8achxnuW3gyIZJJYnhOijYTdljSi1+A2tZaZIV0YbDWwN5xi1Xu6gUz2YwnZK23T1Rlec68X5VUERiJ9eiSQAY+YwAXm4w3f0FazcKlgGKCcEq5z6LBlrZ2tbeyO6H0wDl9HqRCs3d3Ia+5o9I5Iw6pwj1JQXrXmoQvYv46hqbh0Bdgl9C811Dvzx7EFrUDNUa0bPuPVs0yPwDtFrB2DhP1Ks6JRzJQdpldK7Xy+KZH68xBnpKOCgx1iPgRF3ocVXv2GqyfYnq43wJh5sTUgVvTN76LX+Ur6MEwp5Y2setvvuDzVOvITiCCf5hgq02WjHkiJtCTttRhFsmfu71WruzH0F/fnX4L++yh1NgUFcLVCM0h4MUG60EjXvBrmxmwiwDAP8n5FakxwNcvJu9Shpo4aojzZbk1QArsLrhMt4qXemmc3aPuGGyBEV+qiOeM4XOX6Jpdmt/3sFUPkqL/J6UDDtENDaDQkaBefqv7JUsjrX9hdDZfx2QYE+4OHz18fD9eSBHywhDx4O1CvuHZxeH6sJ2kuUjyXLCNYjY2kjBbilDDvOexIAA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(23010399003)(366016)(4143699003)(6133799003)(56012099006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TGt749vLkBgnLjFG4ZZwzcNOUpMZT13+fag/BWtubxTDCAQQQRi05Q8LaPJ2?=
 =?us-ascii?Q?exg430mHNMnZQcLotvx4BbHH2lnqxc6uOVG4tUagIuG9CoIFOI0xq/PexU67?=
 =?us-ascii?Q?E+e6z3KFDdjf279eW5CuIHP6X9x6VpILiYdLwgYOjM0mjviModNlRZ+06rPA?=
 =?us-ascii?Q?Xvb9LvItFIocH2FMtAlA5oiV/u6WXfsQVO0GWjXiIRqWZoIrM/UIgkqabPbg?=
 =?us-ascii?Q?Ag8ii9zGUMnZWzJfEGcgDGrzHDay9xDRI+79i+1GuyL5QKfL0+J2chle7N2d?=
 =?us-ascii?Q?hWjAGyojidAeQiVeZa9eDi4N5LBjTme0CLnfRzFmZeF5WEgPGT/x49TrwssT?=
 =?us-ascii?Q?a7UuWI3tdA/V9Zn96tT4frIAw17FhximkUH5s4bd3EMHmdxsXGV7Ye3Yt0cN?=
 =?us-ascii?Q?XPSK7H8pae6lKyoQ3GpdI6oUNM5uMfkMmskbt8VewrozSvlms5ArKbGfHme9?=
 =?us-ascii?Q?MM/liXOWi4FdOaQMetVUxZUIt9YF7KefrpruHrL5ffgkwmqyGzYEQ14Gm3Gk?=
 =?us-ascii?Q?zZqIJ4e19lINww0tzkm2iCcHH48fSUZaIfukWCuo1lNdPjzWcodwGKKDY6SZ?=
 =?us-ascii?Q?Q5BAk8Fsv/1Va+KI+u0l8OTf8pvA6zRbCS4b1Al3rQGwvLrWmizQ1yAdgRms?=
 =?us-ascii?Q?ptmPHFsSvGrKRWoe4xXVAxR6+ATHo3BAgMa4DXkhhKx9e83fthebJcHfRWdu?=
 =?us-ascii?Q?kgpvvNkB86s9IkRumuTWIxW70b2N2ry/0qv6nEqyX2bQn4He1DnLC3KfeSza?=
 =?us-ascii?Q?gPcd1xQhUq42yDkPi0EW6+EswdWxMA2lrXzUdIsvobiA2FE/aCobzFENMohz?=
 =?us-ascii?Q?NFiaPiiRSWkRKXV2A5IOCsWvp+D77AhWQmelrEBjV13jiUEmDj5OAa/5Q8HM?=
 =?us-ascii?Q?3o3F6Z02QRhXrrRJ9qWGSmsdfTPSlJf/AS6JR3S890cNquBf0SN04Q1rKkZb?=
 =?us-ascii?Q?MUyGBR8GDk7hokYaFBxRtqIwpLx3TWdjiJAmRtz66I9qTzAJi1hYzG8PHq9P?=
 =?us-ascii?Q?9eEUFE8SO3f+LnuTqhWSrn5UkYr5zr8/qzZKbr0/FbYkQIubyT7VJYz2raoy?=
 =?us-ascii?Q?Pk7wi9HRiVdgcgLVJ2kcu96Ke+Yos/J5noBt2dndSxrM2wmCtCIuoyyZ4kI2?=
 =?us-ascii?Q?i6pXEJAJyzbjcJ5ANQJqygh0VEM/zwSFiPhji8K2SAEf7GVIKstqiQmse+qp?=
 =?us-ascii?Q?fddNFPZ8CjeBj5tfnpJ+q6Gb541l12C/x60LCqAu+zKexbgVjd0+9M+HKYFM?=
 =?us-ascii?Q?1axp35OdbhlvcpbLV1jcBG7YfUnQnTCx+cCtMjg0/FMqEcy4LhW/1t5fgWy2?=
 =?us-ascii?Q?hlS8kobI/TB+o6eAE5K7RaXuJnF/9rkcYkYKpaqE+BemEmYYoVwvvrCTjutP?=
 =?us-ascii?Q?EJwF3sIjUHnH0rs6OEpKbEup4CAqxXMt0eHP4EjYxfk7RFuYpav6V+6f5XuU?=
 =?us-ascii?Q?agK/xu6A6gxYnQ02yIlj3jvJP8PrKkwBg4reUsCIFULEzAK7O/b+egKiqjNL?=
 =?us-ascii?Q?ZxuTKRkVbKMkojdhskxH/7IBB9ib++d3xr8+2OZPhINB59oc1mVGWwoA0KjI?=
 =?us-ascii?Q?AINKy63VcbJU6vUZ8QjK5aDUwbuqIRxELLnWRy+O6EUDvxT6w4yKdvCKsqjB?=
 =?us-ascii?Q?0nolL3aTWO5ZQvBN6Ut5d+KtCXHVSdoLyVkr9TqIdwOPDB9mVSlKESutwk02?=
 =?us-ascii?Q?OLi9dfbnv1WZffEBpWcurqG9qgl5fQbF7UDyZ9L5D1x+d/l1/1kN6JauDqDb?=
 =?us-ascii?Q?AScCtvjfOOGWKtyEcTLzA3RxHBUUMJ/KpnHIZubtescmLubpZN2b?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa7a42b-3874-4772-a706-08deee4db80d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 15:17:50.1850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkl4M9D+oaYFtY13NTY624veg823PTlCP8Vsim6sEl499qvPuUToVmL342xX6FHyoAmyNp6adkQp98Fgzz115A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7815

On Thu, Jul 30, 2026 at 12:43:20PM +0200, Niklas Cassel wrote:
> On Thu, Jul 30, 2026 at 05:39:46PM +0900, Koichiro Den wrote:
> > 
> > I was struggling to reproduce this, but I think I figured out what triggers it.
> > It happens when the 'dma' variant runs before DOORBELL_TEST, e.g. when running
> > the full test suite with no arguments, or by running '-v dma' first.
> > 
> > I think the following patch fixes it:
> > 
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index 89a4c498a17b..ec097c68cf5f 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -755,6 +755,7 @@ static int dw_edma_emul_irq_alloc(struct dw_edma *dw)
> >                 return virq;
> > 
> >         irq_set_chip_and_handler(virq, &dw_edma_emul_irqchip, handle_level_irq);
> > +       irq_set_status_flags(virq, IRQ_LEVEL);
> >         irq_set_chip_data(virq, dw);
> >         irq_set_noprobe(virq);
> > 
> > Could you test this?
> 
> That appears to fix my problem.

Thanks for confirming. I'll send a fix for this. Sorry for the trouble.

Best regards,
Koichiro

> 
> We have had a ton of DWC problems related to IRQs.
> IIRC, most DWC IRQs, e.g. the embedded MSI controller on the PCIe controller
> itself, works using level triggered IRQs.
> 
> However, e.g. MSIs themselves are by definition edge triggered, so there is
> a difference of how you mark the IRQ handler in the DWC driver, and how you
> configure the IRQ domain that you configure to the MSI/IRQ kernel code:
> https://patchew.org/linux/20250205151635.v2.1.Id60295bee6aacf44aa3664e702012cb4710529c3@changeid/
> 
> 
> Since this is for an IRQ within the PCIe controller, I think this is correct.
> 
> 
> 
> We've also seen problems where we've been clearing the level IRQ too
> late, see e.g.
> ca1658921b63 ("PCI: designware: Fix missing MSI IRQs")
> 
> which caused us to miss IRQs when two MSIs came very close after one another.
> 
> 
> 
> Kind regards,
> Niklas
