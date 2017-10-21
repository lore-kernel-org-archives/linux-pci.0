Return-Path: <SRS0=Qe2T=BU=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=Qe2T=BU=huawei.com=liudongdong3@kernel.org>
Subject: Re: [PATCH v6 0/4] PCI/portdrv: Fix MSI/MSI-X bug for PCIe port
 service drivers
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20171020161922.6391.9091.stgit@bhelgaas-glaptop.roam.corp.google.com>
CC: Charles Chenxin <charles.chenxin@huawei.com>, <linuxarm@huawei.com>,
        Christoph Hellwig <hch@lst.de>,
        Gabriele Paoloni
	<gabriele.paoloni@huawei.com>,
        <linux-pci@vger.kernel.org>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <2db2ba34-8f65-0eb2-3a00-587618e4144b@huawei.com>
Date: Sat, 21 Oct 2017 10:22:41 +0800
MIME-Version: 1.0
In-Reply-To: <20171020161922.6391.9091.stgit@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn.

The patch v6 looks good to me.
It works ok on HiSilicon hip08 platform.
Tested-by: Dongdong Liu <liudongdong3@huawei.com>

在 2017/10/21 0:21, Bjorn Helgaas 写道:
> This is based on Dongdong's series:
>   v3: http://lkml.kernel.org/r/1507553167-27833-1-git-send-email-liudongdong3@huawei.com
>   v4: http://lkml.kernel.org/r/1507719178-112556-1-git-send-email-liudongdong3@huawei.com
>   v5: http://lkml.kernel.org/r/20171019225726.17806.62380.stgit@bhelgaas-glaptop.roam.corp.google.com
>
> The main idea is to fix IRQ issues when removing and adding back a Root
> Port.  The problem is that when we allocate, free, and reallocate MSI/MSI-X
> vectors for the device, we may not get the same vectors the second time,
> but we saved IRQs based on the first set of vectors.
>
> Changes in v5:
>   - add back a general Interrupt Message Number comment
>   - factor out Interrupt Message Number helper separately
>
> This is on pci/msi for v4.15.
>
> ---
>
> Bjorn Helgaas (3):
>       PCI/portdrv: Consolidate comments
>       PCI/portdrv: Factor out Interrupt Message Number lookup
>       PCI/portdrv: Compute MSI/MSI-X IRQ vectors after final allocation
>
> Dongdong Liu (1):
>       PCI/portdrv: Add #defines for AER and DPC Interrupt Message Number masks
>
>
>  drivers/pci/pcie/portdrv_core.c |  171 +++++++++++++++++----------------------
>  include/uapi/linux/pci_regs.h   |    2
>  2 files changed, 77 insertions(+), 96 deletions(-)
>
> .
>
