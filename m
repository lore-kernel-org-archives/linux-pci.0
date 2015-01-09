Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:64510 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803AbbAIR1a (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jan 2015 12:27:30 -0500
Received: by mail-oi0-f46.google.com with SMTP id a3so12819485oib.5
        for <linux-pci@vger.kernel.org>; Fri, 09 Jan 2015 09:27:29 -0800 (PST)
Date: Fri, 9 Jan 2015 10:27:26 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] PCI: Generate uppercase hex for modalias var in uevent
Message-ID: <20150109172726.GC6575@google.com>
References: <1417538104-27341-1-git-send-email-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1417538104-27341-1-git-send-email-ricardo.ribalda@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 02, 2014 at 05:35:04PM +0100, Ricardo Ribalda Delgado wrote:
> Some implementations of modprobe fail to load the driver for a PCI device
> automatically because the "interface" part of the modalias from the kernel
> is lowercase, and the modalias from file2alias is uppercase.
> 
> The "interface" is the low-order byte of the Class Code, defined in PCI
> r3.0, Appendix D.  Most interface types defined in the spec do not use
> alpha characters, so they won't be affected.  For example, 00h, 01h, 10h,
> 20h, etc. are unaffected.
> 
> Print the "interface" byte of the Class Code in uppercase hex, as we
> already do for the Vendor ID, Device ID, Class, etc.
> 
> Commit 89ec3dcf17fd ("PCI: Generate uppercase hex for modalias
> interface class") fixed only half of the problem. Some udev
> implementations relays on the uevent file and not in the modalias file.
> 
> CC: Bjorn Helgaas <bhelgaas@google.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Fixes: d1ded203adf1 ("PCI: add MODALIAS to hotplug event for pci devices")
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

Applied with Greg's ack to pci/enumeration for v3.20, thanks!

> ---
> 
> Modified line is >80 char, but I believe that it is better than breaking
> the string or indent it bad.
> 
>  drivers/pci/pci-driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 2b3c894..b720e78 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1389,7 +1389,7 @@ static int pci_uevent(struct device *dev, struct kobj_uevent_env *env)
>  	if (add_uevent_var(env, "PCI_SLOT_NAME=%s", pci_name(pdev)))
>  		return -ENOMEM;
>  
> -	if (add_uevent_var(env, "MODALIAS=pci:v%08Xd%08Xsv%08Xsd%08Xbc%02Xsc%02Xi%02x",
> +	if (add_uevent_var(env, "MODALIAS=pci:v%08Xd%08Xsv%08Xsd%08Xbc%02Xsc%02Xi%02X",
>  			   pdev->vendor, pdev->device,
>  			   pdev->subsystem_vendor, pdev->subsystem_device,
>  			   (u8)(pdev->class >> 16), (u8)(pdev->class >> 8),
> -- 
> 2.1.3
> 
