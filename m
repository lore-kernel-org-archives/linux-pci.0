Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ve0-f177.google.com ([209.85.128.177]:36433 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754721Ab3EXQAV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 May 2013 12:00:21 -0400
Received: by mail-ve0-f177.google.com with SMTP id ox1so3511330veb.22
        for <linux-pci@vger.kernel.org>; Fri, 24 May 2013 09:00:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQUS9rUfhH=J5pgynO6Xhrnn8Rx4pHeZ=p0dHm0fUoHd3A@mail.gmail.com>
References: <CAE9FiQX=h4H1gcbW=EfQo_ZtAgHGOZ2GxVxLG59C1iMH+qgH2g@mail.gmail.com>
 <1367732090.11982.38.camel@pasglop> <CAE9FiQUN3qqVmdw_EdOC-JZGc219M3tu=roOX98xns+77LJhMw@mail.gmail.com>
 <1367740336.11982.41.camel@pasglop> <51871088.4594420a.0ccc.7300SMTPIN_ADDED_BROKEN@mx.google.com>
 <CAE9FiQXGUOM_h_X5tdGbkiuZGZkiFigSLbbftx3YXybFBg6trg@mail.gmail.com>
 <518786a7.64bbec0a.58a0.1f6bSMTPIN_ADDED_BROKEN@mx.google.com>
 <CAErSpo5MJCoaof=heFM4vLxuWz8pFqsyXAC356jZ7rbRvSOt9g@mail.gmail.com>
 <CAE9FiQWsZXfkSSVFzee4-J4bUDP8DdG=y9-k2du+ek90StDvNA@mail.gmail.com>
 <CAE9FiQXw=Q9hDWMS3kx8=G0eSqo2keKh-VP3=LWZ31PfXmrAmg@mail.gmail.com>
 <519dcfbe.89e9420a.4934.488bSMTPIN_ADDED_BROKEN@mx.google.com>
 <CAE9FiQW==Zvwv976-xjtRFj70JWoZW94yQyM0NMTvMpR-yDG9Q@mail.gmail.com>
 <CAErSpo5ASyYvRJgA3TDt7A5xtxL0sqopfAxbnJwDL=z_2hDJag@mail.gmail.com>
 <CAE9FiQX8o97RY-Bd9t1vj+gm_Uri0v_hAUwecaNoF2GwGGTNyA@mail.gmail.com>
 <CAErSpo5vY-DY9_bLWbM5UNrSZdO5dyASx1hLGMQg-ypgZHXLLg@mail.gmail.com>
 <CAE9FiQWyEhdQGjC+hiGxOHdHwZoajfwfcgp26wivqL0s62NPkA@mail.gmail.com>
 <1369344196.3870.35.camel@pasglop> <CAE9FiQUS9rUfhH=J5pgynO6Xhrnn8Rx4pHeZ=p0dHm0fUoHd3A@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 24 May 2013 09:59:54 -0600
Message-ID: <CAErSpo40LBfJGHfGiveE-czMgbF=qqziySCPgPAAJT3BYBS__A@mail.gmail.com>
Subject: Re: Resource assignment oddities
To: Yinghai Lu <yinghai@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 23, 2013 at 4:16 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Thu, May 23, 2013 at 2:23 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
>> On Thu, 2013-05-23 at 14:00 -0700, Yinghai Lu wrote:
>>> Yes, that is what patch try to do. Keep the mmio allocation from first
>>> try, and only retry with io port.
>>
>> Can you describe more precisely what happens with the *current* code ?
>>
>> Ie. The first pass allocates my device MMIO regions fine. The second
>> pass them spew some error messages about some mem allocation. I can
>> still observe *something* being assigned to devices and in the (limited)
>> setup I've been able to test with, so far, the devices seemed to still
>> work, so I don't have a good grasp of the extent of the risk here.
>
> after bus_size_bridge, will have two list
> a. head that is for must-have resource
> b. realloc_head that is for optional size.
>
> then __assign_resources_sorted:
> in the first try,
> clone head list to saved list,  then update head list with optional size
> from realloc_head list. and try to assign resources, fail resources
> will be added to local_fail_head.
>
> retry:
> if local_fail_head is empty, mean must+optional are all allocated, so done.
>
> if local_fail_head is not empty, will restore head list from saved list.
> then try to assign resource, fail resources will be add to global resources.
> then try to extend (reassign) resources with optional size from realloc_size.
>
>>
>> Is there a chance that this failed "second pass" actually prevents
>> proper allocation of resources ?
>
> failed "second pass", should only fail to extend optional resources
> like resource
> for SRIOV, because fail to allocate resource compactly.
>
> in your case, "second pass" assign must-have, then extend optional way.
>
> pci 0001:00:00.0: BAR 8: assigned [mem 0x3d01080000000-0x3d01081ffffff]
> pci 0001:00:00.0: BAR 9: assigned [mem 0x3d01082000000-0x3d010837fffff pref]
> pci 0001:00:00.0: BAR 7: can't assign io (size 0x3000)  ==> cause first try fail
> pci 0001:00:00.0: BAR 8: assigned [mem 0x3d01080000000-0x3d010817fffff]
> pci 0001:00:00.0: BAR 9: assigned [mem 0x3d01081800000-0x3d010827fffff pref]
> ===> go extend now
> pci 0001:00:00.0: BAR 8: reassigned [mem 0x3d01082800000-0x3d010847fffff]
> pci 0001:00:00.0: BAR 9: reassigned [mem 0x3d01080000000-0x3d010817fffff pref]
> ==> luckly it will extend ok, but it will stay in the MIDDLE.
>
> then come the poor 0001:01:00.0
>
> pci 0001:01:00.0: BAR 8: assigned [mem 0x3d01082800000-0x3d01083ffffff]
> pci 0001:01:00.0: BAR 9: assigned [mem 0x3d01080000000-0x3d010817fffff pref]
> pci 0001:01:00.0: BAR 0: assigned [mem 0x3d01084000000-0x3d0108403ffff]
> pci 0001:01:00.0: BAR 7: can't assign io (size 0x3000) ===> cause first try fail
> pci 0001:01:00.0: BAR 8: assigned [mem 0x3d01082800000-0x3d010837fffff]
> pci 0001:01:00.0: BAR 9: assigned [mem 0x3d01080000000-0x3d01080ffffff pref]
> pci 0001:01:00.0: BAR 0: assigned [mem 0x3d01083800000-0x3d0108383ffff]
> ===> go extend optional now
> pci 0001:01:00.0: BAR 8: can't assign mem (size 0x1000000)
> pci 0001:01:00.0: failed to add 800000 res[8]=[mem
> 0x3d01082800000-0x3d010837fffff]
> pci 0001:01:00.0: BAR 9: reassigned [mem 0x3d01080000000-0x3d010817fffff pref]
> pci 0001:01:00.0: BAR 7: can't assign io (size 0x3000)
> ===> so BAR8 can not extend now...because other lay on the middle...
>
>
> So we need to patch that will prevent us to fall into "allocate must
> and extend it"
> trap as it will not allocate resource efficiently.
>
> otherwise in your case, devices pci0001:01:00.0 will have problem to use SRIOV.

Whew.  I think I finally see what you're getting at.  From the log in
Ben's very first email, it looks like we initially assign two 24MB MEM
windows to the 0001:01:00.0 bridge:

  pci 0001:01:00.0: BAR 8: assigned [mem 0x3d01081800000-0x3d01082ffffff]
  pci 0001:01:00.0: BAR 9: assigned [mem 0x3d01080000000-0x3d010817fffff pref]

After the reassignment brouhaha, the prefetchable window is unchanged,
but the non-prefetchable window has been reduced in size to 8MB:

  pci 0001:01:00.0: PCI bridge to [bus 02-0d]
  pci 0001:01:00.0:   bridge window [mem 0x3d01081800000-0x3d01081ffffff]
  pci 0001:01:00.0:   bridge window [mem 0x3d01080000000-0x3d010817fffff pref]

That should not happen, because the only reason we're reassigning is
for IO space, and we shouldn't be touching the MEM assignments.  I
agree that we should fix that.

I do not agree that your current patches are the right way to fix
this.  You are trying to make a relatively small patch that we can
wedge into v3.10 in a hurry.  I would prefer that we work out a
cleaner solution that simplifies reassignment, *then* figure out the
best way to backport it as needed.

Bjorn
