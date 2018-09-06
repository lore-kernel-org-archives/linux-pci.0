Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout1.hostsharing.net ([83.223.95.100]:40161 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbeIFRNd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Sep 2018 13:13:33 -0400
Date: Thu, 6 Sep 2018 14:38:14 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2 13/20] PCI: Make link active reporting detection generic
Message-ID: <20180906123814.nkpmhce62oonet2s@wunner.de>
References: <20180905203546.21921-1-keith.busch@intel.com>
 <20180905203546.21921-14-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180905203546.21921-14-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 05, 2018 at 02:35:39PM -0600, Keith Busch wrote:
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -121,7 +121,6 @@ struct controller {
> 	struct task_struct *poll_thread;
> 	unsigned long cmd_started;	/* jiffies */
> 	unsigned int cmd_busy:1;
> -	unsigned int link_active_reporting:1;
> 	unsigned int notification_enabled:1;
> 	unsigned int power_fault_detected;
> 	atomic_t pending_events;

Please also remove the kerneldoc for this attribute further up in the file.


> @@ -256,18 +249,9 @@ int pciehp_check_link_status(struct controller *ctrl)
>  	bool found;
>  	u16 lnk_status;
>  
> -	/*
> -	 * Data Link Layer Link Active Reporting must be capable for
> -	 * hot-plug capable downstream port. But old controller might
> -	 * not implement it. In this case, we wait for 1000 ms.
> -	*/
> -	if (ctrl->link_active_reporting)
> -		pcie_wait_link_active(ctrl);
> -	else
> -		msleep(1000);
> +	if (!pcie_wait_for_link(pdev, true))
> +		return -1;
>  
> -	/* wait 100ms before read pci conf, and try in 1s */
> -	msleep(100);

Aha, so this addresses the second objection I've just raised for
patch [03/20].  Okay.


> +	/*
> +	 * Some controllers might not implement link active reporting. In this
> +	 * case, we wait for 1000 + 100 ms.
> +	 */
> +	if (!pdev->link_active_reporting) {
> +		msleep(1100);
> +		return true;
> +	}
> +

More specifically, the Data Link Layer Link Active Reporting Capable bit
in the Link Capabilities register was added in PCIe r1.1 (2005-03-28).
The bit was marked reserved in PCIe r1.0 (2002-04-29).

So this is perfectly legal for old devices adhering only to PCIe r1.0.

Thanks,

Lukas
