Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from AUSXIPPC110.us.dell.com ([143.166.85.200]:9857 "EHLO
	ausxippc110.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992508AbcBSToc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Feb 2016 14:44:32 -0500
From: <Jordan_Hargrave@Dell.com>
To: <hare@suse.de>, <jharg93@gmail.com>
CC: <bhelgaas@google.com>, <alexander.duyck@gmail.com>,
	<linux-pci@vger.kernel.org>, <babu.moger@oracle.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Create sysfs entries for PCI VPDI and VPDR tags
Date: Fri, 19 Feb 2016 19:44:21 +0000
Message-ID: <1455910852096.10012@Dell.com>
References: <1455825895-10951-1-git-send-email-Jordan_Hargrave@dell.com>
 <56C6E7D1.4@suse.de>
 <CAC1AzddUqEScGgUqPxa8CgLSH3gynVcj71vMNn6b-Roi2YTRUQ@mail.gmail.com>,<56C72420.4070601@suse.de>
In-Reply-To: <56C72420.4070601@suse.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>On 02/19/2016 03:07 PM, Jordan Hargrave wrote:
>> On Fri, Feb 19, 2016 at 4:00 AM, Hannes Reinecke <hare@suse.de> wrote:
>>>
>>> On 02/18/2016 09:04 PM, Jordan Hargrave wrote:
>>>> The VPD-R is a readonly area of the PCI Vital Product Data region.
>>>> There are some standard keywords for serial number, manufacturer,
>>>> and vendor-specific values.  Dell Servers use a vendor-specific
>>>> tag to store number of ports and port mapping of partitioned NICs.
>>>>
>>>> info = VPD-Info string
>>>> PN = Part Number
>>>> SN = Serial Number
>>>> MN = Manufacturer ID
>>>> Vx = Vendor-specific (x=0..9 A..Z)
>>>>
>>>> This creates a sysfs subdirectory in the pci device: vpdattr with
>>>> 'info', 'EC', 'SN', 'V0', etc. files containing the tag values.
>>>>
>>>> Signed-off-by: Jordan Hargrave <Jordan_Hargrave@dell.com>
>>> Hmm. Can we first get an agreement on the PCI VPD parsing patches
>>> I've posted earlier?
>>> VPD parsing is really tricky, and we should aim on making the
>>> read_vpd function robust enough before we begin putting things into
>>> sysfs.
>>>
>>> Also, I'm not utterly keen on this patchset.
>>> The sysfs space is blown up with tiny pieces of information, which
>>> can easily gotten via lspci, too.
>>>
>>> Also, to my knowledge it's perfectly valid to _write_ to the VPD, in
>>> which case the entire sysfs attribute setup would be invalided.
>>> How do you propose to handle that?
>>>
>>
>> This patch only reads the attributes from VPD-I and VPD-R areas, not
>> the VPD-W (read write) area.
>> The VPD-W data is located after the VPD-I and VPD-R area  So nothing
>> in these attributes should change.
>>
>Ah. Ok.
>
>> The main reason I want this is for replacing biosdevname (ethernet
>> naming) functionality and getting the same functionality into the
>> kernel and systemd.  Systemd doesn't want to do vpd parsing, and
>> reading the vpd can take a very long time on some devices, causing
>> systemd to timeout.  Another disadvantage of it being in userspace
>> is for devices using SR-IOV.  In those devices the vpd only
>> exists for the physfn devices but not the virtual devices.  A
>> userspace program device will have to read the entire VPD for
>> each physical and virtual PCI device.
>>
>> Logic is something like this:
>> if (open("/sys/bus/pci/devices/X/physfn/vpd", O_RDONLY) < 0)
>>    if (open("/sys/bus/pci/devices/X/vpd", O_RDONLY) < 0)
>>      return;
>> }
>> parsevpd(fd);
>>
>> Specifically it is parsing one of the Vx attributes for a 'DCM' or
>> 'DC2' string that contain a mapping from
>> NIC ports and partitions to PCI device
>>
>Well, unfortunately you just gave a very good reason to _not_
>include this into the kernel:

The delay isn't a huge amount on any of the devices I've seen. The
Mellanox cards I have are the slowest.  Here's some timing tests I've done,
using this patch vs a readvpd utility.  I also compared it with lspci.

@@@ Read individual Broadcom
(time ./readvpd 0000:01:00.0 > /dev/null) &>>log
real	0m0.003s
user	0m0.002s
sys	0m0.002s

@@@ Read individual Mellanox
(time ./readvpd 0000:04:00.0 > /dev/null) &>>log
real	0m0.071s
user	0m0.001s
sys	0m0.070s

@@@ Read individual Broadcom using lspci
(time lspci -vvv -s 0000:01:00.0 > /dev/null) &>>log
real	0m0.036s
user	0m0.017s
sys	0m0.019s

@@@ Read individual Mellanox using lspci
(time lspci -vvv -s 0000:04:00.0 > /dev/null) &>>log
real	0m1.213s  <--- SLOW!!!!
user	0m0.012s
sys	0m1.201s

@@@ Read each network device with 'real' VPD.  This should be equivalent to the boot time delay, at least for network devices with VPD
(time for X in /sys/class/net/*/device ; do PF=$(readlink -f $X); SBDF=$(basename $PF) ; if [ -e $PF/vpdattr ] ; then echo ==== $X ; ./readvpd $SBDF > /dev/null; fi ; done) &>> log
==== /sys/class/net/eno1/device
==== /sys/class/net/eno2/device
==== /sys/class/net/eno3/device
==== /sys/class/net/eno4/device
==== /sys/class/net/eno5/device
==== /sys/class/net/eno6/device
==== /sys/class/net/enp4s0d1/device
==== /sys/class/net/enp4s0/device

real	0m0.319s
user	0m0.033s
sys	0m0.295s

@@@ Read each network device, including SR-IOV
(time for X in /sys/class/net/*/device ; do PF=$(readlink -f $X); if [ -e $PF/physfn ] ; then PF=$(readlink -f $PF/physfn) ; fi ; SBDF=$(basename $PF) ; if [ -e $PF/vpdattr ] ; then echo ==== $X ; ./readvpd $SBDF > /dev/null; fi ; done) &>> log
==== /sys/class/net/eno1/device
==== /sys/class/net/eno2/device
==== /sys/class/net/eno3/device
==== /sys/class/net/eno4/device
==== /sys/class/net/eno5/device
==== /sys/class/net/eno6/device
==== /sys/class/net/enp4s0d1/device
==== /sys/class/net/enp4s0/device
==== /sys/class/net/enp4s0f1d1/device (SR-IOV)
==== /sys/class/net/enp4s0f1/device (SR-IOV)
==== /sys/class/net/enp4s0f2d1/device (SR-IOV)
==== /sys/class/net/enp4s0f2/device (SR-IOV)
==== /sys/class/net/enp4s0f3d1/device (SR-IOV)
==== /sys/class/net/enp4s0f3/device (SR-IOV)
==== /sys/class/net/enp4s0f4d1/device (SR-IOV)
==== /sys/class/net/enp4s0f4/device (SR-IOV)
==== /sys/class/net/enp4s0f5d1/device (SR-IOV)
==== /sys/class/net/enp4s0f5/device (SR-IOV)
==== /sys/class/net/enp4s0f6d1/device (SR-IOV)
==== /sys/class/net/enp4s0f6/device (SR-IOV)
==== /sys/class/net/enp4s0f7d1/device (SR-IOV)
==== /sys/class/net/enp4s0f7/device (SR-IOV)
==== /sys/class/net/enp4s1d1/device (SR-IOV)
==== /sys/class/net/enp4s1/device (SR-IOV)

real	0m1.449s
user	0m0.047s
sys	0m1.412s

This is much slower as it has to re-read/parse the VPD data for each SR-IOV device

By contrast, here is using cached kernel entries (including virtual devices)
(time for X in /sys/class/net/*/device ; do PF=$(readlink -f $X); if [ -e $PF/physfn ] ; then PF=$(readlink -f $PF/physfn) ; fi ; if [ -e $PF/vpdattr ] ; then echo ==== $X ; cat $PF/vpdattr/* > /dev/null; fi ; done) &> log
==== /sys/class/net/eno1/device
==== /sys/class/net/eno2/device
==== /sys/class/net/eno3/device
==== /sys/class/net/eno4/device
==== /sys/class/net/eno5/device
==== /sys/class/net/eno6/device
==== /sys/class/net/enp4s0d1/device
==== /sys/class/net/enp4s0/device
==== /sys/class/net/enp4s0f1d1/device
==== /sys/class/net/enp4s0f1/device
==== /sys/class/net/enp4s0f2d1/device
==== /sys/class/net/enp4s0f2/device
==== /sys/class/net/enp4s0f3d1/device
==== /sys/class/net/enp4s0f3/device
==== /sys/class/net/enp4s0f4d1/device
==== /sys/class/net/enp4s0f4/device
==== /sys/class/net/enp4s0f5d1/device
==== /sys/class/net/enp4s0f5/device
==== /sys/class/net/enp4s0f6d1/device
==== /sys/class/net/enp4s0f6/device
==== /sys/class/net/enp4s0f7d1/device
==== /sys/class/net/enp4s0f7/device
==== /sys/class/net/enp4s1d1/device
==== /sys/class/net/enp4s1/device

real	0m0.212s
user	0m0.050s
sys	0m0.175s

>> reading the vpd can take a very long time on some devices, causing
>
>If we were to put your patch in, we would need to read the VPD
>_during each boot_, thereby slowing down the booting process noticeably.
>Plus the additional risk of locking up during boot for misbehaving
>PCI devices. Probably not something we should be doing.
>
>I would rather have it delegated to some helper function/program
>invoked from udev; with my latest patchset we always will have
>well-behaved VPD information so it's easy to just read the vpd
>attribute from sysfs.
>There still might be a lag, but surely not so long as if to timeout
>udev. And if we still encounter these devices I would mark them as
>broken via the blacklist and skip VPD reading for those.
>
>Cheers,
>
>Hannes
>--
>Dr. Hannes Reinecke                Teamlead Storage & Networking
>hare@suse.de                                   +49 911 74053 688
>SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
>GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
>HRB 21284 (AG Nürnberg)
>