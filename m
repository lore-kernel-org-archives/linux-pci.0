Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:55677 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758247Ab3HBJds (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 Aug 2013 05:33:48 -0400
Received: from /spool/local
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Fri, 2 Aug 2013 19:23:14 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 5DDF92BB004F
	for <linux-pci@vger.kernel.org>; Fri,  2 Aug 2013 19:33:42 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r729XWau10748278
	for <linux-pci@vger.kernel.org>; Fri, 2 Aug 2013 19:33:32 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id r729Xf1D009849
	for <linux-pci@vger.kernel.org>; Fri, 2 Aug 2013 19:33:42 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: linuxram@us.ibm.com, shangw@linux.vnet.ibm.com,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH 4/4] PCI: fix the io resource alignment calculation in pbus_size_io()
Date: Fri,  2 Aug 2013 17:31:06 +0800
Message-Id: <1375435866-16332-5-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1375435866-16332-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1375435866-16332-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In commit 462d9303 ("PCI: Align P2P windows using pcibios_window_alignment()"),
it introduce a new method to calculate the window alignment of P2P bridge.

When the io_window_1k is set,  the calculation for the io resource alignment
is different from the original one. In the original logic before 462d9303,
the alignment is no bigger than 4K even the io_window_1k is set. The logic
introduced in 462d9303 will limit the alignment to 1k in this case.

This patch fix this issue.

Here is an example for this case.

Assume:
        1. pcibios_window_alignment() return 1.
        2. window_alignment() return PCI_P2P_DEFAULT_IO_ALIGN_1K.
        3. one of the child device has an IO resource with size of 2K.

Result comparison:

                    Before 462d9303             After 462d9303
    min_align       1k                          1k
                                        |
                             after loop |
                                        V
    min_align       2k                          2k
                                        |
                         check boundary |
                                        V
    min_align       2k                          1k

After applying the change:

Result comparison:

                    with  462d9303             with this patch
    min_align       1k                          1k
    io_align        1k                          4k
                                        |
                             after loop |
                                        V
    min_align       2k                          2k
    io_align        1k                          4k
                                        |
                         check boundary |
                                        V
    min_align       1k                          2k
    io_align        1k                          1k

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/setup-bus.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index d4f1ad9..6c111e9 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -755,6 +755,10 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
  		return;
 
 	io_align = min_align = window_alignment(bus, IORESOURCE_IO);
+	/* Don't exceed 4KiB for windows requesting 1KiB alignment */
+	if (bus->self->io_window_1k && io_align == PCI_P2P_DEFAULT_IO_ALIGN_1K)
+		io_align = PCI_P2P_DEFAULT_IO_ALIGN;
+
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		int i;
 
-- 
1.7.5.4

