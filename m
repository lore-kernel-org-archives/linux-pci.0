Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:47452 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755594Ab3G3NtN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 30 Jul 2013 09:49:13 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: tianyu.lan@intel.com, bhelgaas@google.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, stern@rowland.harvard.edu
Subject: Re: [PATCH] PCI/ACPI: Change dev_info() to dev_dbg() in the acpi_pci_set_power_state()
Date: Tue, 30 Jul 2013 15:59:22 +0200
Message-ID: <8048720.q4LxpIqNkE@vostro.rjw.lan>
In-Reply-To: <1375151550-28632-1-git-send-email-tianyu.lan@intel.com>
References: <1375151550-28632-1-git-send-email-tianyu.lan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, July 30, 2013 10:32:30 AM tianyu.lan@intel.com wrote:
> From: Lan Tianyu <tianyu.lan@intel.com>
> 
> acpi_pci_set_power_state() produces log of device power state changing.
> Now the log is produced by dev_info(). This seems make no sense when user
> doesn't open debug option. So change it to dev_dbg() and prevent kernel
> log from being.
> 
> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=60636
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>

Bjorn, what do you think about this?

Rafael


> ---
>  drivers/pci/pci-acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index c78cc43..fb3522957 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -210,7 +210,7 @@ static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>  	}
>  
>  	if (!error)
> -		dev_info(&dev->dev, "power state changed by ACPI to %s\n",
> +		dev_dbg(&dev->dev, "power state changed by ACPI to %s\n",
>  			 acpi_power_state_string(state_conv[state]));
>  
>  	return error;
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
