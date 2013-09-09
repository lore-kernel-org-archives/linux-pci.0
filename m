Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:42001 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755085Ab3IITsn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 9 Sep 2013 15:48:43 -0400
Date: Mon, 9 Sep 2013 12:48:21 -0700
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: Xenia Ragiadakou <burzalodowa@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Dong Nguyen <Dong.Nguyen@amd.com>, linux-usb@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: setup msi-x vectors in xhci-hcd
Message-ID: <20130909194821.GA5727@xanatos>
References: <522495E5.80000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <522495E5.80000@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 02, 2013 at 04:43:01PM +0300, Xenia Ragiadakou wrote:
> Hi Sarah and Alan,
> 
> I am writing a patch for allocating as many msi-x vectors as the
> number of event rings because now the msi-x vectors allocated are
> more than are actually used, since currently xhci-hcd implements
> only one event ring.
> 
> xhci_setup_msix() limits the number of supported msi-x vectors based
> on the number of cpus in the host system, and that confuses me:
> 
> xhci->msix_count = min(num_online_cpus() + 1,
> HCS_MAX_INTRS(xhci->hcs_params1));
> 
> Can you explain me why it does so?

I'm not the original author of that patch, so I'm not sure why they did
that.  I asked them to explain why in a comment above the code:

http://marc.info/?l=linux-usb&m=127351043723713&w=2

The comment that they placed above the line didn't explain *why* they
needed they wanted to allocate an MSI-X vector per CPU, just what they
were doing:

http://marc.info/?l=linux-usb&m=127365906500373&w=2

(And now you understand why kernel developers ask for a lot of
documentation and comments.  People disappear after submitting their
code all the time.)

I suspect the original author assumed that only one MSI-X vector could
be tied to a CPU?  If that's the case, I don't know why they allocated
an extra vector.  If you're going to allocate more MSI-X vectors than
you have CPUs available, it probably makes sense to allocate as many
vectors as you have event rings.

> Also, another thing that bothers me is that, in case
> pci_enable_msix() returns a positive number which
> indicates the number of msi-x vectors supported based on the MSI-X
> Capability structure of the PCI Configuration Address Space (this
> value is returned when the requested number of msi-x vectors are
> greater than the supported number), shall i free the msix_entries
> and reallocate them for the new number
> or reimplement this check before pci_enable_msix() is called and
> take it into account when allocate msix_entries for first time?

I think you should re-implement the check, so that you allocate the
minimum of:
 - the number of MSI-X vectors the PCI device will support,
 - the number of interrupters the xHCI host will support, and
 - the number of event rings as the driver has allocated.

Sarah Sharp
