Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 23 Mar 2017 15:52:14 +0000
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC PATCH 24/30] iommu: Specify PASID state when unbinding a task
Message-ID: <20170323145311.GA22972@e106794-lin.localdomain>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-25-jean-philippe.brucker@arm.com>
 <20170322154429.GE7266@8bytes.org>
 <e2bb4c67-9b61-01cf-cc17-68088cdc5e5b@arm.com>
 <20170322225320.GF7266@8bytes.org>
 <a093bc07-a345-a689-9d97-f15a306f922d@arm.com>
 <20170323143014.GK7266@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <20170323143014.GK7266@8bytes.org>
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

On 23/03/17 14:30, Joerg Roedel wrote:
> On Thu, Mar 23, 2017 at 01:37:41PM +0000, Jean-Philippe Brucker wrote:
>> On 22/03/17 22:53, Joerg Roedel wrote:
>>> That can't happen, when the device driver does its job right. It has to
>>> shut down the context which causes the PPR requests for the PASID on the
>>> device. This includes stopping the context and waiting until all PPR
>>> requests it sent are processed.
>>
>> By "processed", do you mean that they are committed to the IOMMU, or that
>> they came back with a PRG response?
> 
> By processed I mean the device received a response to the request, or is
> at least no longer waiting for responses.
> 
>> The driver might not be able to do the latter, since PCI defines two ways
>> of shutting down a context:
>>
>> * Either wait for all PPR requests to come back with a PRG response,
>> * Or send a Stop Marker PPR request and forget about it.
> 
> Are you sure about the meaning of the stop-marker? Can you point me to
> where it is specified?

The concept is introduced in the PCI ECN that adds PASIDs to the ATS
specification. I have the following link, which is probably behind a
wall:

https://pcisig.com/sites/default/files/specification_documents/ECN-PASID-ATS-2011-03-31.pdf

A Stop Marker is a PPR with flags Read=Write=0, Last=1, targeting the
PASID that is being decommissioned. In section 4.1.2, the specifications
details the two device-specific ways of stopping use of a PASID, with or
without a Stop Marker. When done with a Stop Marker, the function doesn't
have to wait for any outstanding PPR to return, the Stop Marker serves as
a PASID barrier.

Thanks,
Jean-Philippe

> I know about a different marker, which allows a device to issue several
> PPR requests and only get one response for all of them. The last request
> then has that marker set.
> 
> But I am not aware (yet) of a marker with which the device says it no
> longer sends requests with this PASID.

>> My intent with passing flags to unbind() was to handle the case where VFIO
>> is unable to tell us whether PPRs are still being issued by the device.
>> But the issue seems moot to me now that I have a better understanding, as
>> there will be a detach_dev/attach_dev sequence before we start rebinding
>> PASIDs, and we can simply reset the PRI interface there (I'm currently
>> doing that in add_device, but I should move it.)
> 
> VFIO should completly reset the device before it is re-used, so I don't
> think we run into problems there.
> 
> 
> 
> 	Joerg
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
