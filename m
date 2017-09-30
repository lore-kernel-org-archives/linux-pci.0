Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from alln-iport-1.cisco.com ([173.37.142.88]:46945 "EHLO
        alln-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750724AbdI3GDR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 Sep 2017 02:03:17 -0400
Date: Fri, 29 Sep 2017 23:03:04 -0700
From: Govindarajulu Varadarajan <gvaradar@cisco.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, <benve@cisco.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jlbec@evilplan.org>, <hch@lst.de>,
        <mingo@redhat.com>
Subject: Re: [PATCH 4/4] lockdep: make MAX_LOCK_DEPTH configurable from
 Kconfig
In-Reply-To: <20170929162332.GA15567@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <alpine.LNX.2.20.1709292301420.24635@cae-iprp-alln-lb.cisco.com>
References: <20170927214220.41216-1-gvaradar@cisco.com> <20170927214220.41216-5-gvaradar@cisco.com> <20170928092600.qvehxzikcjr65hvw@hirez.programming.kicks-ass.net> <alpine.LNX.2.20.1709281646360.24635@cae-iprp-alln-lb.cisco.com>
 <20170929162332.GA15567@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 29 Sep 2017, Bjorn Helgaas wrote:

> On Thu, Sep 28, 2017 at 04:51:46PM -0700, Govindarajulu Varadarajan wrote:
>> On Thu, 28 Sep 2017, Peter Zijlstra wrote:
>>
>>> On Wed, Sep 27, 2017 at 02:42:20PM -0700, Govindarajulu Varadarajan wrote:
>>>> Make MAX_LOCK_DEPTH configurable. It is set to 48 right now. Number of
>>>> VFs under a PCI pf bus can exceed 48 and this disables lockdep.
>>>>
>>>> lockdep currently allows max of 63 held_locks.
>>>
>>> But why a config knob? Why not just raise the number to 64
>>> unconditionally? And is that sufficient; you only state 48 is
>>> insufficient, you don't actually state the VF limit.
>>>
>>
>> I did not want to change the default configuration for everyone.
>>
>> I will change it 63 unconditionally in v2 and resubmit the series.
>
> I'm not happy about having to increase MAX_LOCK_DEPTH based on a
> number of VFs.  I haven't had time to look at the locking strategy
> you're proposing, but it just doesn't feel right to have to take 50+
> locks for one operation.

I agree. I have sent V2 where we dont lock 50+ device_lock. Please have a look.
