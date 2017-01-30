Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932446AbdA3QX6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Jan 2017 11:23:58 -0500
Date: Mon, 30 Jan 2017 10:23:37 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Apply _HPX settings only to relevant devices
Message-ID: <20170130162337.GS20550@bhelgaas-glaptop.roam.corp.google.com>
References: <20170112203204.17379.9783.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170112203204.17379.9783.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 12, 2017 at 02:32:04PM -0600, Bjorn Helgaas wrote:
> Previously we didn't check the type of device before trying to apply Type 1
> (PCI-X) or Type 2 (PCIe) Setting Records from _HPX.
> 
> We don't support PCI-X Setting Records, so this was harmless, but the
> warning was useless.
> 
> We do support PCIe Setting Records, and we didn't check whether a device
> was PCIe before applying settings.  I don't think anything bad happened on
> non-PCIe devices because pcie_capability_clear_and_set_word(),
> pcie_cap_has_lnkctl(), etc., would fail before doing any harm.  But it's
> ugly to depend on those internals.
> 
> Check the device type before attempting to apply Type 1 and Type 2 Setting
> Records (Type 0 records are applicable to PCI, PCI-X, and PCIe devices).
> 
> A side benefit is that this prevents useless "not supported" warnings when
> a BIOS supplies a Type 1 (PCI-X) Setting Record and we try to apply it to
> every single device:
> 
>   pci 0000:00:00.0: PCI-X settings not supported
> 
> After this patch, we'll get the warning only when a BIOS supplies a Type 1
> record and we have a PCI-X device to which it should be applied.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=187731
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Applied to pci/enumeration for v4.11.

> ---
>  drivers/pci/probe.c |   15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index e164b5c9f0f0..aca5b2466adb 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1554,8 +1554,16 @@ static void program_hpp_type0(struct pci_dev *dev, struct hpp_type0 *hpp)
>  
>  static void program_hpp_type1(struct pci_dev *dev, struct hpp_type1 *hpp)
>  {
> -	if (hpp)
> -		dev_warn(&dev->dev, "PCI-X settings not supported\n");
> +	int pos;
> +
> +	if (!hpp)
> +		return;
> +
> +	pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
> +	if (!pos)
> +		return;
> +
> +	dev_warn(&dev->dev, "PCI-X settings not supported\n");
>  }
>  
>  static bool pcie_root_rcb_set(struct pci_dev *dev)
> @@ -1581,6 +1589,9 @@ static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp)
>  	if (!hpp)
>  		return;
>  
> +	if (!pci_is_pcie(dev))
> +		return;
> +
>  	if (hpp->revision > 1) {
>  		dev_warn(&dev->dev, "PCIe settings rev %d not supported\n",
>  			 hpp->revision);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
