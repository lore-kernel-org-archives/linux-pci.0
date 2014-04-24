Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:40905 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758755AbaDXWsF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Apr 2014 18:48:05 -0400
Received: by mail-pb0-f42.google.com with SMTP id un15so2480950pbc.1
        for <linux-pci@vger.kernel.org>; Thu, 24 Apr 2014 15:48:04 -0700 (PDT)
Date: Thu, 24 Apr 2014 16:48:02 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Rajat Jain <rajatxjain@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	Rajat Jain <rajatjain@juniper.net>,
	Guenter Roeck <groeck@juniper.net>
Subject: Re: [PATCH] pciehp: Acknowledge the spurious "cmd completed" event.
Message-ID: <20140424224802.GL29593@google.com>
References: <5306AF07.6000601@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5306AF07.6000601@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 20, 2014 at 05:42:31PM -0800, Rajat Jain wrote:
> In case of a spurious "cmd completed", pcie_write_cmd() does not
> clear it, but yet expects more "cmd completed" events to be generated.
> This does not happen because the previous (spurious) event has not
> been acknowledged. Fix that.
> 
> Signed-off-by: Rajat Jain <rajatxjain@gmail.com>
> Signed-off-by: Rajat Jain <rajatjain@juniper.net>
> Signed-off-by: Guenter Roeck <groeck@juniper.net>

Applied to pci/hotplug for v3.16, thanks!

> ---
>  drivers/pci/hotplug/pciehp_hpc.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index d7d058f..1463412 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -159,6 +159,8 @@ static void pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
>  
>  	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
>  	if (slot_status & PCI_EXP_SLTSTA_CC) {
> +		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
> +					   PCI_EXP_SLTSTA_CC);
>  		if (!ctrl->no_cmd_complete) {
>  			/*
>  			 * After 1 sec and CMD_COMPLETED still not set, just
> -- 
> 1.7.9.5
> 
