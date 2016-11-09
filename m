Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752029AbcKIRLp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Nov 2016 12:11:45 -0500
Date: Wed, 9 Nov 2016 11:11:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexander Graf <agraf@suse.de>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/2] pci: Don't set RCB bit in LNKCTL if the upstream
 bridge hasn't
Message-ID: <20161109171140.GK14322@bhelgaas-glaptop.roam.corp.google.com>
References: <20161102223552.14776-1-jthumshirn@suse.de>
 <20161102223552.14776-2-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20161102223552.14776-2-jthumshirn@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Johannes,

On Wed, Nov 02, 2016 at 04:35:52PM -0600, Johannes Thumshirn wrote:
> The Read Completion Boundary (RCB) bit must only be set on a device or
> endpoint if it is set on the root complex.
> 
> Certain BIOSes erroneously set the RCB Bit in their ACPI _HPX Tables
> even if it is not set on the root port. This is a violation to the PCIe
> Specification and is known to bring some Mellanox Connect-X 3 HCAs into
> a state where they can't map their firmware and go into error recovery.
> 
> BIOS Information
> 	Vendor: IBM
> 	Version: -[A8E120CUS-1.30]-
> 	Release Date: 08/22/2016

This seems like a pretty serious problem (sounds like maybe the HCA is
completely useless?)

Can you point us at a bugzilla or other problem report?  It's nice to
have details of what this looks like to a user, so people who trip
over this problem have a little more chance of finding the solution.

7a1562d4f2d0 ("PCI: Apply _HPX Link Control settings to all devices
with a link") appeared in v3.18, so it's probably not a *new* problem,
so my guess is that this is v4.10 material.

> From PCI Express Base Specification 1.1,
> section 2.3.1.1. Data Return for Read Requests:
> The Read Completion Boundary (RCB) parameter determines the naturally
> aligned address boundaries on which a Read Request may be serviced with
> multiple Completions
> o For a Root Complex, RCB is 64 bytes or 128 bytes
>   o This value is reported through a configuration register
>     (see Section 7.8)
>   Note: Bridges and Endpoints may implement a corresponding command
>   bit which may be set by system software to indicate the RCB value
>   for the Root Complex, allowing the Bridge/Endpoint to optimize its
>   behavior when the Root Complex’s RCB is 128 bytes.
> o For all other system elements, RCB is 128 bytes
> 
> Table 7-16: Link Control Register:
> Configuration software must only Set this bit if the Root Port
> Upstream from the Endpoint or Bridge reports an RCB value of
> 128 bytes (a value of 1b in the Read Completion Boundary bit).
> Default value of this bit is 0b.
> 
> Functions that do not implement this feature must hardwire the
> bit to 0b.
> 
> Before commit 7a1562d4f:
> > 41:00.0 Ethernet controller: Mellanox Technologies MT27500 Family [ConnectX-3]
> > 		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
> > 			ExtSynch+ ClockPM- AutWidDis- BWInt- AutBWInt-
> >
> > 40:02.0 PCI bridge: Intel Corporation Xeon E7 v2/Xeon E5 v2/Core i7 PCI Express Root Port 2a (rev 07) (prog-if 00 [Normal decode])
> > 		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
> > 			ExtSynch+ ClockPM- AutWidDis- BWInt- AutBWInt-
> 
> After:
> > 40:02.0 PCI bridge: Intel Corporation Xeon E7 v2/Xeon E5 v2/Core i7 PCI Express Root Port 2a (rev 07) (prog-if 00 [Normal decode])
> > 		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
> > 			ExtSynch+ ClockPM- AutWidDis- BWInt- AutBWInt-
> >
> > 41:00.0 Ethernet controller: Mellanox Technologies MT27500 Family [ConnectX-3]
> > 		LnkCtl:	ASPM Disabled; RCB 128 bytes Disabled- CommClk+
> > 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 
> Fixes: 7a1562d4f ("PCI: Apply _HPX Link Control settings to all devices with a link")
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/pci/probe.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ab00267..0a4ab9c 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1439,6 +1439,19 @@ static void program_hpp_type1(struct pci_dev *dev, struct hpp_type1 *hpp)
>  		dev_warn(&dev->dev, "PCI-X settings not supported\n");
>  }
>  
> +static bool pcie_get_root_rcb(struct pci_dev *dev)
> +{
> +	struct pci_dev *rp = pcie_find_root_port(dev);
> +	u16 lnkctl;
> +
> +	if (!rp)
> +		return false;
> +
> +	pcie_capability_read_word(rp, PCI_EXP_LNKCTL, &lnkctl);
> +
> +	return lnkctl & PCI_EXP_LNKCTL_RCB;
> +}
> +
>  static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp)
>  {
>  	int pos;
> @@ -1468,9 +1481,21 @@ static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp)
>  			~hpp->pci_exp_devctl_and, hpp->pci_exp_devctl_or);
>  
>  	/* Initialize Link Control Register */
> -	if (pcie_cap_has_lnkctl(dev))
> +	if (pcie_cap_has_lnkctl(dev)) {
> +		bool rrcb;
> +		u16 clear;
> +		u16 set;
> +
> +		rrcb = pcie_get_root_rcb(dev);
> +
> +		clear = ~hpp->pci_exp_lnkctl_and;
> +		set = hpp->pci_exp_lnkctl_or;
> +		if (!rrcb)
> +			set &= ~PCI_EXP_LNKCTL_RCB;
> +
>  		pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
> -			~hpp->pci_exp_lnkctl_and, hpp->pci_exp_lnkctl_or);
> +						  clear, set);
> +	}
>  
>  	/* Find Advanced Error Reporting Enhanced Capability */
>  	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
> -- 
> 2.10.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
