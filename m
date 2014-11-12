Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:51432 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293AbaKLTC3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Nov 2014 14:02:29 -0500
Received: by mail-qg0-f53.google.com with SMTP id z107so9463402qgd.12
        for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2014 11:02:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20141112052431.GA30530@shangw>
References: <1415760163-12517-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAErSpo7mEo61GP4oxcodKWFFXaaESae96qLiR1RE0CFsahr29g@mail.gmail.com>
 <20141112031118.GA15257@shangw> <CAErSpo5OZxsB-X=tQWbWf3Q-wSvru3-+8_h5456QXZoMYeGKhA@mail.gmail.com>
 <20141112052431.GA30530@shangw>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 12 Nov 2014 12:02:08 -0700
Message-ID: <CAErSpo6Jx0wp7v9NAVMfj011QgXvPsuutMNHg6da_NFsTp4c5g@mail.gmail.com>
Subject: Re: [PATCH] PCI: Fix device node for virtual bus
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 11, 2014 at 10:24 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
> On Tue, Nov 11, 2014 at 09:08:23PM -0700, Bjorn Helgaas wrote:
>>On Tue, Nov 11, 2014 at 8:11 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
>>> On Tue, Nov 11, 2014 at 07:55:19PM -0700, Bjorn Helgaas wrote:
>>>>On Tue, Nov 11, 2014 at 7:42 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
>>>>> pci_set_bus_of_node() sets virtual PCI bus's device node to PHB's
>>>>> device node wrongly. The patch fixes the issue.
>>>>
>>>>This needs more detail.  How is this bug visible to users?  Is there a
>>>>bug report?  Is this a regression?  Should it be marked for stable?
>>>>
>>>
>>> I don't have opened bug for it. I just found the problem (maybe not
>>> a problem) when reading the code: The original implementation binds
>>> PHB device-tree node with "virtual bus", which doesn't make sense.
>>
>>Does this result in something being wrong in sysfs?  How is this bug
>>visible to users?
>>
>
> No, I don't think it caused anything wrong in sysfs. So I'm not sure
> it's a real problem and need the fix. Please judge.

Well, that's not really the way I work.  If somebody proposes a patch,
I expect the changelog to be an argument for why the patch is needed.
I'm not disagreeing with your patch; I'm just trying to get you to
provide the justification for it.  I'm not an OF expert, so it's not
obvious to me.  I probably could spend some time researching it and
convince myself, but I would rather have *you* convince me :)

>>> Yes, I guess it should be marked for stable if you don't object.

Once we know what the user-visible effect of this change is, it will
probably be obvious whether it should be marked for stable.  If it
doesn't really fix anything, it probably should not go to stable.

Bjorn
