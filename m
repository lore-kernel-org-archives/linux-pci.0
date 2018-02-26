Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180227003123-mutt-send-email-mst@kernel.org>
References: <20180226044837.19543.12267.stgit@mdrustad-mac04.local>
 <CAKgT0UcMth9Jxovoj7xo0q2t+MuY0K1Upf+Mqs3zgXdriui-tA@mail.gmail.com> <20180227003123-mutt-send-email-mst@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 26 Feb 2018 14:38:01 -0800
Message-ID: <CAKgT0UfGsQbONBWpoHmT4pM8gxonjovuD0BWraeA9D7q1SCtaw@mail.gmail.com>
Subject: Re: [RFC PATCH V4] pci: virtio_pci: Add SR-IOV support for virtio_pci devices
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mark Rustad <mark.d.rustad@intel.com>,
        virtio-dev@lists.oasis-open.org, Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        "Daly, Dan" <dan.daly@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Mark Rustad <MRustad@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 26, 2018 at 2:32 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Mon, Feb 26, 2018 at 07:26:14AM -0800, Alexander Duyck wrote:
>> On Sun, Feb 25, 2018 at 8:48 PM, Mark Rustad <mark.d.rustad@intel.com> wrote:
>> > Hardware-realized virtio_pci devices can implement SR-IOV, so this
>> > patch enables its use. The device in question is an upcoming Intel
>> > NIC that implements both a virtio_net PF and virtio_net VFs. These
>> > are hardware realizations of what has been up to now been a software
>> > interface.
>> >
>> > The device in question has the following 4-part PCI IDs:
>> >
>> > PF: vendor: 1af4 device: 1041 subvendor: 8086 subdevice: 15fe
>> > VF: vendor: 1af4 device: 1041 subvendor: 8086 subdevice: 05fe
>> >
>> > The patch needs no check for device ID, because the callback will
>> > never be made for devices that do not assert the capability or
>> > when run on a platform incapable of SR-IOV.
>> >
>> > One reason for this patch is because the hardware requires the
>> > vendor ID of a VF to be the same as the vendor ID of the PF that
>> > created it. So it seemed logical to simply have a fully-functioning
>> > virtio_net PF create the VFs. This patch makes that possible.
>> >
>> > Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
>> > Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>
>>
>> Mark,
>>
>> In the future please don't put my "Reviewed-by" on a patch that I
>> haven't reviewed. I believe I reviewed one of the earlier patches, but
>> I hadn't reviewed this version.
>>
>> Also, after thinking about it over the weekend we may want to look at
>> just coming up with a truly "generic" solution that is applied to
>> SR-IOV capable devices that don't have a SR-IOV capable driver loaded
>> on them. That would allow us to handle the uio, vfio, pci-stub, and
>> virtio cases all in one fell swoop. I think us going though and
>> modifying one patch at a time to do this kind of thing isn't going to
>> scale.
>
> uio really can't support VFs properly - without proper IOMMU
> support any MSIs can corrupt kernel memory, and VFs are
> limited to MSIs.

UIO wasn't being run on the VFs, it was just running the PF. The point
is that there have been about 4 attempts, including this one, to add
SR-IOV support to drivers that don't actually do any VF management
internally. They were just being used as a shim so that they could add
the sriov_configure function to a driver that would load on the PF.

If we make the solution generic I think it should turn out pretty
clean. Most of the work just needs to happen in the sysfs function for
storing the value that is written to sriov_numvfs. I'm working with
Mark and a few other people now to get this addressed and I hope that
we can have a patch available shortly.

Thanks.

- Alex
