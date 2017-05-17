Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750944AbdEQTCf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 May 2017 15:02:35 -0400
Date: Wed, 17 May 2017 14:02:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH] PCI: use IDA to manage domain number if not getting it
 from DT
Message-ID: <20170517190233.GG31462@bhelgaas-glaptop.roam.corp.google.com>
References: <1490175744-22727-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1490175744-22727-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Shawn,

On Wed, Mar 22, 2017 at 05:42:24PM +0800, Shawn Lin wrote:
> If not getting domain number from DT, the domain number will
> keep increasing once doing unbind/bind RC drivers. This could
> introduce pointless tree view of lspci as shows below:
> 
> -+-[0001:00]---00.0-[01]----00.0
>   \-[0000:00]-
> 
> The more test we do, the lengthier it would be. The more serious
> issue is that if attaching two hierarchies for two different domains
> belonging to two root bridges, so when doing unbind/bind test for one
> of them and keep the other, then the domain number would finally
> overflow and make the two hierarchies of devices share the some domain
> number but actually they shouldn't. So it looks like we need to invent
> a new indexing ID mechanism to manage domain number. This patch
> introduces idr to achieve our purpose.

I like the idea of this patch, but I have some comments/suggestions
about the implementation.

> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  drivers/pci/pci.c    | 11 +++++++----
>  drivers/pci/remove.c |  5 +++++
>  include/linux/pci.h  |  2 ++
>  3 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index a881c0d..1752ccc 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -11,6 +11,7 @@
>  #include <linux/kernel.h>
>  #include <linux/delay.h>
>  #include <linux/dmi.h>
> +#include <linux/idr.h>
>  #include <linux/init.h>
>  #include <linux/of.h>
>  #include <linux/of_pci.h>
> @@ -5172,15 +5173,16 @@ static void pci_no_domains(void)
>  }
>  
>  #ifdef CONFIG_PCI_DOMAINS
> -static atomic_t __domain_nr = ATOMIC_INIT(-1);
> +DEFINE_IDA(__domain_nr);
>  
>  int pci_get_new_domain_nr(void)
>  {
> -	return atomic_inc_return(&__domain_nr);
> +	return ida_simple_get(&__domain_nr, 0, sizeof(u64), GFP_KERNEL);
>  }
>  
>  #ifdef CONFIG_PCI_DOMAINS_GENERIC
> -static int of_pci_bus_find_domain_nr(struct device *parent)
> +static int of_pci_bus_find_domain_nr(struct pci_bus *bus,
> +				     struct device *parent)
>  {
>  	static int use_dt_domains = -1;
>  	int domain = -1;
> @@ -5224,12 +5226,13 @@ static int of_pci_bus_find_domain_nr(struct device *parent)
>  		domain = -1;
>  	}
>  
> +	bus->use_dt_domains = use_dt_domains;
>  	return domain;
>  }
>  
>  int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
>  {
> -	return acpi_disabled ? of_pci_bus_find_domain_nr(parent) :
> +	return acpi_disabled ? of_pci_bus_find_domain_nr(bus, parent) :
>  			       acpi_pci_bus_find_domain_nr(bus);
>  }
>  #endif
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 73a03d3..ad93378 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -157,6 +157,11 @@ void pci_remove_root_bus(struct pci_bus *bus)
>  	list_for_each_entry_safe(child, tmp,
>  				 &bus->devices, bus_list)
>  		pci_remove_bus_device(child);
> +	#ifdef CONFIG_PCI_DOMAINS_GENERIC
> +	if (!bus->use_dt_domains)
> +		ida_simple_remove(&__domain_nr, bus->domain_nr);
> +	#endif

1) I think there should be a wrapper alongside pci_get_new_domain_nr()
that does the remove.  That would remove the #ifdef here and help make
the remove symmetric with the get.

2) The "use_dt_domains" name is too specific and makes too many
assumptions about CONFIG_PCI_DOMAINS_GENERIC, e.g., it assumes that we
don't use CONFIG_PCI_DOMAINS_GENERIC with ACPI.

At a high level, if DT or ACPI supplies a domain number, we use that.
We only use the IDA if neither supplies a domain number.  I think it
would be clearer to set a bit in pci_get_new_domain_nr() that means
"we got this domain from IDA", and then test that bit in the
corresponding remove wrapper.

>  	pci_remove_bus(bus);
>  	host_bridge->bus = NULL;
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 6732d32..235b336 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -505,6 +505,7 @@ struct pci_bus {
>  	unsigned char	cur_bus_speed;	/* enum pci_bus_speed */
>  #ifdef CONFIG_PCI_DOMAINS_GENERIC
>  	int		domain_nr;
> +	int		use_dt_domains;
>  #endif
>  
>  	char		name[48];
> @@ -1449,6 +1450,7 @@ static inline int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
>   * configuration space.
>   */
>  #ifdef CONFIG_PCI_DOMAINS
> +extern struct ida __domain_nr;
>  extern int pci_domains_supported;
>  int pci_get_new_domain_nr(void);
>  #else
> -- 
> 1.9.1
> 
> 
