Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:57951 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756515Ab2GJRMY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jul 2012 13:12:24 -0400
Received: by bkwj10 with SMTP id j10so266180bkw.19
        for <linux-pci@vger.kernel.org>; Tue, 10 Jul 2012 10:12:23 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 10 Jul 2012 10:12:22 -0700
Message-ID: <CAD-6qVV0jqqKo729MtWpSxsvfo6r3mB68o+dnZv9MHtvYJq6Fg@mail.gmail.com>
Subject: how to do mmap for cacheable PCIe BAR on x86
From: Alex <solomatnikov@gmail.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I am trying to write a driver with custom mmap() function for PCIe
BAR, with the goal to make this BAR cacheable in the processor cache.
I am aware this is not the best way to achieve highest bandwidth and
that the order of writes is unpredictable (neither are the issues in
this case).

The processor is Sandy Bridge i7, PCIe device is Altera Stratix IV dev. board.

First, I tried to do it on CentOS 5 (2.6.18). I changed the MTRR
settings to make sure the BAR is not within uncacheable MTRR and used
io_remap_pfn_range() with _PAGE_PCD and _PAGE_PWT bits cleared. Reads
worked as expected: reads returned correct values and second read to
the same address does not necessarily cause the read to go to PCIe
(read counter was checked in FPGA). However, the writes caused the
system to freeze and then reboot.

Second, I tried to do it on CentOS 6 (2.6.32), which has PAT support.
The result is the same: reads work correctly, writes cause system
freeze and reboot. Interestingly, non-temporal/write-combining full
cache line writes (AVX/SSE) work as expected, i.e. they always go to
FPGA and FPGA observes full cache line writes, reads return correct
values afterwards. However, simple 64-bit writes still cause system
freeze/reboot.

The message on the screen: Machine Check Exception: 5 Bank 5: be2000000003110a.

Third, I also tried to ioremap_cache() and then iowrite32() inside the
driver code. The result is the same.


I also tried to do the same thing on 2-socket Sandy Bridge (Romley):
reads and non-temporal write behavior is the same, simple writes do
not cause MCE/crash but have no effect on system state, i.e. value in
memory does not change.

Also, I tried the same code on older 2-socket Nehalem system: simple
writes also cause MCE, although the codes are different.


I think it is a hardware issue but I would appreciate if somebody can
share any ideas about what's going on.
Alex
