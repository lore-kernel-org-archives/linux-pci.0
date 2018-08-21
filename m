Return-Path: <SRS0=35td=LE=gigaio.com=epilmore@kernel.org>
Return-Path: <SRS0=35td=LE=gigaio.com=epilmore@kernel.org>
MIME-Version: 1.0
In-Reply-To: <b62adad7-6f39-8bb2-9aca-258cbf909d4d@deltatee.com>
References: <CAOQPn8soxubJxb=vp7kz+AM6LbPH5y+_Nx0Vzv7rjV_nMMqEmA@mail.gmail.com>
 <20180809184331.GB113140@bhelgaas-glaptop.roam.corp.google.com>
 <CAOQPn8uPYKai49WYPqZp2wNd5of=0hUvPOHEtqP56RZu-hcjuw@mail.gmail.com>
 <b54899a8-a144-e8e0-9880-1800c4657b95@deltatee.com> <CAOQPn8tSNN+3igN-kMcQH46w_a9p6T+S7=c8CLREMLxr1kaTXQ@mail.gmail.com>
 <7068db44-af31-4462-f966-2dd2340ba0f0@deltatee.com> <695826a6-e10c-5a30-a51f-7cc61ba6e640@gigaio.com>
 <0d3f48c3-8c4f-4dfb-e883-23c168f12b9b@deltatee.com> <14db6acb-da4f-9604-7359-1671210fcb8b@gigaio.com>
 <ad2cd3f2-eb41-d4c2-7614-379c2e458352@deltatee.com> <CAOQPn8uuTEcmdQdZB9-A7FT+YWtxSuruGFwmwCPApffTJNs9Vg@mail.gmail.com>
 <41419ada-7f16-0028-1e43-3b4a6c6960b6@deltatee.com> <CAOQPn8uyozbmEV0Ww3LW4XDcaY1ZwV0yazsPxPQC0AfLNUhKYw@mail.gmail.com>
 <dd918b52-7ddc-662c-5980-edf3e96ebca2@deltatee.com> <CAOQPn8vO7wP2XGwyJALxkyeBFG6fkTAFgF8QcGiiJF0fOMBa4Q@mail.gmail.com>
 <b62adad7-6f39-8bb2-9aca-258cbf909d4d@deltatee.com>
From: Eric Pilmore <epilmore@gigaio.com>
Date: Tue, 21 Aug 2018 16:59:08 -0700
Message-ID: <CAOQPn8unksJgKiG2fnJf8u6K8wOcC10MKBvAsKpZs+fDrVsOQg@mail.gmail.com>
Subject: Re: IOAT DMA w/IOMMU
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Kit Chow <kchow@gigaio.com>, Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>,
	iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 21, 2018 at 4:53 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>
> CPUs don't always have good support for routing PCI P2P transactions.
> However, I would have expected a relatively new i7 CPU to support it
> well. It may simply be that this CPU does not have good support, however
>  that comes as a bit of a surprise to me. Our plans for the P2P
> patch-set was to have a white-list for CPUs that work.
>
> If you can, it would be worth hooking up a PCI analyzer to see what's
> happening to the TLPs in both cases.

We do have one, but it will be a bit of a logistical effort to get it set-up
in this config. Will be a while before I can gather that data. Will forward
along when I do.

Thanks,
Eric
