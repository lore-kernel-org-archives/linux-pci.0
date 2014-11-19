Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:58197 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932543AbaKSWOr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Nov 2014 17:14:47 -0500
Received: by mail-ig0-f180.google.com with SMTP id h15so1779772igd.13
        for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2014 14:14:47 -0800 (PST)
Date: Wed, 19 Nov 2014 15:14:44 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-pci@vger.kernel.org, Kevin Hilman <khilman@linaro.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Myron Stowe <myron.stowe@redhat.com>
Subject: Re: [PATCH] PCI: fixup __pci_read_base() after refactoring
Message-ID: <20141119221444.GE23467@google.com>
References: <20141118105542.457d7863@free-electrons.com>
 <1416310271-4423-1-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1416310271-4423-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 18, 2014 at 12:31:11PM +0100, Thomas Petazzoni wrote:
> In commit 7ea945f0bb49 ("PCI: Shrink decoding-disabled window while
> sizing BARs"), Myron Stowe refactored the code of __pci_read_base() in
> order to reduce the amount of time spent with decoding disabled.
> 
> However, contrary to what was said in the commit log, the commit does
> introduce some functional change: the pci_size() function that used to
> be called *before* the BAR size check is done is now called *after*
> the BAR size check is done.
> 
> This causes some failures on certain platforms (namely ARM Marvell EBU
> platforms, equipped for example with a PCIe SATA card, or a PCIe USB3
> XHCI controller):
> 
> pci 0000:03:00.0: reg 0x10: can't handle BAR larger than 4GB (size 0xfffffffffff00000)
> 
> This problem didn't exist before this commit, due to pci_size() being
> called before doing the PCI BAR size check. Therefore, this commit
> fixes the problem by restoring the initial order of the operation, by
> calling pci_size() before doing the PCI BAR size check.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Fixes: 7ea945f0bb49 ("PCI: Shrink decoding-disabled window while sizing BARs")
> ---
> Note: this fix has been tested to work correctly for me, and the PCI
> messages I get are now identical to the ones I was getting with
> 3.18-rc5. However, please review my patch carefully, as I must admit I
> do not fully understand all the implications of the change as well as
> the code in __pci_read_base().
> 
> Applies on top of pci/next
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

I folded essentially this patch into "PCI: Shrink decoding-disabled window
while sizing BARs" and re-merged that into my "next" branch.  Thanks!

Bjorn

> ---
>  drivers/pci/probe.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index db16678..6168ca1 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -246,6 +246,14 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
>  	if (!sz64)
>  		goto fail;
>  
> +	sz64 = pci_size(l64, sz64, mask64);
> +
> +	if (!sz64) {
> +		dev_info(&dev->dev, "%sreg 0x%x: invalid BAR (can't size)\n",
> +			 FW_BUG, pos);
> +		goto fail;
> +	}
> +
>  	if (res->flags & IORESOURCE_MEM_64) {
>  		if ((sizeof(dma_addr_t) < 8 || sizeof(resource_size_t) < 8) &&
>  		    sz64 > 0x100000000ULL) {
> @@ -268,14 +276,6 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
>  		}
>  	}
>  
> -	sz64 = pci_size(l64, sz64, mask64);
> -
> -	if (!sz64) {
> -		dev_info(&dev->dev, "%sreg 0x%x: invalid BAR (can't size)\n",
> -			 FW_BUG, pos);
> -		goto fail;
> -	}
> -
>  	region.start = l64;
>  	region.end = l64 + sz64;
>  
> -- 
> 2.1.0
> 
