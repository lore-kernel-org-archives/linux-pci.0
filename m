Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20171017081422.GA19475@lst.de>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
 <1507761269-7017-6-git-send-email-jim2101024@gmail.com>
 <589c04cb-061b-a453-3188-79324a02388e@arm.com>
 <20171017081422.GA19475@lst.de>
From: Jim Quinlan <jim2101024@gmail.com>
Date: Tue, 17 Oct 2017 12:11:55 -0400
Message-ID: <CANCKTBsCB+x2XgrND9AhRtxPkCXfps1nA+YymkZjKHOUZfjSHQ@mail.gmail.com>
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

On Tue, Oct 17, 2017 at 4:14 AM, Christoph Hellwig <hch@lst.de> wrote:
> Just took a quick look over this and I basically agree with the comments
> from Robin.
>
> What I don't understand is why you're even trying to do all these
> hacky things.
>
> It seems like the controller should simply set dma_pfn_offset for
> each device hanging off it, and all the supported architectures
> should be updated to obey that if they don't do so yet, and
> you're done without needing this giant mess.

My understanding is that dma_pfn_offset is that it is a single
constant offset from RAM, in our case, to map to PCIe space.  But in
my commit message I detail how our PCIe controller presents memory
with multiple regions with multiple different offsets. If an EP device
maps to a region on the host memory, yes we can set the dma_pfn_offset
for that device for that location within that range,.  But if the
device then unmaps and allocates from another region with a different
offset, it won't work.  If  I set dma_pfn_offset I have to assume that
the device is using only one region of memory only, not more than one,
and that it is not unmapping that region and mapping another (with a
different offset).  Can I make those assumptions?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
