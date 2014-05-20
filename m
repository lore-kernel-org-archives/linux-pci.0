Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:32777 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbaETVD5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 20 May 2014 17:03:57 -0400
Received: by mail-ig0-f181.google.com with SMTP id h3so1294115igd.8
        for <linux-pci@vger.kernel.org>; Tue, 20 May 2014 14:03:56 -0700 (PDT)
Date: Tue, 20 May 2014 15:03:53 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, nic_swsd@realtek.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: quirk RTL8110SC INTx masking
Message-ID: <20140520210353.GB22821@google.com>
References: <20140501203525.27822.98248.stgit@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140501203525.27822.98248.stgit@bling.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 01, 2014 at 02:36:31PM -0600, Alex Williamson wrote:
> INTx masking does not work on this device.  To see this, configure
> the network device UP on an active network, note that the interrupt
> count continues to increment for the device in /proc/interrupts.  Use
> setpci to set the PCI_COMMAND_INTX_DISABLE bit in the PCI_COMMAND
> register.  As expected, the interrupt count ceases to increment.
> However, reading the PCI_STATUS_INTERRUPT bit of the PCI_STATUS
> register does not indicate that interrupts are pending and clearing
> PCI_COMMAND_INTX_DISABLE in the PCI_COMMAND register does not allow
> the device to continue operation.
> 
> This does not affect operation of the host r8169 driver, but it does
> prevent the device from being functional when assigned to a VM, such
> as with QEMU and VFIO.  The guest driver successfully probes the
> device, but there is no traffic.  Mark INTx masking as broken,
> allowing the more restrictive APIC masking to be used instead.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Applied to pci/virtualization for v3.16, thanks.

> ---
>  drivers/pci/quirks.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index ea55b0f..e15a5da 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2991,6 +2991,14 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CHELSIO, 0x0030,
>  			 quirk_broken_intx_masking);
>  DECLARE_PCI_FIXUP_HEADER(0x1814, 0x0601, /* Ralink RT2800 802.11n PCI */
>  			 quirk_broken_intx_masking);
> +/*
> + * Realtek RTL8169 PCI Gigabit Ethernet Controller (rev 10)
> + * Subsystem: Realtek RTL8169/8110 Family PCI Gigabit Ethernet NIC
> + *
> + * RTL8110SC - Fails under PCI device assignment using DisINTx masking.
> + */
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_REALTEK, 0x8169,
> +			 quirk_broken_intx_masking);
>  
>  static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f,
>  			  struct pci_fixup *end)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
