Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 13 Dec 2017 14:59:54 +0100
From: Niklas Cassel <niklas.cassel@axis.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kishon@ti.com
Subject: Re: [PATCH v5 01/18] PCI: dwc: Use the DMA-API to get the MSI address
Message-ID: <20171213135953.GA30833@axis.com>
References: <20171120133222.27771-1-niklas.cassel@axis.com>
 <20171120133222.27771-2-niklas.cassel@axis.com>
 <20171130152843.GC12096@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171130152843.GC12096@red-moon>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 30, 2017 at 03:28:43PM +0000, Lorenzo Pieralisi wrote:
> Jingoo, Joao,
> 
> I am expecting your testing on the series and ACKs on the dwc related
> patches please, according to v4 review - I will mark them as needs
> review/ACK waiting for you to chime in.
> 
> v4 thread:
> 
> https://patchwork.ozlabs.org/patch/833882/
> 

Hello Lorenzo, Jingoo, Joao,

Tomorrow another 2 weeks has passed.
V1 of this patch series was posted on 2017-10-13.

I'm a bit worried that this patch series will not make it to linux-next
in time for this patch series to be included in the 4.16 pull request.

Here is the V5 patch series:
https://patchwork.ozlabs.org/project/linux-pci/list/?series=14364

Perhaps any maintainer of a designware based PCIe driver could
help out and test this patch series?

Regards,
Niklas
