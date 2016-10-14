Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:41803 "EHLO bes.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753964AbcJNMlx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Oct 2016 08:41:53 -0400
To: Bjorn Helgaas <bhelgaas@google.com>, <Joao.Pinto@synopsys.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
From: Niklas Cassel <niklas.cassel@axis.com>
Subject: [REGRESSION, bisect] pci: artpec-6: imprecise external abort
Message-ID: <b53d5807-8199-5789-6184-e37324a1d79e@axis.com>
Date: Fri, 14 Oct 2016 14:41:44 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello

Because of recent changes to drivers/pci/host/pcie-artpec6.c,
I was going to try out Bjorn's tag pci-v4.9-changes-2,
however I was greeted by an imprecise external abort:


[    0.613082] Trying to unpack rootfs image as initramfs...
[    0.886577] Freeing initrd memory: 4724K (c2900000 - c2d9d000)
[    0.892685] hw perfevents: enabled with armv7_cortex_a9 PMU driver, 7 counters available
[    0.901519] futex hash table entries: 512 (order: 3, 32768 bytes)
[    0.908151] workingset: timestamp_bits=30 max_order=16 bucket_order=0
[    0.920977] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.927408] NFS: Registering the id_resolver key type
[    0.932505] Key type id_resolver registered
[    0.936689] Key type id_legacy registered
[    0.940742] ntfs: driver 2.1.32 [Flags: R/O].
[    0.946094] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
[    0.953534] io scheduler noop registered
[    0.957467] io scheduler deadline registered
[    0.961859] io scheduler cfq registered (default)
[    0.967829] libphy: mdio_driver_register: phy-bcm-ns2-pci
[    0.975979] OF: PCI: host bridge /pcie@f8050000 ranges:
[    0.981243] OF: PCI:    IO 0xc0002000..0xc0011fff -> 0x00000000
[    0.987179] OF: PCI:   MEM 0xc0012000..0xdfffffff -> 0xc0012000
[    0.993225] Unhandled fault: imprecise external abort (0x406) at 0x00000000
[    1.000187] pgd = c0204000
[    1.002892] [00000000] *pgd=00000000
[    1.006471] Internal error: : 406 [#1] SMP ARM
[    1.010910] Modules linked in:
[    1.013968] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.8.0-rc1 #1
[    1.020580] Hardware name: Axis ARTPEC-6 Platform
[    1.025281] task: cb040000 task.stack: cb036000
[    1.029822] PC is at dw_pcie_host_init+0x4b0/0x534
[    1.034615] LR is at __irq_put_desc_unlock+0x14/0x38
[    1.039579] pc : [<c063da6c>]    lr : [<c03884bc>]    psr: 60000053
[    1.039579] sp : cb037e10  ip : 00010000  fp : c0ea3dc8
[    1.051061] r10: c0ea3dc0  r9 : cbdd7c50  r8 : cb037e20
[    1.056283] r7 : cb037e20  r6 : c1285fc8  r5 : 00000020  r4 : cb1ea250
[    1.062808] r3 : d0824000  r2 : 00000000  r1 : 60000053  r0 : 00000000
[    1.069334] Flags: nZCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
[    1.076559] Control: 10c5387d  Table: 0020404a  DAC: 00000051
[    1.082303] Process swapper/0 (pid: 1, stack limit = 0xcb036220)
[    1.088306] Stack: (0xcb037e10 to 0xcb038000)
[    1.092662] 7e00:                                     c0cd721c c1285fc8 00000000 c0ea3c80
[    1.100845] 7e20: cb1c1540 cb1c1680 c0ea523c 00000000 cb1ea250 cb0cc810 fffffdfb 00000000
[    1.109028] 7e40: 00000000 00000000 cbfff2c0 c064673c 00010080 c0ea523c cb1ea250 fffffdfb
[    1.117210] 7e60: cb0cc810 cb0cc810 c1286a70 c07a268c cb0cc810 c1349fa4 c1349fac c1286a70
[    1.125393] 7e80: 00000000 c07a0e8c cb0cc810 c1286a70 cb0cc844 c12a4ff8 0000010b 00000007
[    1.133575] 7ea0: 00000000 c07a0ff0 00000000 c1286a70 c07a0f38 c079f1e8 cb02bc5c cb0ce0b4
[    1.141757] 7ec0: c1286a70 cb25e800 00000000 c07a032c c0ea526c c110dc5c c1286a70 c1286a70
[    1.149940] 7ee0: c1033580 c110dc60 c10a3834 c07a1710 ffffe000 c1033580 c110dc60 c0301eb4
[    1.158122] 7f00: c1235d08 00000000 00000000 c04709e0 c0c0b300 cb05ba80 00000000 c1234a38
[    1.166304] 7f20: 60000053 00000003 00000001 00000000 c0eed190 c0f73f34 00000000 00000006
[    1.174486] 7f40: 00000006 c0e4b55c c1234a20 c1309000 c1309000 c1309000 c110dc60 c10a3834
[    1.182668] 7f60: 0000010b 00000007 c10a383c c1000dc0 00000006 00000006 00000000 c10005ac
[    1.190850] 7f80: 00000000 00000000 c0b047f4 00000000 00000000 00000000 00000000 00000000
[    1.199032] 7fa0: 00000000 c0b047fc 00000000 c0307e78 00000000 00000000 00000000 00000000
[    1.207213] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.215395] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000 7263306f 65756167
[    1.223589] [<c063da6c>] (dw_pcie_host_init) from [<c064673c>] (artpec6_pcie_probe+0x118/0x1a0)
[    1.232300] [<c064673c>] (artpec6_pcie_probe) from [<c07a268c>] (platform_drv_probe+0x4c/0xb0)
[    1.240920] [<c07a268c>] (platform_drv_probe) from [<c07a0e8c>] (driver_probe_device+0x20c/0x2b8)
[    1.249798] [<c07a0e8c>] (driver_probe_device) from [<c07a0ff0>] (__driver_attach+0xb8/0xbc)
[    1.258250] [<c07a0ff0>] (__driver_attach) from [<c079f1e8>] (bus_for_each_dev+0x68/0x9c)
[    1.266439] [<c079f1e8>] (bus_for_each_dev) from [<c07a032c>] (bus_add_driver+0x1a0/0x218)
[    1.274710] [<c07a032c>] (bus_add_driver) from [<c07a1710>] (driver_register+0x78/0xf8)
[    1.282723] [<c07a1710>] (driver_register) from [<c0301eb4>] (do_one_initcall+0x44/0x174)
[    1.290919] [<c0301eb4>] (do_one_initcall) from [<c1000dc0>] (kernel_init_freeable+0x158/0x1e8)
[    1.299636] [<c1000dc0>] (kernel_init_freeable) from [<c0b047fc>] (kernel_init+0x8/0x10c)
[    1.307828] [<c0b047fc>] (kernel_init) from [<c0307e78>] (ret_from_fork+0x14/0x3c)
[    1.315404] Code: eafffef9 e5943008 e5930900 f57ff04f (eaffff69)
[    1.321503] ---[ end trace b458093682b1fb9a ]---


a git bisect later and the cause appears to be a0601a470537 ("PCI: designware: Add iATU Unroll feature")

the following patch gives me a working system again:

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 035f50c03281..74510508fafc 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -637,11 +637,11 @@ int dw_pcie_host_init(struct pcie_port *pp)
                }
        }
 
-       pp->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pp);
-
        if (pp->ops->host_init)
                pp->ops->host_init(pp);
 
+       pp->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pp);
+
        pp->root_bus_nr = pp->busn->start;
        if (IS_ENABLED(CONFIG_PCI_MSI)) {
                bus = pci_scan_root_bus_msi(pp->dev, pp->root_bus_nr,


>From the ARTPEC-6 SoC manual:
By default, the PCI Express interface shall be held in reset and clock-gated.
Software is required to enable the relevant modules
(turns on clocks and de-asserts reset) before these modules can be used.

Turning on the clocks and de-asserting reset is done in pp->ops->host_init().
We get an external abort when calling dw_pcie_iatu_unroll_enabled,
since that function does a read from the IP before we are allowed to do
AXI transfers (at least in the ARTPEC-6 case, might be the same for some
other SoCs).

It appears that dw_pcie_iatu_unroll_enabled was actually called _before_
host_init() in v4 of Joao's patch, but was changed to after host_init() in v5,
unfortunately the patch doesn't state a reason for the move.

