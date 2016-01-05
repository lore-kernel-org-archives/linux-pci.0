Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:35615 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbcAEQSL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jan 2016 11:18:11 -0500
MIME-Version: 1.0
In-Reply-To: <20160105113317-mutt-send-email-mst@redhat.com>
References: <20151213212557.5410.48577.stgit@localhost.localdomain>
	<20160104204104.GB17427@char.us.oracle.com>
	<CAKgT0UenF-Cj2fvFPEmY0g7FOf=85HbFJ9iFUjs4KgsaXrckqA@mail.gmail.com>
	<20160105113317-mutt-send-email-mst@redhat.com>
Date: Tue, 5 Jan 2016 08:18:10 -0800
Message-ID: <CAKgT0UeY9+BJoGtM+Fqa4Zve36GBJQpYVyoo2CPJZdELH6cEbg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] x86: Add support for guest DMA dirty page tracking
From: Alexander Duyck <alexander.duyck@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Alexander Duyck <aduyck@mirantis.com>, kvm@vger.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	x86@kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	qemu-devel@nongnu.org, Lan Tianyu <tianyu.lan@intel.com>,
	Yang Zhang <yang.zhang.wz@gmail.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Alexander Graf <agraf@suse.de>,
	Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 5, 2016 at 1:40 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Mon, Jan 04, 2016 at 07:11:25PM -0800, Alexander Duyck wrote:
>> >> The two mechanisms referenced above would likely require coordination with
>> >> QEMU and as such are open to discussion.  I haven't attempted to address
>> >> them as I am not sure there is a consensus as of yet.  My personal
>> >> preference would be to add a vendor-specific configuration block to the
>> >> emulated pci-bridge interfaces created by QEMU that would allow us to
>> >> essentially extend shpc to support guest live migration with pass-through
>> >> devices.
>> >
>> > shpc?
>>
>> That is kind of what I was thinking.  We basically need some mechanism
>> to allow for the host to ask the device to quiesce.  It has been
>> proposed to possibly even look at something like an ACPI interface
>> since I know ACPI is used by QEMU to manage hot-plug in the standard
>> case.
>>
>> - Alex
>
>
> Start by using hot-unplug for this!
>
> Really use your patch guest side, and write host side
> to allow starting migration with the device, but
> defer completing it.

Yeah, I'm fully on board with this idea, though I'm not really working
on this right now since last I knew the folks on this thread from
Intel were working on it.  My patches were mostly meant to be a nudge
in this direction so that we could get away from the driver specific
code.

> So
>
> 1.- host tells guest to start tracking memory writes
> 2.- guest acks
> 3.- migration starts
> 4.- most memory is migrated
> 5.- host tells guest to eject device
> 6.- guest acks
> 7.- stop vm and migrate rest of state
>

Sounds about right.  The only way this differs from what I see as the
final solution for this is that instead of fully ejecting the device
in step 5 the driver would instead pause the device and give the host
something like 10 seconds to stop the VM and resume with the same
device connected if it is available.  We would probably also need to
look at a solution that would force the device to be ejected or abort
prior to starting the migration if it doesn't give us the ack in step
2.

> It will already be a win since hot unplug after migration starts and
> most memory has been migrated is better than hot unplug before migration
> starts.

Right.  Generally the longer the VF can be maintained as a part of the
guest the longer the network performance is improved versus using a
purely virtual interface.

> Then measure downtime and profile. Then we can look at ways
> to quiesce device faster which really means step 5 is replaced
> with "host tells guest to quiesce device and dirty (or just unmap!)
> all memory mapped for write by device".

Step 5 will be the spot where we really need to start modifying
drivers.  Specifically we probably need to go through and clean-up
things so that we can reduce as many of the delays in the driver
suspend/resume path as possible.  I suspect there is quite a bit that
can be done there that would probably also improve boot and shutdown
times since those are also impacted by the devices.

- Alex
