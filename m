Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 7 Apr 2016 11:06:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com,
	agross@codeaurora.org, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pci, acpi: free IO resource during shutdown
Message-ID: <20160407160624.GB8780@localhost>
References: <1457389310-3538-1-git-send-email-okaya@codeaurora.org>
 <1457389310-3538-2-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457389310-3538-2-git-send-email-okaya@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sinan,

On Mon, Mar 07, 2016 at 05:21:50PM -0500, Sinan Kaya wrote:
> The ACPI PCI driver is leaking out memory mappings
> when a slot is removed. Upon insertion following a
> removal, we are hitting a BUG statement. Second call
> to the remap API hits a bug statement because the area is
> already mapped. This patch releases additional virtual
> memory mapped by pci_remap_iospace function as part of
> __release_pci_root_info function if the region type is IO.

I don't know what "removing a slot" means.  You're changing
pci_root.c, so I assume this is really an ACPI host bridge removal?

The release should correspond to a mapping, and the changelog should
point out where that mapping happens so we can see the symmetry.

You say this is undoing the effect of pci_remap_iospace(), but that's
only called by native drivers and the generic (OF) driver, not by
pci_root.c.

Please combine this with the previous patch so we have the new
function and its use in the same patch.

>  BUG: failure at kernel/lib/ioremap.c:31/ioremap_pte_range()!
>  Kernel panic - not syncing: BUG!
>  CPU: 1 PID: 630 Comm: kworker/u48:3 Not tainted
>  Workqueue: kacpi_hotplug acpi_hotplug_work_fn Call trace:
>  dump_backtrace+0x0/0x10c [<ffff800000086e58>]
>  show_stack+0x10/0x1c [<ffff8000004d1f50>]
>  dump_stack+0x74/0xc4
>  panic+0xe4/0x21c [<ffff8000002577cc>]
>  ioremap_page_range+0x290/0x30c [<ffff8000002861dc>]
>  pci_remap_iospace+0x88/0xa0 [<ffff8000000908f8>]
>  setup_resource+0x114/0x16c [<ffff8000002c0fc0>]
>  acpi_walk_resource_buffer+0x54/0xb0
>  acpi_walk_resources+0x90/0xbc
>  pci_acpi_scan_root+0x184/0x2d0
>  acpi_pci_root_add+0x368/0x434
>  acpi_bus_attach+0x124/0x22c [<ffff8000002a5628>]
>  acpi_bus_scan+0x58/0x74 [<ffff8000002a57c0>]
>  acpi_device_hotplug+0xc4/0x3f0 [<ffff8000002a0468>]
>  acpi_hotplug_work_fn+0x1c/0x34 [<ffff8000000b9310>]
>  process_one_work+0x1e8/0x308 [<ffff8000000b9b04>]
>  worker_thread+0x294/0x3cc  [<ffff8000000bd9
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/acpi/pci_root.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 71bbfae..6d4bc2d 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -946,6 +946,8 @@ static void acpi_pci_root_release_info(struct pci_host_bridge *bridge)
>  
>  	resource_list_for_each_entry(entry, &bridge->windows) {
>  		res = entry->res;
> +		if (res->flags & IORESOURCE_IO)
> +			pci_unmap_iospace(res);
>  		if (res->parent &&
>  		    (res->flags & (IORESOURCE_MEM | IORESOURCE_IO)))
>  			release_resource(res);
> -- 
> 1.8.2.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
