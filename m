Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.sysgo.com ([176.9.12.79]:49072 "EHLO mail.sysgo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754472AbcDFMBk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 6 Apr 2016 08:01:40 -0400
From: David Engraf <david.engraf@sysgo.com>
Subject: Exception due to PCI: Use pci_is_root_bus() to check for root bus
To: Bjorn Helgaas <bhelgaas@google.com>,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org
Message-ID: <5704F85B.4080501@sysgo.com>
Date: Wed, 6 Apr 2016 13:51:55 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I have an exception in __pci_bus_size_bridges() when pci_is_root_bus 
returns false but bus->self == NULL. My driver registers a virtual bus, 
like virtfn_add_bus(). pci_add_new_bus() is called with a parent but 
without a pci_dev. Thus bus->parent is set but bus->self is NULL. When 
__pci_bus_size_bridges() is called I get an exception at:

switch (bus->self->class >> 8)

The previous version of the code, checking for bus->self != NULL worked 
for me. I think an additional check is required to make sure we're not 
accessing a NULL pointer.

Best regards
David Engraf

