Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from dliviu.plus.com ([80.229.23.120]:39349 "EHLO smtp.dudau.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753306AbaE3Ayn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 29 May 2014 20:54:43 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.dudau.co.uk (Postfix) with SMTP id E5995FF6BA
	for <linux-pci@vger.kernel.org>; Fri, 30 May 2014 01:54:41 +0100 (BST)
From: "Liviu Dudau" <liviu@dudau.co.uk>
Date: Fri, 30 May 2014 01:56:03 +0100
To: Kumar Gala <galak@codeaurora.org>
Cc: Rob Herring <robherring2@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] of: treat PCI config space as IORESOURCE_MEM type
Message-ID: <20140530005602.GE1677@bart.dudau.co.uk>
References: <1401379426-9701-1-git-send-email-galak@codeaurora.org>
 <CAL_JsqLPFDwtd-QYDqCwx1JVj1Aa8=nof-e0P6R9CZra+fXHfw@mail.gmail.com>
 <47B1E3D0-4336-4529-80B0-172F4ACA5C97@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <47B1E3D0-4336-4529-80B0-172F4ACA5C97@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 29, 2014 at 03:51:28PM -0500, Kumar Gala wrote:
> 
> On May 29, 2014, at 3:44 PM, Rob Herring <robherring2@gmail.com> wrote:
> 
> > On Thu, May 29, 2014 at 11:03 AM, Kumar Gala <galak@codeaurora.org> wrote:
> >> If we have a PCI config space specified in something like a ranges
> >> property we should treat it as memory type resource.
> > 
> > Config space should not be in ranges[1]. We have some cases that are,
> > but we don't want new ones.
> 
> For the cases we have I agree, however an ECAM based cfg seems completely legit.
> 
> >> Signed-off-by: Kumar Gala <galak@codeaurora.org>
> >> ---
> >> drivers/of/address.c | 3 +++
> >> 1 file changed, 3 insertions(+)
> >> 
> >> diff --git a/drivers/of/address.c b/drivers/of/address.c
> >> index cb4242a..4e7ee59 100644
> >> --- a/drivers/of/address.c
> >> +++ b/drivers/of/address.c
> >> @@ -122,6 +122,9 @@ static unsigned int of_bus_pci_get_flags(const __be32 *addr)
> >>        u32 w = be32_to_cpup(addr);
> >> 
> >>        switch((w >> 24) & 0x03) {
> >> +       case 0x00: /* cfg space */
> >> +               flags |= IORESOURCE_MEM;
> >> +               break;
> > 
> > How would you then distinguish actual memory ranges?
> 
> One assumes you are still looking at pci_space as part of of_pci_range

That doesn't happen when you start scanning the bus. The existing code will
use the IORESOURCE_MEM for allocating memory space for devices, which is
not what you want. Did you test your patch on any PCI system? I'm pretty
sure that with my patch series that tries to make a generic framework for
host controllers this will fail.

We really need a IORESOURCE_CFG flag for this space.

Best regards,
Liviu

> 
> > 
> > Rob
> > 
> > [1] http://www.spinics.net/lists/linux-pci/msg30585.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
-------------------
   .oooO
   (   )
    \ (  Oooo.
     \_) (   )
          ) /
         (_/

 One small step
   for me ...

