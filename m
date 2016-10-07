Return-Path: <keith.busch@intel.com>
Return-Path: <keith.busch@intel.com>
Date: Fri, 7 Oct 2016 13:45:49 -0400
From: Keith Busch <keith.busch@intel.com>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: helgaas@kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI/VMD: Use the more reliable method for setting
 the AER
Message-ID: <20161007174548.GA4746@localhost.localdomain>
References: <1475861189-10794-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1475861189-10794-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 07, 2016 at 11:26:28AM -0600, Jon Derrick wrote:
> Instead of relying on the domain being >= 0x10000, use the member of the
> pci sysdata that identifies a VMD root port bus.

'is_vmd' is only defined for x86. You'll need a '#define is_vmd' to
false in some arch generic place.


> ---
>  drivers/pci/quirks.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index edc7f96..713035f 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4438,8 +4438,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
>   */
>  static void quirk_no_aersid(struct pci_dev *pdev)
>  {
> -	/* VMD Domain */
> -	if (pdev->bus->sysdata && pci_domain_nr(pdev->bus) >= 0x10000)
> +	if (is_vmd(pdev->bus))
>  		pdev->bus->bus_flags |= PCI_BUS_FLAGS_NO_AERSID;
>  }
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2030, quirk_no_aersid);
