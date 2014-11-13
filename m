Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp06.in.ibm.com ([122.248.162.6]:55580 "EHLO
	e28smtp06.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462AbaKMAqG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Nov 2014 19:46:06 -0500
Received: from /spool/local
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Thu, 13 Nov 2014 06:16:03 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id CF4031258044
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2014 06:16:04 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sAD0kYCn35782900
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2014 06:16:34 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sAD0k0P6027317
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2014 06:16:00 +0530
Date: Thu, 13 Nov 2014 11:45:56 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Fix device node for virtual bus
Message-ID: <20141113004556.GA24858@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1415760163-12517-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAErSpo7mEo61GP4oxcodKWFFXaaESae96qLiR1RE0CFsahr29g@mail.gmail.com>
 <20141112031118.GA15257@shangw>
 <CAErSpo5OZxsB-X=tQWbWf3Q-wSvru3-+8_h5456QXZoMYeGKhA@mail.gmail.com>
 <20141112052431.GA30530@shangw>
 <CAErSpo6Jx0wp7v9NAVMfj011QgXvPsuutMNHg6da_NFsTp4c5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo6Jx0wp7v9NAVMfj011QgXvPsuutMNHg6da_NFsTp4c5g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 12, 2014 at 12:02:08PM -0700, Bjorn Helgaas wrote:
>On Tue, Nov 11, 2014 at 10:24 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
>> On Tue, Nov 11, 2014 at 09:08:23PM -0700, Bjorn Helgaas wrote:
>>>On Tue, Nov 11, 2014 at 8:11 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
>>>> On Tue, Nov 11, 2014 at 07:55:19PM -0700, Bjorn Helgaas wrote:
>>>>>On Tue, Nov 11, 2014 at 7:42 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
>>>>>> pci_set_bus_of_node() sets virtual PCI bus's device node to PHB's
>>>>>> device node wrongly. The patch fixes the issue.
>>>>>
>>>>>This needs more detail.  How is this bug visible to users?  Is there a
>>>>>bug report?  Is this a regression?  Should it be marked for stable?
>>>>>
>>>>
>>>> I don't have opened bug for it. I just found the problem (maybe not
>>>> a problem) when reading the code: The original implementation binds
>>>> PHB device-tree node with "virtual bus", which doesn't make sense.
>>>
>>>Does this result in something being wrong in sysfs?  How is this bug
>>>visible to users?
>>>
>>
>> No, I don't think it caused anything wrong in sysfs. So I'm not sure
>> it's a real problem and need the fix. Please judge.
>
>Well, that's not really the way I work.  If somebody proposes a patch,
>I expect the changelog to be an argument for why the patch is needed.
>I'm not disagreeing with your patch; I'm just trying to get you to
>provide the justification for it.  I'm not an OF expert, so it's not
>obvious to me.  I probably could spend some time researching it and
>convince myself, but I would rather have *you* convince me :)
>

Thank you for the detailed explaining. I'm trying to convince you.
Please drop it in case I fail :)

Basically, we have 3 types of buses with SR-IOV case inclusive:
(A) root bus leading from PHB; (B) normal bus leading from PCI
bridge; (C) virtual bus to hold SR-IOV VFs. A's device node is set
to PHB's device node and B's device node is equal to parent PCI
bridge's device node. So the device node of PCI bus is set that
one of parent device (either PHB or PCI bridge for A/B). For (C),
the bus's device node would be NULL, which is consistent with that
its parent device is NULL.

Kernel code can convert PCI bus to its corresponding device node
with function pci_bus_to_OF_node(). The code is usually unware
what type (PHB, PCI bridge or device) the device node is. With
current code, we poke the PHB device node for SR-IOV virtual buses.
and potentially wrong properties retrieved. I personally don't
think it's appropriate and it's worthy to have NULL device nodes
for those virtual buses.

>>>> Yes, I guess it should be marked for stable if you don't object.
>
>Once we know what the user-visible effect of this change is, it will
>probably be obvious whether it should be marked for stable.  If it
>doesn't really fix anything, it probably should not go to stable.
>

Yep, it's not good candidate for stable.

Thanks,
Gavin

