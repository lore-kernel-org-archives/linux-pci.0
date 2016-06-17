Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37466 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129AbcFQVJ3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 17 Jun 2016 17:09:29 -0400
Date: Fri, 17 Jun 2016 16:09:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2 10/13] PCI: Avoid going from D3cold to D3hot for
 system sleep
Message-ID: <20160617210924.GA12254@localhost>
References: <cover.1463134231.git.lukas@wunner.de>
 <20ccb6cc38f872c3d56b44cc2b9776a4a39c7dc5.1463134232.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20ccb6cc38f872c3d56b44cc2b9776a4a39c7dc5.1463134232.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 13, 2016 at 01:15:31PM +0200, Lukas Wunner wrote:
> There are devices wich are not power-managed by the platform, yet can be

s/wich/which/

> runtime suspended to D3cold with some other mechanism.  When putting the
> system to sleep, we currently handle such devices improperly by trying
> to transition them from D3cold to D3hot (the default power state defined
> at the beginning of pci_target_state()).  Avoid that.
> 
> An example for devices affected by this are Thunderbolt controllers
> built into Macs which can be put into D3cold with nonstandard ACPI
> methods.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

This needs an ack from Rafael.

Naive question: why is the default target_state PCI_D3hot?

> ---
>  drivers/pci/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 791dfe7..6af9911 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1943,6 +1943,8 @@ static pci_power_t pci_target_state(struct pci_dev *dev)
>  			      && !(dev->pme_support & (1 << target_state)))
>  				target_state--;
>  		}
> +	} else if (dev->current_state == PCI_D3cold) {
> +		target_state = PCI_D3cold;
>  	}

This only covers the case of !device_may_wakeup().  So I guess
device_may_wakeup() is false for these Thunderbolt controllers.  Is
there a reason you don't want to do this check for devices that may
wakeup?

Sorry, more naive questions.  I don't know anything about power
management, and it all looks like black magic to me.

>  	return target_state;
> -- 
> 2.8.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
