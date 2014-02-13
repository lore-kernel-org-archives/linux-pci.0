Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:21622 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257AbaBMMW2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2014 07:22:28 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0X00ARSP1EWI30@mailout3.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 13 Feb 2014 21:22:26 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Will Deacon' <will.deacon@arm.com>,
	linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de, linux-pci@vger.kernel.org, bhelgaas@google.com,
	jgunthorpe@obsidianresearch.com, 'Jingoo Han' <jg1.han@samsung.com>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com>
 <1392236171-10512-3-git-send-email-will.deacon@arm.com>
In-reply-to: <1392236171-10512-3-git-send-email-will.deacon@arm.com>
Subject: Re: [PATCH v2 2/3] ARM: bios32: use pci_enable_resource to enable PCI
 resources
Date: Thu, 13 Feb 2014 21:22:26 +0900
Message-id: <000001cf28b6$41846bb0$c48d4310$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, February 13, 2014 5:16 AM, Will Deacon wrote:
> 
> This patch moves bios32 over to using the generic code for enabling PCI
> resources. Since the core code takes care of bridge resources too, we
> can also drop the explicit IO and MEMORY enabling for them in the arch
> code.
> 
> A side-effect of this change is that we no longer explicitly enable
> devices when running in PCI_PROBE_ONLY mode. This stays closer to the
> meaning of the option and prevents us from trying to enable devices
> without any assigned resources (the core code refuses to enable
> resources without parents).
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

I tested this patch with NIC on Exynos platform.
It works properly.

Tested-by: Jingoo Han <jg1.han@samsung.com> 

[    0.406431] PCI: bus1: Fast back to back transfers disabled
[    0.411912] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    0.418608] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 01
[    0.425351] pci 0000:00:00.0: BAR 8: assigned [mem 0x40100000-0x401fffff]
[    0.432144] pci 0000:00:00.0: BAR 9: assigned [mem 0x40200000-0x402fffff pref]
[    0.439426] pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
[    0.445599] pci 0000:01:00.0: BAR 1: assigned [mem 0x40100000-0x4017ffff]
[    0.452488] pci 0000:01:00.0: BAR 6: assigned [mem 0x40200000-0x4023ffff pref]
[    0.459745] pci 0000:01:00.0: BAR 0: assigned [mem 0x40180000-0x4019ffff]
[    0.466635] pci 0000:01:00.0: BAR 3: assigned [mem 0x401a0000-0x401a3fff]
[    0.473499] pci 0000:01:00.0: BAR 2: assigned [io  0x1000-0x101f]
[    0.479656] pci 0000:00:00.0: PCI bridge to [bus 01]

Best regards,
Jingoo Han

> ---
>  arch/arm/kernel/bios32.c | 37 +++----------------------------------
>  1 file changed, 3 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index 317da88ae65b..91f48804e3bb 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -608,41 +608,10 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>   */
>  int pcibios_enable_device(struct pci_dev *dev, int mask)
>  {
> -	u16 cmd, old_cmd;
> -	int idx;
> -	struct resource *r;
> -
> -	pci_read_config_word(dev, PCI_COMMAND, &cmd);
> -	old_cmd = cmd;
> -	for (idx = 0; idx < 6; idx++) {
> -		/* Only set up the requested stuff */
> -		if (!(mask & (1 << idx)))
> -			continue;
> -
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
> +	if (pci_has_flag(PCI_PROBE_ONLY))
> +		return 0;
> 
> -	/*
> -	 * Bridges (eg, cardbus bridges) need to be fully enabled
> -	 */
> -	if ((dev->class >> 16) == PCI_BASE_CLASS_BRIDGE)
> -		cmd |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY;
> -
> -	if (cmd != old_cmd) {
> -		printk("PCI: enabling device %s (%04x -> %04x)\n",
> -		       pci_name(dev), old_cmd, cmd);
> -		pci_write_config_word(dev, PCI_COMMAND, cmd);
> -	}
> -	return 0;
> +	return pci_enable_resources(dev, mask);
>  }
> 
>  int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
> --
> 1.8.2.2

