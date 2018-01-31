Return-Path: <SRS0=3Q2p=E2=codeaurora.org=poza@kernel.org>
Return-Path: <SRS0=3Q2p=E2=codeaurora.org=poza@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Wed, 31 Jan 2018 10:53:18 +0530
From: poza@codeaurora.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Oza Pawandeep <oza.pawandeep@gmail.com>, Sinan Kaya
 <okaya@codeaurora.org>, Keith Busch <keith.busch@intel.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Linux PCI <linux-pci@vger.kernel.org>,
 linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH 2/6] PCI/DPC: Leave interrupts enabled while handling
 event
In-Reply-To: <20180130183046.GG232763@bhelgaas-glaptop.roam.corp.google.com>
References: <20180129213145.26068-1-keith.busch@intel.com>
 <20180129213145.26068-2-keith.busch@intel.com>
 <56d77093-b630-148d-52ab-14dcb7714e6b@codeaurora.org>
 <CAK1A=4w-uDm+gau6WdwM=ZrgO=bWDtDKqwabxWxm2EZZb+YoKw@mail.gmail.com>
 <f0afb7badc99dcfc3b6818cc2356250d@codeaurora.org>
 <20180130183046.GG232763@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <751f22485ba10c4a732831787c4ea2d6@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2018-01-31 00:00, Bjorn Helgaas wrote:
> On Tue, Jan 30, 2018 at 12:04:44PM +0530, poza@codeaurora.org wrote:
>> Bjorn: Can you please help to review my AER/DPC series of patches so
>> that I do not have to keep rebasing and do manual merge ?
> 
> They're in the queue and I'll get to them this cycle.
> 
> You don't need to rebase them unless you change your patches to
> actually require something from another branch.  If there are
> conflicts with other patches that are in-flight, I'll resolve those
> myself.
> 
> Since your patches will probably land in the v4.17 merge, it *will* be
> nice if you rebase them when I update the pci/master branch, which
> will probably be to v4.16-rc1.  But unless you *depend* on features in
> another branch, it's easiest if you base them on pci/master, which
> generally stays the same throughout the cycle.
> 
> Bjorn

sure, will rebase them on top of pci/master.

Regards,
Oza.
