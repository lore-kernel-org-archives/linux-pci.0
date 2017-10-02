Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32817 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbdJBERD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Oct 2017 00:17:03 -0400
Received: by mail-pf0-f193.google.com with SMTP id m28so4286497pfi.0
        for <linux-pci@vger.kernel.org>; Sun, 01 Oct 2017 21:17:03 -0700 (PDT)
Date: Sun, 1 Oct 2017 21:17:01 -0700
From: Yinghai Lu <yinghai@kernel.org>
To: Zhou Wang <wangzhou1@hisilicon.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH] PCI: Fix prefetchable range broken in
 pci_bridge_check_ranges
Message-ID: <20171002041700.GA3834@localhost.localdomain>
References: <1506151482-113560-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1506151482-113560-1-git-send-email-wangzhou1@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Sep 23, 2017 at 03:24:42PM +0800, Zhou Wang wrote:
>                                         -> pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32, 0xffffffff)
> 
> This will change the prefetch range of 00:00.0 in a time slot, so traffic of
> 01:00.0 or 01:00.1 may be broken.
> 
> In fact, we can get if one bridge supports 64bit range by the bottom 4bits of
> prefetchable memory base/limit. Honestly speaking, I don't know why 1f82de10d6b1
> ("PCI/86: don't assume prefetchable ranges are 64bit") has added the double
> check code.

some chip even that flags say that 64bit is support from that bits, but its upper 32 bits
actually can not be changed.

> 
> So Can we remove the double checking of prefetchable range to avoid this problem?
> 
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> ---
>  drivers/pci/setup-bus.c | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 958da7d..23010a9 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -778,20 +778,6 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
>  			b_res[2].flags |= PCI_PREF_RANGE_TYPE_64;
>  		}
>  	}
> -
> -	/* double check if bridge does support 64 bit pref */
> -	if (b_res[2].flags & IORESOURCE_MEM_64) {
> -		u32 mem_base_hi, tmp;
> -		pci_read_config_dword(bridge, PCI_PREF_BASE_UPPER32,
> -					 &mem_base_hi);
> -		pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32,
> -					       0xffffffff);
> -		pci_read_config_dword(bridge, PCI_PREF_BASE_UPPER32, &tmp);
> -		if (!tmp)
> -			b_res[2].flags &= ~IORESOURCE_MEM_64;
> -		pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32,
> -				       mem_base_hi);
> -	}
>  }
>  
>  /* Helper function for sizing routines: find first available

Maybe we can try this: only touch upper 32bits after we touched low 32bits ?

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 958da7db9033..2ac4d20e5c11 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -744,6 +744,7 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
 	u32 pmem;
 	struct pci_dev *bridge = bus->self;
 	struct resource *b_res;
+	int pref_memory_base_touched = 0;
 
 	b_res = &bridge->resource[PCI_BRIDGE_RESOURCES];
 	b_res[1].flags |= IORESOURCE_MEM;
@@ -769,6 +770,7 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
 					       0xffe0fff0);
 		pci_read_config_dword(bridge, PCI_PREF_MEMORY_BASE, &pmem);
 		pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE, 0x0);
+		pref_memory_base_touched = 1;
 	}
 	if (pmem) {
 		b_res[2].flags |= IORESOURCE_MEM | IORESOURCE_PREFETCH;
@@ -780,7 +782,7 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
 	}
 
 	/* double check if bridge does support 64 bit pref */
-	if (b_res[2].flags & IORESOURCE_MEM_64) {
+	if (pref_memory_base_touched && b_res[2].flags & IORESOURCE_MEM_64) {
 		u32 mem_base_hi, tmp;
 		pci_read_config_dword(bridge, PCI_PREF_BASE_UPPER32,
 					 &mem_base_hi);
