Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37256 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752240AbeDCTGG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Apr 2018 15:06:06 -0400
MIME-Version: 1.0
In-Reply-To: <20180403212503-mutt-send-email-mst@kernel.org>
References: <20180315183449.3102.64791.stgit@localhost.localdomain>
 <20180315184132.3102.90947.stgit@localhost.localdomain> <20180316183042-mutt-send-email-mst@kernel.org>
 <CAKgT0UfgZ2gAdiAbCe4MTOr3o9cqq1q-mykCQsw68p2F-QEC8g@mail.gmail.com>
 <20180403161151-mutt-send-email-mst@kernel.org> <CAKgT0UfeSmG=xsd6sTkg4cOMnZ0QiqtCRDt4PynpF3d6nvvFCA@mail.gmail.com>
 <20180403212503-mutt-send-email-mst@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 3 Apr 2018 12:06:03 -0700
Message-ID: <CAKgT0Ude79FYrK4qA0OKRJ1NackyqPi-hZ8Zh3WSdLDFxoOosQ@mail.gmail.com>
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
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 3, 2018 at 11:27 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Tue, Apr 03, 2018 at 10:32:00AM -0700, Alexander Duyck wrote:
>> On Tue, Apr 3, 2018 at 6:12 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > On Fri, Mar 16, 2018 at 09:40:34AM -0700, Alexander Duyck wrote:
>> >> On Fri, Mar 16, 2018 at 9:34 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> >> > On Thu, Mar 15, 2018 at 11:42:41AM -0700, Alexander Duyck wrote:
>> >> >> From: Alexander Duyck <alexander.h.duyck@intel.com>
>> >> >>
>> >> >> Hardware-realized virtio_pci devices can implement SR-IOV, so this
>> >> >> patch enables its use. The device in question is an upcoming Intel
>> >> >> NIC that implements both a virtio_net PF and virtio_net VFs. These
>> >> >> are hardware realizations of what has been up to now been a software
>> >> >> interface.
>> >> >>
>> >> >> The device in question has the following 4-part PCI IDs:
>> >> >>
>> >> >> PF: vendor: 1af4 device: 1041 subvendor: 8086 subdevice: 15fe
>> >> >> VF: vendor: 1af4 device: 1041 subvendor: 8086 subdevice: 05fe
>> >> >>
>> >> >> The patch currently needs no check for device ID, because the callback
>> >> >> will never be made for devices that do not assert the capability or
>> >> >> when run on a platform incapable of SR-IOV.
>> >> >>
>> >> >> One reason for this patch is because the hardware requires the
>> >> >> vendor ID of a VF to be the same as the vendor ID of the PF that
>> >> >> created it. So it seemed logical to simply have a fully-functioning
>> >> >> virtio_net PF create the VFs. This patch makes that possible.
>> >> >>
>> >> >> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> >> >> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
>> >> >> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
>> >> >
>> >> > So if and when virtio PFs can manage the VFs, then we can
>> >> > add a feature bit for that?
>> >> > Seems reasonable.
>> >>
>> >> Yes. If nothing else you may not even need a feature bit depending on
>> >> how things go.
>> >
>> > OTOH if the interface is changed in an incompatible way,
>> > and old Linux will attempt to drive the new device
>> > since there is no check.
>> >
>> > I think we should add a feature bit right away.
>>
>> I'm not sure why you would need a feature bit. The capability is
>> controlled via PCI configuration space. If it is present the device
>> has the capability. If it is not then it does not.
>>
>> Basically if the PCI configuration space is not present then the sysfs
>> entries will not be spawned and nothing will attempt to use this
>> function.
>>
>> - ALex
>
> It's about compability with older guests which ignore the
> capability.
>
> The feature is thus helpful so host knows whether guest supports VFs.

The thing is if the capability is ignored then the feature isn't used.
So for SR-IOV it isn't an uncommon thing for there to be drivers for
the PF floating around that do not support SR-IOV. In such cases
SR-IOV just isn't used while the hardware could support it.

I would think in the case of virtio it would be the same kind of
thing. Basically if SR-IOV is supported by the host then the
capability would be present. If SR-IOV is supported by the guest then
it would make use of the capability to spawn VFs. If either the
capability isn't present, or the driver doesn't use it then you won't
be able to spawn VFs in the guest.

Maybe I am missing something. Do you support dynamically changing the
PCI configuration space for Virtio devices based on the presence of
feature bits provided by the guest?

Also are you saying this patch set should wait on the feature bit to
be added, or are you talking about doing this as some sort of
follow-up?

- Alex
