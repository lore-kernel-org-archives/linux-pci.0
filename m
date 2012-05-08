Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35148 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753843Ab2EHQ2q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 May 2012 12:28:46 -0400
Received: by lbbgm6 with SMTP id gm6so4348538lbb.19
        for <linux-pci@vger.kernel.org>; Tue, 08 May 2012 09:28:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120508172153.b67a8cc6.izumi.taku@jp.fujitsu.com>
References: <1336186830-10765-1-git-send-email-jiang.liu@huawei.com> <20120508172153.b67a8cc6.izumi.taku@jp.fujitsu.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 8 May 2012 09:28:23 -0700
Message-ID: <CAErSpo4rwK60jdUQiN4ZES=toyq0Ugdd7iswW5z7tTOPskVNCA@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] PCI, x86: update MMCFG information when
 hot-plugging PCI host bridges
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: Jiang Liu <liuj97@gmail.com>, Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 8, 2012 at 1:21 AM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
>
> Hi Jiang,
>
>  I tested this pachset.
>  (to be honest, as I used Bjorn tree, I changed a little of Patch6/6
>   to apply to his tree.)
>
>  My machine failed to boot after applied your patchset.
>  The reason is:
>    My machine's MCFG table shows that End bus number is 0x13.
>
> [000h 0000  4]                    Signature : "MCFG"    /* Memory Mapped Configuration table */
> [004h 0004  4]                 Table Length : 00000040
> [008h 0008  1]                     Revision : 01
> [009h 0009  1]                     Checksum : 3E
> [00Ah 0010  6]                       Oem ID : "PTLTD "
> [010h 0016  8]                 Oem Table ID : "  MCFG  "
> [018h 0024  4]                 Oem Revision : 06040001
> [01Ch 0028  4]              Asl Compiler ID : " LTP"
> [020h 0032  4]        Asl Compiler Revision : 00000000
>
> [024h 0036  8]                     Reserved : 0000000000000000
>
> [02Ch 0044  8]                 Base Address : 00000000F0000000
> [034h 0052  2]         Segment Group Number : 0000
> [036h 0054  1]             Start Bus Number : 00
> [037h 0055  1]               End Bus Number : 13
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> [038h 0056  4]                     Reserved : 00000000
>
>   But CRS shows bus range is 0x00 - 0xff. So arch_acpi_pci_root_add() failed
>   because pci_mmconfig_insert() returns not -EEXIST but -EINVAL.
>
> [    0.094236] PCI: MMCONFIG for domain 0000 [bus 00-ff] conflicts with domain 0000 [bus 00-13]

The MCFG told us about MMCONFIG space for [bus 00-13], so we should
set that up.   I think it's a mistake to assume that MMCONFIG space
exists for [bus 14-ff].

For a bridge with _CBA, the spec says it applies to the bus range
specified in _CRS.  But we can not use the _CRS bus range with a base
address from MCFG.

> int __devinit pci_mmconfig_insert(int segment, int start, int end, u64 addr)
> {
> ..
> (snip)
> ...
>        mutex_lock(&pci_mmcfg_lock);
>        cfg = pci_mmconfig_lookup(segment, start);
>        if (cfg) {
>                if (cfg->start_bus <= start && cfg->end_bus >= end) {
>                        rc = -EEXIST;
>                } else {
>                        printk(KERN_WARNING PREFIX
>                               "MMCONFIG for domain %04x [bus %02x-%02x] "
>                               "conflicts with domain %04x [bus %02x-%02x]\n",
>                               segment, start, end,
>                               cfg->segment, cfg->start_bus, cfg->end_bus);
>                }
>                goto out;
>
>
>  My impression is my machine's firmware is broken.
>  Howerver my machine boots well without your patchset. So I report as a problem.
>
>
> Best regards,
> Taku Izumi <izumi.taku@jp.fujitsu.com>
>
