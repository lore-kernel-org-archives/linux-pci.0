Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388105AbeGWXOs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Jul 2018 19:14:48 -0400
Date: Mon, 23 Jul 2018 17:11:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/pci/probe: Move variable bridge inside ifdef
Message-ID: <20180723221129.GW128988@bhelgaas-glaptop.roam.corp.google.com>
References: <20180721214556.25651-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180721214556.25651-1-anders.roxell@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jul 21, 2018 at 11:45:56PM +0200, Anders Roxell wrote:
> When CONFIG_PCI_QUIRKS isn't enabled we get the warning below:
> drivers/pci/probe.c: In function ‘pci_bus_read_dev_vendor_id’:
> drivers/pci/probe.c:2221:18: warning: unused variable ‘bridge’ [-Wunused-variable]
>   struct pci_dev *bridge = bus->self;
>                   ^~~~~~
> 
> Move the declaration of variable bridge to inside the ifdef
> CONFIG_PCI_QUIRKS.
> 
> Fixes: ac5ea104a279 ("PCI: Workaround IDT switch ACS Source Validation erratum")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I folded this into the original commit on pci/enumeration, thanks!

> ---
>  drivers/pci/probe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 1c581346c5b9..7a5323798312 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2218,9 +2218,9 @@ bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
>  bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
>  				int timeout)
>  {
> +#ifdef CONFIG_PCI_QUIRKS
>  	struct pci_dev *bridge = bus->self;
>  
> -#ifdef CONFIG_PCI_QUIRKS
>  	/*
>  	 * Certain IDT switches have an issue where they improperly trigger
>  	 * ACS Source Validation errors on completions for config reads.
> -- 
> 2.18.0
> 
