Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46570 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751625AbcDFNfG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 6 Apr 2016 09:35:06 -0400
Date: Wed, 6 Apr 2016 08:35:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Engraf <david.engraf@sysgo.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org
Subject: Re: Exception due to PCI: Use pci_is_root_bus() to check for root bus
Message-ID: <20160406133502.GB4976@localhost>
References: <5704F85B.4080501@sysgo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5704F85B.4080501@sysgo.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi David,

On Wed, Apr 06, 2016 at 01:51:55PM +0200, David Engraf wrote:
> Hi,
> 
> I have an exception in __pci_bus_size_bridges() when pci_is_root_bus
> returns false but bus->self == NULL. My driver registers a virtual
> bus, like virtfn_add_bus(). pci_add_new_bus() is called with a
> parent but without a pci_dev. Thus bus->parent is set but bus->self
> is NULL. When __pci_bus_size_bridges() is called I get an exception
> at:
> 
> switch (bus->self->class >> 8)
> 
> The previous version of the code, checking for bus->self != NULL
> worked for me. I think an additional check is required to make sure
> we're not accessing a NULL pointer.

When you say "previous version of the code," do you mean a previous
version of Linux worked correctly but a newer version does not?  What
versions are they?  Did you identify a commit that changed the
behavior?  I assume you're talking about an out-of-tree driver that
registers a virtual bus?  Can you point us to the code?  Can you share
the dmesg log, including the backtrace?

Bjorn
