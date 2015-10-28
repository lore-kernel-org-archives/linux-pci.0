Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35279 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbbJ1ScQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Oct 2015 14:32:16 -0400
Subject: Re: [PATCH 2/5] iov: Reset resources to 0 if totalVFs increases after
 enabling ARI
To: Bjorn Helgaas <helgaas@kernel.org>,
	Alexander Duyck <aduyck@mirantis.com>
References: <20151027204607.14626.59671.stgit@localhost.localdomain>
 <20151027205221.14626.8940.stgit@localhost.localdomain>
 <20151028163747.GA29223@localhost>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ben Shelton <benjamin.h.shelton@intel.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Message-ID: <563114AE.7050505@gmail.com>
Date: Wed, 28 Oct 2015 11:32:14 -0700
MIME-Version: 1.0
In-Reply-To: <20151028163747.GA29223@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/28/2015 09:37 AM, Bjorn Helgaas wrote:
> Hi Alex,
>
> On Tue, Oct 27, 2015 at 01:52:21PM -0700, Alexander Duyck wrote:
>> This patch forces us to reallocate VF BARs if the totalVFs value has
>> increased after enabling ARI.  This normally shouldn't occur, however I
>> have seen some non-spec devices that shift between 7 and some value greater
>> than 7 based on the ARI value and we want to avoid triggering any issues
>> with such devices.
>
> Can you include specifics about the devices?  The value "7" is pretty
> specific, so if we're going to include that level of detail, we should
> have the actual device info to go with it.

I referenced 7 as that is the largest number of VFs a single function 
can support assuming a single function without ARI and without the 
ability to handle Type 1 configuration requests.  The Intel fm10k driver 
has logic in it that does a check for ARI and if it is supported it 
reports via sysfs a totalVFs of 64, otherwise it limits the totalVFs 
reported to 7.  However, I don't believe it exposes the limitation via 
the configuration space.

> I guess the problem is:
>
>    - Device supports 7 TotalVFs with ARI disabled, >7 with ARI enabled
>    - Firmware leaves ARI disabled in SRIOV_CTRL
>    - Firmware computes size based on 7 VFs
>    - Firmware allocates space and programs BARs for 7 VFs
>    - Linux enables ARI, reads >7 TotalVFs
>    - Linux computes size based on >7 VFs
>    - Increased size may overlap other resources
>
> Right?

Right.  More than likely what will happen is that you will see overlap 
of the device on itself if it has multiple base address registers 
assigned to the VFs.

>> Fixes: 3aa71da412fe ("PCI: Enable SR-IOV ARI Capable Hierarchy before reading TotalVFs")
>> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
>> ---
>>   drivers/pci/iov.c |   11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>> index 099050d78a39..238950412de0 100644
>> --- a/drivers/pci/iov.c
>> +++ b/drivers/pci/iov.c
>> @@ -393,7 +393,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
>>   	int rc;
>>   	int nres;
>>   	u32 pgsz;
>> -	u16 ctrl, total;
>> +	u16 ctrl, total, orig_total;
>>   	struct pci_sriov *iov;
>>   	struct resource *res;
>>   	struct pci_dev *pdev;
>> @@ -402,6 +402,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
>>   	    pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT)
>>   		return -ENODEV;
>>
>> +	pci_read_config_word(dev, pos + PCI_SRIOV_TOTAL_VF, &orig_total);
>>   	pci_read_config_word(dev, pos + PCI_SRIOV_CTRL, &ctrl);
>>   	if (ctrl & PCI_SRIOV_CTRL_VFE) {
>>   		pci_write_config_word(dev, pos + PCI_SRIOV_CTRL, 0);
>> @@ -450,6 +451,14 @@ found:
>>   		}
>>   		iov->barsz[i] = resource_size(res);
>>   		res->end = res->start + resource_size(res) * total - 1;
>> +
>> +		/* force reallocation of BARs if total VFs increased */
>> +		if (orig_total < total) {
>> +			res->flags |= IORESOURCE_UNSET;
>> +			res->end -= res->start;
>> +			res->start = 0;
>> +		}
>
> Two thoughts here:
>
> 1) Even if the required space increased, it's possible that firmware
> placed the BAR somewhere where the extra space is available.  In that
> case, this forces reallocation unnecessarily.

I'd say it is possible, but not likely.  From past experience I have 
seen BIOSes do some very dumb things when it comes to SR-IOV, assuming 
they even support it.

In addition many of the VF devices out there support more than one base 
address register per function.  The Intel NICs for example have one for 
device registers and one for MSI-X registers.  And most BIOSes usually 
pack one right after the other from what I have seen.  So while there 
may be more space there what usually happens is that the MSI-X region 
will have to be relocated in order to make room for expanding the other 
base address register.

My last bit on all this is that VFs are meant to be assigned into 
guests.  I would argue that for the sake of security we are much better 
off invalidating the VF base address registers and forcing a 
reallocation if there is even a risk of the VF base address register 
space overlapping with some other piece of host memory.  We don't want 
to risk possibly exposing any bits of the host that we didn't intend on.

> 2) This *feels* like something the PCI core should be doing anyway,
> even without any help here.  Shouldn't we fail in pci_claim_resource()
> and set IORESOURCE_UNSET there?
>
> OK, and a third: re-reading TotalVF is (I think) completely
> unnecessary per spec, so if we're going to do it we should probably
> have a one-line comment about why the code is doing something that
> appears unnecessary, and really should have a concrete example device
> in the changelog.

I'm perfectly fine with us adding a comment about this being needed for 
out-of-spec devices on BIOSes that may not fully support SR-IOV. 
However, I wasn't the one that had the device that needed the workaround 
for totalVFs and so I cannot provide a concrete example myself.

I've added Ben to the Cc as he was the author for the original patch 
that introduced this possible issue.  Perhaps he can provide us with 
more details on the hardware that needs this.

- Alex
