Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:39484 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932626AbcJURTf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Oct 2016 13:19:35 -0400
Date: Fri, 21 Oct 2016 13:30:04 -0400
From: Keith Busch <keith.busch@intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>, Wei Zhang <wzhang@fb.com>
Subject: Re: [PATCHv3 2/5] pci: Add is_removed state
Message-ID: <20161021173004.GB8633@localhost.localdomain>
References: <1475007815-28354-1-git-send-email-keith.busch@intel.com>
 <1475007815-28354-3-git-send-email-keith.busch@intel.com>
 <20161021165810.GD4221@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161021165810.GD4221@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 21, 2016 at 06:58:10PM +0200, Lukas Wunner wrote:
> On Tue, Sep 27, 2016 at 04:23:32PM -0400, Keith Busch wrote:
> I note that you've removed the change to pci_device_is_present()
> completely from v3 of this patch, however only a portion of the
> change was problematic.  This portion would have been okay:
> 
> 
> +	if (pdev->is_removed)
> +		return false;
>  
> 	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0);
> 
> 
> Up to you if you want to include this in the next iteration or not.

I was thinking it didn't matter since patch 3/5 has config access return
-ENODEV on a removed pci_dev, but pci_bus_read_dev_vendor_id doesn't use
the pci_dev. I'll add it back in.
