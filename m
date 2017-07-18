Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751461AbdGRCXZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Jul 2017 22:23:25 -0400
Date: Mon, 17 Jul 2017 20:23:24 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Feng Kan <fkan@apm.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com
Subject: Re: [PATCH] pci: quirk: Apply APM ACS quirk to XGene devices
Message-ID: <20170717202324.105e993c@w520.home>
In-Reply-To: <1500338752-30576-1-git-send-email-fkan@apm.com>
References: <1500338752-30576-1-git-send-email-fkan@apm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 17 Jul 2017 17:45:52 -0700
Feng Kan <fkan@apm.com> wrote:

> The APM X-Gene PCIe root port does not support ACS at this point.
> Since the root does not allow peer to peer transactions, mask out
> ACS capability flag bits.
> 
> Signed-off-by: Feng Kan <fkan@apm.com>
> ---
>  drivers/pci/quirks.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 085fb78..951064d 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4368,6 +4368,8 @@ static int pci_quirk_mf_endpoint_acs(struct pci_dev *dev, u16 acs_flags)
>  	{ 0x10df, 0x720, pci_quirk_mf_endpoint_acs }, /* Emulex Skyhawk-R */
>  	/* Cavium ThunderX */
>  	{ PCI_VENDOR_ID_CAVIUM, PCI_ANY_ID, pci_quirk_cavium_acs },
> +	/* APM XGene */
> +	{ PCI_VENDOR_ID_AMCC, 0xE004, pci_quirk_mf_endpoint_acs },
>  	{ 0 }
>  };


You're using the "mf_enpoint" quirk for something that is not an
endpoint and may or may not be multi-function.  Downstream ports have
different rules than multi-function endpoints and the quirk function is
commented to reflect why certain fields are relevant or not to
multi-function endpoints.  I don't think it's valid to use this quirk
for other device types, we'd only need to accidentally test the assumed
device type in that function to break you in the future. Additionally,
lack of peer to peer does not necessarily imply functionality like
Source Validation, without which a device can spoof the requester ID.
Thanks,

Alex
