Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751894AbeFEWMQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Jun 2018 18:12:16 -0400
Date: Tue, 5 Jun 2018 17:11:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Alex_Gagniuc@Dellteam.com,
        Scott Bauer <scott.bauer@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>
Subject: Re: [PATCH 0/4] PCI/AER: Use-after-free fix
Message-ID: <20180605221128.GC226399@bhelgaas-glaptop.roam.corp.google.com>
References: <20180409220444.6632-1-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180409220444.6632-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 09, 2018 at 04:04:40PM -0600, Keith Busch wrote:
> AER error handling walks the PCI topology below a root port, saving
> pointers of the pci_dev structs affected by the error along the way.
> 
> At the same time, the pcie hotplug driver could be freeing those very
> same structures, causing the AER driver to reference freed memory.
> 
> This series fixes this by synchroniziing the aer driver with the pci
> hotplug driver during. The final patch is the one that ultimately provides
> the locking by having AER lock the same pci lock rescan/remove mutex as
> the pciehp driver. The first three patches are prepping to make it safe
> for the aer bottom half handler to hold that lock.
> 
> Keith Busch (4):
>   PCI/AER: Remove unused parameters
>   PCI/AER: Replace struct pcie_device with pci_dev
>   PCI/AER: Reference count aer structures
>   PCI/AER: Lock pci topology when scanning errors
> 
>  drivers/pci/pcie/aer/aerdrv.c      | 28 +++++++++++++++++++++-------
>  drivers/pci/pcie/aer/aerdrv.h      |  9 +++------
>  drivers/pci/pcie/aer/aerdrv_core.c | 38 +++++++++++++++++---------------------
>  3 files changed, 41 insertions(+), 34 deletions(-)

I applied the first two to pci/aer for v4.18, thanks!

I think the last two might need some rework to adapt after Oza's patches. 
