Return-Path: <SRS0=xQUW=KZ=intel.com=dave.jiang@kernel.org>
Return-Path: <SRS0=xQUW=KZ=intel.com=dave.jiang@kernel.org>
Subject: Re: IOAT DMA w/IOMMU
To: Logan Gunthorpe <logang@deltatee.com>, Kit Chow <kchow@gigaio.com>,
 Eric Pilmore <epilmore@gigaio.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <CAOQPn8soxubJxb=vp7kz+AM6LbPH5y+_Nx0Vzv7rjV_nMMqEmA@mail.gmail.com>
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
 <929f3dfa-fbff-c582-3be5-c368f11feb7e@deltatee.com>
 <460cc47f-6a8e-67b0-01a0-02f0c51df258@intel.com>
 <0f653f8f-c7ae-831d-e238-2742590d9ea1@deltatee.com>
 <6525fa4d-7d9b-0136-7206-f8351230af46@intel.com>
 <f22c565e-ba49-c83d-3e51-7967664c7136@deltatee.com>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <499934e7-3734-1aee-37dd-b42a5d2a2608@intel.com>
Date: Fri, 10 Aug 2018 10:46:31 -0700
MIME-Version: 1.0
In-Reply-To: <f22c565e-ba49-c83d-3e51-7967664c7136@deltatee.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>



On 08/10/2018 10:15 AM, Logan Gunthorpe wrote:
> 
> 
> On 10/08/18 11:01 AM, Dave Jiang wrote:
>> Or if the BIOS has provided mapping for the Intel NTB device
>> specifically? Is that a possibility? NTB does go through the IOMMU.
> 
> I don't know but if the BIOS is doing it, but that would only at best
> work for Intel NTB.... I see no hope in getting the BIOS to map the MW
> for a Switchtec NTB device...

Right. I'm just speculating why it may possibly work. But yes, I think
kernel will need appropriate mapping if it's not happening right now.
Hopefully Kit is onto something.

> 
> Logan
> 
