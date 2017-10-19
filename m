Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH 0/12] PM / sleep: Driver flags for system suspend/resume
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Linux PM <linux-pm@vger.kernel.org>,
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
References: <3806130.B2KCK0tvef@aspire.rjw.lan>
 <CAPDyKFozJtSHxxBEFtC+ofJ4XUyQjqUundPs81JATT=WfjXoYA@mail.gmail.com>
 <7b9c2a3e-2e88-938e-46a5-703de0080681@ti.com>
 <2926646.NJduVklg7n@aspire.rjw.lan>
 <CAPDyKFrFbdXrZqtvwm=xmJSqQckfGzs7XNn7AOCTbOjwP4iAFQ@mail.gmail.com>
 <1769d82f-07d3-14c9-c06a-d6afec20fa0e@ti.com>
 <CAPDyKFoAKguKiwnJu6zQF7F-w5AQ+mQoQq_XbNOQrys+c54Jhw@mail.gmail.com>
 <CAPDyKFrtQO_rowO8q=7Lsb25x8+bQAJyc1yUYVRgiguG-2W0tA@mail.gmail.com>
From: Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <fa2647cb-b043-0116-8129-cb035e03cb2c@ti.com>
Date: Thu, 19 Oct 2017 16:31:32 -0500
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrtQO_rowO8q=7Lsb25x8+bQAJyc1yUYVRgiguG-2W0tA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 10/19/2017 01:11 PM, Ulf Hansson wrote:
> On 19 October 2017 at 20:04, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 19 October 2017 at 19:21, Grygorii Strashko <grygorii.strashko@ti.com> wrote:
>>>
>>>
>>> On 10/19/2017 03:33 AM, Ulf Hansson wrote:
>>>> On 18 October 2017 at 23:48, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>>>> On Wednesday, October 18, 2017 9:45:11 PM CEST Grygorii Strashko wrote:
>>>>>>
>>>>>> On 10/18/2017 09:11 AM, Ulf Hansson wrote:
>>>>>
>>>>> [...]
>>>>>
>>>>>>>>> That's the point. We know pm_runtime_force_* works nicely for the
>>>>>>>>> trivial middle-layer cases.
>>>>>>>>
>>>>>>>> In which cases the middle-layer callbacks don't exist, so it's just like
>>>>>>>> reusing driver callbacks directly. :-)
>>>>>>
>>>>>> I'd like to ask you clarify one point here and provide some info which I hope can be useful -
>>>>>> what's exactly means  "trivial middle-layer cases"?
>>>>>>
>>>>>> Is it when systems use "drivers/base/power/clock_ops.c - Generic clock
>>>>>> manipulation PM callbacks" as dev_pm_domain (arm davinci/keystone), or OMAP
>>>>>> device framework struct dev_pm_domain omap_device_pm_domain
>>>>>> (arm/mach-omap2/omap_device.c) or static const struct dev_pm_ops
>>>>>> tegra_aconnect_pm_ops?
>>>>>>
>>>>>> if yes all above have PM runtime callbacks.
>>>>>
>>>>> Trivial ones don't actually do anything meaningful in their PM callbacks.
>>>>>
>>>>> Things like the platform bus type, spi bus type, i2c bus type and similar.
>>>>>
>>>>> If the middle-layer callbacks manipulate devices in a significant way, then
>>>>> they aren't trivial.
>>>>
>>>> I fully agree with Rafael's description above, but let me also clarify
>>>> one more thing.
>>>>
>>>> We have also been discussing PM domains as being trivial and
>>>> non-trivial. In some statements I even think the PM domain has been a
>>>> part the middle-layer terminology, which may have been a bit
>>>> confusing.
>>>>
>>>> In this regards as we consider genpd being a trivial PM domain, those
>>>> examples your bring up above is too me also examples of trivial PM
>>>> domains. Especially because they don't deal with wakeups, as that is
>>>> taken care of by the drivers, right!?
>>>
>>> Not directly, for example, omap device framework has noirq callback implemented
>>> which forcibly disable all devices which are not PM runtime suspended.
>>> while doing this it calls drivers PM .runtime_suspend() which may return
>>> non 0 value and in this case device will be left enabled (powered) at suspend for
>>> wake up purposes (see _od_suspend_noirq()).
>>>
>>
>> Yeah, I had that feeling that omap has some trickyness going on. :-)
>>
>> I sure that can be fixed in the omap PM domain, although
> 
> ...slipped with my fingers.. here is the rest of the reply...
> 
> ..of course that require us to use another way for drivers to signal
> to the omap PM domain that it needs to stay powered as to deal with
> wakeup.
> 
> I can have a look at that more closely, to see if it makes sense to change.
> 

Also, additional note here. some IPs are reused between OMAP/Davinci/Keystone,
OMAP PM domain have some code running at noirq time to dial with devices left
in PM runtime enabled state (OMAP PM runtime centric), while Davinci/Keystone haven't (clock_ops.c),
so pm_runtime_force_* API is actually possibility now to make the same driver work 
 on all these platforms. 

-- 
regards,
-grygorii
