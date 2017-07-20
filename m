Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965298AbdGTWW6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jul 2017 18:22:58 -0400
Date: Thu, 20 Jul 2017 16:22:55 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Feng Kan <fkan@apm.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com
Subject: Re: [PATCH V2] pci: quirk: Apply APM ACS quirk to XGene devices
Message-ID: <20170720162255.36e015f1@ul30vt.home>
In-Reply-To: <1500511611-2019-1-git-send-email-fkan@apm.com>
References: <1500511611-2019-1-git-send-email-fkan@apm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 19 Jul 2017 17:46:51 -0700
Feng Kan <fkan@apm.com> wrote:

> The APM X-Gene PCIe root port does not support ACS at this point.
> However, the hw provides isolation and source validation through
> the SMMU. Turn on ACS but disable all the peer to peer features.
> 
> Signed-off-by: Feng Kan <fkan@apm.com>
> ---
>  drivers/pci/quirks.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 085fb78..0f8f1cd 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4120,6 +4120,19 @@ static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
>  	return acs_flags ? 0 : 1;
>  }
>  
> +static int pci_quirk_xgene_acs(struct pci_dev *dev, u16 acs_flags)
> +{
> +	/*
> +	 * XGene root matching this quirk do not allow peer-to-peer
> +	 * transactions with others, allowing masking out these bits as if they
> +	 * were unimplemented in the ACS capability.
> +	 */
> +	acs_flags &= ~(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
> +		       PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT);
> +
> +	return acs_flags ? 0 : 1;
> +}
> +
>  /*
>   * Many Intel PCH root ports do provide ACS-like features to disable peer
>   * transactions and validate bus numbers in requests, but do not provide an
> @@ -4368,6 +4381,8 @@ static int pci_quirk_mf_endpoint_acs(struct pci_dev *dev, u16 acs_flags)
>  	{ 0x10df, 0x720, pci_quirk_mf_endpoint_acs }, /* Emulex Skyhawk-R */
>  	/* Cavium ThunderX */
>  	{ PCI_VENDOR_ID_CAVIUM, PCI_ANY_ID, pci_quirk_cavium_acs },
> +	/* APM XGene */
> +	{ PCI_VENDOR_ID_AMCC, 0xE004, pci_quirk_xgene_acs },
>  	{ 0 }
>  };
>  

Sorry, I'm not yet convinced there's an equivalent of SV, if a device
spoofs a different bdf and it reaches the smmu, what prevents that from
simply referencing the context for that alternate bdf?  The point of
root port SV is to ensure that any forwarded transaction is within the
downstream bdf range.  Thanks,

Alex
