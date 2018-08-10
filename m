Return-Path: <SRS0=FW5r=KZ=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=FW5r=KZ=deltatee.com=logang@kernel.org>
To: Kit Chow <kchow@gigaio.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 Eric Pilmore <epilmore@gigaio.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <CAOQPn8soxubJxb=vp7kz+AM6LbPH5y+_Nx0Vzv7rjV_nMMqEmA@mail.gmail.com>
 <20180809184331.GB113140@bhelgaas-glaptop.roam.corp.google.com>
 <CAOQPn8uPYKai49WYPqZp2wNd5of=0hUvPOHEtqP56RZu-hcjuw@mail.gmail.com>
 <b54899a8-a144-e8e0-9880-1800c4657b95@deltatee.com>
 <95e53520-b05f-4be4-e694-463d717453a8@gigaio.com>
 <cdd9245f-eb23-9e10-1755-8f396a2cd255@deltatee.com>
 <b278c1e5-6f08-c879-a27d-7fc172645fd5@gigaio.com>
 <f04fae39-645e-3c6e-07c0-b194260bf5de@deltatee.com>
 <3f503940-db6a-ec75-ed15-1db99d5d48ef@gigaio.com>
 <112A412BB11A1242B37129D931BCE5348382CFB2@fmsmsx117.amr.corp.intel.com>
 <b8af340c-d40b-cb8c-987f-b394f1d6ec3e@gigaio.com>
 <adf51c74-36fa-b61d-8497-27bd75178ba4@deltatee.com>
 <aa9c3f41-efc9-8c68-a517-2736c8986621@gigaio.com>
 <1170c096-a749-6ee3-32d4-ebba1d12adff@gigaio.com>
 <c8dd4740-f01a-372f-2990-2e1163f94042@gigaio.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <672079e5-7432-fcd8-d81c-6d7010b71630@deltatee.com>
Date: Fri, 10 Aug 2018 10:24:54 -0600
MIME-Version: 1.0
In-Reply-To: <c8dd4740-f01a-372f-2990-2e1163f94042@gigaio.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: IOAT DMA w/IOMMU
List-ID: <linux-pci.vger.kernel.org>



On 10/08/18 10:23 AM, Kit Chow wrote:
> There is an internal routine (__intel_map_single) inside the intel iommu 
> code that does the actual mapping using a phys_addr_t. Think I'll try to 
> implement a intel_map_resource routine that calls that routine directly 
> without all of the conversions done for dma_map_{single,page} (pci bar 
> addr -> page -> phys_addr)...

Nice, yes, that was what I was thinking.

Logan
