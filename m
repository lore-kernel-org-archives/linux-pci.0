Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021125.outbound.protection.outlook.com [52.101.125.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713E8426EB8;
	Wed, 19 Aug 2026 08:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787129329; cv=fail; b=vFhLGkeoi9EwZ1Zpjnb5d2hHyC5pcxV/VcidtE8eKngMYMKad2LIvmM8Ns5piOvIJtgsRyCL0UnrLki/Cc5iYSmjcBFPqoA1qYY0KP0AtnjRmAzzXUC7H8cDOFFup4pPGnG4BOyZ5U4iHFf/EB30KPn8qh1n6geRU9NxxGPX1Q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787129329; c=relaxed/simple;
	bh=9FjYnGW/KA58vmp2EUKGqCVT+3emcQN8h0cFIEqlomk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T+z9fHLaQDqpkruyjmvh1xCIIkQ6FDTyUoC2+0Zqk3yEjoUZb4gGxlYXb22ZgULx7AspMNbme9Gu9y1XyqxGIpS8B/pSs1VQTcQf+Z+J82wcni46BaawhBzDNCtpzTZpNfdJCViOhc87vhAWJfTOVBEbUoW/lEKTu5LiGCANcT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=cM4+Biqj; arc=fail smtp.client-ip=52.101.125.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="cM4+Biqj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIy8xCkOq61AEo7aGXqcuXbkTLNTRPd6hn0Kc7ciMEeMv6O21QK5nbQ5cEpuIS7ydVRKwId9v1wrRGw/ri32ohn4/cInfgJk5zjE+hjxDL/aLRG8F7nZiQkI5s8NQAD7JMyooyYKp49k5bwEFqIshNbhCSGaxTzwVjue/ZYAHLa87V2xS+n1Q9GTCRp7W5iUhxIdO0Hj4R8eSK1fX1tjuJ/1Zp09skE7EnV5xCeXVBwPn1lbmmSTdxXYVigHGvd9vgm4C058Z/+WJ+WtIqnUkg6NRCSxz6nfRTiUd79du+QCA+EkFCTuktAhjM6Ll87K+glsUp1/GTvUDiV8rb2xqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8P2Utu0lVhKbaW19bD2A5wVf/p1zPUIo8fhUmbEyXto=;
 b=FeH/OmclHTY0WcgvvCM1VOxlEcC7rHYB7R8zK38tb4SbX3YS6z/FKtAPvDSPnSLd2S859V4IvwS+DKFucExvV4zG4hexzdhM1RJBGEQbeJxcJUiE5yC1PcI3AtuhIKDjbQpuCkB7zppsfLP4RBTjvaSP0zqb6piM8cUKYFyZqtiNRtS9lBNEIoZ3zwg7BogZZXEIGJxl7CHpzD7mxwnCACMD9gUPAcobYTSgWzRUsw+Q0Ctp8A6nBsJ/zEW/j/hhouCg/GegK2/5rMt+CJjPtROcVqTKb+iNDl4kLNizCjKFqRZIlCOEHGXawTANX5hH16+A3/YoSfSEh4LCodGEUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8P2Utu0lVhKbaW19bD2A5wVf/p1zPUIo8fhUmbEyXto=;
 b=cM4+BiqjH6pz0OPfft5Ocr0hJAq1I8Uzc9RJUCmquhzw1eUgmS3c7aJxNQVlT+zl+QeyaWU0ZrvFR5JU5/+3Kgf/xJYVOoJ2sIIKb/nvOWhjwsnJpr8TKLPUUFJX4qgxzJ2WM90YWGfklBoxNojWfP8Ppp5v2z5y5liQROfGdOA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB7384.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:451::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 08:48:42 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0315.016; Wed, 19 Aug 2026
 08:48:42 +0000
Date: Wed, 19 Aug 2026 17:48:40 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-pci@vger.kernel.org, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: rcar-gen4: Fix potential unclocked access in
 rcar_gen4_pcie_ep_deinit()
Message-ID: <gnv6rbodtisekx7hvlwdmdzj5r3hdutbeexqde4gw3jodadwoj@rnukrhteykir>
References: <20260813091925.71363-1-marek.vasut+renesas@mailbox.org>
 <h43onk4priskfkvdrheml4ttx2b7udavnulxvftj45midvcs3c@lec5rx7mrgys>
 <CAMuHMdUAph2fbR94k8RDaAeVH=OTKWAWe1dJne9D-YbQQrYHsA@mail.gmail.com>
 <zi6an774rs4zsvz4rgvskvchlcz3ontuih7ztime673pw55axf@updaznhtexix>
 <0e5dae39-3ded-4b24-b3aa-7707983ec243@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e5dae39-3ded-4b24-b3aa-7707983ec243@mailbox.org>
X-ClientProxiedBy: TY4PR01CA0114.jpnprd01.prod.outlook.com
 (2603:1096:405:379::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB7384:EE_
X-MS-Office365-Filtering-Correlation-Id: 21377af2-ec35-4bf9-24a5-08defdceabc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016|23010399003|18002099003|22082099003|56012099006|6133799003|5023799004|4143699003|10067099003|27256017;
X-Microsoft-Antispam-Message-Info:
	F5jVU1BhLxVp3UJqRnVyEcXsA0RdogFnpZGeS+tcSb8xqUn5xDKN1gh4ypa857adyb0xCIp0NOremb0RXoiWN/A7vrFy0Fnzf1zcskuGh7ab2kB5cO2PlaOsn1thyfeoyhYuFGuv8kbFeiY0p2g38EgGl3dr2PN1I5obKZRDmLkkYHkqniNZ8gCE4B1/sAHMLikQVc+Rv+SX9HkpzGnDXNeE2inzGp2RHZPNbqe7NMh0E+KwasuA4HkSd4pP0LdQ0Jlbl4P2hxVpXYhAioyOpoo5hTkELRUbSVu53292yy17aHirib1pxwFizoc22mOCzvjXyh8vu3206dnngHHOI45L8u/iJotLGVEdSFRKMai0AeMxjaBQigOKc3tqR4GJFJE88IWqncktd/xAYsmRz2Di7fxUb5q//2quwn3F/6sgxHd6KjlA1731yJE7ZuylHGgLWmISke/GGlk2yp2VdTRX4GgTytr9+SYhWt0KI78OKjfdyAhCLXQeEx5KGvL2+HovxjOY96rGE+qTtmhknMRKxk/aTr4Wfp0wMxOJRaSgU4Qny7OlEHTtpoc74qtk6uyf+oShKxwVBTQj8bExh1vRJYqYfbg6gvqhryay6dZOy0vjacUPjKSE4d8zHJI6XQ6fAfv/h86m7SunnksHPa9xjPDKmORmKMX/WrjVi8ulYHGQ5B7n2nVFuU6Sqo8an8gwyhnUPoPcuZkOKZKR3Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(56012099006)(6133799003)(5023799004)(4143699003)(10067099003)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rxVbwvsCx/ERipjgvKue7wWcqLyq96iSMyhdpuJaqMHVw9zH3lMK8N0ZhQW0?=
 =?us-ascii?Q?yQL53Qyv6jQync03tMEnWbECRXdsS/wLWiLkWKl5d0uwcm4pio8yaU8wC4Vk?=
 =?us-ascii?Q?t/Ed94/+AuJHh50unFUBZuZ5osZOVvv3UtWIKbBzpxWbJRhV/CtFFgwYy2e3?=
 =?us-ascii?Q?qbd3V8hMyMizz0M1i5C9m+etnLWZGLUNE6/+wrJ2a0Hwxovm2xG7mRrmSGdc?=
 =?us-ascii?Q?DiCqV6zR05K0Z2kKqIrXIzkYuzfBl+vzUFyhJkP/v/L1FNw/vAEkn4PM6B0K?=
 =?us-ascii?Q?jhQbYneMmeSO0Tvsddt74RYO07daVww8NJX/l6zBC/Seiags5yGoPm/jI8x0?=
 =?us-ascii?Q?js5PTDOKTGvcVTvuA6Gzf3Z9lqNeN2TIKRNCvk/Nuxr+VXzuA/95XJaiegtM?=
 =?us-ascii?Q?0V4e30nRrJCfFliWyFEQdtEPzBWGaaOZnGA3Ji+zoQUYql+RqRmCvIPP3eq2?=
 =?us-ascii?Q?QfmQXXNcewIsoV6ZEneMfBbXKY+lI/PvZn2IJ6zl05GxjDPE+5SySuBEe5le?=
 =?us-ascii?Q?EYTjXL3mVWq1L3MVOYGSQOmPQc1ALAMhpPzhwxhM7th9ZzgOOxAQwBwArJFH?=
 =?us-ascii?Q?YI8y65PTN60/0MuqoL8cUSWngnplNHIu3mZMsk2XOWqwC3l34zovNtWvekLV?=
 =?us-ascii?Q?ZGvt7uKPxHeFxdGxNRfQDYuwcvTxOuUwNhf+h1K4Dr7Nw89KyK6n6Ei5Cces?=
 =?us-ascii?Q?dvNE76WrhsSHnq52syCwkkwpb0QvXNCrQcSXy5BPKu7qKjgbJx2QzHlNbwhM?=
 =?us-ascii?Q?p3zNWvGUsx9O/rDjP2G8uBCgKU8NuwVImaKarCb6CVHi7ceIhm70gPw//LQO?=
 =?us-ascii?Q?cWm3AZTMJ5rl3LdgU+o1WR3hHZNfOHsSWvkwJeQwP+ErIxcX0zIzkJtxWh8/?=
 =?us-ascii?Q?sC33O/bd/YYZZ0zIByp6LvqfFlyuNLLdg1DowR0gi5GEvQJEMa+ysIg8LKd/?=
 =?us-ascii?Q?BR8TiR1fdYaOiNWRxZ2FXdjYStORD1MQefzmwQGqXAhZGX2hN8vM2Z3mkwh6?=
 =?us-ascii?Q?XHOgjBZ3ZZVR+J3SNKlk1V2gFmT5R3SWPgOJPLfBYBmfyORM7sPEsWClbnif?=
 =?us-ascii?Q?ocMJ8mNc+Q3nxh9v5+huV1BzgsldA7nA5VgVprzDXrnJkDadCky7b2VIza22?=
 =?us-ascii?Q?z+gA0vSLqImomXt5BkHJXEcW1ydjqiziw/2Krdhw5fx8OTna2Zrbat5vCcju?=
 =?us-ascii?Q?QwL1HxfcxK5mAPDPKZTs9uYuEr8H5P+ZxBIhQ+I3rOa+TzFBAXj0exodl9Sf?=
 =?us-ascii?Q?CCuXYZ86WhiiZ/8d5H2Voxl4hVSJwYb/IyLqLt/d7PQpAKspzVCFfW5+hiFF?=
 =?us-ascii?Q?5xhZ7mSWwzivTa/yfiQqrOS8d8MQ3AneRplkmguhDaR0GLrVrR/M9gib79c4?=
 =?us-ascii?Q?4BOYsDG3nIQ/c9YK2r83d0SS5h/CSr44F623nU1iY63HeDtSVU/OkRGiT1ux?=
 =?us-ascii?Q?cGnApFV9tetKWb7BsHwKzFjj7mmbPDFAPOUO01jTOP4912bgXKrEEaA+XFqa?=
 =?us-ascii?Q?AnM9cs7n9B23yr2/3BoSFXCAgu6Y5vWfv+7LhyxMony0LjtMFtN9w88ihnL/?=
 =?us-ascii?Q?18K7xe6jRbO7E+Fatu/1bzlT+LZehwRagVgt7xMD6RuV/HoO+tF6al4b+Z8j?=
 =?us-ascii?Q?Ow5gqIZVjtrBmcEfJ8jhWgscJDfP2jOgz3x6OEWakjVJcBNxEsi7ry0JUbSQ?=
 =?us-ascii?Q?XH+46L39IZ8ewWkvqUYmGRp2XOLRjX8h6XjRiXAV7WhjBIhD3Fbv9c+R8uAL?=
 =?us-ascii?Q?pzJ2Fx/vkmnWJrtGVkAEdx0ejF8QVjWXigy9sBd9Bc5oOSGDNcSF?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 21377af2-ec35-4bf9-24a5-08defdceabc4
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 08:48:42.1520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCgpnrZ+yJzHyEasxOg9JioJgr41a6K+VwzB1GxthRbn7wXYb8bUeCRpGVBZ6x7z/oD8MktkvrjHbDA+dcR6Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7384

On Wed, Aug 19, 2026 at 08:28:39AM +0200, Marek Vasut wrote:
> On 8/18/26 5:09 PM, Koichiro Den wrote:
> 
> Hello Den-san,
> 
> > I see, CPG_MOD 624. Thanks! Then I am not sure the original writel() is actually
> > unclocked. It runs before pm_runtime_put(), so runtime PM still keeps that clock
> > enabled. If "unclocked" means ref clock instead, the new writel() also runs
> > before clk_bulk_prepare_enable(). Probably I'm missing something again. I would
> > appreciate it if you could shed light on this.
> 
> This is clearly my error, the commit message is poorly written.
> 
> The rcar_gen4_add_dw_pcie_ep() contains two calls which can fail,
> dw_pcie_ep_init() and dw_pcie_ep_init_registers().
> 
> The first one, dw_pcie_ep_init(), internally calls .pre_init callback, which
> is implemented in rcar_gen4_pcie_ep_pre_init() on R-Car Gen4 .
> 
> The rcar_gen4_pcie_ep_pre_init() internally calls
> rcar_gen4_pcie_common_init(), which may succeed or fail. At this point, two
> possibilities can happen, the fail one is of interest:
> - If rcar_gen4_pcie_common_init() succeeds , then clk_bulk_prepare_enable()
> in rcar_gen4_pcie_common_init() did enable all dw->core_clks and those clock
> are kept enabled on exit from rcar_gen4_pcie_common_init() . The return
> value from rcar_gen4_pcie_common_init() is 0. OK.
> - If rcar_gen4_pcie_common_init() failed, then clk_bulk_disable_unprepare()
> is called in rcar_gen4_pcie_common_init() fail path and dw->core_clks clock
> are disabled. Return value from rcar_gen4_pcie_common_init() is non-zero.
> NG.
> 
> Back in rcar_gen4_pcie_ep_pre_init():
> - If rcar_gen4_pcie_ep_pre_init() succeeded , then write PCIEDMAINTSTSEN and
> enable edma_int , and exit with return value 0, OK.
> - If rcar_gen4_pcie_common_init() failed, then immediately exit with return
> value non-zero. Do not write PCIEDMAINTSTSEN and do not enable the
> edma_interrupts, do depend on previously set content of PCIEDMAINTSTSEN
> register, which was zeroed out at the beginning of this function instead.
> NG.
> 
> Finally, back in rcar_gen4_add_dw_pcie_ep():
> - If dw_pcie_ep_init() failed, then dw->core_clks have to be disabled at
> this point (*), and PCIEDMAINTSTSEN register is 0, therefore, do not call
> rcar_gen4_pcie_ep_deinit() which writes PCIEDMAINTSTSEN register to 0
> (again) and calls rcar_gen4_pcie_common_deinit(), directly call
> rcar_gen4_pcie_common_deinit() (**).
> 
> But as I wrote this part, I realized the (*) is not true, and
> rcar_gen4_pcie_common_deinit() is not the correct function to call in case
> dw_pcie_ep_init() fails.
> 
> I think we might need this kind of a patch:
> 
> "
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c
> b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index de8ee3db43601..a5801a74dec67 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -1553,7 +1553,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>                                ep->page_size);
>         if (ret < 0) {
>                 dev_err(dev, "Failed to initialize address space\n");
> -               return ret;
> +               goto err_deinit;
>         }
> 
>         ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
> @@ -1568,6 +1568,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> 
>  err_exit_epc_mem:
>         pci_epc_mem_exit(epc);
> +err_deinit:
> +       if (ep->ops->pre_deinit)
> +               ep->ops->pre_deinit(ep);
> 
>         return ret;
>  }
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h
> b/drivers/pci/controller/dwc/pcie-designware.h
> index 0735ae9409240..733d8b6ad6d2b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -475,6 +475,7 @@ struct dw_pcie_rp {
> 
>  struct dw_pcie_ep_ops {
>         int     (*pre_init)(struct dw_pcie_ep *ep);
> +       void    (*pre_deinit)(struct dw_pcie_ep *ep);
>         int     (*init)(struct dw_pcie_ep *ep);
>         int     (*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
>                              unsigned int type, u16 interrupt_num);
> "
> 
> Then implement .pre_deinit callback for R-Car Gen4 such, that it would
> assert reset and stop the dw->core_clks by calling
> rcar_gen4_pcie_common_deinit(). Then we are sure (*) is true.
> 
> Finally, if dw_pcie_ep_init() call in rcar_gen4_add_dw_pcie_ep() fails, then
> with the aforementioned deinit implementation, I think it will be possible
> to simply do the following to cover (**).
> 
> ret = dw_pcie_ep_init(ep);
> if (ret)
>   return ret;
> 
> (I am also attaching the entire example as a diff, compile tested only thus
> far)
> 
> What do you think ?

Hi Marek,

Thanks for sharing your thoughts.

I think the callback idea is much cleaner. I wonder if .post_deinit might
describe its role more clearly.


P.S. I took a quick look through the related call paths, and it made me wonder
if we could take this a little further. Perhaps dw_pcie_ep_deinit() could call
the same hook at the end (I use .post_deinit as a tentative name below):

  dw_pcie_ep_init()
    -> .pre_init()
    -> generic intialization
    error:
      -> generic unwind
      -> .post_deinit()

  dw_pcie_ep_deinit()
    -> generic teardown
    -> .post_deinit()

Then would let the generic init/deinit pair own both hooks, and the
pcie-rcar-gen4 driver would no longer need to call rcar_gen4_pcie_ep_deinit()
separately. After dropping those explicit calls, the function could naturally be
renamed rcar_gen4_pcie_ep_post_deinit() and be used only as the hook.

This might be too much for this small fix. Even without this wider change,
however, I think rcar_gen4_pcie_ep_pre_deinit() should do the same operations as
rcar_gen4_pcie_ep_deinit(), rather than only calling common_deinit(). For
example, if pci_epc_mem_init() fails after .pre_init() succeeds, PCIEDMAINTSTSEN
is already 0xffff, and common_deinit() does not clear it.

Best regards,
Koichiro

> 
> > P.S. I also ran two error injection experiments on an S4 Spider. This is also
> > related to question #2 in my previous comment.
> > 
> > - When I injected a failure inside common_init(), its error path unwound the
> >    bulk clocks itself. Calling common_deinit() afterwards triggered "already
> >    disabled/unprepared" warnings.
> 
> I think this ought to be addressed by the pre_deinit above.
> 
> > - When I injected a failure after pre_init() had succeeded, PCIEDMAINTSTSEN read
> >    back as 0xffff both before and after common_deinit().
> 
> I think that with the aforementioned pre_deinit implementation, in case
> pre_init succeeded and a failure occurred in dw_pcie_ep_init_registers()
> instead, the PCIEDMAINTSTSEN will be cleared in rcar_gen4_pcie_ep_deinit()
> correctly.
> 
> Does that cover this concern or is there another fail path which I missed ?
> 
> > So I think clean-up needs to know whether pre_init() completed, rather than
> > always calling common_deinit(). Something like this (field declaration omitted):
> > 
> > --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > @@ -487,17 +487,24 @@ static int rcar_gen4_pcie_ep_pre_init(struct dw_pcie_ep *ep)
> >          struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> >          int ret;
> > 
> >          ret = rcar_gen4_pcie_common_init(rcar);
> >          if (ret)
> >                  return ret;
> > 
> >          writel(PCIEDMAINTSTSEN_INIT, rcar->base + PCIEDMAINTSTSEN);
> > +       rcar->ep_pre_init_done = true;
> > 
> >          return 0;
> >   }
> > 
> >   static void rcar_gen4_pcie_ep_deinit(struct rcar_gen4_pcie *rcar)
> >   {
> > +       if (!rcar->ep_pre_init_done)
> > +               return;
> > +
> > +       rcar->ep_pre_init_done = false;
> >          writel(0, rcar->base + PCIEDMAINTSTSEN);
> >          rcar_gen4_pcie_common_deinit(rcar);
> >   }
> > 
> > I may be missing something again, so please just take it with a pinch of salt.
> Thank you for your feedback, it allowed me to find an error in my train of
> thoughts, it is very much appreciated. I hope we can also find a good
> solution.
> 
> Thank you for your help !
> 
> -- 
> Best regards,
> Marek Vasut


