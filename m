Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164439AbdEXWab (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 May 2017 18:30:31 -0400
Date: Wed, 24 May 2017 17:30:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH v3] PCI: use IDA to manage domain number if not getting
 it from DT
Message-ID: <20170524223027.GA7958@bhelgaas-glaptop.roam.corp.google.com>
References: <1495525511-202465-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1495525511-202465-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Shawn,

On Tue, May 23, 2017 at 03:45:11PM +0800, Shawn Lin wrote:
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
> Changes in v3:
> - make ida_domain a system-wide property and check it in the code to
> combine with use_dt_domains. Also update the comment there.
> 
> Changes in v2:
> - add a remove wrapper
> - rename use_dt_domains to ida_domain and set this bit
> in pci_get_new_domain_nr and test it in the remove wrapper.
> 
>  drivers/pci/pci.c    | 42 ++++++++++++++++++++++++++++--------------
>  drivers/pci/remove.c |  2 ++
>  include/linux/pci.h  |  8 ++++++--
>  3 files changed, 36 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b01bd5b..e5f5db0 100644
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
> @@ -5340,15 +5341,25 @@ static void pci_no_domains(void)
>  }
>  
>  #ifdef CONFIG_PCI_DOMAINS
> -static atomic_t __domain_nr = ATOMIC_INIT(-1);
> +DEFINE_IDA(__domain_nr);

Should be static.

> -int pci_get_new_domain_nr(void)
> +/* get domain number from IDA */
> +static bool ida_domain = true;

Reorder so "ida_domain" precedes the data structure it controls.

> +int pci_get_new_domain_nr(struct pci_bus *bus)
> +{
> +	return ida_simple_get(&__domain_nr, 0, sizeof(u64), GFP_KERNEL);
> +}
> +
> +void pci_put_old_domain_nr(struct pci_bus *bus)

s/pci_put_old_domain_nr/pci_put_domain_nr/

>  {
> -	return atomic_inc_return(&__domain_nr);
> +	if (ida_domain)
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
> @@ -5361,19 +5372,21 @@ static int of_pci_bus_find_domain_nr(struct device *parent)
>  	 * If DT domain property is valid (domain >= 0) and
>  	 * use_dt_domains != 0, the DT assignment is valid since this means
>  	 * we have not previously allocated a domain number by using
> -	 * pci_get_new_domain_nr(); we should also update use_dt_domains to
> -	 * 1, to indicate that we have just assigned a domain number from
> -	 * DT.
> +	 * pci_get_new_domain_nr(), so we should set ida_domain to false to
> +	 * indicate that we don't allocate domain from idr; we should also
> +	 * update use_dt_domains to 1, to indicate that we have just assigned
> +	 * a domain number from DT.
>  	 *
>  	 * If DT domain property value is not valid (ie domain < 0), and we
>  	 * have not previously assigned a domain number from DT
> -	 * (use_dt_domains != 1) we should assign a domain number by
> -	 * using the:
> +	 * (use_dt_domains != 1 && ida_domain != false) we should assign a
> +	 * domain number by using the:
>  	 *
>  	 * pci_get_new_domain_nr()
>  	 *
> -	 * API and update the use_dt_domains value to keep track of method we
> -	 * are using to assign domain numbers (use_dt_domains = 0).
> +	 * API and update the use_dt_domains and ida_domain value to keep track
> +	 * of method we are using to assign domain numbers (use_dt_domains = 0
> +	 * and ida_domain = true).
>  	 *
>  	 * All other combinations imply we have a platform that is trying
>  	 * to mix domain numbers obtained from DT and pci_get_new_domain_nr(),
> @@ -5383,9 +5396,10 @@ static int of_pci_bus_find_domain_nr(struct device *parent)
>  	 */
>  	if (domain >= 0 && use_dt_domains) {
>  		use_dt_domains = 1;
> -	} else if (domain < 0 && use_dt_domains != 1) {
> +		ida_domain = false;
> +	} else if (domain < 0 && use_dt_domains != 1 && ida_domain != false) {
>  		use_dt_domains = 0;
> -		domain = pci_get_new_domain_nr();
> +		domain = pci_get_new_domain_nr(bus);

These comments and logic are too complicated for my puny brain.  Much of
this was pre-existing, of course.  Surely there's a simpler way?

1) If we're using ACPI, every host bridge must have a _SEG method, and it
supplies the domain.  We ignore any bridge without _SEG.

2) If we're using DT, every host bridge must supply "linux,pci-domain", and
it supplies the domain.  We ignore any bridge without "linux,pci-domain".

3) Otherwise, we always use IDA.

>  	} else {
>  		dev_err(parent, "Node %s has inconsistent \"linux,pci-domain\" property in DT\n",
>  			parent->of_node->full_name);
> @@ -5397,7 +5411,7 @@ static int of_pci_bus_find_domain_nr(struct device *parent)
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

In your current patch, ida_domain defaults to true, and it is only set
to false in of_pci_bus_find_domain_nr(), which is only called when
ACPI is disabled.  Therefore, ida_domain will be true when we're using
ACPI, and I think pci_put_old_domain_nr() will erroneously remove
domains from tha IDA.

>  	pci_remove_bus(bus);
>  	host_bridge->bus = NULL;
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 33c2b0b..9296e31 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1445,13 +1445,17 @@ static inline int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
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
