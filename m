Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:38577 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250Ab2IGWPu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 7 Sep 2012 18:15:50 -0400
Received: by eaac11 with SMTP id c11so27221eaa.19
        for <linux-pci@vger.kernel.org>; Fri, 07 Sep 2012 15:15:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo6vMjr=veZs8AWg1X5EfWfGNeUFkz1EExF4+km9fnOwmQ@mail.gmail.com>
References: <bug-18412-41252@https.bugzilla.kernel.org/>
	<20120907214005.5077211FC43@bugzilla.kernel.org>
	<CAErSpo6vMjr=veZs8AWg1X5EfWfGNeUFkz1EExF4+km9fnOwmQ@mail.gmail.com>
Date: Fri, 7 Sep 2012 15:15:49 -0700
Message-ID: <CAE9FiQXO3R8oQH2rNky64SWe-4DRx7HJr3-rp0eqEZvQbN4W2A@mail.gmail.com>
Subject: Re: [Bug 18412] Intel DP43BF requires "pci=assign-busses" to discover
 some devices
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, vl.homutov@gmail.com
Cc: bugzilla-daemon@bugzilla.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 7, 2012 at 2:52 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Fri, Sep 7, 2012 at 2:40 PM,  <bugzilla-daemon@bugzilla.kernel.org> wrote:
>> https://bugzilla.kernel.org/show_bug.cgi?id=18412
>
>> --- Comment #4 from VL <vl.homutov@gmail.com>  2012-09-07 21:40:04 ---
>> The bug is still there with behaviour exactly as specified by reporter.
>>
>> Tested with linux-3.4.9 (gentoo), DP43BF motherboard and Intel PRO/1000 NICs.
>> With pci=assign-busses lspci shows devices properly, without it nothing
>> is in the list.

VL,

I rebased for-pci-busn-alloc branch to current pci-next

please check if could fix the problem.

git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
for-pci-busn-alloc

http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=shortlog;h=refs/heads/for-pci-busn-alloc

Thanks

Yinghai
