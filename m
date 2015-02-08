Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:33156 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbbBHHh2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 8 Feb 2015 02:37:28 -0500
From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
To: mohit.kumar@st.com
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	"Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: [PATCH] pci: spear: Drop __initdata from struct platform_driver spear13xx_pcie_driver
Date: Sun,  8 Feb 2015 10:37:10 +0300
Message-Id: <1423381030-3457-1-git-send-email-matwey@sai.msu.ru>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

spear13xx_pcie_driver.driver is allocated in text.init section
and then the pointer to it is passed futher. This patch is to avoid
crashes like the following, when freed memory is used:

 #0  __device_attach (drv=0xc0ed5608 <spear13xx_pcie_driver+20>, data=0xdb622610) at ../drivers/base/dd.c:409
 #1  0xc07a4798 in bus_for_each_drv (bus=<optimized out>, start=<optimized out>, data=0xda0, fn=0xc07a6740 <__device_attach>)
    at ../drivers/base/bus.c:463
 #2  0xc07a6324 in device_attach (dev=0xdb622610) at ../drivers/base/dd.c:447
 #3  0xc07a5814 in bus_probe_device (dev=0xdb622610) at ../drivers/base/bus.c:558
 #4  0xc07a38d8 in device_add (dev=<optimized out>) at ../drivers/base/core.c:1058
 #5  0xc08b6a5c in of_device_add (ofdev=<optimized out>) at ../drivers/of/device.c:66
 #6  0xc08b742c in of_platform_device_create_pdata (np=<optimized out>, bus_id=0x0 <__vectors_start>, platform_data=0x0 <__vectors_start>,
    parent=<optimized out>) at ../drivers/of/platform.c:241
 #7  0xc08b7568 in of_platform_bus_create (bus=0xdfa46780, matches=0x0 <__vectors_start>, lookup=0x0 <__vectors_start>, parent=0xdb183410,
    strict=true) at ../drivers/of/platform.c:414
 #8  0xc08b79bc in of_platform_populate (root=0xc0ed5608 <spear13xx_pcie_driver+20>, matches=0xdb622610, lookup=0xda0,
    parent=0xc07a6740 <__device_attach>) at ../drivers/of/platform.c:501
 #9  0xbf000030 in am335x_child_probe (pdev=0xdb183400) at ../drivers/usb/musb/musb_am335x.c:12
 #10 0xc07a83f0 in platform_drv_probe (_dev=0xdb183410) at ../drivers/base/platform.c:512
 #11 0xc07a64e8 in really_probe (drv=<optimized out>, dev=<optimized out>) at ../drivers/base/dd.c:302
 #12 driver_probe_device (drv=0xbf000234, dev=0xdb183410) at ../drivers/base/dd.c:399
 #13 0xc07a6820 in __driver_attach (dev=0xdb183410, data=0xbf000234) at ../drivers/base/dd.c:477
 #14 0xc07a46e8 in bus_for_each_dev (bus=<optimized out>, start=<optimized out>, data=0xda0, fn=0xc07a83a4 <platform_drv_probe>)
    at ../drivers/base/bus.c:313
 #15 0xc07a5ebc in driver_attach (drv=<optimized out>) at ../drivers/base/dd.c:496
 #16 0xc07a5af0 in bus_add_driver (drv=0xbf000234) at ../drivers/base/bus.c:694
 #17 0xc07a6fec in driver_register (drv=0xbf000234) at ../drivers/base/driver.c:167
 #18 0xc0209c34 in do_one_initcall (fn=0xbf002000) at ../init/main.c:801
 #19 0xc02e0494 in do_init_module (mod=<optimized out>) at ../kernel/module.c:3142
 #20 load_module (info=0xdb6b1f54, uargs=<optimized out>, flags=<optimized out>) at ../kernel/module.c:3461
 #21 0xc02e0a44 in SYSC_finit_module (flags=<optimized out>, uargs=<optimized out>, fd=<optimized out>) at ../kernel/module.c:3537
 #22 SyS_finit_module (fd=7, uargs=-1225602132, flags=0) at ../kernel/module.c:3518
 #23 0xc021a680 in ?? ()

Fixes: 6675ef212da (PCI: spear: Fix Section mismatch compilation warning for probe())
Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 drivers/pci/host/pcie-spear13xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
index 866465f..435651d 100644
--- a/drivers/pci/host/pcie-spear13xx.c
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -370,7 +370,7 @@ static const struct of_device_id spear13xx_pcie_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, spear13xx_pcie_of_match);
 
-static struct platform_driver spear13xx_pcie_driver __initdata = {
+static struct platform_driver spear13xx_pcie_driver = {
 	.probe		= spear13xx_pcie_probe,
 	.driver = {
 		.name	= "spear-pcie",
-- 
2.1.4

