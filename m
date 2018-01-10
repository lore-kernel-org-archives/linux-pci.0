Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751923AbeAJUtC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Jan 2018 15:49:02 -0500
Date: Wed, 10 Jan 2018 14:48:58 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Include more PCI files
Message-ID: <20180110204858.GB241460@bhelgaas-glaptop.roam.corp.google.com>
References: <20171215225307.175987.4972.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171215225307.175987.4972.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 15, 2017 at 04:53:07PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Add more PCI files to the PCI subsystem.
> 
> I expect Rafael to continue merging things in drivers/acpi/pci*, but it's
> nice to have linux-pci included on patches.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Applied with Rafael's ack on pci/misc for v4.16.

> ---
>  MAINTAINERS |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa71ab52fd76..6fcc9b8bab52 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10551,8 +10551,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
>  S:	Supported
>  F:	Documentation/devicetree/bindings/pci/
>  F:	Documentation/PCI/
> +F:	drivers/acpi/pci*
>  F:	drivers/pci/
> +F:	include/asm-generic/pci*
>  F:	include/linux/pci*
> +F:	include/uapi/linux/pci*
> +F:	lib/pci*
>  F:	arch/x86/pci/
>  F:	arch/x86/kernel/quirks.c
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
