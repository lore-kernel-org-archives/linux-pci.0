Return-Path: <SRS0=35td=LE=gigaio.com=epilmore@kernel.org>
Return-Path: <SRS0=35td=LE=gigaio.com=epilmore@kernel.org>
MIME-Version: 1.0
In-Reply-To: <ad2cd3f2-eb41-d4c2-7614-379c2e458352@deltatee.com>
References: <CAOQPn8soxubJxb=vp7kz+AM6LbPH5y+_Nx0Vzv7rjV_nMMqEmA@mail.gmail.com>
 <20180809184331.GB113140@bhelgaas-glaptop.roam.corp.google.com>
 <CAOQPn8uPYKai49WYPqZp2wNd5of=0hUvPOHEtqP56RZu-hcjuw@mail.gmail.com>
 <b54899a8-a144-e8e0-9880-1800c4657b95@deltatee.com> <CAOQPn8tSNN+3igN-kMcQH46w_a9p6T+S7=c8CLREMLxr1kaTXQ@mail.gmail.com>
 <7068db44-af31-4462-f966-2dd2340ba0f0@deltatee.com> <695826a6-e10c-5a30-a51f-7cc61ba6e640@gigaio.com>
 <0d3f48c3-8c4f-4dfb-e883-23c168f12b9b@deltatee.com> <14db6acb-da4f-9604-7359-1671210fcb8b@gigaio.com>
 <ad2cd3f2-eb41-d4c2-7614-379c2e458352@deltatee.com>
From: Eric Pilmore <epilmore@gigaio.com>
Date: Tue, 21 Aug 2018 16:18:55 -0700
Message-ID: <CAOQPn8uuTEcmdQdZB9-A7FT+YWtxSuruGFwmwCPApffTJNs9Vg@mail.gmail.com>
Subject: Re: IOAT DMA w/IOMMU
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Kit Chow <kchow@gigaio.com>, Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>,
	iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 16, 2018 at 11:56 AM, Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 16/08/18 12:53 PM, Kit Chow wrote:
> >
> >
> > On 08/16/2018 10:21 AM, Logan Gunthorpe wrote:
> >>
> >> On 16/08/18 11:16 AM, Kit Chow wrote:
> >>> I only have access to intel hosts for testing (and possibly an AMD
> >>> host currently collecting dust) and am not sure how to go about getting
> >>> the proper test coverage for other architectures.
> >> Well, I thought you were only changing the Intel IOMMU implementation...
> >> So testing on Intel hardware seems fine to me.
> > For the ntb change, I wasn't sure if there was some other arch where
> > ntb_async_tx_submit would work ok with the pci bar address but
> > would break with the dma map (assuming map_resource has been implemented).
> > If its all x86 at the moment, I guess I'm good to go. Please confirm.
>
> I expect lots of arches have issues with dma_map_resource(), it's pretty
> new and if it didn't work correctly on x86 I imagine many other arches
> are wrong too. I an arch is doesn't work, someone will have to fix that
> arches Iommu implementation. But using dma_map_resource() in
> ntb_transport is definitely correct compared to what was done before.
>
> Logan


We have been running locally with Kit's change for dma_map_resource and its
incorporation in ntb_async_tx_submit for the destination address and
it runs fine
under "load" (iperf) on a Xeon (Xeon(R) CPU E5-2680 v4 @ 2.40GHz) based system,
regardless of whether the DMA engine being used is IOAT or a PLX
device sitting in
the PCIe tree. However, when we go back to a i7 (i7-7700K CPU @ 4.20GHz) based
system it seems to run into issues, specifically when put under a
load. In this case,
just having a load using a single ping command with an interval=0, i.e. no delay
between ping packets, after a few thousand packets the system just hangs. No
panic or watchdogs.  Note that in this scenario I can only use a PLX DMA engine.

Just wondering if anybody might have a clue as to why the i7 system might run
into issues, but a Xeon system not. IOMMU differences? My gut reaction is that
the problem may not necessarily be IOMMU hardware related, but perhaps simply
a timing issue given the difference in cpu speeds between these systems and
maybe we're hitting some window in the Intel IOMMU mapping/unmapping logic.

Thanks,
Eric
