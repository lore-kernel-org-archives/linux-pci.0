Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:48209 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751271AbcJUQ5j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Oct 2016 12:57:39 -0400
Date: Fri, 21 Oct 2016 18:58:10 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>, Wei Zhang <wzhang@fb.com>
Subject: Re: [PATCHv3 2/5] pci: Add is_removed state
Message-ID: <20161021165810.GD4221@wunner.de>
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
> 
> The pciehp and pcie-dpc drivers are aware of when the link is down,
> so these explicitly set this flag when its handlers detect the device
> is gone.

I note that you've removed the change to pci_device_is_present()
completely from v3 of this patch, however only a portion of the
change was problematic.  This portion would have been okay:


+	if (pdev->is_removed)
+		return false;
 
	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0);


Up to you if you want to include this in the next iteration or not.

Thanks,

Lukas
