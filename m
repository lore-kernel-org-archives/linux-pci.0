Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 23 Jul 2014 14:04:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 0/3] ACPI / PM: Make ACPI-based PCI wakeup work for the
 "freeze" sleep state
Message-ID: <20140723120432.GU3935@laptop>
References: <1907495.agrCMfRsQN@vostro.rjw.lan>
 <1938033.aGLPbNTjeQ@vostro.rjw.lan>
 <20140723113840.GJ20603@laptop.programming.kicks-ass.net>
 <6491652.ycQtdn67HU@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6491652.ycQtdn67HU@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 23, 2014 at 02:17:55PM +0200, Rafael J. Wysocki wrote:
> > (also, patchwork blows chunks :/)
> 
> That's never happened to me (and there's only one hunk in that patch).

I meant that patchwork sucks :-) It hides the actual patch, I had to
download things in order to see the actual patch.

> Anyway, the count for 0000:00:01.0:pcie01 means that the wakeup source
> has been activated, so it should have woken it up in theory.
> 
> Unless, of course, it was activated after the power button wakeup.

Yeah, I was thikning that maybe it doesn't get through entirely but has
pending state and comes through once we press the power button.

> It looks like the stuff works on the hardware level, though, so we should be
> able to make the wakeup work too.  I'll have another look later today.

Thanks.
