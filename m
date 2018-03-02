Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932131AbeCBVs7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Mar 2018 16:48:59 -0500
Date: Fri, 2 Mar 2018 15:48:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: KarimAllah Ahmed <karahmed@amazon.de>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 2/2] PCI/IOV: Use the cached VF BARs size instead of
 re-reading them
Message-ID: <20180302214857.GD202062@bhelgaas-glaptop.roam.corp.google.com>
References: <1519939897-14596-1-git-send-email-karahmed@amazon.de>
 <1519939897-14596-2-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1519939897-14596-2-git-send-email-karahmed@amazon.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 01, 2018 at 10:31:37PM +0100, KarimAllah Ahmed wrote:
> Use the cached VF BARs size instead of re-reading them from the hardware.
> That avoids doing unnecessarily bus transactions which is specially
> noticable when you have a PF with a large number of VFs.

Thanks a lot for breaking this out!  It seems trivial, but it did make it
much easier for me to think about this one.

> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> ---
>  drivers/pci/probe.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index a96837e..aeaa10a 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -180,6 +180,7 @@ static inline unsigned long decode_bar(struct pci_dev *dev, u32 bar)
>  int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
>  		    struct resource *res, unsigned int pos)
>  {
> +	int bar = res - dev->resource;
>  	u32 l = 0, sz = 0, mask;
>  	u64 l64, sz64, mask64;
>  	u16 orig_cmd;
> @@ -199,9 +200,13 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
>  	res->name = pci_name(dev);
>  
>  	pci_read_config_dword(dev, pos, &l);
> -	pci_write_config_dword(dev, pos, l | mask);
> -	pci_read_config_dword(dev, pos, &sz);
> -	pci_write_config_dword(dev, pos, l);
> +	if (dev->is_virtfn) {
> +		sz = dev->physfn->sriov->barsz[bar] & 0xffffffff;
> +	} else {
> +		pci_write_config_dword(dev, pos, l | mask);
> +		pci_read_config_dword(dev, pos, &sz);
> +		pci_write_config_dword(dev, pos, l);
> +	}

I don't quite understand this.  This is reading the regular BARs (config
offsets 0x10, 0x14, ..., 0x24).  Per sec 9.3.4.1.11, these are all RO Zero
for VFs.  That should make them look like they're all unimplemented.

But this patch makes us use the size we discovered from the PF's VF BARn
registers in its SR-IOV capability.  Won't that cause us to fill in the
VF's dev->resource[n], when we didn't do it before?

>  	/*
>  	 * All bits set in sz means the device isn't working properly.
> @@ -241,9 +246,14 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
>  
>  	if (res->flags & IORESOURCE_MEM_64) {
>  		pci_read_config_dword(dev, pos + 4, &l);
> -		pci_write_config_dword(dev, pos + 4, ~0);
> -		pci_read_config_dword(dev, pos + 4, &sz);
> -		pci_write_config_dword(dev, pos + 4, l);
> +
> +		if (dev->is_virtfn) {
> +			sz = (dev->physfn->sriov->barsz[bar] >> 32) & 0xffffffff;
> +		} else {
> +			pci_write_config_dword(dev, pos + 4, ~0);
> +			pci_read_config_dword(dev, pos + 4, &sz);
> +			pci_write_config_dword(dev, pos + 4, l);
> +		}
>  
>  		l64 |= ((u64)l << 32);
>  		sz64 |= ((u64)sz << 32);
> @@ -332,6 +342,8 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
>  	for (pos = 0; pos < howmany; pos++) {
>  		struct resource *res = &dev->resource[pos];
>  		reg = PCI_BASE_ADDRESS_0 + (pos << 2);
> +		if (dev->is_virtfn && dev->physfn->sriov->barsz[pos] == 0)
> +			continue;

Since we know the VF BARs are all zero (the ones in the VF config space,
not the ones in the PF SR-IOV capability), including the VF ROM BAR, it
would make sense to me to totally skip this whole function, e.g.,

  if (dev->non_compliant_bars)
    return;

  if (dev->is_virtfn)
    return;

>  		pos += __pci_read_base(dev, pci_bar_unknown, res, reg);
>  	}
>  
> -- 
> 2.7.4
> 
