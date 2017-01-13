Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <988ae7dc-ff41-0a06-903f-8681b8ddf13f@broadcom.com>
References: <1484265521-13497-1-git-send-email-aospan@netup.ru>
 <988ae7dc-ff41-0a06-903f-8681b8ddf13f@broadcom.com>
From: Abylay Ospan <aospan@netup.ru>
Date: Fri, 13 Jan 2017 00:32:06 -0500
Message-ID: <CAK3bHNWUa5m2s8jj0kBhgnFwRH7=qq2Hd-FwLOyA3XLuFaTYFg@mail.gmail.com>
Subject: Re: [PATCH] PCI: iproc: fix resource allocation for BCMA PCIe
To: Ray Jui <ray.jui@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ray,

i'm not sure but looks so. Following drivers is doing same allocation on stack:

drivers/pci/host/pcie-designware.c
drivers/pci/host/pcie-rockchip.c
drivers/pci/host/pcie-xilinx.c
drivers/pci/host/pcie-xilinx-nwl.c
drivers/pci/host/pci-host-common.c
 -> drivers/pci/host/pci-thunder-ecam.c
 -> drivers/pci/host/pci-thunder-pem.c
 -> drivers/pci/host/pci-host-generic.c
drivers/pci/host/pci-versatile.c
drivers/pci/host/pci-xgene.c

other drivers is ok. But need to double-check.

Below is more detailed description of the problem.

Problem is visible when second PCIe bridge registering (but can cause
kernel crash with only one PCIe bridge because broken pointer
introduced to 'iomem_resource' anyway). Here is my global
'iomem_resource' list dump:

after first PCIe bridge registered:
[    3.578650] iomem_resource child=cb039d40 name=PCIe MEM space start=08000000
[    3.585811] iomem_resource child=cb41da80 name=serial start=18000300
[    3.592267] iomem_resource child=cb15ce80 name=serial start=18000400
[    3.598719] iomem_resource child=cb57df00 name=nand start=18028000
[    3.605001] iomem_resource child=cb57dc80 name=iproc-ext start=18028f00
[    3.611723] iomem_resource child=cb57da00 name=iproc-idm start=1811a408
[    3.618433] iomem_resource child=cbfffe80 name=System RAM start=80000000

this dump looks good but before registering second PCIe same dump looks broken:
[    3.669225] iomem_resource child=cb039d40 name=PCIe MEM space start=40000000
[    3.676395] iomem_resource child=cb5e3410 name=bcma0:8 start=cb0f6e10
[    3.682948] iomem_resource child=cb061080 name= start=c1604b04

and second PCIe registration fail with:
[    3.694207] pcie_iproc_bcma bcma0:8: resource collision: [mem
0x40000000-0x47ffffff] conflicts with PCIe MEM space [mem
0x40000000-0x47ffffff]
[    3.707024] pcie_iproc_bcma bcma0:8: PCIe controller setup failed

address 0xcb039d40 from this dumps is allocated on stack and is not
valid after 'iproc_pcie_bcma_probe' exit.

Proposed patch is fixing this issue.

2017-01-12 19:40 GMT-05:00 Ray Jui <ray.jui@broadcom.com>:
> Hi Abylay,
>
> On 1/12/2017 3:58 PM, Abylay Ospan wrote:
>> Resource allocated on stack was saved by 'devm_request_resource' to
>> global 'iomem_resource' but become invalid after 'iproc_pcie_bcma_probe' exit.
>> So the global 'iomem_resource' was poisoned. This may cause kernel crash
>> or second PCIe bridge registration failure.
>>
>> Tested on Broadcom NorthStar machine ('Edgecore ECW7220-L') with two PCIe wifi
>> adapters (b43 BCM4331 and ath10k QCA988X).
>>
>> Signed-off-by: Abylay Ospan <aospan@netup.ru>
>
> I have not yet looked into this in great details. But if what you
> claimed is true, do we have the same problem with multiple PCIe host
> drivers that all have their resource allocated on the stack and have
> 'devm_request_resource' called to save it?
>
> Thanks,
>
> Ray
>
>> ---
>>  drivers/pci/host/pcie-iproc-bcma.c | 18 ++++++++----------
>>  drivers/pci/host/pcie-iproc.h      |  2 ++
>>  2 files changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/pci/host/pcie-iproc-bcma.c b/drivers/pci/host/pcie-iproc-bcma.c
>> index bd4c9ec..28f9b89 100644
>> --- a/drivers/pci/host/pcie-iproc-bcma.c
>> +++ b/drivers/pci/host/pcie-iproc-bcma.c
>> @@ -44,8 +44,6 @@ static int iproc_pcie_bcma_probe(struct bcma_device *bdev)
>>  {
>>       struct device *dev = &bdev->dev;
>>       struct iproc_pcie *pcie;
>> -     LIST_HEAD(res);
>> -     struct resource res_mem;
>>       int ret;
>>
>>       pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>> @@ -62,21 +60,21 @@ static int iproc_pcie_bcma_probe(struct bcma_device *bdev)
>>       }
>>
>>       pcie->base_addr = bdev->addr;
>> +     INIT_LIST_HEAD(&pcie->resources);
>>
>> -     res_mem.start = bdev->addr_s[0];
>> -     res_mem.end = bdev->addr_s[0] + SZ_128M - 1;
>> -     res_mem.name = "PCIe MEM space";
>> -     res_mem.flags = IORESOURCE_MEM;
>> -     pci_add_resource(&res, &res_mem);
>> +     pcie->res_mem.start = bdev->addr_s[0];
>> +     pcie->res_mem.end = bdev->addr_s[0] + SZ_128M - 1;
>> +     pcie->res_mem.name = "PCIe MEM space";
>> +     pcie->res_mem.flags = IORESOURCE_MEM;
>> +     pcie->res_mem.child = NULL;
>> +     pci_add_resource(&pcie->resources, &pcie->res_mem);
>>
>>       pcie->map_irq = iproc_pcie_bcma_map_irq;
>>
>> -     ret = iproc_pcie_setup(pcie, &res);
>> +     ret = iproc_pcie_setup(pcie, &pcie->resources);
>>       if (ret)
>>               dev_err(dev, "PCIe controller setup failed\n");
>>
>> -     pci_free_resource_list(&res);
>> -
>>       bcma_set_drvdata(bdev, pcie);
>>       return ret;
>>  }
>> diff --git a/drivers/pci/host/pcie-iproc.h b/drivers/pci/host/pcie-iproc.h
>> index 04fed8e..866d649 100644
>> --- a/drivers/pci/host/pcie-iproc.h
>> +++ b/drivers/pci/host/pcie-iproc.h
>> @@ -105,6 +105,8 @@ struct iproc_pcie {
>>
>>       bool need_msi_steer;
>>       struct iproc_msi *msi;
>> +     struct resource res_mem;
>> +     struct list_head resources;
>>  };
>>
>>  int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res);
>>



-- 
Abylay Ospan,
NetUP Inc.
http://www.netup.tv

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
