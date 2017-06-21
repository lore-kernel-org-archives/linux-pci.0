Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:36255 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbdFUIjd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jun 2017 04:39:33 -0400
Received: by mail-io0-f174.google.com with SMTP id y77so6919210ioe.3
        for <linux-pci@vger.kernel.org>; Wed, 21 Jun 2017 01:39:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 21 Jun 2017 10:39:31 +0200
Message-ID: <CACRpkdZ1rBq9eLJkz_gRuXAG=if+xXf-jPzDEPCfG8EgUmUG3A@mail.gmail.com>
Subject: Re: [RFT PATCH v2 00/42] PCI: ARM/ARM64: remove pci_fixup_irqs() usage
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Minghuan Lian <minghuan.Lian@freescale.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Roy Zang <tie-fei.zang@freescale.com>,
        Matthew Minter <matt@masarand.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 8, 2017 at 4:13 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:

I pulled this into the Gemini tree:
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git pci/pci-fixup-irqs-removal-v2

And then this happens:

OF: PCI: host bridge /soc/pci@50000000 ranges:
OF: PCI:    IO 0x50000000..0x500fffff -> 0x00000000
OF: PCI:   MEM 0x58000000..0x5fffffff -> 0x58000000
Unable to handle kernel NULL pointer dereference at virtual address 00000070
pgd = c0004000
[00000070] *pgd=00000000
Internal error: Oops: 17 [#1] PREEMPT ARM
CPU: 0 PID: 254 Comm: kworker/0:1 Not tainted 4.12.0-rc3+ #888
Hardware name: Gemini (Device Tree)
Workqueue: events deferred_probe_work_func
task: c38c3a40 task.stack: c390a000
PC is at faraday_pci_probe+0x274/0x65c
LR is at __irq_put_desc_unlock+0x18/0x70
pc : [<c0232648>]    lr : [<c004be48>]    psr: 80000013
sp : c390bdf0  ip : c3424274  fp : c3ac2ee0
r10: c3f77718  r9 : c3ad49b0  r8 : c3907800
r7 : 00000004  r6 : c390be18  r5 : c3907810  r4 : c3ad4810
r3 : 00000000  r2 : 00000000  r1 : 00000001  r0 : c3ac2de0
Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 0000397f  Table: 03a9c000  DAC: 00000053
Process kworker/0:1 (pid: 254, stack limit = 0xc390a190)
Stack: (0xc390bdf0 to 0xc390c000)
bde0:                                     c0534a60 c3ad49b0 00000003 c024cb68
be00: 00000001 20000013 00000000 50000000 00000007 000020dd c3ae2680 c3ae2740
be20: c07c861f c0134328 00000000 c3ad5fa0 c3910a50 c3910a50 00000001 00000000
be40: 00000000 c01344ec c3910a50 c3910a50 00000001 00000000 c3910a50 c39d76e0
be60: c3ad5fa0 c05f6f58 c3910a50 c3907810 c3907810 c07cba88 fffffdfb 00000003
be80: 00000000 c07c5040 c386e420 c02bbbe0 c3907810 c081c6c4 00000000 c07cba88
bea0: 00000003 c02ba9dc 00000000 c390bee0 c02bab30 00000001 c07bf660 00000000
bec0: c07c5040 c02b93dc c382829c c39886f4 c3907810 c3907844 c3907810 c02ba674
bee0: c3907810 00000001 c390bf0c c3907810 c07d3a80 c3907810 c07d38e4 c02b961c
bf00: c3907810 c07d38d0 c07d38d0 c02ba210 c07d38ec c386e420 00000000 c3f6b100
bf20: c07bf660 c002dac0 00000008 c07bf660 c07bf660 c386e438 c390a000 c07bf674
bf40: 00000008 c07bf660 c07c5040 c002e044 c390a000 00000001 00000000 00000000
bf60: c3901518 c3901500 ffffe000 c38e2700 00000000 c3901518 c386e420 c002ddb4
bf80: c3839ee4 c00335ec c390a000 c38e2700 c003350c 00000000 00000000 00000000
bfa0: 00000000 00000000 00000000 c000a270 00000000 00000000 00000000 00000000
bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bfe0: 00000000 00000000 00000000 00000000 00000013 00000000 ffffffff ffffffff
[<c0232648>] (faraday_pci_probe) from [<c02bbbe0>]
(platform_drv_probe+0x50/0xb4)
[<c02bbbe0>] (platform_drv_probe) from [<c02ba9dc>]
(driver_probe_device+0x248/0x2dc)
[<c02ba9dc>] (driver_probe_device) from [<c02b93dc>]
(bus_for_each_drv+0x68/0x98)
[<c02b93dc>] (bus_for_each_drv) from [<c02ba674>] (__device_attach+0xa8/0x110)
[<c02ba674>] (__device_attach) from [<c02b961c>] (bus_probe_device+0x88/0x90)
[<c02b961c>] (bus_probe_device) from [<c02ba210>]
(deferred_probe_work_func+0x54/0x80)
[<c02ba210>] (deferred_probe_work_func) from [<c002dac0>]
(process_one_work+0x13c/0x430)
[<c002dac0>] (process_one_work) from [<c002e044>] (worker_thread+0x290/0x5f4)
[<c002e044>] (worker_thread) from [<c00335ec>] (kthread+0xe0/0x120)
[<c00335ec>] (kthread) from [<c000a270>] (ret_from_fork+0x14/0x24)
Code: e59401b0 e3700a01 8a00001d e59421ac (e5d23070)
---[ end trace 1e313b1ea11e101c ]---

I'm trying to figure out what is causing it.

Yours,
Linus Walleij
