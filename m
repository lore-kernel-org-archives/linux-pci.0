Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f68.google.com ([209.85.192.68]:35369 "EHLO
	mail-qg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755882AbcEQBnD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2016 21:43:03 -0400
Received: by mail-qg0-f68.google.com with SMTP id b14so178720qge.2
        for <linux-pci@vger.kernel.org>; Mon, 16 May 2016 18:42:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1463431052.1983.57.camel@users.sourceforge.net>
References: <1463331375.6071.39.camel@users.sourceforge.net>
	<CAL-B5D19esStG0=nbUa-mJggtRDX94t542Vzz1=u_avq9qRgYQ@mail.gmail.com>
	<1463431052.1983.57.camel@users.sourceforge.net>
Date: Mon, 16 May 2016 19:42:29 -0600
Message-ID: <CAL-B5D3xNYe_roUDXLTYeYP+UijwQDxQ4j7Vr0-ETUyC4hE44Q@mail.gmail.com>
Subject: Re: `pcilib: sysfs_read_vpd: read failed: Input/output error` on
 ASRock E350M1
From: Myron Stowe <myron.stowe@gmail.com>
To: Paul Menzel <paulepanter@users.sourceforge.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 16, 2016 at 2:37 PM, Paul Menzel
<paulepanter@users.sourceforge.net> wrote:
> Dear Myron,
>
>
> thank you for your response.
>
>
> Am Montag, den 16.05.2016, 12:02 -0600 schrieb Myron Stowe:
>> On Sun, May 15, 2016 at 10:56 AM, Paul Menzel wrote:
>
> […]
>
>> > Is that related to [1]?
>>
>> There have been a number of recent kernel commits to work-around know
>> buggy devices -
>>   v4.6-rc5
>>     67e6587  cxgb4: Set VPD size so we can read both VPD structures
>>     cb92148  PCI: Add pci_set_vpd_size() to set VPD size
>>   v4.6 -
>>     7c20078  PCI: Prevent VPD access for buggy devices
>>     c521b01  PCI: Sleep rather than busy-wait for VPD access completion
>>     408641e  PCI: Fold struct pci_vpd_pci22 into struct pci_vpd
>>     f1cd93f  PCI: Rename VPD symbols to remove unnecessary "pci22"
>>     da00684  PCI: Remove struct pci_vpd_ops.release function pointer
>>     6437907  PCI: Move pci_vpd_release() from header file to pci/access.c
>>     fc0a407  PCI: Move pci_read_vpd() and pci_write_vpd() close to other code
>>     104daa7  PCI: Determine actual VPD size on first access
>>     c556388  PCI: Use bitfield instead of bool for struct pci_vpd_pci22.busy
>>     f52e562  PCI: Allow access to VPD attributes with size 0
>>     9eb45d5  PCI: Update VPD definitions
>>   v4.3 -
>>     da2d03e  PCI: Use function 0 VPD only for identical functions
>>     9d92407  PCI: Fix devfn for VPD access through function 0
>>     7aa6ca4  PCI: Add VPD function 0 quirk for Intel Ethernet devices
>>     932c435  PCI: Add dev_flags bit to access VPD through function 0
>>
>> What were you getting/seeing before?
>
> The error wasn’t shown. Sorry if that is not a helpful answer. If I
> provide more information, please tell me how I can get them.

I expect that prior to the kernel updates you were seeing:

lspci -s 3:0 -vv
...
        Capabilities: [d0] Vital Product Data
                Unknown small resource type 00, will not decode more.
...

and with 'xxd', looking at the VPD area you likely would have seen:

# xxd /sys/bus/pci/devices/0000\:03\:00.0/vpd
0000000: 0000 0000 0000 0000 0000 0000 0000 0000  ................
0000010: 0000 0000 0000 0000 0000 0000 0000 0000  ................
0000020: 0000 0000 0000 0000 0000 0000 0000 0000  ................
...

and nothing in the 'dmesg' logs.

With the recent kernel updates you see the new output from the kernel
and 'lspci -vv' that started this thread.  I expect that you also get
something close to the following from 'xxd':

# xxd /sys/bus/pci/devices/0000\:03\:00.0/vpd
xxd: Input/output error

and also see the following in the 'dmesg' logs.

# dmesg | grep VPD
r8169 0000:03:00.0: invalid short VPD tag 00 at offset 1


The new kernel behavior is correct in its complaint as the device is
advertising that it has VPD via a 'capability' yet its VPD data area
is likely all 0's.  This is a device error - specifically an error
with the device's firmware: either it should _not_ advertise via the
'capability' that it has VPD or, it s VPD area needs to conform to the
VPD data format as expressed in the "PCI Local Bus Specification, Rev.
3.0" appendix I - "Vital Product Data".

With the new kernel behavior, effectively circumventing reading of an
invalid VPD area, you can't get to the data via "# xxd" (as shown
above).  You could run a kernel prior to the changes and run the "xxd"
command and likely see that the VPD area is all 0's.  I would be
interested in confirming such if you could do so please.

Thanks,
 Myron

>
> You can find a lot of lspci output for the ASRock E350M1 in coreboot’s
> board status repository [2].
>
>
> Thanks,
>
> Paul
>
>
>> > [1] https://lkml.org/lkml/2016/4/15/649
> [2] http://review.coreboot.org/cgit/board-status.git/tree/asrock/e350m1
