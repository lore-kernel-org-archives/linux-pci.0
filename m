Return-Path: <SRS0=GLfr=BP=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=GLfr=BP=huawei.com=liudongdong3@kernel.org>
Subject: Re: [PATCH V4 0/2] PCI/portdrv: Fix MSI/MSI-X bug for PCIe port
 service drivers
To: <helgaas@kernel.org>, <hch@lst.de>
References: <1507719178-112556-1-git-send-email-liudongdong3@huawei.com>
CC: <linux-pci@vger.kernel.org>, <stable@vger.kernel.org>,
        <gabriele.paoloni@huawei.com>, <charles.chenxin@huawei.com>,
        <linuxarm@huawei.com>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <5380b9e0-b756-6950-2d87-01b60189324d@huawei.com>
Date: Mon, 16 Oct 2017 20:09:50 +0800
MIME-Version: 1.0
In-Reply-To: <1507719178-112556-1-git-send-email-liudongdong3@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn

Is this patchset ok ?  or do I still need to work v5 without optimizing
the interrupt vector allocation strategy(just use PATCH v3 and
add #defines for the AER and DPC Interrupt Message Number masks.)

Thanks,
Dongdong

ÔÚ 2017/10/11 18:52, Dongdong Liu Ð´µÀ:
> This patchset is to optimize the interrupt vector allocation strategy
> in pcie_port_enable_irq_vec() and add #defines for the AER and DPC
> Interrupt Message Number masks.
>
> v3->v4:
> - Optimize the interrupt vector allocation strategy in
> pcie_port_enable_irq_vec().
> - add #defines for the AER and DPC Interrupt Message Number masks.
> v2->v3:
> - Use a 12-character SHA1 commit id.
> - Rebase on v4.14-rc4.
> v1->v2:
> - Fix comments on PATCH v1.
> - Simplify implementation.
>
> Dongdong Liu (2):
>   PCI/portdrv: Fix MSI/MSI-X bug for PCIe port service drivers
>   PCI/portdrv: Add #defines for the AER and DPC Interrupt Message Number
>     masks
>
>  drivers/pci/pcie/portdrv_core.c | 49 ++++++++++++++---------------------------
>  include/uapi/linux/pci_regs.h   |  2 ++
>  2 files changed, 18 insertions(+), 33 deletions(-)
>
