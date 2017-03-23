Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [RFC PATCH 24/30] iommu: Specify PASID state when unbinding a task
To: Joerg Roedel <joro@8bytes.org>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-25-jean-philippe.brucker@arm.com>
 <20170322154429.GE7266@8bytes.org>
 <e2bb4c67-9b61-01cf-cc17-68088cdc5e5b@arm.com>
 <20170322225320.GF7266@8bytes.org>
 <a093bc07-a345-a689-9d97-f15a306f922d@arm.com>
 <20170323143014.GK7266@8bytes.org>
 <20170323145311.GA22972@e106794-lin.localdomain>
 <20170323165218.GL7266@8bytes.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <9d318e88-11af-6dab-b30e-d6b5c02443fe@arm.com>
Date: Thu, 23 Mar 2017 17:03:46 +0000
MIME-Version: 1.0
In-Reply-To: <20170323165218.GL7266@8bytes.org>
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

On 23/03/17 16:52, Joerg Roedel wrote:
> On Thu, Mar 23, 2017 at 03:52:14PM +0000, Jean-Philippe Brucker wrote:
>> On 23/03/17 14:30, Joerg Roedel wrote:
>>> Are you sure about the meaning of the stop-marker? Can you point me to
>>> where it is specified?
>>
>> The concept is introduced in the PCI ECN that adds PASIDs to the ATS
>> specification. I have the following link, which is probably behind a
>> wall:
>>
>> https://pcisig.com/sites/default/files/specification_documents/ECN-PASID-ATS-2011-03-31.pdf
>>
>> A Stop Marker is a PPR with flags Read=Write=0, Last=1, targeting the
>> PASID that is being decommissioned. In section 4.1.2, the specifications
>> details the two device-specific ways of stopping use of a PASID, with or
>> without a Stop Marker. When done with a Stop Marker, the function doesn't
>> have to wait for any outstanding PPR to return, the Stop Marker serves as
>> a PASID barrier.
> 
> Thanks for that, I have a closer look. Is that stopper packet visible to
> software (e.g. is an entry created in the queue)?

As far as I understand, it should be added to the queue like a normal PPR,
and software should check the R/W/L flags combination. For SMMU at least,
it is the same. The only difference is that when the PRI queue overflows,
the SMMU would discard a Stop Marker instead of sending an automated
response to the device (as it would do with others PPR that have the L
flag.) Software shouldn't send a response to a Stop Marker either.

Thanks,
Jean-Philippe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
