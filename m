Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:38490 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbeIFWHb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Sep 2018 18:07:31 -0400
Subject: Re: [PATCHv2 00/20] PCI, error handling and hot plug
To: Keith Busch <keith.busch@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>
References: <20180905203546.21921-1-keith.busch@intel.com>
From: Thomas Tai <thomas.tai@oracle.com>
Message-ID: <81a2db94-f4a9-73a6-6853-16d31fa749b9@oracle.com>
Date: Thu, 6 Sep 2018 13:30:47 -0400
MIME-Version: 1.0
In-Reply-To: <20180905203546.21921-1-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Keith,
Which tag or branch is your patch based on? I can't apply it on the 
master branch of 
https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git

Thank you,
Thomas

On 09/05/2018 04:35 PM, Keith Busch wrote:
> v1 -> v2:
> 
>    * Use Dennis' patch for the incorrect slot reset detection since he
>      posted that fix first
> 
>    * I found some DPC and HPC capable ports (PLX Device 9781 to be
>      specific) that don't have data-link active reporting capabilities,
>      so I added another patch to handle that
> 
>    * If the recovery determines the precence detection has changed during
>      error handling, we need to prevent the downstream driver from
>      accessing the device under its old context. This was a little tricky
>      because of a circular dependency on the pci_bus_sem, so there is a
>      prep patch to allow recursive pci bus walking, and then we use it
>      from pciehp's slot_reset callback.
> 
>    * Make error handling not able to change the error state away from
>      pci_channel_state_perm_failure so that hotplug and error handling
>      may use the same state (suggested by Benjamin Herrenschmidt)
> 
>    * Moved the link active wait requirements into generic code
>      (suggested by Sinan Kaya)
> 
>    * Check for successful secondary bus reset on recovery failure
>      (suggested by Sinan Kaya)
> 
>    * Use pcie_device for service driver error callbacks (suggested by
>      Lukas Wunner)
> 
>    * Hold pci_slot_lock when doing a slot reset (suggested by
>      Lukas Wunner)
> 
>    * Fixed processing user orderly hotplug requests during error handling
>      suggested by Lukas Wunner)
> 
>    * Various code cleanups (suggested by Christoph Hellwig)
> 
>    * Split dpc code cleanup into separate patch
> 
>    * Changelog grammer fixes and wording clarity
> 
> Dennis Dalessandro (1):
>    PCI: Fix faulty logic in pci_reset_bus()
> 
> Keith Busch (18):
>    PCI: Add required waits on link active
>    PCI/AER: Remove dead code
>    PCI/ERR: Use slot reset if available
>    PCI/ERR: Handle fatal error recovery
>    PCI/ERR: Always use the first downstream port
>    PCI/ERR: Simplify broadcast callouts
>    PCI/ERR: Report current recovery status for udev
>    PCI/ERR: Remove devices on recovery failure
>    PCI/portdrv: Provide pci error callbacks
>    PCI/portdrv: Restore pci state on slot reset
>    PCI: Make link active reporting detection generic
>    PCI: Create recursive bus walk
>    PCI/pciehp: Fix powerfault detection order
>    PCI/pciehp: Implement error handling callbacks
>    PCI/pciehp: Ignore link events during DPC event
>    PCI/DPC: Wait for link active after reset
>    PCI/DPC: Link reset code cleanup
>    PCI: Unify device inaccessible
> 
> Lukas Wunner (1):
>    PCI: Simplify disconnected marking
> 
>   drivers/pci/bus.c                 |  14 +-
>   drivers/pci/hotplug/pciehp.h      |   2 +-
>   drivers/pci/hotplug/pciehp_core.c |  39 +++++
>   drivers/pci/hotplug/pciehp_hpc.c  |  56 +++----
>   drivers/pci/hotplug/pciehp_pci.c  |   9 +-
>   drivers/pci/pci.c                 |  68 +++++++-
>   drivers/pci/pci.h                 |  17 +-
>   drivers/pci/pcie/aer.c            |  27 ++--
>   drivers/pci/pcie/dpc.c            |  37 +++--
>   drivers/pci/pcie/err.c            | 327 +++++++++++++-------------------------
>   drivers/pci/pcie/portdrv.h        |  10 +-
>   drivers/pci/pcie/portdrv_pci.c    |  45 +++++-
>   drivers/pci/probe.c               |   1 +
>   drivers/pci/slot.c                |   2 +-
>   include/linux/pci.h               |  10 ++
>   15 files changed, 353 insertions(+), 311 deletions(-)
> 
