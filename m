Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732164AbeISUtn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 16:49:43 -0400
Subject: Re: [PATCH 12/12] PCI/pciehp: Use device managed allocations
To: Keith Busch <keith.busch@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20180918235848.26694-1-keith.busch@intel.com>
 <20180918235848.26694-13-keith.busch@intel.com>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <87c363e3-e274-853e-414f-7568c8e16ade@kernel.org>
Date: Wed, 19 Sep 2018 11:11:19 -0400
MIME-Version: 1.0
In-Reply-To: <20180918235848.26694-13-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/18/2018 7:58 PM, Keith Busch wrote:
> -	ctrl->notification_enabled = 1;
>   	return 0;
>   }
>   
>   void pcie_shutdown_notification(struct controller *ctrl)
>   {
> -	if (ctrl->notification_enabled) {
> -		pcie_disable_notification(ctrl);
> -		pciehp_free_irq(ctrl);
> -		ctrl->notification_enabled = 0;
> -	}
> +	pcie_disable_notification(ctrl);
> +	if (pciehp_poll_mode)
> +		kthread_stop(ctrl->poll_thread);
>   }
>   

I think this notification_enabled bit change needs to go to
another path. The rest of the change in this file is pretty mechanic changes.
Also, are you going to remove the notification_enabled member?
