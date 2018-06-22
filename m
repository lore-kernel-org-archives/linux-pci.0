Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754321AbeFVRTB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Jun 2018 13:19:01 -0400
Date: Fri, 22 Jun 2018 12:18:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alan Douglas <adouglas@cadence.com>
Cc: bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, shawn.lin@rock-chips.com
Subject: Re: [PATCH] PCI: Update Makefile to move Endpoint library before
 controllers
Message-ID: <20180622171859.GE108993@bhelgaas-glaptop.roam.corp.google.com>
References: <1529684237-10424-1-git-send-email-adouglas@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1529684237-10424-1-git-send-email-adouglas@cadence.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 22, 2018 at 05:17:17PM +0100, Alan Douglas wrote:
> The Endpoint library must be initialized before its users, which
> are in drivers/pci/controllers
> 
> This change corrects a kernel crash when loading the Cadence EP
> driver, since it calls devm_pci_epc_create() and this is only
> valid once the Endpoint library has been initialized.
> 
> Signed-off-by: Alan Douglas <adouglas@cadence.com>

Applied to for-linus for v4.18, thanks!

I think this got broken by the move to drivers/pci/controllers, so I added
this:

  Fixes: 6e0832fa432e ("PCI: Collect all native drivers under drivers/pci/controller/")

> ---
>  drivers/pci/Makefile |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 5352019..1b2cfe5 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -28,10 +28,10 @@ obj-$(CONFIG_PCI_PF_STUB)	+= pci-pf-stub.o
>  obj-$(CONFIG_PCI_ECAM)		+= ecam.o
>  obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>  
> -obj-y				+= controller/
> -obj-y				+= switch/
> -
>  # Endpoint library must be initialized before its users
>  obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
>  
> +obj-y				+= controller/
> +obj-y				+= switch/
> +
>  ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
> -- 
> 1.7.1
> 
