Return-Path: <SRS0=VCL4=73=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=VCL4=73=free.fr=slash.tmp@kernel.org>
Subject: Re: [pci:pci/host-mediatek 11/11]
 drivers/pci/host/pcie-mediatek.c:541:43: error: 'node' undeclared
To: Bjorn Helgaas <helgaas@kernel.org>, mtk11102 <honghui.zhang@mediatek.com>
Cc: kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org,
 linux-pci <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
References: <201708232205.SymULNVt%fengguang.wu@intel.com>
 <20170823225211.GI8498@bhelgaas-glaptop.roam.corp.google.com>
 <1503544447.19072.7.camel@mhfsdcap03>
 <20170824134451.GA31858@bhelgaas-glaptop.roam.corp.google.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <f3b302a9-d478-96b5-98d0-49d4d4433358@free.fr>
Date: Fri, 25 Aug 2017 12:01:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170824134451.GA31858@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On 24/08/2017 15:44, Bjorn Helgaas wrote:

> On Thu, Aug 24, 2017 at 11:14:07AM +0800, mtk11102 wrote:
>
>> @@ -531,8 +533,10 @@ static const struct irq_domain_ops msi_domain_ops =
>> {
>>  static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
>>  {
>>         u32 val;
>> +       phys_addr_t msg_addr;
>>
>> -       val = lower_32_bits((u64)(port->base + PCIE_MSI_VECTOR));
>> +       msg_addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
>> +       val = lower_32_bits(msg_addr);
>>         writel(val, port->base + PCIE_IMSI_ADDR);
>>
>>         val = readl(port->base + PCIE_INT_MASK);
> 
> I don't think this is quite right: virt_to_phys() converts a CPU
> virtual address to a CPU physical address, but the msg_addr is a PCI
> bus address.  In many cases, PCI bus addresses are identical to CPU
> physical addresses, but not always.

Is the virt_to_bus() function not appropriate?

Regards.
