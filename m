Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 1/3] of/pci/dma: fix DMA configuration for PCI masters
To: Oza Oza <oza.oza@broadcom.com>
References: <1493786795-28153-1-git-send-email-oza.oza@broadcom.com>
 <d7203258-e39a-a59b-d14f-c0c92a1d3f41@arm.com>
 <CAMSpPPcC6wN+2HeZPak+gWxoy2WaO14epHNQfHT1W0FnTRHnOQ@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <48cd8da2-5928-3d5d-0f07-dfdb83f50ccb@arm.com>
Date: Fri, 5 May 2017 16:25:30 +0100
MIME-Version: 1.0
In-Reply-To: <CAMSpPPcC6wN+2HeZPak+gWxoy2WaO14epHNQfHT1W0FnTRHnOQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Oza Pawandeep <oza.pawandeep@gmail.com>,
 linux-pci@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 linux-kernel@vger.kernel.org, Linux IOMMU <iommu@lists.linux-foundation.org>,
 BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 04/05/17 19:41, Oza Oza wrote:
[...]
>>> 5) leaves scope of adding PCI flag handling for inbound memory
>>> by the new function.
>>
>> Which flags would ever actually matter? DMA windows aren't going to be
>> to config or I/O space, so the memory type can be assumed, and the
>> 32/64-bit distinction is irrelevant as it's not a relocatable BAR;
>> DMA-able system memory isn't going to be read-sensitive, so the
>> prefetchable flag shouldn't matter; and not being a BAR none of the
>> others would be relevant either.
>>
> 
> Thanks Robin; for your reply and attention:
> 
> agree with you, at present it would not matter,
> but it does not mean that we do not scope it to make it matter in future.
> 
> now where it could matter:
> there is Relaxed Ordering for inbound memory for PCI.
> According to standard, Relaxed Ordering (RO) bit can be set only for
> Memory requests and completions (if present in the original request).
> Also, according to transaction ordering rules, I/O and configuration
> requests can still be re-ordered ahead of each other.
> and we would like to make use of it.
> for e.g. lets say we mark memory as Relaxed Ordered with flag.
> the special about this memory is incoming PCI transactions can be
> reordered and rest memory has to be strongly ordered.

Please look at "PCI Bus Binding to: IEEE Std 1275-1994 Standard for Boot
(Initialization Configuration) Firmware" (as referenced in DTSpec) and
explain how PCIe Relaxed Order has anything to do with the DT binding.

> how it our SOC would make use of this is out of scope for the
> discussion at this point of time, but I am just bringing in the
> idea/point how flags could be useful
> for inbound memory, since we would not like throw-away flags completely.

The premise for implementing a PCI-specific parser is that you claim we
need to do something with the phys.hi cell of a DT PCI address, rather
than just taking the numerical part out of the phys.mid and phys.lo
cells. Please make that argument in reference to the flags which that
upper cell actually encodes, not unrelated things.

[...]
>>> +int of_pci_get_dma_ranges(struct device_node *np, struct list_head *resources)
>>> +{
>>> +     struct device_node *node = of_node_get(np);
>>> +     int rlen;
>>> +     int ret = 0;
>>> +     const int na = 3, ns = 2;
>>> +     struct resource *res;
>>> +     struct of_pci_range_parser parser;
>>> +     struct of_pci_range range;
>>> +
>>> +     if (!node)
>>> +             return -EINVAL;
>>> +
>>> +     parser.node = node;
>>> +     parser.pna = of_n_addr_cells(node);
>>> +     parser.np = parser.pna + na + ns;
>>> +
>>> +     parser.range = of_get_property(node, "dma-ranges", &rlen);
>>> +
>>> +     if (!parser.range) {
>>> +             pr_debug("pcie device has no dma-ranges defined for node(%s)\n",
>>> +                       np->full_name);
>>> +             ret = -EINVAL;
>>> +             goto out;
>>> +     }
>>> +
>>> +     parser.end = parser.range + rlen / sizeof(__be32);
>>> +
>>> +     for_each_of_pci_range(&parser, &range) {
>>
>> This is plain wrong - of_pci_range_parser_one() will translate upwards
>> through parent "ranges" properties, which is completely backwards for
>> DMA addresses.
>>
>> Robin.
>>
> 
> No it does not, this patch is thoroughly tested on our SOC and it works.
> of_pci_range_parser_one does not translate upwards through parent. it
> just sticks to given PCI parser.

Frankly, I'm losing patience with this attitude. Please look at the code
you call:

#define for_each_of_pci_range(parser, range) \
	for (; of_pci_range_parser_one(parser, range);)


struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser
*parser,
						struct of_pci_range *range)
{
	const int na = 3, ns = 2;

	if (!range)
		return NULL;

	if (!parser->range || parser->range + parser->np > parser->end)
		return NULL;

	range->pci_space = parser->range[0];
	range->flags = of_bus_pci_get_flags(parser->range);
	range->pci_addr = of_read_number(parser->range + 1, ns);
	range->cpu_addr = of_translate_address(parser->node,
				parser->range + na);
...


u64 of_translate_address(struct device_node *dev, const __be32 *in_addr)
{
	return __of_translate_address(dev, in_addr, "ranges");
}


I don't doubt that you still manage to get the right result on *your*
SoC, because you probably have neither further "ranges" nor "dma-ranges"
translations above your host controller node anyway. That does not
change the fact that the proposed code is still obviously wrong for more
complex DT topologies that do.

We're doing upstream work in core code here: I don't particularly care
about making your SoC work; I don't really care about making Juno work
properly either; what I do care about is that code to parse dma-ranges
actually parses dma-ranges *correctly* for all possible valid uses of
dma-ranges, which means fixing the existing bugs and not introducing
more. The principal side-effect of that is that *all* systems with valid
DTs will then work correctly.

Robin.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
