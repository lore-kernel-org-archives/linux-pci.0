Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <fa2647cb-b043-0116-8129-cb035e03cb2c@ti.com>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <CAPDyKFozJtSHxxBEFtC+ofJ4XUyQjqUundPs81JATT=WfjXoYA@mail.gmail.com>
 <7b9c2a3e-2e88-938e-46a5-703de0080681@ti.com> <2926646.NJduVklg7n@aspire.rjw.lan>
 <CAPDyKFrFbdXrZqtvwm=xmJSqQckfGzs7XNn7AOCTbOjwP4iAFQ@mail.gmail.com>
 <1769d82f-07d3-14c9-c06a-d6afec20fa0e@ti.com> <CAPDyKFoAKguKiwnJu6zQF7F-w5AQ+mQoQq_XbNOQrys+c54Jhw@mail.gmail.com>
 <CAPDyKFrtQO_rowO8q=7Lsb25x8+bQAJyc1yUYVRgiguG-2W0tA@mail.gmail.com> <fa2647cb-b043-0116-8129-cb035e03cb2c@ti.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 20 Oct 2017 08:05:17 +0200
Message-ID: <CAPDyKFptOc2w-5gXVtzt=fp1cRta3KyLssaGbTe0koV4kNaD=A@mail.gmail.com>
Subject: Re: [PATCH 0/12] PM / sleep: Driver flags for system suspend/resume
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

>>>>> In this regards as we consider genpd being a trivial PM domain, those
>>>>> examples your bring up above is too me also examples of trivial PM
>>>>> domains. Especially because they don't deal with wakeups, as that is
>>>>> taken care of by the drivers, right!?
>>>>
>>>> Not directly, for example, omap device framework has noirq callback implemented
>>>> which forcibly disable all devices which are not PM runtime suspended.
>>>> while doing this it calls drivers PM .runtime_suspend() which may return
>>>> non 0 value and in this case device will be left enabled (powered) at suspend for
>>>> wake up purposes (see _od_suspend_noirq()).
>>>>
>>>
>>> Yeah, I had that feeling that omap has some trickyness going on. :-)
>>>
>>> I sure that can be fixed in the omap PM domain, although
>>
>> ...slipped with my fingers.. here is the rest of the reply...
>>
>> ..of course that require us to use another way for drivers to signal
>> to the omap PM domain that it needs to stay powered as to deal with
>> wakeup.
>>
>> I can have a look at that more closely, to see if it makes sense to change.
>>
>
> Also, additional note here. some IPs are reused between OMAP/Davinci/Keystone,
> OMAP PM domain have some code running at noirq time to dial with devices left
> in PM runtime enabled state (OMAP PM runtime centric), while Davinci/Keystone haven't (clock_ops.c),
> so pm_runtime_force_* API is actually possibility now to make the same driver work
>  on all these platforms.

That sounds great!

Also, in the end it would be nice to also convert the OMAP PM domain
to genpd. I think most of the needed infrastructure is already there
to do that.

Kind regards
Uffe
