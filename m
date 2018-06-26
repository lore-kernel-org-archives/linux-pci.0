Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933719AbeFZUj2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jun 2018 16:39:28 -0400
Date: Tue, 26 Jun 2018 15:39:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Marc Zyngier <marc.zyngier@arm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/4] PCI: shpchp: NULL pointer fix and cleanups
Message-ID: <20180626203926.GB181504@bhelgaas-glaptop.roam.corp.google.com>
References: <152996746234.260522.11381067633352986554.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <152996746234.260522.11381067633352986554.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 25, 2018 at 05:59:33PM -0500, Bjorn Helgaas wrote:
> The first patch fixes a NULL pointer dereference reported by Marc and would
> be targeted for v4.18.
> 
> The others simplify the shpchp probe path and would be for v4.19.
> 
> ---
> 
> Bjorn Helgaas (4):
>       PCI: shpchp: Manage SHPC unconditionally on non-ACPI systems
>       PCI: shpchp: Separate existence of SHPC and permission to use it
>       PCI: shpchp: Inline shpchp_is_native()
>       PCI: hotplug: Implement hotplug_is_native() only when CONFIG_ACPI=y

I applied the first (with Marc's tested-by and Mika's reviewed-by) to
for-linus for v4.18.

I applied the others with Mika's reviewed-by to pci/hotplug for v4.19.

>  drivers/pci/hotplug/acpi_pcihp.c  |   40 +++++++++++++++++++++++--------------
>  drivers/pci/hotplug/shpchp_core.c |   21 +++++++++++++++++++
>  drivers/pci/pci-acpi.c            |   29 ---------------------------
>  include/linux/pci.h               |    1 +
>  include/linux/pci_hotplug.h       |   20 ++++++++++---------
>  5 files changed, 58 insertions(+), 53 deletions(-)
