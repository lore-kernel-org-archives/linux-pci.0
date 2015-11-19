Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:34361 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161388AbbKSUjf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Nov 2015 15:39:35 -0500
Received: by obbbj7 with SMTP id bj7so70184476obb.1
        for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2015 12:39:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CALCETrWrq=G+sqwmZtnxL8HOe=y7CVNqX=r7nHtEdS7CtLnwBg@mail.gmail.com>
References: <CALCETrV-S64Vi=QLhGNe_LZ78uPp-OhcZ8nM2KjDFn8+346=Nw@mail.gmail.com>
 <CALCETrWrq=G+sqwmZtnxL8HOe=y7CVNqX=r7nHtEdS7CtLnwBg@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 19 Nov 2015 12:39:15 -0800
Message-ID: <CALCETrWRa8ZOTQ8mWr0ZxLm6VWtHe3yd6RxtwrJ6Jw7=ewc_Zg@mail.gmail.com>
Subject: Re: i2c_designware doesn't recover from subdevice driver unload
To: Andy Lutomirski <luto@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 19, 2015 at 8:57 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Thu, Nov 19, 2015 at 7:56 AM, Andy Lutomirski <luto@kernel.org> wrote:
>> I unloaded and reloaded hid_multitouch (on a Skylake laptop where the
>> HID device is behind an integrated designware controller) and I got:
>>
>> [39545.054684] i2c_hid i2c-DLL0704:01: failed to retrieve report from device.
>> [39545.061728] i2c_designware i2c_designware.1:
>> i2c_dw_handle_tx_abort: lost arbitration
>> [39545.061734] i2c_hid i2c-DLL0704:01: failed to retrieve report from device.
>> [39545.061944] i2c_hid i2c-DLL0704:01: failed to retrieve report from device.
>> [39545.062373] i2c_hid i2c-DLL0704:01: error in i2c_hid_init_report
>> size:6 / ret_size:4
>> [39545.062564] i2c_hid i2c-DLL0704:01: failed to retrieve report from device.
>> [39545.062636] input: DLL0704:01 06CB:76AE UNKNOWN as
>> /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-7/i2c-DLL0704:01/0018:06CB:76AE.0005/input/input20
>> [39545.063212] hid-multitouch 0018:06CB:76AE.0005: input,hidraw1:
>> <UNKNOWN> HID v1.00 Mouse [DLL0704:01 06CB:76AE] on
>> [40178.534814] i2c_hid i2c-DLL0704:01: failed to retrieve report from device.
>> [40178.541848] i2c_designware i2c_designware.1:
>> i2c_dw_handle_tx_abort: lost arbitration
>> [40178.541853] i2c_hid i2c-DLL0704:01: failed to retrieve report from device.
>> [40179.542135] i2c_designware i2c_designware.1: controller timed out
>> [40179.542166] i2c_hid i2c-DLL0704:01: failed to retrieve report from device.
>> [40180.542909] i2c_designware i2c_designware.1: controller timed out
>> [40180.542942] i2c_hid i2c-DLL0704:01: failed to retrieve report from device.
>> [40181.543697] i2c_designware i2c_designware.1: controller timed out
>>
>> after that, I just keep seeing "controller timed out" messages.
>>
>> This is Linux 4.3.0.
>
> This just happened again (after a reboot) on its own without any
> rmmod.  Reloading the i2c_designware drivers didn't help, so I'm
> wondering if it's a bug lower in the stack instead.
>
> Reloading intel-lpss-acpi after the failure says:
>
> [  695.955911] idma64 idma64.0: Found Intel integrated DMA 64-bit
> [  695.966755] idma64 idma64.1: Found Intel integrated DMA 64-bit
> [  696.967468] i2c_designware i2c_designware.1: controller timed out
> [  696.967550] i2c_hid i2c-DLL0704:01: hid_descr_cmd failed
>
>
> This is a Dell XPS 13 9350.

I think the docs for all of this stuff are here:

https://download.01.org/future-platform-configuration-hub/skylake/register-definitions/332219-002.pdf

There's a reset register at offset 0x204 in I2C MMIO space.  Should
the driver be using it?

--Andy
