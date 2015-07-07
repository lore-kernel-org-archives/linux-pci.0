Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:52267 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932391AbbGGSNN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jul 2015 14:13:13 -0400
Message-ID: <559C16B0.6060909@roeck-us.net>
Date: Tue, 07 Jul 2015 11:13:04 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	Will Deacon <Will.Deacon@arm.com>
Subject: Re: [PATCH] PCI: Only enable IO window if supported
References: <1432342336-25832-1-git-send-email-linux@roeck-us.net> <20150527210447.GY32152@google.com> <20150528022332.GA23724@roeck-us.net> <20150528124112.GJ10210@google.com> <20150618180103.GA23809@roeck-us.net> <20150619162413.GA21533@red-moon> <20150707144019.GH4379@red-moon> <559BE9D9.4050407@roeck-us.net> <20150707172818.GA930@red-moon>
In-Reply-To: <20150707172818.GA930@red-moon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/07/2015 10:28 AM, Lorenzo Pieralisi wrote:
> On Tue, Jul 07, 2015 at 04:01:45PM +0100, Guenter Roeck wrote:
>> Hi Lorenzo,
>>
>> On 07/07/2015 07:40 AM, Lorenzo Pieralisi wrote:
>>> On Fri, Jun 19, 2015 at 05:24:13PM +0100, Lorenzo Pieralisi wrote:
>>>> Hi Guenter,
>>>>
>>>> On Thu, Jun 18, 2015 at 07:01:03PM +0100, Guenter Roeck wrote:
>>>>> On Thu, May 28, 2015 at 07:41:12AM -0500, Bjorn Helgaas wrote:
>>>>>>
>>>>>>>> I'd like res->flags to reflect the capabilities of the hardware, not
>>>>>>>> whether the window is currently enabled.
>>>>>>>>
>>>>>>> Flag bits seem to be all taken. Could we use IORESOURCE_DISABLED for that
>>>>>>> purpose, or could that cause conflicts elsewhere ?
>>>>>>
>>>>>> Yes, I think IORESOURCE_DISABLED would be appropriate for any I/O windows
>>>>>> below a host bridge that doesn't support I/O space.
>>>>>>
>>>>> I integrated Lorenzo's patch and tried to get this working.
>>>>
>>>> Thanks. How do you want to proceed with this ? Are you taking my patch
>>>> and post it along with your updated series ? We need to extend test
>>>> coverage to platforms we could not test on, as you know my series
>>>> affects all archs but SPARC (I mean it should *not* affect them, this
>>>> has to be tested though, I do not have the HW needed, your coverage
>>>> for x86 and PowerPC is great but I do not think it can be deemed
>>>> sufficient).
>>>>
>>>> Please let me know, thanks !
>>>
>>> Any comment on this ? I will have to remove the bridge resource claiming
>>> from my patch according to Ben's concerns for PowerPC, which requires
>>> a v3.
>>>
>>> How do you want me to go on with this ?
>>>
>>
>> Can you send your v3 ?
>
> Yes, I have to figure out though where I can claim bridge resources
> on PROBE_ONLY arm/arm64 systems, which is proving interesting, anyway
> I will send it out asap.
>
>> I didn't submit my latest version because I recalled Ben's objections,
>> and I never got around asking you if you plan to send a new version
>> of your patch.
>
> No worries, let's get this sorted.
>
>> I had to drop the idea of using IORESOURCE_DISABLED; pretty much all
>> kernel code uses the "!flags" test to identify unused resources.
>> I tried to change that, but just could not get it to work.
>> I ended up introducing a new bus flag instead, PCI_BUS_FLAGS_NO_IO,
>> which works quite nicely since it propagates to child buses.
>
> Ok, great, I can test it too.
>

I just sent out the curent version of my patch as RFC to get some feedback.
I'll be out of the office for the next two weeks, so I won't be able
to do much if any testing during that time. So take time for your v3.

Thanks,
Guenter

