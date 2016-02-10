Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33892 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751120AbcBJHRE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 10 Feb 2016 02:17:04 -0500
Subject: Re: [PATCHv2 2/4] pci: allow access to VPD attributes with size '0'
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1452684335-46107-1-git-send-email-hare@suse.de>
 <1452684335-46107-3-git-send-email-hare@suse.de>
 <20160209205347.GA32530@localhost>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Babu Moger <babu.moger@oracle.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <56BAE3ED.2020905@suse.de>
Date: Wed, 10 Feb 2016 08:17:01 +0100
MIME-Version: 1.0
In-Reply-To: <20160209205347.GA32530@localhost>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/09/2016 09:53 PM, Bjorn Helgaas wrote:
> Hi Hannes,
> 
> On Wed, Jan 13, 2016 at 12:25:33PM +0100, Hannes Reinecke wrote:
>> It is not always possible to determine the actual size of the VPD
>> data, so allow access to them if the size is set to '0'.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>  drivers/pci/pci-sysfs.c | 20 ++++++++++++--------
>>  1 file changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>> index eead54c..de327c3 100644
>> --- a/drivers/pci/pci-sysfs.c
>> +++ b/drivers/pci/pci-sysfs.c
>> @@ -772,10 +772,12 @@ static ssize_t read_vpd_attr(struct file *filp, struct kobject *kobj,
>>  	struct pci_dev *dev =
>>  		to_pci_dev(container_of(kobj, struct device, kobj));
>>  
>> -	if (off > bin_attr->size)
>> -		count = 0;
>> -	else if (count > bin_attr->size - off)
>> -		count = bin_attr->size - off;
>> +	if (bin_attr->size > 0) {
>> +		if (off > bin_attr->size)
>> +			count = 0;
>> +		else if (count > bin_attr->size - off)
>> +			count = bin_attr->size - off;
>> +	}
> 
> I'm trying to figure out why we do any of this checking here.  It
> seems like we could do all of it in pci_read_vpd().
> 
> Where is bin_attr->size set?  I assume this is the "attr" allocated in
> pci_create_capabilities_sysfs().  I see that before your series, we
> set "attr->size = dev->vpd->len" there, but after patch 3/4 of your
> series, we set it to 0 there, and I don't see a place that sets it to
> anything else.
> 
That is entirely correct.
One of the joys of sysfs binary attributes.

In general, sysfs binary attributes are allowed to have a size of
'0', but still can provide data when read.
The size of '0' is just an indicator for "I don't know how much data
I can provide, figure out yourself".
(Cf fs/sysfs/file.c:sysfs_kf_bin_read() for details here)

In our case we're not using that function, but rather our own
pci_read_vpd(), which always exposes a size.

So this patch just takes the same reasoning from
sysfs_kf_bin_read(), and sets the size to '0', as initially we
simply do _not_ know how much data will be provided.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
