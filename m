Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 2 Nov 2012 19:02:02 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH 3/8] PCI: Move out pci_enable_bridges out of
 assign_unsigned_bus_res
Message-Id: <20121102190202.2b09edcd.izumi.taku@jp.fujitsu.com>
In-Reply-To: <1351618965-16761-4-git-send-email-yinghai@kernel.org>
References: <20121030040237.GA10472@google.com>
	<1351618965-16761-1-git-send-email-yinghai@kernel.org>
	<1351618965-16761-4-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 30 Oct 2012 10:42:40 -0700
Yinghai Lu <yinghai@kernel.org> wrote:

> So could use assign_unassigned_bus_res pci root bus add

  This description doesn't match the following patch...
  This is for 4/8?

> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
>  drivers/pci/probe.c     |    1 +
>  drivers/pci/setup-bus.c |    2 --
>  2 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 65f62e3..59cf1ba 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1905,6 +1905,7 @@ unsigned int __ref pci_rescan_bus(struct pci_bus *bus)
>  
>  	max = pci_scan_child_bus(bus);
>  	pci_assign_unassigned_bus_resources(bus);
> +	pci_enable_bridges(bus);
>  	pci_bus_add_devices(bus);
>  
>  	return max;
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 59e6c55..6d3591d 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1566,6 +1566,4 @@ void pci_assign_unassigned_bus_resources(struct pci_bus *bus)
>  	up_read(&pci_bus_sem);
>  	__pci_bus_assign_resources(bus, &add_list, NULL);
>  	BUG_ON(!list_empty(&add_list));
> -
> -	pci_enable_bridges(bus);
>  }
> -- 
> 1.7.7
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Taku Izumi <izumi.taku@jp.fujitsu.com>

