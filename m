Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cmexedge1.emulex.com ([138.239.224.99]:16476 "EHLO
	CMEXEDGE1.ext.emulex.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845AbbAGE3z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jan 2015 23:29:55 -0500
From: Venkat Duvvuru <VenkatKumar.Duvvuru@Emulex.Com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: Ajit Kumar Khaparde <Ajit.Khaparde@Emulex.Com>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: RE: [PATCH] PCI: Mark broken INTx masking for BENET devices
Date: Wed, 7 Jan 2015 04:29:24 +0000
Message-ID: <be483be7-96b7-4aaf-8c70-5fecb6fcb324@CMEXHTCAS2.ad.emulex.com>
References: <1420424274-3194-1-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1420424274-3194-1-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Can someone please explain, why interrupt storm issue doesn't occur in non-VFIO scenario?

> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
> owner@vger.kernel.org] On Behalf Of Gavin Shan
> Sent: Monday, January 05, 2015 7:48 AM
> To: linux-pci@vger.kernel.org
> Cc: Ajit Kumar Khaparde; bhelgaas@google.com; Gavin Shan
> Subject: [PATCH] PCI: Mark broken INTx masking for BENET devices
> 
> Similar to commit 11e4253 ("PCI: Assume all Mellanox devices have
> broken INTx masking"), when passing through following PCI device
> using VFIO infrastructure, interrupt storm are reported. After
> marking its INTx masking is broken, the interrupt storm isn't
> raised again:
> 
>  # lspci -s 0000::.
>  0000:01:00.0 Ethernet controller: Emulex Corporation \
>               OneConnect 10Gb NIC (be3) (rev 02)
>  0000:01:00.1 Ethernet controller: Emulex Corporation \
>               OneConnect 10Gb NIC (be3) (rev 02)
>  # lspci -n -s 0000::.
>  0000:01:00.0 0200: 19a2:0710 (rev 02)
>  0000:01:00.1 0200: 19a2:0710 (rev 02)
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  drivers/pci/quirks.c    | 2 ++
>  include/linux/pci_ids.h | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index ed6f89b..e823ac0 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3027,6 +3027,8 @@
> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_REALTEK, 0x8169,
>  			 quirk_broken_intx_masking);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, PCI_ANY_ID,
>  			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_BE, PCI_ANY_ID,
> +			 quirk_broken_intx_masking);
> 
>  #ifdef CONFIG_ACPI
>  /*
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index e63c02a..df70b76 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2481,6 +2481,8 @@
>  #define PCI_DEVICE_ID_KORENIX_JETCARDF2	0x1700
>  #define PCI_DEVICE_ID_KORENIX_JETCARDF3	0x17ff
> 
> +#define PCI_VENDOR_ID_BE		0x19a2
> +
>  #define PCI_VENDOR_ID_QMI		0x1a32
> 
>  #define PCI_VENDOR_ID_AZWAVE		0x1a3b
> --
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
