Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 22 Mar 2017 23:53:20 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC PATCH 24/30] iommu: Specify PASID state when unbinding a task
Message-ID: <20170322225320.GF7266@8bytes.org>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-25-jean-philippe.brucker@arm.com>
 <20170322154429.GE7266@8bytes.org>
 <e2bb4c67-9b61-01cf-cc17-68088cdc5e5b@arm.com>
MIME-Version: 1.0
In-Reply-To: <e2bb4c67-9b61-01cf-cc17-68088cdc5e5b@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Shanker Donthineni <shankerd@qti.qualcomm.com>, kvm@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Sinan Kaya <okaya@qti.qualcomm.com>,
 Will Deacon <will.deacon@arm.com>, iommu@lists.linux-foundation.org,
 Harv Abdulhamid <harba@qti.qualcomm.com>,
 Alex Williamson <alex.williamson@redhat.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Nate Watterson <nwatters@qti.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 22, 2017 at 06:31:01PM +0000, Jean-Philippe Brucker wrote:
> The problem might be too tied to the specifics of the SMMU. As implemented
> in this series, the normal flow for a PPR with the SMMU is the following:
> 
> (1) PCI device issues a PPR for PASID 1
> (2) The PPR is queued by the SMMU in the (hardware) PRI queue
> (3) The SMMU driver receives an interrupt, dequeues the PPR and moves it
>     to a software work queue.
> (4) The PPR is finally handled and a PRI response is sent to the device.

There are two ways a PASID could get shut down:

	1) The device driver calls unbind()
	2) The mm_struct bound to that PASID is going away

Case 1) is the easy one, we can safely assume that the device driver did
anything to stop new PPR requests from being created for that PASID. In
this case we just shut down PPR processing by waiting until everything
is handled and reply INVALID to any further PPR request before we remove
the PASID from the per-device IOMMU data structures and flush caches.

In case 2) we have more work to do. The mm_struct is going away
(probably because the task segfaulted) and we can't assume that the
device driver shut everything down already. But for this case we have
the call-back into the device driver to tell it should clean everything
up for that PASID and stop the device from creating further requests.

After that call-back returns it is the same as in case 1), we drain the
queue and deny any further request that comes in.

> The case that worries me is if someone unbinds PASID 1 between (2) and
> (3), while the PPR is still in the hardware queue, and immediately binds
> it to a new address space.
> 
> Then (3) and (4) happen, the PPR is handled and the fault is for the new
> address space. It's certainly undesirable, but I don't know if it could be
> exploited. We don't kill the task for an unhandled fault at the moment,
> simply report a failed PPR to the device, so I might be worrying for nothing.

As I wrote above, when the device driver calls unbind() we should
assume that the device does not sent any further requests with that
PASID. If it does, we just answer with INVALID.

> Having the caller tell us if PPRs might still be pending in the hardware
> PRI queue ensures that the SMMU driver waits until it's entirely safe:
> 
> * If the device has no outstanding PPR, PASID can be reallocated
> * If the device has outstanding PPRs, wait for a Stop Marker, or drain
>   the PRI queue after a while (if the Stop Marker was lost in a PRI queue
>   overflow).

That can't happen, when the device driver does its job right. It has to
shut down the context which causes the PPR requests for the PASID on the
device. This includes stopping the context and waiting until all PPR
requests it sent are processed.

And the device driver has to do this either before it calls unbind() or
in the call-back it provided. Only after this the PASID should be freed.

> Draining the PRI queue is very costly, we need to block the PRI thread to
> inspect the queue, risking an overflow. And with these PASID state flags
> we avoid flushing any queue.

There is a configurable maximum of PPR requests a device can have
in-flight. If you take that into account when allocation the PPR queue
for the SMMU, there can't be any overflows. The AMD driver allocates a
queue for 512 entries and allows devices to have a maximum of 32
outstanding requests.

> But since the problem seems too centered around the SMMU, I might just
> drop this patch along with the CLEAN/FLUSHED flags in my next version, and
> go with the full-drain solution. After all, unbind should be a fairly rare
> event.

I don't think all this is SMMU specific, it is the same on all other
IOMMUs that have the ATS/PRI/PASID features.



	Joerg


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
