Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:63340 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754436AbaA1IDC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jan 2014 03:03:02 -0500
Received: by mail-wg0-f52.google.com with SMTP id b13so97155wgh.7
        for <linux-pci@vger.kernel.org>; Tue, 28 Jan 2014 00:03:00 -0800 (PST)
MIME-Version: 1.0
From: Kamel BOUHARA <k.bouhara@gmail.com>
Date: Tue, 28 Jan 2014 09:02:40 +0100
Message-ID: <CAM9uW_75p7rt4V82TysSKmVbsYYgWqYwgaecyHMa+q4kSRwzUw@mail.gmail.com>
Subject: PCIe trouble on imx6q
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

Im getting trouble with kernel 3.13 at boot time, the pcie link failed
to get up with the following log:
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at drivers/gpio/gpiolib.c:159 gpio_to_desc+0x34/0x48()
invalid GPIO -2
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.13.0+ #4
Backtrace:
[<8001217c>] (dump_backtrace) from [<80012460>] (show_stack+0x18/0x1c)
 r6:802b9548 r5:00000000 r4:808d3060 r3:00000000
[<80012448>] (show_stack) from [<806414fc>] (dump_stack+0x84/0x9c)
[<80641478>] (dump_stack) from [<800289f8>] (warn_slowpath_common+0x70/0x94)
 r5:00000009 r4:bf05bcb0
[<80028988>] (warn_slowpath_common) from [<80028a54>]
(warn_slowpath_fmt+0x38/0x40)
 r8:01f00000 r7:00000000 r6:0011cc11 r5:808b68c0 r4:bf24fa30
[<80028a20>] (warn_slowpath_fmt) from [<802b9548>] (gpio_to_desc+0x34/0x48)
 r3:fffffffe r2:807d23fc
[<802b9514>] (gpio_to_desc) from [<802d9de0>] (imx6_pcie_host_init+0x174/0x434)
[<802d9c6c>] (imx6_pcie_host_init) from [<80886dbc>]
(dw_pcie_host_init+0x348/0x41c)
 r6:00000000 r5:808d52cc r4:00000020 r3:802d9c6c
[<80886a74>] (dw_pcie_host_init) from [<808871d4>] (imx6_pcie_probe+0x320/0x3dc)
 r10:00000000 r9:000000c4 r8:808d539c r7:bf7e3384 r6:bf24fa30 r5:bf135810
 r4:bf24fa10
[<80886eb4>] (imx6_pcie_probe) from [<8034b670>] (platform_drv_probe+0x20/0x50)
 r8:808d539c r7:00000000 r6:00000000 r5:808d539c r4:bf135810
[<8034b650>] (platform_drv_probe) from [<80349c74>]
(driver_probe_device+0x118/0x234)
 r5:bf135810 r4:80e526b8
[<80349b5c>] (driver_probe_device) from [<80349e78>] (__driver_attach+0x9c/0xa0)
 r8:80886e90 r7:00000000 r6:bf135844 r5:808d539c r4:bf135810 r3:00000000
[<80349ddc>] (__driver_attach) from [<8034806c>] (bus_for_each_dev+0x68/0x9c)
 r6:80349ddc r5:808d539c r4:00000000 r3:00000000
[<80348004>] (bus_for_each_dev) from [<8034972c>] (driver_attach+0x20/0x28)
 r6:808df6a8 r5:bf1f5e00 r4:808d539c
[<8034970c>] (driver_attach) from [<803493b0>] (bus_add_driver+0x148/0x1f4)
[<80349268>] (bus_add_driver) from [<8034a4c8>] (driver_register+0x80/0x100)
 r7:8090e640 r6:8090e640 r5:00000005 r4:808d539c
[<8034a448>] (driver_register) from [<8034b63c>]
(__platform_driver_register+0x50/0x64)
 r5:00000005 r4:808d5388
[<8034b5ec>] (__platform_driver_register) from [<8034b6e0>]
(platform_driver_probe+0x28/0xac)
[<8034b6b8>] (platform_driver_probe) from [<80886ea8>]
(imx6_pcie_init+0x18/0x24)
 r5:00000005 r4:808aa104
[<80886e90>] (imx6_pcie_init) from [<80008978>] (do_one_initcall+0x100/0x164)
[<80008878>] (do_one_initcall) from [<8085ecc0>]
(kernel_init_freeable+0x10c/0x1d0)
 r10:8089e060 r9:000000c4 r8:8089e050 r7:8090e640 r6:8090e640 r5:00000005
 r4:808aa104
[<8085ebb4>] (kernel_init_freeable) from [<8063b67c>] (kernel_init+0x10/0x120)
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8063b66c
 r4:00000000
[<8063b66c>] (kernel_init) from [<8000e9c8>] (ret_from_fork+0x14/0x2c)
 r4:00000000 r3:ffffffff
---[ end trace b5e746dfc2398cd6 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at drivers/gpio/gpiolib.c:159 gpio_to_desc+0x34/0x48()
invalid GPIO -2
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W    3.13.0+ #4
Backtrace:
[<8001217c>] (dump_backtrace) from [<80012460>] (show_stack+0x18/0x1c)
 r6:802b9548 r5:00000000 r4:808d3060 r3:00000000
[<80012448>] (show_stack) from [<806414fc>] (dump_stack+0x84/0x9c)
[<80641478>] (dump_stack) from [<800289f8>] (warn_slowpath_common+0x70/0x94)
 r5:00000009 r4:bf05bcb0
[<80028988>] (warn_slowpath_common) from [<80028a54>]
(warn_slowpath_fmt+0x38/0x40)
 r8:01f00000 r7:00000000 r6:0011cc11 r5:808b68c0 r4:bf24fa30
[<80028a20>] (warn_slowpath_fmt) from [<802b9548>] (gpio_to_desc+0x34/0x48)
 r3:fffffffe r2:807d23fc
[<802b9514>] (gpio_to_desc) from [<802d9df8>] (imx6_pcie_host_init+0x18c/0x434)
[<802d9c6c>] (imx6_pcie_host_init) from [<80886dbc>]
(dw_pcie_host_init+0x348/0x41c)
 r6:00000000 r5:808d52cc r4:00000020 r3:802d9c6c
[<80886a74>] (dw_pcie_host_init) from [<808871d4>] (imx6_pcie_probe+0x320/0x3dc)
 r10:00000000 r9:000000c4 r8:808d539c r7:bf7e3384 r6:bf24fa30 r5:bf135810
 r4:bf24fa10
[<80886eb4>] (imx6_pcie_probe) from [<8034b670>] (platform_drv_probe+0x20/0x50)
 r8:808d539c r7:00000000 r6:00000000 r5:808d539c r4:bf135810
[<8034b650>] (platform_drv_probe) from [<80349c74>]
(driver_probe_device+0x118/0x234)
 r5:bf135810 r4:80e526b8
[<80349b5c>] (driver_probe_device) from [<80349e78>] (__driver_attach+0x9c/0xa0)
 r8:80886e90 r7:00000000 r6:bf135844 r5:808d539c r4:bf135810 r3:00000000
[<80349ddc>] (__driver_attach) from [<8034806c>] (bus_for_each_dev+0x68/0x9c)
 r6:80349ddc r5:808d539c r4:00000000 r3:00000000
[<80348004>] (bus_for_each_dev) from [<8034972c>] (driver_attach+0x20/0x28)
 r6:808df6a8 r5:bf1f5e00 r4:808d539c
[<8034970c>] (driver_attach) from [<803493b0>] (bus_add_driver+0x148/0x1f4)
[<80349268>] (bus_add_driver) from [<8034a4c8>] (driver_register+0x80/0x100)
 r7:8090e640 r6:8090e640 r5:00000005 r4:808d539c
[<8034a448>] (driver_register) from [<8034b63c>]
(__platform_driver_register+0x50/0x64)
 r5:00000005 r4:808d5388
[<8034b5ec>] (__platform_driver_register) from [<8034b6e0>]
(platform_driver_probe+0x28/0xac)
[<8034b6b8>] (platform_driver_probe) from [<80886ea8>]
(imx6_pcie_init+0x18/0x24)
 r5:00000005 r4:808aa104
[<80886e90>] (imx6_pcie_init) from [<80008978>] (do_one_initcall+0x100/0x164)
[<80008878>] (do_one_initcall) from [<8085ecc0>]
(kernel_init_freeable+0x10c/0x1d0)
 r10:8089e060 r9:000000c4 r8:8089e050 r7:8090e640 r6:8090e640 r5:00000005
 r4:808aa104
[<8085ebb4>] (kernel_init_freeable) from [<8063b67c>] (kernel_init+0x10/0x120)
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8063b66c
 r4:00000000
[<8063b66c>] (kernel_init) from [<8000e9c8>] (ret_from_fork+0x14/0x2c)
 r4:00000000 r3:ffffffff
---[ end trace b5e746dfc2398cd7 ]---
imx6q-pcie 1ffc000.pcie: phy link never came up
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x1000-0x10000]
pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
PCI: bus0: Fast back to back transfers disabled
PCI: bus1: Fast back to back transfers enabled
pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
pci 0000:00:00.0: BAR 6: assigned [mem 0x01100000-0x0110ffff pref]
pci 0000:00:00.0: PCI bridge to [bus 01]
pci 0000:00:00.0: PCI bridge to [bus 01]

Please, any help is welcome.
Regards,
Kamel.B
