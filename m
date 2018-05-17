Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750924AbeEQNZj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 May 2018 09:25:39 -0400
Date: Thu, 17 May 2018 08:25:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: dmeyer@gigaio.com
Cc: logang@deltatee.com, kurt.schwemmer@microsemi.com,
        linux-pci@vger.kernel.org, linux-ntb@googlegroups.com,
        bhelgaas@google.com, jdmason@kudzu.us, dave.jiang@intel.com,
        allenbh@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] NTB: Migrate PCI Constants to Cannonical PCI Header
Message-ID: <20180517132536.GB19955@bhelgaas-glaptop.roam.corp.google.com>
References: <1526558413-23113-1-git-send-email-dmeyer@gigaio.com>
 <1526558413-23113-2-git-send-email-dmeyer@gigaio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1526558413-23113-2-git-send-email-dmeyer@gigaio.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Doug,

Thanks for the patches!

On Thu, May 17, 2018 at 05:00:12AM -0700, dmeyer@gigaio.com wrote:
> From: Doug Meyer <dmeyer@gigaio.com>
> 
> This is the first of two patches to implement a PCI quirk which will
> allow the Switchtec NTB code to work with the IOMMU turned on.
> 
> Here, the Microsemi Switchtec PCI vendor and device ID constants are
> moved to the canonical location in pci_ids.h. Also, Microsemi class
> constants are replaced with the standard PCI usage.
> 
> Signed-off-by: Doug Meyer <dmeyer@gigaio.com>
> ---
>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c |  3 ++-
>  drivers/pci/switch/switchtec.c         | 15 +++++++--------
>  include/linux/pci_ids.h                | 32 ++++++++++++++++++++++++++++++++
>  include/linux/switchtec.h              |  4 ----
>  4 files changed, 41 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> index f624ae2..5ee5f40 100644
> --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> @@ -19,6 +19,7 @@
>  #include <linux/kthread.h>
>  #include <linux/interrupt.h>
>  #include <linux/ntb.h>
> +#include <linux/pci.h>
>  
>  MODULE_DESCRIPTION("Microsemi Switchtec(tm) NTB Driver");
>  MODULE_VERSION("0.1");
> @@ -1487,7 +1488,7 @@ static int switchtec_ntb_add(struct device *dev,
>  
>  	stdev->sndev = NULL;
>  
> -	if (stdev->pdev->class != MICROSEMI_NTB_CLASSCODE)
> +	if (stdev->pdev->class != (PCI_CLASS_BRIDGE_OTHER << 8))
>  		return -ENODEV;
>  
>  	sndev = kzalloc_node(sizeof(*sndev), GFP_KERNEL, dev_to_node(dev));
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index 47cd0c0..07a03b9 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -1,4 +1,3 @@
> -// SPDX-License-Identifier: GPL-2.0

This looks like a mistake?  I doubt you intended to remove the SPDX
header.

> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index cc608fc5..7b04ca95 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -3073,4 +3073,36 @@
>  
>  #define PCI_VENDOR_ID_OCZ		0x1b85
>  
> +#define PCI_VENDOR_ID_MICROSEMI			0x11f8

1) Please move the PCI_VENDOR_ID_MICROSEMI definition to keep the file
   sorted by vendor ID.  It should end up next to the
   PCI_VENDOR_ID_PMC_Sierra definition, which I guess makes sense
   because it looks like Microsemi acquired PMC-Sierra.
   
   The XEN and OCZ definitions got added out of sequence.  I'll fix
   those separately.

2) We no longer add device IDs to pci_ids.h (unless they're shared
   between multiple drivers).  These don't look shared, so just use
   the raw hex IDs in quirks.c.

3) Please make the class code changes a separate patch.  That makes
   both patches easier to review.

4) Typo in subject: s/Cannonical/canonical/

> +#define PCI_DEVICE_ID_MICROSEMI_PFX24XG3	0x8531
> +#define PCI_DEVICE_ID_MICROSEMI_PFX32XG3	0x8532
