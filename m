Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965291AbeAMAEU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Jan 2018 19:04:20 -0500
Date: Fri, 12 Jan 2018 18:04:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: linux-pci@vger.kernel.org, linuxarm@huawei.com,
        zhouyupeng1@huawei.com, tangyongqian@huawei.com,
        bruce.feng@huawei.com, stable@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix MSI disabled for HiSilicon Hip06/Hip07 EP mode
Message-ID: <20180113000414.GC205469@bhelgaas-glaptop.roam.corp.google.com>
References: <1514454812-101846-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1514454812-101846-1-git-send-email-liudongdong3@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 28, 2017 at 05:53:32PM +0800, Dongdong Liu wrote:
> HiSilicon Hip06/Hip07 can work as RC mode and EP mode. The PCIe Root Port
> in Hip06/Hip07 SoCs advertises an MSI capability, but it can not generate
> MSIs. It can generate MSIs When it works as EP mode, but the vendor id and
> device id of RP and EP are the same. Current code also disable MSI for EP
> mode, we only need to disable MSI for Root Port.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 72f2ff0deb87 ("PCI: Disable MSI for HiSilicon Hip06/Hip07 Root Ports")
> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>

Applied with Zhou's reviewed-by to pci/msi for v4.16, thanks!

> ---
>  drivers/pci/quirks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 10684b1..d22750e 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1636,8 +1636,8 @@ static void quirk_pcie_mch(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7520_MCH,	quirk_pcie_mch);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7320_MCH,	quirk_pcie_mch);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7525_MCH,	quirk_pcie_mch);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI,	0x1610,	quirk_pcie_mch);
>  
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_HUAWEI, 0x1610, PCI_CLASS_BRIDGE_PCI, 8, quirk_pcie_mch);
>  
>  /*
>   * It's possible for the MSI to get corrupted if shpc and acpi
> -- 
> 1.9.1
> 
