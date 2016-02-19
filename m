Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38429 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946757AbcBSOSM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 19 Feb 2016 09:18:12 -0500
Subject: Re: [PATCH] Create sysfs entries for PCI VPDI and VPDR tags
To: Jordan Hargrave <jharg93@gmail.com>
References: <1455825895-10951-1-git-send-email-Jordan_Hargrave@dell.com>
 <56C6E7D1.4@suse.de>
 <CAC1AzddUqEScGgUqPxa8CgLSH3gynVcj71vMNn6b-Roi2YTRUQ@mail.gmail.com>
Cc: Jordan Hargrave <Jordan_Hargrave@dell.com>,
	Bjorn Helgaas <bhelgaas@google.com>, alexander.duyck@gmail.com,
	linux-pci@vger.kernel.org, babu.moger@oracle.com,
	LKML <linux-kernel@vger.kernel.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <56C72420.4070601@suse.de>
Date: Fri, 19 Feb 2016 15:18:08 +0100
MIME-Version: 1.0
In-Reply-To: <CAC1AzddUqEScGgUqPxa8CgLSH3gynVcj71vMNn6b-Roi2YTRUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/19/2016 03:07 PM, Jordan Hargrave wrote:
> On Fri, Feb 19, 2016 at 4:00 AM, Hannes Reinecke <hare@suse.de> wrote:
>>
>> On 02/18/2016 09:04 PM, Jordan Hargrave wrote:
>>> The VPD-R is a readonly area of the PCI Vital Product Data region.
>>> There are some standard keywords for serial number, manufacturer,
>>> and vendor-specific values.  Dell Servers use a vendor-specific
>>> tag to store number of ports and port mapping of partitioned NICs.
>>>
>>> info = VPD-Info string
>>> PN = Part Number
>>> SN = Serial Number
>>> MN = Manufacturer ID
>>> Vx = Vendor-specific (x=0..9 A..Z)
>>>
>>> This creates a sysfs subdirectory in the pci device: vpdattr with
>>> 'info', 'EC', 'SN', 'V0', etc. files containing the tag values.
>>>
>>> Signed-off-by: Jordan Hargrave <Jordan_Hargrave@dell.com>
>> Hmm. Can we first get an agreement on the PCI VPD parsing patches
>> I've posted earlier?
>> VPD parsing is really tricky, and we should aim on making the
>> read_vpd function robust enough before we begin putting things into
>> sysfs.
>>
>> Also, I'm not utterly keen on this patchset.
>> The sysfs space is blown up with tiny pieces of information, which
>> can easily gotten via lspci, too.
>>
>> Also, to my knowledge it's perfectly valid to _write_ to the VPD, in
>> which case the entire sysfs attribute setup would be invalided.
>> How do you propose to handle that?
>>
> 
> This patch only reads the attributes from VPD-I and VPD-R areas, not
> the VPD-W (read write) area.
> The VPD-W data is located after the VPD-I and VPD-R area  So nothing
> in these attributes should change.
> 
Ah. Ok.

> The main reason I want this is for replacing biosdevname (ethernet
> naming) functionality and getting the same functionality into the
> kernel and systemd.  Systemd doesn't want to do vpd parsing, and
> reading the vpd can take a very long time on some devices, causing
> systemd to timeout.  Another disadvantage of it being in userspace
> is for devices using SR-IOV.  In those devices the vpd only
> exists for the physfn devices but not the virtual devices.  A
> userspace program device will have to read the entire VPD for
> each physical and virtual PCI device.
> 
> Logic is something like this:
> if (open("/sys/bus/pci/devices/X/physfn/vpd", O_RDONLY) < 0)
>    if (open("/sys/bus/pci/devices/X/vpd", O_RDONLY) < 0)
>      return;
> }
> parsevpd(fd);
> 
> Specifically it is parsing one of the Vx attributes for a 'DCM' or
> 'DC2' string that contain a mapping from
> NIC ports and partitions to PCI device
> 
Well, unfortunately you just gave a very good reason to _not_
include this into the kernel:

> reading the vpd can take a very long time on some devices, causing

If we were to put your patch in, we would need to read the VPD
_during each boot_, thereby slowing down the booting process noticeably.
Plus the additional risk of locking up during boot for misbehaving
PCI devices. Probably not something we should be doing.

I would rather have it delegated to some helper function/program
invoked from udev; with my latest patchset we always will have
well-behaved VPD information so it's easy to just read the vpd
attribute from sysfs.
There still might be a lag, but surely not so long as if to timeout
udev. And if we still encounter these devices I would mark them as
broken via the blacklist and skip VPD reading for those.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
