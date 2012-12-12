Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:58360 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819Ab2LLF41 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Dec 2012 00:56:27 -0500
MIME-Version: 1.0
In-Reply-To: <CAObL_7Fn7Z_0vhZ+RfC-L=+OKqkRpxo6i0wftKfncSwrmb567w@mail.gmail.com>
References: <20121126191002.GE6504@xanatos>
	<1962497.aG1sFtYjJG@vostro.rjw.lan>
	<20121207002808.GG5324@xanatos>
	<7766249.mqYLvmhmrJ@vostro.rjw.lan>
	<1355279525.7216.154.camel@yhuang-dev>
	<CAObL_7Fn7Z_0vhZ+RfC-L=+OKqkRpxo6i0wftKfncSwrmb567w@mail.gmail.com>
Date: Wed, 12 Dec 2012 11:18:56 +0800
Message-ID: <CAC=cRTP+2gnSfKw8k2JtLLUWxe=4hhRrMtsNXQ31TQePUnxJSg@mail.gmail.com>
Subject: Re: Unreliable USB3 with NEC uPD720200 and Delock Cardreader
From: huang ying <huang.ying.caritas@gmail.com>
To: Andrew Lutomirski <luto@mit.edu>
Cc: Huang Ying <ying.huang@intel.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	Ulrich Eckhardt <usb@uli-eckhardt.de>,
	=?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Ming Lei <ming.lei@canonical.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 12, 2012 at 10:34 AM, Andrew Lutomirski <luto@mit.edu> wrote:
> On Tue, Dec 11, 2012 at 6:32 PM, Huang Ying <ying.huang@intel.com> wrote:
>> On Fri, 2012-12-07 at 22:00 +0100, Rafael J. Wysocki wrote:
>>> On Thursday, December 06, 2012 04:28:08 PM Sarah Sharp wrote:
>>> > On Thu, Dec 06, 2012 at 01:43:32AM +0100, Rafael J. Wysocki wrote:
>>> > > On Wednesday, December 05, 2012 04:33:44 PM Sarah Sharp wrote:
>>> > > > Wakeup from D3 works fine on the 3.5.0 kernel, but fails on 3.6.2.  I
>>> > > > haven't fully bisected yet.
>>> > > >
>>> > > > In debugging, I found that if you only enable runtime suspend for the
>>> > > > NEC host controller, the host successfully comes out of D3 when you plug
>>> > > > in a USB device.  However, if you enable runtime PM for the parent PCIe root
>>> > > > port, it stops working.  Disabling D3cold for both devices did not help.
>>> > > >
>>> > > > It looks like a PCI issue, so what sort of debugging info do you need
>>> > > > from me?
>>> > >
>>> > > It looks like this is related to one of the following commits:
>>> >
>>> > > Generally, please try to bisect changes in drivers/pci between v3.5 and v3.6.
>>> >
>>> > Ok, I ran git bisect with only the drivers/pci directory as a target.
>>> >
>>> > > ee85f54 ACPI/PM: specify lowest allowed state for device sleep state
>>> >
>>> > git bisect ended up identifying this as the bad patch, although
>>> > reverting just that patch after the bisect finished didn't seem to help.
>>> > However, it does make sense that this would be the culprit patch, if
>>> > Huang Ying's theory about the PME polling is correct.
>>>
>>> Well, we surely don't handle this particular case correctly, and it shouldn't
>>> be very difficult to fix, so let's hope that this is the culprit. :-)
>>>
>>
>> Please try the patch attached.  With it, USB host controller can be
>> waken up with USB card reader plugging in on my test machine.
>
> Potentially silly question: is this better than waking up the PCIe
> port when polling the device (and putting it back to sleep again)?

Put PCI devices into/out of low power state can be very time
consuming.  For D3hot, it is at least 20ms, and for D3cold, it is at
least 200ms.

Best Regards,
Huang Ying
