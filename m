Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751968AbdA1Utj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Jan 2017 15:49:39 -0500
Date: Sat, 28 Jan 2017 14:49:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add Union Point to Intel ACS quirks
Message-ID: <20170128204935.GC20550@bhelgaas-glaptop.roam.corp.google.com>
References: <20170119155103.17200.51138.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170119155103.17200.51138.stgit@gimli.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 19, 2017 at 08:51:30AM -0700, Alex Williamson wrote:
> Intel 200-series chipsets have the same errata as 100-series, the ACS
> capability doesn't follow the PCIe spec, the capability and control
> registers are dwords rather than words.  Add PCIe root port device IDs
> to existing quirk.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Applied to pci/virtualization for v4.11, thanks, Alex!

> ---
>  drivers/pci/quirks.c |   28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 1800bef..a0b3cd5 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4150,15 +4150,35 @@ static int pci_quirk_intel_pch_acs(struct pci_dev *dev, u16 acs_flags)
>   *
>   * N.B. This doesn't fix what lspci shows.
>   *
> + * The 100 series chipset specification update includes this as errata #23[3].
> + *
> + * The 200 series chipset (Union Point) has the same bug according to the
> + * specification update (Intel 200 Series Chipset Family Platform Controller
> + * Hub, Specification Update, January 2017, Revision 001, Document# 335194-001,
> + * Errata 22)[4].  Per the datasheet[5], root port PCI Device IDs for this
> + * chipset include:
> + *
> + * 0xa290-0xa29f PCI Express Root port #{0-16}
> + * 0xa2e7-0xa2ee PCI Express Root port #{17-24}
> + *
>   * [1] http://www.intel.com/content/www/us/en/chipsets/100-series-chipset-datasheet-vol-2.html
>   * [2] http://www.intel.com/content/www/us/en/chipsets/100-series-chipset-datasheet-vol-1.html
> + * [3] http://www.intel.com/content/www/us/en/chipsets/100-series-chipset-spec-update.html
> + * [4] http://www.intel.com/content/www/us/en/chipsets/200-series-chipset-pch-spec-update.html
> + * [5] http://www.intel.com/content/www/us/en/chipsets/200-series-chipset-pch-datasheet-vol-1.html
>   */
>  static bool pci_quirk_intel_spt_pch_acs_match(struct pci_dev *dev)
>  {
> -	return pci_is_pcie(dev) &&
> -		pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
> -		((dev->device & ~0xf) == 0xa110 ||
> -		 (dev->device >= 0xa167 && dev->device <= 0xa16a));
> +	if (!pci_is_pcie(dev) || pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
> +		return false;
> +
> +	switch (dev->device) {
> +	case 0xa110 ... 0xa11f: case 0xa167 ... 0xa16a: /* Sunrise Point */
> +	case 0xa290 ... 0xa29f: case 0xa2e7 ... 0xa2ee: /* Union Point */
> +		return true;
> +	}
> +
> +	return false;
>  }
>  
>  #define INTEL_SPT_ACS_CTRL (PCI_ACS_CAP + 4)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
