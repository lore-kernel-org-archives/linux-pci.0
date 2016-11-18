Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752363AbcKRTGI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Nov 2016 14:06:08 -0500
Date: Fri, 18 Nov 2016 13:06:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3] PCI: create revision file in sysfs
Message-ID: <20161118190603.GJ25762@bhelgaas-glaptop.roam.corp.google.com>
References: <20161101154232.6451-1-emil.l.velikov@gmail.com>
 <20161111143723.5818-1-emil.l.velikov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161111143723.5818-1-emil.l.velikov@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 11, 2016 at 02:37:23PM +0000, Emil Velikov wrote:
> From: Emil Velikov <emil.velikov@collabora.com>
> 
> Currently the revision isn't available via sysfs/libudev thus if one
> wants to know the value they need to read through the config file.
> 
> This in itself wakes/powers up the device, causing unwanted delay
> since it can be quite costly.
> 
> There are at least two userspace components which could make use the new
> file libpciaccess and libdrm. The former [used in various places] wakes
> up _every_ PCI device, which can be observed via glxinfo [when using
> Mesa 10.0+ drivers]. While the latter [in association with Mesa 13.0]
> can lead to 2-3 second delays while starting firefox, thunderbird or
> chromium.
> 
> Expose the revision as a separate file, just like we do for the device,
> vendor, their subsystem version and class.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Link: https://bugs.freedesktop.org/show_bug.cgi?id=98502
> Tested-by: Mauro Santos <registo.mailling@gmail.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Emil Velikov <emil.velikov@collabora.com>

Applied with Daniel's reviewed-by to pci/misc for v4.10, thanks.

> ---
> v2: Add r-b/t-b tags, slim down CC list, add note about userspace.
> 
> v3: Add Documentation/ bits (Greg KH)
> 
> Gents, please keep me in the CC list.
> 
> Thanks
> Emil
> ---
>  Documentation/ABI/testing/sysfs-bus-pci | 7 +++++++
>  Documentation/filesystems/sysfs-pci.txt | 2 ++
>  drivers/pci/pci-sysfs.c                 | 2 ++
>  3 files changed, 11 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index b3bc50f..5a1732b 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -294,3 +294,10 @@ Description:
>  		a firmware bug to the system vendor.  Writing to this file
>  		taints the kernel with TAINT_FIRMWARE_WORKAROUND, which
>  		reduces the supportability of your system.
> +
> +What:		/sys/bus/pci/devices/.../revision
> +Date:		November 2016
> +Contact:	Emil Velikov <emil.l.velikov@gmail.com>
> +Description:
> +		This file contains the revision field of the the PCI device.
> +		The value comes from device config space. The file is read only.
> diff --git a/Documentation/filesystems/sysfs-pci.txt b/Documentation/filesystems/sysfs-pci.txt
> index 74eaac2..6ea1ced 100644
> --- a/Documentation/filesystems/sysfs-pci.txt
> +++ b/Documentation/filesystems/sysfs-pci.txt
> @@ -17,6 +17,7 @@ that support it.  For example, a given bus might look like this:
>       |   |-- resource0
>       |   |-- resource1
>       |   |-- resource2
> +     |   |-- revision
>       |   |-- rom
>       |   |-- subsystem_device
>       |   |-- subsystem_vendor
> @@ -41,6 +42,7 @@ files, each with their own function.
>         resource		   PCI resource host addresses (ascii, ro)
>         resource0..N	   PCI resource N, if present (binary, mmap, rw[1])
>         resource0_wc..N_wc  PCI WC map resource N, if prefetchable (binary, mmap)
> +       revision		   PCI revision (ascii, ro)
>         rom		   PCI ROM resource, if present (binary, ro)
>         subsystem_device	   PCI subsystem device (ascii, ro)
>         subsystem_vendor	   PCI subsystem vendor (ascii, ro)
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index bcd10c7..0666287 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -50,6 +50,7 @@ pci_config_attr(vendor, "0x%04x\n");
>  pci_config_attr(device, "0x%04x\n");
>  pci_config_attr(subsystem_vendor, "0x%04x\n");
>  pci_config_attr(subsystem_device, "0x%04x\n");
> +pci_config_attr(revision, "0x%02x\n");
>  pci_config_attr(class, "0x%06x\n");
>  pci_config_attr(irq, "%u\n");
>  
> @@ -568,6 +569,7 @@ static struct attribute *pci_dev_attrs[] = {
>  	&dev_attr_device.attr,
>  	&dev_attr_subsystem_vendor.attr,
>  	&dev_attr_subsystem_device.attr,
> +	&dev_attr_revision.attr,
>  	&dev_attr_class.attr,
>  	&dev_attr_irq.attr,
>  	&dev_attr_local_cpus.attr,
> -- 
> 2.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
