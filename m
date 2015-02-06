Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:42337 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389AbbBFPMW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Feb 2015 10:12:22 -0500
Date: Fri, 6 Feb 2015 15:12:10 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <Will.Deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>
Subject: Re: [PATCH v6 3/7] of: fix size when dma-range is not used
Message-ID: <20150206151210.GC23190@e104818-lin.cambridge.arm.com>
References: <1423173179-10227-1-git-send-email-m-karicheri2@ti.com>
 <1423173179-10227-4-git-send-email-m-karicheri2@ti.com>
 <20150206143812.GB20549@localhost>
 <54D4D59F.6050408@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54D4D59F.6050408@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 06, 2015 at 02:54:23PM +0000, Murali Karicheri wrote:
> On 02/06/2015 09:38 AM, Catalin Marinas wrote:
> > On Thu, Feb 05, 2015 at 09:52:55PM +0000, Murali Karicheri wrote:
> >> Fix the dma-range size when the DT attribute is missing. i.e  set size to
> >> dev->coherent_dma_mask + 1 instead of dev->coherent_dma_mask. Also add
> >> code to check invalid values of size configured in DT and log error.
> >>
> >> Cc: Joerg Roedel<joro@8bytes.org>
> >> Cc: Grant Likely<grant.likely@linaro.org>
> >> Cc: Rob Herring<robh+dt@kernel.org>
> >> Cc: Bjorn Helgaas<bhelgaas@google.com>
> >> Cc: Will Deacon<will.deacon@arm.com>
> >> Cc: Russell King<linux@arm.linux.org.uk>
> >> Cc: Arnd Bergmann<arnd@arndb.de>
> >> Cc: Suravee Suthikulpanit<Suravee.Suthikulpanit@amd.com>
> >>
> >> Signed-off-by: Murali Karicheri<m-karicheri2@ti.com>
> >> ---
> >>   drivers/of/device.c |   17 ++++++++++++++++-
> >>   1 file changed, 16 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/of/device.c b/drivers/of/device.c
> >> index 2de320d..314c8a9 100644
> >> --- a/drivers/of/device.c
> >> +++ b/drivers/of/device.c
> >> @@ -105,9 +105,24 @@ void of_dma_configure(struct device *dev, struct device_node *np)
> >>   	ret = of_dma_get_range(np,&dma_addr,&paddr,&size);
> >>   	if (ret<  0) {
> >>   		dma_addr = offset = 0;
> >> -		size = dev->coherent_dma_mask;
> >> +		size = dev->coherent_dma_mask + 1;
> >>   	} else {
> >>   		offset = PFN_DOWN(paddr - dma_addr);
> >> +
> >> +		/*
> >> +		 * Add a work around to treat the size as mask + 1 in case
> >> +		 * it is defined in DT as a mask.
> >> +		 */
> >> +		if (size&  1) {
> >> +			dev_warn(dev, "Invalid size 0x%llx for dma-range\n",
> >> +				 size);
> >> +			size = size + 1;
> >> +		}
> >> +
> >> +		if (!size) {
> >> +			dev_err(dev, "Adjusted size 0x%llx invalid\n", size);
> >> +			return;
> >> +		}
> >
> > Would it make sense to set coherent_dma_mask to 0 here to make this more
> > noticeable? It can be done together with the mask calculation from size.
>
> I guess you are the following in the code.
> 
> if (!size) {
> 		dev->coherent_dma_mask = 0;
> 		dev_err(dev, "Adjusted size 0x%llx invalid\n", size);
> 		return;
> }
> 
> Not sure how this is going to help and how this get handled by the 
> caller and subsequent logic. Probably it will cause probe to fail, with 
> some helpful error code.

Not sure how it will fail, maybe the driver figures out that DMA isn't
available and say something or switch to PIO. I guess you can leave it
as 32-bit mask by default for now even in case of size == 0.

BTW, since pci_device_add() already sets coherent_dma_mask, you could
add another check at the beginning of of_dma_configure():

	if (!dev->coherent_dma_mask)
		dev->coherent_dma_mask = DMA_BIT_MASK(32);

That's more of a nitpick as the values are both the same.

-- 
Catalin
