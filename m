Return-Path: <SRS0=YFOV=CH=axis.com=niklas.cassel@kernel.org>
Return-Path: <SRS0=YFOV=CH=axis.com=niklas.cassel@kernel.org>
Subject: Re: [PATCH v4 01/17] PCI: dwc: Use the DMA-API to get the MSI address
To: Bjorn Helgaas <helgaas@kernel.org>, Joao Pinto <Joao.Pinto@synopsys.com>
CC: Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20171103134722.5532-1-niklas.cassel@axis.com>
 <20171103134722.5532-2-niklas.cassel@axis.com>
 <20171108005614.GF22847@bhelgaas-glaptop.roam.corp.google.com>
 <1c059ad0-aa57-fca4-6d92-e68736ffad5f@synopsys.com>
 <20171108172745.GD28427@bhelgaas-glaptop.roam.corp.google.com>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <7b41b35f-b815-d708-08ef-a13b172780c1@axis.com>
Date: Thu, 9 Nov 2017 10:20:58 +0100
MIME-Version: 1.0
In-Reply-To: <20171108172745.GD28427@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>

On 11/08/2017 06:27 PM, Bjorn Helgaas wrote:
> On Wed, Nov 08, 2017 at 12:45:49PM +0000, Joao Pinto wrote:
>> Hello to all,
>>
>> Às 12:56 AM de 11/8/2017, Bjorn Helgaas escreveu:
>>> On Fri, Nov 03, 2017 at 02:47:05PM +0100, Niklas Cassel wrote:
>>>> Use the DMA-API to get the MSI address. This address will be written to
>>>> our PCI config space and to the register which determines which AXI
>>>> address the DWC IP will spoof for incoming MSI irqs.
>>>>
>>>> Since it is a PCIe endpoint device, rather than the CPU, that is supposed
>>>> to write to the MSI address, the proper way to get the MSI address is by
>>>> using the DMA API, not by using virt_to_phys().
>>>>
>>>> Using virt_to_phys() might work on some systems, but using the DMA API
>>>> should work on all systems.
>>>>
>>>> This is essentially the same thing as allocating a buffer in a driver
>>>> to which the endpoint will write to. To do this, we use the DMA API.
>>>>
>>>> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
>>>
>>> I'm expecting Jingoo and/or Joao to chime in and ack the
>>> DesignWare-related patches.  I think all the others are in
>>> pretty good shape.
>>>
>>>> ---
>>>>  drivers/pci/dwc/pcie-designware-host.c | 15 ++++++++++++---
>>>>  drivers/pci/dwc/pcie-designware.h      |  3 ++-
>>>>  2 files changed, 14 insertions(+), 4 deletions(-)
>>>> ...
>>
>> Let me test this patch-set in my setup first!
>> I will give feedback until Friday.
> 
> OK, thanks.  This may push this series out until v4.16 because the
> v4.15 merge window will probably open Sunday, and I don't like to add
> code during the window and merge it immediately.
> 

I suspected as much. The general rule seems to be that
a patch has to be in linux-next for at least 2 weeks
before sending it to Linus.

No worries, there is not really a rush.

Regards,
Niklas
