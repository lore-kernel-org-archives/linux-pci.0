Return-Path: <SRS0=VPNC=ZF=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=VPNC=ZF=huawei.com=liudongdong3@kernel.org>
Subject: Re: [PATCH 0/3] PCI:hisi: Add DT almost ECAM support for HiSilicon
 Hip06/Hip07 host controllers
To: <helgaas@kernel.org>
References: <1484202504-96686-1-git-send-email-liudongdong3@huawei.com>
CC: <linux-pci@vger.kernel.org>, <wangzhou1@hisilicon.com>,
        <gabriele.paoloni@huawei.com>, <charles.chenxin@huawei.com>,
        <linuxarm@huawei.com>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <274f51da-67ea-898c-abe4-c43d9ec98b45@huawei.com>
Date: Mon, 23 Jan 2017 18:29:46 +0800
MIME-Version: 1.0
In-Reply-To: <1484202504-96686-1-git-send-email-liudongdong3@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn

Please look at this patchset if you have time.

Thanks,
Dongdong

ÔÚ 2017/1/12 14:28, Dongdong Liu Ð´µÀ:
> The PCIe controller in Hip06/Hip07 SoCs is not completely
> ECAM-compliant. It is non-ECAM only for the RC bus config space; for
> any other bus underneath the root bus it does support ECAM access.
>
> This series contains
> 1. Add the almost ECAM support in DT way.
> 2. Add quirk to set root port pdev->no_msi = 1.
> 3. Add condition #ifndef CONFIG_ARM64 for pci_fixup_irqs.
>
> This patchset is based on 4.10-rc3.
>
> Dongdong Liu (3):
>   PCI:hisi: Add DT almost ECAM support for HiSilicon Hip06/Hip07 host
>     controllers
>   PCI: Set pdev->no_msi=1 for HiSilicon Hip06/Hip07 host controllers
>   PCI: generic: Fix the bug of pci_fixup_irqs() for arm64 platform.
>
>  .../devicetree/bindings/pci/hisilicon-pcie.txt     | 37 +++++++++++++++
>  drivers/pci/host/pci-host-common.c                 |  2 +
>  drivers/pci/host/pcie-hisi.c                       | 54 ++++++++++++++++++++--
>  drivers/pci/quirks.c                               |  1 +
>  include/linux/pci_ids.h                            |  3 ++
>  5 files changed, 94 insertions(+), 3 deletions(-)
>
