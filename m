Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:36267 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754228AbbLDQeL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Dec 2015 11:34:11 -0500
Received: by igcph11 with SMTP id ph11so36331606igc.1
        for <linux-pci@vger.kernel.org>; Fri, 04 Dec 2015 08:34:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <564ECD3D.2080205@linux.intel.com>
References: <CALCETrV-S64Vi=QLhGNe_LZ78uPp-OhcZ8nM2KjDFn8+346=Nw@mail.gmail.com>
 <CALCETrWrq=G+sqwmZtnxL8HOe=y7CVNqX=r7nHtEdS7CtLnwBg@mail.gmail.com>
 <CALCETrWRa8ZOTQ8mWr0ZxLm6VWtHe3yd6RxtwrJ6Jw7=ewc_Zg@mail.gmail.com> <564ECD3D.2080205@linux.intel.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 4 Dec 2015 08:33:51 -0800
Message-ID: <CALCETrVWRDO-Hn49SN94UCy3z0PyPZtwsHOcricRVyPRABjNGA@mail.gmail.com>
Subject: Re: i2c_designware doesn't recover from subdevice driver unload
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 19, 2015 at 11:35 PM, Jarkko Nikula
<jarkko.nikula@linux.intel.com> wrote:
> Hi
>
>
> On 11/19/2015 10:39 PM, Andy Lutomirski wrote:
>>
>> On Thu, Nov 19, 2015 at 8:57 AM, Andy Lutomirski <luto@amacapital.net>
>> wrote:
>>>
>>> On Thu, Nov 19, 2015 at 7:56 AM, Andy Lutomirski <luto@kernel.org> wrote:
>>>>
>>>> I unloaded and reloaded hid_multitouch (on a Skylake laptop where the
>>>> HID device is behind an integrated designware controller) and I got:
>>>>
>>>> [39545.054684] i2c_hid i2c-DLL0704:01: failed to retrieve report from
>>>> device.
>>>> [39545.061728] i2c_designware i2c_designware.1:
>>>> i2c_dw_handle_tx_abort: lost arbitration
>>>> [39545.061734] i2c_hid i2c-DLL0704:01: failed to retrieve report from
>>>> device.
>>>> [39545.061944] i2c_hid i2c-DLL0704:01: failed to retrieve report from
>>>> device.
>>>> [39545.062373] i2c_hid i2c-DLL0704:01: error in i2c_hid_init_report
>>>> size:6 / ret_size:4
>>>> [39545.062564] i2c_hid i2c-DLL0704:01: failed to retrieve report from
>>>> device.
>>>> [39545.062636] input: DLL0704:01 06CB:76AE UNKNOWN as
>>>>
>>>> /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-7/i2c-DLL0704:01/0018:06CB:76AE.0005/input/input20
>>>> [39545.063212] hid-multitouch 0018:06CB:76AE.0005: input,hidraw1:
>>>> <UNKNOWN> HID v1.00 Mouse [DLL0704:01 06CB:76AE] on
>>>> [40178.534814] i2c_hid i2c-DLL0704:01: failed to retrieve report from
>>>> device.
>>>> [40178.541848] i2c_designware i2c_designware.1:
>>>> i2c_dw_handle_tx_abort: lost arbitration
>>>> [40178.541853] i2c_hid i2c-DLL0704:01: failed to retrieve report from
>>>> device.
>>>> [40179.542135] i2c_designware i2c_designware.1: controller timed out
>>>> [40179.542166] i2c_hid i2c-DLL0704:01: failed to retrieve report from
>>>> device.
>>>> [40180.542909] i2c_designware i2c_designware.1: controller timed out
>>>> [40180.542942] i2c_hid i2c-DLL0704:01: failed to retrieve report from
>>>> device.
>>>> [40181.543697] i2c_designware i2c_designware.1: controller timed out
>>>>
>>>> after that, I just keep seeing "controller timed out" messages.
>>>>
>>>> This is Linux 4.3.0.
>>>
>>>
>>> This just happened again (after a reboot) on its own without any
>>> rmmod.  Reloading the i2c_designware drivers didn't help, so I'm
>>> wondering if it's a bug lower in the stack instead.
>>>
> I guess this is either related to touch panel or bus timings (we have seen
> both cases recently) as it works here on development machine with another
> panel.
>
> Could you try does following commit from v4.4-rc1 help?
>
> 6d4f5440a3a2 ("HID: multitouch: Fetch feature reports on demand for Win8
> devices")

I've been running that commit for a couple weeks and I haven't seen
the problem recur.  Thanks!

--Andy
