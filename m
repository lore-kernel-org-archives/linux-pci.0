Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:45223 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbbJOKrM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2015 06:47:12 -0400
From: Wenlin Kang <wenlin.kang@windriver.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] pci: restrict 64-bit pci device to assign resource from behind of max_pfn
Date: Thu, 15 Oct 2015 18:46:44 +0800
Message-ID: <1444906004-2083-1-git-send-email-wenlin.kang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch restricts 64-bit pci device to assign resource from behind of
max_pfn when kernel config enables CONFIG_64BIT.

On some system that pci device requires assignment of large resource(eg,
1GB or larger), sometimes,the assignment of some devices may fail under
the current way.

e.g. the follow case is that.

...
[    0.000000] e820: [mem 0x90000000-0xfed1bfff] available for PCI devices
[    0.000000] setup_percpu: NR_CPUS:128 nr_cpumask_bits:128 nr_cpu_ids:72 nr_node_ids:2
...
[    6.564750] pci 0000:00:1c.7:   bridge window [mem 0x9f000000-0xa08fffff]
[    6.587130] pci 0000:84:06.0: BAR 14: can't assign mem (size 0x60000000)
[    6.609158] pci 0000:84:00.0: BAR 14: can't assign mem (size 0x100000)
...

On this case, although the kernel has [0x90000000-0xfed1bfff] [1.73GB]
size space is available for PCI devices, assignment of some devices fail
yet, the cause is the resource isn't yet enough for devices.

After apply this patch, this problem get resolved, the patch makes kernel
assign resource from behind of max_pfn for 64-bit pci devices when kernel
is 64BIT, however, previous way always assigns resource below 4GB no
matter it is 32 or 64-bit devices, so this patch extends this window of
pci resource on 64-bit system that both 32 and 64-bit pci device exist or
only 64-bit device exists, makes it more likely that we can assign
resource to more or all devices.

Signed-off-by: wlkang <wlkang2008@126.com>
Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
---
 drivers/pci/setup-res.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 232f925..dafd667 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -206,7 +206,19 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 	resource_size_t min;
 	int ret;
 
+#ifdef CONFIG_64BIT
+	/*
+	 * For 64-bit pci device, assign resource start from the next page
+	 * boundary above the maximum physical page address
+	 */
+	resource_size_t min_iomem;
+
+	min_iomem = (res->flags & IORESOURCE_MEM_64) ?
+				(max_pfn + 1) << PAGE_SHIFT : PCIBIOS_MIN_MEM;
+	min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : min_iomem;
+#else
 	min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
+#endif
 
 	/*
 	 * First, try exact prefetching match.  Even if a 64-bit
-- 
1.7.9.5

