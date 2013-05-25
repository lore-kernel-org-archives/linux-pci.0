Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:38673 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757158Ab3EYQaV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 25 May 2013 12:30:21 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz11so2678458pad.16
        for <linux-pci@vger.kernel.org>; Sat, 25 May 2013 09:30:20 -0700 (PDT)
Message-ID: <51A0E716.9050405@gmail.com>
Date: Sun, 26 May 2013 00:30:14 +0800
From: Liu Jiang <liuj97@gmail.com>
MIME-Version: 1.0
To: Kevin Hao <haokexin@gmail.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: add 0x prefix when printing the BAR registers
 position in __pci_read_base
References: <1369481787-21500-1-git-send-email-haokexin@gmail.com> <1369481787-21500-2-git-send-email-haokexin@gmail.com>
In-Reply-To: <1369481787-21500-2-git-send-email-haokexin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/25/2013 07:36 PM, Kevin Hao wrote:
> We print the BAR registers position in hexadecimal format, so it
> is more readable if 0x prefix is added. Also fix the following
> checkpatch warning:
>    WARNING: Prefer dev_dbg(... to dev_printk(KERN_DEBUG, ...
>
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
> v2: A new patch introduced in v2.
>
>   drivers/pci/probe.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 70f10fa..2505d5e 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -278,9 +278,9 @@ out:
>   		pci_write_config_word(dev, PCI_COMMAND, orig_cmd);
>   
>   	if (bar_too_big)
> -		dev_err(&dev->dev, "reg %x: can't handle 64-bit BAR\n", pos);
> +		dev_err(&dev->dev, "reg 0x%x: can't handle 64-bit BAR\n", pos);
>   	if (res->flags && !bar_disabled)
> -		dev_printk(KERN_DEBUG, &dev->dev, "reg %x: %pR\n", pos, res);
> +		dev_dbg(&dev->dev, "reg 0x%x: %pR\n", pos, res);
Hi Kevin,
     dev_printk(KERN_DEBUG) -> dev_dbg() is not an equivalent change, it 
depends
on CONFIG_DEBUG and CONFIG_DYNAMIC_DEBUG.
Regards!
Gerry

>   
>   	return (res->flags & IORESOURCE_MEM_64) ? 1 : 0;
>   }

