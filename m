Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:62103 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453Ab3FYVGK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jun 2013 17:06:10 -0400
Received: by mail-oa0-f43.google.com with SMTP id i7so14038056oag.16
        for <linux-pci@vger.kernel.org>; Tue, 25 Jun 2013 14:06:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQVN+iLTV0u0vsJMQyeeRg=oSudcn5EnKWAFSzD+-Uohfw@mail.gmail.com>
References: <20130625172608.GA11914@google.com> <CAE9FiQVN+iLTV0u0vsJMQyeeRg=oSudcn5EnKWAFSzD+-Uohfw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 25 Jun 2013 15:05:49 -0600
Message-ID: <CAErSpo5y=E63PPOi4xDd2bgYfG6PoJhqdvUH=gif_AqYh+m7GA@mail.gmail.com>
Subject: Re: Changes for v3.11 merge window
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 25, 2013 at 12:57 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Tue, Jun 25, 2013 at 10:26 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> Below are the patches currently in my "next" branch, planned for
>> release in v3.11.  If I'm missing something important, let me know.
>
> can you put this one in ?
> https://patchwork.kernel.org/patch/2647131/
>
> [v5,1/7] PCI: Don't let mmio fallback to must-only, if ioport fails
> with must+optional
>
>
> it will not just help powerpc case.
> also found that it is needed for one of 8 socket system that support pciehp
> but some root bus does not have ioport range allocated.
> in that case sriov does not work.

OK, I'll merge [1/7] if you open a kernel.org bugzilla and attach logs
showing the SR-IOV issue you tripped over.  Patch [1/7] will
immediately fix that bug, of course.  If anybody ever reworks our
resource assignment code, it will help to have information about the
scenarios it has to happen.

Actually, your patch should also have a reference to Ben's problem
report.  But I can dig that out and add it for you.

Bjorn
