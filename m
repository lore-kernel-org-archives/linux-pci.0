Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:38979 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759555Ab2COIjr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 15 Mar 2012 04:39:47 -0400
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 2FB1C3EE0BC
	for <linux-pci@vger.kernel.org>; Thu, 15 Mar 2012 17:39:46 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 1961145DE50
	for <linux-pci@vger.kernel.org>; Thu, 15 Mar 2012 17:39:46 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 0207145DD74
	for <linux-pci@vger.kernel.org>; Thu, 15 Mar 2012 17:39:46 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id E9E7C1DB803F
	for <linux-pci@vger.kernel.org>; Thu, 15 Mar 2012 17:39:45 +0900 (JST)
Received: from m106.s.css.fujitsu.com (m106.s.css.fujitsu.com [10.240.81.146])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 957FC1DB8038
	for <linux-pci@vger.kernel.org>; Thu, 15 Mar 2012 17:39:45 +0900 (JST)
From: "Taku Izumi" <izumi.taku@jp.fujitsu.com>
To: "'Yinghai Lu'" <yinghai@kernel.org>
Cc: <linux-pci@vger.kernel.org>
References: <1330570837-26638-1-git-send-email-yinghai@kernel.org> <1330570837-26638-3-git-send-email-yinghai@kernel.org>
In-Reply-To: <1330570837-26638-3-git-send-email-yinghai@kernel.org>
Subject: RE: [PATCH 02/36] x86, PCI: Fix memleak with get_current_resources
Date: Thu, 15 Mar 2012 17:39:43 +0900
Message-ID: <0bec01cd0287$2b74ae40$825e0ac0$@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-owner@vger.kernel.org] On Behalf Of Yinghai Lu
> Sent: Thursday, March 01, 2012 12:00 PM
> To: Jesse Barnes; Benjamin Herrenschmidt; Tony Luck; David Miller; x86
> Cc: Bjorn Helgaas; Dominik Brodowski; linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-arch@vger.kernel.org; Yinghai Lu
> Subject: [PATCH 02/36] x86, PCI: Fix memleak with get_current_resources
> 
> in pci_scan_acpi_root, when pci_use_crs is set, get_current_resources is used
> to get pci_root_info, and it will allocate name and res array.
> 
> later if pci_create_root_bus can not create bus (could be already there...)
> it will only free bus res list. but the name and res array is not freed.
> 
> let get_current_resource take info pointer instead have local info.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
>  arch/x86/pci/acpi.c |   49 ++++++++++++++++++++++++++++++-------------------
>  1 files changed, 30 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index 7cc0a44..304ccf0 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -305,49 +305,55 @@ static void add_resources(struct pci_root_info *info)
>  	}
>  }
> 
> +static void free_pci_root_info(struct pci_root_info *info)
> +{
> +	kfree(info->name);
> +	kfree(info->res);
> +	memset(info, 0, sizeof(struct pci_root_info));
> +}
> +

  This function leads to misunderstanding.
  I'm convinced that the function of the name starts with "free" 
  should free resources completely.


>  static void
> -get_current_resources(struct acpi_device *device, int busnum,
> +get_current_resources(struct pci_root_info *info,
> +		      struct acpi_device *device, int busnum,
>  		      int domain, struct list_head *resources)
>  {
> -	struct pci_root_info info;
>  	size_t size;
> 
> -	info.bridge = device;
> -	info.res_num = 0;
> -	info.resources = resources;
> +	info->bridge = device;
> +	info->res_num = 0;
> +	info->resources = resources;
>  	acpi_walk_resources(device->handle, METHOD_NAME__CRS, count_resource,
> -				&info);
> -	if (!info.res_num)
> +				info);
> +	if (!info->res_num)
>  		return;
> 
> -	size = sizeof(*info.res) * info.res_num;
> -	info.res = kmalloc(size, GFP_KERNEL);
> -	if (!info.res)
> +	size = sizeof(*info->res) * info->res_num;
> +	info->res = kmalloc(size, GFP_KERNEL);
> +	if (!info->res)
>  		return;
> 
> -	info.name = kasprintf(GFP_KERNEL, "PCI Bus %04x:%02x", domain, busnum);
> -	if (!info.name)
> +	info->name = kasprintf(GFP_KERNEL, "PCI Bus %04x:%02x", domain, busnum);
> +	if (!info->name)
>  		goto name_alloc_fail;
> 
> -	info.res_num = 0;
> +	info->res_num = 0;
>  	acpi_walk_resources(device->handle, METHOD_NAME__CRS, setup_resource,
> -				&info);
> +				info);
> 
>  	if (pci_use_crs) {
> -		add_resources(&info);
> +		add_resources(info);
> 
>  		return;
>  	}
> 
> -	kfree(info.name);
> -
>  name_alloc_fail:
> -	kfree(info.res);
> +	free_pci_root_info(info);
>  }
> 
>  struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_pci_root *root)
>  {
>  	struct acpi_device *device = root->device;
> +	struct pci_root_info info;
>  	int domain = root->segment;
>  	int busnum = root->secondary.start;
>  	LIST_HEAD(resources);
> @@ -392,6 +398,7 @@ struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_pci_root *root)
> 
>  	sd->domain = domain;
>  	sd->node = node;
> +	memset(&info, 0, sizeof(struct pci_root_info));
>  	/*
>  	 * Maybe the desired pci bus has been already scanned. In such case
>  	 * it is unnecessary to scan the pci bus with the given domain,busnum.
> @@ -405,7 +412,8 @@ struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_pci_root *root)
>  		memcpy(bus->sysdata, sd, sizeof(*sd));
>  		kfree(sd);
>  	} else {
> -		get_current_resources(device, busnum, domain, &resources);
> +		get_current_resources(&info, device, busnum, domain,
> +					&resources);
> 
>  		/*
>  		 * _CRS with no apertures is normal, so only fall back to
> @@ -419,6 +427,9 @@ struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_pci_root *root)
>  			bus->subordinate = pci_scan_child_bus(bus);
>  		else
>  			pci_free_resource_list(&resources);
> +
> +		if (!bus && pci_use_crs)
> +			free_pci_root_info(&info);
>  	}
> 
>  	/* After the PCI-E bus has been walked and all devices discovered,
> --
> 1.7.7
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


