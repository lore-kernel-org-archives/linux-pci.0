Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jim Quinlan' <jim2101024@gmail.com>, Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH 5/9] PCI: host: brcmstb: add dma-ranges for inbound traffic
Date: Mon, 23 Oct 2017 09:06:03 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD009F05A@AcuExch.aculab.com>
References: <1507761269-7017-6-git-send-email-jim2101024@gmail.com>
 <589c04cb-061b-a453-3188-79324a02388e@arm.com>
 <20171017081422.GA19475@lst.de>
 <CANCKTBsCB+x2XgrND9AhRtxPkCXfps1nA+YymkZjKHOUZfjSHQ@mail.gmail.com>
 <20171018065316.GA11183@lst.de>
 <CANCKTBv+yiCNsrnx3m+W9wPqC4NdKPZ2p=zLtSa8fX6v1rPcYQ@mail.gmail.com>
 <20171019091644.GA14983@lst.de>
 <CANCKTBuaTD29My77QfOeUmtZfLAmmJXUYe6QvBW+uoH2Kb+tAQ@mail.gmail.com>
 <20171020073730.GA12937@lst.de>
 <CANCKTBsRRkwNMrxWjtgxbyZqT6NOxPX0NHDbnEO2BMjj8oVtpg@mail.gmail.com>
 <20171020145752.GA4694@lst.de>
 <CANCKTBtxp9gSdndKAZ7xGA+VozQsn2PX_-9P8A22_5Matbb7-w@mail.gmail.com>
In-Reply-To: <CANCKTBtxp9gSdndKAZ7xGA+VozQsn2PX_-9P8A22_5Matbb7-w@mail.gmail.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, Linux-MIPS <linux-mips@linux-mips.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 linux-pci <linux-pci@vger.kernel.org>, Kevin
 Cernekee <cernekee@gmail.com>, Will Deacon <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ralf
 Baechle <ralf@linux-mips.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Gregory
 Fong <gregory.0xf0@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Brian Norris <computersforpeace@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Jim Quinlan
> Sent: 20 October 2017 16:28
> On Fri, Oct 20, 2017 at 10:57 AM, Christoph Hellwig <hch@lst.de> wrote:
> > On Fri, Oct 20, 2017 at 10:41:56AM -0400, Jim Quinlan wrote:
> >> I am not sure I understand your comment -- the size of the request
> >> shouldn't be a factor.  Let's look at your example of the DMA request
> >> of 3fffff00 to 4000000f (physical memory).  Lets say it is for 15
> >> pages.  If we block out  the last page [0x3ffff000..0x3fffffff] from
> >> what is available, there is no 15 page span that can happen across the
> >> 0x40000000 boundary.  For SG, there can be no merge that connects a
> >> page from one region to another region.  Can you give an example of
> >> the scenario you are thinking of?
> >
> > What prevents a merge from say the regions of
> > 0....3fffffff and 40000000....7fffffff?
> 
> Huh? [0x3ffff000...x3ffffff] is not available to be used. Drawing from
> the original example, we now have to tell Linux that these are now our
> effective memory regions:
> 
>       memc0-a@[        0....3fffefff] <=> pci@[        0....3fffefff]
>       memc0-b@[100000000...13fffefff] <=> pci@[ 40000000....7fffefff]
>       memc1-a@[ 40000000....7fffefff] <=> pci@[ 80000000....bfffefff]
>       memc1-b@[300000000...33fffefff] <=> pci@[ c0000000....ffffefff]
>       memc2-a@[ 80000000....bfffefff] <=> pci@[100000000...13fffefff]
>       memc2-b@[c00000000...c3fffffff] <=> pci@[140000000...17fffffff]
> 
> This leaves a one-page gap between phsyical memory regions which would
> normally be contiguous. One cannot have a dma alloc that spans any two
> regions.  This is a drastic step, but I don't see an alternative.
> Perhaps  I may be missing what you are saying...

Isn't this all unnecessary?
Both kmalloc() and dma_alloc() are constrained to allocate memory
that doesn't cross an address boundary that is larger than the size.
So if you allocate 16k it won't cross a 16k physical address boundary.

	David

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
