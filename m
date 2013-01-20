Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH v9 08/11] PCI, ACPI: debug print for installation of acpi root bridge's notifier
Date: Mon, 21 Jan 2013 00:00:57 +0100
Message-ID: <2506887.8XgRPLTxfQ@vostro.rjw.lan>
In-Reply-To: <1358495602-22867-9-git-send-email-yinghai@kernel.org>
References: <1358495602-22867-1-git-send-email-yinghai@kernel.org> <1358495602-22867-9-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, January 17, 2013 11:53:19 PM Yinghai Lu wrote:
> From: Tang Chen <tangchen@cn.fujitsu.com>
> 
> acpi_install_notify_handler() could fail. So check the exit status
> and give a better debug info.
> 
> Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
>  drivers/acpi/pci_root.c |   12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 3ce5d80..f3ceb61 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -762,6 +762,7 @@ static void handle_hotplug_event_root(acpi_handle handle, u32 type,
>  static acpi_status __init
>  find_root_bridges(acpi_handle handle, u32 lvl, void *context, void **rv)
>  {
> +	acpi_status status;
>  	char objname[64];
>  	struct acpi_buffer buffer = { .length = sizeof(objname),
>  				      .pointer = objname };
> @@ -774,9 +775,14 @@ find_root_bridges(acpi_handle handle, u32 lvl, void *context, void **rv)
>  
>  	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
>  
> -	acpi_install_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
> -				handle_hotplug_event_root, NULL);
> -	printk(KERN_DEBUG "acpi root: %s notify handler installed\n", objname);
> +	status = acpi_install_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
> +					handle_hotplug_event_root, NULL);
> +	if (ACPI_FAILURE(status))
> +		printk(KERN_DEBUG "acpi root: %s notify handler is not installed, exit status: %u\n",

Can you break that line, please?  And use pr_debug()?

> +				  objname, (unsigned int)status);
> +	else
> +		printk(KERN_DEBUG "acpi root: %s notify handler is installed\n",
> +				 objname);
>  
>  	return AE_OK;
>  }

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
