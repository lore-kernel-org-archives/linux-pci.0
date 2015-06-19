Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:35288 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811AbbFSD0y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jun 2015 23:26:54 -0400
Received: by ykar6 with SMTP id r6so82449394yka.2
        for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2015 20:26:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQVZngaPYvxi1DcXDLvDnDvx6qb2md1xbhMBc0uCPyLisw@mail.gmail.com>
References: <1434235142-2751-1-git-send-email-yinghai@kernel.org>
 <20150619022612.GI7710@google.com> <CAE9FiQVZngaPYvxi1DcXDLvDnDvx6qb2md1xbhMBc0uCPyLisw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 18 Jun 2015 22:26:34 -0500
Message-ID: <CAErSpo7mpU4noESX+4BmRcm3SzgyiSeVMTm7TWK--7hkNt1suA@mail.gmail.com>
Subject: Re: [PATCH] PCI: get correct bridge mmio size with old size checking
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 18, 2015 at 10:02 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Thu, Jun 18, 2015 at 7:26 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Sat, Jun 13, 2015 at 03:39:02PM -0700, Yinghai Lu wrote:

>>>               size = min_size;
>>>       if (old_size == 1)
>>>               old_size = 0;
>>> +     size = ALIGN(size + size1, align);
>>>       if (size < old_size)
>>>               size = old_size;
>>> -     size = ALIGN(size + size1, align);
>>> +
>>
>> Please don't add an extra blank line here; the extra line makes
>> calculate_memsize() look different from calculate_iosize() for no good
>> reason.
>
> Sorry for that. I got the some impression from Ingo or someone else.
> like to have
>
> int func(int a)
> {
>         int b;
>
>         b = a .....
>
>         return b;
> }
>
> aka leave the blank line after declaration/define, and before last return.

I don't really care whether there's a blank line there or not.  What I
*do* care about is that we have two functions right next to each other
that are almost identical, and they should *look* the same.  If Ingo
likes a blank line there, that's fine; it just needs to be done
consistently.  So either add the blank line to both calculate_iosize()
and calculate_memsize() or leave it out of both of them.

Bjorn
