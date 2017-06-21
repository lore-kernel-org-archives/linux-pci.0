Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20170621104538.GA8477@red-moon>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
 <CACRpkdZ1rBq9eLJkz_gRuXAG=if+xXf-jPzDEPCfG8EgUmUG3A@mail.gmail.com>
 <20170621103042.GA1712@red-moon> <20170621104538.GA8477@red-moon>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 21 Jun 2017 16:51:40 +0200
Message-ID: <CACRpkdbkKbSLE8TgaiAC3eh87tcUO0E3O-2=FRKr6mpJF=BViQ@mail.gmail.com>
Subject: Re: [RFT PATCH v2 00/42] PCI: ARM/ARM64: remove pci_fixup_irqs() usage
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 linux-pci <linux-pci@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
 Will Deacon <will.deacon@arm.com>, Michal Simek <michal.simek@xilinx.com>,
 Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>,
 Matthew Minter <matt@masarand.com>, Rob Herring <robh@kernel.org>,
 Joao Pinto <Joao.Pinto@synopsys.com>,
 Pratyush Anand <pratyush.anand@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Murali Karicheri <m-karicheri2@ti.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Simon Horman <horms@verge.net.au>, Bjorn Helgaas <bhelgaas@google.com>,
 Mingkai Hu <mingkai.hu@freescale.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>, Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Roy Zang <tie-fei.zang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 21, 2017 at 12:45 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:

>> > I'm trying to figure out what is causing it.
>>
>> Mind trying this patch please on top of my branch (compile tested, that's
>> all I can do)
>
> Sorry I miss yet another usage of struct pci_bus before bus is
> scanned in faraday_pci_parse_map_dma_ranges(), all these config
> accessors want is to access bus number 0 and writei/read some config
> values in there, please confirm.
>
> Updated patch here:
>
> -- >8 --
> Subject: [PATCH] drivers: pci: host: ftpci100: Remove pre-scan bus dependency
>
> Remove leftover pci_bus dependencies from the probe path.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Hm I tried this but sort of the same problem:

OF: PCI: host bridge /soc/pci@50000000 ranges:
OF: PCI:    IO 0x50000000..0x500fffff -> 0x00000000
OF: PCI:   MEM 0x58000000..0x5fffffff -> 0x58000000
Unable to handle kernel NULL pointer dereference at virtual address 00000070
pgd = c0004000
[00000070] *pgd=00000000
Internal error: Oops: 17 [#1] PREEMPT ARM
CPU: 0 PID: 254 Comm: kworker/0:1 Not tainted 4.12.0-rc3+ #894
Hardware name: Gemini (Device Tree)
Workqueue: events deferred_probe_work_func
task: c387f2c0 task.stack: c387c000
PC is at faraday_pci_probe+0x274/0x650
LR is at __irq_put_desc_unlock+0x18/0x70
pc : [<c02324e8>]    lr : [<c004be48>]    psr: 80000013
sp : c387ddf0  ip : c3424274  fp : c3ac0ee0
r10: c3f77718  r9 : c3ae09b0  r8 : c3906800
r7 : 00000004  r6 : c387de18  r5 : c3906810  r4 : c3ae0810
r3 : 00000000  r2 : 00000000  r1 : 00000001  r0 : c3ac0de0
Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 0000397f  Table: 03ab8000  DAC: 00000053
Process kworker/0:1 (pid: 254, stack limit = 0xc387c190)
Stack: (0xc387ddf0 to 0xc387e000)
dde0:                                     c0534a60 c3ae09b0 00000003 c024ca90
de00: 00000001 20000013 00000000 50000000 00000007 000020dd c3ae25c0 c3ae2700
de20: c07c861f c0134328 00000000 c3ae1fa0 c3913a50 c3913a50 00000001 00000000
de40: 00000000 c01344ec c3913a50 c3913a50 00000001 00000000 c3913a50 c39c16e0
de60: c3ae1fa0 c05f6f48 c3913a50 c3906810 c3906810 c07cba88 fffffdfb 00000003
de80: 00000000 c07c5040 c3916420 c02bbb08 c3906810 c081c6c4 00000000 c07cba88
dea0: 00000003 c02ba904 00000000 c387dee0 c02baa58 00000001 c07bf660 00000000
dec0: c07c5040 c02b9304 c382829c c39886f4 c3906810 c3906844 c3906810 c02ba59c
dee0: c3906810 00000001 c387df0c c3906810 c07d3a80 c3906810 c07d38e4 c02b9544
df00: c3906810 c07d38d0 c07d38d0 c02ba138 c07d38ec c3916420 00000000 c3f6b100
df20: c07bf660 c002dac0 00000008 c07bf660 c07bf660 c3916438 c387c000 c07bf674
df40: 00000008 c07bf660 c07c5040 c002e044 c387c000 00000001 00000000 00000000
df60: c39397d8 c39397c0 ffffe000 c38c4740 00000000 c39397d8 c3916420 c002ddb4
df80: c3839ee4 c00335ec c387c000 c38c4740 c003350c 00000000 00000000 00000000
dfa0: 00000000 00000000 00000000 c000a270 00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00030400 00080000
[<c02324e8>] (faraday_pci_probe) from [<c02bbb08>]
(platform_drv_probe+0x50/0xb4)
[<c02bbb08>] (platform_drv_probe) from [<c02ba904>]
(driver_probe_device+0x248/0x2dc)
[<c02ba904>] (driver_probe_device) from [<c02b9304>]
(bus_for_each_drv+0x68/0x98)
[<c02b9304>] (bus_for_each_drv) from [<c02ba59c>] (__device_attach+0xa8/0x110)
[<c02ba59c>] (__device_attach) from [<c02b9544>] (bus_probe_device+0x88/0x90)
[<c02b9544>] (bus_probe_device) from [<c02ba138>]
(deferred_probe_work_func+0x54/0x80)
[<c02ba138>] (deferred_probe_work_func) from [<c002dac0>]
(process_one_work+0x13c/0x430)
[<c002dac0>] (process_one_work) from [<c002e044>] (worker_thread+0x290/0x5f4)
[<c002e044>] (worker_thread) from [<c00335ec>] (kthread+0xe0/0x120)
[<c00335ec>] (kthread) from [<c000a270>] (ret_from_fork+0x14/0x24)
Code: e59401b0 e3700a01 8a00001d e59421ac (e5d23070)
---[ end trace 538dce2df8d99ba7 ]---

I will try to figure it out, just a bit short on time right now...

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
