Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:5300 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758624AbbKTHfb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 20 Nov 2015 02:35:31 -0500
Subject: Re: i2c_designware doesn't recover from subdevice driver unload
To: Andy Lutomirski <luto@amacapital.net>,
	Andy Lutomirski <luto@kernel.org>
References: <CALCETrV-S64Vi=QLhGNe_LZ78uPp-OhcZ8nM2KjDFn8+346=Nw@mail.gmail.com>
 <CALCETrWrq=G+sqwmZtnxL8HOe=y7CVNqX=r7nHtEdS7CtLnwBg@mail.gmail.com>
 <CALCETrWRa8ZOTQ8mWr0ZxLm6VWtHe3yd6RxtwrJ6Jw7=ewc_Zg@mail.gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <564ECD3D.2080205@linux.intel.com>
Date: Fri, 20 Nov 2015 09:35:25 +0200
MIME-Version: 1.0
In-Reply-To: <CALCETrWRa8ZOTQ8mWr0ZxLm6VWtHe3yd6RxtwrJ6Jw7=ewc_Zg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi

On 11/19/2015 10:39 PM, Andy Lutomirski wrote:
> On Thu, Nov 19, 2015 at 8:57 AM, Andy Lutomirski <luto@amacapital.net> wrote:
>> On Thu, Nov 19, 2015 at 7:56 AM, Andy Lutomirski <luto@kernel.org> wrote:
>>> I unloaded and reloaded hid_multitouch (on a Skylake laptop where the
>>> HID device is behind an integrated designware controller) and I got:
>>>
>>> [39545.054684] i2c_hid i2c-DLL0704:01: failed to retrieve report from device.
>>> [39545.061728] i2c_designware i2c_designware.1:
>>> i2c_dw_handle_tx_abort: lost arbitration
>>> [39545.061734] i2c_hid i2c-DLL0704:01: failed to retrieve report from device.
>>> [39545.061944] i2c_hid i2c-DLL0704:01: failed to retrieve report from device.
>>> [39545.062373] i2c_hid i2c-DLL0704:01: error in i2c_hid_init_report
>>> size:6 / ret_size:4
>>> [39545.062564] i2c_hid i2c-DLL0704:01: failed to retrieve report from device.
>>> [39545.062636] input: DLL0704:01 06CB:76AE UNKNOWN as
>>> /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-7/i2c-DLL0704:01/0018:06CB:76AE.0005/input/input20
>>> [39545.063212] hid-multitouch 0018:06CB:76AE.0005: input,hidraw1:
>>> <UNKNOWN> HID v1.00 Mouse [DLL0704:01 06CB:76AE] on
>>> [40178.534814] i2c_hid i2c-DLL0704:01: failed to retrieve report from device.
>>> [40178.541848] i2c_designware i2c_designware.1:
>>> i2c_dw_handle_tx_abort: lost arbitration
>>> [40178.541853] i2c_hid i2c-DLL0704:01: failed to retrieve report from device.
>>> [40179.542135] i2c_designware i2c_designware.1: controller timed out
>>> [40179.542166] i2c_hid i2c-DLL0704:01: failed to retrieve report from device.
>>> [40180.542909] i2c_designware i2c_designware.1: controller timed out
>>> [40180.542942] i2c_hid i2c-DLL0704:01: failed to retrieve report from device.
>>> [40181.543697] i2c_designware i2c_designware.1: controller timed out
>>>
>>> after that, I just keep seeing "controller timed out" messages.
>>>
>>> This is Linux 4.3.0.
>>
>> This just happened again (after a reboot) on its own without any
>> rmmod.  Reloading the i2c_designware drivers didn't help, so I'm
>> wondering if it's a bug lower in the stack instead.
>>
I guess this is either related to touch panel or bus timings (we have 
seen both cases recently) as it works here on development machine with 
another panel.

Could you try does following commit from v4.4-rc1 help?

6d4f5440a3a2 ("HID: multitouch: Fetch feature reports on demand for Win8 
devices")

> I think the docs for all of this stuff are here:
>
> https://download.01.org/future-platform-configuration-hub/skylake/register-definitions/332219-002.pdf
>
Yes, this is the right document for Skylake.

> There's a reset register at offset 0x204 in I2C MMIO space.  Should
> the driver be using it?
>
We use it in probe and resume paths in drivers/mfd/intel-lpss.c which 
manages these LPSS host controller (UART/SPI/I2C) + integrated DMA 
engine compound devices.

-- 
Jarkko
