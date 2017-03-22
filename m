Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 22 Mar 2017 16:44:29 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC PATCH 24/30] iommu: Specify PASID state when unbinding a task
Message-ID: <20170322154429.GE7266@8bytes.org>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-25-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
In-Reply-To: <20170227195441.5170-25-jean-philippe.brucker@arm.com>
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

On Mon, Feb 27, 2017 at 07:54:35PM +0000, Jean-Philippe Brucker wrote:
> It is an important distinction because, if the IOMMU driver reassigns a
> PASID while the IOMMU still holds pending PPR targeting that PASID
> internally, the PPR will trigger a fault in the wrong address space.

The IOMMU driver also controls a devices apbility to issue PPR requests
(at least on PCI), so it already knows whether a device has still
requests pending or if it even can create new ones.

Furhter, the IOMMU driver can already wait for all pending faults to be
processed before it shuts down a PASID. So it is not clear to me why the
device driver needs to be involved here.

When the device driver issues a PASID-unbind call the iommu driver
just waits until all pending faults are processed, answers new faults
with INVALID, then switch off the devices capability to issue new
faults, and then release the PASID.



	Joerg


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
