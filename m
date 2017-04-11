Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752644AbdDKBYu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Apr 2017 21:24:50 -0400
Date: Mon, 10 Apr 2017 20:24:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Grant Grundler <grundler@chromium.org>,
        Greg Hackmann <ghackmann@google.com>,
        Michael Davidson <md@google.com>
Subject: Re: [PATCH] PCI: Add cast when assigning PCI_ROM_ADDRESS_MASK to a
 32-bit variable
Message-ID: <20170411012445.GA8025@bhelgaas-glaptop.roam.corp.google.com>
References: <20170410222457.113155-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170410222457.113155-1-mka@chromium.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 10, 2017 at 03:24:57PM -0700, Matthias Kaehlcke wrote:
> This fixes a clang warning about "implicit conversion from 'unsigned
> long' to 'u32'"
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/pci/probe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index dfc9a2794141..148e80d5caf1 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -180,7 +180,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
>  	u16 orig_cmd;
>  	struct pci_bus_region region, inverted_region;
>  
> -	mask = type ? PCI_ROM_ADDRESS_MASK : ~0;
> +	mask = type ? (u32)PCI_ROM_ADDRESS_MASK : ~0;

Can we put the cast in the PCI_ROM_ADDRESS_MASK #define so we don't have to
repeat it in all the uses?

>  	/* No printks while decoding is disabled! */
>  	if (!dev->mmio_always_on) {
> -- 
> 2.12.2.715.g7642488e1d-goog
> 
