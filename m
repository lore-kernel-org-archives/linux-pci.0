Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 13/20] PCI: iproc-platform: update PCI config space remap
 function
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
 <20170227151436.18698-14-lorenzo.pieralisi@arm.com>
 <84a0b24b-3c88-b750-dd9e-1607bc67a0a8@broadcom.com>
 <20170228105428.GD7439@red-moon>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <e6ce59d4-59af-7c18-4589-342ac08aa88c@broadcom.com>
Date: Tue, 28 Feb 2017 09:42:20 -0800
MIME-Version: 1.0
In-Reply-To: <20170228105428.GD7439@red-moon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arch@vger.kernel.org, Jon Mason <jonmason@broadcom.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ray Jui <rjui@broadcom.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>



On 2/28/2017 2:54 AM, Lorenzo Pieralisi wrote:
> Hi Ray,
> 
> On Mon, Feb 27, 2017 at 01:21:39PM -0800, Ray Jui wrote:
>> Hi Lorenzo,
>>
>> On 2/27/2017 7:14 AM, Lorenzo Pieralisi wrote:
>>> PCI configuration space should be mapped with a memory region type that
>>> generates on the CPU host bus non-posted write transations. Update the
>>> driver to use the devm_pci_remap_cfg* interface to make sure the correct
>>> memory mappings for PCI configuration space are used.
>>>
>>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>> Cc: Ray Jui <rjui@broadcom.com>
>>> Cc: Jon Mason <jonmason@broadcom.com>
>>> ---
>>>  drivers/pci/host/pcie-iproc-platform.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/host/pcie-iproc-platform.c
>>> index f4909bb..b48d0db 100644
>>> --- a/drivers/pci/host/pcie-iproc-platform.c
>>> +++ b/drivers/pci/host/pcie-iproc-platform.c
>>> @@ -67,7 +67,8 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
>>>  		return ret;
>>>  	}
>>>  
>>> -	pcie->base = devm_ioremap(dev, reg.start, resource_size(&reg));
>>> +	pcie->base = devm_pci_remap_cfgspace(dev, reg.start,
>>> +					     resource_size(&reg));
>>
>> Note these are NOT config space registers; instead, they are host
>> controller registers. iProc PCIe controller access config space
>> registers indirectly through two of the controller registers instead of
>> directly mapped.
> 
> Yes but IIUC those registers that allow indirection live in the address
> space pointed at by pcie->base, right ? Question is whether it is fine
> to access those registers through mappings resulting on posted writes
> and that's a question I need your help to answer as I said in the cover
> letter.

This I'll need to check with our ASIC team, and it may take a while.

Note indirect access to the config registers is done with two registers
within pcie->base, one specifies the
address/bus/device/function/read/write direction and the other specifies
the data. All other registers in the block pointed to by pcie->base
really have nothing to do with config register access. They are used for
other block related configurations.

Thanks,

Ray

> 
> Thanks a lot for flagging this up, that's exactly the feedback I need.
> 
> Lorenzo
> 
>>
>> Thanks,
>>
>> Ray
>>
>>>  	if (!pcie->base) {
>>>  		dev_err(dev, "unable to map controller registers\n");
>>>  		return -ENOMEM;
>>>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
