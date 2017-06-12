Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752430AbdFLV4g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Jun 2017 17:56:36 -0400
Date: Mon, 12 Jun 2017 16:56:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Stefan Assmann <sassmann@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add Intel XXV710 to broken INTx masking quirk
Message-ID: <20170612215632.GA4379@bhelgaas-glaptop.roam.corp.google.com>
References: <20170607190027.22611.92564.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170607190027.22611.92564.stgit@gimli.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 07, 2017 at 01:00:48PM -0600, Alex Williamson wrote:
> Just like the other XL710 and X710 variants, the XXV710 device IDs
> appear to have the same hardware bug, the status register doesn't
> report pending interrupts resulting in "irq xx: nobody cared..."
> errors from the spurious interrupt handler when we try to use it
> with device assignment.
> 
> Reported-by: Stefan Assmann <sassmann@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>

Applied with Jesse's ack to pci/virtualization for v4.13, thanks!

> ---
>  drivers/pci/quirks.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 16e6cd86ad71..aa1c9e65f562 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3236,6 +3236,10 @@ static void quirk_broken_intx_masking(struct pci_dev *dev)
>  			quirk_broken_intx_masking);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1589,
>  			quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x158a,
> +			quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x158b,
> +			quirk_broken_intx_masking);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x37d0,
>  			quirk_broken_intx_masking);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x37d1,
> 
