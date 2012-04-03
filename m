Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:38588 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896Ab2DCPRU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Apr 2012 11:17:20 -0400
Received: from /spool/local
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 3 Apr 2012 15:09:59 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q33FAtnd3448848
	for <linux-pci@vger.kernel.org>; Wed, 4 Apr 2012 01:10:56 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q33FHCel027251
	for <linux-pci@vger.kernel.org>; Wed, 4 Apr 2012 01:17:12 +1000
Date: Tue, 3 Apr 2012 23:17:10 +0800
From: Richard Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Richard Yang <weiyang@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org
Subject: Re: What is the difference between number and secondary in pci_bus?
Message-ID: <20120403151710.GB7957@richard>
Reply-To: Richard Yang <weiyang@linux.vnet.ibm.com>
References: <20120401083835.GA23662@richard>
 <CAErSpo6BMzKANM15dups94RsTUN3Q6F5oZJdG0MgCgXeB2KDEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo6BMzKANM15dups94RsTUN3Q6F5oZJdG0MgCgXeB2KDEQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 02, 2012 at 05:30:52PM -0600, Bjorn Helgaas wrote:
>On Sun, Apr 1, 2012 at 2:38 AM, Richard Yang <weiyang@linux.vnet.ibm.com> wrote:
>> All
>>
>> In the structure of pci_bus.
>> There is number, primary, secondary and subordinate.
>>
>> primary and subordinate are easy to understand, while the number and
>> secondary confused me.
>>
>> I think secondary means the current bus number.
>> Then what number stands for?
>>
>> In pci_alloc_child_bus(),
>> child->number = child->secondary = busnr;
>> So they are the same?
>> Then we need two different field?
>
>Good questions.
Thanks for your response.
>
>Primary, secondary, and subordinate are really properties of the
>upstream bridge, not the bus itself.  If we had a struct pci_bridge,
>they would logically live there.  Primary is the bus number of the
>upstream side of the bridge.  Secondary is the bus number of the
>bridge's downstream side.  The bridge forwards config transactions
>with bus numbers between secondary and subordinate to its downstream
>side.
>
>The "number of primary/secondary bridge" comments in struct pci_bus
>are wrong -- they are bus numbers, not bridge numbers.  And the "max
So do you think it is better to change "bridge" to "number"?
>number of subordinate buses" comment is not really right either.
>Subordinate is just the largest bus number forwarded by the bridge.
>As a consequence, that limits the number of buses in the downstream
>hierarchy.
Yes, sounds it is not very exact. Or just "subordinate bus" is ok?
>
>I have no idea why we have both number and secondary in struct
>pci_bus.  It seems like they should always be the same.  It would be
>an interesting exercise to figure out if they're ever different.
>
Do you think add some printk() at the end of pci_scan_bridge() is a good
place to test this?
If they are the same, could we remove one?

BTW, I tried git blame to search who add these two fields. Seems those
code is imported by 1da177e, which is the start of the git system.
>Bjorn

-- 
Richard Yang
Help you, Help me

