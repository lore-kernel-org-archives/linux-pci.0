Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <E8D91EBA-F75D-4FF9-BDE8-FCE3A4B4B007@intel.com>
References: <20180226044837.19543.12267.stgit@mdrustad-mac04.local>
 <CAKgT0UcMth9Jxovoj7xo0q2t+MuY0K1Upf+Mqs3zgXdriui-tA@mail.gmail.com> <E8D91EBA-F75D-4FF9-BDE8-FCE3A4B4B007@intel.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 26 Feb 2018 10:05:31 -0800
Message-ID: <CAKgT0UcG91o3H8jmSJFfyt2p_CoqxgCYrEX2Xchoira6nu6mNg@mail.gmail.com>
Subject: Re: [RFC PATCH V4] pci: virtio_pci: Add SR-IOV support for virtio_pci devices
To: "Rustad, Mark D" <mark.d.rustad@intel.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Daly, Dan" <dan.daly@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "MRustad@gmail.com" <MRustad@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 26, 2018 at 9:48 AM, Rustad, Mark D <mark.d.rustad@intel.com> w=
rote:
> Alex,
>
>> On Feb 26, 2018, at 7:26 AM, Alexander Duyck <alexander.duyck@gmail.com>=
 wrote:
>>
>> Mark,
>>
>> In the future please don't put my "Reviewed-by" on a patch that I
>> haven't reviewed. I believe I reviewed one of the earlier patches, but
>> I hadn't reviewed this version.
>
> I'm very sorry. I completely spaced doing something about that. I think y=
ours was the first Reviewed-by I ever had in this way. In the future I will=
 remove such things from my changelog right after sending. Thanks for alert=
ing me to what I had failed to do.
>
>> Also, after thinking about it over the weekend we may want to look at
>> just coming up with a truly "generic" solution that is applied to
>> SR-IOV capable devices that don't have a SR-IOV capable driver loaded
>> on them. That would allow us to handle the uio, vfio, pci-stub, and
>> virtio cases all in one fell swoop. I think us going though and
>> modifying one patch at a time to do this kind of thing isn't going to
>> scale.
>
> The notion of that kind of troubles me - at least pci-stub does. Having w=
orked on ixgbe a bit, I have to wonder what kind of havoc would ensue if an=
 ixgbe device were assigned to a guest, and an attempt was made to allocate=
 VFs by the pci-stub. The guest could be running any version of the ixgbe d=
river, possibly even an old one that didn't support SR-IOV. Even if it did =
support SR-IOV, I don't know how it would respond to mailbox messages when =
it doesn't think it has VFs.

The assumption here is that the root user knows what they are doing.
We have already had some discussion on this in regards to VFIO. My
thought is we look at adding a new PCI sysfs option called
"sriov_unmanaged_autoprobe" that would be similar to
"sriov_drivers_autoprobe" and is used to determine if we allow for
auto probing of the VFs into the host kernel when SR-IOV is enabled. I
would want to default the value to false so that by default an
unmanaged PF wouldn't have its VFs assigned to the host unless we
specifically enable it by updating the sysfs value.

>> I'll try to do some digging and find the VFIO approach we had been
>> working on. I think with a couple tweaks we can probably make that
>> truly generic and ready for submission.
>
> I'd like to know more about you are thinking about.

Basic idea is to take your generic SR-IOV enable/disable bits from
(http://patchwork.ozlabs.org/patch/877674/) and combine it with the
some of the autoprobe bits and feedback comments from
(http://patchwork.ozlabs.org/patch/846454/). The idea would be when
either no driver is loaded, or a driver without the sriov_configure
method we update the iov auto probe setting based on the value we set
via sriov_unamanaged_autoprobe, and then call your generic
configuration method to enable SR-IOV.
