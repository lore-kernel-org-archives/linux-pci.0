Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:44206 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755980Ab2JZJcG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 26 Oct 2012 05:32:06 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so1990489wgb.1
        for <linux-pci@vger.kernel.org>; Fri, 26 Oct 2012 02:32:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <508A544F.1030007@peak-system.com>
References: <5062BA8B.7090503@peak-system.com> <CAErSpo7vk6d1RCWQPFL9PqqwbH5u+F=uyPywCM_3sAVF3RW34g@mail.gmail.com>
 <508A544F.1030007@peak-system.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 26 Oct 2012 03:31:44 -0600
Message-ID: <CAErSpo4GFn_xSzMb7Y8cR+oJUT4LPi046zJs5iLUY0cp2c85zQ@mail.gmail.com>
Subject: Re: Info about ACPI/PCI vs ISA
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-acpi@vger.kernel.org, support@peak-system.com,
	Robert Hancock <hancockrwd@gmail.com>,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 26, 2012 at 3:13 AM, Stephane Grosjean
<s.grosjean@peak-system.com> wrote:
> Hi Bjorn,
>
> Thanks for your answer. See my comments below...
>
> Le 26/10/2012 10:29, Bjorn Helgaas a écrit :
>>
>> On Wed, Sep 26, 2012 at 2:19 AM, Stephane Grosjean
>> <s.grosjean@peak-system.com> wrote:
>>
>>> I'm working on an issue with one of our PCI adapters.
>>> This PCI adapter is a standard and well proven board, for many years:
>>>
>>> $ lspci -v
>>> ...
>>> 04:08.0 Network controller: PEAK-System Technik GmbH PCAN-PCI CAN-Bus
>>> controller (rev 02)
>>>      Subsystem: PEAK-System Technik GmbH 2 Channel CAN Bus SJC1000
>>>      Flags: medium devsel, IRQ 11
>>>      Memory at f0410000 (32-bit, non-prefetchable) [size=64K]
>>>      Memory at f0400000 (32-bit, non-prefetchable) [size=64K]
>>>      Kernel driver in use: pcan
>>>
>>>
>> Where's the source for the "pcan" driver?  I see the pcan_usb driver
>> in the tree, but that looks like something different from what you're
>> looking at here.
>
>
> The "pcan" driver is an out-ot-tree driver which offers a chardev interface,
> not a mainline driver. The "pcan_usb" (as well as peak_pci...) are our
> recent linux-can (only) drivers.
> Since the "pcan" driver does exist since the old ages of 2.4 kernels, we
> need to continue to support it. See also below for more information about
> that...
>
>> Does the device work under any version of Linux?  If so, please
>> collect the complete dmesg log from the newest working version, and
>> the same log from the broken version.
>
>
> Yes it does! Anyway, you'll find the complete dmesg.txt attached to that
> e-mail. Hoping this could help.

Thanks.  You attached the log for the broken version.  Can you also
attach a log from the newest working version of Linux?

I assume the same driver works on the old version but fails on new
versions.  If so, it sounds like this might be a Linux regression, and
finding the newest working and oldest broken versions will help
identify it.

>>> - why does the system not succeed to "derive" routing for INTA? And why
>>> us?
>>
>> The derivation is based on ACPI _PRT tables.  Regrettably, we don't
>> dump the _PRT contents in dmesg, so we'd need an acpidump to look
>> further into that.
>
> Well unfortunately, we are not able to provide this kind of information at
> this moment.

The acpidump isn't secret (it's not part of the BIOS source); it's
just information extracted from the running system.  See
https://lesswatts.org/projects/acpi/utilities.php for details.

Bjorn
