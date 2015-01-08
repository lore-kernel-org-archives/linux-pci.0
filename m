Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cmexedge2.emulex.com ([138.239.224.100]:56566 "EHLO
	CMEXEDGE2.ext.emulex.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567AbbAHLeR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jan 2015 06:34:17 -0500
From: Venkat Duvvuru <VenkatKumar.Duvvuru@Emulex.Com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
CC: Ajit Kumar Khaparde <Ajit.Khaparde@Emulex.Com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] PCI: Mark broken INTx masking for BENET devices
Date: Thu, 8 Jan 2015 11:33:46 +0000
Message-ID: <a227414f-6f4b-4656-b65b-ef8d6e68f135@CMEXHTCAS1.ad.emulex.com>
References: <1420424274-3194-1-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1420424274-3194-1-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gavin,
We tried to reproduce this in our lab but our observation is that we don't see "interrupt storm" in our system.
Could you please give us the details of the repro scenario?

A few more details will help us understand the problem better as well.
1. be2net driver version
2. be2net firmware version
3. lspci -vvv output of the card (lspci -d 19a2: -vvv)
4. Is SR-IOV enabled in your card?

Thanks,
Venkat.


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
