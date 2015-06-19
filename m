Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:36673 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756743AbbFSWOD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jun 2015 18:14:03 -0400
Received: by iecrd14 with SMTP id rd14so83385181iec.3
        for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2015 15:14:02 -0700 (PDT)
Date: Fri, 19 Jun 2015 17:13:59 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add PCI ID and quirk for Intersil/Techwell TW686[4589]
 AV capture cards.
Message-ID: <20150619221359.GN7710@google.com>
References: <m3vbekruuo.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <m3vbekruuo.fsf@t19.piap.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 19, 2015 at 10:00:15AM +0200, Krzysztof Hałasa wrote:
> Intersil/Techwell TW686[4589]-based video capture cards have an empty
> (zero) class code. Fix it.
> 
> Signed-off-by: Krzysztof Hałasa <khalasa@piap.pl>

Applied to pci/misc for v4.2, with minor tweak as below to use
PCI_CLASS_MULTIMEDIA_OTHER instead of a bare number.  Let me know
if you see any issues with this.  Thanks!


commit c1aa4f19cb8f7974126f2da74a35ae4ca1e60017
Author: Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Date:   Fri Jun 19 10:00:15 2015 +0200

    PCI: Add quirk for Intersil/Techwell TW686[4589] AV capture cards
    
    Intersil/Techwell TW686[4589]-based video capture cards have an empty
    (zero) class code.  Fix it.
    
    Signed-off-by: Krzysztof Hałasa <khalasa@piap.pl>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 54fa458..cbe0351 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3671,6 +3671,28 @@ DECLARE_PCI_FIXUP_HEADER(0x1283, 0x8892, quirk_use_pcie_bridge_dma_alias);
 DECLARE_PCI_FIXUP_HEADER(0x8086, 0x244e, quirk_use_pcie_bridge_dma_alias);
 
 /*
+ * Intersil/Techwell TW686[4589]-based video capture cards have an empty (zero)
+ * class code.  Fix it.
+ */
+static void quirk_tw686x_class(struct pci_dev *pdev)
+{
+	u32 class = pdev->class;
+
+	/* Use "Multimedia controller" class */
+	pdev->class = (PCI_CLASS_MULTIMEDIA_OTHER << 8) | 0x01;
+	dev_info(&pdev->dev, "TW686x PCI class overridden (%#08x -> %#08x)\n",
+		 class, pdev->class);
+}
+DECLARE_PCI_FIXUP_CLASS_EARLY(0x1797, 0x6864, PCI_CLASS_NOT_DEFINED, 0,
+			      quirk_tw686x_class);
+DECLARE_PCI_FIXUP_CLASS_EARLY(0x1797, 0x6865, PCI_CLASS_NOT_DEFINED, 0,
+			      quirk_tw686x_class);
+DECLARE_PCI_FIXUP_CLASS_EARLY(0x1797, 0x6868, PCI_CLASS_NOT_DEFINED, 0,
+			      quirk_tw686x_class);
+DECLARE_PCI_FIXUP_CLASS_EARLY(0x1797, 0x6869, PCI_CLASS_NOT_DEFINED, 0,
+			      quirk_tw686x_class);
+
+/*
  * AMD has indicated that the devices below do not support peer-to-peer
  * in any system where they are found in the southbridge with an AMD
  * IOMMU in the system.  Multifunction devices that do not support

> 
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3662,6 +3662,26 @@ DECLARE_PCI_FIXUP_HEADER(0x1283, 0x8892, quirk_use_pcie_bridge_dma_alias);
>  DECLARE_PCI_FIXUP_HEADER(0x8086, 0x244e, quirk_use_pcie_bridge_dma_alias);
>  
>  /*
> + * Intersil/Techwell TW686[4589]-based video capture cards have an empty (zero)
> + * class code. Fix it.
> + */
> +
> +static void quirk_tw686x_class(struct pci_dev *pdev)
> +{
> +	/* Use "Multimedia controller" class */
> +	pdev->class = 0x048001;
> +	dev_info(&pdev->dev, "TW686x PCI class workaround enabled\n");
> +}
> +DECLARE_PCI_FIXUP_CLASS_EARLY(0x1797, 0x6864, PCI_CLASS_NOT_DEFINED, 0,
> +			      quirk_tw686x_class);
> +DECLARE_PCI_FIXUP_CLASS_EARLY(0x1797, 0x6865, PCI_CLASS_NOT_DEFINED, 0,
> +			      quirk_tw686x_class);
> +DECLARE_PCI_FIXUP_CLASS_EARLY(0x1797, 0x6868, PCI_CLASS_NOT_DEFINED, 0,
> +			      quirk_tw686x_class);
> +DECLARE_PCI_FIXUP_CLASS_EARLY(0x1797, 0x6869, PCI_CLASS_NOT_DEFINED, 0,
> +			      quirk_tw686x_class);
> +
> +/*
>   * AMD has indicated that the devices below do not support peer-to-peer
>   * in any system where they are found in the southbridge with an AMD
>   * IOMMU in the system.  Multifunction devices that do not support
--
To unsubscribe from this list: send the line "unsubscribe linux-pci" in
