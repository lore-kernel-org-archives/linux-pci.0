Return-Path: <SRS0=Ly/z=KY=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=Ly/z=KY=deltatee.com=logang@kernel.org>
To: Kit Chow <kchow@gigaio.com>, Eric Pilmore <epilmore@gigaio.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 iommu@lists.linux-foundation.org
References: <CAOQPn8soxubJxb=vp7kz+AM6LbPH5y+_Nx0Vzv7rjV_nMMqEmA@mail.gmail.com>
 <20180809184331.GB113140@bhelgaas-glaptop.roam.corp.google.com>
 <CAOQPn8uPYKai49WYPqZp2wNd5of=0hUvPOHEtqP56RZu-hcjuw@mail.gmail.com>
 <b54899a8-a144-e8e0-9880-1800c4657b95@deltatee.com>
 <95e53520-b05f-4be4-e694-463d717453a8@gigaio.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <cdd9245f-eb23-9e10-1755-8f396a2cd255@deltatee.com>
Date: Thu, 9 Aug 2018 14:11:17 -0600
MIME-Version: 1.0
In-Reply-To: <95e53520-b05f-4be4-e694-463d717453a8@gigaio.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: IOAT DMA w/IOMMU
List-ID: <linux-pci.vger.kernel.org>



On 09/08/18 01:47 PM, Kit Chow wrote:
>> I haven't tested this scenario but my guess would be that IOAT would
>> indeed go through the IOMMU and the PCI BAR address would need to be
>> properly mapped into the IOAT's IOVA. The fact that you see DMAR errors
>> is probably a good indication that this is the case. I really don't know
>> why you'd want to DMA something without mapping it.
> I have experimented with changing ntb_async_tx_submit to dma_map the PCI 
> BAR
> address. With this, I get a different DMAR error:

What code did you use to do this?


> DMAR: [DMA Write] Request device [07:00.4] fault addr ffd00000
> [fault reason 12] non-zero reserved fields in PTE

Also, what device corresponds to 07:00.4 on your system?

Logan
