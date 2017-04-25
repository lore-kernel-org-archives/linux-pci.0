Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1950284AbdDYUmh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Apr 2017 16:42:37 -0400
Date: Tue, 25 Apr 2017 15:42:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stefan Assmann <sassmann@kpanic.de>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, rjw@rjwysocki.net,
        lenb@kernel.org, Solomon Peachy <pizza@shaftnet.org>
Subject: Re: [PATCH] PCI: add boot interrupt reroute DMI-quirk for ASUS M2N-LR
Message-ID: <20170425204232.GD29024@bhelgaas-glaptop.roam.corp.google.com>
References: <20170419072245.20943-1-sassmann@kpanic.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170419072245.20943-1-sassmann@kpanic.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Solomon]

On Wed, Apr 19, 2017 at 09:22:45AM +0200, Stefan Assmann wrote:
> The ASUS M2N-LR should not trigger boot interrupt quirks although it
> carries an Intel 6702PXH. On this board the boot interrupt quirks
> cause incorrect IRQ assignments and should be disabled.
> 
> Fixes:
> https://bugzilla.kernel.org/show_bug.cgi?id=43074
> 
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>

Applied with Solomon's tested-by to pci/irq for v4.12, thanks!

> ---
>  drivers/pci/quirks.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 6736836..f23ad20 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1685,6 +1685,28 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x260a, quirk_intel_pcie_pm);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x260b, quirk_intel_pcie_pm);
>  
>  #ifdef CONFIG_X86_IO_APIC
> +static int dmi_disable_ioapicreroute(const struct dmi_system_id *d)
> +{
> +	noioapicreroute = 1;
> +	pr_info("%s detected: disable boot interrupt reroute\n", d->ident);
> +
> +	return 0;
> +}
> +static struct dmi_system_id boot_interrupt_dmi_table[] = {
> +	/*
> +	 * Systems to exclude from boot interrupt reroute quirks
> +	 */
> +	{
> +		.callback = dmi_disable_ioapicreroute,
> +		.ident = "ASUSTek Computer INC. M2N-LR",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTek Computer INC."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "M2N-LR"),
> +		},
> +	},
> +	{}
> +};
> +
>  /*
>   * Boot interrupts on some chipsets cannot be turned off. For these chipsets,
>   * remap the original interrupt in the linux kernel to the boot interrupt, so
> @@ -1693,6 +1715,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x260b, quirk_intel_pcie_pm);
>   */
>  static void quirk_reroute_to_boot_interrupts_intel(struct pci_dev *dev)
>  {
> +	dmi_check_system(boot_interrupt_dmi_table);
>  	if (noioapicquirk || noioapicreroute)
>  		return;
>  
> -- 
> 2.9.3
> 
