Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S969447AbeCST6B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Mar 2018 15:58:01 -0400
Date: Mon, 19 Mar 2018 14:57:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: KarimAllah Ahmed <karahmed@amazon.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/IOV: Skip initializing the base addresses from the
 VF config space
Message-ID: <20180319195758.GK77194@bhelgaas-glaptop.roam.corp.google.com>
References: <1520051590-11750-1-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1520051590-11750-1-git-send-email-karahmed@amazon.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Mar 03, 2018 at 05:33:10AM +0100, KarimAllah Ahmed wrote:
> Per PCIe r4.0, sec 9.3.4.1.11, the BARs registers from the VF config space
> are all RO Zero for PCI VFs. So just skip reading them for VFs.
> 
> This is an optimization when enabling SR-IOV on a device with many VFs.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>

Applied to pci/virtualization for v4.17, thanks!

> ---
>  drivers/pci/probe.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index a96837e..7204d46 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -329,6 +329,10 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
>  	if (dev->non_compliant_bars)
>  		return;
>  
> +	/* Per PCIe r4.0, sec 9.3.4.1.11, the VF BARs are all RO Zero */
> +	if (dev->is_virtfn)
> +		return;
> +
>  	for (pos = 0; pos < howmany; pos++) {
>  		struct resource *res = &dev->resource[pos];
>  		reg = PCI_BASE_ADDRESS_0 + (pos << 2);
> -- 
> 2.7.4
> 
