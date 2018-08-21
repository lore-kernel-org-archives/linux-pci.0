Return-Path: <SRS0=hyej=LE=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=hyej=LE=deltatee.com=logang@kernel.org>
To: Eric Pilmore <epilmore@gigaio.com>
Cc: Kit Chow <kchow@gigaio.com>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-pci@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 iommu@lists.linux-foundation.org
References: <CAOQPn8soxubJxb=vp7kz+AM6LbPH5y+_Nx0Vzv7rjV_nMMqEmA@mail.gmail.com>
 <20180809184331.GB113140@bhelgaas-glaptop.roam.corp.google.com>
 <CAOQPn8uPYKai49WYPqZp2wNd5of=0hUvPOHEtqP56RZu-hcjuw@mail.gmail.com>
 <b54899a8-a144-e8e0-9880-1800c4657b95@deltatee.com>
 <CAOQPn8tSNN+3igN-kMcQH46w_a9p6T+S7=c8CLREMLxr1kaTXQ@mail.gmail.com>
 <7068db44-af31-4462-f966-2dd2340ba0f0@deltatee.com>
 <695826a6-e10c-5a30-a51f-7cc61ba6e640@gigaio.com>
 <0d3f48c3-8c4f-4dfb-e883-23c168f12b9b@deltatee.com>
 <14db6acb-da4f-9604-7359-1671210fcb8b@gigaio.com>
 <ad2cd3f2-eb41-d4c2-7614-379c2e458352@deltatee.com>
 <CAOQPn8uuTEcmdQdZB9-A7FT+YWtxSuruGFwmwCPApffTJNs9Vg@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <41419ada-7f16-0028-1e43-3b4a6c6960b6@deltatee.com>
Date: Tue, 21 Aug 2018 17:20:58 -0600
MIME-Version: 1.0
In-Reply-To: <CAOQPn8uuTEcmdQdZB9-A7FT+YWtxSuruGFwmwCPApffTJNs9Vg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: IOAT DMA w/IOMMU
List-ID: <linux-pci.vger.kernel.org>



On 21/08/18 05:18 PM, Eric Pilmore wrote:
> We have been running locally with Kit's change for dma_map_resource and its
> incorporation in ntb_async_tx_submit for the destination address and
> it runs fine
> under "load" (iperf) on a Xeon (Xeon(R) CPU E5-2680 v4 @ 2.40GHz) based system,
> regardless of whether the DMA engine being used is IOAT or a PLX
> device sitting in
> the PCIe tree. However, when we go back to a i7 (i7-7700K CPU @ 4.20GHz) based
> system it seems to run into issues, specifically when put under a
> load. In this case,
> just having a load using a single ping command with an interval=0, i.e. no delay
> between ping packets, after a few thousand packets the system just hangs. No
> panic or watchdogs.  Note that in this scenario I can only use a PLX DMA engine.

This is just my best guess: but it sounds to me like a bug in the PLX
DMA driver or hardware.

Logan
