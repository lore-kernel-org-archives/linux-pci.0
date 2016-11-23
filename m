Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:44815 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755734AbcKWCPc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2016 21:15:32 -0500
Subject: Re: [PATCH 1/3] PCI: rockchip: split out rockchip_cfg_atu
To: Brian Norris <briannorris@chromium.org>
References: <1479863953-123874-1-git-send-email-shawn.lin@rock-chips.com>
 <20161123015914.GA119441@google.com>
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <30d37e0c-73df-5bae-f489-3d9b56cc7b02@rock-chips.com>
Date: Wed, 23 Nov 2016 10:15:16 +0800
MIME-Version: 1.0
In-Reply-To: <20161123015914.GA119441@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

在 2016/11/23 9:59, Brian Norris 写道:
> On Wed, Nov 23, 2016 at 09:19:11AM +0800, Shawn Lin wrote:
>> We split out a new function, rockchip_cfg_atu, in order to
>> re-configure the atu when missing these information after
>> wakeup from S3.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>  drivers/pci/host/pcie-rockchip.c | 119 ++++++++++++++++++++++-----------------
>>  1 file changed, 68 insertions(+), 51 deletions(-)
>>
>> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
>> index b55037a..19399fc 100644
>> --- a/drivers/pci/host/pcie-rockchip.c
>> +++ b/drivers/pci/host/pcie-rockchip.c
>> @@ -169,6 +169,7 @@
>>  #define IB_ROOT_PORT_REG_SIZE_SHIFT		3
>>  #define AXI_WRAPPER_IO_WRITE			0x6
>>  #define AXI_WRAPPER_MEM_WRITE			0x2
>> +#define AXI_WRAPPER_NOR_MSG			0xc
>
> You're also adding this 'normal message' support in a refactoring patch.
> This should be in another patch -- preferably patch 3 I think.
>

okay.

>>
>>  #define MAX_AXI_IB_ROOTPORT_REGION_NUM		3
>>  #define MIN_AXI_ADDR_BITS_PASSED		8
>> @@ -210,6 +211,13 @@ struct rockchip_pcie {
>>  	int	link_gen;
>>  	struct	device *dev;
>>  	struct	irq_domain *irq_domain;
>> +	u32     io_size;
>> +	int     offset;
>> +	phys_addr_t io_bus_addr;
>> +	int     msg_region_nr;
>> +	void	__iomem *msg_region;
>> +	u32     mem_size;
>> +	phys_addr_t mem_bus_addr;
>>  };
>>
>>  static u32 rockchip_pcie_read(struct rockchip_pcie *rockchip, u32 reg)
>> @@ -1149,6 +1157,57 @@ static int rockchip_pcie_prog_ib_atu(struct rockchip_pcie *rockchip,
>>  	return 0;
>>  }
>>
>> +static int rockchip_cfg_atu(struct rockchip_pcie *rockchip)
>> +{
>> +	int offset;
>> +	int err;
>> +	int reg_no;
>> +
>> +	for (reg_no = 0; reg_no < (rockchip->mem_size >> 20); reg_no++) {
>> +		err = rockchip_pcie_prog_ob_atu(rockchip, reg_no + 1,
>> +						AXI_WRAPPER_MEM_WRITE,
>> +						20 - 1,
>> +						rockchip->mem_bus_addr +
>> +						(reg_no << 20),
>> +						0);
>> +		if (err) {
>> +			dev_err(rockchip->dev,
>> +					"program RC mem outbound ATU failed\n");
>> +			return err;
>> +		}
>> +	}
>> +
>> +	err = rockchip_pcie_prog_ib_atu(rockchip, 2, 32 - 1, 0x0, 0);
>> +	if (err) {
>> +		dev_err(rockchip->dev, "program RC mem inbound ATU failed\n");
>> +		return err;
>> +	}
>> +
>> +	offset = rockchip->mem_size >> 20;
>> +	for (reg_no = 0; reg_no < (rockchip->io_size >> 20); reg_no++) {
>> +		err = rockchip_pcie_prog_ob_atu(rockchip,
>> +						reg_no + 1 + offset,
>> +						AXI_WRAPPER_IO_WRITE,
>> +						20 - 1,
>> +						rockchip->io_bus_addr +
>> +						(reg_no << 20),
>> +						0);
>> +		if (err) {
>> +			dev_err(rockchip->dev,
>> +					"program RC io outbound ATU failed\n");
>> +			return err;
>> +		}
>> +	}
>> +
>> +	/* assign message regions */
>> +	rockchip->msg_region_nr = reg_no + 1 + offset;
>> +	rockchip_pcie_prog_ob_atu(rockchip, reg_no + 1 + offset,
>> +				  AXI_WRAPPER_NOR_MSG,
>> +				  20 - 1, 0, 0);
>
> Same here.
>
>> +	rockchip->msg_region = ioremap(rockchip->mem_bus_addr +
>> +				       ((reg_no - 1) << 20), SZ_1M);
>
> (And here.)
>
> ioremap() can fail; check for NULL.
>

Sure.

> Also, when you start reusing rockchip_cfg_atu() in patch 3, you'll be
> leaking virtual address space, as you'll keep remapping this every time.

How about just check if rockchip->msg_region was already mapped?
Otherwise we don't remap it again when calling rockchip_cfg_atu.

> You should straighten that out. Either some kind of check for
> 'if (!rockchip->msg_region)', or just do the map/unmap where it's
> actually used (in patch 3).

Should we really need to unmap it? As this driver won't be a module and
I think it's okay to keep the rockchip->msg_region always.

>
> Brian
>
>> +	return err;
>> +}
>>  static int rockchip_pcie_probe(struct platform_device *pdev)
>>  {
>>  	struct rockchip_pcie *rockchip;
>> @@ -1158,13 +1217,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>>  	resource_size_t io_base;
>>  	struct resource	*mem;
>>  	struct resource	*io;
>> -	phys_addr_t io_bus_addr = 0;
>> -	u32 io_size;
>> -	phys_addr_t mem_bus_addr = 0;
>> -	u32 mem_size = 0;
>> -	int reg_no;
>>  	int err;
>> -	int offset;
>>
>>  	LIST_HEAD(res);
>>
>> @@ -1231,14 +1284,13 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>>  		goto err_vpcie;
>>
>>  	/* Get the I/O and memory ranges from DT */
>> -	io_size = 0;
>>  	resource_list_for_each_entry(win, &res) {
>>  		switch (resource_type(win->res)) {
>>  		case IORESOURCE_IO:
>>  			io = win->res;
>>  			io->name = "I/O";
>> -			io_size = resource_size(io);
>> -			io_bus_addr = io->start - win->offset;
>> +			rockchip->io_size = resource_size(io);
>> +			rockchip->io_bus_addr = io->start - win->offset;
>>  			err = pci_remap_iospace(io, io_base);
>>  			if (err) {
>>  				dev_warn(dev, "error %d: failed to map resource %pR\n",
>> @@ -1249,8 +1301,8 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>>  		case IORESOURCE_MEM:
>>  			mem = win->res;
>>  			mem->name = "MEM";
>> -			mem_size = resource_size(mem);
>> -			mem_bus_addr = mem->start - win->offset;
>> +			rockchip->mem_size = resource_size(mem);
>> +			rockchip->mem_bus_addr = mem->start - win->offset;
>>  			break;
>>  		case IORESOURCE_BUS:
>>  			rockchip->root_bus_nr = win->res->start;
>> @@ -1260,49 +1312,13 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>>  		}
>>  	}
>>
>> -	if (mem_size) {
>> -		for (reg_no = 0; reg_no < (mem_size >> 20); reg_no++) {
>> -			err = rockchip_pcie_prog_ob_atu(rockchip, reg_no + 1,
>> -							AXI_WRAPPER_MEM_WRITE,
>> -							20 - 1,
>> -							mem_bus_addr +
>> -							(reg_no << 20),
>> -							0);
>> -			if (err) {
>> -				dev_err(dev, "program RC mem outbound ATU failed\n");
>> -				goto err_vpcie;
>> -			}
>> -		}
>> -	}
>> -
>> -	err = rockchip_pcie_prog_ib_atu(rockchip, 2, 32 - 1, 0x0, 0);
>> -	if (err) {
>> -		dev_err(dev, "program RC mem inbound ATU failed\n");
>> +	err = rockchip_cfg_atu(rockchip);
>> +	if (err)
>>  		goto err_vpcie;
>> -	}
>> -
>> -	offset = mem_size >> 20;
>> -
>> -	if (io_size) {
>> -		for (reg_no = 0; reg_no < (io_size >> 20); reg_no++) {
>> -			err = rockchip_pcie_prog_ob_atu(rockchip,
>> -							reg_no + 1 + offset,
>> -							AXI_WRAPPER_IO_WRITE,
>> -							20 - 1,
>> -							io_bus_addr +
>> -							(reg_no << 20),
>> -							0);
>> -			if (err) {
>> -				dev_err(dev, "program RC io outbound ATU failed\n");
>> -				goto err_vpcie;
>> -			}
>> -		}
>> -	}
>> -
>>  	bus = pci_scan_root_bus(&pdev->dev, 0, &rockchip_pcie_ops, rockchip, &res);
>>  	if (!bus) {
>>  		err = -ENOMEM;
>> -		goto err_vpcie;
>> +		goto err_scan;
>>  	}
>>
>>  	pci_bus_size_bridges(bus);
>> @@ -1315,7 +1331,8 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>>  	dev_warn(dev, "only 32-bit config accesses supported; smaller writes may corrupt adjacent RW1C fields\n");
>>
>>  	return err;
>> -
>> +err_scan:
>> +	iounmap(rockchip->msg_region);
>>  err_vpcie:
>>  	if (!IS_ERR(rockchip->vpcie3v3))
>>  		regulator_disable(rockchip->vpcie3v3);
>> --
>> 1.9.1
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Best Regards
Shawn Lin

