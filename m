Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755162AbeD3VEZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Apr 2018 17:04:25 -0400
Date: Mon, 30 Apr 2018 16:04:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Matthew Wilcox <matthew@wil.cx>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: ibmphp: fix get_max_bus_speed()
Message-ID: <20180430210423.GF95643@bhelgaas-glaptop.roam.corp.google.com>
References: <20180419100549.GA10672@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180419100549.GA10672@mwanda>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 19, 2018 at 01:05:49PM +0300, Dan Carpenter wrote:
> The "rc" variable is only initialized on the error path.  The caller
> doesn't check the return but, if "rc" is non-zero, then this function is
> basically a no-op.
> 
> Fixes: 3749c51ac6c1 ("PCI: Make current and maximum bus speeds part of the PCI core")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied to pci/hotplug for v4.18, thanks!

> diff --git a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
> index b81ca3fa0e84..1869b0411ce0 100644
> --- a/drivers/pci/hotplug/ibmphp_core.c
> +++ b/drivers/pci/hotplug/ibmphp_core.c
> @@ -379,7 +379,7 @@ static int get_adapter_present(struct hotplug_slot *hotplug_slot, u8 *value)
>  
>  static int get_max_bus_speed(struct slot *slot)
>  {
> -	int rc;
> +	int rc = 0;
>  	u8 mode = 0;
>  	enum pci_bus_speed speed;
>  	struct pci_bus *bus = slot->hotplug_slot->pci_slot->bus;
