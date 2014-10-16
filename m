Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:45859 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbaJPImE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Oct 2014 04:42:04 -0400
Received: from /spool/local
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Thu, 16 Oct 2014 18:42:02 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 37AB22BB0047
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2014 19:41:59 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id s9G8fulg31785180
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2014 19:41:56 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s9G8fwwk009728
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2014 19:41:59 +1100
Date: Thu, 16 Oct 2014 16:41:56 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH V7 00/17] Enable SRIOV on POWER8
Message-ID: <20141016084156.GA5216@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1406182947-11302-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20140819211942.GA6295@google.com>
 <20140820023404.GC6904@richard>
 <CAErSpo5Dm4Eu0TcvJn2fYLVd005OgJCy-yZAhqsttjbb8jwm=A@mail.gmail.com>
 <20140820033546.GA7669@richard>
 <20141002155943.GA19392@google.com>
 <20141015090014.GA13499@richard>
 <CAErSpo4g1gtizAsVpxXGWRMDDaNLkjajqdj3xUdckiTf6f3g4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo4g1gtizAsVpxXGWRMDDaNLkjajqdj3xUdckiTf6f3g4Q@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 15, 2014 at 07:52:16AM -0600, Bjorn Helgaas wrote:
>On Wed, Oct 15, 2014 at 3:00 AM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
>> On Thu, Oct 02, 2014 at 09:59:43AM -0600, Bjorn Helgaas wrote:
>...
>>>I haven't seen any more on this series, and I'm assuming you'll post a
>>>rebased series (maybe you're waiting for v3.18-rc1?).  I'm just checking to
>>>make sure you're not waiting for something from me...
>>>
>>
>> Hi, Bjorn
>>
>> Haven't seen you for a long time :-) I am just back from vocation and the mail
>> box doesn't work well for previous two days.
>>
>> Yep, I am rebasing the code on top of v3.17, is this fine for you?
>
>When I apply your patches, they will be on a branch based on
>v3.18-rc1, so the easiest thing for me would be if you generate them
>from that base.  Here's why:
>
>  - Linus released v3.17 on Oct 5, 2014
>  - Merge window for v3.18 opened when v3.17 released
>  - All changes intended for v3.18 will be merged during window
>(theoretically, at least)
>  - Merge window closes when Linus releases v3.18-rc1 (probably Oct 19 or 26)
>
>Your changes will miss the v3.18 merge window, so the next chance to
>merge them will be during the v3.19 merge window that opens when v3.18
>releases.  v3.18-rc1 is a close approximation of what v3.18 will
>eventually be, so rebasing to v3.18-rc1 will minimize merge conflicts
>when we eventually merge your changes on top of v3.18.
>
>v3.18-rc1 isn't out yet, but if you rebase to the current head of
>Linus' tree, that should be fairly close.  The PCI changes are already
>in (80213c03c415), and at least some of the powerpc changes are in
>(fd9879b9bb32).
>

Thanks for your explanation. I will do some rebase and test on v3.17. Then
rebase it on v3.18-rc1 when it is released.

And finally give you the one on v3.18-rc1.

>Bjorn

-- 
Richard Yang
Help you, Help me

