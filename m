Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33529 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758836Ab2JXVOH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Oct 2012 17:14:07 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so774272wgb.1
        for <linux-pci@vger.kernel.org>; Wed, 24 Oct 2012 14:14:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6817642.hqndXjdIQA@vostro.rjw.lan>
References: <50841CCC.9030809@uli-eckhardt.de> <5086D067.4000900@uli-eckhardt.de>
 <CAErSpo4TG8F94qkQzD7XrZnozBcTo3ZGdJsJ0PeLmCtpsU1MtA@mail.gmail.com> <6817642.hqndXjdIQA@vostro.rjw.lan>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 24 Oct 2012 15:13:45 -0600
Message-ID: <CAErSpo5cN5w=E8GYyKE=bX0=67Qk0g0wAW4vVFe0QfPGxo=+MA@mail.gmail.com>
Subject: Re: Unreliable USB3 with NEC uPD720200 and Delock Cardreader
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Ulrich Eckhardt <usb@uli-eckhardt.de>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	linux-pci@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 24, 2012 at 3:10 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Wednesday 24 of October 2012 14:18:40 Bjorn Helgaas wrote:
>> On Tue, Oct 23, 2012 at 11:14 AM, Ulrich Eckhardt <usb@uli-eckhardt.de> wrote:
>> > Am 23.10.2012 01:40, schrieb Sarah Sharp:
>> >> On Sun, Oct 21, 2012 at 06:03:24PM +0200, Ulrich Eckhardt wrote:
>> >
>> >>> I have tested it with Kernel 3.6.2. The USB3 port is the one built
>> >>> in the Mainboard M4A87DT EVO.
>> >>
>> >> Did a previous kernel version work?
>> >
>> > Yes, I tried the Kernel shipped with OpenSUSE (3.4.11) several 3.5 and all
>> > available 3.6 kernel versions.
>>
>> I assume you mean that every kernel you tried failed?  If some
>> kernel(s) did work, what is the newest working version and the oldest
>> broken version?
>>
>> > I attach the complete dmesg logs and the lspci -vv output as requested by
>> > Bjorn for the situations when the controller does not work after startup
>> > (extension notworking), when the controller is working (extension OK), and
>> > after stopping (extension stop).
>>
>> In the "notworking" logs, my guess is that the xHCI device is being
>> powered off.  The "notworking" lspci shows this:
>>
>>   00:0a.0 PCI bridge: Advanced Micro Devices [AMD] nee ATI RD790 PCI
>> to PCI bridge (PCI express gpp port F) (prog-if 00 [Normal decode])
>>         Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
>>                 LnkCap: Port #247, Speed 5GT/s, Width x2, ASPM L0s L1,
>> Latency L0 <64ns, L1 <1us
>>                 LnkSta: Speed unknown, Width x1, TrErr- Train-
>> SlotClk+ DLActive- BWMgmt+ ABWMgmt+
>>   04:00.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host
>> Controller (rev ff) (prog-if ff)
>>         !!! Unknown header type 7f
>>         Kernel driver in use: xhci_hcd
>>
>> The bridge's "DLActive-" means that the downstream link leading to the
>> xHCI device is not active.  The "rev ff", "prog-if ff", and "header
>> type 7f" suggest that we read all 0xff's from the xHCI device, which
>> is what we get if the device doesn't respond.
>>
>> The xHCI device must have been powered up and working originally,
>> because we enumerated it and bound the xhci_hcd driver to it.  I don't
>> have any ideas about why it would be powered off.
>>
>> Rafael, Alan, is there any way we can disable power management or
>> enable related debug messages?
>
> It can be disabled by writing "on" to the controller's
> /sys/devices/.../power/control file.

Ulrich, if you boot in the working situation and write "on" to the
control file as above, can you still reproduce the failure?

> For debug, there are trace points in rpm_suspend() and rpm_resume().

I don't know how to use those.  Is there a doc somewhere?
