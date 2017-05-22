Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933776AbdEVVTG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 May 2017 17:19:06 -0400
Date: Mon, 22 May 2017 16:18:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH v2] PCI: use IDA to manage domain number if not getting
 it from DT
Message-ID: <20170522211859.GC19733@bhelgaas-glaptop.roam.corp.google.com>
References: <1495072037-135458-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1495072037-135458-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 18, 2017 at 09:47:17AM +0800, Shawn Lin wrote:
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
> 
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
> Changes in v2:
> - add a remove wrapper
> - rename use_dt_domains to ida_domain and set this bit
> in pci_get_new_domain_nr and test it in the remove wrapper.
> 
>  drivers/pci/pci.c    | 23 +++++++++++++++++------
>  drivers/pci/remove.c |  2 ++
>  include/linux/pci.h  |  9 +++++++--
>  3 files changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b01bd5b..8affda5 100644
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
> @@ -5340,19 +5341,29 @@ static void pci_no_domains(void)
>  }
>  
>  #ifdef CONFIG_PCI_DOMAINS
> -static atomic_t __domain_nr = ATOMIC_INIT(-1);
> +DEFINE_IDA(__domain_nr);
>  
> -int pci_get_new_domain_nr(void)
> +int pci_get_new_domain_nr(struct pci_bus *bus)
>  {
> -	return atomic_inc_return(&__domain_nr);
> +	bus->ida_domain = true;
> +	return ida_simple_get(&__domain_nr, 0, sizeof(u64), GFP_KERNEL);
> +}
> +
> +void pci_put_old_domain_nr(struct pci_bus *bus)
> +{
> +	if (bus->ida_domain)
> +		ida_simple_remove(&__domain_nr, bus->domain_nr);
>  }
>  
>  #ifdef CONFIG_PCI_DOMAINS_GENERIC
> -static int of_pci_bus_find_domain_nr(struct device *parent)
> +static int of_pci_bus_find_domain_nr(struct pci_bus *bus,
> +				     struct device *parent)
>  {
>  	static int use_dt_domains = -1;
>  	int domain = -1;
>  
> +	bus->ida_domain = false;
> +
>  	if (parent)
>  		domain = of_get_pci_domain_nr(parent->of_node);
>  	/*
> @@ -5385,7 +5396,7 @@ static int of_pci_bus_find_domain_nr(struct device *parent)
>  		use_dt_domains = 1;
>  	} else if (domain < 0 && use_dt_domains != 1) {
>  		use_dt_domains = 0;
> -		domain = pci_get_new_domain_nr();
> +		domain = pci_get_new_domain_nr(bus);
>  	} else {
>  		dev_err(parent, "Node %s has inconsistent \"linux,pci-domain\" property in DT\n",
>  			parent->of_node->full_name);
> @@ -5397,7 +5408,7 @@ static int of_pci_bus_find_domain_nr(struct device *parent)
>  
>  int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
>  {
> -	return acpi_disabled ? of_pci_bus_find_domain_nr(parent) :
> +	return acpi_disabled ? of_pci_bus_find_domain_nr(bus, parent) :
>  			       acpi_pci_bus_find_domain_nr(bus);
>  }
>  #endif
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 73a03d3..1bbbb37 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -157,6 +157,8 @@ void pci_remove_root_bus(struct pci_bus *bus)
>  	list_for_each_entry_safe(child, tmp,
>  				 &bus->devices, bus_list)
>  		pci_remove_bus_device(child);
> +
> +	pci_put_old_domain_nr(bus);
>  	pci_remove_bus(bus);
>  	host_bridge->bus = NULL;
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 33c2b0b..d4f6fb8 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -513,6 +513,7 @@ struct pci_bus {
>  	unsigned char	cur_bus_speed;	/* enum pci_bus_speed */
>  #ifdef CONFIG_PCI_DOMAINS_GENERIC
>  	int		domain_nr;
> +	bool		ida_domain;	/* get domain number from IDA */

The fact that ida_domain is a member of struct pci_bus suggests that
it can be a per-bus property.  However, I think it is actually a
system-wide property.  If we get the domain from DT for some buses but
via IDA for other buses, there's no mechanism to prevent collisions,
is there?

If it's a system-wide property, I'd rather have a single global
variable for it because that makes it more obvious to the reader that
we don't have to worry about collisions between a DT domain number and
one from IDA.

>  #endif
>  
>  	char		name[48];
> @@ -1445,13 +1446,17 @@ static inline int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
>   * configuration space.
>   */
>  #ifdef CONFIG_PCI_DOMAINS
> +extern struct ida __domain_nr;
>  extern int pci_domains_supported;
> -int pci_get_new_domain_nr(void);
> +int pci_get_new_domain_nr(struct pci_bus *bus);
> +void pci_put_old_domain_nr(struct pci_bus *bus);
>  #else
>  enum { pci_domains_supported = 0 };
>  static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
>  static inline int pci_proc_domain(struct pci_bus *bus) { return 0; }
> -static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
> +static inline int pci_get_new_domain_nr(struct pci_bus *bus)
> +{ return -ENOSYS; }
> +static inline void pci_put_old_domain_nr(struct pci_bus *bus) { }
>  #endif /* CONFIG_PCI_DOMAINS */
>  
>  /*
> -- 
> 1.9.1
> 
> 
