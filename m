Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:33339 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390AbcERBwU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 May 2016 21:52:20 -0400
Received: by mail-qg0-f49.google.com with SMTP id f92so18568782qgf.0
        for <linux-pci@vger.kernel.org>; Tue, 17 May 2016 18:52:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1463520103.2290.101.camel@users.sourceforge.net>
References: <1463331375.6071.39.camel@users.sourceforge.net>
	<CAL-B5D19esStG0=nbUa-mJggtRDX94t542Vzz1=u_avq9qRgYQ@mail.gmail.com>
	<1463431052.1983.57.camel@users.sourceforge.net>
	<CAL-B5D3xNYe_roUDXLTYeYP+UijwQDxQ4j7Vr0-ETUyC4hE44Q@mail.gmail.com>
	<1463520103.2290.101.camel@users.sourceforge.net>
Date: Tue, 17 May 2016 19:52:19 -0600
Message-ID: <CAL-B5D1Ao6Soj+T6qEH5pYO9vWY4A3+G0r2bdBHxvuNbK3FkUg@mail.gmail.com>
Subject: Re: `pcilib: sysfs_read_vpd: read failed: Input/output error` on
 ASRock E350M1
From: Myron Stowe <myron.stowe@gmail.com>
To: Paul Menzel <paulepanter@users.sourceforge.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 17, 2016 at 3:21 PM, Paul Menzel
<paulepanter@users.sourceforge.net> wrote:
> Dear Myron,
>
>
> Am Montag, den 16.05.2016, 19:42 -0600 schrieb Myron Stowe:
>> On Mon, May 16, 2016 at 2:37 PM, Paul Menzel wrote:
>
>> > Am Montag, den 16.05.2016, 12:02 -0600 schrieb Myron Stowe:
>> > >
>> > > On Sun, May 15, 2016 at 10:56 AM, Paul Menzel wrote:
>> > […]
>> > > >
>> > > > Is that related to [1]?
>> > > There have been a number of recent kernel commits to work-around know
>> > > buggy devices -
>> > >   v4.6-rc5
>> > >     67e6587  cxgb4: Set VPD size so we can read both VPD structures
>> > >     cb92148  PCI: Add pci_set_vpd_size() to set VPD size
>> > >   v4.6 -
>> > >     7c20078  PCI: Prevent VPD access for buggy devices
>> > >     c521b01  PCI: Sleep rather than busy-wait for VPD access completion
>> > >     408641e  PCI: Fold struct pci_vpd_pci22 into struct pci_vpd
>> > >     f1cd93f  PCI: Rename VPD symbols to remove unnecessary "pci22"
>> > >     da00684  PCI: Remove struct pci_vpd_ops.release function pointer
>> > >     6437907  PCI: Move pci_vpd_release() from header file to pci/access.c
>> > >     fc0a407  PCI: Move pci_read_vpd() and pci_write_vpd() close to other code
>> > >     104daa7  PCI: Determine actual VPD size on first access
>> > >     c556388  PCI: Use bitfield instead of bool for struct pci_vpd_pci22.busy
>> > >     f52e562  PCI: Allow access to VPD attributes with size 0
>> > >     9eb45d5  PCI: Update VPD definitions
>> > >   v4.3 -
>> > >     da2d03e  PCI: Use function 0 VPD only for identical functions
>> > >     9d92407  PCI: Fix devfn for VPD access through function 0
>> > >     7aa6ca4  PCI: Add VPD function 0 quirk for Intel Ethernet devices
>> > >     932c435  PCI: Add dev_flags bit to access VPD through function 0
>> > >
>> > > What were you getting/seeing before?
>> > The error wasn’t shown. Sorry if that is not a helpful answer. If I
>> > provide more information, please tell me how I can get them.
>> I expect that prior to the kernel updates you were seeing:
>>
>> lspci -s 3:0 -vv
>> ...
>>         Capabilities: [d0] Vital Product Data
>>                 Unknown small resource type 00, will not decode more.
>> ...
>
> From logs stored in coreboot’s board status repository [2].
>
> ```
> $ more asrock/e350m1/4.3-817-g477a0d6/2016-04-22T18_41_34Z/lspci-vvxxx.txt
> […]
>        Capabilities: [d0] Vital Product Data
>                No end tag found
> […]
> ```

The above - "No end tag found" - is from 'lspci' reading the VPD area
and parsing it looking for an small resource data type "End Tag"
(0x0f) and never finding one.  Thus it seems like the VPD area is
malformed at best.

>
>> and with 'xxd', looking at the VPD area you likely would have seen:
>>
>> # xxd /sys/bus/pci/devices/0000\:03\:00.0/vpd
>> 0000000: 0000 0000 0000 0000 0000 0000 0000 0000  ................
>> 0000010: 0000 0000 0000 0000 0000 0000 0000 0000  ................
>> 0000020: 0000 0000 0000 0000 0000 0000 0000 0000  ................
>> ...
>>
>> and nothing in the 'dmesg' logs.
>
> ```
> $ more asrock/e350m1/4.3-817-g477a0d6/2016-04-22T18_41_34Z/lspci-vvxxx.txt
> […]
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 10 00 01 01 01 12 63 80 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 80 80 00 00 00 00 00 00 00 00 00
> […]
> ```

Careful here, the above is _not_ the VPD area.  The above is the
device's standard PCI (type 0) configuration header registers [I'm
thinking you mistook the 0xd0 from "Capabilities: [d0] Vital Product
Data" and thought that was the offset for the VPD area - it is not.
To get to the VPD area one has to manipulate a couple of VPD registers
which is basically obtaining the VPD bytes from within the device
itself (i.e. from within the device's firmware)].

To get the VPD area you will need to run a kernel prior to the commits
I pointed out and then use 'xxd' as shown above to gain insight into
what, if anything, is really there.

>
> There is nothing in the Linux 3.16 messages.
>
>> With the recent kernel updates you see the new output from the kernel
>> and 'lspci -vv' that started this thread.  I expect that you also get
>> something close to the following from 'xxd':
>>
>> # xxd /sys/bus/pci/devices/0000\:03\:00.0/vpd
>> xxd: Input/output error
>
> Correct.
>
>> and also see the following in the 'dmesg' logs.
>>
>> # dmesg | grep VPD
>> r8169 0000:03:00.0: invalid short VPD tag 00 at offset 1
>
> Indeed similar:
>
> ```
> $ dmesg | grep VPD
> [15841.258561] r8169 0000:03:00.0: invalid large VPD tag 7f at offset 0
> ```

Humm, the above is interesting to me in that it implies that the VPD
area is not necessarily all 0's as I was expecting.  A "Large VPD tag"
is denoted by the most significant bit of the first byte being set.
However, the value denoted - 0x7f - does not have the MSB set so now
I'm a bit confused (perhaps the MSB is stripped off - I'll need to
look at the related code).  Either way, its looking like perhaps the
VPD area is not all 0's so I'd really be interested in knowing what is
there.

Ok, looking at the code - ./drivers/pci/access.c::pci_vpd_size() - the
tag value output - 7f - had its MSB stripped off via
'pci_vpd_lrdt_tag()'.  So what must have been read for the first byte
was 0xff.

>
>> The new kernel behavior is correct in its complaint as the device is
>> advertising that it has VPD via a 'capability' yet its VPD data area
>> is likely all 0's.  This is a device error - specifically an error
>> with the device's firmware: either it should _not_ advertise via the
>> 'capability' that it has VPD or, it s VPD area needs to conform to the
>> VPD data format as expressed in the "PCI Local Bus Specification, Rev.
>> 3.0" appendix I - "Vital Product Data".
>>
>> With the new kernel behavior, effectively circumventing reading of an
>> invalid VPD area, you can't get to the data via "# xxd" (as shown
>> above).  You could run a kernel prior to the changes and run the "xxd"
>> command and likely see that the VPD area is all 0's.  I would be
>> interested in confirming such if you could do so please.
>
> Please see the paste above. Please tell me if I missed something.

I have to admit I'm a bit surprised at this point (that the VPD area
is not all 0's as I was expecting).  The only way we'll know is to
obtain the VPD area - if you can get that via 'xxd' it would be
interesting to see what is there exactly.

>
> So what to do about this? Contact Realtek? Add a workaround?

The VPD area is almost certainly malformed (or doesn't exist at all).
As a colleague of mine noted today, LSI devices seem to be especially
negligent in this manner (see commit 7c20078 ("PCI: Prevent VPD access
for buggy devices")).  Assuming the VPD area of this device is at best
invalid then the kernel is correct in its current behavior - not much
more it can do.  While it would be good for the device's firmware to
be upgraded to either not advertise it has VPD or to put in valid VPD,
I very much doubt you'd get any traction there.  You could try adding
this device's signature (device and vendor id) to the 7c20078 quirk
and see if there is any subtle difference.  If there was, it'd be very
subtle at best.

All that aside, you are just questioning the error output - correct
(i.e. you are not expecting, nor needing, valid VPD content for some
reason and questioning that I assume)?

Myron

>
>
> Thanks,
>
> Paul
>
>
>> > > > [1] https://lkml.org/lkml/2016/4/15/649
>> > [2] http://review.coreboot.org/cgit/board-status.git/tree/asrock/e350m1
