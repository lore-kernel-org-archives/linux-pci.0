Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:34493 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755797Ab3KEXd4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Nov 2013 18:33:56 -0500
Received: by mail-ie0-f169.google.com with SMTP id ar20so16662909iec.0
        for <linux-pci@vger.kernel.org>; Tue, 05 Nov 2013 15:33:55 -0800 (PST)
Date: Tue, 5 Nov 2013 16:33:53 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Marta Rybczynska <rybczynska@gmail.com>
Cc: linux-pci@vger.kernel.org, Jiri Kosina <trivial@kernel.org>
Subject: Re: [PATCH] drivers/pci/pci.c: fix comment typo
Message-ID: <20131105233353.GB3359@google.com>
References: <20131105223135.GA10523@desktop.fbx.proxad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131105223135.GA10523@desktop.fbx.proxad.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 05, 2013 at 11:31:35PM +0100, Marta Rybczynska wrote:
> Signed-off-by: Marta Rybczynska <rybczynska@gmail.com>
> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index bdd64b1..fb5090d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3339,7 +3339,7 @@ void pci_reset_bridge_secondary_bus(struct pci_dev *dev)
>  	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
>  	/*
>  	 * PCI spec v3.0 7.6.4.2 requires minimum Trst of 1ms.  Double
> -	 * this to 2ms to ensure that we meet the minium requirement.
> +	 * this to 2ms to ensure that we meet the minimum requirement.
>  	 */
>  	msleep(2);
>  

Thanks, I folded this into a large whitespace and spelling correction
patch I'm holding for the v3.13 merge window.

Bjorn
