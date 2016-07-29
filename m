Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52886 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752937AbcG2Wbc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 29 Jul 2016 18:31:32 -0400
Date: Fri, 29 Jul 2016 17:31:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Edward Cree <ecree@solarflare.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	linux-net-drivers@solarflare.com
Subject: Re: [PATCH] pci: quirks: Add ACS quirk to Solarflare SFC9220
Message-ID: <20160729223127.GA13632@localhost>
References: <df310014-18d6-0f65-e902-107b04577090@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <df310014-18d6-0f65-e902-107b04577090@solarflare.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 28, 2016 at 06:13:56PM +0100, Edward Cree wrote:
> Device does not perform peer-to-peer between functions.
> 
> Signed-off-by: Edward Cree <ecree@solarflare.com>

Applied to pci/virtualization.  This is tiny, so I think we can squeeze it
in for v4.8.

> ---
>  drivers/pci/quirks.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b69321c..37ff015 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4095,6 +4095,7 @@ static const struct pci_dev_acs_enabled {
>  	{ PCI_VENDOR_ID_AMD, 0x7809, pci_quirk_amd_sb_acs },
>  	{ PCI_VENDOR_ID_SOLARFLARE, 0x0903, pci_quirk_mf_endpoint_acs },
>  	{ PCI_VENDOR_ID_SOLARFLARE, 0x0923, pci_quirk_mf_endpoint_acs },
> +	{ PCI_VENDOR_ID_SOLARFLARE, 0x0A03, pci_quirk_mf_endpoint_acs },
>  	{ PCI_VENDOR_ID_INTEL, 0x10C6, pci_quirk_mf_endpoint_acs },
>  	{ PCI_VENDOR_ID_INTEL, 0x10DB, pci_quirk_mf_endpoint_acs },
>  	{ PCI_VENDOR_ID_INTEL, 0x10DD, pci_quirk_mf_endpoint_acs },
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
