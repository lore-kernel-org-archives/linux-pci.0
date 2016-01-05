Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:35017 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753887AbcAEDL0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jan 2016 22:11:26 -0500
MIME-Version: 1.0
In-Reply-To: <20160104204104.GB17427@char.us.oracle.com>
References: <20151213212557.5410.48577.stgit@localhost.localdomain>
	<20160104204104.GB17427@char.us.oracle.com>
Date: Mon, 4 Jan 2016 19:11:25 -0800
Message-ID: <CAKgT0UenF-Cj2fvFPEmY0g7FOf=85HbFJ9iFUjs4KgsaXrckqA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] x86: Add support for guest DMA dirty page tracking
From: Alexander Duyck <alexander.duyck@gmail.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Alexander Duyck <aduyck@mirantis.com>, kvm@vger.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	x86@kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	qemu-devel@nongnu.org, Lan Tianyu <tianyu.lan@intel.com>,
	Yang Zhang <yang.zhang.wz@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Alexander Graf <agraf@suse.de>,
	Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 4, 2016 at 12:41 PM, Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
> On Sun, Dec 13, 2015 at 01:28:09PM -0800, Alexander Duyck wrote:
>> This patch set is meant to be the guest side code for a proof of concept
>> involving leaving pass-through devices in the guest during the warm-up
>> phase of guest live migration.  In order to accomplish this I have added a
>
> What does that mean? 'warm-up-phase'?

It is the first phase in a pre-copy migration.
https://en.wikipedia.org/wiki/Live_migration

Basically in this phase all the memory is marked as dirty and then
copied.  Any memory that changes gets marked as dirty as well.
Currently DMA circumvents this as the user space dirty page tracking
isn't able to track DMA.

>> new function called dma_mark_dirty that will mark the pages associated with
>> the DMA transaction as dirty in the case of either an unmap or a
>> sync_.*_for_cpu where the DMA direction is either DMA_FROM_DEVICE or
>> DMA_BIDIRECTIONAL.  The pass-through device must still be removed before
>> the stop-and-copy phase, however allowing the device to be present should
>> significantly improve the performance of the guest during the warm-up
>> period.
>
> .. if the warm-up phase is short I presume? If the warm-up phase takes
> a long time (busy guest that is of 1TB size) it wouldn't help much as the
> tracking of these DMA's may be quite long?
>
>>
>> This current implementation is very preliminary and there are number of
>> items still missing.  Specifically in order to make this a more complete
>> solution we need to support:
>> 1.  Notifying hypervisor that drivers are dirtying DMA pages received
>
> .. And somehow giving the hypervisor the GPFN so it can retain the PFN in
> the VT-d as long as possible.

Yes, what has happened is that the host went through and marked all
memory as read-only.  So trying to do any operation that requires
write access triggers a page fault which is then used by the host to
track pages that were dirtied.

>> 2.  Bypassing page dirtying when it is not needed.
>
> How would this work with with device doing DMA operations _after_ the migration?
> That is the driver submits and DMA READ.. migrates away, device is unplugged,
> VT-d context is torn down - device does the DMA READ gets an VT-d error...
>
> and what then? How should the device on the other host replay the DMA READ?

The device has to quiesce before the migration can occur.  We cannot
have any DMA mappings still open when we reach the stop-and-copy phase
of the migration.  The solution I have proposed here works for
streaming mappings but doesn't solve the case for things like
dma_alloc_coherent where a bidirectional mapping is maintained between
the CPU and the device.

>>
>> The two mechanisms referenced above would likely require coordination with
>> QEMU and as such are open to discussion.  I haven't attempted to address
>> them as I am not sure there is a consensus as of yet.  My personal
>> preference would be to add a vendor-specific configuration block to the
>> emulated pci-bridge interfaces created by QEMU that would allow us to
>> essentially extend shpc to support guest live migration with pass-through
>> devices.
>
> shpc?

That is kind of what I was thinking.  We basically need some mechanism
to allow for the host to ask the device to quiesce.  It has been
proposed to possibly even look at something like an ACPI interface
since I know ACPI is used by QEMU to manage hot-plug in the standard
case.

- Alex
