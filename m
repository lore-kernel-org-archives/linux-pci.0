Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] pci: add missing __iomem cast
To: Christoph Hellwig <hch@infradead.org>,
        Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
References: <20170719120535.26350-1-palminha@synopsys.com>
 <20170720080742.GA22116@infradead.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <bhelgaas@google.com>, <gwshan@linux.vnet.ibm.com>
From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Message-ID: <84660edf-3a19-0400-4fa7-8f26ae5e4218@synopsys.com>
Date: Fri, 21 Jul 2017 12:38:32 +0100
MIME-Version: 1.0
In-Reply-To: <20170720080742.GA22116@infradead.org>
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Christoph,

Looking deep into to this, i think there is no need to use phy_to_virts since pdev->rom is already a physical address.
That's what pci_platform_rom should return, right?!

I'll probably send a new patch removing the usage of phys_to_virt.

Regards,
C.Palminha

On 20-07-2017 09:07, Christoph Hellwig wrote:
> On Wed, Jul 19, 2017 at 01:05:35PM +0100, Carlos Palminha wrote:
>> Add missing __iomem annotation to fix sparse warning:
>> - incorrect type in return expression (different address spaces)
> 
> How is this going to shut up sparse without a __force?
> 
> And once you add the __force please also add a comment explaining
> why it's safe.
> 
