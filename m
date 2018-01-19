Return-Path: <SRS0=5WU8=EO=linux-mips.org=ladis@kernel.org>
Return-Path: <SRS0=5WU8=EO=linux-mips.org=ladis@kernel.org>
Date: Fri, 19 Jan 2018 18:06:57 +0100
Sender: Ladislav Michl <ladis@linux-mips.org>
From: Ladislav Michl <ladis@linux-mips.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Wei Yongjun <weiyongjun1@huawei.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] PCI: dra7xx: Fix potential NULL dereference
Message-ID: <20180119170657.GA27882@lenoch>
References: <1516284037-81537-1-git-send-email-weiyongjun1@huawei.com>
 <20180118145420.GA21163@lenoch>
 <20180118183525.GG53542@bhelgaas-glaptop.roam.corp.google.com>
 <20180119095857.GA26765@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180119095857.GA26765@lenoch>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 19, 2018 at 10:58:57AM +0100, Ladislav Michl wrote:
> On Thu, Jan 18, 2018 at 12:35:25PM -0600, Bjorn Helgaas wrote:
> > That's probably a better idea.  Maybe we should add a comment like this
> > to help avoid this in the future:
> 
> That seems to spot another a bit more serious problem (given how late
> release cycle is now).
> 
> Both devm_ioremap() and devm_ioremap_resource() shares the same release
> function: devm_ioremap_release(). However this function is not aware of
> memory region previously requested by devm_request_mem_region() called
> from devm_ioremap_resource().
> 
> Bellow is just a quick hack, even untested as looking at devm_ioremap,
> devm_ioremap_wc and devm_ioremap_wc, there is some room for optimization.

Okay, forget it, above analysis is not correct, however there is a bug (and
also in PCI version). To show it, let's make following modification:

diff --git a/lib/devres.c b/lib/devres.c
index e9aad136f667..193e540eab23 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -153,6 +153,10 @@ void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res)
 		return IOMEM_ERR_PTR(-EBUSY);
 	}
 
+	if (res->start == 0x4809c000 || res->start == 0x480b4000 || res->start == 0x480ad000) {
+		dev_info(dev, "Setting size to madness\n");
+		size = 1000000000;
+	}
 	dest_ptr = devm_ioremap(dev, res->start, size);
 	if (!dest_ptr) {
 		dev_err(dev, "ioremap failed for resource %pR\n", res);

Above patch will set insane resource size for omap_hsmmc driver which is
using devm_ioremap_resource() and triggers following error:

vmap allocation for size 1000005632 failed: use vmalloc=<size> to increase size
omap_hsmmc 4809c000.mmc: ioremap failed for resource [mem 0x4809c000-0x4809c1ff]
Trying to free nonexistent resource <000000004809c000-0000000083a489ff>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 92 at kernel/resource.c:1477 __devm_release_region+0x44/0x58
Modules linked in: omap_aes_driver(+) omap_sham(+) crypto_engine omap_crypto phy_twl4030_usb omap2430(+) omap_hsmmc(+) musb_hdrc omap_mailbox ohci_platform(+) snd_soc_twl4030 ohci_hcd ehci_omap td
CPU: 0 PID: 92 Comm: systemd-udevd Not tainted 4.15.0-rc8-next-20180118 #42
Hardware name: Generic OMAP36xx (Flattened Device Tree)
[<c010d450>] (unwind_backtrace) from [<c010b510>] (show_stack+0x10/0x14)
[<c010b510>] (show_stack) from [<c0129648>] (__warn+0xd4/0xec)
[<c0129648>] (__warn) from [<c0129720>] (warn_slowpath_null+0x38/0x44)
[<c0129720>] (warn_slowpath_null) from [<c012cd4c>] (__devm_release_region+0x44/0x58)
[<c012cd4c>] (__devm_release_region) from [<c02b9904>] (devm_ioremap_resource+0x118/0x140)
[<c02b9904>] (devm_ioremap_resource) from [<bf0f9f0c>] (omap_hsmmc_probe+0x15c/0x960 [omap_hsmmc])
[<bf0f9f0c>] (omap_hsmmc_probe [omap_hsmmc]) from [<c0339204>] (platform_drv_probe+0x50/0x9c)
[<c0339204>] (platform_drv_probe) from [<c0337c04>] (driver_probe_device+0x330/0x478)
[<c0337c04>] (driver_probe_device) from [<c0337dec>] (__driver_attach+0xa0/0x104)
[<c0337dec>] (__driver_attach) from [<c0335fe8>] (bus_for_each_dev+0x54/0x78)
[<c0335fe8>] (bus_for_each_dev) from [<c0336fbc>] (bus_add_driver+0x1b4/0x22c)
[<c0336fbc>] (bus_add_driver) from [<c03384bc>] (driver_register+0xa0/0xe0)
[<c03384bc>] (driver_register) from [<c0102620>] (do_one_initcall+0x124/0x14c)
[<c0102620>] (do_one_initcall) from [<c016d300>] (do_init_module+0x54/0x1c0)
[<c016d300>] (do_init_module) from [<c016ca48>] (load_module+0x1e90/0x1fb0)
[<c016ca48>] (load_module) from [<c016cd80>] (SyS_finit_module+0xb4/0xc4)
[<c016cd80>] (SyS_finit_module) from [<c0101000>] (ret_fast_syscall+0x0/0x54)
Exception stack(0xdde2bfa8 to 0xdde2bff0)
bfa0:                   004f23b0 beb7cdc4 00000007 b6f7e0d8 00000000 004f22f8
bfc0: 004f23b0 beb7cdc4 beb7cdbc 0000017b 004faec8 00000000 00000000 004fd1d0
bfe0: beb7cca8 beb7cc98 b6f77cc5 b6edfba2
---[ end trace b8768b734ce0c288 ]---
omap_hsmmc: probe of 4809c000.mmc failed with error -12

Please note that "Trying to free nonexistent resource" caused by calling
devm_release_mem_region() twice.

Fixes will be sent separately.

Best regards,
	ladis
