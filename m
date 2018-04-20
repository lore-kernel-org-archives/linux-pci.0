Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180420030640-mutt-send-email-mst@kernel.org>
References: <20180315183449.3102.64791.stgit@localhost.localdomain>
 <20180315184132.3102.90947.stgit@localhost.localdomain> <20180316183042-mutt-send-email-mst@kernel.org>
 <CAKgT0UfgZ2gAdiAbCe4MTOr3o9cqq1q-mykCQsw68p2F-QEC8g@mail.gmail.com>
 <20180403161151-mutt-send-email-mst@kernel.org> <CAKgT0UfeSmG=xsd6sTkg4cOMnZ0QiqtCRDt4PynpF3d6nvvFCA@mail.gmail.com>
 <20180403212503-mutt-send-email-mst@kernel.org> <CAKgT0Ude79FYrK4qA0OKRJ1NackyqPi-hZ8Zh3WSdLDFxoOosQ@mail.gmail.com>
 <20180420030640-mutt-send-email-mst@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 20 Apr 2018 07:56:14 -0700
Message-ID: <CAKgT0Ucpw9D1u8MYoEX5KOij6sxs-5O9gPFTmOVq=Dgt=HUJ=g@mail.gmail.com>
Subject: Re: [virtio-dev] [pci PATCH v7 2/5] virtio_pci: Add support for
 unmanaged SR-IOV on virtio_pci devices
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Daly, Dan" <dan.daly@intel.com>,
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
        "Rustad, Mark D" <mark.d.rustad@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@lst.de>, dwmw@amazon.co.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 19, 2018 at 5:40 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Tue, Apr 03, 2018 at 12:06:03PM -0700, Alexander Duyck wrote:
>> On Tue, Apr 3, 2018 at 11:27 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > On Tue, Apr 03, 2018 at 10:32:00AM -0700, Alexander Duyck wrote:
>> >> On Tue, Apr 3, 2018 at 6:12 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> >> > On Fri, Mar 16, 2018 at 09:40:34AM -0700, Alexander Duyck wrote:
>> >> >> On Fri, Mar 16, 2018 at 9:34 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> >> >> > On Thu, Mar 15, 2018 at 11:42:41AM -0700, Alexander Duyck wrote:
>> >> >> >> From: Alexander Duyck <alexander.h.duyck@intel.com>
>> >> >> >>
>> >> >> >> Hardware-realized virtio_pci devices can implement SR-IOV, so this
>> >> >> >> patch enables its use. The device in question is an upcoming Intel
>> >> >> >> NIC that implements both a virtio_net PF and virtio_net VFs. These
>> >> >> >> are hardware realizations of what has been up to now been a software
>> >> >> >> interface.
>> >> >> >>
>> >> >> >> The device in question has the following 4-part PCI IDs:
>> >> >> >>
>> >> >> >> PF: vendor: 1af4 device: 1041 subvendor: 8086 subdevice: 15fe
>> >> >> >> VF: vendor: 1af4 device: 1041 subvendor: 8086 subdevice: 05fe
>> >> >> >>
>> >> >> >> The patch currently needs no check for device ID, because the callback
>> >> >> >> will never be made for devices that do not assert the capability or
>> >> >> >> when run on a platform incapable of SR-IOV.
>> >> >> >>
>> >> >> >> One reason for this patch is because the hardware requires the
>> >> >> >> vendor ID of a VF to be the same as the vendor ID of the PF that
>> >> >> >> created it. So it seemed logical to simply have a fully-functioning
>> >> >> >> virtio_net PF create the VFs. This patch makes that possible.
>> >> >> >>
>> >> >> >> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> >> >> >> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
>> >> >> >> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
>> >> >> >
>> >> >> > So if and when virtio PFs can manage the VFs, then we can
>> >> >> > add a feature bit for that?
>> >> >> > Seems reasonable.
>> >> >>
>> >> >> Yes. If nothing else you may not even need a feature bit depending on
>> >> >> how things go.
>> >> >
>> >> > OTOH if the interface is changed in an incompatible way,
>> >> > and old Linux will attempt to drive the new device
>> >> > since there is no check.
>> >> >
>> >> > I think we should add a feature bit right away.
>> >>
>> >> I'm not sure why you would need a feature bit. The capability is
>> >> controlled via PCI configuration space. If it is present the device
>> >> has the capability. If it is not then it does not.
>> >>
>> >> Basically if the PCI configuration space is not present then the sysfs
>> >> entries will not be spawned and nothing will attempt to use this
>> >> function.
>> >>
>> >> - ALex
>> >
>> > It's about compability with older guests which ignore the
>> > capability.
>> >
>> > The feature is thus helpful so host knows whether guest supports VFs.
>>
>> The thing is if the capability is ignored then the feature isn't used.
>> So for SR-IOV it isn't an uncommon thing for there to be drivers for
>> the PF floating around that do not support SR-IOV. In such cases
>> SR-IOV just isn't used while the hardware could support it.
>
> Right but how come there are VF drivers but PF driver does not
> know about these?

I'm not sure what you mean here. The VF and PF drivers are the same
driver. The only difference is that the PF has the extra SR-IOV
configuration space.

What this code is meant to enable is a form of SR-IOV where the VFs
are essentially pre-allocated resources. So for example in our case
the MMIO space is identical for a PF versus any of the VFs. It doesn't
have any special controls in place to allow the PF to manipulate any
of the resources belonging to the VFs.

> And are there PF drivers that intentially do not enable SRIOV
> because it's known to be broken in some way?

In the Virtio IO case right now are there any devices that support
SR-IOV? For now this is just an add-on bit to a function that is
already emulating the Virtio in hardware.

> Case in point I do think virtio want to limit this
> depending on a feature bit on general principles
> (the principle being that all extensions have feature bits).

This part has me kind of scratching my head. In our setup the "PF" is
really nothing more than a "VF" with the SR-IOV configuration space
attached to it. There are already examples of similar designs for NVMe
and the Amazon ENA devices. Giving the "PF" any functionality in MMIO
space that controls the SR-IOV kind of defeats the whole point of
allowing this function in the first place. Basically the PF isn't
really controlling things, it is the kernel that is doing it.

> There are security implications here - we previously relied on
> whitelisting after all.

Yes and no. The original patch set had issues as you could have a PF
assigned to user space and the VFs managed by the host. When I changed
things so that the function had to be in a kernel driver that issue
went away.

> Wouldn't it be safer to be a bit more careful and update the
> actual PF drivers? It's just one line per driver, but it
> can be done with an ack by driver maintainer.
> If/once we find out all drivers do have it, we can then
> change the default.

I have no clue what you are talking about here. This is the more
careful approach. Are you sure you are reviewing the v7 of the
patches?

My understanding is that no paravirtual interfaces currently expose
SR-IOV. What we are looking at is hardware will want to emulate
Virtio, specifically virtio_net in the future and as a part of that
the PF ends up emulating it as well. What we would need to watch for
going forward is that any device that enables SR-IOV support would
need to also provide a 4 tuple ID so that if something goes wrong with
it we could disable SR-IOV on the device via a PCI quirk later.

>> I would think in the case of virtio it would be the same kind of
>> thing. Basically if SR-IOV is supported by the host then the
>> capability would be present. If SR-IOV is supported by the guest then
>> it would make use of the capability to spawn VFs. If either the
>> capability isn't present, or the driver doesn't use it then you won't
>> be able to spawn VFs in the guest.
>
>> Maybe I am missing something. Do you support dynamically changing the
>> PCI configuration space for Virtio devices based on the presence of
>> feature bits provided by the guest?
>
> No. The point is that IMHO at least virtio - in absence of feature bit -
> to ignore VFs rather than assume they are safe to drive
> in an unmanaged way.
>
>> Also are you saying this patch set should wait on the feature bit to
>> be added, or are you talking about doing this as some sort of
>> follow-up?
>>
>> - Alex
>
> I think for virtio it should include the feature bit, yes.
> Adding feature bit is very easy - post a patch to the virtio TC mailing
> list, wait about a week to give people time to respond (two weeks if it
> is around holidays and such).

The problem is we are talking about hardware/FPGA, not software.
Adding a feature bit means going back and updating RTL. The software
side of things is easy, re-validating things after a hardware/FPGA
change not so much.

If this is a hard requirement I may just drop the virtio patch, push
what I have, and leave it to Mark/Dan to deal with the necessary RTL
and code changes needed to support Virtio as I don't expect the
turnaround to be as easy as just a patch.

Thanks.

- Alex
