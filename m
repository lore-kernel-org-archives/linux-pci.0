Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:8005 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751271AbcJUQ6R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Oct 2016 12:58:17 -0400
Date: Fri, 21 Oct 2016 13:08:46 -0400
From: Keith Busch <keith.busch@intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>, Wei Zhang <wzhang@fb.com>,
        Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCHv3 2/5] pci: Add is_removed state
Message-ID: <20161021170846.GA8633@localhost.localdomain>
References: <1475007815-28354-1-git-send-email-keith.busch@intel.com>
 <1475007815-28354-3-git-send-email-keith.busch@intel.com>
 <20161021162010.GB4221@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161021162010.GB4221@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 21, 2016 at 06:20:10PM +0200, Lukas Wunner wrote:
> I've found that the following simple change on top of your series is
> already sufficient to make hot-removal of the Apple Gigabit Ethernet
> adapter "just work" (no more soft lockups, which is a giant improvement):
> 
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 5c43012..cc8b234 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -406,7 +406,7 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus);
>  
>  static inline int pci_channel_offline(struct pci_dev *pdev)
>  {
> -	return (pdev->error_state != pci_channel_io_normal);
> +	return pdev->error_state != pci_channel_io_normal || pdev->is_removed;
>  }
>  
>  struct pci_host_bridge {
> 
> 
> This got me thinking:  We've got three pci_channel_state values defined
> in include/linux/pci.h, "normal", "frozen" and "perm_failure".  Instead
> of adding a new "is_removed" bit to struct pci_dev, would it perhaps
> make more sense to just add a new type of pci_channel_state for removed
> devices?  Then the above change to pci_channel_offline() wouldn't even
> be necessary.  The pciehp and dpc drivers would just change the channel
> status to "removed" and all the drivers already querying it with
> pci_channel_offline() would pick up the change automatically.
> 
> Thoughts?

I'd be happy if we can reuse that, but concerned about overloading
error_state's intended purpose for AER. The conditions under which an
'is_removed' may be set can also create AER events, and the aer driver
overrides the error_state.
