Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:34610 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906Ab2EIHV1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 May 2012 03:21:27 -0400
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 52E553EE0C0
	for <linux-pci@vger.kernel.org>; Wed,  9 May 2012 16:21:25 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 3412745DE57
	for <linux-pci@vger.kernel.org>; Wed,  9 May 2012 16:21:25 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 17A2445DE52
	for <linux-pci@vger.kernel.org>; Wed,  9 May 2012 16:21:25 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 003C81DB802F
	for <linux-pci@vger.kernel.org>; Wed,  9 May 2012 16:21:24 +0900 (JST)
Received: from m107.s.css.fujitsu.com (m107.s.css.fujitsu.com [10.240.81.147])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 795A31DB8041
	for <linux-pci@vger.kernel.org>; Wed,  9 May 2012 16:21:24 +0900 (JST)
Date: Wed, 9 May 2012 16:21:17 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Jiang Liu <liuj97@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 0/6] PCI, x86: update MMCFG information when
 hot-plugging PCI host bridges
Message-Id: <20120509162117.63d8c155.izumi.taku@jp.fujitsu.com>
In-Reply-To: <4FA950A5.6040106@gmail.com>
References: <1336186830-10765-1-git-send-email-jiang.liu@huawei.com>
	<20120508172153.b67a8cc6.izumi.taku@jp.fujitsu.com>
	<4FA950A5.6040106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 09 May 2012 00:58:13 +0800
Jiang Liu <liuj97@gmail.com> wrote:

> Hi Taku,
> 	Thanks for testing. Could you please help to try the patch below?

  Hi Jian,
  I confirmed this patch solves my problem.

  Best regards,
  Taku Izumi

> diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
> index a8da5d4..2551586 100644
> --- a/arch/x86/pci/mmconfig-shared.c
> +++ b/arch/x86/pci/mmconfig-shared.c
> @@ -708,6 +708,13 @@ int __devinit pci_mmconfig_insert(int segment, int start, int end
>         if (cfg) {
>                 if (cfg->start_bus <= start && cfg->end_bus >= end) {
>                         rc = -EEXIST;
> +               } else if (!addr) {
> +                       /*
> +                        * With some legacy BIOSes, the MCFG table only
> +                        * partially covers bus ranges returned by
> +                        * root bridges' _CRS method.
> +                        */
> +                       rc = -EEXIST;
>                 } else {
>                         printk(KERN_WARNING PREFIX
>                                "MMCONFIG for domain %04x [bus %02x-%02x] "
> 
> On 05/08/2012 04:21 PM, Taku Izumi wrote:
> > 
> > Hi Jiang,
> > 
> >  I tested this pachset.
> >   (to be honest, as I used Bjorn tree, I changed a little of Patch6/6 
> >    to apply to his tree.)
> > 
> >  My machine failed to boot after applied your patchset.
> >  The reason is:
> >     My machine's MCFG table shows that End bus number is 0x13.
> > 
> > [000h 0000  4]                    Signature : "MCFG"    /* Memory Mapped Configuration table */
> > [004h 0004  4]                 Table Length : 00000040
> > [008h 0008  1]                     Revision : 01
> > [009h 0009  1]                     Checksum : 3E
> > [00Ah 0010  6]                       Oem ID : "PTLTD "
> > [010h 0016  8]                 Oem Table ID : "  MCFG  "
> > [018h 0024  4]                 Oem Revision : 06040001
> > [01Ch 0028  4]              Asl Compiler ID : " LTP"
> > [020h 0032  4]        Asl Compiler Revision : 00000000
> > 
> > [024h 0036  8]                     Reserved : 0000000000000000
> > 
> > [02Ch 0044  8]                 Base Address : 00000000F0000000
> > [034h 0052  2]         Segment Group Number : 0000
> > [036h 0054  1]             Start Bus Number : 00
> > [037h 0055  1]               End Bus Number : 13
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > [038h 0056  4]                     Reserved : 00000000
> > 
> >    But CRS shows bus range is 0x00 - 0xff. So arch_acpi_pci_root_add() failed
> >    because pci_mmconfig_insert() returns not -EEXIST but -EINVAL.
> > 
> > [    0.094236] PCI: MMCONFIG for domain 0000 [bus 00-ff] conflicts with domain 0000 [bus 00-13]
> > 
> > int __devinit pci_mmconfig_insert(int segment, int start, int end, u64 addr)
> > {
> > ..
> > (snip)
> > ...
> >         mutex_lock(&pci_mmcfg_lock);
> >         cfg = pci_mmconfig_lookup(segment, start);
> >         if (cfg) {
> >                 if (cfg->start_bus <= start && cfg->end_bus >= end) {
> >                         rc = -EEXIST;
> >                 } else {
> >                         printk(KERN_WARNING PREFIX
> >                                "MMCONFIG for domain %04x [bus %02x-%02x] "
> >                                "conflicts with domain %04x [bus %02x-%02x]\n",
> >                                segment, start, end,
> >                                cfg->segment, cfg->start_bus, cfg->end_bus);
> >                 }
> >                 goto out;
> > 
> > 
> >   My impression is my machine's firmware is broken.
> >   Howerver my machine boots well without your patchset. So I report as a problem.
> > 
> >    
> > Best regards,
> > Taku Izumi <izumi.taku@jp.fujitsu.com>
> > 
> 
> 


-- 
Taku Izumi <izumi.taku@jp.fujitsu.com>

