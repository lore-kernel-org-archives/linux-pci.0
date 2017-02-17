Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34970 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933832AbdBQOE4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Feb 2017 09:04:56 -0500
Date: Fri, 17 Feb 2017 15:04:51 +0100
From: Frederic Weisbecker <fweisbec@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>, wanpeng.li@hotmail.com,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@redhat.com>,
        "# .39.x" <stable@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: v4.10-rc8 (-rc6) boot regression on Intel desktop, does not boot
 after cold boots, boots after reboot
Message-ID: <20170217140449.GA4521@lerouge>
References: <CA+55aFxuXgsCyMgrRDHdM6BQaej68QoU8TwdM=3LYu9LMBf4fQ@mail.gmail.com>
 <20170215172303.GA15696@amd>
 <20170215232005.GA7877@amd>
 <CA+55aFyqsxjQPp=Y6MnvyMH_iA-TSiPrycnAHbBzw5bwQi7jjg@mail.gmail.com>
 <20170216111144.GA12377@amd>
 <20170216172535.GA7868@amd>
 <20170216181353.GB4357@lerouge>
 <CA+55aFwhzMWR8QPGEK+8O8r0sFpHjn4XXraQ9K0Hq4VQi8Ru-w@mail.gmail.com>
 <20170216183421.GC4357@lerouge>
 <alpine.DEB.2.20.1702162033200.4049@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.20.1702162033200.4049@nanos>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 16, 2017 at 08:34:45PM +0100, Thomas Gleixner wrote:
> On Thu, 16 Feb 2017, Frederic Weisbecker wrote:
> > On Thu, Feb 16, 2017 at 10:20:14AM -0800, Linus Torvalds wrote:
> > > On Thu, Feb 16, 2017 at 10:13 AM, Frederic Weisbecker
> > > <fweisbec@gmail.com> wrote:
> > > >
> > > > I haven't followed the discussion but this patch has a known issue which is fixed
> > > > with:
> > > >     7bdb59f1ad474bd7161adc8f923cdef10f2638d1
> > > >     "tick/nohz: Fix possible missing clock reprog after tick soft restart"
> > > >
> > > > I hope this fixes your issue.
> > > 
> > > No, Pavel saw the problem with rc8 too, which already has that fix.
> > > 
> > > So I think we'll just need to revert that original patch (and that
> > > means that we have to revert the commit you point to as well, since
> > > that ->next_tick field was added by the original commit).
> > 
> > Aw too bad, but indeed that late we don't have the choice.
> 
> Hint: Look for CPU hotplug interaction of these patches. I bet something
> becomes stale when the CPU goes down and does not get reset when it comes
> back online.

Indeed I should check that. But Pavel is seeing this on boot, where the
only hotplug operations that happen are CPU UP without preceding CPU DOWN
that may have retained stale values. I think the value of ts->next_tick should
be initially 0 for all CPUs. So perhaps that 0 value confuses stuff. But
looking at the code I don't see how. It maybe something more subtle.
