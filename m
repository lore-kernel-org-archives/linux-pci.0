Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:56019 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751101Ab2IGVxC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 7 Sep 2012 17:53:02 -0400
Received: by lagy9 with SMTP id y9so34939lag.19
        for <linux-pci@vger.kernel.org>; Fri, 07 Sep 2012 14:53:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120907214005.5077211FC43@bugzilla.kernel.org>
References: <bug-18412-41252@https.bugzilla.kernel.org/> <20120907214005.5077211FC43@bugzilla.kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 7 Sep 2012 14:52:40 -0700
Message-ID: <CAErSpo6vMjr=veZs8AWg1X5EfWfGNeUFkz1EExF4+km9fnOwmQ@mail.gmail.com>
Subject: Re: [Bug 18412] Intel DP43BF requires "pci=assign-busses" to discover
 some devices
To: bugzilla-daemon@bugzilla.kernel.org
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 7, 2012 at 2:40 PM,  <bugzilla-daemon@bugzilla.kernel.org> wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=18412

> --- Comment #4 from VL <vl.homutov@gmail.com>  2012-09-07 21:40:04 ---
> The bug is still there with behaviour exactly as specified by reporter.
>
> Tested with linux-3.4.9 (gentoo), DP43BF motherboard and Intel PRO/1000 NICs.
> With pci=assign-busses lspci shows devices properly, without it nothing
> is in the list.

Anybody who wants to help with bugs like this, feel free :)  There are
a number of open regressions and bugs in the PCI subsystem of
https://bugzilla.kernel.org/

I spend a lot of time looking at these bugs, and that reduces the time
I have to review and apply patches.
