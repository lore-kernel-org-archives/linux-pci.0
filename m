Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:41615 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281Ab2H3GCo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Aug 2012 02:02:44 -0400
Received: by lbbgj3 with SMTP id gj3so263705lbb.19
        for <linux-pci@vger.kernel.org>; Wed, 29 Aug 2012 23:02:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQWEE0aCPbM=aVfH4kYzWqpJ4orseh2isWuuGFj3yFxKqQ@mail.gmail.com>
References: <CAErSpo73r3yzzndUek-NJ3d0pDKtg8zTrnjk4ihudBE5gngBAA@mail.gmail.com>
 <503E39DE.7000109@gmail.com> <CAPoiz9yRzEr68=NB53SVXb5+nRmEa_J4Mtt6eGAAo5EWFbDbmQ@mail.gmail.com>
 <CAE9FiQWEE0aCPbM=aVfH4kYzWqpJ4orseh2isWuuGFj3yFxKqQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 29 Aug 2012 23:02:22 -0700
Message-ID: <CAErSpo60gh1Ph6jq5iWT6Vsc=UGW+4DFdGCZpL90-3vk+_H89g@mail.gmail.com>
Subject: Re: PCI mini-summit notes
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jon Mason <jdmason@kudzu.us>, Jiang Liu <liuj97@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[removed cc ksummit-2012-discuss]

On Wed, Aug 29, 2012 at 3:54 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Wed, Aug 29, 2012 at 3:44 PM, Jon Mason <jdmason@kudzu.us> wrote:
>>> Hi Bjorn,
>>>         One of my team member reported another corner case for SR-IOV. There's
>>> are two NIC cards in the system driven by the same driver, but one supports
>>> SR-IOV and the other doesn't. It runs into trouble if "max_vfs" parameter is
>>> set for the NIC driver.
>>>         --Gerry
>>
>> I believe it was decided that a per-pf sysfs interface would be used
>> to replace the current module parameter that specifies the number of
>> vf's.  This should enable different numbers of vf's for each physical
>> device.  The driver interface that was discussed would introduce new
>> function pointers for handlers to setup/teardown the vf's.  I believe
>> this will solve your problem once it has been implemented.
>
> now we have ixgbe.max_vfs=63
>
> so if change to per pci device (PF),
>
> how about having the driver built-in?
> what kind of kernel parameters will be passed?

I don't think we really discussed things at this level, and I
personally don't know enough about the current SR-IOV support to even
know what the possible strategies are.  I think it's really up to the
person doing the implementation to figure out what makes sense given
the constraints of the SR-IOV specs and the current Linux support.

Bjorn
