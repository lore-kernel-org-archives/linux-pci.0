Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752172AbcHVRFT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Aug 2016 13:05:19 -0400
Date: Mon, 22 Aug 2016 12:05:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Will Deacon <will.deacon@arm.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci: Add support for unbinding the generic PCI host
 controller
Message-ID: <20160822170515.GF18628@localhost>
References: <57698276.6050606@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57698276.6050606@siemens.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jan,

On Tue, Jun 21, 2016 at 08:07:50PM +0200, Jan Kiszka wrote:
> Particularly useful when working in virtual environments where the
> controller may come and go, but possibly not only there.

I'm not sure where we're at with this.  Will had a few questions about
the tear-down paths, and I couldn't tell what the resolution was.

> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  drivers/pci/ecam.h                  |  1 +
>  drivers/pci/host/pci-host-common.c  | 13 +++++++++++++
>  drivers/pci/host/pci-host-generic.c |  1 +
>  3 files changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/ecam.h b/drivers/pci/ecam.h
> index 9878beb..5a5f607 100644
> --- a/drivers/pci/ecam.h
> +++ b/drivers/pci/ecam.h
> @@ -63,5 +63,6 @@ extern struct pci_ecam_ops pci_generic_ecam_ops;
>  /* for DT-based PCI controllers that support ECAM */
>  int pci_host_common_probe(struct platform_device *pdev,
>  			  struct pci_ecam_ops *ops);
> +int pci_host_common_remove(struct platform_device *pdev);
>  #endif
>  #endif
> diff --git a/drivers/pci/host/pci-host-common.c b/drivers/pci/host/pci-host-common.c
> index 8cba7ab..c0ff4b1 100644
> --- a/drivers/pci/host/pci-host-common.c
> +++ b/drivers/pci/host/pci-host-common.c
> @@ -164,6 +164,19 @@ int pci_host_common_probe(struct platform_device *pdev,
>  	}
>  
>  	pci_bus_add_devices(bus);
> +	platform_set_drvdata(pdev, bus);
> +	return 0;
> +}
> +
> +int pci_host_common_remove(struct platform_device *pdev)
> +{
> +	struct pci_bus *bus = platform_get_drvdata(pdev);
> +
> +	pci_lock_rescan_remove();
> +	pci_stop_root_bus(bus);
> +	pci_remove_root_bus(bus);
> +	pci_unlock_rescan_remove();
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
> index 6eaceab..0a2e75b 100644
> --- a/drivers/pci/host/pci-host-generic.c
> +++ b/drivers/pci/host/pci-host-generic.c
> @@ -65,6 +65,7 @@ static struct platform_driver gen_pci_driver = {
>  		.of_match_table = gen_pci_of_match,
>  	},
>  	.probe = gen_pci_probe,
> +	.remove = pci_host_common_remove,
>  };
>  module_platform_driver(gen_pci_driver);
>  
> -- 
> 2.1.4
