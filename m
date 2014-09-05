Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:52790 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931AbaIEViy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Sep 2014 17:38:54 -0400
Received: by mail-pa0-f47.google.com with SMTP id ey11so899090pad.6
        for <linux-pci@vger.kernel.org>; Fri, 05 Sep 2014 14:38:54 -0700 (PDT)
Date: Fri, 5 Sep 2014 15:38:50 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, amirv@mellanox.com,
	alex.williamson@redhat.com, eli@mellanox.com,
	weiyang@linux.vnet.ibm.com
Subject: Re: [PATCH v3] PCI: Mark broken INTx masking for Mellanox devices
Message-ID: <20140905213850.GH8080@google.com>
References: <1407844091-20815-1-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407844091-20815-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 12, 2014 at 09:48:11PM +1000, Gavin Shan wrote:
> The VFIO driver is routing LSI interrupts by capturing, masking,
> and then delivering. When passing though Mellanox adapters from
> host to guest, interrupt storm was reported from host and guest.
> That's because we can't mask the LSI interrupt with help of PCI
> command register.
> 
>  # lspci | grep Mellanox
>  0001:05:00.0 Ethernet controller: Mellanox Technologies MT27500 \
>               Family [ConnectX-3]
>  0005:01:00.0 Ethernet controller: Mellanox Technologies MT26448 \
>               [ConnectX EN 10GigE, PCIe 2.0 5GT/s] (rev b0)
> 
> It's confirmed by Amir Vadai that all Mellanox devices have same
> problem. The patch marks broken INTx masking for all Mellanox
> adapters.
> 
> Cc: Amir Vadai <amirv@mellanox.com>
> Suggested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

I applied this with Amir's ack to pci/virtualization for v3.18.

It's possible Mellanox will someday make a device where INTx masking works.
I guess we'll have to deal with that if and when it happens.

> ---
> v3: Mark broken INTx masking for all Mellanox adapters
> ---
>  drivers/pci/quirks.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 80c2d01..da062d8 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2985,6 +2985,8 @@ DECLARE_PCI_FIXUP_HEADER(0x1814, 0x0601, /* Ralink RT2800 802.11n PCI */
>   */
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_REALTEK, 0x8169,
>  			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, PCI_ANY_ID,
> +			 quirk_broken_intx_masking);
>  
>  #ifdef CONFIG_ACPI
>  /*
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
