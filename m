Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [RFC PATCH 22/30] iommu: Bind/unbind tasks to/from devices
To: Joerg Roedel <joro@8bytes.org>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-23-jean-philippe.brucker@arm.com>
 <1488534044.6234.14.camel@infradead.org>
 <20170303183958.GA15146@e106794-lin.localdomain>
 <20170322153610.GC7266@8bytes.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <426ce726-e4e3-ea7c-81ac-154ee40a2d79@arm.com>
Date: Wed, 22 Mar 2017 18:30:56 +0000
MIME-Version: 1.0
In-Reply-To: <20170322153610.GC7266@8bytes.org>
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
 Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>,
 Harv Abdulhamid <harba@qti.qualcomm.com>,
 Alex Williamson <alex.williamson@redhat.com>, iommu@lists.linux-foundation.org,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Nate Watterson <nwatters@qti.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Joerg,

On 22/03/17 15:36, Joerg Roedel wrote:
> On Fri, Mar 03, 2017 at 06:39:58PM +0000, Jean-Philippe Brucker wrote:
>> Yes, it would be nice to have a common PASID allocator. But I don't
>> think that a system-wide PASID space is workable for us. At the moment
>> systems might have a few identical devices all supporting 20 bits of
>> PASID. But consider the case where one odd device can only handle four
>> address spaces, and supports a maximum of two PASID bits. We'd quickly
>> run out of PASIDs to hand to such devices, even though we could easily
>> have one PASID space per endpoint (from a quick glance at the specs, I
>> assume that both Intel and AMD IOMMUs offer one PASID table per RID.)
> 
> But that shouldn't be a problem if we allocate PASIDs top-down (meaning
> starting from the biggest value supported by a given device), right?
> 
> Then we can satisfy the devices with 16 or 20 bit PASIDs and still have
> the 2-bit PASIDs free for the devices that need it.

But if there is more than 4 devices that only support 2 bit PASIDs, you
still get a starvation that you wouldn't get with per-domain/device PASID
allocator. Arguably I have no real-world example to back this up, we can
probably expect vendors to always implement a sane amount of PASID bits.
Unifying the API is certainly more important than imagining all the
twisted configurations possible, and a PASID allocator with per-task
top-down allocation seems to me like an acceptable compromise.

Thanks,
Jean-Philippe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
