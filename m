Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] PCI: rockchip: add remove() support
To: Brian Norris <briannorris@chromium.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20170310024617.67303-1-briannorris@chromium.org>
 <20170310024617.67303-3-briannorris@chromium.org>
 <de4d1e8a-c971-1f4d-2996-883341d287b3@rock-chips.com>
Cc: shawn.lin@rock-chips.com, linux-kernel@vger.kernel.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <5cec190e-4eee-fc55-7039-2336ba5253f3@rock-chips.com>
Date: Fri, 10 Mar 2017 12:20:54 +0800
MIME-Version: 1.0
In-Reply-To: <de4d1e8a-c971-1f4d-2996-883341d287b3@rock-chips.com>
Content-Type: text/plain; charset=gbk; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2017/3/10 11:22, Shawn Lin wrote:
> On 2017/3/10 10:46, Brian Norris wrote:
>> Currently, if we try to unbind the platform device, the remove will
>> succeed, but the removal won't undo most of the registration, leaving
>> partially-configured PCI devices in the system.
>>
>> This allows, for example, a simple 'lspci' to crash the system, as it
>> will try to touch the freed (via devm_*) driver structures.
>>
>> So let's implement device remove().
>>
>
> As this patchset seems to be merged together so I think the following
> warning will be ok? if my git-am robot only pick your patch 1->compile->
> patch 2->compile->patch 3 then
>
> drivers/pci/host/pcie-rockchip.c: In function 'rockchip_pcie_remove':
> drivers/pci/host/pcie-rockchip.c:1435:2: error: implicit declaration of
> function 'pci_unmap_iospace' [-Werror=implicit-function-declaration]
>   pci_unmap_iospace(rockchip->io);
>
> but I guess you may need to move your patch 4 ahead of patch 3?
>

Well, I am not sure if something is wrong here.

But when booting up the system for the first time, we got
[    0.527263] PCI host bridge /pcie@f8000000 ranges:
[    0.527293]   MEM 0xfa000000..0xfa5fffff -> 0xfa000000
[    0.527308]    IO 0xfa600000..0xfa6fffff -> 0xfa600000
[    0.527544] rockchip-pcie f8000000.pcie: PCI host bridge to bus 0000:0

so the hierarchy(lspci -t) looks like:
lspci -t
-[0000:00]---00.0-[01]----00.0

and lspci
0000:00:00.0 Class 0604: Device 1d87:0100
0001:01:00.0 Class 0108: Device 8086:f1a5 (rev 03)

but if I did unbind and bind, the bus number is different.

lspci
0001:00:00.0 Class 0604: Device 1d87:0100
0001:01:00.0 Class 0108: Device 8086:f1a5 (rev 03)

lspci -t
-+-[0001:00]---00.0-[01]----00.0
  \-[0000:00]-

This hierarchy looks wrong to me.

>
>> Signed-off-by: Brian Norris <briannorris@chromium.org>
>> ---
>> v2:
>> * unmap IO space with pci_unmap_iospace()
>> * remove IRQ domain
>> ---
>>  drivers/pci/host/pcie-rockchip.c | 36
>> ++++++++++++++++++++++++++++++++++--
>>  1 file changed, 34 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/host/pcie-rockchip.c
>> b/drivers/pci/host/pcie-rockchip.c
>> index 5d7b27b1e941..d2e5078ae331 100644
>> --- a/drivers/pci/host/pcie-rockchip.c
>> +++ b/drivers/pci/host/pcie-rockchip.c
>> @@ -223,9 +223,11 @@ struct rockchip_pcie {
>>      int    link_gen;
>>      struct    device *dev;
>>      struct    irq_domain *irq_domain;
>> -    u32     io_size;
>>      int     offset;
>> +    struct pci_bus *root_bus;
>> +    struct resource *io;
>>      phys_addr_t io_bus_addr;
>> +    u32     io_size;
>>      void    __iomem *msg_region;
>>      u32     mem_size;
>>      phys_addr_t msg_bus_addr;
>> @@ -1360,6 +1362,7 @@ static int rockchip_pcie_probe(struct
>> platform_device *pdev)
>>                       err, io);
>>                  continue;
>>              }
>> +            rockchip->io = io;
>>              break;
>>          case IORESOURCE_MEM:
>>              mem = win->res;
>> @@ -1391,6 +1394,7 @@ static int rockchip_pcie_probe(struct
>> platform_device *pdev)
>>          err = -ENOMEM;
>>          goto err_free_res;
>>      }
>> +    rockchip->root_bus = bus;
>>
>>      pci_bus_size_bridges(bus);
>>      pci_bus_assign_resources(bus);
>> @@ -1421,6 +1425,34 @@ static int rockchip_pcie_probe(struct
>> platform_device *pdev)
>>      return err;
>>  }
>>
>> +static int rockchip_pcie_remove(struct platform_device *pdev)
>> +{
>> +    struct device *dev = &pdev->dev;
>> +    struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
>> +
>> +    pci_stop_root_bus(rockchip->root_bus);
>> +    pci_remove_root_bus(rockchip->root_bus);
>> +    pci_unmap_iospace(rockchip->io);
>> +    irq_domain_remove(rockchip->irq_domain);
>> +
>> +    phy_power_off(rockchip->phy);
>> +    phy_exit(rockchip->phy);
>> +
>> +    clk_disable_unprepare(rockchip->clk_pcie_pm);
>> +    clk_disable_unprepare(rockchip->hclk_pcie);
>> +    clk_disable_unprepare(rockchip->aclk_perf_pcie);
>> +    clk_disable_unprepare(rockchip->aclk_pcie);
>> +
>> +    if (!IS_ERR(rockchip->vpcie3v3))
>> +        regulator_disable(rockchip->vpcie3v3);
>> +    if (!IS_ERR(rockchip->vpcie1v8))
>> +        regulator_disable(rockchip->vpcie1v8);
>> +    if (!IS_ERR(rockchip->vpcie0v9))
>> +        regulator_disable(rockchip->vpcie0v9);
>> +
>> +    return 0;
>> +}
>> +
>>  static const struct dev_pm_ops rockchip_pcie_pm_ops = {
>>      SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(rockchip_pcie_suspend_noirq,
>>                        rockchip_pcie_resume_noirq)
>> @@ -1438,6 +1470,6 @@ static struct platform_driver
>> rockchip_pcie_driver = {
>>          .pm = &rockchip_pcie_pm_ops,
>>      },
>>      .probe = rockchip_pcie_probe,
>> -
>> +    .remove = rockchip_pcie_remove,
>>  };
>>  builtin_platform_driver(rockchip_pcie_driver);
>>
>
>


-- 
Best Regards
Shawn Lin
