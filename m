Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 9 Jul 2015 11:30:30 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	David Ahern <david.ahern@oracle.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 36/36] PCI: Don't set flags to 0 when assign resource fail
Message-ID: <20150709033030.GA7079@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1436225966-27247-1-git-send-email-yinghai@kernel.org>
 <1436225966-27247-37-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436225966-27247-37-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi, Yinghai

This patch may introduce some problem.

On my P8 machine, after applying this patch, I see following error:

[    0.589948] pnv_ioda_setup_pe_seg: trigger IO SEG 0
[    0.589992] pnv_ioda_setup_pe_seg: res[io  0x1000-0x3fff] 100

The last 0x100 is the res->flags, which indicates the UNSET and DISABLED bit
is not set.

On P8, we don't have IO window, which means the IO BAR will not be assigned.
And those io_segmap is not allocated. The following trace is printed since the
io_segmap is accessed, while it is NULL.

[    0.590050] Unable to handle kernel paging request for data at address 0x00000000
[    0.590115] Faulting instruction address: 0xc0000000000759b8
[    0.590172] Oops: Kernel access of bad area, sig: 11 [#1]
[    0.590216] SMP NR_CPUS=1024 NUMA PowerNV
[    0.590262] Modules linked in:
[    0.590309] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.2.0-rc1eeh_refactor+ #244
[    0.590375] task: c000002ff4380000 ti: c000002ff6084000 task.ti: c000002ff6084000
[    0.590440] NIP: c0000000000759b8 LR: c000000000075960 CTR: 000000003004a1bc
[    0.590506] REGS: c000002ff6087620 TRAP: 0300   Not tainted  (4.2.0-rc1eeh_refactor+)
[    0.590572] MSR: 9000000000009032 <SF,HV,EE,ME,IR,DR,RI>  CR: 22000028  XER: 20000000
[    0.590727] CFAR: c000000000008468 DAR: 0000000000000000 DSISR: 42000000 SOFTE: 1 
GPR00: c000000000075960 c000002ff60878a0 c000000001534f00 0000000000000031 
GPR04: 0000000000000001 0000000000000003 0000000000000000 0000000000000000 
GPR08: 0000000000000006 0000000000000000 0000000000000000 00000000000003f2 
GPR12: 0000000022000022 c00000000fda0000 c000000000b82c88 0000000000000000 
GPR16: 0000000000003fff 0000000000000000 0000000000001000 c000000000b82cc8 
GPR20: c000000000b82c50 c000000000b82c70 c000000001452148 c000002fffb2d900 
GPR24: c000000000923c40 c000002fffb4c810 c000002fffb4c300 0000000000102000 
GPR28: c000002fffb40720 c000001ff42aa500 c000002fffb4c580 0000000000000000 
[    0.591603] NIP [c0000000000759b8] .pnv_pci_ioda_fixup+0xaa8/0xb20
[    0.591658] LR [c000000000075960] .pnv_pci_ioda_fixup+0xa50/0xb20
[    0.591713] Call Trace:
[    0.591736] [c000002ff60878a0] [c000000000075960] .pnv_pci_ioda_fixup+0xa50/0xb20 (unreliable)
[    0.591824] [c000002ff6087a40] [c000000000caf0a8] .pcibios_resource_survey+0x3a8/0x404
[    0.591901] [c000002ff6087b60] [c000000000cae7f0] .pcibios_init+0xa0/0xd4
[    0.591968] [c000002ff6087bf0] [c00000000000ad30] .do_one_initcall+0x110/0x280
[    0.592045] [c000002ff6087ce0] [c000000000ca45c4] .kernel_init_freeable+0x274/0x35c
[    0.592122] [c000002ff6087db0] [c00000000000b5e4] .kernel_init+0x24/0x140
[    0.592188] [c000002ff6087e30] [c0000000000094e8] .ret_from_kernel_thread+0x58/0x70
[    0.592265] Instruction dump:
[    0.592298] 7d3107b4 7f084840 7e525214 7fb09040 4099f7b8 419cf7b4 e93e0180 811c0024 
[    0.592408] 7a2a1764 38a00003 7a270420 38c00000 <7d09512e> a09c0026 e87e0018 4bff1c59 
[    0.592524] ---[ end trace 856c9d223a60380c ]---
[    0.593584] 
[    2.593742] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    2.593742] 
[    2.605223] Rebooting in 10 seconds..


On Mon, Jul 06, 2015 at 04:39:26PM -0700, Yinghai Lu wrote:
>make flags take IORESOURCE_UNSET | IORESOURCE_DISABLED instead.
>
>Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>---
> drivers/pci/setup-bus.c | 52 +++++++++++++++++++++++++------------------------
> drivers/pci/setup-res.c | 11 +++++++++++
> 2 files changed, 38 insertions(+), 25 deletions(-)
>
>diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>index 9b27e15..e82655b 100644
>--- a/drivers/pci/setup-bus.c
>+++ b/drivers/pci/setup-bus.c
>@@ -255,7 +255,8 @@ static void pdev_check_resources(struct pci_dev *dev,
> 		if (r->flags & IORESOURCE_PCI_FIXED)
> 			continue;
>
>-		if (!(r->flags) || r->parent)
>+		if (!r->flags || r->parent ||
>+		    (r->flags & IORESOURCE_DISABLED))
> 			continue;
>
> 		r_align = __pci_resource_alignment(dev, r, realloc_head);
>@@ -296,13 +297,6 @@ static void __dev_check_resources(struct pci_dev *dev,
> 	pdev_check_resources(dev, realloc_head, head);
> }
>
>-static inline void reset_resource(struct resource *res)
>-{
>-	res->start = 0;
>-	res->end = 0;
>-	res->flags = 0;
>-}
>-
> static void __sort_resources(struct list_head *head)
> {
> 	struct pci_dev_resource *res1, *tmp_res, *res2;
>@@ -387,7 +381,7 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
> 	list_for_each_entry_safe(add_res, tmp, realloc_head, list) {
> 		res = add_res->res;
> 		/* skip resource that has been reset */
>-		if (!res->flags)
>+		if (res->flags & IORESOURCE_DISABLED)
> 			goto out;
>
> 		/* skip this resource if not found in head list */
>@@ -405,7 +399,7 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
> 			res->start = align;
> 			res->end = res->start + add_size - 1;
> 			if (pci_assign_resource(add_res->dev, idx))
>-				reset_resource(res);
>+				res->flags |= IORESOURCE_DISABLED;
> 		} else {
> 			/* could just assigned with alt, add difference ? */
> 			if (r_size < add_res->must_size)
>@@ -454,7 +448,7 @@ static void assign_requested_resources_sorted(struct list_head *head,
> 		    pci_assign_resource(dev_res->dev, idx)) {
> 			if (fail_head)
> 				add_to_list(fail_head, dev_res->dev, res);
>-			reset_resource(res);
>+			res->flags |= IORESOURCE_DISABLED;
> 		}
> 	}
> }
>@@ -672,7 +666,7 @@ static void __assign_resources_alt_sorted(struct list_head *head,
> 			release_resource(dev_res->res);
> 			/* put into fail list */
> 			add_to_list(local_fail_head, dev_res->dev, res);
>-			reset_resource(res);
>+			res->flags |= IORESOURCE_DISABLED;
> 		}
>
> 		alt_res = res_to_dev_res(realloc_head, res);
>@@ -716,7 +710,7 @@ static void __assign_resources_alt_sorted(struct list_head *head,
> 		res->end = res->start + dev_res->must_size - 1;
>
> 		add_to_list(local_fail_head, fail_res->dev, res);
>-		reset_resource(res);
>+		res->flags |= IORESOURCE_DISABLED;
> 	}
> 	free_list(&local_alt_fail_head);
> }
>@@ -872,7 +866,7 @@ static void pci_setup_bridge_io(struct pci_dev *bridge)
> 	/* Set up the top and bottom of the PCI I/O segment for this bus. */
> 	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 0];
> 	pcibios_resource_to_bus(bridge->bus, &region, res);
>-	if (res->flags & IORESOURCE_IO) {
>+	if ((res->flags & IORESOURCE_IO) && !(res->flags & IORESOURCE_UNSET)) {
> 		pci_read_config_word(bridge, PCI_IO_BASE, &l);
> 		io_base_lo = (region.start >> 8) & io_mask;
> 		io_limit_lo = (region.end >> 8) & io_mask;
>@@ -902,7 +896,8 @@ static void pci_setup_bridge_mmio(struct pci_dev *bridge)
> 	/* Set up the top and bottom of the PCI Memory segment for this bus. */
> 	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 1];
> 	pcibios_resource_to_bus(bridge->bus, &region, res);
>-	if (res->flags & IORESOURCE_MEM) {
>+	if ((res->flags & IORESOURCE_MEM) &&
>+	    !(res->flags & IORESOURCE_UNSET)) {
> 		l = (region.start >> 16) & 0xfff0;
> 		l |= region.end & 0xfff00000;
> 		dev_info(&bridge->dev, "  bridge window %pR\n", res);
>@@ -927,7 +922,8 @@ static void pci_setup_bridge_mmio_pref(struct pci_dev *bridge)
> 	bu = lu = 0;
> 	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 2];
> 	pcibios_resource_to_bus(bridge->bus, &region, res);
>-	if (res->flags & IORESOURCE_PREFETCH) {
>+	if ((res->flags & IORESOURCE_PREFETCH) &&
>+	    !(res->flags & IORESOURCE_UNSET)) {
> 		l = (region.start >> 16) & 0xfff0;
> 		l |= region.end & 0xfff00000;
> 		if (res->flags & IORESOURCE_MEM_64) {
>@@ -1046,6 +1042,7 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
>
> 	b_res = &bridge->resource[PCI_BRIDGE_RESOURCES];
> 	b_res[1].flags |= IORESOURCE_MEM;
>+	b_res[1].flags &= ~IORESOURCE_DISABLED;
>
> 	pci_read_config_word(bridge, PCI_IO_BASE, &io);
> 	if (!io) {
>@@ -1053,8 +1050,10 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
> 		pci_read_config_word(bridge, PCI_IO_BASE, &io);
> 		pci_write_config_word(bridge, PCI_IO_BASE, 0x0);
> 	}
>-	if (io)
>+	if (io) {
> 		b_res[0].flags |= IORESOURCE_IO;
>+		b_res[0].flags &= ~IORESOURCE_DISABLED;
>+	}
>
> 	/*  DECchip 21050 pass 2 errata: the bridge may miss an address
> 	    disconnect boundary by one PCI data phase.
>@@ -1071,6 +1070,7 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
> 	}
> 	if (pmem) {
> 		b_res[2].flags |= IORESOURCE_MEM | IORESOURCE_PREFETCH;
>+		b_res[2].flags &= ~IORESOURCE_DISABLED;
> 		if ((pmem & PCI_PREF_RANGE_TYPE_MASK) ==
> 		    PCI_PREF_RANGE_TYPE_64) {
> 			b_res[2].flags |= IORESOURCE_MEM_64;
>@@ -1214,8 +1214,10 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
> 			struct resource *r = &dev->resource[i];
> 			unsigned long r_size;
>
>-			if (r->parent || !(r->flags & IORESOURCE_IO))
>+			if (r->parent || !(r->flags & IORESOURCE_IO) ||
>+			    (r->flags & IORESOURCE_DISABLED))
> 				continue;
>+
> 			r_size = resource_size(r);
>
> 			if (r_size < 0x400)
>@@ -1244,7 +1246,7 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
> 		if (b_res->start || b_res->end)
> 			dev_info(&bus->self->dev, "disabling bridge window %pR to %pR (unused)\n",
> 				 b_res, &bus->busn_res);
>-		b_res->flags = 0;
>+		b_res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
> 		return;
> 	}
>
>@@ -1513,7 +1515,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>
> 			if (r->parent || ((flags & mask) != type &&
> 					  (flags & mask) != type2 &&
>-					  (flags & mask) != type3))
>+					  (flags & mask) != type3) ||
>+			    (r->flags & IORESOURCE_DISABLED))
> 				continue;
>
> 			r_size = resource_size(r);
>@@ -1534,7 +1537,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
> 			if (align > (1ULL<<37)) { /*128 Gb*/
> 				dev_warn(&dev->dev, "disabling BAR %d: %pR (bad alignment %#llx)\n",
> 					i, r, (unsigned long long) align);
>-				r->flags = 0;
>+				r->flags |= IORESOURCE_UNSET |
>+					    IORESOURCE_DISABLED;
> 				continue;
> 			}
>
>@@ -1622,7 +1626,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
> 		if (b_res->start || b_res->end)
> 			dev_info(&bus->self->dev, "disabling bridge window %pR to %pR (unused)\n",
> 				 b_res, &bus->busn_res);
>-		b_res->flags = 0;
>+		b_res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
> 		return 0;
> 	}
> 	b_res->start = min_align;
>@@ -2024,7 +2028,7 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
> 		/* keep the old size */
> 		r->end = resource_size(r) - 1;
> 		r->start = 0;
>-		r->flags = 0;
>+		r->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
>
> 		/* avoiding touch the one without PREF */
> 		if (type & IORESOURCE_PREFETCH)
>@@ -2284,7 +2288,6 @@ again:
> 		res->end = fail_res->end;
> 		res->flags = fail_res->flags;
> 		if (fail_res->dev->subordinate) {
>-			res->flags = 0;
> 			/* last or third times and later */
> 			if (tried_times + 1 == pci_try_num ||
> 			    tried_times + 1 > 2) {
>@@ -2372,7 +2375,6 @@ again:
> 		res->end = fail_res->end;
> 		res->flags = fail_res->flags;
> 		if (fail_res->dev->subordinate) {
>-			res->flags = 0;
> 			/* last time */
> 			res->start = 0;
> 			res->end = res->start - 1;
>diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
>index 26aedde..2a5cddc 100644
>--- a/drivers/pci/setup-res.c
>+++ b/drivers/pci/setup-res.c
>@@ -371,6 +371,17 @@ int pci_enable_resources(struct pci_dev *dev, int mask)
> 			continue;
>
> 		if (r->flags & IORESOURCE_UNSET) {
>+			/* bridge BAR could be disabled one by one */
>+			if (dev->subordinate && i >= PCI_BRIDGE_RESOURCES &&
>+						i <= PCI_BRIDGE_RESOURCE_END)
>+				continue;
>+
>+#ifdef CONFIG_PCI_IOV
>+			/* SRIOV ? */
>+			if (i >= PCI_IOV_RESOURCES && i <= PCI_IOV_RESOURCE_END)
>+				continue;
>+#endif
>+
> 			dev_err(&dev->dev, "can't enable device: BAR %d %pR not assigned\n",
> 				i, r);
> 			return -EINVAL;
>-- 
>1.8.4.5

-- 
Richard Yang
Help you, Help me

