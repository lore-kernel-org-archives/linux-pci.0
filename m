Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:47593 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758352AbaLKAG6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 10 Dec 2014 19:06:58 -0500
Received: by mail-ig0-f170.google.com with SMTP id r2so8639686igi.3
        for <linux-pci@vger.kernel.org>; Wed, 10 Dec 2014 16:06:57 -0800 (PST)
Date: Wed, 10 Dec 2014 17:06:54 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Scott Murray <scott@spiteful.org>, linux-pci@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org,
	Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 1/1] PCI: hotplug: Deletion of an unnecessary check
 before the function call "pci_dev_put"
Message-ID: <20141211000654.GB22886@google.com>
References: <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <546E1B21.2070206@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <546E1B21.2070206@users.sourceforge.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 20, 2014 at 05:47:29PM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 20 Nov 2014 17:42:23 +0100
> 
> The pci_dev_put() function tests whether its argument is NULL and then
> returns immediately. Thus the test around the call is not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied to next-pci/misc for v3.19, thanks.  This branch will be rebased
when v3.19-rc1 is released.

Bjorn

> ---
>  drivers/pci/hotplug/cpci_hotplug_core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/cpci_hotplug_core.c b/drivers/pci/hotplug/cpci_hotplug_core.c
> index e09cf78..82c969b 100644
> --- a/drivers/pci/hotplug/cpci_hotplug_core.c
> +++ b/drivers/pci/hotplug/cpci_hotplug_core.c
> @@ -211,8 +211,7 @@ static void release_slot(struct hotplug_slot *hotplug_slot)
>  
>  	kfree(slot->hotplug_slot->info);
>  	kfree(slot->hotplug_slot);
> -	if (slot->dev)
> -		pci_dev_put(slot->dev);
> +	pci_dev_put(slot->dev);
>  	kfree(slot);
>  }
>  
> -- 
> 2.1.3
> 
