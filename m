Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753722AbcKWRjv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Nov 2016 12:39:51 -0500
Date: Wed, 23 Nov 2016 11:39:46 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Noa Osherovich <noaos@mellanox.com>, linux-pci@vger.kernel.org,
        majd@mellanox.com, gwshan@linux.vnet.ibm.com
Subject: Re: [PATCH v3 0/5] Unmarking Mellanox devices with broken INTx
 masking
Message-ID: <20161123173946.GE16033@bhelgaas-glaptop.roam.corp.google.com>
References: <20161117232458.2003.88193.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161117232458.2003.88193.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 17, 2016 at 05:29:54PM -0600, Bjorn Helgaas wrote:
> Maybe the third time is the charm.  This is basically the v1 you posted,
> but I added an mlx4 update to use the new device ID definitions.  That way
> grep and cscope will find the ID both places, so we can match the quirk
> with the related driver.
> 
> This is on the pci/virtualization branch.  And I did build it this time.
> 
> v2 -> v3
> - Add device ID definitions to pci_ids.h (from original patch of Nov 1)
> - Use new definitions in mlx4 driver (new patch)
> - Use new definitions in quirks (as in v1 patches)
> 
> v1 -> v2 (pushed to pci/virtualization branch but not posted on list)
> - Bjorn removed device ID definitions (which broke build)
> - Bjorn reordered so Mellanox wasn't in the middle of other quirk list
> - Bjorn moved pci_disable_device() to end of quirk
> 
> v0 -> v1
> Fixes according to Gavin Shan's comments:
> - Patch numbering was wrong
> - Fixed logic of mellanox_check_broken_intx_masking
> 
> ---
> 
> Bjorn Helgaas (1):
>       net/mlx4_core: Use device ID defines
> 
> Noa Osherovich (4):
>       PCI: Add Mellanox device IDs
>       PCI: Convert broken INTx masking quirks from HEADER to FINAL
>       PCI: Convert Mellanox broken INTx quirks to be for listed devices only
>       PCI: Support INTx masking on ConnectX-4 with firmware x.14.1100+
> 
> 
>  drivers/net/ethernet/mellanox/mlx4/main.c |   78 +++++++-------
>  drivers/pci/quirks.c                      |  159 ++++++++++++++++++++++-------
>  include/linux/pci_ids.h                   |   27 ++++-
>  3 files changed, 181 insertions(+), 83 deletions(-)

I added Tariq's ack on "net/mlx4_core: Use device ID defines" and applied
these on pci/virtualization for v4.10.
