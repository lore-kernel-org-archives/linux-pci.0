Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:41909 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753095AbcKHO7p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Nov 2016 09:59:45 -0500
Date: Tue, 8 Nov 2016 15:59:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jan Beulich <JBeulich@suse.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, tglx@linutronix.de,
        hch@lst.de, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/MSI: pci_irq_get_affinity() should cope with NULL
        affinity vector
Message-ID: <20161108145943.GD12817@lst.de>
References: <5821904A020000780011CF55@prv-mh.provo.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5821904A020000780011CF55@prv-mh.provo.novell.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 08, 2016 at 12:43:54AM -0700, Jan Beulich wrote:
> msi_setup_entry() only logs a message when the affinity vector can't be
> allocated, and hence pci_irq_get_affinity() indexing entry->affinity is
> wrong without a prior check.

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But just curious: did you run into that case in practice?
