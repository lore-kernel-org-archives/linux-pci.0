Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 2 Mar 2017 10:51:54 +0000
From: Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [RFC PATCH 04/30] iommu/arm-smmu-v3: Add support for PCI ATS
Message-ID: <20170302105153.GB15742@e106794-lin.localdomain>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-5-jean-philippe.brucker@arm.com>
 <5a7822f2-3991-aa51-169f-78ef49567feb@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <5a7822f2-3991-aa51-169f-78ef49567feb@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Harb Abdulhamid <harba@codeaurora.org>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Shanker Donthineni <shankerd@qti.qualcomm.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <Will.Deacon@arm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <Robin.Murphy@arm.com>,
 David Woodhouse <dwmw2@infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Nate Watterson <nwatters@qti.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sinan,

On 01/03/17 19:24, Sinan Kaya wrote:
> On 2/27/2017 2:54 PM, Jean-Philippe Brucker wrote:
>> /* Initialise command lazily */
>> +		if (!cmd.opcode)
>> +			arm_smmu_atc_invalidate_to_cmd(smmu, iova, size, &cmd);
>> +
>> +		spin_lock(&smmu_group->devices_lock);
>> +
>> +		list_for_each_entry(master, &smmu_group->devices, group_head)
>> +			arm_smmu_atc_invalidate_master(master, &cmd);
>> +
>> +		/*
>> +		 * TODO: ensure we do a sync whenever we have sent ats_queue_depth
>> +		 * invalidations to the same device.
>> +		 */
>> +		arm_smmu_cmdq_issue_cmd(smmu, &sync_cmd);
>> +
> 
> It is possible to observe ATS invalidation timeout up to 90 seconds according to PCIe
> spec. How does the current code deal with this?
> 

Currently we give up waiting for sync after 100us (ARM_SMMU_POLL_TIMEOUT_US).
A successful sync guarantees that all ATC invalidations since last sync
were successful, so in case of timeout we should resend all of them.
The delay itself isn't important at the moment, since we don't handle
invalidaton failure at all. It's fire and forget, and I haven't come up
with a complete solution yet.

The simplest error handling would be to retry invalidation after 90
seconds if the sync didn't complete. Then after a number of failed
attempts, maybe try to reset the device. Given that ats_invalidate is
generally called in irq-safe context, we would be blocking the CPU for
minutes at a time, which seems unwise. A proper solution would be to
postpone the unmap and return an error, although unmap errors are
usually ignored.

To avoid letting anyone remap something at that address until we're sure
the invalidation succeeded, we would need to repopulate the page tables
with the stale mapping, and add a delayed work that inspects the status
of the invalidation and tries again if it failed. If the invalidation
comes from the IOMMU core, we control the page tables and it should be
doable. If it comes from mm/ however, it's more complicated. MMU
notifiers only tell us that the mapping is going away, they don't
provide us with a way to hold on to them. Until all stale mappings have
been invalidated, we also need to hold on to the address space.

I think the problem is complex enough to deserve a series of its own,
once we confirm that it may happen in hardware and have a rough idea of
the timeout values encountered.

Thanks,
Jean-Philippe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
