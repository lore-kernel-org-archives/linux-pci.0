Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182]:6600 "EHLO
	ironport2-out.teksavvy.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755106Ab2KUPq1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Nov 2012 10:46:27 -0500
Date: Wed, 21 Nov 2012 10:42:31 -0500 (EST)
From: Scott Murray <scott@spiteful.org>
To: Bill Pemberton <wfp5p@virginia.edu>
cc: gregkh@linuxfoundation.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 088/493] pci: remove use of __devexit_p
In-Reply-To: <1353349642-3677-88-git-send-email-wfp5p@virginia.edu>
Message-ID: <alpine.LFD.2.02.1211211034580.26121@godzilla.spiteful.org>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu> <1353349642-3677-88-git-send-email-wfp5p@virginia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 19 Nov 2012, Bill Pemberton wrote:

> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> needed.
>
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Scott Murray <scott@spiteful.org>
> Cc: linux-pci@vger.kernel.org

Acked-by: Scott Murray <scott@spiteful.org>

> ---
>  drivers/pci/hotplug/cpcihp_zt5550.c | 2 +-
>  drivers/pci/ioapic.c                | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/hotplug/cpcihp_zt5550.c b/drivers/pci/hotplug/cpcihp_zt5550.c
> index 6bf8d2a..34b2a4a 100644
> --- a/drivers/pci/hotplug/cpcihp_zt5550.c
> +++ b/drivers/pci/hotplug/cpcihp_zt5550.c
> @@ -290,7 +290,7 @@ static struct pci_driver zt5550_hc_driver = {
>  	.name		= "zt5550_hc",
>  	.id_table	= zt5550_hc_pci_tbl,
>  	.probe		= zt5550_hc_init_one,
> -	.remove		= __devexit_p(zt5550_hc_remove_one),
> +	.remove		= zt5550_hc_remove_one,
>  };
>
>  static int __init zt5550_init(void)
> diff --git a/drivers/pci/ioapic.c b/drivers/pci/ioapic.c
> index 22436f7..2b24fb4 100644
> --- a/drivers/pci/ioapic.c
> +++ b/drivers/pci/ioapic.c
> @@ -110,7 +110,7 @@ static struct pci_driver ioapic_driver = {
>  	.name		= "ioapic",
>  	.id_table	= ioapic_devices,
>  	.probe		= ioapic_probe,
> -	.remove		= __devexit_p(ioapic_remove),
> +	.remove		= ioapic_remove,
>  };
>
>  static int __init ioapic_init(void)
>

-- 
==============================================================================
Scott Murray, scott@spiteful.org

     "Good, bad ... I'm the guy with the gun." - Ash, "Army of Darkness"
