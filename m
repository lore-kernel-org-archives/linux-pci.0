Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3]:60400 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902AbaDOLzE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Apr 2014 07:55:04 -0400
Received: from /spool/local
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <yan@linux.vnet.ibm.com>;
	Tue, 15 Apr 2014 17:25:01 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id 90AB73940049
	for <linux-pci@vger.kernel.org>; Tue, 15 Apr 2014 17:24:57 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s3FBsrVu11141570
	for <linux-pci@vger.kernel.org>; Tue, 15 Apr 2014 17:24:53 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s3FBssmL010165
	for <linux-pci@vger.kernel.org>; Tue, 15 Apr 2014 17:24:56 +0530
Date: Tue, 15 Apr 2014 19:54:50 +0800
From: Guo Chao <yan@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	Amir Vadai <amirv@mellanox.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Eugenia Emantayev <eugenia@mellanox.com>, talal@mellanox.com,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v7] PCI: Try best to allocate pref mmio 64bit above 4g
Message-ID: <20140415115450.GA7792@yanx>
References: <CAE9FiQXzRQ9S0mwwb58R2icBTtHHJ6NMVFMaxEgtVNP9mZVjZw@mail.gmail.com>
 <1394222924-28886-1-git-send-email-yinghai@kernel.org>
 <CAErSpo6r16va7oBpaDcTXw0Y0igc=NbXy9G7c27X+P0UM7fh8g@mail.gmail.com>
 <20140408025738.GA3198@yanx>
 <CAErSpo4JSrjSn4dXC9Pzfz2Aho+W4Gq9uKc+kAFbqTERcRAJ+w@mail.gmail.com>
 <20140409075215.GA3173@yanx>
 <CAErSpo4aGU_rmNSiv=HS-pDVsfKk798zLQW8Kx5huHe8jwdghw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo4aGU_rmNSiv=HS-pDVsfKk798zLQW8Kx5huHe8jwdghw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 10, 2014 at 11:26:14AM -0600, Bjorn Helgaas wrote:
> On Wed, Apr 9, 2014 at 1:52 AM, Guo Chao <yan@linux.vnet.ibm.com> wrote:
> > So 4G-above space can be properly used.
> >
> > Why does enabling 64-bit space matter?
> >
> > * 32-bit space is just too small. If larger-than-4G BAR sounds
> >   unrealistic (we do have such devices), there is still a chance that
> >   total MMIO size under a domain is too large, especially when SR-IOV
> >   enabled (we met this situation).
> 
> Please give more details about the problem you saw.  A complete dmesg
> log showing a boot failure or a device that doesn't work, and another
> log with this patch applied, showing things working as desired, would
> go a long ways toward clarifying this.
> 
> This sounds like a specific case that will be fixed by the patch, and
> if you give more details, maybe I can figure out what's going on.
> 

Let's see an example.

| pci 0003:05:00.0: reg 0x10: [mem 0x3d05801000000-0x3d058010fffff 64bit]
| pci 0003:05:00.0: reg 0x18: [mem 0x3d05010000000-0x3d05017ffffff 64bit pref]
| pci 0003:05:00.0: reg 0x30: [mem 0x00000000-0x000fffff pref]
| pci 0003:05:00.0: reg 0x134: [mem 0x3d05018000000-0x3d0501fffffff 64bit pref]

This is printed at enumeration phase. This device has a SRIOV BAR with
size of 0x7ffffff (128M). That's the size of a signle VF BAR. The device
supports 63 VFs so we need near 8G space in total. Apparanlty we need
exploit 64-bit space.

| PCI host bridge to bus 0003:00
| pci_bus 0003:00: root bus resource [mem 0x3d05800000000-0x3d0587ffeffff] (bus address [0x80000000-0xfffeffff])
| pci_bus 0003:00: root bus resource [mem 0x3d05008000000-0x3d057ffffffff 64bit pref]

And we do have a huge (32G) 64-bit prefetchable window supply. We expect
everything to work fine, but:

| pci 0003:00:00.0: BAR 15: can't assign mem pref (size 0x206000000)
| pci 0003:00:00.0: BAR 14: assigned [mem 0x3d05800000000-0x3d05802ffffff]
| pci 0003:00:00.0: BAR 13: can't assign io (size 0x4000)

It went wrong at the beginning. Note the error message never considers
64-bit or not, but BAR 15 here has it MEM_64 flag cleared. It first
tried to find a 32-bit prefetchable window, but we only supply a 64-bit one.
So it fall back to (32-bit) non-prefetchable window, but there is no enough
room there. At last it went into complicated steps (not show here) of
allocating requested resource first, then try best for the optional ones, etc..

Why is BAR 15 (prefetchable) 32 bit instead of 64? Because PCI core favours
32-bit prefetchable BARs and we have some. This is one of them:

| pci 0003:05:00.0: reg 0x30: [mem 0x00000000-0x000fffff pref]

PCI core decides to let them enjoy the benefition of prefetch. They can't
bear the risk of getting 4G-above address, so its parent, its parent's parent,
its parent's parent's parent, finally the root bridge (00:00.0) must have their
MEM_64 flag of prefetchable resource (BAR 15) clear. In the end nobody
is eligible to use the 64-bit (prefetchable) space even we have huge
supply !

Note even the resource is small and successfully fall back into 32-bit
non-prefetchable window, that's still not OK for us because we need
SRIOV resource be at 64-bit prefetchable space to do platform
configuration.

With Yinghai's patch, when 64-bit prefetchable BARs found, they're more
favoured than the 32-bit prefetchable ones (if any), so all upstream bridges'
prefetchable windows have their MEM_64 flag reserved and the huge 64-bit
prefetchable space will be exploited:

| pci 0003:00:00.0: BAR 15: assigned [mem 0x3d05008000000-0x3d0521fffffff 64bit pref]
| pci 0003:00:00.0: BAR 14: assigned [mem 0x3d05800000000-0x3d05802ffffff]
| pci 0003:00:00.0: BAR 13: can't assign io (size 0x4000)

(The IO resource error here is due to we do not provide IO window)

Thanks,
Guo Chao


> Bjorn
> 

