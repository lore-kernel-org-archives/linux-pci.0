Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33428 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754010AbcFTSf3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 20 Jun 2016 14:35:29 -0400
Date: Mon, 20 Jun 2016 13:34:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Miller <davem@davemloft.net>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: Fix unaligned accesses in VC code.
Message-ID: <20160620183428.GA31564@localhost>
References: <20160618.235225.1591502152749272620.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160618.235225.1591502152749272620.davem@davemloft.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 18, 2016 at 11:52:25PM -0700, David Miller wrote:
> 
> The save/restore buffers for VC state is first composed of a 2-byte
> control register, then a bunch of 4-byte words.
> 
> This causes unaligned accesses which trap on platform such as sparc.
> 
> This is easy to fix by simply moving the buffer pointer forward by 4
> bytes instead of 2 after dealing with the control register.  The
> length adjustment needs to be changed likewise as well.
> 
> Reported-by: Meelis Roos <mroos@linux.ee>
> Reported-by: Anatoly Pugachev <matorola@gmail.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>

Applied to for-linus for v4.7, thanks.

I'm pretty sure this problem was introduced by 5f8fc43217a0 ("PCI:
Include pci/pcie/Kconfig directly from pci/Kconfig"), which appeared
in v4.6.  This effectively made PCIe services, including VC, available
on sparc. 

I added a stable tag for v4.6.

> diff --git a/drivers/pci/vc.c b/drivers/pci/vc.c
> index dfbab61..1fa3a32 100644
> --- a/drivers/pci/vc.c
> +++ b/drivers/pci/vc.c
> @@ -221,9 +221,9 @@ static int pci_vc_do_save_buffer(struct pci_dev *dev, int pos,
>  		else
>  			pci_write_config_word(dev, pos + PCI_VC_PORT_CTRL,
>  					      *(u16 *)buf);
> -		buf += 2;
> +		buf += 4;
>  	}
> -	len += 2;
> +	len += 4;
>  
>  	/*
>  	 * If we have any Low Priority VCs and a VC Arbitration Table Offset
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
