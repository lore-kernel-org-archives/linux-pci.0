Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:37723 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757705AbcFAJ5l (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2016 05:57:41 -0400
Subject: Re: [PATCH 2/2] pci: Add PCIe driver for Rockchip Soc
To: Arnd Bergmann <arnd@arndb.de>, Wenrui Li <wenrui.li@rock-chips.com>
References: <1463740105-7061-1-git-send-email-shawn.lin@rock-chips.com>
 <8520D5D51A55D047800579B094147198258AF22F@XAP-PVEXMBX01.xlnx.xilinx.com>
 <57482200.9090008@rock-chips.com> <4816755.yFEaWXVu6I@wuerfel>
Cc: shawn.lin@rock-chips.com,
	Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <edd7ae48-fb73-41dd-51b7-6d61d1e92ae7@rock-chips.com>
Date: Wed, 1 Jun 2016 17:57:25 +0800
MIME-Version: 1.0
In-Reply-To: <4816755.yFEaWXVu6I@wuerfel>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

On 2016/6/1 16:24, Arnd Bergmann wrote:
> On Friday, May 27, 2016 6:31:28 PM CEST Wenrui Li wrote:
>> Hi,
>>
>> On 2016/5/27 15:13, Bharat Kumar Gogada wrote:
>>>>>
>>>>>> +
>>>>>> +static int rockchip_pcie_rd_other_conf(struct rockchip_pcie_port *pp,
>>>>>> +                                 struct pci_bus *bus, u32 devfn,
>>>>>> +                                 int where, int size, u32 *val)
>>>>>> +{
>>>>>> +  u32 busdev;
>>>>>> +
>>>>>> +  busdev = PCIE_ECAM_ADDR(bus->number, PCI_SLOT(devfn),
>>>>>> +                          PCI_FUNC(devfn), where);
>>>>>> +
>>>>>> +  if (busdev & (size - 1)) {
>>>>>> +          *val = 0;
>>>>>> +          return PCIBIOS_BAD_REGISTER_NUMBER;
>>>>>> +  }
>>>>>> +
>>>>>> +  if (size == 4) {
>>>>>> +          *val = readl(pp->reg_base + busdev);
>>>>>> +  } else if (size == 2) {
>>>>>> +          *val = readw(pp->reg_base + busdev);
>>>>>> +  } else if (size == 1) {
>>>>>> +          *val = readb(pp->reg_base + busdev);
>>>>>> +  } else {
>>>>>> +          *val = 0;
>>>>>> +          return PCIBIOS_BAD_REGISTER_NUMBER;
>>>>>> +  }
>>>>>> +  return PCIBIOS_SUCCESSFUL;
>>>>>> +}
>>>>>> +
>>>>>
>>>>> This looks like the normal ECAM operations, you could just call those.
>>>>
>>>> I read ECAM reference code, I found it not support ioremap config space
>>>> for each bus individually on 64-bit systems. Our soc is 64-bit system,
>>>> and bus0 config space base address is 0xfda00000, bus1 base address is
>>>> 0xf8100000. So I think it is not normal ECAM operations, I do not know
>>>> if I have understood correctly?
>>>>
>>> Hi,
>>>
>>> I think Arnd was suggesting to use generic config read/write calls, pci_generic_config_read/pci_generic_config_write
>>> which does above functionality.
>>
>> Yeah, I seem the pci_generic_config_write use writew/writeb for byte and
>> word write. but our SOC not support byte and word write in RC config
>> spcace. So I redefine the the pci_ops.write
>
> Rihgt, that bug should be documented somewhere. You can also use
> the pci_generic_config_read32/pci_generic_config_write32 functions
> for this.
>
> I wonder if we should add a more general way of treating type 1
> config space accesses differently, as a lot of host bridges have
> similar requirements, accessing the registers in a different place,
> different layout, or other constraints.

yes, that is what we need and we believe other host bridges have
this requirements.  With your patch applied, we only need to
implement our map0 callback here. Thanks for improving it.

BTW, would you mind that we pack your patch into my patchset for
the next version if possible, or maybe you wanna upstream it
by yourself? :)


Thanks.

>
> The patch below would make that very easy to do. Suggestions for
> better naming welcome.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index d11cdbb8fba3..2f7dcaa63e1d 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -34,9 +34,12 @@ int pci_bus_read_config_##size \
>  	u32 data = 0;							\
>  	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
>  	raw_spin_lock_irqsave(&pci_lock, flags);			\
> -	res = bus->ops->read(bus, devfn, pos, len, &data);		\
> +	if (bus->number == 0 && bus->ops->read0)			\
> +		res = bus->ops->read0(bus, devfn, pos, len, &data);	\
> +	else								\
> +		res = bus->ops->read(bus, devfn, pos, len, &data);	\
>  	*value = (type)data;						\
> -	raw_spin_unlock_irqrestore(&pci_lock, flags);		\
> +	raw_spin_unlock_irqrestore(&pci_lock, flags);			\
>  	return res;							\
>  }
>
> @@ -48,8 +51,11 @@ int pci_bus_write_config_##size \
>  	unsigned long flags;						\
>  	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
>  	raw_spin_lock_irqsave(&pci_lock, flags);			\
> -	res = bus->ops->write(bus, devfn, pos, len, value);		\
> -	raw_spin_unlock_irqrestore(&pci_lock, flags);		\
> +	if (bus->number == 0 && bus->ops->write0)			\
> +		res = bus->ops->write0(bus, devfn, pos, len, value);	\
> +	else								\
> +		res = bus->ops->write(bus, devfn, pos, len, value);	\
> +	raw_spin_unlock_irqrestore(&pci_lock, flags);			\
>  	return res;							\
>  }
>
> @@ -72,7 +78,11 @@ int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
>  {
>  	void __iomem *addr;
>
> -	addr = bus->ops->map_bus(bus, devfn, where);
> +	if (bus->number == 0 && bus->ops->map_bus0)
> +		addr = bus->ops->map_bus0(bus, devfn, where);
> +	else
> +		addr = bus->ops->map_bus(bus, devfn, where);
> +
>  	if (!addr) {
>  		*val = ~0;
>  		return PCIBIOS_DEVICE_NOT_FOUND;
> @@ -94,7 +104,10 @@ int pci_generic_config_write(struct pci_bus *bus, unsigned int devfn,
>  {
>  	void __iomem *addr;
>
> -	addr = bus->ops->map_bus(bus, devfn, where);
> +	if (bus->number == 0 && bus->ops->map_bus0)
> +		addr = bus->ops->map_bus0(bus, devfn, where);
> +	else
> +		addr = bus->ops->map_bus(bus, devfn, where);
>  	if (!addr)
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>
> @@ -114,7 +127,10 @@ int pci_generic_config_read32(struct pci_bus *bus, unsigned int devfn,
>  {
>  	void __iomem *addr;
>
> -	addr = bus->ops->map_bus(bus, devfn, where & ~0x3);
> +	if (bus->number == 0 && bus->ops->map_bus0)
> +		addr = bus->ops->map_bus0(bus, devfn, where);
> +	else
> +		addr = bus->ops->map_bus(bus, devfn, where & ~0x3);
>  	if (!addr) {
>  		*val = ~0;
>  		return PCIBIOS_DEVICE_NOT_FOUND;
> @@ -135,7 +151,10 @@ int pci_generic_config_write32(struct pci_bus *bus, unsigned int devfn,
>  	void __iomem *addr;
>  	u32 mask, tmp;
>
> -	addr = bus->ops->map_bus(bus, devfn, where & ~0x3);
> +	if (bus->number == 0 && bus->ops->map_bus0)
> +		addr = bus->ops->map_bus0(bus, devfn, where);
> +	else
> +		addr = bus->ops->map_bus(bus, devfn, where & ~0x3);
>  	if (!addr)
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index df41c4645911..1caae3bd7115 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -580,6 +580,9 @@ struct pci_ops {
>  	void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
>  	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
>  	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
> +	void __iomem *(*map_bus0)(struct pci_bus *bus, unsigned int devfn, int where);
> +	int (*read0)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
> +	int (*write0)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
>  };
>
>  /*
>
>
>
>


-- 
Best Regards
Shawn Lin

