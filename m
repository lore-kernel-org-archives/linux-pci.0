Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 14 Dec 2015 16:02:59 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yang Zhang <yang.zhang.wz@gmail.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	Alexander Duyck <aduyck@mirantis.com>, kvm@vger.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	x86@kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	qemu-devel@nongnu.org, Lan Tianyu <tianyu.lan@intel.com>,
	konrad.wilk@oracle.com,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Alexander Graf <agraf@suse.de>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC PATCH 0/3] x86: Add support for guest DMA dirty page
 tracking
Message-ID: <20151214160139-mutt-send-email-mst@redhat.com>
References: <20151213212557.5410.48577.stgit@localhost.localdomain>
 <566E2917.7050705@gmail.com>
 <CAKgT0Uf6ZFRkKFfWzDJPhKqPYD9mXEWR6jpXgVR9DpZYugDOCg@mail.gmail.com>
 <566E521F.5090103@gmail.com>
 <CAKgT0UfgmwkZpU2=6DCsPZOwhDPyZDkbrPGH-dhVfA3ZVusJyQ@mail.gmail.com>
 <566E6DBA.4080800@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <566E6DBA.4080800@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 14, 2015 at 03:20:26PM +0800, Yang Zhang wrote:
> On 2015/12/14 13:46, Alexander Duyck wrote:
> >On Sun, Dec 13, 2015 at 9:22 PM, Yang Zhang <yang.zhang.wz@gmail.com> wrote:
> >>On 2015/12/14 12:54, Alexander Duyck wrote:
> >>>
> >>>On Sun, Dec 13, 2015 at 6:27 PM, Yang Zhang <yang.zhang.wz@gmail.com>
> >>>wrote:
> >>>>
> >>>>On 2015/12/14 5:28, Alexander Duyck wrote:
> >>>>>
> >>>>>
> >>>>>This patch set is meant to be the guest side code for a proof of concept
> >>>>>involving leaving pass-through devices in the guest during the warm-up
> >>>>>phase of guest live migration.  In order to accomplish this I have added
> >>>>>a
> >>>>>new function called dma_mark_dirty that will mark the pages associated
> >>>>>with
> >>>>>the DMA transaction as dirty in the case of either an unmap or a
> >>>>>sync_.*_for_cpu where the DMA direction is either DMA_FROM_DEVICE or
> >>>>>DMA_BIDIRECTIONAL.  The pass-through device must still be removed before
> >>>>>the stop-and-copy phase, however allowing the device to be present
> >>>>>should
> >>>>>significantly improve the performance of the guest during the warm-up
> >>>>>period.
> >>>>>
> >>>>>This current implementation is very preliminary and there are number of
> >>>>>items still missing.  Specifically in order to make this a more complete
> >>>>>solution we need to support:
> >>>>>1.  Notifying hypervisor that drivers are dirtying DMA pages received
> >>>>>2.  Bypassing page dirtying when it is not needed.
> >>>>>
> >>>>
> >>>>Shouldn't current log dirty mechanism already cover them?
> >>>
> >>>
> >>>The guest has no way of currently knowing that the hypervisor is doing
> >>>dirty page logging, and the log dirty mechanism currently has no way
> >>>of tracking device DMA accesses.  This change is meant to bridge the
> >>>two so that the guest device driver will force the SWIOTLB DMA API to
> >>>mark pages written to by the device as dirty.
> >>
> >>
> >>OK. This is what we called "dummy write mechanism". Actually, this is just a
> >>workaround before iommu dirty bit ready. Eventually, we need to change to
> >>use the hardware dirty bit. Besides, we may still lost the data if dma
> >>happens during/just before stop and copy phase.
> >
> >Right, this is a "dummy write mechanism" in order to allow for entry
> >tracking.  This only works completely if we force the hardware to
> >quiesce via a hot-plug event before we reach the stop-and-copy phase
> >of the migration.
> >
> >The IOMMU dirty bit approach is likely going to have a significant
> >number of challenges involved.  Looking over the driver and the data
> >sheet it looks like the current implementation is using a form of huge
> >pages in the IOMMU, as such we will need to tear that down and replace
> >it with 4K pages if we don't want to dirty large regions with each DMA
> 
> Yes, we need to split the huge page into small pages to get the small dirty
> range.
> 
> >transaction, and I'm not sure that is something we can change while
> >DMA is active to the affected regions.  In addition the data sheet
> 
> what changes do you mean?
> 
> >references the fact that the page table entries are stored in a
> >translation cache and in order to sync things up you have to
> >invalidate the entries.  I'm not sure what the total overhead would be
> >for invalidating something like a half million 4K pages to migrate a
> >guest with just 2G of RAM, but I would think that might be a bit
> 
> Do you mean the cost of submit the flush request or the performance
> impaction due to IOTLB miss? For the former, we have domain-selective
> invalidation. For the latter, it would be acceptable since live migration
> shouldn't last too long.

That's pretty weak - if migration time is short and speed does not
matter during migration, then all this work is useless, temporarily
switching to a virtual card would be preferable.

> >expensive given the fact that IOMMU accesses aren't known for being
> >incredibly fast when invalidating DMA on the host.
> >
> >- Alex
> >
> 
> 
> -- 
> best regards
> yang
