Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753222AbcLGSfA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Dec 2016 13:35:00 -0500
Date: Wed, 7 Dec 2016 12:34:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, Scott Murray <scott@spiteful.org>,
        minyard@acm.org, gnomes@lxorguk.ukuu.org.uk,
        linux-pci@vger.kernel.org, linux-security-module@vger.kernel.org,
        keyrings@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 25/39] Annotate hardware config module parameters in
 drivers/pci/hotplug/
Message-ID: <20161207183455.GC22129@bhelgaas-glaptop.roam.corp.google.com>
References: <148059537897.31612.9461043954611464597.stgit@warthog.procyon.org.uk>
 <148059557836.31612.5039521915534964791.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <148059557836.31612.5039521915534964791.stgit@warthog.procyon.org.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 01, 2016 at 12:32:58PM +0000, David Howells wrote:
> When the kernel is running in secure boot mode, we lock down the kernel to
> prevent userspace from modifying the running kernel image.  Whilst this
> includes prohibiting access to things like /dev/mem, it must also prevent
> access by means of configuring driver modules in such a way as to cause a
> device to access or modify the kernel image.
> 
> To this end, annotate module_param* statements that refer to hardware
> configuration and indicate for future reference what type of parameter they
> specify.  The parameter parser in the core sees this information and can
> skip such parameters with an error message if the kernel is locked down.
> The module initialisation then runs as normal, but just sees whatever the
> default values for those parameters is.
> 
> Note that we do still need to do the module initialisation because some
> drivers have viable defaults set in case parameters aren't specified and
> some drivers support automatic configuration (e.g. PNP or PCI) in addition
> to manually coded parameters.
> 
> This patch annotates drivers in drivers/pci/hotplug/.
> 
> Suggested-by: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Scott Murray <scott@spiteful.org>
> cc: Bjorn Helgaas <bhelgaas@google.com>
> cc: linux-pci@vger.kernel.org

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I assume you'll merge this via some non-PCI tree.  Let me know if you
need anything else from me.

> ---
> 
>  drivers/pci/hotplug/cpcihp_generic.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/cpcihp_generic.c b/drivers/pci/hotplug/cpcihp_generic.c
> index 88a44a707b96..bbf9cf8aeaad 100644
> --- a/drivers/pci/hotplug/cpcihp_generic.c
> +++ b/drivers/pci/hotplug/cpcihp_generic.c
> @@ -220,7 +220,7 @@ module_param(first_slot, byte, 0);
>  MODULE_PARM_DESC(first_slot, "Hotswap bus first slot number");
>  module_param(last_slot, byte, 0);
>  MODULE_PARM_DESC(last_slot, "Hotswap bus last slot number");
> -module_param(port, ushort, 0);
> +module_param_hw(port, ushort, ioport, 0);
>  MODULE_PARM_DESC(port, "#ENUM signal I/O port");
>  module_param(enum_bit, uint, 0);
>  MODULE_PARM_DESC(enum_bit, "#ENUM signal bit (0-7)");
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
