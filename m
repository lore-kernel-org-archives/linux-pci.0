Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20180116093038.GA11827@red-moon>
References: <1516094147-4597-1-git-send-email-hiraku.toyooka@cybertrust.co.jp>
 <20180116093038.GA11827@red-moon>
From: Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>
Date: Tue, 16 Jan 2018 18:46:32 +0900
Message-ID: <CADPJy8U8FtxcwjEQAF2dVJ4yqeVisxEbPWNuCqRhhsRtRxKBtQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] PCI/MSI: add NULL check before use of msi_desc
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>, Joao.Pinto@synopsys.com,
 hongxing.zhu@nxp.com, linux-pci@vger.kernel.org, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, linux@armlinux.org.uk, jingoohan1@gmail.com,
 bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
 l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hello Lorenzo,

Thank you for telling me.
I missed the patch.

Best regards,
Hiraku Toyooka

2018-01-16 18:30 GMT+09:00 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>:
> On Tue, Jan 16, 2018 at 06:15:46PM +0900, Hiraku Toyooka wrote:
>> Hello,
>>
>> I found a NULL pointer dereference in PCI/MSI when I tried to run kdump
>> kernel on i.MX6(MCIMX6Q-SDB). This error occurs when masking MSI irq
>> which does not have msi_desc.
>> I added NULL check to avoid the error, and kdump worked fine. But I'm
>> not sure this is correct way. What do you think about this fix?
>
> It has been reported and it is being handled:
>
> https://marc.info/?l=linux-kernel&m=151321815226439&w=2
>
>> My environment:
>>  - Board:  MCIMX6Q-SDB
>>  - Kernel: 4.15.0-rc5 (commit: 464e1d5f23)
>>    - used also as kdump kernel
>>    - CONFIG_CRASH_DUMP and CONFIG_DEBUG_INFO are enabled based on imx_v6_v7_defconfig
>>  - U-Boot: u-boot-fslc (2017.11+fslc branch)
>>    - built with meta-freescale (commit: bf7fd9cfe0)
>>
>>
>> Console log in failure case (patch not applied):
>>
>> root@imx6qdlsabresd:~# cat /proc/cmdline
>> console=ttymxc0,115200 root=PARTUUID=6c7357c5-02 rootwait rw quiet crashkernel=96M
>> root@imx6qdlsabresd:~# kexec --type zImage -p /boot/zImage --dtb=/boot/imx6q-sabresd.dtb --append="console=ttymxc0,115200 root=/dev/mmcblk1p2 rootwait rw 3 maxcpus=1 reset_devices earlycon"
>> root@imx6qdlsabresd:~# echo c > /proc/sysrq-trigger
>> [   27.590895] sysrq: SysRq : Trigger a crash
>> [   27.595250] Unable to handle kernel NULL pointer dereference at virtual address 00000000
>> ...(snip)...
>> [   27.808001] Backtrace:
>> [   27.810502] [<c04d1a58>] (sysrq_handle_crash) from [<c04d206c>] (__handle_sysrq+0xd8/0x258)
>> [   27.818877]  r5:00000063 r4:c101a6b0
>> [   27.822489] [<c04d1f94>] (__handle_sysrq) from [<c04d2688>] (write_sysrq_trigger+0x78/0x90)
>> [   27.830871]  r10:00000000 r9:00000002 r8:00000000 r7:e6490c00 r6:00000000 r5:01ced738
>> [   27.838719]  r4:00000002
>> [   27.841290] [<c04d2610>] (write_sysrq_trigger) from [<c02979bc>] (proc_reg_write+0x68/0x90)
>> [   27.849664]  r5:00000000 r4:c04d2610
>> [   27.853277] [<c0297954>] (proc_reg_write) from [<c022e50c>] (__vfs_write+0x34/0x134)
>> [   27.861050]  r9:00000002 r8:01ced738 r7:00000002 r6:e71a9f78 r5:c0297954 r4:e6a49cc0
>> [   27.868824] [<c022e4d8>] (__vfs_write) from [<c022e78c>] (vfs_write+0xa8/0x170)
>> [   27.876162]  r9:00000002 r8:01ced738 r7:e71a9f78 r6:01ced738 r5:e6a49cc0 r4:00000002
>> [   27.883936] [<c022e6e4>] (vfs_write) from [<c022e96c>] (SyS_write+0x44/0x98)
>> [   27.891014]  r9:00000002 r8:01ced738 r7:00000000 r6:00000000 r5:e6a49cc0 r4:e6a49cc0
>> [   27.898797] [<c022e928>] (SyS_write) from [<c0107fe0>] (ret_fast_syscall+0x0/0x28)
>> [   27.906395]  r9:e71a8000 r8:c01081a4 r7:00000004 r6:b6f7eda8 r5:01ced738 r4:00000002
>> [   27.914169] Code: e3a04000 e5835000 ee074f9a ebf11af2 (e5c45000)
>> [   27.920332] CPU 1 will stop doing anything useful since another CPU has crashed
>> [   27.920342] CPU 0 will stop doing anything useful since another CPU has crashed
>> [   27.920351] CPU 2 will stop doing anything useful since another CPU has crashed
>> [   27.949670] Unable to handle kernel NULL pointer dereference at virtual address 00000028
>> [   27.957798] pgd = c30fc51b
>> [   27.960529] [00000028] *pgd=4a140831
>> [   27.964144] Internal error: Oops: 17 [#2] SMP ARM
>> [   27.968869] Modules linked in:
>> [   27.971962] CPU: 3 PID: 399 Comm: sh Not tainted 4.15.0-rc5-g3630470 #15
>> [   27.978685] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
>> [   27.985248] PC is at msi_set_mask_bit+0x18/0x6c
>> [   27.989805] LR is at pci_msi_mask_irq+0x14/0x18
>> [   27.994358] pc : [<c0485ee4>]    lr : [<c0485f4c>]    psr: a0000193
>> [   28.000647] sp : e71a9bb0  ip : e71a9bc8  fp : e71a9bc4
>> [   28.005892] r10: ffffe000  r9 : e682e400  r8 : c101a72c
>> [   28.011140] r7 : e71a9c00  r6 : c102a504  r5 : 0000012f  r4 : 00000000
>> [   28.017690] r3 : e642b400  r2 : 00000001  r1 : 00000001  r0 : e642b414
>> [   28.024241] Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
>> [   28.031486] Control: 10c5387d  Table: 36ef804a  DAC: 00000051
>> [   28.037255] Process sh (pid: 399, stack limit = 0x61f128fb)
>> [   28.042849] Stack: (0xe71a9bb0 to 0xe71aa000)
>> ...(snip)...
>> [   28.334445] Backtrace:
>> [   28.336937] [<c0485ecc>] (msi_set_mask_bit) from [<c0485f4c>] (pci_msi_mask_irq+0x14/0x18)
>> [   28.345224]  r5:0000012f r4:e642b400
>> [   28.348844] [<c0485f38>] (pci_msi_mask_irq) from [<c0111308>] (machine_crash_shutdown+0xe8/0x1a0)
>> [   28.357763] [<c0111220>] (machine_crash_shutdown) from [<c01b4aa4>] (__crash_kexec+0x5c/0xa0)
>> [   28.366319]  r9:e682e400 r8:bf000000 r7:c100d9e4 r6:c17c9c88 r5:e71a9df0 r4:e71a9c00
>> [   28.374097] [<c01b4a48>] (__crash_kexec) from [<c01b4b58>] (crash_kexec+0x70/0x80)
>> [   28.381691]  r6:0000000b r5:ffffffff r4:c10155ac
>> [   28.386341] [<c01b4ae8>] (crash_kexec) from [<c010ce8c>] (die+0x230/0x368)
>> [   28.393239]  r5:e71a9df0 r4:c107b21c
>> [   28.396848] [<c010cc5c>] (die) from [<c0116b80>] (__do_kernel_fault.part.0+0x5c/0x7c)
>> [   28.404707]  r10:e69c96d4 r9:00000000 r8:00000817 r7:e69c9680 r6:00000817 r5:e71a9df0
>> [   28.412556]  r4:00000000
>> [   28.415123] [<c0116b24>] (__do_kernel_fault.part.0) from [<c01169a0>] (do_page_fault+0x3a4/0x3c4)
>> [   28.424017]  r7:e69c9680 r4:e71a9df0
>> [   28.427623] [<c01165fc>] (do_page_fault) from [<c0101388>] (do_DataAbort+0x3c/0xbc)
>> [   28.435310]  r10:00000000 r9:e71a8000 r8:e71a9df0 r7:00000000 r6:c01165fc r5:00000817
>> [   28.443159]  r4:c100e4a0
>> [   28.445723] [<c010134c>] (do_DataAbort) from [<c010d804>] (__dabt_svc+0x64/0xa0)
>> [   28.453140] Exception stack(0xe71a9df0 to 0xe71a9e38)
>> [   28.458217] 9de0:                                     00000000 00000730 00000000 00000000
>> [   28.466423] 9e00: 00000000 00000001 c10359a0 00000000 00000004 00000002 00000000 e71a9e54
>> [   28.474627] 9e20: e71a9e30 e71a9e40 c0118694 c04d1aa8 60000013 ffffffff
>> [   28.481268]  r8:00000004 r7:e71a9e24 r6:ffffffff r5:60000013 r4:c04d1aa8
>> [   28.488012] [<c04d1a58>] (sysrq_handle_crash) from [<c04d206c>] (__handle_sysrq+0xd8/0x258)
>> [   28.496385]  r5:00000063 r4:c101a6b0
>> [   28.499995] [<c04d1f94>] (__handle_sysrq) from [<c04d2688>] (write_sysrq_trigger+0x78/0x90)
>> [   28.508375]  r10:00000000 r9:00000002 r8:00000000 r7:e6490c00 r6:00000000 r5:01ced738
>> [   28.516223]  r4:00000002
>> [   28.518791] [<c04d2610>] (write_sysrq_trigger) from [<c02979bc>] (proc_reg_write+0x68/0x90)
>> [   28.527164]  r5:00000000 r4:c04d2610
>> [   28.530774] [<c0297954>] (proc_reg_write) from [<c022e50c>] (__vfs_write+0x34/0x134)
>> [   28.538547]  r9:00000002 r8:01ced738 r7:00000002 r6:e71a9f78 r5:c0297954 r4:e6a49cc0
>> [   28.546320] [<c022e4d8>] (__vfs_write) from [<c022e78c>] (vfs_write+0xa8/0x170)
>> [   28.553658]  r9:00000002 r8:01ced738 r7:e71a9f78 r6:01ced738 r5:e6a49cc0 r4:00000002
>> [   28.561433] [<c022e6e4>] (vfs_write) from [<c022e96c>] (SyS_write+0x44/0x98)
>> [   28.568511]  r9:00000002 r8:01ced738 r7:00000000 r6:00000000 r5:e6a49cc0 r4:e6a49cc0
>> [   28.576291] [<c022e928>] (SyS_write) from [<c0107fe0>] (ret_fast_syscall+0x0/0x28)
>> [   28.583890]  r9:e71a8000 r8:c01081a4 r7:00000004 r6:b6f7eda8 r5:01ced738 r4:00000002
>> [   28.591662] Code: e24cb004 e590300c e1a02001 e5934008 (e5d43028)
>> [   28.597788] ---[ end trace b7f10c526986d6ea ]---
>> [   28.602430] Kernel panic - not syncing: Fatal exception
>> [   28.607716] ---[ end Kernel panic - not syncing: Fatal exception
>>
>>
>> Console log in success case (patch applied):
>>
>> root@imx6qdlsabresd:~# cat /proc/cmdline
>> console=ttymxc0,115200 root=PARTUUID=6c7357c5-02 rootwait rw quiet crashkernel=96M
>> root@imx6qdlsabresd:~# kexec --type zImage -p /boot/zImage --dtb=/boot/imx6q-sabresd.dtb --append="console=ttymxc0,115200 root=/dev/mmcblk1p2 rootwait rw 3 maxcpus=1 reset_devices earlycon"
>> root@imx6qdlsabresd:~# echo c > /proc/sysrq-trigger
>> [   42.951366] sysrq: SysRq : Trigger a crash
>> [   42.955711] Unable to handle kernel NULL pointer dereference at virtual address 00000000
>> ...(snip)...
>> [   43.167849] Backtrace:
>> [   43.170314] [<c04d1a5c>] (sysrq_handle_crash) from [<c04d2070>] (__handle_sysrq+0xd8/0x258)
>> [   43.178671]  r5:00000063 r4:c101a6b0
>> [   43.182258] [<c04d1f98>] (__handle_sysrq) from [<c04d268c>] (write_sysrq_trigger+0x78/0x90)
>> [   43.190617]  r10:00000000 r9:00000002 r8:00000000 r7:e6490c00 r6:00000000 r5:003b2738
>> [   43.198450]  r4:00000002
>> [   43.200995] [<c04d2614>] (write_sysrq_trigger) from [<c02979bc>] (proc_reg_write+0x68/0x90)
>> [   43.209350]  r5:00000000 r4:c04d2614
>> [   43.212937] [<c0297954>] (proc_reg_write) from [<c022e50c>] (__vfs_write+0x34/0x134)
>> [   43.220688]  r9:00000002 r8:003b2738 r7:00000002 r6:e6f33f78 r5:c0297954 r4:e6b47680
>> [   43.228439] [<c022e4d8>] (__vfs_write) from [<c022e78c>] (vfs_write+0xa8/0x170)
>> [   43.235756]  r9:00000002 r8:003b2738 r7:e6f33f78 r6:003b2738 r5:e6b47680 r4:00000002
>> [   43.243508] [<c022e6e4>] (vfs_write) from [<c022e96c>] (SyS_write+0x44/0x98)
>> [   43.250564]  r9:00000002 r8:003b2738 r7:00000000 r6:00000000 r5:e6b47680 r4:e6b47680
>> [   43.258320] [<c022e928>] (SyS_write) from [<c0107fe0>] (ret_fast_syscall+0x0/0x28)
>> [   43.265896]  r9:e6f32000 r8:c01081a4 r7:00000004 r6:b6f0eda8 r5:003b2738 r4:00000002
>> [   43.273647] Code: e3a04000 e5835000 ee074f9a ebf11af1 (e5c45000)
>> [   43.279767] CPU 3 will stop doing anything useful since another CPU has crashed
>> [   43.279771] CPU 2 will stop doing anything useful since another CPU has crashed
>> [   43.279775] CPU 0 will stop doing anything useful since another CPU has crashed
>> [   43.301962] Loading crashdump kernel...
>> [   43.305886] Bye!
>> [    0.000000] Booting Linux on physical CPU 0x1
>> [    0.000000] Linux version 4.15.0-rc5-g13f566e (miracle@ar) (gcc version 5.4.0 20160609 (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.4)) #14 SMP Tue Jan 16 06:33:27 UTC 2018
>>
>>
>> Hiraku Toyooka (1):
>>   PCI/MSI: add NULL check before use of msi_desc
>>
>>  drivers/pci/msi.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> --
>> 2.7.4
>>
>



-- 
Hiraku Toyooka
Cybertrust Japan Co., Ltd.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
