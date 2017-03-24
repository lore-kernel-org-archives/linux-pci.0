Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936690AbdCXPr7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Mar 2017 11:47:59 -0400
Date: Fri, 24 Mar 2017 10:47:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <deathsimple@vodafone.de>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] x86/PCI: Enable a 64bit BAR on AMD Family 15h
 (Models 30h-3fh) Processors
Message-ID: <20170324154744.GE25380@bhelgaas-glaptop.roam.corp.google.com>
References: <1489408896-25039-1-git-send-email-deathsimple@vodafone.de>
 <1489408896-25039-4-git-send-email-deathsimple@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1489408896-25039-4-git-send-email-deathsimple@vodafone.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 13, 2017 at 01:41:35PM +0100, Christian König wrote:
> From: Christian König <christian.koenig@amd.com>
> 
> Most BIOS don't enable this because of compatibility reasons.

Can you give any more details here?  Without more hints, it's hard to
know whether any of the compatibility reasons might apply to Linux as
well.

> Manually enable a 64bit BAR of 64GB size so that we have
> enough room for PCI devices.

>From the context, I'm guessing this is enabling a new 64GB window
through the PCI host bridge?  That might be documented as a "BAR", but
it's not anything the Linux PCI core would recognize as a BAR.

I think the specs would envision this being done via an ACPI _SRS
method on the PNP0A03 host bridge device.  That would be a more
generic path that would work on any host bridge.  Did you explore that
possibility?  I would prefer to avoid adding device-specific code if
that's possible.

> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  arch/x86/pci/fixup.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index 6d52b94..bff5242 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -571,3 +571,56 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2fc0, pci_invalid_bar);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6f60, pci_invalid_bar);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fa0, pci_invalid_bar);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fc0, pci_invalid_bar);
> +
> +static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
> +{
> +	const uint64_t size = 64ULL * 1024 * 1024 * 1024;
> +	uint32_t base, limit, high;
> +	struct resource *res;
> +	unsigned i;
> +	int r;
> +
> +	for (i = 0; i < 8; ++i) {
> +
> +		pci_read_config_dword(dev, 0x80 + i * 0x8, &base);
> +		pci_read_config_dword(dev, 0x180 + i * 0x4, &high);
> +
> +		/* Is this slot free? */
> +		if ((base & 0x3) == 0x0)
> +			break;
> +
> +		base >>= 8;
> +		base |= high << 24;
> +
> +		/* Abort if a slot already configures a 64bit BAR. */
> +		if (base > 0x10000)
> +			return;
> +
> +	}
> +
> +	if (i == 8)
> +		return;
> +
> +	res = kzalloc(sizeof(*res), GFP_KERNEL);
> +	res->flags = IORESOURCE_MEM | IORESOURCE_PREFETCH | IORESOURCE_MEM_64 |
> +		IORESOURCE_WINDOW;
> +	res->name = dev->bus->name;
> +	r = allocate_resource(&iomem_resource, res, size, 0x100000000,
> +			      0xfd00000000, size, NULL, NULL);
> +	if (r) {
> +		kfree(res);
> +		return;
> +	}
> +
> +	base = ((res->start >> 8) & 0xffffff00) | 0x3;
> +	limit = ((res->end + 1) >> 8) & 0xffffff00;
> +	high = ((res->start >> 40) & 0xff) |
> +		((((res->end + 1) >> 40) & 0xff) << 16);
> +
> +	pci_write_config_dword(dev, 0x180 + i * 0x4, high);
> +	pci_write_config_dword(dev, 0x84 + i * 0x8, limit);
> +	pci_write_config_dword(dev, 0x80 + i * 0x8, base);
> +
> +	pci_bus_add_resource(dev->bus, res, 0);

We would need some sort of printk here to explain how this new window
magically appeared.

> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x141b, pci_amd_enable_64bit_bar);
> -- 
> 2.7.4
> 
