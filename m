Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:39772 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751003AbeBJBt6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Feb 2018 20:49:58 -0500
Cc: shawn.lin@rock-chips.com,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: epf does not have a release() function
Message-ID: <e9288e61-9d0a-81f5-9f3a-6c97e66ab720@rock-chips.com>
Date: Sat, 10 Feb 2018 09:49:56 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Kishon,

I have been testing ep framework for rockchip PCIe controller
for a while and see this warning accidentally by making some
mistake in my DT which leads some resource missing. So the probe
process halts and trigger this warning.


[    0.986269] rockchip-pcie-ep f8000000.pcie-ep: invalid resource
[    0.987346] ------------[ cut here ]------------
[    0.987844] Device 'f8000000.pcie-ep' does not have a release() 
function, it is broken and must be fixed.
[    0.988981] WARNING: CPU: 3 PID: 1 at drivers/base/core.c:815 
device_release+0x84/0x98
[    0.989788] Modules linked in:
[    0.990158] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 
4.15.0-next-20180209-00010-ge344474-dirty #171
[    0.991085] Hardware name: Excavator-RK3399 Board (DT)
[    0.991629] pstate: 60000005 (nZCv daif -PAN -UAO)
[    0.992141] pc : device_release+0x84/0x98
[    0.992573] lr : device_release+0x84/0x98
[    0.992992] sp : ffff00000804bb30
[    0.993342] x29: ffff00000804bb30 x28: 0000000000000000
[    0.993912] x27: ffff00000900b970 x26: ffff000008f00624
[    0.994478] x25: ffff00000915f000 x24: ffff00000804bc28
[    0.995040] x23: ffff000009029000 x22: 0000000000000002
[    0.995606] x21: ffff8000f1331d00 x20: ffff8000f0c9ac10
[    0.996172] x19: ffff8000f0c9ac00 x18: ffffffffffffffff
[    0.996739] x17: 000000000000037f x16: 0000000000000000
[    0.997305] x15: ffff000009029b88 x14: 207369207469202c
[    0.997872] x13: 6e6f6974636e7566 x12: 202928657361656c
[    0.998439] x11: 6572206120657661 x10: 6820746f6e207365
[    0.999006] x9 : 6f64202770652d65 x8 : 207473756d20646e
[    0.999572] x7 : ffff0000085bfb28 x6 : 00000000000000b9
[    1.000138] x5 : 0000000000000000 x4 : 0000000000000000
[    1.000702] x3 : ffffffffffffffff x2 : ffff000009042f00
[    1.001268] x1 : 39c1333e45671700 x0 : 0000000000000000
[    1.001832] Call trace:
[    1.002111]  device_release+0x84/0x98
[    1.002508]  kobject_put+0x70/0xe0
[    1.002880]  device_unregister+0x20/0x30
[    1.003302]  pci_epc_destroy+0x20/0x38
[    1.003704]  devm_pci_epc_release+0x10/0x18
[    1.004157]  release_nodes+0x12c/0x230
[    1.004564]  devres_release_all+0x34/0x50
[    1.004993]  driver_probe_device+0xbc/0x308
[    1.005436]  __driver_attach+0xac/0xb0
[    1.005837]  bus_for_each_dev+0x68/0xc8
[    1.006246]  driver_attach+0x20/0x28
[    1.006630]  bus_add_driver+0x108/0x228
[    1.007038]  driver_register+0x60/0xf8
[    1.007443]  __platform_driver_register+0x40/0x48
[    1.007943]  rockchip_pcie_ep_driver_init+0x18/0x20
[    1.008460]  do_one_initcall+0x50/0x158
[    1.008872]  kernel_init_freeable+0x184/0x224
[    1.009335]  kernel_init+0x10/0x100
[    1.009712]  ret_from_fork+0x10/0x18
[    1.010141] ---[ end trace 7a91d2001781494c ]---
[    1.010797] rockchip-pcie-ep: probe of f8000000.pcie-ep failed with 
error -22
