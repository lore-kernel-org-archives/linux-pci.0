Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout1.hostsharing.net ([83.223.95.100]:57531 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeHIUYS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Aug 2018 16:24:18 -0400
Date: Thu, 9 Aug 2018 19:58:19 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] pci/sriov: Hold rescan lock while enumerating
Message-ID: <20180809175819.42j6laq5gxtpnlxy@wunner.de>
References: <20180809163356.18650-1-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180809163356.18650-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 09, 2018 at 10:33:56AM -0600, Keith Busch wrote:
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -591,6 +591,7 @@ static ssize_t sriov_numvfs_store(struct device *dev,
>  	if (num_vfs > pci_sriov_get_totalvfs(pdev))
>  		return -ERANGE;
>  
> +	pci_lock_rescan_remove();
>  	device_lock(&pdev->dev);

Doesn't this obviate the need to hold the device_lock()?  What could
otherwise run concurrently that doesn't hold pci_lock_rescan_remove()
and would cause a race condition?

Thanks,

Lukas
