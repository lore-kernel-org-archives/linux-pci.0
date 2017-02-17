Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35867 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934507AbdBQSnh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Feb 2017 13:43:37 -0500
Date: Fri, 17 Feb 2017 19:43:28 +0100
From: Frederic Weisbecker <fweisbec@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        wanpeng.li@hotmail.com, Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20170217184327.GD4521@lerouge>
References: <CA+55aFyqsxjQPp=Y6MnvyMH_iA-TSiPrycnAHbBzw5bwQi7jjg@mail.gmail.com>
 <20170216111144.GA12377@amd>
 <20170216172535.GA7868@amd>
 <20170216181353.GB4357@lerouge>
 <CA+55aFwhzMWR8QPGEK+8O8r0sFpHjn4XXraQ9K0Hq4VQi8Ru-w@mail.gmail.com>
 <20170216183421.GC4357@lerouge>
 <alpine.DEB.2.20.1702162033200.4049@nanos>
 <20170217140449.GA4521@lerouge>
 <alpine.DEB.2.20.1702171737020.3536@nanos>
 <20170217170508.GA20884@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170217170508.GA20884@amd>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 17, 2017 at 06:05:08PM +0100, Pavel Machek wrote:
> On Fri 2017-02-17 17:37:47, Thomas Gleixner wrote:
> > On Fri, 17 Feb 2017, Frederic Weisbecker wrote:
> > > On Thu, Feb 16, 2017 at 08:34:45PM +0100, Thomas Gleixner wrote:
> > > > On Thu, 16 Feb 2017, Frederic Weisbecker wrote:
> > > > > On Thu, Feb 16, 2017 at 10:20:14AM -0800, Linus Torvalds wrote:
> > > > > > On Thu, Feb 16, 2017 at 10:13 AM, Frederic Weisbecker
> > > > > > <fweisbec@gmail.com> wrote:
> > > > > > >
> > > > > > > I haven't followed the discussion but this patch has a known issue which is fixed
> > > > > > > with:
> > > > > > >     7bdb59f1ad474bd7161adc8f923cdef10f2638d1
> > > > > > >     "tick/nohz: Fix possible missing clock reprog after tick soft restart"
> > > > > > >
> > > > > > > I hope this fixes your issue.
> > > > > > 
> > > > > > No, Pavel saw the problem with rc8 too, which already has that fix.
> > > > > > 
> > > > > > So I think we'll just need to revert that original patch (and that
> > > > > > means that we have to revert the commit you point to as well, since
> > > > > > that ->next_tick field was added by the original commit).
> > > > > 
> > > > > Aw too bad, but indeed that late we don't have the choice.
> > > > 
> > > > Hint: Look for CPU hotplug interaction of these patches. I bet something
> > > > becomes stale when the CPU goes down and does not get reset when it comes
> > > > back online.
> > > 
> > > Indeed I should check that. But Pavel is seeing this on boot, where the
> > 
> > I don't think so. He observed it on suspend resume and by doing hotplug
> > operations in a loop. But I might be wrong as usual.
> 
> These are different bugs.
> 
> On x60, I see failures doing hotplug/unplug in a loop, or lot of
> suspends. Someone seen it in v4.8-stable etc. Old bug. Rare to hit.
> 
> Desktop machine was failing to boot, and had some fun with
> suspend/resume too. Boot hang was reproducible with right
> procedure. (Hard poweroff, cold boot.). That one was introduced in
> 4.10-rc cycle.

Pavel, is there any chance you could apply this patch on top of latest linus tree
and send me your resulting dmesg log? This has the two reverted patches plus some
debugging code. The amount of printk shouldn't be too big, I tested it home without
issue.

If you can't manage to dump the dmesg, please try to take a picture of your screen
so that I can see the last messages starting with "NEXT_TICK_READ".

Thanks!

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 2c115fd..504cb41 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -658,6 +658,8 @@ static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
 		tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
 }
 
+static DEFINE_PER_CPU(u64, prev_next_tick);
+
 static ktime_t tick_nohz_stop_sched_tick(struct tick_sched *ts,
 					 ktime_t now, int cpu)
 {
@@ -725,6 +727,11 @@ static ktime_t tick_nohz_stop_sched_tick(struct tick_sched *ts,
 		 */
 		if (delta == 0) {
 			tick_nohz_restart(ts, now);
+			/*
+			 * Make sure next tick stop doesn't get fooled by past
+			 * clock deadline
+			 */
+			ts->next_tick = 0;
 			goto out;
 		}
 	}
@@ -767,8 +774,15 @@ static ktime_t tick_nohz_stop_sched_tick(struct tick_sched *ts,
 	tick = expires;
 
 	/* Skip reprogram of event if its not changed */
-	if (ts->tick_stopped && (expires == dev->next_event))
-		goto out;
+	if (ts->tick_stopped) {
+		if (system_state == SYSTEM_BOOTING) {
+			if (ts->next_tick != this_cpu_read(prev_next_tick))
+				printk("NEXT_TICK_READ: CPU: %d Expires: %llu ts->next_tick:%llu\n", smp_processor_id(), expires, ts->next_tick);
+			this_cpu_write(prev_next_tick, ts->next_tick);
+		}
+		if (expires == ts->next_tick)
+			goto out;
+	}
 
 	/*
 	 * nohz_stop_sched_tick can be called several times before
@@ -787,6 +801,8 @@ static ktime_t tick_nohz_stop_sched_tick(struct tick_sched *ts,
 		trace_tick_stop(1, TICK_DEP_MASK_NONE);
 	}
 
+	ts->next_tick = tick;
+
 	/*
 	 * If the expiration time == KTIME_MAX, then we simply stop
 	 * the tick timer.
@@ -802,7 +818,10 @@ static ktime_t tick_nohz_stop_sched_tick(struct tick_sched *ts,
 	else
 		tick_program_event(tick, 1);
 out:
-	/* Update the estimated sleep length */
+	/*
+	 * Update the estimated sleep length until the next timer
+	 * (not only the tick).
+	 */
 	ts->sleep_length = ktime_sub(dev->next_event, now);
 	return tick;
 }
diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index bf38226..075444e 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -27,6 +27,7 @@ enum tick_nohz_mode {
  *			timer is modified for nohz sleeps. This is necessary
  *			to resume the tick timer operation in the timeline
  *			when the CPU returns from nohz sleep.
+ * @next_tick:		Next tick to be fired when in dynticks mode.
  * @tick_stopped:	Indicator that the idle tick has been stopped
  * @idle_jiffies:	jiffies at the entry to idle for idle time accounting
  * @idle_calls:		Total number of idle calls
@@ -44,6 +45,7 @@ struct tick_sched {
 	unsigned long			check_clocks;
 	enum tick_nohz_mode		nohz_mode;
 	ktime_t				last_tick;
+	ktime_t				next_tick;
 	int				inidle;
 	int				tick_stopped;
 	unsigned long			idle_jiffies;
