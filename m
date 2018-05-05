Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v2 07/10] PCI: Convert of_pci_get_host_bridge_resources()
 users to devm variant
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <cover.1525067324.git.jan.kiszka@siemens.com>
 <ed3e6df4feca5febefa14716d62aaddd5b4a39d1.1525067324.git.jan.kiszka@siemens.com>
 <dbfa80fb-5fe8-3ccd-6886-4604ef9e058b@mentor.com>
 <20180504164401.GA17043@e107981-ln.cambridge.arm.com>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <0b7bf715-63dc-e2dc-a614-02d88bdc0254@mentor.com>
Date: Sat, 5 May 2018 10:42:16 +0300
MIME-Version: 1.0
In-Reply-To: <20180504164401.GA17043@e107981-ln.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 linux-pci@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On 05/04/2018 07:44 PM, Lorenzo Pieralisi wrote:
> On Thu, May 03, 2018 at 10:18:24AM +0300, Vladimir Zapolskiy wrote:
>> Hi Jan,
>>
>> On 04/30/2018 08:48 AM, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> Straightforward for all of them, no more leaks afterwards.
>>>
>>> CC: Jingoo Han <jingoohan1@gmail.com>
>>> CC: Joao Pinto <Joao.Pinto@synopsys.com>
>>> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> Acked-by: Jingoo Han <jingoo1han@gmail.com>
>>
>> [snip]
>>
>>> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
>>> index 6ab28f29ac6a..6eb36c924983 100644
>>> --- a/drivers/pci/host/pcie-rcar.c
>>> +++ b/drivers/pci/host/pcie-rcar.c
>>> @@ -1067,12 +1067,11 @@ static int rcar_pcie_parse_request_of_pci_ranges(struct rcar_pcie *pci)
>>>  {
>>>  	int err;
>>>  	struct device *dev = pci->dev;
>>> -	struct device_node *np = dev->of_node;
>>>  	resource_size_t iobase;
>>>  	struct resource_entry *win, *tmp;
>>>  
>>> -	err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pci->resources,
>>> -					       &iobase);
>>> +	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
>>> +						    &pci->resources, &iobase);
>>>  	if (err)
>>>  		return err;
>>>  
>>
>> this one snippet is obsoleted by https://patchwork.ozlabs.org/patch/904326/
>>
>> If 08/10 remains a deprecation, then it is sufficient to exclude the R-Car change,
>> otherwise I hope maintainers can deal with the proper ordering.
> 
> Isn't applying your patch:
> 
> https://patchwork.ozlabs.org/patch/904326/
> 
> and dropping the rcar hunk from this patch enough ?
> 

absolutely, but it relies on any of two assumptions that
* my unmodified change is applied first, then Jan's adjusted change is applied,
* Jan's unmodified change is applied first, then my adjusted change is applied.

Otherwise there will be a trivial merge conflict, or even worse, if R-Car hunk
is removed as suggested, then of_pci_get_host_bridge_resources() is removed
instead of deprecation, and then my unmodified change is applied on top, it will
result in a window of commits, where R-Car PCIe driver won't be buildable, and
git-bisect users can be disappointed.

It makes little sense to include my change into Jan's series, thus I rely on
maintainers' awareness and smooth resolution of the issue by maintainers.

For what it's worth, I vote for of_pci_get_host_bridge_resources() removal.

--
With best wishes,
Vladimir

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
