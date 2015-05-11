Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35881 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243AbbEKP2P (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 May 2015 11:28:15 -0400
Received: by qku63 with SMTP id 63so88974498qku.3
        for <linux-pci@vger.kernel.org>; Mon, 11 May 2015 08:28:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150511143025.GD20282@l.oracle.com>
References: <1430505138-2877-1-git-send-email-wdavis@nvidia.com>
 <1430505138-2877-4-git-send-email-wdavis@nvidia.com> <20150507151905.GL24643@google.com>
 <20150511143025.GD20282@l.oracle.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 11 May 2015 10:27:53 -0500
Message-ID: <CAErSpo4gJDEbGYnG+drdT-x8Rc0wEGjzYYp2FXvGnAQ90pDw_g@mail.gmail.com>
Subject: Re: [PATCH 3/6] dma-mapping: pci: add pci_(un)map_resource
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: William Davis <wdavis@nvidia.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
	Jerome Glisse <jglisse@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Terence Ripperda <tripperda@nvidia.com>,
	Yinghai Lu <yinghai@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 11, 2015 at 9:30 AM, Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
> On Thu, May 07, 2015 at 10:19:05AM -0500, Bjorn Helgaas wrote:
>> [+cc Dave for sparc64, Yinghai]
>>
>> On Fri, May 01, 2015 at 01:32:15PM -0500, wdavis@nvidia.com wrote:
>> > From: Will Davis <wdavis@nvidia.com>
>> >
>> > Simply route these through to the new dma_(un)map_resource APIs.
>> >
>> > Signed-off-by: Will Davis <wdavis@nvidia.com>
>> > Reviewed-by: Terence Ripperda <tripperda@nvidia.com>
>> > Reviewed-by: John Hubbard <jhubbard@nvidia.com>
>> > ---
>> >  include/asm-generic/pci-dma-compat.h | 14 ++++++++++++++
>> >  1 file changed, 14 insertions(+)
>> >
>> > diff --git a/include/asm-generic/pci-dma-compat.h b/include/asm-generic/pci-dma-compat.h
>> > index c110843..ac4a4ad 100644
>> > --- a/include/asm-generic/pci-dma-compat.h
>> > +++ b/include/asm-generic/pci-dma-compat.h
>> > @@ -61,6 +61,20 @@ pci_unmap_page(struct pci_dev *hwdev, dma_addr_t dma_address,
>> >     dma_unmap_page(hwdev == NULL ? NULL : &hwdev->dev, dma_address, size, (enum dma_data_direction)direction);
>> >  }
>> >
>> > +static inline dma_addr_t
>> > +pci_map_resource(struct pci_dev *hwdev, struct resource *resource,
>> > +            unsigned long offset, size_t size, int direction)
>> > +{
>> > +   return dma_map_resource(hwdev == NULL ? NULL : &hwdev->dev, resource, offset, size, (enum dma_data_direction)direction);
>> > +}
>>
>> On sparc64, PCI bus addresses, e.g., raw BAR values, can be 64 bits wide,
>> but dma_addr_t is only 32 bits [1].  So dma_addr_t is a bit of a problem
>> here.  It's likely that we will add a pci_bus_addr_t, but that hasn't
>> happened yet [2].
>
> Why not just expand the 'dma_addr_t' to be unsigned long (if to support
> the T5-8 box)?

That would work, but would increase the kernel memory footprint [3].
I don't have numbers (maybe Dave does), but if it is really
significant, other platforms with IOMMUs might want to explore using a
dma_addr_t smaller than 64 bits, too.

>> [1] http://lkml.kernel.org/r/20150327.145016.86183910134380870.davem@davemloft.net
>> [2] http://lkml.kernel.org/r/1427857069-6789-2-git-send-email-yinghai@kernel.org

[3] http://lkml.kernel.org/r/20150403.124855.96516097693494126.davem@davemloft.net
