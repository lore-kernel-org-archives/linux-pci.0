Return-Path: <SRS0=b4qK=7V=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=b4qK=7V=huawei.com=liudongdong3@kernel.org>
Subject: Re: [PATCH V4 0/2] PCI/DPC: Add eDPC support
To: <helgaas@kernel.org>
References: <1503044509-35876-1-git-send-email-liudongdong3@huawei.com>
CC: <linux-pci@vger.kernel.org>, <keith.busch@intel.com>,
        <gabriele.paoloni@huawei.com>, <charles.chenxin@huawei.com>,
        <linuxarm@huawei.com>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <14720e32-cf0d-b630-df79-442621f2ea43@huawei.com>
Date: Sat, 19 Aug 2017 16:18:26 +0800
MIME-Version: 1.0
In-Reply-To: <1503044509-35876-1-git-send-email-liudongdong3@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
List-ID: <linux-pci.vger.kernel.org>


I made a mistake, there are some warnings.
Regardless of the patchset. I will fix the warnings in PATCH v5.
Sorry .

drivers/pci/pcie/pcie-dpc.c: In function 'dpc_wait_link_inactive':
drivers/pci/pcie/pcie-dpc.c:104:12: warning: passing argument 1 of 'dev_warn' from incompatible pointer type
    dev_warn(&dev, "Link state not disabled for DPC event\n");
             ^
In file included from ./include/linux/pci.h:30:0,
                  from drivers/pci/pcie/pcie-dpc.c:15:
./include/linux/device.h:1262:6: note: expected 'const struct device *' but argument is of type 'struct device **'
  void dev_warn(const struct device *dev, const char *fmt, ...);
       ^
drivers/pci/pcie/pcie-dpc.c: In function 'dpc_rp_pio_print_error':
drivers/pci/pcie/pcie-dpc.c:150:18: warning: unused variable 'pdev' [-Wunused-variable]


Thanks,
Dongdong
ÔÚ 2017/8/18 16:21, Dongdong Liu Ð´µÀ:
> This patchset is to add eDPC support and use a local
> "struct device *dev" for brevity and consistency in DPC driver.
>
> v3->v4:
> - Use pcie_device's device to keep consistency.
> - Adjust patch sequence.
>
> v2->v3:
> - Add a separate patch to use a local "struct device *dev"
>   for brevity and consistency in  DPC driver.
> - Fix comments on PATCH V2.
> - Rebase on v4.13-rc5.
>
> v1->v2:
> - Use a stack local variable instead of the allocated memory for
>   collecting RP PIO information.
> - Fix the condition of RP PIO error.
> - Rebase on v4.13-rc1.
>
> Dongdong Liu (2):
>   PCI/DPC: Add eDPC support
>   PCI/DPC: Add local struct device
>
>  drivers/pci/pcie/pcie-dpc.c   | 188 +++++++++++++++++++++++++++++++++++++++---
>  include/uapi/linux/pci_regs.h |  10 +++
>  2 files changed, 188 insertions(+), 10 deletions(-)
>
