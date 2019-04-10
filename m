Return-Path: <SRS0=u0zl=SM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B9EC10F11
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 22:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07DD120830
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 22:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554936759;
	bh=NgUY/kAl30XKCotoENqvRAbiGzMy6ElAApKHZkqCHAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zVrtVxRlvNaWrzyUFTPr+yyBh1XC6Mg1ouv9D3AOCmORkRfF1CZ0hrrYw4NZeSEcj
	 YbKco9sbc2Fchn865unqgj5U9Wqd4P8LzxlYbMyGFdNzabAg7X3z0Mbj4Jm5M8GzvR
	 kchg/vCL6fG0r22OuZFNUf5iAMHMGH8khKERPTPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfDJWwc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:52:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbfDJWwb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Apr 2019 18:52:31 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94BAB20830;
        Wed, 10 Apr 2019 22:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554936749;
        bh=NgUY/kAl30XKCotoENqvRAbiGzMy6ElAApKHZkqCHAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xTXrV1XIXsFJ9RNTITNwhgmv0Qxn4LqLJXlPACoCpHS3wGWATVwz0UW9ye8twDMzJ
         XmMGV5SDNmVo2235+0lKQAYENLEbjTpMH2+Dbo84sQeBjMDCPYgwVW0h40k1P5/p79
         L/qUxCFo/Vr0+gs1XJXIMPUMxhwVW9W/Z5q3TXs4=
Date:   Wed, 10 Apr 2019 17:52:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: Re: [PATCH v2 4/4] PCI: modify kernel parameters to differentiate
 between MMIO and MMIO_PREF sizes
Message-ID: <20190410225228.GM256045@google.com>
References: <20190311162154.3852-1-nicholas.johnson-opensource@outlook.com.au>
 <PS2P216MB0642F184D07467C1BA17064D80480@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PS2P216MB0642F184D07467C1BA17064D80480@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 11, 2019 at 04:23:55PM +0000, Nicholas Johnson wrote:
> Add new kernel parameters:
>         - hp_io_size=nn
>         - hp_mmio_size=nnM
>         - hp_mmio_pref_size=nnM
> 
> Depreciate old kernel parameters and print warning when used:
>         - hpiosize=nn
>         - hpmemsize=nnM

s/Depreciate/Deprecate/ (several occurrences)

> Make hp_io_size function identically to hpiosize.
> Make hp_mmio_size set additional size for MMIO bridge window.
> Make hp_mmio_pref_size set additional size for MMIO_PREF bridge window.

Help me understand this -- I think the point of this is today,
a value specified with "hpmemsize=" applies to both the MMIO
(non-prefetchable) and the MMIO_PREF window, and you want to control
them separately, right?

That seems reasonable.  I also agree that your proposed new parameter
names are nicer than the existing ones.  But the renames make this
patch much bigger than it would be otherwise, and I'm not really
convinced that the user confusion of deprecating the old ones is worth
the trouble.

What I would suggest is either dropping the rename or splitting this
into two patches:

  1) add "hpmemprefsize=" parameter
  2) rename the parameters

Then the first patch would be a little smaller but would have all the
important functionality, and the second would be pretty easy to review
because it only changes names.

> Override old kernel parameters if any of the new ones are specified.
> 
> Make sure old kernel parameters still work identically when none of the
> new kernel parameters are specified.
> 
> Make sure it is easy to remove old kernel parameters from the source
> when it is deemed that sufficient time has passed to allow users to
> migrate to the new kernel parameters.
> 
> Update documentation to reflect changes.
> 
> Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> ---
>  .../admin-guide/kernel-parameters.txt         | 21 ++++++++--
>  drivers/pci/pci.c                             | 39 +++++++++++++++++--
>  drivers/pci/setup-bus.c                       | 26 +++++++------
>  include/linux/pci.h                           |  3 +-
>  4 files changed, 69 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 858b6c0b9..29406ae8f 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3326,12 +3326,27 @@
>  				the default.
>  				off: Turn ECRC off
>  				on: Turn ECRC on.
> -		hpiosize=nn[KMG]	The fixed amount of bus space which is
> +
> +		hpiosize=nn[KMG]	Depreciated. Overridden by hp_io_size
> +				value if any of hp_io_size, hp_mmio_size
> +				or hp_mmio_pref_size are used. This sets
> +				hp_io_size to the given value if not
> +				overridden.
> +
> +		hpmemsize=nn[KMG]	Depreciated. Overridden if any of
> +				hp_io_size, hp_mmio_size or
> +				hp_mmio_pref_size are used. This sets
> +				hp_mmio_size and hp_mmio_pref_size to
> +				the given value if not overridden.
> +		hp_io_size=nn[KMG]	The fixed amount of bus space which is
>  				reserved for hotplug bridge's IO window.
>  				Default size is 256 bytes.
> -		hpmemsize=nn[KMG]	The fixed amount of bus space which is
> -				reserved for hotplug bridge's memory window.
> +		hp_mmio_size=nn[KMG]	The fixed amount of bus space which is
> +				reserved for hotplug bridge's 32-bit mmio window.
>  				Default size is 2 megabytes.
> +		hp_mmio_pref_size=nn[KMG]	The fixed amount of bus space
> +				which is reserved for hotplug bridge's 64-bit
> +				mmio_pref window. Default size is 2 megabytes.
>  		hpbussize=nn	The minimum amount of additional bus numbers
>  				reserved for buses below a hotplug bridge.
>  				Default is 1.
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index c25acace7..64978bf84 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -85,12 +85,15 @@ unsigned long pci_cardbus_io_size = DEFAULT_CARDBUS_IO_SIZE;
>  unsigned long pci_cardbus_mem_size = DEFAULT_CARDBUS_MEM_SIZE;
>  
>  #define DEFAULT_HOTPLUG_IO_SIZE		(256)
> -#define DEFAULT_HOTPLUG_MEM_SIZE	(2*1024*1024)
> -/* pci=hpmemsize=nnM,hpiosize=nn can override this */
> +#define DEFAULT_HOTPLUG_MMIO_SIZE	(2*1024*1024)
> +#define DEFAULT_HOTPLUG_MMIO_PREF_SIZE	(2*1024*1024)
> +/* Override with pci=hp_io_size=nn,hp_mmio_size=nnM,hp_mmio_pref_size=nnM */
>  unsigned long pci_hotplug_io_size  = DEFAULT_HOTPLUG_IO_SIZE;
> -unsigned long pci_hotplug_mem_size = DEFAULT_HOTPLUG_MEM_SIZE;
> +unsigned long pci_hotplug_mmio_size  = DEFAULT_HOTPLUG_MMIO_SIZE;
> +unsigned long pci_hotplug_mmio_pref_size  = DEFAULT_HOTPLUG_MMIO_PREF_SIZE;
>  
>  #define DEFAULT_HOTPLUG_BUS_SIZE	1
> +/* Override with pci=hpbussize=nn,assign-busses */
>  unsigned long pci_hotplug_bus_size = DEFAULT_HOTPLUG_BUS_SIZE;
>  
>  enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_DEFAULT;
> @@ -6144,6 +6147,15 @@ EXPORT_SYMBOL(pci_fixup_cardbus);
>  
>  static int __init pci_setup(char *str)
>  {
> +	/*
> +	 * Depreciated pci=hpmemsize=nnM but keep the functionality for now.
> +	 * If none of hp_io_size, hp_mmio_size or hp_mmio_pref_size are set
> +	 * then override hp_mmio_size and hp_mmio_pref_size with hpmemsize.
> +	 */
> +	unsigned long pci_hotplug_io_size_old = DEFAULT_HOTPLUG_IO_SIZE;
> +	unsigned long pci_hotplug_mem_size = DEFAULT_HOTPLUG_MMIO_SIZE;
> +	bool use_new_pci_hotplug_params = 0;
> +
>  	while (str) {
>  		char *k = strchr(str, ',');
>  		if (k)
> @@ -6176,9 +6188,23 @@ static int __init pci_setup(char *str)
>  			} else if (!strncmp(str, "ecrc=", 5)) {
>  				pcie_ecrc_get_policy(str + 5);
>  			} else if (!strncmp(str, "hpiosize=", 9)) {
> -				pci_hotplug_io_size = memparse(str + 9, &str);
> +				printk(KERN_WARNING "PCI: Depreciated option 'hpiosize', use 'hp_io_size' instead\n");
> +				pci_hotplug_io_size_old =
> +					memparse(str + 9, &str);
>  			} else if (!strncmp(str, "hpmemsize=", 10)) {
> +				printk(KERN_WARNING "PCI: Depreciated option 'hpmemsize', use 'hp_mmio_size' and 'hp_mmio_pref_size' instead\n");
>  				pci_hotplug_mem_size = memparse(str + 10, &str);
> +			} else if (!strncmp(str, "hp_io_size=", 11)) {
> +				use_new_pci_hotplug_params = 1;
> +				pci_hotplug_io_size = memparse(str + 11, &str);
> +			} else if (!strncmp(str, "hp_mmio_size=", 13)) {
> +				use_new_pci_hotplug_params = 1;
> +				pci_hotplug_mmio_size =
> +					memparse(str + 13, &str);
> +			} else if (!strncmp(str, "hp_mmio_pref_size=", 18)) {
> +				use_new_pci_hotplug_params = 1;
> +				pci_hotplug_mmio_pref_size =
> +					memparse(str + 18, &str);
>  			} else if (!strncmp(str, "hpbussize=", 10)) {
>  				pci_hotplug_bus_size =
>  					simple_strtoul(str + 10, &str, 0);
> @@ -6204,6 +6230,11 @@ static int __init pci_setup(char *str)
>  		}
>  		str = k;
>  	}
> +	if (!use_new_pci_hotplug_params) {
> +		pci_hotplug_io_size = pci_hotplug_io_size_old;
> +		pci_hotplug_mmio_size = pci_hotplug_mem_size;
> +		pci_hotplug_mmio_pref_size = pci_hotplug_mem_size;
> +	}
>  	return 0;
>  }
>  early_param("pci", pci_setup);
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index efe899b02..56d227227 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1223,7 +1223,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
>  {
>  	struct pci_dev *dev;
>  	unsigned long mask, prefmask, type2 = 0, type3 = 0;
> -	resource_size_t additional_mem_size = 0, additional_io_size = 0;
> +	resource_size_t additional_io_size = 0, additional_mmio_size = 0,
> +		additional_mmio_pref_size = 0;
>  	struct resource *b_res;
>  	int ret;
>  
> @@ -1256,8 +1257,9 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
>  	case PCI_CLASS_BRIDGE_PCI:
>  		pci_bridge_check_ranges(bus);
>  		if (bus->self->is_hotplug_bridge) {
> -			additional_io_size  = pci_hotplug_io_size;
> -			additional_mem_size = pci_hotplug_mem_size;
> +			additional_io_size = pci_hotplug_io_size;
> +			additional_mmio_size = pci_hotplug_mmio_size;
> +			additional_mmio_pref_size = pci_hotplug_mmio_pref_size;
>  		}
>  		/* Fall through */
>  	default:
> @@ -1275,9 +1277,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
>  			prefmask |= IORESOURCE_MEM_64;
>  			ret = pbus_size_mem(bus, prefmask, prefmask,
>  				  prefmask, prefmask,
> -				  realloc_head ? 0 : additional_mem_size,
> -				  additional_mem_size, realloc_head);
> -
> +				  realloc_head ? 0 : additional_mmio_pref_size,
> +				  additional_mmio_pref_size, realloc_head);
>  			/*
>  			 * If successful, all non-prefetchable resources and any
>  			 * 32-bit prefetchable resources will go in the
> @@ -1298,9 +1299,9 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
>  		if (!type2) {
>  			prefmask &= ~IORESOURCE_MEM_64;
>  			ret = pbus_size_mem(bus, prefmask, prefmask,
> -					 prefmask, prefmask,
> -					 realloc_head ? 0 : additional_mem_size,
> -					 additional_mem_size, realloc_head);
> +				prefmask, prefmask,
> +				realloc_head ? 0 : additional_mmio_pref_size,
> +				additional_mmio_pref_size, realloc_head);
>  
>  			/*
>  			 * If successful, only non-prefetchable resources
> @@ -1309,7 +1310,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
>  			if (ret == 0)
>  				mask = prefmask;
>  			else
> -				additional_mem_size += additional_mem_size;
> +				additional_mmio_size +=
> +					additional_mmio_pref_size;
>  
>  			type2 = type3 = IORESOURCE_MEM;
>  		}
> @@ -1329,8 +1331,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
>  		 * prefetchable resource in a 64-bit prefetchable window.
>  		 */
>  		pbus_size_mem(bus, mask, IORESOURCE_MEM, type2, type3,
> -				realloc_head ? 0 : additional_mem_size,
> -				additional_mem_size, realloc_head);
> +				realloc_head ? 0 : additional_mmio_size,
> +				additional_mmio_size, realloc_head);
>  		break;
>  	}
>  }
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 65f1d8c2f..b30d55697 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1959,7 +1959,8 @@ extern u8 pci_dfl_cache_line_size;
>  extern u8 pci_cache_line_size;
>  
>  extern unsigned long pci_hotplug_io_size;
> -extern unsigned long pci_hotplug_mem_size;
> +extern unsigned long pci_hotplug_mmio_size;
> +extern unsigned long pci_hotplug_mmio_pref_size;
>  extern unsigned long pci_hotplug_bus_size;
>  
>  /* Architecture-specific versions may override these (weak) */
> -- 
> 2.20.1
> 
