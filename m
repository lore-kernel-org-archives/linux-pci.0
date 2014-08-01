Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59859 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721AbaHAEGe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 1 Aug 2014 00:06:34 -0400
Message-ID: <1406865990.2963.167.camel@ul30vt.home>
Subject: Re: [PATCH] PCI: Mark broken INTx masking for Mellanox devices
From: Alex Williamson <alex.williamson@redhat.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org
Date: Thu, 31 Jul 2014 22:06:30 -0600
In-Reply-To: <1406865063-24775-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1406865063-24775-1-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2014-08-01 at 13:51 +1000, Gavin Shan wrote:
> The VFIO driver is routing LSI interrupts by capturing, masking,
> and then delivering. When passing though Mallanox adapters from
> host to guest, interrupt storm was reported from host and guest.
> That's because we can't mask the LSI interrupt with help of PCI
> command register.
> 
> The patch marks broken INTx masking for Mellanox devices so that
> the VFIO driver will always mask the interrupt from interrupt
> controller side to avoid interrupt storm.
> 
> Suggested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  drivers/pci/quirks.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index d0f6926..8c2b96f 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2977,6 +2977,10 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CHELSIO, 0x0030,
>  			 quirk_broken_intx_masking);
>  DECLARE_PCI_FIXUP_HEADER(0x1814, 0x0601, /* Ralink RT2800 802.11n PCI */
>  			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0x1003,
> +			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0x6750,
> +			 quirk_broken_intx_masking);
>  /*
>   * Realtek RTL8169 PCI Gigabit Ethernet Controller (rev 10)
>   * Subsystem: Realtek RTL8169/8110 Family PCI Gigabit Ethernet NIC

Is there an lspci description for the devices that we can also include?
You might also want to cc the driver maintainers to see if they're aware
or have any comments.  Thanks,

Alex

