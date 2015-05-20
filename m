Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp112.ord1c.emailsrvr.com ([108.166.43.112]:52841 "EHLO
	smtp112.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751876AbbETMRQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2015 08:17:16 -0400
Message-ID: <555C79E5.9040507@compro.net>
Date: Wed, 20 May 2015 08:11:17 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>, wdavis@nvidia.com
CC: joro@8bytes.org, iommu@lists.linux-foundation.org,
	linux-pci@vger.kernel.org, tripperda@nvidia.com,
	jhubbard@nvidia.com, jglisse@redhat.com, konrad.wilk@oracle.com,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2 4/7] DMA-API: Add dma_(un)map_resource() documentation
References: <1431973504-5903-1-git-send-email-wdavis@nvidia.com> <1431973504-5903-5-git-send-email-wdavis@nvidia.com> <20150519234300.GA31666@google.com>
In-Reply-To: <20150519234300.GA31666@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/19/2015 07:43 PM, Bjorn Helgaas wrote:
> [+cc Dave, Jonathan]
>
> On Mon, May 18, 2015 at 01:25:01PM -0500, wdavis@nvidia.com wrote:
>> From: Will Davis <wdavis@nvidia.com>
>>
>> Add references to both the general API documentation as well as the HOWTO.
>>
>> Signed-off-by: Will Davis <wdavis@nvidia.com>
>> ---
>>   Documentation/DMA-API-HOWTO.txt | 39 +++++++++++++++++++++++++++++++++++++--
>>   Documentation/DMA-API.txt       | 36 +++++++++++++++++++++++++++++++-----
>>   2 files changed, 68 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/DMA-API-HOWTO.txt b/Documentation/DMA-API-HOWTO.txt
>> index 0f7afb2..89bd730 100644
>> --- a/Documentation/DMA-API-HOWTO.txt
>> +++ b/Documentation/DMA-API-HOWTO.txt
>> @@ -138,6 +138,10 @@ What about block I/O and networking buffers?  The block I/O and
>>   networking subsystems make sure that the buffers they use are valid
>>   for you to DMA from/to.
>>
>> +In some systems, it may also be possible to DMA to and/or from a peer
>> +device's MMIO region, as described by a 'struct resource'. This is
>> +referred to as a peer-to-peer mapping.
>> +
>>   			DMA addressing limitations
>>
>>   Does your device have any DMA addressing limitations?  For example, is
>> @@ -648,6 +652,35 @@ Every dma_map_{single,sg}() call should have its dma_unmap_{single,sg}()
>>   counterpart, because the bus address space is a shared resource and
>>   you could render the machine unusable by consuming all bus addresses.
>>
>> +Peer-to-peer DMA mappings can be obtained using dma_map_resource() to map
>> +another device's MMIO region for the given device:
>> +
>> +	struct resource *peer_mmio_res = &other_dev->resource[0];
>> +	dma_addr_t dma_handle = dma_map_resource(dev, peer_mmio_res,
>> +						 offset, size, direction);
>> +	if (dma_handle == 0 || dma_mapping_error(dev, dma_handle))
>> +	{
>> +		/*
>> +		 * If dma_handle == 0, dma_map_resource() is not
>> +		 * implemented, and peer-to-peer transactions will not
>> +		 * work.
>> +		 */
>> +		goto map_error_handling;
>> +	}
>> +
>> +	...
>> +
>> +	dma_unmap_resource(dev, dma_handle, size, direction);
>> +
>> +Here, "offset" means byte offset within the given resource.
>> +
>> +You should both check for a 0 return value and call dma_mapping_error(),
>> +as dma_map_resource() can either be not implemented or fail and return
>> +error as outlined under the dma_map_single() discussion.
>> +
>> +You should call dma_unmap_resource() when DMA activity is finished, e.g.,
>> +from the interrupt which told you that the DMA transfer is done.
>> +
>>   If you need to use the same streaming DMA region multiple times and touch
>>   the data in between the DMA transfers, the buffer needs to be synced
>>   properly in order for the CPU and device to see the most up-to-date and
>> @@ -765,8 +798,8 @@ failure can be determined by:
>>
>>   - checking if dma_alloc_coherent() returns NULL or dma_map_sg returns 0
>>
>> -- checking the dma_addr_t returned from dma_map_single() and dma_map_page()
>> -  by using dma_mapping_error():
>> +- checking the dma_addr_t returned from dma_map_single(), dma_map_resource(),
>> +  and dma_map_page() by using dma_mapping_error():
>>
>>   	dma_addr_t dma_handle;
>>
>> @@ -780,6 +813,8 @@ failure can be determined by:
>>   		goto map_error_handling;
>>   	}
>>
>> +- checking if dma_map_resource() returns 0
>> +
>>   - unmap pages that are already mapped, when mapping error occurs in the middle
>>     of a multiple page mapping attempt. These example are applicable to
>>     dma_map_page() as well.
>> diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
>> index 5208840..c25c549 100644
>> --- a/Documentation/DMA-API.txt
>> +++ b/Documentation/DMA-API.txt
>> @@ -283,14 +283,40 @@ and <size> parameters are provided to do partial page mapping, it is
>>   recommended that you never use these unless you really know what the
>>   cache width is.
>>
>> +dma_addr_t
>> +dma_map_resource(struct device *dev, struct resource *res,
>> +		 unsigned long offset, size_t size,
>> +		 enum dma_data_direction_direction)
>> +
>> +API for mapping resources. This API allows a driver to map a peer
>> +device's resource for DMA. All the notes and warnings for the other
>> +APIs apply here. Also, the success of this API does not validate or
>> +guarantee that peer-to-peer transactions between the device and its
>> +peer will be functional. They only grant access so that if such
>> +transactions are possible, an IOMMU will not prevent them from
>> +succeeding.
>
> If the driver can't tell whether peer-to-peer accesses will actually work,
> this seems like sort of a dubious API.  I'm trying to imagine how a driver
> would handle this.  I guess whether peer-to-peer works depends on the
> underlying platform (not the devices themselves)?  If we run the driver on
> a platform where peer-to-peer *doesn't* work, what happens?  The driver
> can't tell, so we just rely on the user to say "this isn't working as
> expected"?
>

Most currently available hardware doesn't allow reads but will allow 
writes on PCIe peer-to-peer transfers. All current AMD chipsets are this 
way. I'm pretty sure all Intel chipsets are this way also. What happens 
with reads is they are just dropped with no indication of error other 
than the data will not be as expected. Supposedly the PCIe spec does not 
even require any peer-to-peer support. Regular PCI there is no problem 
and this API could be useful. However I doubt seriously you will find a 
pure PCI motherboard that has an IOMMU.

I don't understand the chipset manufactures reasoning for disabling PCIe 
peer-to-peer reads. We would like to make PCIe versions of our cards but 
their application requires  peer-to-peer reads and writes. So we cannot 
develop PCIe versions of the cards.

Again, Regular PCI there is no problem and this API could be useful. 
IOMMU or not.
If we had a pure PCI with IOMMU env, how will this API handle when the 2 
devices are on the same PCI bus. There will be NO IOMMU between the 
devices on the same bus. Does this API address that configuration?

Mark

>> +If this API is not provided by the underlying implementation, 0 is
>> +returned and the driver must take appropriate action. Otherwise, the
>> +DMA address is returned, and that DMA address should be checked by
>> +the driver (see dma_mapping_error() below).
>> +
>> +void
>> +dma_unmap_resource(struct device *dev, dma_addr_t dma_address, size_t size,
>> +		   enum dma_data_direction direction)
>> +
>> +Unmaps the resource previously mapped. All the parameters passed in
>> +must be identical to those passed in to (and returned by) the mapping
>> +API.
>> +
>>   int
>>   dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
>>
>> -In some circumstances dma_map_single() and dma_map_page() will fail to create
>> -a mapping. A driver can check for these errors by testing the returned
>> -DMA address with dma_mapping_error(). A non-zero return value means the mapping
>> -could not be created and the driver should take appropriate action (e.g.
>> -reduce current DMA mapping usage or delay and try again later).
>> +In some circumstances dma_map_single(), dma_map_page() and dma_map_resource()
>> +will fail to create a mapping. A driver can check for these errors by testing
>> +the returned DMA address with dma_mapping_error(). A non-zero return value
>> +means the mapping could not be created and the driver should take appropriate
>> +action (e.g. reduce current DMA mapping usage or delay and try again later).
>>
>>   	int
>>   	dma_map_sg(struct device *dev, struct scatterlist *sg,
>> --
>> 2.4.0
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

