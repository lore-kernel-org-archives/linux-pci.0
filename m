Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <3aec823d-d3c7-03d3-68f7-963d3649c184@arm.com>
References: <1490419893-5073-1-git-send-email-oza.oza@broadcom.com>
 <1490419893-5073-3-git-send-email-oza.oza@broadcom.com>
 <CAL_Jsq+1f2pHEy7=2Q7xGYYJjuQk3rLHH4pPTKRVN4QTtSr4Kw@mail.gmail.com>
 <3aec823d-d3c7-03d3-68f7-963d3649c184@arm.com>
From: Oza Oza <oza.oza@broadcom.com>
Date: Tue, 28 Mar 2017 10:20:12 +0530
Message-ID: <CAMSpPPfkm=vbbNFnatqEgtUJ8m-fn7OvNKk_PPCCywwoq0vFWg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] of: fix node traversing in of_dma_get_range
To: Robin Murphy <robin.murphy@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Rob Herring <robh@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 "bcm-kernel-feedback-list@broadcom.com"
 <bcm-kernel-feedback-list@broadcom.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

please find my comments inline.

On Mon, Mar 27, 2017 at 8:15 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> Hi Rob,
>
> On 27/03/17 15:34, Rob Herring wrote:
>> On Sat, Mar 25, 2017 at 12:31 AM, Oza Pawandeep <oza.oza@broadcom.com> wrote:
>>> it jumps to the parent node without examining the child node.
>>> also with that, it throws "no dma-ranges found for node"
>>> for pci dma-ranges.
>>>
>>> this patch fixes device node traversing for dma-ranges.
>>
>> What's the DT look like that doesn't work?
>
> The problem is the bodge in pci_dma_configure() where we don't have an
> OF node for the actual device itself, so pass in the host bridge's OF
> node instead. This happens to work well enough for dma-coherent, but I
> don't think dma-ranges was even considered at the time.
>
> As it happens I'm currently halfway through writing an experiment
> wherein pci_dma_configure() creates a temporary child node for the
> of_dma_configure() call if no other suitable alternative (e.g. some
> intermediate bridge node) exists. How hard are you likely to NAK that
> approach? ;)
>
>> dma-ranges is supposed to be a bus property, not a device's property.
>> So looking at the parent is correct behavior generally.
>
> Indeed, this patch as-is will break currently correct DTs (because we
> won't find dma-ranges on the device, so will bail before even looking at
> the parent as we should).

current parsing of dma-ranges assume that dma-ranges always to be
found in parent node.

based on that, my thinking is following:
couple of options

1)
instead while(1)  some meaningful condition such as while(!node)
the following bail out is not required.
      if (!ranges)
           break;

2)
have check based on dt-property to distinguish between pci and handle
dma-ranges root bridge

but again these changes do not solve the entire problem for choosing
right dma_mask.
neither it actually correctly address root bridge pci dma-ranges.

and hence I have written
https://lkml.org/lkml/2017/3/27/540

my final take is: this function does not need to change, let it parse
memory mapped dma-ranges as it is doing.

I am more inclined to have generic pci dma-ranges and parsing.
which following already addresses.
https://lkml.org/lkml/2017/3/27/540

Regards,
Oza.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
