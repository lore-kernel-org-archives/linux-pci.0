Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60363 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753166AbcCUMkp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 21 Mar 2016 08:40:45 -0400
Date: Mon, 21 Mar 2016 07:40:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tero Roponen <tero.roponen@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Restore inclusion of pci/hotplug Kconfig
Message-ID: <20160321124042.GB28507@localhost>
References: <alpine.LFD.2.20.1603210924030.16682@terrop.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LFD.2.20.1603210924030.16682@terrop.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 21, 2016 at 09:26:41AM +0200, Tero Roponen wrote:
> Commit e7e127e3c767 ("PCI: Include pci/hotplug Kconfig directly
> from pci/Kconfig") added one line to pci/Kconfig. However, for
> some mysterious reason it isn't there now, even though there
> are no traces of removing it in the git log.
> 
> I detected this issue when 'make oldconfig' removed all the
> options that depended on HOTPLUG_PCI.
> 
> Signed-off-by: Tero Roponen <tero.roponen@gmail.com>

Thanks for catching this, Tero!  I botched the pci/hv merge and
dropped this line.  I applied this to for-linus and will ask Linus to
pull it before v4.6-rc1.

> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index a1f37db..209292e 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -128,4 +128,5 @@ config PCI_HYPERV
>            The PCI device frontend driver allows the kernel to import arbitrary
>            PCI devices from a PCI backend to support PCI driver domains.
>  
> +source "drivers/pci/hotplug/Kconfig"
>  source "drivers/pci/host/Kconfig"
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
