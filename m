Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:47272 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751107AbaHCHxb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 3 Aug 2014 03:53:31 -0400
Message-ID: <53DDE9EC.5040303@mellanox.com>
Date: Sun, 3 Aug 2014 10:51:08 +0300
From: Amir Vadai <amirv@mellanox.com>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, <linux-pci@vger.kernel.org>
CC: <alex.williamson@redhat.com>,
	Yevgeny Petrilin <yevgenyp@mellanox.com>,
	Peter Paneah <peter@mellanox.com>, Eli Cohen <eli@mellanox.com>
Subject: Re: [PATCH v2] PCI: Mark broken INTx masking for Mellanox devices
References: <1406868871-350-1-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1406868871-350-1-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/1/2014 7:54 AM, Gavin Shan wrote:
> The VFIO driver is routing LSI interrupts by capturing, masking,
> and then delivering. When passing though Mallanox adapters from
> host to guest, interrupt storm was reported from host and guest.
> That's because we can't mask the LSI interrupt with help of PCI
> command register.
Hi Gavin,

What is the problem with masking the interrupts with the PCI command
register? I'm asking because I want to understand in which devices we
have the problem, and if it could be fixed by firmware guys.
What are the implications of having the quirk?

> 
> [root@ncc-1701 ~]# lspci | grep Mellanox
> 0001:05:00.0 Ethernet controller: Mellanox Technologies MT27500 \
>              Family [ConnectX-3]
> 0005:01:00.0 Ethernet controller: Mellanox Technologies MT26448 \
>              [ConnectX EN 10GigE, PCIe 2.0 5GT/s] (rev b0)
> 
> The patch marks broken INTx masking for Mellanox devices so that
> the VFIO driver will always mask the interrupt from interrupt
> controller side to avoid interrupt storm.
> 
> Cc: Amir Vadai <amirv@mellanox.com>
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
I still don't understand what exactly is the problem, but I assume that
there are other Mellanox devices that suffer from it.

>  /*
>   * Realtek RTL8169 PCI Gigabit Ethernet Controller (rev 10)
>   * Subsystem: Realtek RTL8169/8110 Family PCI Gigabit Ethernet NIC
> 

Thanks,
Amir
