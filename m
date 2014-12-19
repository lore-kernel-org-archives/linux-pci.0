Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:38931 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751158AbaLSBiu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 18 Dec 2014 20:38:50 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, <benh@kernel.crashing.org>
Subject: Adding an ops to struct pci_host_bridge?
Date: Fri, 19 Dec 2014 11:19:20 +1030
Message-ID: <878ui4tqen.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

        On powerpc, we have a possibly-programmable device (CXL) which
we're making look a lot like a PCI bus containing devices.  Rather than
hacking "if (is_really_cxl(dev))" into every powerpc pcibios_* routine,
Ben Herrenschmidt suggested moving from pcibios_* to an ops structure
inside pci_host_bridge.

        In transition, it'd be up to the arch (ie. powerpc) to call
find_pci_host_bridge(dev->bus)->ops->xxx from their pcibios_ functions,
but if there's general interest other archs could start doing it too.

If this seems like a nice idea, we can discuss which pcibios_ functions
make sense to place into ops.

Thanks,
Rusty.
