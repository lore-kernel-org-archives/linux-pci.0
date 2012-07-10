Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:62053 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751876Ab2GJTYi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 10 Jul 2012 15:24:38 -0400
Message-ID: <4FFC8174.8050208@redhat.com>
Date: Tue, 10 Jul 2012 15:24:36 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Alex <solomatnikov@gmail.com>
CC: linux-pci@vger.kernel.org
Subject: Re: how to do mmap for cacheable PCIe BAR on x86
References: <CAD-6qVV0jqqKo729MtWpSxsvfo6r3mB68o+dnZv9MHtvYJq6Fg@mail.gmail.com>
In-Reply-To: <CAD-6qVV0jqqKo729MtWpSxsvfo6r3mB68o+dnZv9MHtvYJq6Fg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/10/2012 01:12 PM, Alex wrote:
> I am trying to write a driver with custom mmap() function for PCIe
> BAR, with the goal to make this BAR cacheable in the processor cache.
> I am aware this is not the best way to achieve highest bandwidth and
> that the order of writes is unpredictable (neither are the issues in
> this case).
>
> The processor is Sandy Bridge i7, PCIe device is Altera Stratix IV dev. board.
>
> First, I tried to do it on CentOS 5 (2.6.18). I changed the MTRR
> settings to make sure the BAR is not within uncacheable MTRR and used
> io_remap_pfn_range() with _PAGE_PCD and _PAGE_PWT bits cleared. Reads
> worked as expected: reads returned correct values and second read to
> the same address does not necessarily cause the read to go to PCIe
> (read counter was checked in FPGA). However, the writes caused the
> system to freeze and then reboot.
>
> Second, I tried to do it on CentOS 6 (2.6.32), which has PAT support.
> The result is the same: reads work correctly, writes cause system
> freeze and reboot. Interestingly, non-temporal/write-combining full
> cache line writes (AVX/SSE) work as expected, i.e. they always go to
> FPGA and FPGA observes full cache line writes, reads return correct
> values afterwards. However, simple 64-bit writes still cause system
> freeze/reboot.
>
> The message on the screen: Machine Check Exception: 5 Bank 5: be2000000003110a.
>
> Third, I also tried to ioremap_cache() and then iowrite32() inside the
> driver code. The result is the same.
>
>
> I also tried to do the same thing on 2-socket Sandy Bridge (Romley):
> reads and non-temporal write behavior is the same, simple writes do
> not cause MCE/crash but have no effect on system state, i.e. value in
> memory does not change.
>
> Also, I tried the same code on older 2-socket Nehalem system: simple
> writes also cause MCE, although the codes are different.
>
>
> I think it is a hardware issue but I would appreciate if somebody can
> share any ideas about what's going on.
> Alex
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
Once moving the registers into cacheable address space, your
device may be getting a full cache block write with varying byte masks
set.  Does your FPGA handle such a large write packet with varying byte
masks?  or does it cause a PCIe error that gets translated into the
Machine-checks your seeing under various write cases?
i.e., even an iowrite32() will write an entire cache block with
       a large number of byte mask bits not set.

