Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kevin Hilman <khilman@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 0/12] PM / sleep: Driver flags for system suspend/resume
Date: Wed, 18 Oct 2017 02:39:24 +0200
Message-ID: <1591167.zlNa3zLfmM@aspire.rjw.lan>
In-Reply-To: <CAPDyKFrMTSUHP86hnpHius2CDfv-ap4svGg=xgwAiH8pKj9Lvw@mail.gmail.com>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <17155956.N7VCkzZpky@aspire.rjw.lan> <CAPDyKFrMTSUHP86hnpHius2CDfv-ap4svGg=xgwAiH8pKj9Lvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, October 17, 2017 9:41:16 PM CEST Ulf Hansson wrote:

[cut]

> >
> >> deploying this and from a middle layer point of view, all the trivial
> >> cases supports this.
> >
> > These functions are wrong, however, because they attempt to reuse the
> > whole callback *path* instead of just reusing driver callbacks.  The
> > *only* reason why it all "works" is because there are no middle layer
> > callbacks involved in that now.
> >
> > If you changed them to reuse driver callbacks only today, nothing would break
> > AFAICS.
> 
> Yes, it would.
> 
> First, for example, the amba bus is responsible for the amba bus
> clock, but relies on drivers to gate/ungate it during system sleep. In
> case the amba drivers don't use the pm_runtime_force_suspend|resume(),
> it will explicitly have to start manage the clock during system sleep
> themselves. Leading to open coding.

Well, I suspected that something like this would surface. ;-)

Are there any major reasons why the appended patch (obviously untested) won't
work, then?

> Second, it will introduce a regression in behavior for all users of
> pm_runtime_force_suspend|resume(), especially during system resume as
> the driver may then end up resuming the device even in case it isn't
> needed.

How so?

I'm talking about a change like in the appended patch, where
pm_runtime_force_* simply invoke driver callbacks directly.  What is
skipped there is middle-layer stuff which is empty anyway in all cases
except for AMBA (if that's all what is lurking below the surface), so
I don't quite see how the failure will happen.

> I believe I have explained why, also several times by now -
> and that's also how far you could take the i2c designware driver at
> this point.
> 
> That said, I assume the second part may be addressed in this series,
> if these drivers convert to use the "driver PM flags", right?
> 
> However, what about the first case? Is some open coding needed or your
> think the amba driver can instruct the amba bus via the "driver PM
> flags"?

With the appended patch applied things should work for AMBA like for
any other bus type implementing PM, so I don't see why not.

> >
> >> Like the spi bus, i2c bus, amba bus, platform
> >> bus, genpd, etc. There are no changes needed to continue to support
> >> this option, if you see what I mean.
> >
> > For the time being, nothing changes in that respect, but eventually I'd
> > prefer the pm_runtime_force_* things to go away, frankly.
> 
> Okay, thanks for that clear statement!
> 
> >
> >> So, when you say that re-using runtime PM callbacks for system-wide PM
> >> isn't going to happen, can you please elaborate what you mean?
> >
> > I didn't mean "reusing runtime PM callbacks for system-wide PM" overall, but
> > reusing *middle-layer* runtime PM callbacks for system-wide PM.  That is the
> > bogus part.
> 
> I think we have discussed this several times, but the arguments you
> have put forward, explaining *why* haven't yet convinced me.

Well, sorry about that.  I would like to be able to explain my point to you so
that you understand my perspective, but if that's not working, that's not a
sufficient reason for me to give up.

I'm just refusing to maintain code that I don't agree with in the long run.

> In principle what you have been saying is that it's a "layering
> violation" to use pm_runtime_force_suspend|resume() from driver's
> system sleep callbacks, but on the other hand you think using
> pm_runtime_get*  and friends is okay!?

Not unconditionally, which would be fair to mention.

Only if it is called in ->prepare or as the first thing in a ->suspend
callback.  Later than that is broken too in principle.

> That makes little sense to me, because it's the same "layering
> violation" that is done for both cases.

The "layering violation" is all about things possibly occurring in a
wrong order.  For example, say a middle-layer ->runtime_suspend is
called via pm_runtime_force_suspend() which in turn is called from
middle-layer ->suspend_late as a driver callback.  If the ->runtime_suspend
does anything significat to the device, then executing the remaining part of
->suspend_late will almost cetainly break things, more or less.

That is not a concern with a middle-layer ->runtime_resume running
*before* a middle-layer ->suspend (or any subsequent callbacks) does
anything significant to the device.

Is there anything in the above which is not clear enough?

> Moreover, you have been explaining that re-using runtime PM callbacks
> for PCI doesn't work. Then my question is, why should a limitation of
> the PCI subsystem put constraints on the behavior for all other
> subsystems/middle-layers?

Because they aren't just PCI subsystem limitations only.  The need to handle
wakeup setup differently for runtime PM and system sleep is not PCI-specific.
The need to handle suspend and hibernation differently isn't too.

Those things may be more obvious in PCI, but they are generic rather than
special.

Also, quite so often other middle layers interact with PCI directly or
indirectly (eg. a platform device may be a child or a consumer of a PCI
device) and some optimizations need to take that into account (eg. parents
generally need to be accessible when their childres are resumed and so on).

Moreover, the majority of the "other subsystems/middle-layers" you've talked
about so far don't provide any PM callbacks to be invoked by pm_runtime_force_*,
so question is how representative they really are.

> >
> > Quoting again:
> >
> > "If you are a middle layer, your role is basically to do PM for a certain
> > group of devices.  Thus you cannot really do the same in ->suspend or
> > ->suspend_early and in ->runtime_suspend (because the former generally need to
> > take device_may_wakeup() into account and the latter doesn't) and you shouldn't
> > really do the same in ->suspend and ->freeze (becuase the latter shouldn't
> > change the device's power state) and so on."
> >
> > I have said for multiple times that re-using *driver* callbacks actually makes
> > sense and the series is for doing that easier in general among other things.
> >
> >> I assume you mean that the PM core won't be involved to support this,
> >> but is that it?
> >>
> >> Do you also mean that *all* users of pm_runtime_force_suspend|resume()
> >> must convert to this new thing, using "driver PM flags", so in the end
> >> you want to remove pm_runtime_force_suspend|resume()?
> >>  - Then if so, you must of course consider all cases for how
> >> pm_runtime_force_suspend|resume() are being deployed currently, else
> >> existing users can't convert to the "driver PM flags" thing. Have you
> >> done that in this series?
> >
> > Let me turn this around.
> >
> > The majority of cases in which pm_runtime_force_* are used *should* be
> > addressable using the flags introduced here.  Some case in which
> > pm_runtime_force_* cannot be used should be addressable by these flags
> > as well.
> 
> That's sounds really great!
> 
> >
> > There may be some cases in which pm_runtime_force_* are used that may
> > require something more, but I'm not going to worry about that right now.
> 
> This approach concerns me, because if we in the end realizes that
> pm_runtime_force_suspend|resume() will be too hard to get rid of, then
> this series just add yet another generic way of trying to optimize the
> system sleep path for runtime PM enabled devices.

Which also works for PCI and the ACPI PM domain and that's sort of valuable
anyway, isn't it?

For the record, I don't think it will be too hard to get rid of
pm_runtime_force_suspend|resume(), although that may take quite some time.

> So then we would end up having to support the "direct_complete" path,
> the "driver PM flags" and cases where
> pm_runtime_force_suspend|resume() is used. No, that just isn't good
> enough to me. That will just lead to similar scenarios as we had in
> the i2c designware driver.

Frankly, this sounds like staging for indefinite blocking of changes in
this area on non-technical grounds.  I hope that it isn't the case ...

> If we decide to go with these new "driver PM flags", I want to make
> sure, as long as possible, that we can remove both the
> "direct_complete" path support from the PM core as well as removing
> the pm_runtime_force_suspend|resume() helpers.

We'll see.

> >
> > I'll take care of that when I'll be removing pm_runtime_force_*, which I'm
> > not doing here.
> 
> Of course I am fine with that we postpone doing the actual converting
> of drivers etc from this series, although as stated above, let's sure
> we *can* do it by using the "driver PM flags".

There clearly are use cases that benefit from this series and I don't see
any alternatives covering them, including both direct-complete and the
pm_runtime_force* approach, so I'm not buying this "let's make sure
it can cover all possible use cases that exist" argumentation.

Thanks,
Rafael


---
 drivers/amba/bus.c           |   79 ++++++++++++++++++++++++++++---------------
 drivers/base/power/runtime.c |   10 +++--
 2 files changed, 58 insertions(+), 31 deletions(-)

Index: linux-pm/drivers/amba/bus.c
===================================================================
--- linux-pm.orig/drivers/amba/bus.c
+++ linux-pm/drivers/amba/bus.c
@@ -132,52 +132,77 @@ static struct attribute *amba_dev_attrs[
 ATTRIBUTE_GROUPS(amba_dev);
 
 #ifdef CONFIG_PM
+static void amba_pm_suspend(struct device *dev)
+{
+	struct amba_device *pcdev = to_amba_device(dev);
+
+	if (!dev->driver)
+		return;
+
+	if (pm_runtime_is_irq_safe(dev))
+		clk_disable(pcdev->pclk);
+	else
+		clk_disable_unprepare(pcdev->pclk);
+}
+
+static int amba_pm_resume(struct device *dev)
+{
+	struct amba_device *pcdev = to_amba_device(dev);
+
+	if (!dev->driver)
+		return 0;
+
+	/* Failure is probably fatal to the system, but... */
+	if (pm_runtime_is_irq_safe(dev))
+		return clk_enable(pcdev->pclk);
+
+	return clk_prepare_enable(pcdev->pclk);
+}
+
 /*
  * Hooks to provide runtime PM of the pclk (bus clock).  It is safe to
  * enable/disable the bus clock at runtime PM suspend/resume as this
  * does not result in loss of context.
  */
+static int amba_pm_suspend_early(struct device *dev)
+{
+	int ret = pm_generic_suspend_early(dev);
+
+	if (ret)
+		return ret;
+
+	amba_pm_suspend(dev);
+	return 0;
+}
+
+static int amba_pm_resume_late(struct device *dev)
+{
+	int ret = amba_pm_resume(dev);
+
+	return ret ? ret : pm_generic_resume_late(dev);
+}
+
 static int amba_pm_runtime_suspend(struct device *dev)
 {
-	struct amba_device *pcdev = to_amba_device(dev);
 	int ret = pm_generic_runtime_suspend(dev);
 
-	if (ret == 0 && dev->driver) {
-		if (pm_runtime_is_irq_safe(dev))
-			clk_disable(pcdev->pclk);
-		else
-			clk_disable_unprepare(pcdev->pclk);
-	}
+	if (ret)
+		return ret;
 
-	return ret;
+	amba_pm_suspend(dev);
+	return 0;
 }
 
 static int amba_pm_runtime_resume(struct device *dev)
 {
-	struct amba_device *pcdev = to_amba_device(dev);
-	int ret;
-
-	if (dev->driver) {
-		if (pm_runtime_is_irq_safe(dev))
-			ret = clk_enable(pcdev->pclk);
-		else
-			ret = clk_prepare_enable(pcdev->pclk);
-		/* Failure is probably fatal to the system, but... */
-		if (ret)
-			return ret;
-	}
+	int ret = amba_pm_resume(dev);
 
-	return pm_generic_runtime_resume(dev);
+	return ret ? ret : pm_generic_runtime_resume(dev);
 }
 #endif /* CONFIG_PM */
 
 static const struct dev_pm_ops amba_pm = {
-	.suspend	= pm_generic_suspend,
-	.resume		= pm_generic_resume,
-	.freeze		= pm_generic_freeze,
-	.thaw		= pm_generic_thaw,
-	.poweroff	= pm_generic_poweroff,
-	.restore	= pm_generic_restore,
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(amba_pm_suspend_late, amba_pm_resume_early)
 	SET_RUNTIME_PM_OPS(
 		amba_pm_runtime_suspend,
 		amba_pm_runtime_resume,
Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -1636,14 +1636,15 @@ void pm_runtime_drop_link(struct device
  */
 int pm_runtime_force_suspend(struct device *dev)
 {
-	int (*callback)(struct device *);
+	int (*callback)(struct device *) = NULL;
 	int ret = 0;
 
 	pm_runtime_disable(dev);
 	if (pm_runtime_status_suspended(dev))
 		return 0;
 
-	callback = RPM_GET_CALLBACK(dev, runtime_suspend);
+	if (dev->driver && dev->driver->pm)
+		callback = dev->driver->pm->runtime_suspend;
 
 	if (!callback) {
 		ret = -ENOSYS;
@@ -1690,10 +1691,11 @@ EXPORT_SYMBOL_GPL(pm_runtime_force_suspe
  */
 int pm_runtime_force_resume(struct device *dev)
 {
-	int (*callback)(struct device *);
+	int (*callback)(struct device *) = NULL;
 	int ret = 0;
 
-	callback = RPM_GET_CALLBACK(dev, runtime_resume);
+	if (dev->driver && dev->driver->pm)
+		callback = dev->driver->pm->runtime_resume;
 
 	if (!callback) {
 		ret = -ENOSYS;

