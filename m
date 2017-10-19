Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20171019091644.GA14983@lst.de>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
 <1507761269-7017-6-git-send-email-jim2101024@gmail.com>
 <589c04cb-061b-a453-3188-79324a02388e@arm.com>
 <20171017081422.GA19475@lst.de>
 <CANCKTBsCB+x2XgrND9AhRtxPkCXfps1nA+YymkZjKHOUZfjSHQ@mail.gmail.com>
 <20171018065316.GA11183@lst.de>
 <CANCKTBv+yiCNsrnx3m+W9wPqC4NdKPZ2p=zLtSa8fX6v1rPcYQ@mail.gmail.com>
 <20171019091644.GA14983@lst.de>
From: Jim Quinlan <jim2101024@gmail.com>
Date: Thu, 19 Oct 2017 18:47:45 -0400
Message-ID: <CANCKTBuaTD29My77QfOeUmtZfLAmmJXUYe6QvBW+uoH2Kb+tAQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] PCI: host: brcmstb: add dma-ranges for inbound traffic
To: Christoph Hellwig <hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
 Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org,
 linux-pci <linux-pci@vger.kernel.org>, Kevin Cernekee <cernekee@gmail.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>,
 bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
 Gregory Fong <gregory.0xf0@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Brian Norris <computersforpeace@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 19, 2017 at 5:16 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Wed, Oct 18, 2017 at 10:41:17AM -0400, Jim Quinlan wrote:
>> That's what brcm_to_{pci,cpu} are for -- they keep a list of the
>> dma-ranges given in the PCIe DT node, and translate from system memory
>> addresses to pci-space addresses, and vice versa.  As long as people
>> are using the DMA API it should work.  It works for all of the ARM,
>> ARM64, and MIPS Broadcom systems I've tested, using eight different EP
>> devices.  Note that I am not thrilled to be advocating this mechanism
>> but it seemed the best alternative.
>
> Say we are using your original example ranges:
>
>  memc0-a@[        0....3fffffff] <=> pci@[        0....3fffffff]
>  memc0-b@[100000000...13fffffff] <=> pci@[ 40000000....7fffffff]
>  memc1-a@[ 40000000....7fffffff] <=> pci@[ 80000000....bfffffff]
>  memc1-b@[300000000...33fffffff] <=> pci@[ c0000000....ffffffff]
>  memc2-a@[ 80000000....bfffffff] <=> pci@[100000000...13fffffff]
>  memc2-b@[c00000000...c3fffffff] <=> pci@[140000000...17fffffff]
>
> and now you get a dma mapping request for physical addresses
> 3fffff00 to 4000000f, which would span two of your ranges.  How
> is this going to work?

The only way to prevent this is to reserve a single page at the end of
the first memory region of any pair that are adjacent in physical
memory.  A hack, yes, but I don't see an easier way out of this.  Many
if not most of our boards do not have adjacent regions and would not
need this.

Overriding phys_to_dma/dma_to_phys comes with the same overlap problem
(MIPS solution and possible ARM/ARM64 solution).

>
>> I would prefer that the same code work for all three architectures.
>> What I would like from ARM/ARM64 is the ability to override
>> phys_to_dma() and dma_to_phys(); I thought the chances of that being
>> accepted would be slim.  But you are right, I should ask the
>> maintainers.
>
> It is still better than trying to stack dma ops, which is a receipe
> for problems down the road.

Let me send out V2 of my patchset and also send it to the ARM/ARM64
maintainers as you suggested; perhaps there is an alternative.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
