Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750858AbeDTQO4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Apr 2018 12:14:56 -0400
Date: Fri, 20 Apr 2018 19:14:51 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Daly, Dan" <dan.daly@intel.com>,
        "Rustad, Mark D" <mark.d.rustad@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        kvm@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>, netanel@amazon.com,
        Don Dutile <ddutile@redhat.com>,
        Maximilian Heyne <mheyne@amazon.de>,
        "Wang, Liang-min" <liang-min.wang@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@lst.de>, dwmw@amazon.co.uk
Subject: Re: [virtio-dev] [pci PATCH v7 2/5] virtio_pci: Add support for
 unmanaged SR-IOV on virtio_pci devices
Message-ID: <20180420191055-mutt-send-email-mst@kernel.org>
References: <20180316183042-mutt-send-email-mst@kernel.org>
 <CAKgT0UfgZ2gAdiAbCe4MTOr3o9cqq1q-mykCQsw68p2F-QEC8g@mail.gmail.com>
 <20180403161151-mutt-send-email-mst@kernel.org>
 <CAKgT0UfeSmG=xsd6sTkg4cOMnZ0QiqtCRDt4PynpF3d6nvvFCA@mail.gmail.com>
 <20180403212503-mutt-send-email-mst@kernel.org>
 <CAKgT0Ude79FYrK4qA0OKRJ1NackyqPi-hZ8Zh3WSdLDFxoOosQ@mail.gmail.com>
 <20180420030640-mutt-send-email-mst@kernel.org>
 <CAKgT0Ucpw9D1u8MYoEX5KOij6sxs-5O9gPFTmOVq=Dgt=HUJ=g@mail.gmail.com>
 <20180420180839-mutt-send-email-mst@kernel.org>
 <CAKgT0UeWzK=_8m9hhWfaKyYB02WXDsuCkgowS4hgQ9GkLMcAMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKgT0UeWzK=_8m9hhWfaKyYB02WXDsuCkgowS4hgQ9GkLMcAMA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 20, 2018 at 09:08:51AM -0700, Alexander Duyck wrote:
> On Fri, Apr 20, 2018 at 8:28 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Fri, Apr 20, 2018 at 07:56:14AM -0700, Alexander Duyck wrote:
> >> > I think for virtio it should include the feature bit, yes.
> >> > Adding feature bit is very easy - post a patch to the virtio TC mailing
> >> > list, wait about a week to give people time to respond (two weeks if it
> >> > is around holidays and such).
> >>
> >> The problem is we are talking about hardware/FPGA, not software.
> >> Adding a feature bit means going back and updating RTL. The software
> >> side of things is easy, re-validating things after a hardware/FPGA
> >> change not so much.
> >>
> >> If this is a hard requirement I may just drop the virtio patch, push
> >> what I have, and leave it to Mark/Dan to deal with the necessary RTL
> >> and code changes needed to support Virtio as I don't expect the
> >> turnaround to be as easy as just a patch.
> >>
> >> Thanks.
> >>
> >> - Alex
> >
> > Let's focus on virtio in this thread.
> 
> That is kind of what I was thinking, and why I was thinking it might
> make sense to make the virtio specific changes a separate patch set. I
> could get the PCI bits taken care of in the meantime since they effect
> genetic PCI, NVMe, and the Amazon ENA interfaces.
> 
> > Involving the virtio TC in host/guest interface changes is a
> > hard requirement. It's just too easy to create conflicts otherwise.
> >
> > So you guys should have just sent the proposal to the TC when you
> > were doing your RTL and you would have been in the clear.
> 
> Agreed. I believe I brought this up when I was originally asked to
> look into the coding for this.
> 
> > Generally adding a feature bit with any extension is a good idea:
> > this way you merely reserve a feature bit for your feature through
> > the TC and are more or less sure of forward and backward compatibility.
> > It's incredibly easy.
> 
> Agreed, though in this case I am not sure it makes sense since this
> isn't necessarily something that is a Virtio feature itself. It is
> just a side effect of the fact that they are adding SR-IOV support to
> a device that happens to emulate Virtio NET and apparently their PF
> has to be identical to the VF other than the PCIe extended config
> space.

I got that. My point is not everyone implementing SR-IOV will
want to do it like this. Others might want to have VFs
be different from PFs somehow. Feature bits ensure forward
not just backward compatibility.


> > But maybe it's not needed here.  I am not making the decisions myself.
> > Not too late: post to the TC list and let's see what the response is.
> > Without a feature bit you are making a change affecting all future
> > implementations without exception so the bar is a bit higher: you need
> > to actually post a spec text proposal not just a patch showing how to
> > use the feature, and TC needs to vote on it. Voting takes a week,
> > review a week or two depending on change complexity.
> >
> > Hope this helps,
> >
> > --
> > MST
> 
> I think I will leave this for Dan and Mark to handle since I am still
> not all that familiar with the hardware in use here. Once a decision
> has been made him and Mark could look at pushing either the one line
> patch or something more complex involving a feature flag.
> 
> Thanks.
> 
> Alex

As long as the TC is involved.

I know it's a bit of a strange thing to block it at the driver level,
the issue is with the device, but it's literally the only handle I have
to prevent people from doing out of spec hacks then pushing it all on us
to maintain.

-- 
MST
