Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:33309 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755004Ab3LITbO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 9 Dec 2013 14:31:14 -0500
Date: Mon, 9 Dec 2013 12:31:12 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: Prevent bus conflicts while checking for bridge
 apertures
Message-ID: <20131209193112.GA20199@obsidianresearch.com>
References: <20131206001333.27659.59935.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20131206001947.27659.14981.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131206001947.27659.14981.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 05, 2013 at 05:19:47PM -0700, Bjorn Helgaas wrote:
> pci_bridge_check_ranges() determines whether the bridge supports an I/O
> aperture and a prefetchable memory aperture.
> 
> Previously, if the I/O aperture was unsupported, disabled, or configured at
> [io 0x0000-0x0fff], we wrote 0xf0 to PCI_IO_BASE and PCI_IO_LIMIT, which,
> if the bridge supports it, enables the I/O aperture at [io 0xf000-0xffff].
> The enabled aperture may conflict with other devices in the system.
> 
> Similarly, we wrote 0xfff0 to PCI_PREF_MEMORY_BASE and
> PCI_PREF_MEMORY_LIMIT, which enables the prefetchable memory aperture at
> [mem 0xfff00000-0xffffffff], and that may also conflict with other devices.
> 
> All we need to know is whether the base and limit registers are writable,
> so we can use values that leave the apertures disabled, e.g., PCI_IO_BASE =
> 0xf0, PCI_IO_LIMIT = 0xe0, PCI_PREF_MEMORY_BASE = 0xfff0,
> PCI_PREF_MEMORY_LIMIT = 0xffe0.
> 
> Writing non-zero values to both the base and limit registers means we
> detect whether either or both are writable, as we did before.

Looks sane to me. The only refinement would be to detect if IO is
enabled and use that as a first check.

Cheers,
Jason
