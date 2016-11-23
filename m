Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935282AbcKWRgd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Nov 2016 12:36:33 -0500
Date: Wed, 23 Nov 2016 11:36:24 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/9] PCI: Tidy up messages
Message-ID: <20161123173624.GD16033@bhelgaas-glaptop.roam.corp.google.com>
References: <20161121214006.21036.11599.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161121214006.21036.11599.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 21, 2016 at 03:45:11PM -0600, Bjorn Helgaas wrote:
> Remove a few messages that don't contain any useful information, e.g.,
> 
>   pcie_pme 0000:00:02.0:pcie01: service driver pcie_pme loaded
>   pci_hotplug: PCI Hot Plug PCI Core version: 0.5
>   pciehp 0000:80:02.0:pcie04: service driver pciehp loaded
>   pciehp: PCI Express Hot Plug Controller Driver version: 0.4
> 
> NOTE: I added a patch to drop Root Complex Event Collector PME support.  I
> suspect that we really want to keep that, but it looks like it's currently
> broken.  I would welcome opinions and some help to test it if we fix the
> current breakage.
> 
> Changes from v1->v2:
>   - Drop Root Complex Event Collector PME support
>   - Add PME IRQ to existing log message
>   - Log PME message once per hierarchy, not once per device
>   - Log AER probe errors with plain PCI device, not PCIe service device
>   - Add new AER claim message, including IRQ
>   - Remove unused AER version macros
> 
> ---
> 
> Bjorn Helgaas (9):
>       PCI/PME: Drop unused support for PMEs from Root Complex Event Collectors
>       PCI/PME: Log PME IRQ when claiming Root Port
>       PCI/AER: Remove unused version macros
>       PCI/AER: Log errors with PCI device, not PCIe service device
>       PCI/AER: Log AER IRQ when claiming Root Port
>       PCI: Remove service driver load/unload messages
>       PCI: hotplug: Remove hotplug core message
>       PCI: pciehp: Remove loading message
>       PCI: Expand "VPD access disabled" quirk message
> 
> 
>  drivers/pci/hotplug/pci_hotplug_core.c |   10 +++-------
>  drivers/pci/hotplug/pciehp_core.c      |    9 ++++-----
>  drivers/pci/pcie/aer/aerdrv.c          |   18 ++++++------------
>  drivers/pci/pcie/pme.c                 |   29 +++++++----------------------
>  drivers/pci/pcie/portdrv_core.c        |    3 ---
>  drivers/pci/quirks.c                   |    2 +-
>  6 files changed, 21 insertions(+), 50 deletions(-)

I applied these (with Rafael's ack on the first two) to pci/misc for v4.10.
