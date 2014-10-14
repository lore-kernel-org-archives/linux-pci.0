Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:53948 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753241AbaJNSOc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Oct 2014 14:14:32 -0400
Received: by mail-ig0-f178.google.com with SMTP id h3so15675821igd.17
        for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2014 11:14:32 -0700 (PDT)
Date: Tue, 14 Oct 2014 12:14:29 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: matt@masarand.com
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 03/18] Delayed arm setup of PCI IRQs to bus scan time
Message-ID: <20141014181429.GC10125@google.com>
References: <1412222866-21068-1-git-send-email-matt@masarand.com>
 <1412222866-21068-4-git-send-email-matt@masarand.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412222866-21068-4-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 02, 2014 at 05:07:31AM +0100, matt@masarand.com wrote:
> From: Matthew Minter <matt@masarand.com>
> 
> Currently PCI device IRQs under arm are initialised during the
> pci_common_init_dev code path, this results in an extra sweep of the
> PCI bus as well as causing PCI devices hot-plugged after boot to not
> receive an IRQ.
> 
> This patch set defers this assignment untill the device enable phase
> which prevents both these issues.
> 
> Signed-off-by: Matthew Minter <matt@masarand.com>
> 
> ---
>  arch/arm/kernel/bios32.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index 17a26c1..4dcf3f7 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -389,7 +389,7 @@ void pcibios_remove_bus(struct pci_bus *bus)
>   * PCI standard swizzle is implemented on plug-in cards and Cardbus based
>   * PCI extenders, so it can not be ignored.
>   */
> -static u8 pcibios_swizzle(struct pci_dev *dev, u8 *pin)
> +u8 pcibios_swizzle(struct pci_dev *dev, u8 *pin)

I don't think there's anything in this patch that requires
pcibios_swizzle() or pcibios_map_irq() to be non-static.

>  {
>  	struct pci_sys_data *sys = dev->sysdata;
>  	int slot, oldpin = *pin;
> @@ -409,7 +409,7 @@ static u8 pcibios_swizzle(struct pci_dev *dev, u8 *pin)
>  /*
>   * Map a slot/pin to an IRQ.
>   */
> -static int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> +int pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
>  {
>  	struct pci_sys_data *sys = dev->sysdata;
>  	int irq = -1;
> @@ -424,6 +424,13 @@ static int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>  	return irq;
>  }
>  
> +int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
> +{
> +	bridge->swizzle_irq = pcibios_swizzle;
> +	bridge->map_irq = pcibios_map_irq;
> +	return 0;
> +}
> +
>  static int pcibios_init_resources(int busnr, struct pci_sys_data *sys)
>  {
>  	int ret;
> @@ -523,8 +530,6 @@ void pci_common_init_dev(struct device *parent, struct hw_pci *hw)
>  	if (hw->postinit)
>  		hw->postinit();
>  
> -	pci_fixup_irqs(pcibios_swizzle, pcibios_map_irq);
> -
>  	list_for_each_entry(sys, &head, node) {
>  		struct pci_bus *bus = sys->bus;
>  
> -- 
> 2.1.0
> 
