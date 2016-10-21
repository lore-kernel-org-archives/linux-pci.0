Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:37779 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935179AbcJUQTo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Oct 2016 12:19:44 -0400
Date: Fri, 21 Oct 2016 18:20:10 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>, Wei Zhang <wzhang@fb.com>,
        Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCHv3 2/5] pci: Add is_removed state
Message-ID: <20161021162010.GB4221@wunner.de>
References: <1475007815-28354-1-git-send-email-keith.busch@intel.com>
 <1475007815-28354-3-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1475007815-28354-3-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 27, 2016 at 04:23:32PM -0400, Keith Busch wrote:
> This adds a new state for devices that were once in the system, but
> unexpectedly removed. This is so device tear down functions can observe
> the device is not accessible so it may skip attempting to initialize
> the hardware.
[...]
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -337,6 +337,7 @@ struct pci_dev {
>  	unsigned int	multifunction:1;/* Part of multi-function device */
>  	/* keep track of device state */
>  	unsigned int	is_added:1;
> +	unsigned int	is_removed:1;	/* device was surprise removed */
>  	unsigned int	is_busmaster:1; /* device is busmaster */
>  	unsigned int	no_msi:1;	/* device may not use msi */
>  	unsigned int	no_64bit_msi:1; /* device may only use 32-bit MSIs */

The tg3 driver (as well as many other drivers) already check reachability
of a device before accessing its mmio space by calling pci_channel_offline().

I've found that the following simple change on top of your series is
already sufficient to make hot-removal of the Apple Gigabit Ethernet
adapter "just work" (no more soft lockups, which is a giant improvement):


diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5c43012..cc8b234 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -406,7 +406,7 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus);
 
 static inline int pci_channel_offline(struct pci_dev *pdev)
 {
-	return (pdev->error_state != pci_channel_io_normal);
+	return pdev->error_state != pci_channel_io_normal || pdev->is_removed;
 }
 
 struct pci_host_bridge {


This got me thinking:  We've got three pci_channel_state values defined
in include/linux/pci.h, "normal", "frozen" and "perm_failure".  Instead
of adding a new "is_removed" bit to struct pci_dev, would it perhaps
make more sense to just add a new type of pci_channel_state for removed
devices?  Then the above change to pci_channel_offline() wouldn't even
be necessary.  The pciehp and dpc drivers would just change the channel
status to "removed" and all the drivers already querying it with
pci_channel_offline() would pick up the change automatically.

Thoughts?

Thanks,

Lukas
