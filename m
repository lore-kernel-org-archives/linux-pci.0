Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: generic: add description of property
 "interrupt-skip-mask"
To: Mark Rutland <mark.rutland@arm.com>
References: <1456401208-10136-1-git-send-email-thunder.leizhen@huawei.com>
 <1456401208-10136-2-git-send-email-thunder.leizhen@huawei.com>
 <20160225122035.GB10593@leverpostej>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Grant Likely <grant.likely@linaro.org>,
	Will Deacon <will.deacon@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	devicetree <devicetree@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Zefan Li <lizefan@huawei.com>, Xinwei Hu <huxinwei@huawei.com>,
	Tianhong Ding <dingtianhong@huawei.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <56CFFC9B.20703@huawei.com>
Date: Fri, 26 Feb 2016 15:19:55 +0800
MIME-Version: 1.0
In-Reply-To: <20160225122035.GB10593@leverpostej>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 2016/2/25 20:20, Mark Rutland wrote:
> Hi,
> 
> In future, please send the binding document first in a series, per point
> 3 of Documentation/devicetree/bindings/submitting-patches.txt. It makes
> review easier/faster.
Thank you for your reminding.

> 
> On Thu, Feb 25, 2016 at 07:53:28PM +0800, Zhen Lei wrote:
>> Interrupt Pin register is read-only and optional. Some pci devices may use
>> msi/msix but leave the value of Interrupt Pin non-zero.
> 
> Is that permitted by the spec? Surely 'optional' means it must be zero
> if not implemented?

In <PCI Local Bus Specification Revision 3.0>:
Devices (or device functions) that do not use an interrupt pin must put a 0 in this register. This register is read-only.

So, do you think this is a hardware bug? But these pci-devices are not produced by our company.

In function init_service_irqs, it try msix first, then msi, Interrupt PIN is the last attemption. But of_irq_parse_pci() happened before this.


In fact, there also a familiar problem exist. As below:
pci 0000:42:00.0: BAR 7: no space for [io  size 0x1000]
pci 0000:42:00.0: BAR 7: failed to assign [io  size 0x1000]

There no "io space" on arm64, maybe only exist on X86. And the Memory Space Indicator also read-only in BAR register.

> 
>> In this case, the driver will print information as below: pci
>> 0000:40:00.0: of_irq_parse_pci() failed with rc=-22
>>
>> It's easily lead to misinterpret.
> 
> If this is limited to a subset of devices which we know are broken in
> this regard, can we not handle these cases explicitly?
Actually, we have another way to block this warning. Use "interrupt-map" to map it to a pesudo IRQ. But I think it will also be misunderstanded.

> 
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  Documentation/devicetree/bindings/pci/host-generic-pci.txt | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.txt b/Documentation/devicetree/bindings/pci/host-generic-pci.txt
>> index 3f1d3fc..0f10978 100644
>> --- a/Documentation/devicetree/bindings/pci/host-generic-pci.txt
>> +++ b/Documentation/devicetree/bindings/pci/host-generic-pci.txt
>> @@ -70,6 +70,8 @@ Practice: Interrupt Mapping' and requires the following properties:
>>
>>  - interrupt-map-mask : <see aforementioned specification>
>>
>> +- interrupt-skip-mask: Explicitly declare which pci devices only use msi/msix
>> +but leave the value of Interrupt Pin non-zero.
> 
> Unlike the rest of the interrupt mapping properties, this is not
> described in  `Open Firmware Recommended Practice: Interrupt Mapping'.
> 
> This needs a far more complete description.
> 
> This also doesn't strike me as th right approach. The interrupt-map-mask
> property describe as relationship between the host-controller-provided
> interrupt lines and endpoints, while this seems to be a bug completely
> contained within an endpoint.

In <host-generic-pci.txt>:
// PCI_DEVICE(3)  INT#(1)  CONTROLLER(PHANDLE)  CONTROLLER_DATA(3)
    interrupt-map = <  0x0 0x0 0x0  0x1  &gic  0x0 0x4 0x1

PCI_DEVICE contain 3 cells. But only the first one be used in function of_irq_parse_pci.
laddr[0] = cpu_to_be32((pdev->bus->number << 16) | (pdev->devfn << 8));
laddr[1] = laddr[2] = cpu_to_be32(0);

And for INT#, I don't think there will some Pins used but others unused on a pci-device. So I can ommit it.

So, only laddr[0] mask need to be described.
> 
> Thanks,
> Mark.
> 
>>
>>  Example:
>>
>> --
>> 2.5.0
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> .
> 
