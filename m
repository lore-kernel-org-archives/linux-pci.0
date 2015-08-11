Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 11 Aug 2015 15:28:34 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, john.ronciak@intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add ACS quirks for Intel I219-LM/V
Message-ID: <20150811202834.GH13982@google.com>
References: <20150810183055.5714.12998.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150810183055.5714.12998.stgit@gimli.home>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 10, 2015 at 12:32:04PM -0600, Alex Williamson wrote:
> The Intel 100-series chipset now includes the integrated Ethernet as
> part of a multifunction package.  The Ethernet function does not
> include native ACS support, but Intel confirms that the device is not
> capable of peer-to-peer within the package.  We can therefore quirk it
> to expose the isolation.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Cc: John Ronciak <john.ronciak@intel.com>

Applied with John's ack to pci/virtualization for v4.3, thanks!

> ---
>  drivers/pci/quirks.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index e9fd0e9..a914848 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3848,6 +3848,9 @@ static const struct pci_dev_acs_enabled {
>  	{ PCI_VENDOR_ID_INTEL, 0x105F, pci_quirk_mf_endpoint_acs },
>  	{ PCI_VENDOR_ID_INTEL, 0x1060, pci_quirk_mf_endpoint_acs },
>  	{ PCI_VENDOR_ID_INTEL, 0x10D9, pci_quirk_mf_endpoint_acs },
> +	/* I219 */
> +	{ PCI_VENDOR_ID_INTEL, 0x15b7, pci_quirk_mf_endpoint_acs },
> +	{ PCI_VENDOR_ID_INTEL, 0x15b8, pci_quirk_mf_endpoint_acs },
>  	/* Intel PCH root ports */
>  	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_intel_pch_acs },
>  	{ 0x19a2, 0x710, pci_quirk_mf_endpoint_acs }, /* Emulex BE3-R */
> 
