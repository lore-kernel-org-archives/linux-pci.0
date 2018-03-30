Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:37022 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751322AbeC3Q3K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Mar 2018 12:29:10 -0400
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Tal Gilboa <talgi@mellanox.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: Linux PCI <linux-pci@vger.kernel.org>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: RE: [PATCH next V4 0/8] Report PCI device link status
Date: Fri, 30 Mar 2018 16:29:08 +0000
Message-ID: <02874ECE860811409154E81DA85FBB5882D44EAF@ORSMSX115.amr.corp.intel.com>
References: <1522394086-3555-1-git-send-email-talgi@mellanox.com>
In-Reply-To: <1522394086-3555-1-git-send-email-talgi@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Tal Gilboa [mailto:talgi@mellanox.com]
> Sent: Friday, March 30, 2018 12:15 AM
> To: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Linux PCI <linux-pci@vger.kernel.org>; Tariq Toukan <tariqt@mellanox.com>;
> Saeed Mahameed <saeedm@mellanox.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Tal Gilboa <talgi@mellanox.com>
> Subject: [PATCH next V4 0/8] Report PCI device link status
> 
> These patches introduce the ability to report PCI link width
> and speed for all PCI devices in kernel log.
> This would reduce code duplication between drivers and unify
> the approach for reporting PCI link status.
> Implemented and tested for Mellanox devices.
> 
> v4: Reverted most of v2, meaning re-introduced bandwidth limitation calculation.
> Limiting device is now returned from the available PCIe bandwidth calculation
> function and is logged in kernel log (suggested by Bjorn Helgaas and Jacob E.
> Keller).
> 
> Applied PCIe encoding overhead to PCIe bandwidth calculation
> (available/capable).
> this way upper bandwidth limit of the device is more accurate.
> 

I didn't find any objections to the series. We can probably remove the old function in the future once no one uses it anymore.

Acked-by: Jacob Keller <jacob.e.keller@intel.com>

> v3: Add Reviewed-by: Tariq Toukan to all commits.
> 
> v2: Remove chain BW calculation. This might be a nice feature, but
> without the ability to know the exact limiting part, it is more
> confusing than useful.
> Remove warnings for failed PCI query actions, leaving only the status
> and gaps from max capabilities report.
> Use pci_warn()/pci_info() instead of dev_warn()/dev_info().
> (suggested by Bjorn Helgaas).
> 
> v1: Split to multiple patches, calculate BW limitation and remove
> MACRO definition for LNKCAP shift (suggested by Bjorn Helgaas).
> Multiple fixes - conventions, typos, function naming and functional
> (suggested by Tariq Toukan).
> 
> Tal Gilboa (8):
>   PCI: Add a query function for PCI device's speed cap
>   PCI: Add a query function for PCI device's width cap
>   PCI: Add device link bandwidth capabilities calculation
>   PCI: Calculate available bandwidth for PCI devices
>   PCI: Print PCI device link status in kernel log
>   net/mlx4_core: Report PCI properties using dedicated function
>   net/mlx5: Report device PCI link status and issues
>   net/mlx5e: Use generic PCI function for bandwidth calculation
> 
>  drivers/net/ethernet/mellanox/mlx4/main.c         |  81 +----------
>  drivers/net/ethernet/mellanox/mlx5/core/en_main.c |  17 +--
>  drivers/net/ethernet/mellanox/mlx5/core/main.c    |   4 +
>  drivers/pci/pci-sysfs.c                           |  28 ++--
>  drivers/pci/pci.c                                 | 161 +++++++++++++++++++++-
>  include/linux/pci.h                               |  24 ++++
>  6 files changed, 194 insertions(+), 121 deletions(-)
> 
> --
> 1.8.3.1
