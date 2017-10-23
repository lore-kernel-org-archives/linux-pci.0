Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
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
Subject: Re: [Update][PATCH v2 01/12] PM / core: Add NEVER_SKIP and SMART_PREPARE driver flags
Date: Mon, 23 Oct 2017 22:41:28 +0200
Message-ID: <30801783.UkqmB4d2t0@aspire.rjw.lan>
In-Reply-To: <CAPDyKFpYr-W8yni2_OEkYfx1T0=U_9Ru6NYxzBVoeRj253+Gxw@mail.gmail.com>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <11013815.Nxk07oyMGD@aspire.rjw.lan> <CAPDyKFpYr-W8yni2_OEkYfx1T0=U_9Ru6NYxzBVoeRj253+Gxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, October 23, 2017 6:37:41 PM CEST Ulf Hansson wrote:
> On 19 October 2017 at 01:17, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The motivation for this change is to provide a way to work around
> > a problem with the direct-complete mechanism used for avoiding
> > system suspend/resume handling for devices in runtime suspend.
> >
> > The problem is that some middle layer code (the PCI bus type and
> > the ACPI PM domain in particular) returns positive values from its
> > system suspend ->prepare callbacks regardless of whether the driver's
> > ->prepare returns a positive value or 0, which effectively prevents
> > drivers from being able to control the direct-complete feature.
> > Some drivers need that control, however, and the PCI bus type has
> > grown its own flag to deal with this issue, but since it is not
> > limited to PCI, it is better to address it by adding driver flags at
> > the core level.
> >
> > To that end, add a driver_flags field to struct dev_pm_info for flags
> > that can be set by device drivers at the probe time to inform the PM
> > core and/or bus types, PM domains and so on on the capabilities and/or
> > preferences of device drivers.  Also add two static inline helpers
> > for setting that field and testing it against a given set of flags
> > and make the driver core clear it automatically on driver remove
> > and probe failures.
> >
> > Define and document two PM driver flags related to the direct-
> > complete feature: NEVER_SKIP and SMART_PREPARE that can be used,
> > respectively, to indicate to the PM core that the direct-complete
> > mechanism should never be used for the device and to inform the
> > middle layer code (bus types, PM domains etc) that it can only
> > request the PM core to use the direct-complete mechanism for
> > the device (by returning a positive value from its ->prepare
> > callback) if it also has been requested by the driver.
> >
> > While at it, make the core check pm_runtime_suspended() when
> > setting power.direct_complete so that it doesn't need to be
> > checked by ->prepare callbacks.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > -> v2: Change the data type for driver_flags to u32 as suggested by Greg
> >        and fix a couple of documentation typos pointed out by Lukas.
> >
> > ---
> >  Documentation/driver-api/pm/devices.rst |   14 ++++++++++++++
> >  Documentation/power/pci.txt             |   19 +++++++++++++++++++
> >  drivers/acpi/device_pm.c                |    3 +++
> >  drivers/base/dd.c                       |    2 ++
> >  drivers/base/power/main.c               |    4 +++-
> >  drivers/pci/pci-driver.c                |    5 ++++-
> >  include/linux/device.h                  |   10 ++++++++++
> >  include/linux/pm.h                      |   20 ++++++++++++++++++++
> >  8 files changed, 75 insertions(+), 2 deletions(-)
> >
> > Index: linux-pm/include/linux/device.h
> > ===================================================================
> > --- linux-pm.orig/include/linux/device.h
> > +++ linux-pm/include/linux/device.h
> > @@ -1070,6 +1070,16 @@ static inline void dev_pm_syscore_device
> >  #endif
> >  }
> >
> > +static inline void dev_pm_set_driver_flags(struct device *dev, u32 flags)
> > +{
> > +       dev->power.driver_flags = flags;
> > +}
> > +
> > +static inline bool dev_pm_test_driver_flags(struct device *dev, u32 flags)
> > +{
> > +       return !!(dev->power.driver_flags & flags);
> > +}
> > +
> >  static inline void device_lock(struct device *dev)
> >  {
> >         mutex_lock(&dev->mutex);
> > Index: linux-pm/include/linux/pm.h
> > ===================================================================
> > --- linux-pm.orig/include/linux/pm.h
> > +++ linux-pm/include/linux/pm.h
> > @@ -550,6 +550,25 @@ struct pm_subsys_data {
> >  #endif
> >  };
> >
> > +/*
> > + * Driver flags to control system suspend/resume behavior.
> > + *
> > + * These flags can be set by device drivers at the probe time.  They need not be
> > + * cleared by the drivers as the driver core will take care of that.
> > + *
> > + * NEVER_SKIP: Do not skip system suspend/resume callbacks for the device.
> > + * SMART_PREPARE: Check the return value of the driver's ->prepare callback.
> > + *
> > + * Setting SMART_PREPARE instructs bus types and PM domains which may want
> > + * system suspend/resume callbacks to be skipped for the device to return 0 from
> > + * their ->prepare callbacks if the driver's ->prepare callback returns 0 (in
> > + * other words, the system suspend/resume callbacks can only be skipped for the
> > + * device if its driver doesn't object against that).  This flag has no effect
> > + * if NEVER_SKIP is set.
> 
> In principle ACPI/PCI middle-layer/PM domain could have started out by
> respecting the return values from driver's ->prepare() callbacks in
> case those existed, but they didn't, and that is the reason to why the
> SMART_PREPARE is needed. Right?
> 
> My point is, I don't think we should encourage other middle-layer to
> support the SMART_PREPARE flag, simply because they should be able to
> cope without it. To make this more obvious we could try to find a
> different name of the flag indicating that, or at least make it clear
> that we don't want it to be used by others than ACPI/PCI via
> documenting that.

I want it to be generic, though, so setting it should not be treated as a
mistake in any case (for example, because some drivers interact with the
ACPI PM domain and with some other middle layers).

If SMART_PREPARE simply overlaps with your defaul behavior, there's no need
to check the flag, but then it can be set really safely. :-)

> > + */
> > +#define DPM_FLAG_NEVER_SKIP    BIT(0)
> > +#define DPM_FLAG_SMART_PREPARE BIT(1)
> > +
> >  struct dev_pm_info {
> >         pm_message_t            power_state;
> >         unsigned int            can_wakeup:1;
> > @@ -561,6 +580,7 @@ struct dev_pm_info {
> >         bool                    is_late_suspended:1;
> >         bool                    early_init:1;   /* Owned by the PM core */
> >         bool                    direct_complete:1;      /* Owned by the PM core */
> > +       u32                     driver_flags;
> >         spinlock_t              lock;
> >  #ifdef CONFIG_PM_SLEEP
> >         struct list_head        entry;
> > Index: linux-pm/drivers/base/dd.c
> > ===================================================================
> > --- linux-pm.orig/drivers/base/dd.c
> > +++ linux-pm/drivers/base/dd.c
> > @@ -464,6 +464,7 @@ pinctrl_bind_failed:
> >         if (dev->pm_domain && dev->pm_domain->dismiss)
> >                 dev->pm_domain->dismiss(dev);
> >         pm_runtime_reinit(dev);
> > +       dev_pm_set_driver_flags(dev, 0);
> >
> >         switch (ret) {
> >         case -EPROBE_DEFER:
> > @@ -869,6 +870,7 @@ static void __device_release_driver(stru
> >                 if (dev->pm_domain && dev->pm_domain->dismiss)
> >                         dev->pm_domain->dismiss(dev);
> >                 pm_runtime_reinit(dev);
> > +               dev_pm_set_driver_flags(dev, 0);
> >
> >                 klist_remove(&dev->p->knode_driver);
> >                 device_pm_check_callbacks(dev);
> > Index: linux-pm/drivers/base/power/main.c
> > ===================================================================
> > --- linux-pm.orig/drivers/base/power/main.c
> > +++ linux-pm/drivers/base/power/main.c
> > @@ -1700,7 +1700,9 @@ unlock:
> >          * applies to suspend transitions, however.
> >          */
> >         spin_lock_irq(&dev->power.lock);
> > -       dev->power.direct_complete = ret > 0 && state.event == PM_EVENT_SUSPEND;
> > +       dev->power.direct_complete = state.event == PM_EVENT_SUSPEND &&
> > +               pm_runtime_suspended(dev) && ret > 0 &&
> > +               !dev_pm_test_driver_flags(dev, DPM_FLAG_NEVER_SKIP);
> >         spin_unlock_irq(&dev->power.lock);
> >         return 0;
> >  }
> > Index: linux-pm/drivers/pci/pci-driver.c
> > ===================================================================
> > --- linux-pm.orig/drivers/pci/pci-driver.c
> > +++ linux-pm/drivers/pci/pci-driver.c
> > @@ -682,8 +682,11 @@ static int pci_pm_prepare(struct device
> >
> >         if (drv && drv->pm && drv->pm->prepare) {
> >                 int error = drv->pm->prepare(dev);
> > -               if (error)
> > +               if (error < 0)
> >                         return error;
> > +
> > +               if (!error && dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_PREPARE))
> > +                       return 0;
> >         }
> >         return pci_dev_keep_suspended(to_pci_dev(dev));
> >  }
> > Index: linux-pm/drivers/acpi/device_pm.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/device_pm.c
> > +++ linux-pm/drivers/acpi/device_pm.c
> > @@ -965,6 +965,9 @@ int acpi_subsys_prepare(struct device *d
> >         if (ret < 0)
> >                 return ret;
> >
> > +       if (!ret && dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_PREPARE))
> > +               return 0;
> 
> So if the driver don't implement the ->prepare() callback, you still
> want to treat this flag as it has one assigned and that it returns 0?
> 
> It seems not entirely according to what you have documented about the flag.

You are right, I just should not use the _generic_prepare() thing there.

I'll send a fix patch for that.

> > +
> >         if (!adev || !pm_runtime_suspended(dev))
> >                 return 0;
> >
> > Index: linux-pm/Documentation/driver-api/pm/devices.rst
> > ===================================================================
> > --- linux-pm.orig/Documentation/driver-api/pm/devices.rst
> > +++ linux-pm/Documentation/driver-api/pm/devices.rst
> > @@ -354,6 +354,20 @@ the phases are: ``prepare``, ``suspend``
> >         is because all such devices are initially set to runtime-suspended with
> >         runtime PM disabled.
> >
> > +       This feature also can be controlled by device drivers by using the
> > +       ``DPM_FLAG_NEVER_SKIP`` and ``DPM_FLAG_SMART_PREPARE`` driver power
> > +       management flags.  [Typically, they are set at the time the driver is
> > +       probed against the device in question by passing them to the
> > +       :c:func:`dev_pm_set_driver_flags` helper function.]  If the first of
> > +       these flags is set, the PM core will not apply the direct-complete
> > +       procedure described above to the given device and, consequenty, to any
> > +       of its ancestors.  The second flag, when set, informs the middle layer
> > +       code (bus types, device types, PM domains, classes) that it should take
> > +       the return value of the ``->prepare`` callback provided by the driver
> > +       into account and it may only return a positive value from its own
> > +       ``->prepare`` callback if the driver's one also has returned a positive
> > +       value.
> > +
> >      2. The ``->suspend`` methods should quiesce the device to stop it from
> >         performing I/O.  They also may save the device registers and put it into
> >         the appropriate low-power state, depending on the bus type the device is
> > Index: linux-pm/Documentation/power/pci.txt
> > ===================================================================
> > --- linux-pm.orig/Documentation/power/pci.txt
> > +++ linux-pm/Documentation/power/pci.txt
> > @@ -961,6 +961,25 @@ dev_pm_ops to indicate that one suspend
> >  .suspend(), .freeze(), and .poweroff() members and one resume routine is to
> >  be pointed to by the .resume(), .thaw(), and .restore() members.
> >
> > +3.1.19. Driver Flags for Power Management
> > +
> > +The PM core allows device drivers to set flags that influence the handling of
> > +power management for the devices by the core itself and by middle layer code
> > +including the PCI bus type.  The flags should be set once at the driver probe
> > +time with the help of the dev_pm_set_driver_flags() function and they should not
> > +be updated directly afterwards.
> 
> I am wondering if we really need to make a statement generic to all
> "driver PM flags" that these flags must be set at ->probe(). Maybe
> that is better documented per flag, rather than for all. The reason
> why I bring it up, is that I would not be surprised if a new flag
> comes a long and which may be used a bit differently, not requiring
> that.
> 
> Of course we can also update that later on, if needed.

Right.

Thanks,
Rafael

