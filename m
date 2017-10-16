Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752540AbdJPVXW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Oct 2017 17:23:22 -0400
Date: Mon, 16 Oct 2017 16:23:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wilson.Snyder@cavium.com,
        alex.williamson@redhat.com, David Daney <david.daney@cavium.com>,
        Manish Jaggi <mjaggi@caviumnetworks.com>
Subject: Re: [PATCH v6] PCI: quirks: update Cavium ThunderX ACS quirk
 implementation
Message-ID: <20171016212320.GI25517@bhelgaas-glaptop.roam.corp.google.com>
References: <1506344920-24016-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
 <1506536439-29318-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1506536439-29318-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc David, Manish]

Please use a subject line that tells more about what's going on.
"Update quirk" doesn't really convey any useful information.
Something like "Apply Cavium ThunderX ACS quirk only to Root Ports".

On Wed, Sep 27, 2017 at 11:20:39AM -0700, Vadim Lomovtsev wrote:
> This commit makes Cavium PCI ACS quirk applicable only to Cavium
> ThunderX (CN8XXX) family PCIE Root Ports which has limited PCI capabilities
> in terms of no ACS support advertisement. However, the RTL internally
> implements similar protection as if ACS had completion/request redirection,
> upstream forwarding and validation features enabled.
> 
> Current quirk implementation doesn't take into account PCIERCs which
> also needs to be quirked. So the pci device id check mask is updated
> and check of device ID moved into separate function.

s/PCIE/PCIe/ above

s/PCIERCs/PCIe Root Ports/ (I assume, since usually a Root Complex
itself doesn't appear as a pci_dev)

> Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
> ---
> 	v5 -> v6: comment typo fix: change 0xa00 to 0xa000
> 
>  drivers/pci/quirks.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index a4d3361..ed6c76d 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4211,20 +4211,33 @@ static int pci_quirk_amd_sb_acs(struct pci_dev *dev, u16 acs_flags)
>  #endif
>  }
>  
> -static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
> +/*
> + * The Cavium downstream ports doesn't advertise their ACS capability registers.
> + * However, the RTL internally implements similar protection as if
> + * ACS had completion redirection, forwarding and validation features enabled.
> + * So by this flags we're asserting that the hardware implements and
> + * enables equivalent ACS functionality for these flags.
> + */
> +#define CAVIUM_CN8XXX_ACS_FLAGS (PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_SV | PCI_ACS_UF)

You are changing the set of flags, which isn't mentioned in the changelog.
I think the best thing would be to have two patches: one that changes the
set of flags and a second that changes the set of affected devices.

This set of flags was used twice in the original patch, so a #define made
sense.  But now you only use it once, so there's no benefit in adding the
#define, and adding it makes the change in the set of flags harder to see.

> +static __inline__  bool pci_quirk_cavium_acs_match(struct pci_dev *dev)

No need to use "__inline__" here.  This isn't performance critical,
and the compiler will probably inline it anyway because there's only
one use.

>  {
>  	/*
> -	 * Cavium devices matching this quirk do not perform peer-to-peer
> -	 * with other functions, allowing masking out these bits as if they
> -	 * were unimplemented in the ACS capability.
> +	 * Effectively selects all downstream ports for whole ThunderX 1 family
> +	 * by 0xa000 mask (which represents 8 SoCs), while the lower bits of device ID
> +	 * are used to indicate which subdevice is used within the SoC.

Please wrap your comments so they fit in 80 columns.

>  	 */
> -	acs_flags &= ~(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
> -		       PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT);
> +	return (pci_is_pcie(dev) &&
> +		(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) &&
> +		((dev->device & 0xf800) == 0xa000));

I'm just a little confused by the 0xa000 mask you refer to in the
comment, because the mask in the code is 0xf800.

Previously the quirk applied to all Cavium device IDs in the range
0xa000-0xa0ff.  Now it applies to device IDs in the range
0xa000-0xa7ff, but only if they are PCIe Root Ports.  Right?

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
> 2.4.11
> 
