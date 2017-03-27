Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [RFC PATCH 3/3] of: fix node traversing in of_dma_get_range
To: Rob Herring <robh@kernel.org>, Oza Pawandeep <oza.oza@broadcom.com>
References: <1490419893-5073-1-git-send-email-oza.oza@broadcom.com>
 <1490419893-5073-3-git-send-email-oza.oza@broadcom.com>
 <CAL_Jsq+1f2pHEy7=2Q7xGYYJjuQk3rLHH4pPTKRVN4QTtSr4Kw@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <3aec823d-d3c7-03d3-68f7-963d3649c184@arm.com>
Date: Mon, 27 Mar 2017 15:45:05 +0100
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+1f2pHEy7=2Q7xGYYJjuQk3rLHH4pPTKRVN4QTtSr4Kw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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

Hi Rob,

On 27/03/17 15:34, Rob Herring wrote:
> On Sat, Mar 25, 2017 at 12:31 AM, Oza Pawandeep <oza.oza@broadcom.com> wrote:
>> it jumps to the parent node without examining the child node.
>> also with that, it throws "no dma-ranges found for node"
>> for pci dma-ranges.
>>
>> this patch fixes device node traversing for dma-ranges.
> 
> What's the DT look like that doesn't work?

The problem is the bodge in pci_dma_configure() where we don't have an
OF node for the actual device itself, so pass in the host bridge's OF
node instead. This happens to work well enough for dma-coherent, but I
don't think dma-ranges was even considered at the time.

As it happens I'm currently halfway through writing an experiment
wherein pci_dma_configure() creates a temporary child node for the
of_dma_configure() call if no other suitable alternative (e.g. some
intermediate bridge node) exists. How hard are you likely to NAK that
approach? ;)

> dma-ranges is supposed to be a bus property, not a device's property.
> So looking at the parent is correct behavior generally.

Indeed, this patch as-is will break currently correct DTs (because we
won't find dma-ranges on the device, so will bail before even looking at
the parent as we should).

Robin.

> 
> Rob
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
