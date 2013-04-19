Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:60289 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498Ab3DSPtp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Apr 2013 11:49:45 -0400
Received: by mail-oa0-f53.google.com with SMTP id m6so3979322oag.26
        for <linux-pci@vger.kernel.org>; Fri, 19 Apr 2013 08:49:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5170B9BD.6040408@huawei.com>
References: <SNT136-W425B9A4DBEA719E570080DB2C80@phx.gbl> <5170B9BD.6040408@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 19 Apr 2013 09:49:23 -0600
Message-ID: <CAErSpo43xWdYE8MT9Y4Hdi0bkNh3D4Su6zThAVs72+nYiUD5qg@mail.gmail.com>
Subject: Re: Rescan PCIE bus to find recently powered on device.
To: Yijing Wang <wangyijing@huawei.com>
Cc: Frank Rizzo <thefrankrizzo@hotmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 18, 2013 at 9:27 PM, Yijing Wang <wangyijing@huawei.com> wrote:
> On 2013/4/19 10:59, Frank Rizzo wrote:
>> Hey list.
>>
>> I'm working on a driver for a device that's external from the PC.  It's connected to the PC via a weird cable that connects to a PCIE card inside the case that appears to be nothing other than glue logic to allow the signals from the cable to be tossed onto the bus.

The card probably contains a PCIe switch with the downstream link
being routed on the cable.

>>
>> When the external device is powered off during boot, nothing is found.  hwinfo doesn't find it, lspci doesn't find it, etc.

That's completely normal, of course.  When the device is powered off,
it doesn't respond, so we can't find it.

>> If you power on the device BEFORE booting, everything is found, and it works fine.

Also normal.

>> And lastly, if you power it on AFTER Linux has booted, you still can't find it.  I've tried echoing "1" to rescan, and everything else that I could find via Google search.
>>
>> So, what are my options here?  I'm not allergic to adding code to the driver to scan for the device periodically, if I knew HOW to find it.  And, once found, how do I get it registered?
>>
>
> When your device power off during boot, system maybe will not reserve resource like bus res for your device. So when you power on your device after system boot,
> system cannot scan your device by rescan interface, I guess.

I think Yijing is right; this is probably a resource allocation
problem.  Linux isn't smart enough to reassign bus numbers, MMIO
address space, or I/O port numbers at run-time, so if we didn't leave
space at boot-time to accommodate the new device, we won't be able to
use it.

I think your best option is to reserve space at boot-time.  The
"pci=hpmemsize=..." and "pci=hpiosize=..." parameters might be useful,
but since it sounds like we can't find the device at all, it's more
likely that bus number space is the problem, and we don't have a
parameter to reserve that.

If you collect "lspci -vv" output (when device was powered on before
boot) and complete dmesg logs (both from when device was powered on
before boot and when it was powered off at boot), we should be able to
figure out exactly what the problem is.

Bjorn
