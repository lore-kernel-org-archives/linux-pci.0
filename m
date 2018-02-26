Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45511 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751429AbeBZWo6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Feb 2018 17:44:58 -0500
MIME-Version: 1.0
In-Reply-To: <20180227003257-mutt-send-email-mst@kernel.org>
References: <20180226044837.19543.12267.stgit@mdrustad-mac04.local>
 <CAKgT0UcMth9Jxovoj7xo0q2t+MuY0K1Upf+Mqs3zgXdriui-tA@mail.gmail.com>
 <E8D91EBA-F75D-4FF9-BDE8-FCE3A4B4B007@intel.com> <CAKgT0UcG91o3H8jmSJFfyt2p_CoqxgCYrEX2Xchoira6nu6mNg@mail.gmail.com>
 <20180227003257-mutt-send-email-mst@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 26 Feb 2018 14:44:56 -0800
Message-ID: <CAKgT0UdicSYCJ_=oCUrxKg+zx5X3B9ubt1X+BdfP42n4NR9B3g@mail.gmail.com>
Subject: Re: [RFC PATCH V4] pci: virtio_pci: Add SR-IOV support for virtio_pci devices
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Rustad, Mark D" <mark.d.rustad@intel.com>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Daly, Dan" <dan.daly@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "MRustad@gmail.com" <MRustad@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 26, 2018 at 2:38 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Mon, Feb 26, 2018 at 10:05:31AM -0800, Alexander Duyck wrote:
>> On Mon, Feb 26, 2018 at 9:48 AM, Rustad, Mark D <mark.d.rustad@intel.com=
> wrote:
>> > Alex,
>> >
>> >> On Feb 26, 2018, at 7:26 AM, Alexander Duyck <alexander.duyck@gmail.c=
om> wrote:
>> >>
>> >> Mark,
>> >>
>> >> In the future please don't put my "Reviewed-by" on a patch that I
>> >> haven't reviewed. I believe I reviewed one of the earlier patches, bu=
t
>> >> I hadn't reviewed this version.
>> >
>> > I'm very sorry. I completely spaced doing something about that. I thin=
k yours was the first Reviewed-by I ever had in this way. In the future I w=
ill remove such things from my changelog right after sending. Thanks for al=
erting me to what I had failed to do.
>> >
>> >> Also, after thinking about it over the weekend we may want to look at
>> >> just coming up with a truly "generic" solution that is applied to
>> >> SR-IOV capable devices that don't have a SR-IOV capable driver loaded
>> >> on them. That would allow us to handle the uio, vfio, pci-stub, and
>> >> virtio cases all in one fell swoop. I think us going though and
>> >> modifying one patch at a time to do this kind of thing isn't going to
>> >> scale.
>> >
>> > The notion of that kind of troubles me - at least pci-stub does. Havin=
g worked on ixgbe a bit, I have to wonder what kind of havoc would ensue if=
 an ixgbe device were assigned to a guest, and an attempt was made to alloc=
ate VFs by the pci-stub. The guest could be running any version of the ixgb=
e driver, possibly even an old one that didn't support SR-IOV. Even if it d=
id support SR-IOV, I don't know how it would respond to mailbox messages wh=
en it doesn't think it has VFs.
>>
>> The assumption here is that the root user knows what they are doing.
>
> There are tools that let non-root users load the stub.
>
> People use that to e.g.  prevent a native driver from loading while also
> assuming it won't break the kernel.
>
>
>> We have already had some discussion on this in regards to VFIO. My
>> thought is we look at adding a new PCI sysfs option called
>> "sriov_unmanaged_autoprobe" that would be similar to
>> "sriov_drivers_autoprobe" and is used to determine if we allow for
>> auto probing of the VFs into the host kernel when SR-IOV is enabled.
>
> I'm not sure how a global option can work for use-cases
> such as containers though.

It isn't global. It is per PF. There is a sysfs value per PF called
"sriov_drivers_autoprobe" that currently controls if VFs are
automatically bound by drivers from the kernel. What I am suggesting
is we split that value, and then add a new one called
"sriov_unmanaged_autoprobe" to handle the case where either there is
no driver on the PF or the driver loaded doesn't support SR-IOV. The
default behavior for it would be to be disabled by default so if VFs
are spawned by an unmanaged PF the drivers don't load on them by
default. The root user can toggle the sysfs entry if they want that
behavior to change.

The idea based on a request by Alex Williamson that we prevent VF
drivers from loading in the host if a PF is managed by user-space or a
firmware entity and we don't have a clear way of configuring VFs from
the kernel.

- Alex
