Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33378 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755493AbcAHSBi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 8 Jan 2016 13:01:38 -0500
Date: Fri, 8 Jan 2016 12:01:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Will.Deacon@arm.com,
	catalin.marinas@arm.com, bhelgaas@google.com,
	hanjun.guo@linaro.org, rrichter@cavium.com,
	Prasun.Kapoor@caviumnetworks.com, gpkulkarni@gmail.com
Subject: Re: [PATCH] arm64, pci, numa: Adding helper functions as required by
 pci
Message-ID: <20160108180131.GB5354@localhost>
References: <1450780730-13667-1-git-send-email-gkulkarni@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1450780730-13667-1-git-send-email-gkulkarni@caviumnetworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 22, 2015 at 04:08:50PM +0530, Ganapatrao Kulkarni wrote:
> Adding helper functions and necessary code to make
> pci driver(pci-host-generic) numa aware.
> 
> This patch is on top of arm64-numa v7.
> http://www.spinics.net/lists/arm-kernel/msg460813.html
> 
> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> ---
>  arch/arm64/include/asm/numa.h       | 8 +++++---
>  arch/arm64/kernel/pci.c             | 8 ++++++++
>  drivers/pci/host/pci-host-generic.c | 1 +
>  3 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/numa.h b/arch/arm64/include/asm/numa.h
> index b8c2a3f..1eca4db 100644
> --- a/arch/arm64/include/asm/numa.h
> +++ b/arch/arm64/include/asm/numa.h
> @@ -15,9 +15,11 @@
>  extern int __node_distance(int from, int to);
>  #define node_distance(a, b) __node_distance(a, b)
>  
> -/* dummy definitions for pci functions */
> -#define pcibus_to_node(node)	0
> -#define cpumask_of_pcibus(bus)	0
> +struct pci_bus;
> +extern int pcibus_to_node(struct pci_bus *bus);
> +#define cpumask_of_pcibus(bus)	(pcibus_to_node(bus) == -1 ?		\
> +				 cpu_all_mask :				\
> +				 cpumask_of_node(pcibus_to_node(bus)))

All the arch definitions of cpumask_of_pcibus() are pretty similar;
could they be made more generic?  At the very least, can you drop the
definition here and use the one in include/asm-generic/topology.h,
which is identical to what you're defining here?

>  extern int cpu_to_node_map[NR_CPUS];
>  extern nodemask_t numa_nodes_parsed __initdata;
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index b3d098b..37e2e9f 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -84,3 +84,11 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>  	return NULL;
>  }
>  #endif
> +
> +#ifdef CONFIG_NUMA
> +int pcibus_to_node(struct pci_bus *bus)
> +{
> +	return dev_to_node(&bus->dev);
> +}
> +EXPORT_SYMBOL(pcibus_to_node);
> +#endif
> diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
> index 5434c90..a821e49 100644
> --- a/drivers/pci/host/pci-host-generic.c
> +++ b/drivers/pci/host/pci-host-generic.c
> @@ -230,6 +230,7 @@ static int gen_pci_probe(struct platform_device *pdev)
>  	of_pci_check_probe_only();
>  
>  	of_id = of_match_node(gen_pci_of_match, np);
> +	set_dev_node(dev, of_node_to_nid(np));
>  	pci->cfg.ops = (struct gen_pci_cfg_bus_ops *)of_id->data;
>  	pci->host.dev.parent = dev;
>  	INIT_LIST_HEAD(&pci->host.windows);
> -- 
> 1.8.1.4
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
