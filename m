Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ye0-f172.google.com ([209.85.213.172]:50921 "EHLO
	mail-ye0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755454Ab3JCWOL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Oct 2013 18:14:11 -0400
Received: by mail-ye0-f172.google.com with SMTP id m12so782478yen.31
        for <linux-pci@vger.kernel.org>; Thu, 03 Oct 2013 15:14:10 -0700 (PDT)
Date: Thu, 3 Oct 2013 16:06:28 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Workaround missing pci_set_master in pci drivers
Message-ID: <20131003220628.GA14835@google.com>
References: <CAE9FiQV8ipnQ_vV68S-QHMrUrQTWQT_XObxyBeR=dOuw6fG1eg@mail.gmail.com>
 <1380399187-4962-1-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380399187-4962-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Sep 28, 2013 at 01:13:07PM -0700, Yinghai Lu wrote:
> BenH found:
> | 928bea964827d7824b548c1f8e06eccbbc4d0d7d
> | PCI: Delay enabling bridges until they're needed
> 
> break PCI on powerpc.  The reason is that the PCIe port driver will
> call pci_enable_device() on the bridge, so device enabled (but skip
> pci_set_master because pcie_port_auto and no acpi on powerpc ).
> 
> Because of that, pci_enable_bridge() later on (called as a result of the
> child device driver doing pci_enable_device) will see the bridge as
> already enabled and will not call pci_set_master() on it.
> 
> Fixed by add checking in pci_enable_bridge, and call pci_set_master
> if driver skip that.
> That will make the code more robot and wade off problem for missing
> pci_set_master in drivers.
> 
> Reported-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> 
> ---
>  drivers/pci/pci.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/pci/pci.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/pci.c
> +++ linux-2.6/drivers/pci/pci.c
> @@ -1156,8 +1156,14 @@ static void pci_enable_bridge(struct pci
>  
>  	pci_enable_bridge(dev->bus->self);
>  
> -	if (pci_is_enabled(dev))
> +	if (pci_is_enabled(dev)) {
> +		if (!dev->is_busmaster) {
> +			dev_warn(&dev->dev, "driver skip pci_set_master, fix it!\n");

I know this is already in Linus' tree, but if we're going to enable
bus mastering here, what's the point of the warning?  If somebody
fixes the driver by adding a pci_set_master() call there, does that
improve something?

Bjorn

> +			pci_set_master(dev);
> +		}
>  		return;
> +	}
> +
>  	retval = pci_enable_device(dev);
>  	if (retval)
>  		dev_err(&dev->dev, "Error enabling bridge (%d), continuing\n",
