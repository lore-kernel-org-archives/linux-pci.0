Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:14011 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666Ab2H2I7P (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Aug 2012 04:59:15 -0400
Message-ID: <503DD9A7.70007@huawei.com>
Date: Wed, 29 Aug 2012 16:58:15 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>,
	PCI <linux-pci@vger.kernel.org>
CC: Jiang Liu <jiang.liu@huawei.com>, Hanjun Guo <guohanjun@huawei.com>
Subject: a small problem about pci_stop_and_remove_bus_device() function
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,
   The drivers/pci/remove.c now is so clean after applied series "[PATCH v2 00/16] Clean up drivers/pci/remove.c"(very good ^_^).
I have a small problem about pci_stop_and_remove_bus_device() function. Traditionally, pci_bus is removed after its pci bridge stop.
But now pci_bus is remove before its pci brdige. So If I use pci_bus_type notifier, I can't identify pci_dev whether is bridge(by pci_dev->subordinate)
when notifier arrives.
   What about move pci_remove_bus after stop pci bridge?

 82     if (bus) {
 83         list_for_each_entry_safe_reverse(child, tmp,
 84                          &bus->devices, bus_list)
 85             pci_stop_and_remove_bus_device(child);
 86
 87     }
 88
 89     pci_stop_dev(dev);
 90     if (bus) {
 91         pci_remove_bus(bus);
 92         dev->subordinate = NULL;
 93     }
 94     pci_destroy_dev(dev);


-- 
Thanks!
Yijing

