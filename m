Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49104 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751099AbcCHRu3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 8 Mar 2016 12:50:29 -0500
Date: Tue, 8 Mar 2016 11:50:20 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Andi Kleen <ak@linux.intel.com>,
	Jayachandran Chandrashekaran Nair
	<jayachandran.chandrashekaran@broadcom.com>,
	Rob Herring <robh@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 0/3] PCI: Avoid touching non-compliant BARs
Message-ID: <20160308175020.GD19869@localhost>
References: <20160226155334.9113.77645.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160226155334.9113.77645.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 26, 2016 at 09:58:42AM -0600, Bjorn Helgaas wrote:
> Hi guys,
> 
> Here's a proposal for dealing with these devices that have non-BAR
> registers where BARs are supposed to be.  The idea is to:
> 
>   - have an early quirk mark these devices,
>   - disable IO & MEM decoding so the devices don't consume address space
>     we don't know about, and
>   - skip BAR sizing (so the struct resources stay zeroed out)
> 
> This is basically a modification of what Andi originally proposed.  The
> difference here is that we never touch the BAR at all, and we don't have to
> add any struct resource flags, so we don't have to worry about changing any
> consumers of the struct resources.
> 
> Let me know what you think.
> 
> ---
> 
> Bjorn Helgaas (3):
>       PCI: Disable IO/MEM decoding for devices with non-compliant BARs
>       x86/PCI: Mark Broadwell-EP Home Agent & PCU as having non-compliant BARs
>       PCI: Mark Broadcom Vulcan bridges as having non-compliant BARs
> 
> 
>  arch/x86/pci/fixup.c |    7 +++++++
>  drivers/pci/probe.c  |   14 ++++++++++++++
>  drivers/pci/quirks.c |   14 ++++++++++++++
>  include/linux/pci.h  |    1 +
>  4 files changed, 36 insertions(+)

I applied the first two patches, with Andi's Tested-by, to
pci/resource for v4.6.

Per Jayachandran, the Broadcom patch turned out not to be necessary,
so I dropped that one.

Bjorn
