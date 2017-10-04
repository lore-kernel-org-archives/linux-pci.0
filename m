Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751132AbdJDToL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Oct 2017 15:44:11 -0400
Date: Wed, 4 Oct 2017 14:44:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Create iov virtfn/physfn links before attaching
 driver
Message-ID: <20171004194408.GJ25517@bhelgaas-glaptop.roam.corp.google.com>
References: <d3328861-2da2-918d-c3db-cc0795ab1586@gmail.com>
 <20170926205745.GR15970@bhelgaas-glaptop.roam.corp.google.com>
 <45746aaf-656c-3ca7-9c11-55607a8154d2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45746aaf-656c-3ca7-9c11-55607a8154d2@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 04, 2017 at 10:57:52AM -0500, Stuart Hayes wrote:
> When creating virtual functions, create the "virtfn%u" and "physfn" links 
> in sysfs before attaching the driver.  Without this, there is a race when 
> the driver attaches to the new virtual network interface and sends out an 
> "add" udev event, and the network interface naming software (biosdevname
> or systemd, for example) tries to look at these links.
> 
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>

Applied to pci/virtualization for v4.15, thanks!

> ---
> 
> --- linux-4.14-rc1/drivers/pci/iov.c.orig	2017-09-18 15:00:43.168255665 -0500
> +++ linux-4.14-rc1/drivers/pci/iov.c	2017-09-18 15:07:04.792280999 -0500
> @@ -162,7 +162,6 @@ int pci_iov_add_virtfn(struct pci_dev *d
>  
>  	pci_device_add(virtfn, virtfn->bus);
>  
> -	pci_bus_add_device(virtfn);
>  	sprintf(buf, "virtfn%u", id);
>  	rc = sysfs_create_link(&dev->dev.kobj, &virtfn->dev.kobj, buf);
>  	if (rc)
> @@ -173,6 +172,8 @@ int pci_iov_add_virtfn(struct pci_dev *d
>  
>  	kobject_uevent(&virtfn->dev.kobj, KOBJ_CHANGE);
>  
> +	pci_bus_add_device(virtfn);
> +
>  	return 0;
>  
>  failed2:
> 
> ---
> This email has been checked for viruses by Avast antivirus software.
> https://www.avast.com/antivirus
> 
