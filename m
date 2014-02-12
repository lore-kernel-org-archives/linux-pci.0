Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:44706 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbaBLBG5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Feb 2014 20:06:57 -0500
Received: by mail-ig0-f174.google.com with SMTP id hl1so10122539igb.1
        for <linux-pci@vger.kernel.org>; Tue, 11 Feb 2014 17:06:57 -0800 (PST)
Date: Tue, 11 Feb 2014 18:06:50 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
	Liviu.Dudau@arm.com, linux-pci@vger.kernel.org, mohit.kumar@st.com
Subject: Re: [PATCH 1/3] ARM: bios32: use pci_enable_resource to enable PCI
 resources
Message-ID: <20140212010650.GI21057@google.com>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com>
 <1391532784-1953-2-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1391532784-1953-2-git-send-email-will.deacon@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 04, 2014 at 04:53:02PM +0000, Will Deacon wrote:
> This patch moves bios32 over to using the generic code for enabling PCI
> resources. All that's left to take care of is the case of PCI bridges,
> which need to be enabled for both IO and MEMORY, regardless of the
> resource types.
> 
> A side-effect of this change is that we no longer explicitly enable
> devices when running in PCI_PROBE_ONLY mode. This stays closer to the
> meaning of the option and prevents us from trying to enable devices
> without any assigned resources (the core code refuses to enable
> resources without parents).

Heh, I've been looking at this, too :)  I have a similar patch for ARM and
other architectures with their own versions of pcibios_enable_device().

Several of them (arm m68k tile tegra unicore32) have this special code that
enables IO and MEMORY for bridges unconditionally.  But from a PCI
perspective, I don't know why we should do this unconditionally.  If a
bridge doesn't have an enabled MEM window or MEM BAR, I don't think we
should have to enable PCI_COMMAND_MEMORY for it.

The architectures that do this only check for valid MEM BARs, i.e., they
only look at resources 0-5, and they don't look at the window resources.

The architectures that don't enable IO and MEMORY for bridges
unconditionally check *all* the resources up to PCI_NUM_RESOURCES, which
includes the BARs, bridge windows, and any IOV resources.

The generic pci_enable_resources() does check all the resources, so I
*think* it should be safe for all architectures to use that and just drop
the check for bridges.  What do you think?

Bjorn

> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/kernel/bios32.c | 35 ++++++++++-------------------------
>  1 file changed, 10 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index 317da88ae65b..9f3c76638689 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -608,40 +608,25 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>   */
>  int pcibios_enable_device(struct pci_dev *dev, int mask)
>  {
> -	u16 cmd, old_cmd;
> -	int idx;
> -	struct resource *r;
> +	int err;
> +	u16 cmd;
>  
> -	pci_read_config_word(dev, PCI_COMMAND, &cmd);
> -	old_cmd = cmd;
> -	for (idx = 0; idx < 6; idx++) {
> -		/* Only set up the requested stuff */
> -		if (!(mask & (1 << idx)))
> -			continue;
> +	if (pci_has_flag(PCI_PROBE_ONLY))
> +		return 0;
>  
> -		r = dev->resource + idx;
> -		if (!r->start && r->end) {
> -			printk(KERN_ERR "PCI: Device %s not available because"
> -			       " of resource collisions\n", pci_name(dev));
> -			return -EINVAL;
> -		}
> -		if (r->flags & IORESOURCE_IO)
> -			cmd |= PCI_COMMAND_IO;
> -		if (r->flags & IORESOURCE_MEM)
> -			cmd |= PCI_COMMAND_MEMORY;
> -	}
> +	err = pci_enable_resources(dev, mask);
> +	if (err)
> +		return err;
>  
>  	/*
>  	 * Bridges (eg, cardbus bridges) need to be fully enabled
>  	 */
> -	if ((dev->class >> 16) == PCI_BASE_CLASS_BRIDGE)
> +	if ((dev->class >> 16) == PCI_BASE_CLASS_BRIDGE) {
> +		pci_read_config_word(dev, PCI_COMMAND, &cmd);
>  		cmd |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY;
> -
> -	if (cmd != old_cmd) {
> -		printk("PCI: enabling device %s (%04x -> %04x)\n",
> -		       pci_name(dev), old_cmd, cmd);
>  		pci_write_config_word(dev, PCI_COMMAND, cmd);
>  	}
> +
>  	return 0;
>  }
>  
> -- 
> 1.8.2.2
> 
