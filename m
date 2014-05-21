Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:64841 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbaEUEgu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 May 2014 00:36:50 -0400
Received: by mail-ie0-f171.google.com with SMTP id to1so1497706ieb.2
        for <linux-pci@vger.kernel.org>; Tue, 20 May 2014 21:36:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140521033111.GA8419@richard>
References: <1397752819-17326-1-git-send-email-yinghai@kernel.org>
 <20140520033233.11972.49094.stgit@bhelgaas-glaptop.roam.corp.google.com> <20140521033111.GA8419@richard>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 20 May 2014 22:36:30 -0600
Message-ID: <CAErSpo4z+pqMGxH3wM7PfkvY2BLfN3ts4nf25nf17DZfhSJqGg@mail.gmail.com>
Subject: Re: [PATCH v10 0/4] PCI: Restrict 64-bit prefetchable bridge windows
 to 64-bit resources
To: Wei Yang <weiyang@linux.vnet.ibm.com>,
	Guo Chao <yan@linux.vnet.ibm.com>
Cc: Yinghai Lu <yinghai@kernel.org>, talal@mellanox.com,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Amir Vadai <amirv@mellanox.com>,
	Eugenia Emantayev <eugenia@mellanox.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 20, 2014 at 9:31 PM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
> Bjorn,
>
> I tried to apply it on the lastest upstrea, but seems not work.
>
> Which tree should I apply to? This one ?
> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git

They are on top of my pci/resource branch, i.e.,
http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/resource

BTW, Guo, I'm waiting for your update to
https://bugzilla.kernel.org/show_bug.cgi?id=74151 .  I want to close
the loop with a specific example of how this patch fixes the problem.

> On Mon, May 19, 2014 at 09:45:45PM -0600, Bjorn Helgaas wrote:
>>I'd like to merge these for v3.16.  The first is Yinghai's v9 patch
>>unchanged except to resolve minor merge conflicts, write a changelog, and
>>fold in the mem64_mask removal posted previously as [1].
>>
>>The rest are cleanups and comment changes to try to make the code more
>>readable.
>>
>>This does fix a real bug -- in some cases we can't assign space to large
>>64-bit BARs even though there is plenty of 64-bit space available.  But I
>>am concerned that we are giving up performance in some cases (32-bit
>>prefetchable resources below a bridge with a 64-bit prefetchable window
>>will no longer be prefetchable).  With some additional work, it should be
>>possible to get that performance back.
>>
>>Comments welcome.
>>
>>[1] http://lkml.kernel.org/r/CAE9FiQUKYMPvXLsk84o-gH-j0-wiJGL0Wt1aTW2o4FPSm0PvbQ@mail.gmail.com
>>
>>---
>>
>>Bjorn Helgaas (3):
>>      PCI: Change pbus_size_mem() return values to be more conventional
>>      PCI: Simplify __pci_assign_resource() coding style
>>      PCI: Add resource allocation comments
>>
>>Yinghai Lu (1):
>>      PCI: Restrict 64-bit prefetchable bridge windows to 64-bit resources
>>
>>
>> drivers/pci/setup-bus.c |  207 +++++++++++++++++++++++++++++++++--------------
>> drivers/pci/setup-res.c |   41 +++++++--
>> 2 files changed, 176 insertions(+), 72 deletions(-)
>
> --
> Richard Yang
> Help you, Help me
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
