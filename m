Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0059.outbound.protection.outlook.com ([104.47.37.59]:7831
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751537AbdITLd3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Sep 2017 07:33:29 -0400
Date: Wed, 20 Sep 2017 04:33:21 -0700
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex.williamson@redhat.com
Cc: Wilson.Snyder@cavium.com, Vadim.Lomovtsev@cavium.com
Subject: Re: [PATCH v4] PCI: quirks: update Cavium ThunderX ACS quirk
 implementation
Message-ID: <20170920113321.GA32496@localhost.localdomain>
References: <1505480233-22694-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
 <1505724481-28413-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1505724481-28413-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi guys,

Sorry for annoying topic ..
Could you please provide your comments/objections on this if any ?

WBR,
Vadim

On Mon, Sep 18, 2017 at 01:48:01AM -0700, Vadim Lomovtsev wrote:
> This commit makes Cavium PCI ACS quirk applicable only to Cavium
> ThunderX (CN81/83/88XX) PCIE Root Ports which has limited PCI capabilities
> in terms of no ACS support advertisement. However, the RTL internally
> implements similar protection as if ACS had completion/request redirection,
> upstream forwarding and validation features enabled.
> 
> Current quirk implementation doesn't take into account PCIERCs which
> also needs to be quirked. So the pci device id check mask is updated
> and check of device ID moved into separate function.
> 
> Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
> ---
> 	v1	: put device check into separate function and extend it to all
> 		  Cavium PCIERC/PCCBR devices;
> 	v1 -> v2: update match function in order to filter only ThunderX devices by device
> 	      	  ids to properly filter CN8XXX devices, update subject & description with
> 		  ACS register info (rejected by maillist due to triple X in subject);
> 	v2 -> v3: update subject: remove CN8XXX from subject line, replace it with ThunderX;
> 	v3 -> v4: update ACS mask (remove TB and TD bits), update commit message (remove
> 	      	  ACS register printout);
> 
>  drivers/pci/quirks.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index a4d3361..e6b904a 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4211,20 +4211,26 @@ static int pci_quirk_amd_sb_acs(struct pci_dev *dev, u16 acs_flags)
>  #endif
>  }
>  
> -static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
> +/*
> + * Cavium devices matching this quirk do not perform peer-to-peer
> + * with other functions, allowing masking out these bits as if they
> + * were unimplemented in the ACS capability.
> + */
> +#define CAVIUM_CN8XXX_ACS_FLAGS (PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_SV | PCI_ACS_UF)
> +
> +static __inline__  bool pci_quirk_cavium_acs_match(struct pci_dev *dev)
>  {
> -	/*
> -	 * Cavium devices matching this quirk do not perform peer-to-peer
> -	 * with other functions, allowing masking out these bits as if they
> -	 * were unimplemented in the ACS capability.
> -	 */
> -	acs_flags &= ~(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
> -		       PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT);
> +	return (pci_is_pcie(dev) &&
> +		(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) &&
> +		((dev->device & 0xf800) == 0xa000));
> +}
>  
> -	if (!((dev->device >= 0xa000) && (dev->device <= 0xa0ff)))
> +static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
> +{
> +	if (!pci_quirk_cavium_acs_match(dev))
>  		return -ENOTTY;
>  
> -	return acs_flags ? 0 : 1;
> +	return acs_flags & ~(CAVIUM_CN8XXX_ACS_FLAGS) ? 0 : 1;
>  }
>  
>  static int pci_quirk_xgene_acs(struct pci_dev *dev, u16 acs_flags)
> -- 
> 2.9.5
> 
