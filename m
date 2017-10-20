Return-Path: <SRS0=vfPS=BT=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=vfPS=BT=huawei.com=liudongdong3@kernel.org>
Subject: Re: [PATCH v5 0/3] PCI/portdrv: Fix MSI/MSI-X bug for PCIe port
 service drivers
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20171019225726.17806.62380.stgit@bhelgaas-glaptop.roam.corp.google.com>
CC: Charles Chenxin <charles.chenxin@huawei.com>, <linuxarm@huawei.com>,
        Christoph Hellwig <hch@lst.de>,
        Gabriele Paoloni
	<gabriele.paoloni@huawei.com>,
        <linux-pci@vger.kernel.org>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <4ef5470d-b3b1-618a-8449-d67e69587141@huawei.com>
Date: Fri, 20 Oct 2017 16:20:27 +0800
MIME-Version: 1.0
In-Reply-To: <20171019225726.17806.62380.stgit@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn

Many thanks for your work on the patchset.
The pachset looks good to me.
It works ok on HiSilicon hip08 platform.
Tested-by: Dongdong Liu <liudongdong3@huawei.com>

Thanks,
Dongdong
在 2017/10/20 7:01, Bjorn Helgaas 写道:
> This is based on Dongdong's series:
>   v3: http://lkml.kernel.org/r/1507553167-27833-1-git-send-email-liudongdong3@huawei.com
>   v4: http://lkml.kernel.org/r/1507719178-112556-1-git-send-email-liudongdong3@huawei.com
>
> The main idea is to fix IRQ issues when removing and adding back a Root
> Port.  The problem is that when we allocate, free, and reallocate MSI/MSI-X
> vectors for the device, we may not get the same vectors the second time,
> but we saved IRQs based on the first set of vectors.
>
> ---
>
> Bjorn Helgaas (2):
>       PCI/portdrv: Remove excessive comments
>       PCI/portdrv: Compute MSI/MSI-X IRQ vectors after final allocation
>
> Dongdong Liu (1):
>       PCI/portdrv: Add #defines for AER and DPC Interrupt Message Number masks
>
>
>  drivers/pci/pcie/portdrv_core.c |  162 ++++++++++++++++-----------------------
>  include/uapi/linux/pci_regs.h   |    2
>  2 files changed, 70 insertions(+), 94 deletions(-)
>
> .
>
