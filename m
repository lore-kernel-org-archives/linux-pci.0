Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752325AbdBCUmG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Feb 2017 15:42:06 -0500
Date: Fri, 3 Feb 2017 14:42:02 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: linux-pci@vger.kernel.org, wangzhou1@hisilicon.com,
        gabriele.paoloni@huawei.com, charles.chenxin@huawei.com,
        linuxarm@huawei.com
Subject: Re: [PATCH 2/3] PCI: Set pdev->no_msi=1 for HiSilicon Hip06/Hip07
 host controllers
Message-ID: <20170203204202.GG10291@bhelgaas-glaptop.roam.corp.google.com>
References: <1484202504-96686-1-git-send-email-liudongdong3@huawei.com>
 <1484202504-96686-3-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484202504-96686-3-git-send-email-liudongdong3@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 12, 2017 at 02:28:23PM +0800, Dongdong Liu wrote:
> The PCIe root port in Hip06/Hip07 SoCs does not support MSI/MSI-X,
> it can only transfer MSI/MSI-X from EP, so we add the quirk to
> set root port pdev->no_msi = 1.
> 
> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> Reviewed-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>

Applied as follows to pci/host-hisi for v4.11.    I removed the device
ID, since we don't add those to pci_ids.h unless they're used in more
than one place.  I also reworded the changelog; let me know if I
didn't understand it correctly.

commit c2f8051a8a0c7ea9e93d80e484948cab583b7605
Author: Dongdong Liu <liudongdong3@huawei.com>
Date:   Thu Jan 12 14:28:23 2017 +0800

    PCI: Disable MSI for HiSilicon Hip06/Hip07 Root Ports
    
    The PCIe Root Port in Hip06/Hip07 SoCs can transfer MSI/MSI-X from
    downstream devices, but does not support MSI/MSI-X itself.
    
    Add a quirk to prevent use of MSI/MSI-X by the Root Port.
    
    [bhelgaas: changelog, sort vendor ID #define, drop device ID #define]
    Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
    Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 1800befa8b8b..c49ac99bda4b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1634,6 +1634,7 @@ static void quirk_pcie_mch(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7520_MCH,	quirk_pcie_mch);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7320_MCH,	quirk_pcie_mch);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7525_MCH,	quirk_pcie_mch);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI,	0x1610,	quirk_pcie_mch);
 
 
 /*
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 73dda0edcb97..a4f77feecbb0 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2516,6 +2516,8 @@
 #define PCI_DEVICE_ID_KORENIX_JETCARDF2	0x1700
 #define PCI_DEVICE_ID_KORENIX_JETCARDF3	0x17ff
 
+#define PCI_VENDOR_ID_HUAWEI         	0x19e5
+
 #define PCI_VENDOR_ID_NETRONOME		0x19ee
 #define PCI_DEVICE_ID_NETRONOME_NFP3200	0x3200
 #define PCI_DEVICE_ID_NETRONOME_NFP3240	0x3240

> ---
>  drivers/pci/quirks.c    | 1 +
>  include/linux/pci_ids.h | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 1800bef..20cbdae 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1634,6 +1634,7 @@ static void quirk_pcie_mch(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7520_MCH,	quirk_pcie_mch);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7320_MCH,	quirk_pcie_mch);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7525_MCH,	quirk_pcie_mch);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI,	PCI_DEVICE_ID_HISILICON_1610,	quirk_pcie_mch);
>  
>  
>  /*
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 73dda0e..9cc4720 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -3054,4 +3054,7 @@
>  
>  #define PCI_VENDOR_ID_OCZ		0x1b85
>  
> +#define PCI_VENDOR_ID_HUAWEI         	0x19e5
> +#define PCI_DEVICE_ID_HISILICON_1610 	0x1610
> +
>  #endif /* _LINUX_PCI_IDS_H */
> -- 
> 1.9.1
> 
