Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v2 1/6] PM / core: Add LEAVE_SUSPENDED driver flag
Date: Wed, 15 Nov 2017 02:48:30 +0100
Message-ID: <2655595.bSA6msl5Qp@aspire.rjw.lan>
In-Reply-To: <CAPDyKFr4DgVdKtf=G1vUy=Si0nSTECsrWoqB+z9UCQHS8DuwcQ@mail.gmail.com>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <CAJZ5v0i4yFGyqAZ6QqG7q1_xNfjMNHkPk3o0WuBvwKFeM2nXeg@mail.gmail.com> <CAPDyKFr4DgVdKtf=G1vUy=Si0nSTECsrWoqB+z9UCQHS8DuwcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, November 14, 2017 5:07:59 PM CET Ulf Hansson wrote:
> On 11 November 2017 at 00:45, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Fri, Nov 10, 2017 at 10:09 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >> On 8 November 2017 at 14:25, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> Define and document a new driver flag, DPM_FLAG_LEAVE_SUSPENDED, to
> >>> instruct the PM core and middle-layer (bus type, PM domain, etc.)
> >>> code that it is desirable to leave the device in runtime suspend
> >>> after system-wide transitions to the working state (for example,
> >>> the device may be slow to resume and it may be better to avoid
> >>> resuming it right away).
> >>>
> >>> Generally, the middle-layer code involved in the handling of the
> >>> device is expected to indicate to the PM core whether or not the
> >>> device may be left in suspend with the help of the device's
> >>> power.may_skip_resume status bit.  That has to happen in the "noirq"
> >>> phase of the preceding system suspend (or analogous) transition.
> >>> The middle layer is then responsible for handling the device as
> >>> appropriate in its "noirq" resume callback which is executed
> >>> regardless of whether or not the device may be left suspended, but
> >>> the other resume callbacks (except for ->complete) will be skipped
> >>> automatically by the core if the device really can be left in
> >>> suspend.
> >>
> >> I don't understand the reason to why you need to skip invoking resume
> >> callbacks to achieve this behavior, could you elaborate on that?
> >
> > The reason why it is done this way is because that takes less code and
> > is easier (or at least less error-prone, because it avoids repeating
> > patterns in middle layers).
> >
> > Note that the callbacks only may be skipped by the core if the middle
> > layer has set power.skip_resume for the device (or if the core is
> > handling it in patch [5/6], but that's one more step ahead still).
> >
> >> Couldn't the PM domain or the middle-layer instead decide what to do?
> >
> > They still can, the whole thing is a total opt-in.
> >
> > But to be constructive, do you have any specific examples in mind?
> 
> See more below.
> 
> >
> >> To me it sounds a bit prone to errors by skipping callbacks from the
> >> PM core, and I wonder if the general driver author will be able to
> >> understand how to use this flag properly.
> >
> > This has nothing to do with general driver authors and I'm not sure
> > what you mean here and where you are going with this.
> 
> Let me elaborate.
> 
> My general goal is that I want to make it easier (or as easy as
> possible) for the general driver author to deploy runtime PM and
> system-wide PM support - in an optimized manner. Therefore, I am
> pondering over the solution you picked in this series, trying to
> understand how it fits into those aspects.
> 
> Particular I am a bit worried from a complexity point of view, about
> the part with skipping callbacks from the PM core. We have observed
> some difficulties with the direct_complete path (i2c dw driver), which
> is based on a similar approach as this one.

These are resume callbacks, not suspend callbacks.  Also not all of them
are skipped.  That is quite a bit different from skipping *all* callbacks.

Moreover, at the point the core decides to skip the callbacks, the device
*has* *to* be left suspended and there simply is no point in running them
no matter what.

That part of code can be trivially moved to middle layers, but then each
of them will have to do exactly the same thing.  I don't see any reason to
do that and I'm not finding one in your comments.  Sorry.

> Additionally, in this case, to trigger skipping of callbacks to
> happen, first, drivers needs to inform the middle-layer, second, the
> middle layer acts on that information and then informs the PM core,
> then in the third step, the PM core can decide what to do. It doesn't
> sound straight-forward.

It really doesn't work like that.

First, the driver sets the LEAVE_SUSPENDED flag for the core to consume.
The middle layers don't have to look at it at all.

Second, each middle layer sets power.may_skip_resume for devices whose
state after system suspend should match the runtime suspend state.  The
middle layer must know that this is the case to set that bit.  [The core
effectively does that part for devices handled by it directly in patch
[5/6].]

The core then takes the LEAVE_SUSPENDED flags, power.may_skip_resume bits,
status of the children and consumers into account in order to produce the
power.must_resume bits and those are used (later) to decide whether or not
to resume the devices.  That decision is made by the core and so the core
acts on it and the middle layers must follow.

> I guess I need to be convinced that this new approach is going to be
> better than the the direct_complete path, so it somehow can replace it
> along the road. Otherwise, we may end up just having yet another way
> of skipping callbacks in the PM core and I don't like that.

Well, this works the other way around this time, I'm afraid.  At this point
you need to convince me that the approach has real issues. :-)

> Of course, I also realize this hole thing is opt-in, so nothing will
> break and we are all good. :-)
> 
> >
> >> That said, as the series don't include any changes for drivers making
> >> use of the flag, could please fold in such change as it would provide
> >> a more complete picture?
> >
> > I've already done so, see https://patchwork.kernel.org/patch/10007349/
> >
> > IMHO it's not really useful to drag this stuff (which doesn't change
> > BTW) along with every iteration of the core patches.
> 
> Well, to me it's useful because it shows how these flags can/will be used.
> 
> Anyway, I thought you scraped that patch and was working on a new
> version. I will have a look then.
> 
> [...]
> 
> >>>   * device_resume_noirq - Execute a "noirq resume" callback for given device.
> >>>   * @dev: Device to handle.
> >>>   * @state: PM transition of the system being carried out.
> >>> @@ -575,6 +587,12 @@ static int device_resume_noirq(struct de
> >>>         error = dpm_run_callback(callback, dev, state, info);
> >>>         dev->power.is_noirq_suspended = false;
> >>>
> >>> +       if (dev_pm_may_skip_resume(dev)) {
> >>> +               pm_runtime_set_suspended(dev);
> >>
> >> According to the doc, the DPM_FLAG_LEAVE_SUSPENDED intends to leave
> >> the device in runtime suspend state during system resume.
> >> However, here you are actually trying to change its runtime PM state to that.
> >
> > So the doc needs to be fixed. :-)
> 
> Yep.
> 
> >
> > But I'm guessing that this just is a misunderstanding and you mean the
> > phrase "it may be desirable to leave some devices in runtime suspend
> > after [...]".  Yes, it is talking about "runtime suspend", but
> > actually "runtime suspend" is the only kind of "suspend" you can leave
> > a device in after a system transition to the working state.  It never
> > says that the device must have been suspended before the preceding
> > system transition into a sleep state started.
> 
> My point is, it's isn't obvious why you need to make sure the device's
> runtime PM status is set to "RPM_SUSPENDED" when leaving the resume
> noirq phase. You did explain that somewhat above, thanks!
> 
> Perhaps you could fold in some of that information into the doc as well?

The doc doesn't describe the design of the code, though.

I guess I'll just add a comment at the point where the status changes.

> >
> >> Moreover, you should check the return value from
> >> pm_runtime_set_suspended().
> >
> > This is in "noirq", so failures of that are meaningless here.
> >
> >> Then I wonder, what should you do when it fails here?
> >>
> >> Perhaps a better idea is to do this in the noirq suspend phase,
> >> because it allows you to bail out in case pm_runtime_set_suspended()
> >> fails.
> >
> > This doesn't make sense, sorry.
> 
> What do you mean by "failures of that are meaningless here."?

If all devices have runtime PM disabled, pm_runtime_set_suspended() should
just do what it is asked for unless called with an invalid argument or
similar.

> I was suggesting, instead of calling pm_runtime_set_suspended() in the
> noirq *resume* phase, why can't you do that in the noirq *suspend*
> phase?
> 
> In the noirq *suspend* phase it's not too late to deal with errors!? Or is it?

At that point it has not been decided whether or not the devices will stay
suspended yet.  The status cannot be changed before making that decision,
which only happens in the noirq resume phase.

Thanks,
Rafael

