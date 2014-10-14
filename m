Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:42994 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755498AbaJNSxt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Oct 2014 14:53:49 -0400
Received: by mail-ig0-f170.google.com with SMTP id hn15so18413444igb.5
        for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2014 11:53:48 -0700 (PDT)
Date: Tue, 14 Oct 2014 12:53:44 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: matt@masarand.com
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 16/18] Disabled bus scan time PCI IRQ assignment on ia64
Message-ID: <20141014185344.GL10125@google.com>
References: <1412222866-21068-1-git-send-email-matt@masarand.com>
 <1412222866-21068-17-git-send-email-matt@masarand.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412222866-21068-17-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 02, 2014 at 05:07:44AM +0100, matt@masarand.com wrote:
> From: Matthew Minter <matt@masarand.com>
> 
> Most of the architectures are switched to allocating IRQs at device_enable
> time instead of boot time, however ia64 does not provide an easy way of
> making that transition so the new code is disabled here on ia64.
> 
> Signed-off-by: Matthew Minter <matt@masarand.com>
> 
> ---
>  arch/ia64/pci/pci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
> index 291a582..398d5d4 100644
> --- a/arch/ia64/pci/pci.c
> +++ b/arch/ia64/pci/pci.c
> @@ -483,6 +483,9 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
>  {
>  	struct pci_controller *controller = bridge->bus->sysdata;
>  
> +	bridge->swizzle_irq = NULL;
> +	bridge->map_irq = NULL;

Since ->swizzle_irq and ->map_irq default to NULL anyway, isn't this a
no-op?

>  	ACPI_COMPANION_SET(&bridge->dev, controller->companion);
>  	return 0;
>  }
> -- 
> 2.1.0
> 
