Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.138]:51226 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227AbcE0Kbe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 May 2016 06:31:34 -0400
Subject: Re: [PATCH 2/2] pci: Add PCIe driver for Rockchip Soc
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Shawn Lin <shawn.lin@rock-chips.com>
References: <1463740105-7061-1-git-send-email-shawn.lin@rock-chips.com>
 <1463740156-7148-1-git-send-email-shawn.lin@rock-chips.com>
 <9836736.6VjP1ug4kE@wuerfel> <5747EDC9.2080603@rock-chips.com>
 <8520D5D51A55D047800579B094147198258AF22F@XAP-PVEXMBX01.xlnx.xilinx.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Wenrui Li <wenrui.li@rock-chips.com>
Message-ID: <57482200.9090008@rock-chips.com>
Date: Fri, 27 May 2016 18:31:28 +0800
MIME-Version: 1.0
In-Reply-To: <8520D5D51A55D047800579B094147198258AF22F@XAP-PVEXMBX01.xlnx.xilinx.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On 2016/5/27 15:13, Bharat Kumar Gogada wrote:
>>>
>>>> +
>>>> +static int rockchip_pcie_rd_other_conf(struct rockchip_pcie_port *pp,
>>>> +				       struct pci_bus *bus, u32 devfn,
>>>> +				       int where, int size, u32 *val)
>>>> +{
>>>> +	u32 busdev;
>>>> +
>>>> +	busdev = PCIE_ECAM_ADDR(bus->number, PCI_SLOT(devfn),
>>>> +				PCI_FUNC(devfn), where);
>>>> +
>>>> +	if (busdev & (size - 1)) {
>>>> +		*val = 0;
>>>> +		return PCIBIOS_BAD_REGISTER_NUMBER;
>>>> +	}
>>>> +
>>>> +	if (size == 4) {
>>>> +		*val = readl(pp->reg_base + busdev);
>>>> +	} else if (size == 2) {
>>>> +		*val = readw(pp->reg_base + busdev);
>>>> +	} else if (size == 1) {
>>>> +		*val = readb(pp->reg_base + busdev);
>>>> +	} else {
>>>> +		*val = 0;
>>>> +		return PCIBIOS_BAD_REGISTER_NUMBER;
>>>> +	}
>>>> +	return PCIBIOS_SUCCESSFUL;
>>>> +}
>>>> +
>>>
>>> This looks like the normal ECAM operations, you could just call those.
>>
>> I read ECAM reference code, I found it not support ioremap config space
>> for each bus individually on 64-bit systems. Our soc is 64-bit system,
>> and bus0 config space base address is 0xfda00000, bus1 base address is
>> 0xf8100000. So I think it is not normal ECAM operations, I do not know
>> if I have understood correctly?
>>
> Hi,
>
> I think Arnd was suggesting to use generic config read/write calls, pci_generic_config_read/pci_generic_config_write
> which does above functionality.

Yeah, I seem the pci_generic_config_write use writew/writeb for byte and 
word write. but our SOC not support byte and word write in RC config 
spcace. So I redefine the the pci_ops.write

>
> Bharat
>
>
>

