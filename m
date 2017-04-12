Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 12 Apr 2017 17:08:35 +0200
From: Frederic Weisbecker <fweisbec@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Stern <stern@rowland.harvard.edu>,
        torvalds@linux-foundation.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: v4.10-rc8 (-rc6) boot regression on Intel desktop, does not boot
 after cold boots, boots after reboot
Message-ID: <20170412150832.GE21309@lerouge>
References: <20170203190414.GA3701@amd>
 <Pine.LNX.4.44L0.1702031415140.1794-100000@iolanthe.rowland.org>
 <20170203205129.GA3791@amd>
 <20170203211854.GA3697@amd>
 <20170214175956.GA3587@amd>
 <20170214192743.GA3869@amd>
 <20170223162825.GA16646@lerouge>
 <20170223184013.GA5177@amd>
 <20170403153850.GA4418@lerouge>
 <20170403182050.GA6555@amd>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
In-Reply-To: <20170403182050.GA6555@amd>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 03, 2017 at 08:20:50PM +0200, Pavel Machek wrote:
> > > > > > ...1d.7: PCI fixup... pass 2
> > > > > > ...1d.7: PCI fixup... pass 3
> > > > > > ...1d.7: PCI fixup... pass 3 done
> > > > > > 
> > > > > > ...followed by hang. So yes, it looks USB related.
> > > > > > 
> > > > > > (Sometimes it hangs with some kind backtrace involving secondary CPU
> > > > > > startup, unfortunately useful info is off screen at that point).
> > > > > 
> > > > > Forgot to say, 1d.7 is EHCI controller.
> > > > > 
> > > > > 00:1d.7 USB controller: Intel Corporation NM10/ICH7 Family USB2 EHCI
> > > > > Controller (rev 01)
> > > > 
> > > > Ok, I should have access soon to a EeePc 1015CX (which seem to have this controller).
> > > > I hope I'll be able to reproduce the issue there. If not, I'm sorry but I'll have to
> > > > burden you again :-)
> > > 
> > > Go through more mails. It is only reproducible after cold boot. .. so
> > > I doubt it will be easy to reproduce on another machine.
> > > 
> > > Now... I do have serial port, and I even might have serial cable
> > > somewhere, but.... Giving how sensitive it is, it is probably going to
> > > go away with console on ttyS...
> > 
> > I also tried on an eeepc (which has ICH7/NM10 as well), with your config.
> > I even plugged a usb keyboard but even then I have been unable to
> > reproduce either :-(
> 
> Ok, give me some time. I'm no longer using the affected machine, so no
> promises.

Actually someone reported me a very similar issue than yours lately. It's probably
the same. And I have a potential fix.

The scenario is a bit tricky again, and still theoretical. If you're interested in gory details:
a tick which is scheduled at jiffies = N + 1, in order to expire a timer_list timer, fires a
tiny bit too early (ie: very few microseconds in advance). So it doesn't update the jiffies on irq entry
and still sees jiffies = N. The timer_list timer doesnt expire yet and on IRQ exit we reschedule
the tick at the same time. But we see that ts->next_tick already has that value, therefore
we don't reprogram it again, leaving the clockevent unprogrammed.

So in case you have the time and opportunity to test the fix, you'll need to:

1) Revert back to the offending change:
   git revert 558e8e27e73f53f8a512485be538b07115fe5f3c

2) Apply a delta fix:

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index a3b8154..ae66515 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1071,8 +1071,10 @@ static void tick_nohz_handler(struct clock_event_device *dev)
 	tick_sched_handle(ts, regs);
 
 	/* No need to reprogram if we are running tickless  */
-	if (unlikely(ts->tick_stopped))
+	if (unlikely(ts->tick_stopped)) {
+		ts->next_tick = 0;
 		return;
+	}
 
 	hrtimer_forward(&ts->sched_timer, now, tick_period);
 	tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
@@ -1172,8 +1174,10 @@ static enum hrtimer_restart tick_sched_timer(struct hrtimer *timer)
 		tick_sched_handle(ts, regs);
 
 	/* No need to reprogram if we are in idle or full dynticks mode */
-	if (unlikely(ts->tick_stopped))
+	if (unlikely(ts->tick_stopped)) {
+		ts->next_tick = 0;
 		return HRTIMER_NORESTART;
+	}
 
 	hrtimer_forward(timer, now, tick_period);
 


Thanks!

--ReaqsoxgOBHFXBhH
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="pavel.diff"

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index a3b8154..ae66515 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1071,8 +1071,10 @@ static void tick_nohz_handler(struct clock_event_device *dev)
 	tick_sched_handle(ts, regs);
 
 	/* No need to reprogram if we are running tickless  */
-	if (unlikely(ts->tick_stopped))
+	if (unlikely(ts->tick_stopped)) {
+		ts->next_tick = 0;
 		return;
+	}
 
 	hrtimer_forward(&ts->sched_timer, now, tick_period);
 	tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
@@ -1172,8 +1174,10 @@ static enum hrtimer_restart tick_sched_timer(struct hrtimer *timer)
 		tick_sched_handle(ts, regs);
 
 	/* No need to reprogram if we are in idle or full dynticks mode */
-	if (unlikely(ts->tick_stopped))
+	if (unlikely(ts->tick_stopped)) {
+		ts->next_tick = 0;
 		return HRTIMER_NORESTART;
+	}
 
 	hrtimer_forward(timer, now, tick_period);
 

--ReaqsoxgOBHFXBhH--
