Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbeGLWDW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Jul 2018 18:03:22 -0400
Date: Thu, 12 Jul 2018 16:51:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Tai <thomas.tai@oracle.com>
Cc: bhelgaas@google.com, poza@codeaurora.org,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH V2, 0/1] PCI/AER: fix use-after-free in
 pcie_do_fatal_recovery
Message-ID: <20180712215151.GD28466@bhelgaas-glaptop.roam.corp.google.com>
References: <1531416823-17841-1-git-send-email-thomas.tai@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1531416823-17841-1-git-send-email-thomas.tai@oracle.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Keith for DPC question]

On Thu, Jul 12, 2018 at 11:33:42AM -0600, Thomas Tai wrote:
> Hi Bjorn,
> Thank you very much to review the V1 patch. I reworked the patch as
> you have suggested. Your suggestion is indeed better and cleaner.
> Would you please have a look for me?
> 
> FYI, I did not clear the device structure in aer_isr_one_error()
> just to avoid over complicated the fix.

I think that was a bad idea anyway.  I think the problem there is that
add_error_device() copies the pci_dev pointer without taking a
reference on it:

  aer_isr
    get_e_source              # dequeue from rpc->e_sources[]
      *e_src = rpc->e_sources[x]
    aer_isr_one_error
      pdev = rpc->rpd         # pdev = Root Port pci_dev
      find_source_device(pdev)
	find_device_iter
	  add_error_device
	    e_info->dev[i] = dev   # <-- save pci_dev pointer
      aer_process_err_devices
	handle_error_source(e_info->dev[i])
	  pcie_do_fatal_recovery

At this point, we have pci_dev pointers in e_info->dev[] that are
potentially stale.  Right now nobody uses them, but I think it's
sloppy that we still have them at all.

I think a better way to fix this would be to call pci_dev_get() in
add_error_device() when we save the pointer, and then do the
corresponding pci_dev_put() in aer_isr_one_error(), after we return
from aer_process_err_devices().

This could be done with a little helper function that iterates through
e_info->dev[i], calls pci_dev_put() for each, and clears
e_info->error_dev_num (which could then be removed from
find_source_device()).

I think this would fix the problem you're seeing, so we wouldn't need
the change in pcie_do_fatal_recovery().

However, I think we're also slightly exposed in dpc_work(), in basically
the same (possibly harmless) way.

  dpc_irq
    schedule_work(&dpc->work)
  ...
  dpc_work
    pdev = dpc->dev->port
    pcie_do_fatal_recovery(pdev)

pdev may be removed by pcie_do_fatal_recovery(), but dpc_work() is still
holding onto a pointer (which it never uses again).

The DPC driver should be holding a reference to pdev (through some black
magic I don't understand), but that would be released when pdev is removed,
and I don't know what ensures that dpc_work() runs before that release.

Bjorn
