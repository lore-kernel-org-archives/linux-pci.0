Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 3/8] PCI: acpiphp: enable_device(): rescan even if no new devices on slot
Date: Thu, 11 Jul 2013 02:25:42 +0200
Message-ID: <1827270.u1sYdQ8l8y@vostro.rjw.lan>
In-Reply-To: <1372860295-8306-4-git-send-email-mika.westerberg@linux.intel.com>
References: <1372860295-8306-1-git-send-email-mika.westerberg@linux.intel.com> <1372860295-8306-4-git-send-email-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, July 03, 2013 05:04:50 PM Mika Westerberg wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> pci_scan_slot() returns number of new devices connected *directly*
> connected to the slot. Current enable_device() checks the return value
> and stops if it doesn't see a new device.
> 
> In Thunderbolt chaining case the new device can be deeper in hierarchy, so
> do the rescan anyway.
> 
> Because of that we must make sure that pcibios_resource_survey_bus() and
> check_hotplug_bridge() get called only for a just found bus and not the
> ones already added to the system. Failure to do so will lead to resource
> conflicts.

Well, I wonder what we're doing to this end, because there's nothing in that
area in the patch?

> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index b983e29..0f4da3b 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -685,18 +685,13 @@ static int __ref enable_device(struct acpiphp_slot *slot)
>  	struct pci_dev *dev;
>  	struct pci_bus *bus = slot->bridge->pci_bus;
>  	struct acpiphp_func *func;
> -	int num, max, pass;
> +	int max, pass;
>  	LIST_HEAD(add_list);
>  
>  	list_for_each_entry(func, &slot->funcs, sibling)
>  		acpiphp_bus_add(func);
>  
> -	num = pci_scan_slot(bus, PCI_DEVFN(slot->device, 0));
> -	if (num == 0) {
> -		/* Maybe only part of funcs are added. */
> -		dbg("No new device found\n");
> -		goto err_exit;
> -	}
> +	pci_scan_slot(bus, PCI_DEVFN(slot->device, 0));
>  	max = acpiphp_max_busnr(bus);
>  	for (pass = 0; pass < 2; pass++) {
> @@ -742,8 +737,6 @@ static int __ref enable_device(struct acpiphp_slot *slot)
>  		}
>  	}
>  
> -
> - err_exit:
>  	return 0;
>  }
>  
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
