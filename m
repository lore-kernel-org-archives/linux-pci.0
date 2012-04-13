Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:39207 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753960Ab2DML7S (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 Apr 2012 07:59:18 -0400
Message-ID: <4F8814F7.20808@snewbury.org.uk>
Date: Fri, 13 Apr 2012 12:58:47 +0100
From: Steven Newbury <steve@snewbury.org.uk>
MIME-Version: 1.0
To: Steven Newbury <steve@snewbury.org.uk>
CC: Yinghai Lu <yinghai@kernel.org>,
	"Barnes, Jesse" <jesse.barnes@intel.com>,
	Dave Airlie <airlied@linux.ie>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	DRI mailing list <dri-devel@lists.freedesktop.org>
Subject: Re: PCI resources above 4GB
References: <1333968563.5678.19.camel@infinity>  <4F84110E.3000400@snewbury.org.uk>  <CAE9FiQVHf_pcXUspOtLXx4XminmzdWja3Ra2Wh5jQRbfNOQ1eQ@mail.gmail.com>  <4F8467AA.90305@snewbury.org.uk>  <CAE9FiQWaop0NE7ZJu6jVW3SnxLkOJ9hRKh4xMNk64XjCAMRMMw@mail.gmail.com>  <4F848357.3060007@snewbury.org.uk>  <CAE9FiQXTgh3X4x+xD1T0ipsEbhbPtctYucfGeuWK=cq7kHeZ1Q@mail.gmail.com>  <4F848E10.1090703@snewbury.org.uk>  <CAE9FiQXvwYrJhLi91VDVtD4+OOfbGQ1U20-Cap+8tBZUt7QCkA@mail.gmail.com>  <1334089568.4083.2.camel@Nokia-N900>  <CAE9FiQWnvB2VbBQQaEnDE0nf+Zwy6nyoGrEuVrUesQEzgYfbvA@mail.gmail.com>  <4F84A3EC.6030903@snewbury.org.uk>  <CAE9FiQU+EEtBWrc66Sw4GFQjSy9Vh9fyFvhgQUheev_aVpAzrw@mail.gmail.com>  <1334229754.30606.7.camel@Nokia-N900>  <CAE9FiQXhzAOErMeQxz6U-BSYAK1LirHMpiFH90iRoXxwduPhPw@mail.gmail.com>  <1334248841.2910.6.camel@Nokia-N900>   <CAE9FiQXvHjW3pL4Nrb-3Oqw5Ht-7MqCL7_isL+Gm41qWOd1yRQ@mail.gmail.com> <1334317529.2910.21.camel@Nokia-N900>
In-Reply-To: <1334317529.2910.21.camel@Nokia-N900>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 13/04/12 12:45, Steven Newbury wrote:
> On Fri, 13 Apr 2012, 09:26:55 BST, Yinghai Lu <yinghai@kernel.org>
> wrote:
> 
>> On Thu, Apr 12, 2012 at 9:40 AM, Steven Newbury
>> <steve@snewbury.org.uk> wrote:
>>>>> 
>>>>> It would be useful to preserve as much low PCI memory
>>>>> address space as possible for hotplug devices (like my
>>>>> Radeon), but the other problem is small regions get
>>>>> allocated at the bottom, resulting in the inability to find
>>>>> large aligned regions later on. I see code to default to
>>>>> top-down allocation was reverted, I guess I'm going to have
>>>>> to dig into the archive to find out why...
>> 
>> Please check attached patches that will find_resource with fit.
>> It may leave space for your hotplug devices.
>> 
>> PCI: Should add children device res to fail list PCI: Try to
>> allocate mem64 above 4G at first intel-gtt: Read 64bit for
>> gmar_bus_addr PCI: Make sure assign same align with large size
>> resource at first resource: make find_resource could return just
>> fit resource PCI: Don't allocate small resource in big empty
>> space. resource: only return range with needed align
>> 
>> You can get them from
>> 
>> 
>> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
>>
>> 
for-pci-res-alloc
> 
> I pulled this in on top of a branch with any of the prior PCI
> patches since they conflict anyway.
> 
> It's not stable, crashes soon after GMA comes up. (Could be
> unrelated breakage in linus/master? Probably not but I will
> verify.)  I noticed the high allocations are occuring from the top
> of 64-bit address-space, whilst /proc/cpuinfo shows only 48 bits of
> virtual addressing.  Could that be why..?
To reply to myself again, I should have said crashes shortly after
Xorg initialises using the intel driver, in both cases!  I'm building
a kernel now without the patch set to see if it's unrelated.  If it
still dies I'll try applying your patch set to a branch without the
changes from linus/master... (should have done that anyway...)

> 
> Also, when not docked GMA still isn't mapped high so there's no
> room for the 256M radeon pref mem.
> 
> Attached /proc/iomem output for docked and undocked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+IFPcACgkQGcb56gMuC61f9ACfQc9AqY5YVMEDAvdufMkSpg9b
cbsAnRm6sA7VGfmzTyOldSJfV6Qt6ea8
=RGn5
-----END PGP SIGNATURE-----
