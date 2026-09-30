Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020124.outbound.protection.outlook.com [52.101.228.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087303E867A;
	Wed, 30 Sep 2026 06:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790750293; cv=fail; b=oXzMB+lq7Ts1NjTtXm89gZYWMNMwcDY+BUt9lP9XAWC6KeZFzlWL73neOV1CrKVISSwBkr4z+mZ6sWm9qz6LeRGgdt/dCbKTUAp4zdngrsLlA6EV4Po4/U3oJv5S5SEmztfeixHc/rb0fAP0aa5hGYgpLfKuPsvG2uz+tiEZisA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790750293; c=relaxed/simple;
	bh=+xZgJPE8NFr2B0x67lmywzpT27J+amaTMrMeAnnM7OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dIr0iMAWZ1OJvuYNcChD4Xt3NXwJbrW5QTfZveY/nxuqfubWQLEq/f2VQb6I2+FExj5uy2pY2b4KEz364ZM4flODvZknWHPnaxmISKjR+1APJNTnKUGLNAPj/iZPL70xD9+cFS4ADYiPjwHDJKcEvTHsDa1QZOZS6HCDdi+NqY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Zp5Gli+c; arc=fail smtp.client-ip=52.101.228.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Zp5Gli+c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+HzYtzEMan7X3pjO+cdODVsVyFhvHUDjqbnCoxi2ocNWHQvK6+LPCH9zKe4Ffi3W5kyHXoZsgMeGkQgbKbgkvIowfM1sOSpPGHenUnnc2LSbXtXtZ4oDPCm7sbX72yMw7YFZ4wqL9wpk92xqyumGMxfLTWrFlyLwAq60++Imf8oB+Zzp2slD7/61PBayi05CnEgLwrSrqtpw4ZvuxM/u8JJZqq8AppzIucHY6YJMiPPhNhmPs6pX0zHfKb9MeDwk77YZpVVM8PxrbktfnioD9SNwT3a2Nb2A8lqHsm7I5SzmIkouTSanhXcR1gjEh0lD4MtPobRqTGG8Y+05bZlNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFL7VtQV/trSDgUR6VWdydchoDemWAi/Kd2wdjbAsyo=;
 b=IKfsLon+NFK7B9E1cecdgXSlX+75AIwfHLgwBLp8HGBe3rpbHZlhf8+JNmlTKT9mhXgQHeyB/jQzocJl68rPEOPxCCHV4FU1EerK1mU/nK5UYqmsr7UoOLYbDGf6RfK7R4lHqgj0c5em0K+vakRJIdb0I22mdvwwG7KvgGmVodXdXeEUOk0BtLCXdTm3VfVIvD5lAHIYaZ31HlnkxEAE/V2ao4htucHfmSo4S1rFdSwtqzIIJLG6K2tz054K9GXbBeGQWIIp42OY9PvGoXx6adu4WLasuSO8U5v+RJHib69K0p4tkbGDyW4CzR792tdm8D8RazFcpnCXI0yWPXwYEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFL7VtQV/trSDgUR6VWdydchoDemWAi/Kd2wdjbAsyo=;
 b=Zp5Gli+cmO7PKFT9ctBKasWenwWtynjWPDG/omey1TJZfrvYdiZC7TRce6k3O5KjW+MrYjPJHOBPwKqSIKQ9a6Vzb2MuFsJZ5Aun9Z/wkVqPczGO4JPBRh/N1twDSvKYc3euiIHzOchk8SPITnw79jVploGVTjT2TqLfGAVoaz4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS3P286MB2422.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:151::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 06:38:02 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.026; Wed, 30 Sep 2026
 06:38:02 +0000
Date: Wed, 30 Sep 2026 15:38:00 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Geert Uytterhoeven <geert@linux-m68k.org>
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
Subject: Re: [PATCH v2 10/15] PCI: rcar-gen4: Take over the iMSI-RX interrupt
Message-ID: <cmswtcb2i3todukcpra4vsqnkgu6w3wytxwvdqi2pvyep2j4kh@4dmmgyhkx7rp>
References: <20260928165230.3397664-1-den@valinux.co.jp>
 <20260928165230.3397664-11-den@valinux.co.jp>
 <CAMuHMdXoKFCroL1d6-fLwYR0UkLBL7suKy=rOFavioLd7rC4OA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXoKFCroL1d6-fLwYR0UkLBL7suKy=rOFavioLd7rC4OA@mail.gmail.com>
X-ClientProxiedBy: TY4P301CA0088.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::9) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS3P286MB2422:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aa03190-27e3-4d3f-edf2-08df1ebd6011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|10070799003|18002099003|22082099003|4143699003|6133799003|10067099003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	idF7PZjcoHS9qFGg3PRsXHQh7jorMME9zaWdriTmC7CTQ5PtJYNZqeDoVtRA2CWkSKPKXymnJ9KUSu6LC/z7TZYIqqVLGKYsfkq+ui4mHcV/So8U3zaLVKusAQS4JWKG34ewYl4jZMBmu8OHVPQc7GevU2EwhSaB8xbggq7HMvanVGHmwOIwh2Yqe5vHzHAf4C/732KiOC1fyTKxmtDQJETnnfnfTfXcNkiaNF/M/oXDMYYtB9uo+lRSa5aGumQk64/azklfjWTawy5DHHlnb+FVOkhMRDgucsa4Ar8+IurUSAi0ZVV3WIldStdnos7Giw3LOR3cOPKlV2t5EWk2T9pj9Vdw13S0MCjaX/EQfB1TjFy9pTHw3fb0xpapJmQiTkafTQ0RNax43eXdYVwuyJ+3rqgw0NHJd5lmtB5BhRQ0JwtPSZJh7pufwEiQH2U1UABvyVNFI/1+a4HDndY5r7yqGGzGiq2im/8S/DyDSBrxi0gnqcAJyoZ5G2WjQS13w6G5hiQt3NhQJJ/951ffrJcFJ1weIELs7o9yKX7my8b96dQx66V12RavW5KLhhp+P1L9qYPslWp2zrhs5a6ESRVbo006gWjmiBLf87mptaD524gUmVU3MvzCnjoV/Lk4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10070799003)(18002099003)(22082099003)(4143699003)(6133799003)(10067099003)(56012099006)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z5QX1kiZhfV/vgc9KgcfFJ/swiOei2KxHL6LfHyfYVZvjdgji/un2dMfvzyL?=
 =?us-ascii?Q?mMpaayevuo89L4dUuzDpqnAxD3lai4FaWPQhp8qSUsjqa6BoNsu/QIvOwnl+?=
 =?us-ascii?Q?SHK4lECWlvjOKjQJ8S8FqqKP81O47FKaL+cOUl1eW4r6WGiVEJXGZArV4t5J?=
 =?us-ascii?Q?55x/I1JV01bAaZK6IBLvRDXbHwk4FVN0CkYDQekg6XwKy7LBBEy8TI31XnbT?=
 =?us-ascii?Q?1Z85qCzVT0/NbHnPGIZMK4nwDeAN3VpbCTKk3ybcw7oQpqFrvspVIlbtshkA?=
 =?us-ascii?Q?W5DULUVJ2tTva5+TqeC9EndFQ3eXCr4qRBUL6HeSPmDFdjC9Oz1NA/IsZdbm?=
 =?us-ascii?Q?MH24MHZsLLdlB/PNodPZWOGKWyFl+8gtN465fQyRv7WZzDRQdtHFqOFEv2/F?=
 =?us-ascii?Q?FYBDisf6aLT0158DoXShJEtTjpVJBUMOT/7WN2doR5kmeUvBsv5H1d23YBR8?=
 =?us-ascii?Q?w2aAOHN/k+n7ZrO8iLfE3U8iUixFM3xoBo9tpUXqxLVLL9d6UvH+b6Eag/aK?=
 =?us-ascii?Q?SbIxNxyd+L17iBrH4vItsJRu5j6YJW2umnhRYL9wdea3y2/F27gyLnSPcciF?=
 =?us-ascii?Q?H+IwhRtS1C41OcaVMYPw8tWiMcnlaEMMEH6DQbG/UTkKdP7EJXz7BzYi6X1S?=
 =?us-ascii?Q?eY9hLEKH6a0Y1u9+g41FcV0TXh9nF92Hfp1blSzI+xml1dagfHWpz7Rn8azR?=
 =?us-ascii?Q?zxAOQ5gtmJz/MkDoQD4nphuKxESCNoouNQtYR7dbEKS0AiJS7GQIn6/FWNyd?=
 =?us-ascii?Q?LOIsSMYTOsOVKI1fwkzyBf9Se8HxeecvwWL0enrfcT6TwoC9W0d4MUt4wmXw?=
 =?us-ascii?Q?k+r03SxT7pO1zz1jcWnDzQqt5pqY0JbNfUhP0ut+tJDovO9ZQ/0muNlFZHtd?=
 =?us-ascii?Q?+acnl9a+1clYs2tBI26N8GltDqYh9rM/51UypzaVg2w4k33uwc9rgzmUW62p?=
 =?us-ascii?Q?ErK1ksq6T1dGWHLCTcaom2G9g/Fmi7cDXQ1eXTBeDB9qkqVVHAuHM6igZxJR?=
 =?us-ascii?Q?BXFH/rNNH7Zo015iRd53ENPXC5GJ0xCto3I15aDbN2Rpa/yAJ3MCm8Lq7+cZ?=
 =?us-ascii?Q?jwwOO/nbSrdXPeL4PyMR3ilkJWJRZDHB+tnp08NoymmSuKVBZOqVIVTjQfqR?=
 =?us-ascii?Q?JXY/BfYkwajbhyAFIy51rHwx30PQwksB2+C8rM0bMoO08gLLSNkIOLp8yaQG?=
 =?us-ascii?Q?HxZANnU/xWX9htutuphj55hLydANmSa6cZVZhx9S1260l6e4ePAufof5Vesz?=
 =?us-ascii?Q?9GBAHXtb2iaqDolJMnCNmGb7FUlE6gi/A0fX9mGJGG8NjS+DzGpYSJ2jc3sy?=
 =?us-ascii?Q?+Qfoql7/qrQ7ESZKwEGW8oyPKbBNPLWMQ9zgjv/R/gpChJHhUZkYKUULePh1?=
 =?us-ascii?Q?8W04hYL8BL9wLd3yrxxweemMYNqny9PmmIIWFQvhoaYLNEJuDiUDFvVsHrRP?=
 =?us-ascii?Q?69jT9yGN5MQsJJi5zyafyYrHuaPfOFoL09ClwnQMnnidiGA0WvTT6eS+oDbA?=
 =?us-ascii?Q?97wvEZdn2E3Z1o+X1nKtXwzxPC6lre6mAKojQkGhgBeeV3FCxGDVZlrQjpJi?=
 =?us-ascii?Q?XcsKkEQha3UwC6REb+7M8UK6PZC6itHE0PfEXFYWzZuO5S5I1p/1b8ZFkVDw?=
 =?us-ascii?Q?1bj704tbq6C2pMJdfjOiR0BDVTfRRbabNCx7vm3KxFcHdWxCUNK0GrKtC4jz?=
 =?us-ascii?Q?JJgXUBjCGPvyqBwPM4MX7WUJtNX62b8yabmPuf4BQN3IlsU36rCQVovdyH8B?=
 =?us-ascii?Q?XYDUyOx7oJpyD7u6MtGAZRSgL3zrpKhqipzwe4UAXMY67inUdOTB?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa03190-27e3-4d3f-edf2-08df1ebd6011
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 06:38:02.0609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z29doSdBAo29MvtNhoqCmRVykqHuoMocU265vL03QE5l6XXU8EJpzo9TnJYmE8h0A+SShXS3pnIC11+h093prg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2422

On Tue, Sep 29, 2026 at 07:43:28PM +0200, Geert Uytterhoeven wrote:
> Hi Den-san, Marek,
> 
> On Mon, 28 Sept 2026 at 18:53, Koichiro Den <den@valinux.co.jp> wrote:
> > On R-Car Gen4, intreq_pcim_sub ("msi") carries more than the integrated
> > MSI receiver: the controller's reset requests and the Root Port's PME
> > and bandwidth notifications are signalled on the same line, and the
> > following patches need to handle them. With the DesignWare core owning
> > the line through its chained handler, the driver would have to hook into
> > that handler when iMSI-RX is used and request the line itself otherwise.
> >
> > Instead, request the interrupt in the driver in all configurations and
> > set pp->msi_irq[0] to -ENODEV so the core does not install its chained
> > handler, as spear13xx, keembay and dra7xx do. The handler demultiplexes
> > the MSIs through dw_handle_msi_irq() when the APP block reports
> > msi_ctrl_int. With an external MSI controller or pci=nomsi the iMSI-RX
> > is not set up, so keep msi_ctrl_int masked rather than enabled, and the
> > handler has nothing to do there yet. Request the interrupt before
> > enumeration, as endpoint drivers may use MSIs from their probe, with
> > IRQF_NO_THREAD so the MSIs are demultiplexed in hard IRQ context like
> > the chained handler did. The interrupt is required by the binding.
> >
> > Release the interrupt in .deinit, before asserting the controller reset
> > and disabling its clocks. Disable it around a Root Port reset because
> > the handler accesses the MSI status registers through DBI.
> >
> > The DT routes downstream INTx to the same line, but the driver has never
> > supported INTx (no INTx domain, INTx enables never set), so requesting
> > the line exclusively takes nothing away.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> 
> Thanks for your patch!
> 
> FTR, this interacts badly with "[PATCH v2] PCI: rcar-gen4: Add missing
> PM ops"[1] during resume from s2idle:

Hi Geert, thanks for the heads-up.

I'll fix this in v3. I'm planning to address this together with the "Known gap"
noted below the commit message, by moving IRQ setup/teardown out of
.init()/.deinit(). On hindsight, I should have done so in v2. That should also
avoid freeing and re-requesting IRQs during suspend/resume, without needing
IRQF_NO_SUSPEND.

By the way, AFAIK Marek has posted v4 of the PM ops patch:
https://lore.kernel.org/r/20260922175525.288106-1-marek.vasut+renesas@mailbox.org/

I had only (re-)tested v3 on the EP side (not RC side):
https://lore.kernel.org/r/ain27ypszl767h3fygurivurojxctyjy2yprada6lgjef5c623@23nn7tsrecb6/
but while looking at your report and reproducing, I noticed that
rcar_gen4_pcie_host_ops lacks .pme_turn_off implementation,
so I wonder if it should also set 'pp->use_atu_msg = true'.

I mean, something like this:

------8<-------8<------
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 1f8821e3a424..b8237962de18 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -671,6 +671,8 @@ static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
                return -ENODEV;

        pp->num_vectors = MAX_MSI_IRQS;
+       /* Reserve an iATU window for the generic PME_Turn_Off implementation. */
+       pp->use_atu_msg = true;
        pp->ops = &rcar_gen4_pcie_host_ops;

        return dw_pcie_host_init(pp);

------8<-------8<------

Marek, I'd appreciate your thoughts on this too.
Perhaps this small change could be included in v5, if you agree.

Best regards,
Koichiro

> 
>     Unbalanced enable for IRQ 57
>     WARNING: kernel/irq/manage.c:775 at __enable_irq+0x38/0x64, CPU#3:
> s2idle/686
>     Modules linked in:
>     CPU: 3 UID: 0 PID: 686 Comm: s2idle Not tainted
> 7.3.0-rc5-rcar3-09216-ga295839bfe55 #696 PREEMPT
>     Hardware name: Renesas Gray Hawk Single board based on r8a779h0 (DT)
>     pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>     pc : __enable_irq+0x38/0x64
>     lr : __enable_irq+0x38/0x64
>     sp : ffffffc08904bab0
>     x29: ffffffc08904bab0 x28: ffffff8446a4a880 x27: ffffffc084e64828
>     x26: ffffffc084e64838 x25: ffffffc08069e630 x24: ffffff8443ad7cb0
>     x23: 0000000000000000 x22: 0000000000000000 x21: 0000000000000070
>     x20: 0000000000000039 x19: ffffff8443ad7c00 x18: 00000000e630bb27
>     x17: 0000000000000000 x16: 0000000000000000 x15: 0720072007200720
>     x14: 0720072007200720 x13: 0720072007200720 x12: 0000000000000566
>     x11: 0000000000000000 x10: ffffffc08418a038 x9 : ffffffc08158a090
>     x8 : ffffffc08904b798 x7 : ffffffc08904b7a0 x6 : 3ffffffffff7ffff
>     x5 : fffffffffff7ffff x4 : 0000000000000000 x3 : 0000000000000000
>     x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffff8446a4a880
>     Call trace:
>      __enable_irq+0x38/0x64 (P)
>      resume_irqs+0xf0/0x130
>      resume_device_irqs+0x10/0x18
>      dpm_resume_noirq+0xe8/0x190
>      suspend_devices_and_enter+0x524/0x594
>      pm_suspend+0x22c/0x270
>      state_store+0xa8/0xe8
>      kobj_attr_store+0x14/0x24
>      sysfs_kf_write+0x4c/0x64
>      kernfs_fop_write_iter+0x13c/0x184
>      vfs_write+0x148/0x1b4
>      ksys_write+0x78/0xe0
>      __arm64_sys_write+0x14/0x1c
>      invoke_syscall+0xa0/0x100
>      el0_svc_common.constprop.0+0xb0/0xcc
>      do_el0_svc+0x18/0x20
>      el0_svc+0x3c/0x114
>      el0t_64_sync_handler+0x58/0x134
>      el0t_64_sync+0x158/0x15c
>     irq event stamp: 0
>     hardirqs last  enabled at (0): [<0000000000000000>] 0x0
>     hardirqs last disabled at (0): [<ffffffc080092a2c>]
> copy_process+0x9e0/0x17b8
>     softirqs last  enabled at (0): [<ffffffc080092a34>]
> copy_process+0x9e8/0x17b8
>     softirqs last disabled at (0): [<0000000000000000>] 0x0
>     ---[ end trace 0000000000000000 ]---
> 
> [1] https://lore.kernel.org/20260907153711.653861-1-marek.vasut+renesas@mailbox.org/
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
