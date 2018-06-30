Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936028AbeF3BuE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Jun 2018 21:50:04 -0400
Date: Fri, 29 Jun 2018 20:50:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: dmeyer@gigaio.com
Cc: logang@deltatee.com, kurt.schwemmer@microsemi.com,
        linux-pci@vger.kernel.org, linux-ntb@googlegroups.com,
        bhelgaas@google.com, jdmason@kudzu.us, dave.jiang@intel.com,
        allenbh@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI Quirk Patchset for Microsemi Switchtec NTB
Message-ID: <20180630015002.GL40928@bhelgaas-glaptop.roam.corp.google.com>
References: <1527106686-18852-1-git-send-email-dmeyer@gigaio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1527106686-18852-1-git-send-email-dmeyer@gigaio.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 23, 2018 at 01:18:04PM -0700, dmeyer@gigaio.com wrote:
> From: Doug Meyer <dmeyer@gigaio.com>
> 
> This is a resend of the patch series to enable Microsemi Switchtec
> NTB configurations to run with the IOMMU in the hosts turned on.
> Because of the nature PCI Quirk implementation, it was preferable
> to migrate the Microsemi PCI vendor and device definitions to the
> Linux canonical location. Logan Gunthorpe requested that this
> migration be done as a separate patch in a set, and so this patch
> series was created as shown here.
> 
> The first patch encapsulates the movement of constants from
> switchtec.h to pci_ids.h, with commensurate changes to the source
> files. This patch is not dependent on any other work.
> 
> The second patch is the PCI quirk implementation itself, and is
> completely dependent upon the first patch in this series.
> 
> Testing of the quirk was done on with a 2-host x86-64 system
> with all combinations of IOMMU off/on. The ntb_perf module was
> used as test stimulus. 
> 
> Blessings,
> Doug Meyer
> 
> Changes since v1:
> - Call pci_device_disable() at return points to clean up properly.
> - Changed all dev_* print macros to pci_* macros.
> - Removed superfluous variable initializations.
> 
> Doug Meyer (2):
>   NTB: Migrate PCI Constants to Cannonical PCI Header
>   NTB: PCI Quirk to Enable Switchtec NT Functionality with IOMMU On
> 
>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c |   3 +-
>  drivers/pci/quirks.c                   | 197 +++++++++++++++++++++++++++++++++
>  drivers/pci/switch/switchtec.c         |  15 ++-
>  include/linux/pci_ids.h                |  32 ++++++
>  include/linux/switchtec.h              |   4 -
>  5 files changed, 238 insertions(+), 13 deletions(-)

I applied these with Logan's reviewed-by to my pci/switchtec branch for
v4.19 with the following updates:

  - You removed the SPDX tag from drivers/pci/switch/switchtec.c.  I assume
    that was a mistake, so I restored it.

  - I moved the PCI_VENDOR_ID_MICROSEMI definition to keep the file sorted.

  - I dropped the Device ID definitions per the policy at the top of the
    file (which I mentioned on your v1 posting).

  - I converted all the Device ID definition uses to raw hex constants.  I
    noticed that the following were defined by your patch, but not used:

      PCI_DEVICE_ID_MICROSEMI_PSX24XG3
      PCI_DEVICE_ID_MICROSEMI_PSX32XG3

    I can't tell whether the quirk is supposed to apply to them or not.

Please review and holler if I broke something.

This touches drivers/ntb/hw/..., which isn't my area.  Let me know if you'd
rather take these through a different tree.

Bjorn
