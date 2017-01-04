Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 1/2] arm64: dma_mapping: allow PCI host driver to limit
 DMA mask
To: Arnd Bergmann <arnd@arndb.de>
References: <1483044304-2085-1-git-send-email-nikita.yoush@cogentembedded.com>
 <2104402.puPT8SttTe@wuerfel>
 <412396ac-4535-08a3-e4c7-dd8d0078a518@cogentembedded.com>
 <3158203.Yc9Qgx82xo@wuerfel>
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Message-ID: <9d5e32d3-000c-2f95-7ea8-c64d53ab6b56@cogentembedded.com>
Date: Wed, 4 Jan 2017 18:29:39 +0300
MIME-Version: 1.0
In-Reply-To: <3158203.Yc9Qgx82xo@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 artemi.ivanov@cogentembedded.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

>>>> For OF platforms, this is called via of_dma_configure(), that checks
>>>> dma-ranges of node that is *parent* for host bridge. Host bridge
>>>> currently does not control this at all.
>>>
>>> We need to think about this a bit. Is it actually the PCI host
>>> bridge that limits the ranges here, or the bus that it is connected
>>> to. In the latter case, the caller needs to be adapted to handle
>>> both.
>>
>> In r-car case, I'm not sure what is the source of limitation at physical
>> level.
>>
>> pcie-rcar driver configures ranges for PCIe inbound transactions based
>> on dma-ranges property in it's device tree node. In the current device
>> tree for this platform, that only contains one range and it is in lower
>> memory.
>>
>> NVMe driver tries i/o to kmalloc()ed area. That returns 0x5xxxxxxxx
>> addresses here. As a quick experiment, I tried to add second range to
>> pcie-rcar's dma-ranges to cover 0x5xxxxxxxx area - but that did not make
>> DMA to high addresses working.
>>
>> My current understanding is that host bridge hardware module can't
>> handle inbound transactions to PCI addresses above 4G - and this
>> limitations comes from host bridge itself.
>>
>> I've read somewhere in the lists that pcie-rcar hardware is "32-bit" -
>> but I don't remember where, and don't know lowlevel details. Maybe
>> somebody from linux-renesas can elaborate?
> 
> Just a guess, but if the inbound translation windows in the host
> bridge are wider than 32-bit, the reason for setting up a single
> 32-bit window is probably because that is what the parent bus supports.

Well anyway applying patch similar to your's will fix pcie-rcar + nvme
case - thus I don't object :)   But it can break other cases ...

But why do you hook at set_dma_mask() and overwrite mask inside, instead
of hooking at dma_supported() and rejecting unsupported mask?

I think later is better, because it lets drivers to handle unsupported
high-dma case, like documented in DMA-API_HOWTO.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
