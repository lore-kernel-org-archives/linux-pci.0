Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [RFC PATCH 24/30] iommu: Specify PASID state when unbinding a task
To: Joerg Roedel <joro@8bytes.org>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-25-jean-philippe.brucker@arm.com>
 <20170322154429.GE7266@8bytes.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <e2bb4c67-9b61-01cf-cc17-68088cdc5e5b@arm.com>
Date: Wed, 22 Mar 2017 18:31:01 +0000
MIME-Version: 1.0
In-Reply-To: <20170322154429.GE7266@8bytes.org>
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

On 22/03/17 15:44, Joerg Roedel wrote:
> On Mon, Feb 27, 2017 at 07:54:35PM +0000, Jean-Philippe Brucker wrote:
>> It is an important distinction because, if the IOMMU driver reassigns a
>> PASID while the IOMMU still holds pending PPR targeting that PASID
>> internally, the PPR will trigger a fault in the wrong address space.
> 
> The IOMMU driver also controls a devices apbility to issue PPR requests
> (at least on PCI), so it already knows whether a device has still
> requests pending or if it even can create new ones.

Apart from resetting the PRI capability, the SMMU doesn't have any control
over the device's PPR requests, so we simply mandate that the caller did
the required work to stop issuing them before calling iommu_unbind.

> Furhter, the IOMMU driver can already wait for all pending faults to be
> processed before it shuts down a PASID. So it is not clear to me why the
> device driver needs to be involved here.

The problem might be too tied to the specifics of the SMMU. As implemented
in this series, the normal flow for a PPR with the SMMU is the following:

(1) PCI device issues a PPR for PASID 1
(2) The PPR is queued by the SMMU in the (hardware) PRI queue
(3) The SMMU driver receives an interrupt, dequeues the PPR and moves it
    to a software work queue.
(4) The PPR is finally handled and a PRI response is sent to the device.

The case that worries me is if someone unbinds PASID 1 between (2) and
(3), while the PPR is still in the hardware queue, and immediately binds
it to a new address space.

Then (3) and (4) happen, the PPR is handled and the fault is for the new
address space. It's certainly undesirable, but I don't know if it could be
exploited. We don't kill the task for an unhandled fault at the moment,
simply report a failed PPR to the device, so I might be worrying for nothing.

Having the caller tell us if PPRs might still be pending in the hardware
PRI queue ensures that the SMMU driver waits until it's entirely safe:

* If the device has no outstanding PPR, PASID can be reallocated
* If the device has outstanding PPRs, wait for a Stop Marker, or drain
  the PRI queue after a while (if the Stop Marker was lost in a PRI queue
  overflow).

Draining the PRI queue is very costly, we need to block the PRI thread to
inspect the queue, risking an overflow. And with these PASID state flags
we avoid flushing any queue.

But since the problem seems too centered around the SMMU, I might just
drop this patch along with the CLEAN/FLUSHED flags in my next version, and
go with the full-drain solution. After all, unbind should be a fairly rare
event.

Thanks,
Jean-Philippe

> When the device driver issues a PASID-unbind call the iommu driver
> just waits until all pending faults are processed, answers new faults
> with INVALID, then switch off the devices capability to issue new
> faults, and then release the PASID.
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
