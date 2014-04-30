Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:53548 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759609AbaD3W1D (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Apr 2014 18:27:03 -0400
Received: by mail-ie0-f180.google.com with SMTP id as1so2744179iec.39
        for <linux-pci@vger.kernel.org>; Wed, 30 Apr 2014 15:27:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQW1yFmgZRCWrhi5ccwxWfDZdR0vbQ1bA7zz-5Fa8TfN5A@mail.gmail.com>
References: <1398893606-22712-1-git-send-email-yinghai@kernel.org>
 <CAErSpo7aWM_BjXqEqgTk0uT4RbpZSqjGJOgOH_hWreoQicMU_A@mail.gmail.com> <CAE9FiQW1yFmgZRCWrhi5ccwxWfDZdR0vbQ1bA7zz-5Fa8TfN5A@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 30 Apr 2014 16:26:41 -0600
Message-ID: <CAErSpo4K_duSr7Y5OHVm+KMhso2csG=nTZ9v1V=ATVK76Rj=QQ@mail.gmail.com>
Subject: Re: [PATCH v3] pciehp: only wait command complete for real hotplug control
To: Yinghai Lu <yinghai@kernel.org>
Cc: Rajat Jain <rajatxjain@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 30, 2014 at 4:06 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Wed, Apr 30, 2014 at 2:51 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Wed, Apr 30, 2014 at 3:33 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>> On system with 16 PCI express hotplug slots, customer complain every slot
>>> will report "Command not completed in 1000 msec" during initialization.
>>>
>>> Intel says that we should only wait command complete only for
>>>            Electromechanical Interlock Control
>>>            Power Controller Control
>>>            Power Indicator Control
>>>            Attention Indicator Control
>>>
>>> System with AMD/Nvidia chipset have same problem.
>>
>> Do you have a datasheet reference for any of these parts?  Do we have
>> any way of identifying the affected parts?  Is it *all* Intel parts,
>> *all* AMD parts, *all* Nvidia parts?
>
> For intel: Nehalem, westmere, sndbridge, ivybridge.
>
> For nvidia, only according to boot log for old systems with chipset:
> ck804 and mcp55.

I meant, do you have a reference to a section in the spec that talks
about how this works?

So far all we have is folklore that was discovered by experimentation.
 It'd be nice to see the spec that says "CC is only used when changing
these listed bits."

>> I want to have a comment in the code because we basically have two
>> strategies for dealing with Command Complete.  Both are legal
>> according to the PCIe spec, and you're changing from strategy A to
>> strategy B because B works better on these parts.  We need a hint in
>> the code that tells us not to change from B back to A and why.
>> Otherwise some future programmer is likely to change back to A, which
>> will break your box again.
>
> ok, will try to add comment about the change.
>
> Thanks
>
> Yinghai
