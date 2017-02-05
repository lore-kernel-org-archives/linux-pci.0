Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751239AbdBEAjB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 4 Feb 2017 19:39:01 -0500
Date: Sat, 4 Feb 2017 18:38:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: linux-pci@vger.kernel.org, wangzhou1@hisilicon.com,
        gabriele.paoloni@huawei.com, charles.chenxin@huawei.com,
        linuxarm@huawei.com
Subject: Re: [PATCH 2/3] PCI: Set pdev->no_msi=1 for HiSilicon Hip06/Hip07
 host controllers
Message-ID: <20170205003855.GA5914@bhelgaas-glaptop.roam.corp.google.com>
References: <1484202504-96686-1-git-send-email-liudongdong3@huawei.com>
 <1484202504-96686-3-git-send-email-liudongdong3@huawei.com>
 <20170203204202.GG10291@bhelgaas-glaptop.roam.corp.google.com>
 <59ad79d6-2a51-bd7c-e062-f8c43b318c76@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <59ad79d6-2a51-bd7c-e062-f8c43b318c76@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Feb 04, 2017 at 11:37:14AM +0800, Dongdong Liu wrote:
> Hi Bjorn
> 
> 在 2017/2/4 4:42, Bjorn Helgaas 写道:
> >On Thu, Jan 12, 2017 at 02:28:23PM +0800, Dongdong Liu wrote:
> >>The PCIe root port in Hip06/Hip07 SoCs does not support MSI/MSI-X,
> >>it can only transfer MSI/MSI-X from EP, so we add the quirk to
> >>set root port pdev->no_msi = 1.
> >>
> >>Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> >>Reviewed-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> >>Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
> >
> >Applied as follows to pci/host-hisi for v4.11.    I removed the device
> >ID, since we don't add those to pci_ids.h unless they're used in more
> >than one place.  I also reworded the changelog; let me know if I
> >didn't understand it correctly.
> >
> >commit c2f8051a8a0c7ea9e93d80e484948cab583b7605
> >Author: Dongdong Liu <liudongdong3@huawei.com>
> >Date:   Thu Jan 12 14:28:23 2017 +0800
> >
> >    PCI: Disable MSI for HiSilicon Hip06/Hip07 Root Ports
> >
> >    The PCIe Root Port in Hip06/Hip07 SoCs can transfer MSI/MSI-X from
> >    downstream devices, but does not support MSI/MSI-X itself.
> >
> >    Add a quirk to prevent use of MSI/MSI-X by the Root Port.
> >
> >    [bhelgaas: changelog, sort vendor ID #define, drop device ID #define]
> >    Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> >    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >    Reviewed-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> >    Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
> >
> >diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> >index 1800befa8b8b..c49ac99bda4b 100644
> >--- a/drivers/pci/quirks.c
> >+++ b/drivers/pci/quirks.c
> >@@ -1634,6 +1634,7 @@ static void quirk_pcie_mch(struct pci_dev *pdev)
> > DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7520_MCH,	quirk_pcie_mch);
> > DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7320_MCH,	quirk_pcie_mch);
> > DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7525_MCH,	quirk_pcie_mch);
> >+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI,	0x1610,	quirk_pcie_mch);
> >
> 
> This looks good to me, thanks for your work on this patch.

Just to confirm, is the problem that this device (PCI_VENDOR_ID_HUAWEI
0x1610) advertises an MSI or MSI-X capability, but MSI/MSI-X doesn't
work?  If it doesn't advertise a capability, I don't think we should
try to use MSI, so we wouldn't need the quirk.

Bjorn
