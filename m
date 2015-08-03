Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lb1-smtp-cloud3.xs4all.net ([194.109.24.22]:55429 "EHLO
	lb1-smtp-cloud3.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751756AbbHCJSR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2015 05:18:17 -0400
Message-ID: <1438593492.3726.13.camel@tiscali.nl>
Subject: Re: [PATCH 4/4] drivers:pci:hv: New paravirtual PCI front-end for
 Hyper-V VMs
From: Paul Bolle <pebolle@tiscali.nl>
To: jakeo@microsoft.com
Cc: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	linux-pci@vger.kernel.org, bhelgaas@google.com, tglx@linutronix.de
Date: Mon, 03 Aug 2015 11:18:12 +0200
In-Reply-To: <1438476889-19220-5-git-send-email-jakeo@microsoft.com>
References: <1438476889-19220-1-git-send-email-jakeo@microsoft.com>
	 <1438476889-19220-5-git-send-email-jakeo@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On zo, 2015-08-02 at 00:54 +0000, jakeo@microsoft.com wrote:
> --- /dev/null
> +++ b/drivers/pci/host/hv_pcifront.c

> +static void exit_hv_pci_drv(void)
> +{
> +	vmbus_driver_unregister(&hv_pci_drv);
> +}
> +
> +static int __init init_hv_pci_drv(void)
> +{
> +	int ret;
> +
> +	/* Register this driver with VMBus. */
> +	ret = vmbus_driver_register(&hv_pci_drv);
> +
> +	if (ret < 0)
> +		exit_hv_pci_drv();
> +
> +	return ret;
> +}

Wouldn't just
    static int __init init_hv_pci_drv(void)
    {
    	return vmbus_driver_register(&hv_pci_drv);
    }

suffice here? That would also allow to mark exit_hv_pci_drv() with
__exit.

> +module_init(init_hv_pci_drv);
> +module_exit(exit_hv_pci_drv);

Thanks,


Paul Bolle
