Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34293 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932697AbdBPSeZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2017 13:34:25 -0500
Date: Thu, 16 Feb 2017 19:34:22 +0100
From: Frederic Weisbecker <fweisbec@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pavel Machek <pavel@ucw.cz>, wanpeng.li@hotmail.com,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "# .39.x" <stable@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: v4.10-rc8 (-rc6) boot regression on Intel desktop, does not boot
 after cold boots, boots after reboot
Message-ID: <20170216183421.GC4357@lerouge>
References: <CA+55aFwt6pbt2STzRh1yCdoo7AnCLFqnPkkrYk4_BGFuvT2VCw@mail.gmail.com>
 <CA+55aFzMiXXw9gqNCMCSc+O5HfcqWHXfqbdtbvcOmAHM9_wNig@mail.gmail.com>
 <CA+55aFxuXgsCyMgrRDHdM6BQaej68QoU8TwdM=3LYu9LMBf4fQ@mail.gmail.com>
 <20170215172303.GA15696@amd>
 <20170215232005.GA7877@amd>
 <CA+55aFyqsxjQPp=Y6MnvyMH_iA-TSiPrycnAHbBzw5bwQi7jjg@mail.gmail.com>
 <20170216111144.GA12377@amd>
 <20170216172535.GA7868@amd>
 <20170216181353.GB4357@lerouge>
 <CA+55aFwhzMWR8QPGEK+8O8r0sFpHjn4XXraQ9K0Hq4VQi8Ru-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+55aFwhzMWR8QPGEK+8O8r0sFpHjn4XXraQ9K0Hq4VQi8Ru-w@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 16, 2017 at 10:20:14AM -0800, Linus Torvalds wrote:
> On Thu, Feb 16, 2017 at 10:13 AM, Frederic Weisbecker
> <fweisbec@gmail.com> wrote:
> >
> > I haven't followed the discussion but this patch has a known issue which is fixed
> > with:
> >     7bdb59f1ad474bd7161adc8f923cdef10f2638d1
> >     "tick/nohz: Fix possible missing clock reprog after tick soft restart"
> >
> > I hope this fixes your issue.
> 
> No, Pavel saw the problem with rc8 too, which already has that fix.
> 
> So I think we'll just need to revert that original patch (and that
> means that we have to revert the commit you point to as well, since
> that ->next_tick field was added by the original commit).

Aw too bad, but indeed that late we don't have the choice.
