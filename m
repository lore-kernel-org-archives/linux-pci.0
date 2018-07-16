Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730688AbeGPWhA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Jul 2018 18:37:00 -0400
Date: Mon, 16 Jul 2018 17:07:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Oza Pawandeep <poza@codeaurora.org>
Subject: Re: [PATCH 1/7] PCI/DPC: Leave interrupts enabled while handling
 event
Message-ID: <20180716220735.GC12391@bhelgaas-glaptop.roam.corp.google.com>
References: <20180620213833.25072-1-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180620213833.25072-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 20, 2018 at 03:38:27PM -0600, Keith Busch wrote:
> Now that the DPC driver clears the interrupt status before exiting the
> irq handler, we don't need to abuse the DPC control register to know if
> a shared interrupt is for a new DPC event: a DPC port can not trigger
> a second interrupt until the host clears the trigger status later in the
> work queue handler.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>

I applied all of these with Sinan and Oza's reviewed-by to pci/dpc for
v4.19, thanks!

I moved the AER API stuff from include/linux/aer.h to
drivers/pci/pci.h.  Let me know if that's a problem.  I didn't see a
reason to expose those details outside the PCI core.

Bjorn
