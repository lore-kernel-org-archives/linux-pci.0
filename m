Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out-2.mail.amis.net ([212.18.32.14]:58055 "EHLO
        out-2.mail.amis.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752634AbdBUN0c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Feb 2017 08:26:32 -0500
To: linux-pci@vger.kernel.org
Cc: Richard.Zhu@freescale.com, l.stach@pengutronix.de
From: Primoz Fiser <primoz.fiser@norik.com>
Subject: PCI: imx6: writing to PCI BAR memory while LTSSM != 0x11 hangs CPU
Message-ID: <eb16bfdd-13ef-6d77-fafa-431e4ecafdef@norik.com>
Date: Tue, 21 Feb 2017 14:20:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello all,

I am in a process of developing custom EP device driver on i.MX6Q.

Basically we have two i.MX6Q devices connected over PCIe. One implements 
RC (Linux 4.1 fslc) and the other implements EP (bare-metal, based on 
freescale SDK).
The communication is working as expected (BAR memory accessible by both 
parties, MSIs working, etc).

But we have constrain where we want to take down (power-cycle) EP 
asynchronously (without notifying RC - Linux side) and recover afterwards.
Basically EP side can reset itself at any time and RC doesn't know about 
it!
After resetting, EP is in its initial state & unconfigured. 
Communication is not working and we have to restore PCI configuration 
space again afterwards...

The problem arises when our custom driver accesses BAR memory while EP 
is resetting / power-cycling.

* On read access to BAR memory (eg. ioread32() in driver), an ARM 
exception (data abort) is triggered and we can attach handler to it with 
hook_fault_code().
This is already done in "drivers/pci/host/pci-imx6.c" with:

/* Added for PCI abort handling */

    hook_fault_code(16 + 6, imx6q_pcie_abort_handler, SIGBUS, 0,
                 "imprecise external abort");


and default handler (imx6q_pcie_abort_handler) is called on data abort.
We modified default abort handler which simply returns 0 (SUCCESS) and 
doesn't handle errors at all, to return all 0xFFFFFFFF in such cases.

* However on write access to BAR memory (eg. iowrite32() in driver) 
there is no such exception.
In most cases the hardware can handle write to broken PCI memory just 
fine (no error, no hang, no exception, etc) except if we do PCI write 
right when LTSSM state changes.
In such case we observe instant SoC hang!
This is how we can replicate bug:
- we add below dummy loop to write() in our custom driver (just for 
testing!!!!):

    pr_warn("entering endless loop - replicating SoC hang\n");
    while(1) {
         iowrite32(1, &private->status_flag);
    }

- in the loop we repeatedly write to &private->status_flag (MMIO, EP's 
BAR memory),
- we then reset/power-cycle our EP (using custom serial protocol)
- we observe instant SoC hang without PCIe abort handler being called!!!

[root@host ~]# echo 1 > /dev/imx6ep
[   48.440212] imx6ep: entering endless loop - replicating SoC hang
using serial port
send: CPUCTRL_RESET_ID seq=41 [03]

(STUCK SoC HERE)

On the other hand if we test above dummy loop with ioread32() instead of 
iowrite32() we get abort handler called and we can fix a problem.

Does anyone have an idea how to prevent i.MX6Q SoC from hanging itself 
on PCI write while ltssm state != 0x11?
Must we avoid touching BARs when LTSSM in incorrect state?
Can this be considered as an errata?

I also tried asking in chip vendor designated forums but no answer was 
given, so this mailing list is my last resort.

Regards,
Primoz
