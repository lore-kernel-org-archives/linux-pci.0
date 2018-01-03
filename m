Return-Path: <SRS0=+JFf=D6=hisilicon.com=wangzhou1@kernel.org>
Return-Path: <SRS0=+JFf=D6=hisilicon.com=wangzhou1@kernel.org>
Subject: Re: [PATCH] PCI: Fix MSI disabled for HiSilicon Hip06/Hip07 EP mode
To: Dongdong Liu <liudongdong3@huawei.com>, <helgaas@kernel.org>
References: <1514454812-101846-1-git-send-email-liudongdong3@huawei.com>
CC: <linux-pci@vger.kernel.org>, <linuxarm@huawei.com>,
	<stable@vger.kernel.org>, <tangyongqian@huawei.com>, <bruce.feng@huawei.com>
From: Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5A4C7E82.1050802@hisilicon.com>
Date: Wed, 3 Jan 2018 14:56:02 +0800
MIME-Version: 1.0
In-Reply-To: <1514454812-101846-1-git-send-email-liudongdong3@huawei.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

On 2017/12/28 17:53, Dongdong Liu wrote:
> HiSilicon Hip06/Hip07 can work as RC mode and EP mode. The PCIe Root Port
> in Hip06/Hip07 SoCs advertises an MSI capability, but it can not generate
> MSIs. It can generate MSIs When it works as EP mode, but the vendor id and
> device id of RP and EP are the same. Current code also disable MSI for EP
> mode, we only need to disable MSI for Root Port.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 72f2ff0deb87 ("PCI: Disable MSI for HiSilicon Hip06/Hip07 Root Ports")
> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>

It looks good to me, so:

Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>

Thanks,
Zhou

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
> 
