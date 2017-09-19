Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 19 Sep 2017 11:58:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI: Fixup the RTIT_BAR of Intel TH on Denverton
Message-ID: <20170919165842.GA22312@bhelgaas-glaptop.roam.corp.google.com>
References: <20170919145136.13527-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170919145136.13527-1-alexander.shishkin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alexander,

On Tue, Sep 19, 2017 at 05:51:36PM +0300, Alexander Shishkin wrote:
> On some intergrations of the Intel TH the reported size of RTIT_BAR

s/intergrations/integrations/

What is "TH"?  If there's a public spec for it, can you include a
reference here?

I guess this is an erratum, since the device responds to more MMIO
space than it advertises via the BAR.  Can you include a reference to
the published erratum?

I'm surprised that this issue occurs so often on Intel parts.  I would
think that after being burned a few times, Intel would figure out a
process to validate this.

> doesn't match its actual size, which leads to overlaps with other
> devices' resources.

So I suppose the BIOS relies on the size advertised via the BAR,
assigns it to be just below the XHCI space, and now both the TH and
XHCI respond there?  I assume this causes some sort of "unexpected
response" error?  Is there a bug report about this?  What does it look
like when a user hits this?  I'm trying to make this fix discoverable
to users who might trip over the problem.

> For this reason, we need to resize the RTIT_BAR on Denverton where
> it would overlap with XHCI MMIO space.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Fixes: 5118ccd347 ("intel_th: pci: Add Denverton SOC support")

Please use a 12-char SHA1.

> Cc: stable@vger.kernel.org

I guess this is only applicable to v4.11+, since 5118ccd34780 appeared in
v4.11-rc4?

> ---
>  drivers/pci/quirks.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 6967c6b4cf..08a1e6629f 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4681,3 +4681,19 @@ static void quirk_intel_no_flr(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_intel_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_intel_no_flr);
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
> +	}
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x19e1, quirk_intel_th_dnv);
> -- 
> 2.14.1
> 
