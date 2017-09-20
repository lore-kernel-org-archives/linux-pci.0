Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 20 Sep 2017 10:11:33 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jcm@redhat.com,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] vfio/pci: Virtualize Maximum Payload Size
Message-ID: <20170920101133.33b68d8f@w520.home>
In-Reply-To: <73d55003-6fcd-3741-73a1-365c73933538@redhat.com>
References: <20170919164952.13200.78849.stgit@gimli.home>
        <c3bbb645-50a9-a1b4-c8f2-8973f0478a2a@redhat.com>
        <20170919142024.05723289@t450s.home>
        <3dd92928-3cda-50c1-6a67-10721c003c10@redhat.com>
        <a609bc8b-8c5b-0828-d175-50985d688fe3@codeaurora.org>
        <73d55003-6fcd-3741-73a1-365c73933538@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 20 Sep 2017 16:26:25 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Sinan,
> 
> On 20/09/2017 15:01, Sinan Kaya wrote:
> > On 9/20/2017 3:59 AM, Auger Eric wrote:  
> >>> My impression is that MRRS is predominantly device and driver
> >>> dependent, not topology dependent.  A device can send a read request
> >>> with a size larger than MPS, which implies that the device supplying
> >>> the read data would split it into multiple TLPs based on MPS.  
> >> I read that too on the net. However in in 6.3.4.1. (3.0. Nov 10), Rules
> >> for SW Configuration it is written:
> >> "Software must set Max_Read_Request_Size of an isochronous-configured
> >> device with a value that does not exceed the Max_Payload_Size set for
> >> the device."
> >>
> >> But on the the other hand some drivers are setting the MMRS directly
> >> without further checking the MPS?  
> > 
> > We discussed this on LPC. MRRS and MPS are two independent concepts and
> > are not related to each other under normal circumstances. 
> > 
> > The only valid criteria is that MRRS needs to be a multiple of MPS.
> > 
> > https://linuxplumbersconf.org/2017/ocw//system/presentations/4732/original/crs.pdf
> > 
> > Because completions are required to be a minimum of MPS size. If MRRS > MPS,
> > read response is sent as multiple completions.  
> 
> With that patch, you can end up with MRRS < MPS. Do I understand
> correctly this is an issue?

My impression is that the issue would be inefficiency.  There should be
nothing functionally wrong with a read request less than MPS, but we're
not "filling" the TLP as much as the topology allows.  Is that your
understanding as well, Sinan?

It seems like it would be relatively easy to virtualize MRRS like we do
the FLR bit, ie. evaluate the change the user is trying to make and
update MRRS with pci-core callbacks, capping the lower bound equal to
MPS for efficiency.  It's possible we'll encounter devices that really
do need a lower MPS, but it seems unlikely since this is the setting
the PCI core seems to make by default (MRRS == MPS).  Thanks,

Alex
