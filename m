Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58202 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752978AbdLMObS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Dec 2017 09:31:18 -0500
Date: Wed, 13 Dec 2017 14:31:59 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Niklas Cassel <niklas.cassel@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kishon@ti.com
Subject: Re: [PATCH v5 01/18] PCI: dwc: Use the DMA-API to get the MSI address
Message-ID: <20171213143159.GC1736@red-moon>
References: <20171120133222.27771-1-niklas.cassel@axis.com>
 <20171120133222.27771-2-niklas.cassel@axis.com>
 <20171130152843.GC12096@red-moon>
 <20171213135953.GA30833@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171213135953.GA30833@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Jingoo, Joao,

Niklas has a point. I can't apply this series without your testing
and review, so please do test/ack if you deem that suitable.

On Wed, Dec 13, 2017 at 02:59:54PM +0100, Niklas Cassel wrote:
> On Thu, Nov 30, 2017 at 03:28:43PM +0000, Lorenzo Pieralisi wrote:
> > Jingoo, Joao,
> > 
> > I am expecting your testing on the series and ACKs on the dwc related
> > patches please, according to v4 review - I will mark them as needs
> > review/ACK waiting for you to chime in.
> > 
> > v4 thread:
> > 
> > https://patchwork.ozlabs.org/patch/833882/
> > 
> 
> Hello Lorenzo, Jingoo, Joao,
> 
> Tomorrow another 2 weeks has passed.
> V1 of this patch series was posted on 2017-10-13.

I understand - I need their review/testing to move forward with this
series and I strongly encourage them to chime in - as soon as possible.

> I'm a bit worried that this patch series will not make it to linux-next
> in time for this patch series to be included in the 4.16 pull request.

We should be able to do it if they reply within a reasonable timeframe.

Thanks,
Lorenzo

> Here is the V5 patch series:
> https://patchwork.ozlabs.org/project/linux-pci/list/?series=14364
> 
> Perhaps any maintainer of a designware based PCIe driver could
> help out and test this patch series?
> 
> Regards,
> Niklas
