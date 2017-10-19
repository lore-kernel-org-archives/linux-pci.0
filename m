Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqq9_ZbPFYn22s+6sxtxePWgnd0GJNodeqkCKF2+QkrNA@mail.gmail.com>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <2890181.vdGMMavi5M@aspire.rjw.lan>
 <CAPDyKFozJtSHxxBEFtC+ofJ4XUyQjqUundPs81JATT=WfjXoYA@mail.gmail.com>
 <4337843.QuD5zygUhU@aspire.rjw.lan> <CAPDyKFqq9_ZbPFYn22s+6sxtxePWgnd0GJNodeqkCKF2+QkrNA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 19 Oct 2017 20:01:05 +0200
Message-ID: <CAPDyKFo2u3KDz-HbUOESPcEcqi-+K6AB8R4Yg_NfDg0nw4+4tQ@mail.gmail.com>
Subject: Re: [PATCH 0/12] PM / sleep: Driver flags for system suspend/resume
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[...]

>>> > Say you want to leave the parent suspended after system resume, but the
>>> > child drivers use pm_runtime_force_suspend|resume().  The parent would then
>>> > need to use pm_runtime_force_suspend|resume() too, no?
>>>
>>> Actually no.
>>>
>>> Currently the other options of "deferring resume" (not using
>>> pm_runtime_force_*), is either using the "direct_complete" path or
>>> similar to the approach you took for the i2c designware driver.
>>>
>>> Both cases should play nicely in combination of a child being managed
>>> by pm_runtime_force_*. That's because only when the parent device is
>>> kept runtime suspended during system suspend, resuming can be
>>> deferred.
>>
>> And because the parent remains in runtime suspend late enough in the
>> system suspend path, its children also are guaranteed to be suspended.
>
> Yes.
>
>>
>> But then all of them need to be left in runtime suspend during system
>> resume too, which is somewhat restrictive, because some drivers may
>> want their devices to be resumed then.
>
> Actually, this scenario is also addressed when using the pm_runtime_force_*.
>
> The driver for the child would only need to bump the runtime PM usage
> count (pm_runtime_get_noresume()) before calling
> pm_runtime_force_suspend() at system suspend. That then also
> propagates to the parent, leading to that both the parent and the
> child will be resumed when pm_runtime_force_resume() is called for
> them.

I need to correct myself here. The above currently only works if the
child is runtime resumed while pm_runtime_force_suspend() is called.

The logic in pm_runtime_force_* needs to be improved to take care of
such scenarios. However I think that should be rather easy to fix, if
we want that.

[...]

Kind regards
Uffe
