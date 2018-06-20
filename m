Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:5464 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933277AbeFTVvb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Jun 2018 17:51:31 -0400
Date: Wed, 20 Jun 2018 15:54:42 -0600
From: Keith Busch <keith.busch@intel.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Oza Pawandeep <poza@codeaurora.org>
Subject: Re: [PATCH 1/7] PCI/DPC: Leave interrupts enabled while handling
 event
Message-ID: <20180620215442.GA25124@localhost.localdomain>
References: <20180620213833.25072-1-keith.busch@intel.com>
 <801facdf-dbdf-12c1-c470-a97db065b232@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <801facdf-dbdf-12c1-c470-a97db065b232@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 20, 2018 at 05:42:51PM -0400, Sinan Kaya wrote:
> On 6/20/2018 5:38 PM, Keith Busch wrote:
> > Now that the DPC driver clears the interrupt status before exiting the
> > irq handler, we don't need to abuse the DPC control register to know if
> > a shared interrupt is for a new DPC event: a DPC port can not trigger
> > a second interrupt until the host clears the trigger status later in the
> > work queue handler.
> > 
> > Signed-off-by: Keith Busch <keith.busch@intel.com>
> 
> Isn't this a problem with legacy interrupts on the root ports with no MSI?
> (can be tested with pci=nomsi)
> 
> DPC interrupt handler gets called for all service driver interrupts like AER, PME and
> HP.

According to PCIe spec, the DPC level-triggered interrupt requires
these:

  The Interrupt Disable bit in Comand register is 0b
  The value of DPC Interrupt Enable bit is 1b
  The value of the DPC Interrupt Status bit is 1b

We now clear DPC Interrupt Status bit prior to exiting the IRQ handler,
so that should satisfy clearing INTx messages, making the DPC Interrupt
Enable control toggling redundant. We weren't doing that before, so this
would have been a problem back then.

If a shared interrupt occurs for another service (say, AER) before DPC's
bottom half handler runs, the DPC Interrupt Status won't be set, so the
DPC driver will return IRQ_NONE.
