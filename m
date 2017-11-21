Return-Path: <SRS0=32xe=CT=axis.com=niklas.cassel@kernel.org>
Return-Path: <SRS0=32xe=CT=axis.com=niklas.cassel@kernel.org>
Subject: Re: [PATCH v4 01/17] PCI: dwc: Use the DMA-API to get the MSI address
To: Joao Pinto <Joao.Pinto@synopsys.com>, Bjorn Helgaas <helgaas@kernel.org>
CC: Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20171103134722.5532-1-niklas.cassel@axis.com>
 <20171103134722.5532-2-niklas.cassel@axis.com>
 <20171108005614.GF22847@bhelgaas-glaptop.roam.corp.google.com>
 <1c059ad0-aa57-fca4-6d92-e68736ffad5f@synopsys.com>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <233b3102-0ca3-ca28-5b43-34e55a5c87c4@axis.com>
Date: Tue, 21 Nov 2017 13:18:18 +0100
MIME-Version: 1.0
In-Reply-To: <1c059ad0-aa57-fca4-6d92-e68736ffad5f@synopsys.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>

On 08/11/17 13:45, Joao Pinto wrote:
> Hello to all,
> 
> Às 12:56 AM de 11/8/2017, Bjorn Helgaas escreveu:
>> On Fri, Nov 03, 2017 at 02:47:05PM +0100, Niklas Cassel wrote:
>>> Use the DMA-API to get the MSI address. This address will be written to
>>> our PCI config space and to the register which determines which AXI
>>> address the DWC IP will spoof for incoming MSI irqs.
>>>
>>> Since it is a PCIe endpoint device, rather than the CPU, that is supposed
>>> to write to the MSI address, the proper way to get the MSI address is by
>>> using the DMA API, not by using virt_to_phys().
>>>
>>> Using virt_to_phys() might work on some systems, but using the DMA API
>>> should work on all systems.
>>>
>>> This is essentially the same thing as allocating a buffer in a driver
>>> to which the endpoint will write to. To do this, we use the DMA API.
>>>
>>> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
>>
>> I'm expecting Jingoo and/or Joao to chime in and ack the
>> DesignWare-related patches.  I think all the others are in
>> pretty good shape.
>>
>>> ---
>>>  drivers/pci/dwc/pcie-designware-host.c | 15 ++++++++++++---
>>>  drivers/pci/dwc/pcie-designware.h      |  3 ++-
>>>  2 files changed, 14 insertions(+), 4 deletions(-)
>>> ...
> 
> Let me test this patch-set in my setup first!
> I will give feedback until Friday.
> 

Hello Joao,

did you manage to find any time to test the designware
related patches?

If not, I posted a V5 yesterday, so in case you are still
planning on testing them, could you please test V5 instead?


Best regards,
Niklas
