Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34769 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932596AbaKMRkh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Nov 2014 12:40:37 -0500
Received: by mail-pa0-f41.google.com with SMTP id rd3so1140883pab.28
        for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2014 09:40:36 -0800 (PST)
Date: Thu, 13 Nov 2014 10:40:30 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Remove to_hotplug_slot()
Message-ID: <20141113174030.GK5064@google.com>
References: <1415760232-12748-1-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1415760232-12748-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 12, 2014 at 01:43:52PM +1100, Gavin Shan wrote:
> struct hotplug_slot doesn't have kobj. to_hotplug_slot(), which
> intends converts kobj to hotplug slot, isn't valid any more.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to pci/hotplug for v3.19, thanks!

> ---
>  include/linux/pci_hotplug.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
> index 2706ee9..8c78950 100644
> --- a/include/linux/pci_hotplug.h
> +++ b/include/linux/pci_hotplug.h
> @@ -109,7 +109,6 @@ struct hotplug_slot {
>  	struct list_head		slot_list;
>  	struct pci_slot			*pci_slot;
>  };
> -#define to_hotplug_slot(n) container_of(n, struct hotplug_slot, kobj)
>  
>  static inline const char *hotplug_slot_name(const struct hotplug_slot *slot)
>  {
> -- 
> 1.8.3.2
> 
