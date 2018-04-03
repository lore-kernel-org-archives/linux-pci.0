Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180403161151-mutt-send-email-mst@kernel.org>
References: <20180315183449.3102.64791.stgit@localhost.localdomain>
 <20180315184132.3102.90947.stgit@localhost.localdomain> <20180316183042-mutt-send-email-mst@kernel.org>
 <CAKgT0UfgZ2gAdiAbCe4MTOr3o9cqq1q-mykCQsw68p2F-QEC8g@mail.gmail.com> <20180403161151-mutt-send-email-mst@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 3 Apr 2018 10:32:00 -0700
Message-ID: <CAKgT0UfeSmG=xsd6sTkg4cOMnZ0QiqtCRDt4PynpF3d6nvvFCA@mail.gmail.com>
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

On Tue, Apr 3, 2018 at 6:12 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Fri, Mar 16, 2018 at 09:40:34AM -0700, Alexander Duyck wrote:
>> On Fri, Mar 16, 2018 at 9:34 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > On Thu, Mar 15, 2018 at 11:42:41AM -0700, Alexander Duyck wrote:
>> >> From: Alexander Duyck <alexander.h.duyck@intel.com>
>> >>
>> >> Hardware-realized virtio_pci devices can implement SR-IOV, so this
>> >> patch enables its use. The device in question is an upcoming Intel
>> >> NIC that implements both a virtio_net PF and virtio_net VFs. These
>> >> are hardware realizations of what has been up to now been a software
>> >> interface.
>> >>
>> >> The device in question has the following 4-part PCI IDs:
>> >>
>> >> PF: vendor: 1af4 device: 1041 subvendor: 8086 subdevice: 15fe
>> >> VF: vendor: 1af4 device: 1041 subvendor: 8086 subdevice: 05fe
>> >>
>> >> The patch currently needs no check for device ID, because the callback
>> >> will never be made for devices that do not assert the capability or
>> >> when run on a platform incapable of SR-IOV.
>> >>
>> >> One reason for this patch is because the hardware requires the
>> >> vendor ID of a VF to be the same as the vendor ID of the PF that
>> >> created it. So it seemed logical to simply have a fully-functioning
>> >> virtio_net PF create the VFs. This patch makes that possible.
>> >>
>> >> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> >> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
>> >> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
>> >
>> > So if and when virtio PFs can manage the VFs, then we can
>> > add a feature bit for that?
>> > Seems reasonable.
>>
>> Yes. If nothing else you may not even need a feature bit depending on
>> how things go.
>
> OTOH if the interface is changed in an incompatible way,
> and old Linux will attempt to drive the new device
> since there is no check.
>
> I think we should add a feature bit right away.

I'm not sure why you would need a feature bit. The capability is
controlled via PCI configuration space. If it is present the device
has the capability. If it is not then it does not.

Basically if the PCI configuration space is not present then the sysfs
entries will not be spawned and nothing will attempt to use this
function.

- ALex
