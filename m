Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail12.wdc04.mandrillapp.com ([205.201.139.12]:57395 "EHLO
	mail12.wdc04.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752119AbcBZALR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Feb 2016 19:11:17 -0500
Received: from pmta05.wdc01.mailchimp.com (127.0.0.1) by mail12.wdc04.mandrillapp.com id hpuc2a1jvjgs for <linux-pci@vger.kernel.org>; Fri, 26 Feb 2016 00:11:15 +0000 (envelope-from <bounce-md_30481620.56cf9823.v1-dea01e0ee526471d9f576446609046db@mandrillapp.com>)
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] PCI: keystone: fix msi code that retrieves the pp struct ptr
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: <stable@vger.kernel.org>, <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Message-Id: <20160226001114.GA10923@kroah.com>
References: <1456438984-22111-1-git-send-email-m-karicheri2@ti.com>
In-Reply-To: <1456438984-22111-1-git-send-email-m-karicheri2@ti.com>
Date: Fri, 26 Feb 2016 00:11:15 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 25, 2016 at 05:23:04PM -0500, Murali Karicheri wrote:
> Recent update to pcie-designware core driver,
> commit "cbce79005 PCI: designware: Make driver arch-agnostic" broke the
> keystone PCI driver. This is because, the way pp struct ptr is retrieved
> from  msi desc has changed and require similar update in pci-keystone-dw.c
> as well. This patch fix this issue. Here is the early boot crash log seen
> on K2E EVM.
> 
> [    1.012999] pci 0000:00:00.0: PCI bridge to [bus 01]
> [    1.018073] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
> [    1.024308] pci 0000:00:00.0:   bridge window [mem 0x60000000-0x600fffff]
> [    1.031216] pci 0000:00:00.0:   bridge window [mem 0x60100000-0x601fffff
> pref]
> [    1.038736] Unable to handle kernel NULL pointer dereference at virtual
> address 00000030
> [    1.046950] pgd = c0003000
> [    1.049750] [00000030] *pgd=80000800004003, *pmd=00000000
> [    1.055265] Internal error: Oops: 206 [#1] PREEMPT SMP ARM
> [    1.060860] Modules linked in:
> [    1.064013] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.4.2-00139-gb74f926 #2
> [    1.071266] Hardware name: Keystone
> [    1.074853] task: eb888000 ti: eb890000 task.ti: eb890000
> [    1.080364] PC is at ks_dw_pcie_msi_irq_unmask+0x24/0x58
> [    1.085785] LR is at ks_dw_pcie_msi_irq_unmask+0x18/0x58
> [    1.091206] pc : [<c02f65c8>]    lr : [<c02f65bc>]    psr: 60000093
> [    1.091206] sp : eb891bc8  ip : 00000000  fp : ebb15010
> [    1.102915] r10: 00000051  r9 : 60000013  r8 : ebafaa20
> [    1.108247] r7 : ebaa9f80  r6 : eb9fd0c0  r5 : ebafa9d0  r4 : ebafa9c0
> [    1.114889] r3 : 00000051  r2 : 00000000  r1 : 00000001  r0 : ebb14c18
> [    1.121533] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment
> kernel
> [    1.129049] Control: 30c5387d  Table: 00003000  DAC: fffffffd
> [    1.134905] Process swapper/0 (pid: 1, stack limit = 0xeb890210)
> [    1.141023] Stack: (0xeb891bc8 to 0xeb892000)
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> ---
>  - Need this fix in 4.4.4 as well

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
