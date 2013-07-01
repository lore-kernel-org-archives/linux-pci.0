Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:36609 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171Ab3GAPLm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jul 2013 11:11:42 -0400
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 2 Jul 2013 01:01:53 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id E5D292CE8044
	for <linux-pci@vger.kernel.org>; Tue,  2 Jul 2013 01:11:36 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r61EudpI64618618
	for <linux-pci@vger.kernel.org>; Tue, 2 Jul 2013 00:56:40 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r61FBZ5c002367
	for <linux-pci@vger.kernel.org>; Tue, 2 Jul 2013 01:11:36 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: weiyang@linux.vnet.ibm.com, linuxram@us.ibm.com,
	shangw@linux.vnet.ibm.com
Subject: [PATCH 4/4] PCI: fix the io resource alignment calculation in pbus_size_io()
Date: Mon,  1 Jul 2013 23:10:32 +0800
Message-Id: <1372691432-6440-5-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1372691432-6440-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1372691432-6440-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In commit 462d9303 ("PCI: Align P2P windows using pcibios_window_alignment()"),
it introduce a new method to calculate the window alignment of P2P bridge.

When the io_window_1k is set,  the calculation for the io resource alignment
is different from the original one. In the original logic before 462d9303,
the alignment is no bigger than 4K even the io_window_1k is set. The logic
introduced in 462d9303 will limit the alignment to 1k in this case.

This patch fix this issue.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Reviewed-by: Gavin Shan <shangw@linux.vnet.ibm.com>
Reviewed-by: Ram Pai <linuxram@us.ibm.com>
---
 drivers/pci/setup-bus.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index bd0ce39d..5c60ca0 100644
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

