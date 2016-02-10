Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34283 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988AbcBJHYX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 10 Feb 2016 02:24:23 -0500
Subject: Re: [PATCHv2 3/4] pci: Determine actual VPD size on first access
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1452684335-46107-1-git-send-email-hare@suse.de>
 <1452684335-46107-4-git-send-email-hare@suse.de>
 <20160209210458.GB32530@localhost>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Babu Moger <babu.moger@oracle.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <56BAE5A5.1090204@suse.de>
Date: Wed, 10 Feb 2016 08:24:21 +0100
MIME-Version: 1.0
In-Reply-To: <20160209210458.GB32530@localhost>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/09/2016 10:04 PM, Bjorn Helgaas wrote:
> On Wed, Jan 13, 2016 at 12:25:34PM +0100, Hannes Reinecke wrote:
>> PCI-2.2 VPD entries have a maximum size of 32k, but might actually
>> be smaller than that. To figure out the actual size one has to read
>> the VPD area until the 'end marker' is reached.
>> Trying to read VPD data beyond that marker results in 'interesting'
>> effects, from simple read errors to crashing the card. And to make
>> matters worse not every PCI card implements this properly, leaving
>> us with no 'end' marker or even completely invalid data.
>> This path tries to determine the size of the VPD data.
>> If no valid data can be read an I/O error will be returned when
>> reading the sysfs attribute.
>>
>> Cc: Alexander Duyck <alexander.duyck@gmail.com>
>> Cc: Bjorn Helgaas <helgaas@kernel.org>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>  drivers/pci/access.c    | 76 ++++++++++++++++++++++++++++++++++++++++++++++++-
>>  drivers/pci/pci-sysfs.c |  2 +-
>>  2 files changed, 76 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
>> index 59ac36f..914e023 100644
>> --- a/drivers/pci/access.c
>> +++ b/drivers/pci/access.c
>> @@ -284,9 +284,65 @@ struct pci_vpd_pci22 {
>>  	struct mutex lock;
>>  	u16	flag;
>>  	bool	busy;
>> +	bool	valid;
> 
> You're just following the precedent here, but I think using "bool" in
> structures like this is pointless: it takes more space than a :1 field
> and doesn't really add any safety.
> 
Okay, will be moving to a bitfield here.

>>  	u8	cap;
>>  };
>>  
>> +/**
>> + * pci_vpd_size - determine actual size of Vital Product Data
>> + * @dev:	pci device struct
>> + * @old_size:	current assumed size, also maximum allowed size
>> + *
> 
> Superfluous empty line.
> 
Ok.

>> + */
>> +static size_t
>> +pci_vpd_pci22_size(struct pci_dev *dev)
> 
> Please follow indentation style of the file (all on one line).
> 
Ok.

>> +{
>> +	size_t off = 0;
>> +	unsigned char header[1+2];	/* 1 byte tag, 2 bytes length */
>> +
>> +	while (off < PCI_VPD_PCI22_SIZE &&
>> +	       pci_read_vpd(dev, off, 1, header) == 1) {
>> +		unsigned char tag;
>> +
>> +		if (header[0] & PCI_VPD_LRDT) {
>> +			/* Large Resource Data Type Tag */
>> +			tag = pci_vpd_lrdt_tag(header);
>> +			/* Only read length from known tag items */
>> +			if ((tag == PCI_VPD_LTIN_ID_STRING) ||
>> +			    (tag == PCI_VPD_LTIN_RO_DATA) ||
>> +			    (tag == PCI_VPD_LTIN_RW_DATA)) {
>> +				if (pci_read_vpd(dev, off+1, 2,
>> +						 &header[1]) != 2) {
>> +					dev_dbg(&dev->dev,
>> +						"invalid large vpd tag %02x "
>> +						"size at offset %zu",
>> +						tag, off + 1);
> 
> The effect of this is that we set vpd->base.len to 0, which will cause
> all VPD accesses to fail, right?  If so, I'd make this at least a
> dev_info(), maybe even a dev_warn().  The dev_dbg() may not appear in
> dmesg at all, depending on config options.
> 
Wrong. Setting the length to '0' will just make the sysfs attribute
appear with a length of '0', as we cannot determine the length when
we create the attribute.

> Capitalize "VPD" and concatenate all the strings, even if it exceeds
> 80 columns.
> 
Okay.

>> +					break;
> 
> I think this leads to "return 0" below; I'd just return directly here
> so the reader doesn't have to figure out what we're breaking from.
> 
Okay, can do.

>> +				}
>> +				off += PCI_VPD_LRDT_TAG_SIZE +
>> +					pci_vpd_lrdt_size(header);
>> +			}
>> +		} else {
>> +			/* Short Resource Data Type Tag */
>> +			off += PCI_VPD_SRDT_TAG_SIZE +
>> +				pci_vpd_srdt_size(header);
>> +			tag = pci_vpd_srdt_tag(header);
>> +		}
>> +		if (tag == PCI_VPD_STIN_END)	/* End tag descriptor */
>> +			return off;
>> +		if ((tag != PCI_VPD_LTIN_ID_STRING) &&
>> +		    (tag != PCI_VPD_LTIN_RO_DATA) &&
>> +		    (tag != PCI_VPD_LTIN_RW_DATA)) {
>> +			dev_dbg(&dev->dev,
>> +				"invalid %s vpd tag %02x at offset %zu",
>> +				(header[0] & PCI_VPD_LRDT) ? "large" : "short",
>> +				tag, off);
>> +			break;
> 
> Same dev_dbg() and break comment here.
> 
>> +		}
>> +	}
>> +	return 0;
>> +}
>> +
>>  /*
>>   * Wait for last operation to complete.
>>   * This code has to spin since there is no other notification from the PCI
>> @@ -337,9 +393,23 @@ static ssize_t pci_vpd_pci22_read(struct pci_dev *dev, loff_t pos, size_t count,
>>  	loff_t end = pos + count;
>>  	u8 *buf = arg;
>>  
>> -	if (pos < 0 || pos > vpd->base.len || end > vpd->base.len)
>> +	if (pos < 0)
>>  		return -EINVAL;
>>  
>> +	if (!vpd->valid) {
>> +		vpd->valid = true;
>> +		vpd->base.len = pci_vpd_pci22_size(dev);
>> +	}
>> +	if (vpd->base.len == 0)
>> +		return -EIO;
>> +
>> +	if (end > vpd->base.len) {
>> +		if (pos > vpd->base.len)
>> +			return 0;
>> +		end = vpd->base.len;
>> +		count = end - pos;
>> +	}
>> +
>>  	if (mutex_lock_killable(&vpd->lock))
>>  		return -EINTR;
>>  
>> @@ -389,6 +459,9 @@ static ssize_t pci_vpd_pci22_write(struct pci_dev *dev, loff_t pos, size_t count
>>  	loff_t end = pos + count;
>>  	int ret = 0;
>>  
>> +	if (!vpd->valid)
>> +		return -EAGAIN;
> 
> Does this mean we now have to do a VPD read before a VPD write?  That
> sounds like a new requirement that is non-obvious.
> 
Hmm. I thought no-one would be daft enough to write a VPD attribute
without first checking whether it actually _needs_ to be written to.
But yeah, you're right. I'll be adding a call to
pci_vpd_pci22_size() here.

>> +
>>  	if (pos < 0 || (pos & 3) || (count & 3) || end > vpd->base.len)
>>  		return -EINVAL;
>>  
>> @@ -496,6 +569,7 @@ int pci_vpd_pci22_init(struct pci_dev *dev)
>>  	mutex_init(&vpd->lock);
>>  	vpd->cap = cap;
>>  	vpd->busy = false;
>> +	vpd->valid = false;
>>  	dev->vpd = &vpd->base;
>>  	return 0;
>>  }
>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>> index de327c3..31a1f35 100644
>> --- a/drivers/pci/pci-sysfs.c
>> +++ b/drivers/pci/pci-sysfs.c
>> @@ -1333,7 +1333,7 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
>>  			return -ENOMEM;
>>  
>>  		sysfs_bin_attr_init(attr);
>> -		attr->size = dev->vpd->len;
>> +		attr->size = 0;
> 
> I'm still puzzled about how we're using attr->size.  I don't really
> want that size to change at run-time, i.e., I don't want it to be zero
> immediately after boot, then change to something else after the first
> VPD read.  I don't think it's important that this reflect the size
> computed based on the VPD contents.  I think it would be fine if it
> were set to 32K all the time and possibly set to zero by quirks on
> devices where VPD is completely broken.
> 
The general idea is to always set the attribute size to '0' (ie the
size reflected to userland via the sysfs attribute).
The _actual_ size of the VPD data is generated by a call to
pci_vpd_pci22_size(), and stored in the vpd structure itself.

With that we won't need to change the sysfs attribute size (which we
cannot do anyway), and don't need any quirks like modifying the
return data for invalid VPD data.

But yeah, the sysfs zero-length binfile handling is non-obvious. It
took me several days and a confused mail exchange with Alexander
Duyck to figure it out.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
