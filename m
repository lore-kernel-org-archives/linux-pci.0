Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932127AbdJZQvg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Oct 2017 12:51:36 -0400
Date: Thu, 26 Oct 2017 11:51:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] PCI: Fixup the RTIT_BAR of Intel TH on Denverton
Message-ID: <20171026165134.GA21991@bhelgaas-glaptop.roam.corp.google.com>
References: <20171026142817.17791-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171026142817.17791-1-alexander.shishkin@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 26, 2017 at 05:28:17PM +0300, Alexander Shishkin wrote:
> On some integrations of the Intel(R) Trace Hub (for a reference and
> overview see Documentation/trace/intel_th.txt) the reported size of
> one of its resources (RTIT_BAR) doesn't match its actual size, which
> leads to overlaps with other devices' resources.
> 
> On a Denverton platform it overlaps with XHCI MMIO space, which results
> in the xhci driver bailing out after seeing its registers as 0xffffffff,
> and perceived disappearance of all USB devices:
> 
> > intel_th_pci 0000:00:1f.7: enabling device (0004 -> 0006)
> > xhci_hcd 0000:00:15.0: xHCI host controller not responding, assume dead
> > xhci_hcd 0000:00:15.0: xHC not responding in xhci_irq, assume controller is dead
> > xhci_hcd 0000:00:15.0: HC died; cleaning up
> > usb 1-1: USB disconnect, device number 2
> ...
> 
> For this reason, we need to resize the RTIT_BAR on Denverton to its
> actual size, which in this case is 4MB.

How do you figure out the actual size?  Per sec 11.1 of the spec you
reference, RTIT_BAR (BAR2) tells us the address of the RTMR, which is
a *variable size* MMIO space.

RTIT_LBAR (sec 13.8.11) suggests that the BAR size should be between
256 and 4096 bytes.  How do you get to 4MB?  Is that a constant size
regardless of system configuration?

> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Link: https://software.intel.com/sites/default/files/managed/d3/3c/intel-th-developer-manual.pdf
> Fixes: 5118ccd34780 ("intel_th: pci: Add Denverton SOC support")

Is there an erratum for this?  If the PCI core gets the wrong number
when it sizes the BAR, it *sounds* like a hardware or possibly a BIOS
defect.

You reference 5118ccd34780 ("intel_th: pci: Add Denverton SOC
support"), but if the PCI core can't size the BAR correctly, we're
susceptible to this problem any time this device is in the system,
regardless of whether the intl_th driver claims it.

So I think referencing 5118ccd34780 is a red herring and will lead
people to wrongly conclude that "I don't need this quirk because my
kernel doesn't include 5118ccd34780."

> Cc: stable@vger.kernel.org
> ---
>  drivers/pci/quirks.c | 16 ++++++++++++++++

It looks like this could go in arch/x86/pci/fixup.c?  (There are a lot
of things in drivers/pci/quirks.c that look like they are actually
x86-specific.)

>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index a4d33619a7bb..d321ea6427b8 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4799,3 +4799,19 @@ static void quirk_no_ats(struct pci_dev *pdev)
>  /* AMD Stoney platform GPU */
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_no_ats);
>  #endif /* CONFIG_PCI_ATS */
> +
> +static void quirk_intel_th_dnv(struct pci_dev *dev)
> +{
> +	struct resource *r = &dev->resource[4];
> +
> +	/*
> +	 * Denverton reports 2k of RTIT_BAR (intel_th resource 4), which
> +	 * appears to be 4 MB in reality.
> +	 */
> +	if (r->end == r->start + 0x7ff) {
> +		r->start = 0;
> +		r->end   = 0x3fffff;
> +		r->flags |= IORESOURCE_UNSET;

Did you check that this results in the device being disabled?  I'm
concerned that if BIOS leaves the device enabled and consuming 4MB of
space (but reporting only 2KB), we may have a conflict.  I'm not sure
that updating the resource and marking it IORESOURCE_UNSET will
actually result in fixing the conflict.  E.g., maybe we can't actually
assign 4MB so we don't touch the device itself, so it remains enabled.

> +	}
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x19e1, quirk_intel_th_dnv);
> -- 
> 2.14.2
> 
