Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:63039 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756193Ab3GYSZj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 25 Jul 2013 14:25:39 -0400
Message-ID: <51F16D80.5040208@redhat.com>
Date: Thu, 25 Jul 2013 14:25:04 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org, joro@8bytes.org,
	iommu@lists.linux-foundation.org, acooks@gmail.com,
	dwmw2@infradead.org
Subject: Re: [RFC PATCH v2 1/2] pci: Create PCIe requester ID interface
References: <20130711204439.1701.90503.stgit@bling.home> <20130711210326.1701.56478.stgit@bling.home> <20130723223533.GB19765@google.com> <51F03C1B.2070002@redhat.com> <20130725171958.GB9272@google.com>
In-Reply-To: <20130725171958.GB9272@google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/25/2013 01:19 PM, Bjorn Helgaas wrote:
> On Wed, Jul 24, 2013 at 04:42:03PM -0400, Don Dutile wrote:
>> On 07/23/2013 06:35 PM, Bjorn Helgaas wrote:
>>> On Thu, Jul 11, 2013 at 03:03:27PM -0600, Alex Williamson wrote:
>>>> This provides interfaces for drivers to discover the visible PCIe
>>>> requester ID for a device, for things like IOMMU setup, and iterate
>>>
>>> IDs (plural)
>>>
>> a single device does not have multiple requester id's;
>> can have multiple tag-id's (that are ignored in this situation, but
>> can be used by switches for ordering purposes), but there's only 1/fcn
>> (except for those quirker pdevs!).
>
> Generally a device does not have multiple requester IDs, but the
> IOMMU may see one of several requester IDs for DMAs from a given
> device because bridges may take ownership of those transactions (sec
> 3.6.1.1 of the VT-d spec).
>
> Just to be clear, I envision this whole interface as being
> specifically for use by IOMMU drivers, so I'm only trying to provide
> what's necessary to build IOMMU mappings.
>
This is all just PCIe-PCI bridge spec; the code Alex is proposing handles this case.

>>>> + * pci_get_visible_pcie_requester - Get requester and requester ID for
>>>> + *                                  @requestee below @bridge
>>>> + * @requestee: requester device
>>>> + * @bridge: upstream bridge (or NULL for root bus)
>>>> + * @requester_id: location to store requester ID or NULL
>>>> + */
>>>> +struct pci_dev *pci_get_visible_pcie_requester(struct pci_dev *requestee,
>>>> +					       struct pci_dev *bridge,
>>>> +					       u16 *requester_id)
>>>
>>> I'm not sure it makes sense to return a struct pci_dev here because
>>> there's no requirement that a requester ID correspond to an actual
>>> pci_dev.
>>>
>> well, I would expect the only callers would be for subsys (iommu's)
>> searching to find requester-id for a pdev, b/c if a pdev doesn't exist,
>> then the device (and requester-id) doesn't exist... :-/
>
>>>> + * pcie_for_each_requester - Call callback @fn on each devices and DMA source
>>>> + *                           from @requestee to the PCIe requester ID visible
>>>> + *                           to @bridge.
>>>
>>> Transactions from a device may appear with one of several requester IDs,
>>> but there's not necessarily an actual pci_dev for each ID, so I think the
>> ditto above; have to have a pdev for each id....
>
> This *might* be true, but I don't think we should rely on it.  For
> example:
>
>    00:1c.0 PCIe to PCI bridge to [bus 01]
>    01:01.0 PCI endpoint
>
> The bridge will take ownership of DMA transactions from the 01:01.0
> endpoint.  An IOMMU on bus 00 will see a bridge-assigned requester
> ID of 01:00.0 (subordinate bus number, devfn zero), but there is no
> 01:00.0 device.
>
Clarification:
I meant that each requester-id must have at least 1 PCI device associated
with it.  when PCIe-PCI(X) bridges are in the path, then iommu-groups
lumps multiple requester-ids into a single group, and all devices behind
the bridges are lumped into that group.
The only time its possible for the requester-id for a device behind a
PCIe-PCI(X) Bridge to not be <secondary-bus>:0.0 is when the device is PCI-X.
I can't find anything in the spec that such a PPB can tell the sw what
requester-id alg it's using (pass PCI-X device's requester-id, or use <sbus>:0.0).
The (vtd) spec does say that all device behind a bridge (PCI-X or PCI) must
be in the same domain, which means same iommu group.
So, comments in the code or reviewers implied a requester-id could exist
w/o a pdev; IMO, the (iommu?) code ought to track/tag req-id -> pdev and vice-versa.

> Maybe the rules of conventional PCI require a device zero (I don't
> remember), but even if they do, it's ugly to rely on that here
> because I don't think device 01:00.0 is relevant to mappings for
> device 01:01.0.
>
no requirement for any device-number on a PCI bus.

> Obviously we also have to be aware that 01:00.0 and 01:01.0 can't be
> isolated from each other, but I think that issue is separate from
> the question of what requester IDs have to be mapped to make 01:01.0
> work.
>
yup.
> Bjorn

