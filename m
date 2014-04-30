Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:45807 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758944AbaD3Uw3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Apr 2014 16:52:29 -0400
Received: by mail-ig0-f172.google.com with SMTP id uy17so646136igb.5
        for <linux-pci@vger.kernel.org>; Wed, 30 Apr 2014 13:52:29 -0700 (PDT)
Date: Wed, 30 Apr 2014 14:52:27 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] pci: remove pcibios_add_platform_entries
Message-ID: <20140430205227.GA30412@google.com>
References: <alpine.LFD.2.11.1404171947150.1588@denkbrett>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LFD.2.11.1404171947150.1588@denkbrett>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 17, 2014 at 07:48:07PM +0200, Sebastian Ott wrote:
> Remove pcibios_add_platform_entries. Architecture specific attributes
> can be achieved by setting pdev->dev.groups .
> 
> Link: https://lkml.kernel.org/r/alpine.LFD.2.11.1404141101500.1529@denkbrett
> Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>

I cherry-picked 8e209e424f8b ("s390/pci: use pdev->dev.groups for attribute
creation") from Martin's tree and then applied this with Greg's ack to
pci/misc for v3.16.  Thanks!

> ---
>  drivers/pci/pci-sysfs.c |   10 ----------
>  include/linux/pci.h     |    1 -
>  2 files changed, 11 deletions(-)
> 
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1272,11 +1272,6 @@ static struct bin_attribute pcie_config_
>  	.write = pci_write_config,
>  };
>  
> -int __weak pcibios_add_platform_entries(struct pci_dev *dev)
> -{
> -	return 0;
> -}
> -
>  static ssize_t reset_store(struct device *dev,
>  			   struct device_attribute *attr, const char *buf,
>  			   size_t count)
> @@ -1392,11 +1387,6 @@ int __must_check pci_create_sysfs_dev_fi
>  		pdev->rom_attr = attr;
>  	}
>  
> -	/* add platform-specific attributes */
> -	retval = pcibios_add_platform_entries(pdev);
> -	if (retval)
> -		goto err_rom_file;
> -
>  	/* add sysfs entries for various capabilities */
>  	retval = pci_create_capabilities_sysfs(pdev);
>  	if (retval)
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1572,7 +1572,6 @@ extern unsigned long pci_hotplug_io_size
>  extern unsigned long pci_hotplug_mem_size;
>  
>  /* Architecture-specific versions may override these (weak) */
> -int pcibios_add_platform_entries(struct pci_dev *dev);
>  void pcibios_disable_device(struct pci_dev *dev);
>  void pcibios_set_master(struct pci_dev *dev);
>  int pcibios_set_pcie_reset_state(struct pci_dev *dev,
> 
