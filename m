Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:52185 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932927Ab2GYN72 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jul 2012 09:59:28 -0400
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: huang ying <huang.ying.caritas@gmail.com>
Cc: Huang Ying <ying.huang@intel.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Zheng Yan <zheng.z.yan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
Subject: Re: bisected regression, v3.5 -> next-20120724: PCI PM causes USB hotplug failure
References: <Pine.LNX.4.44L0.1207241312050.1164-100000@iolanthe.rowland.org>
	<87r4s0opck.fsf@nemi.mork.no> <87pq7ko532.fsf@nemi.mork.no>
	<1343190864.10311.26.camel@yhuang-dev> <87k3xskvqq.fsf@nemi.mork.no>
	<CAC=cRTOi+=49+_4VuMuBR8rTPvjXLMVhNBFbr3SHgNyxfnKQUA@mail.gmail.com>
Date: Wed, 25 Jul 2012 15:58:55 +0200
In-Reply-To: <CAC=cRTOi+=49+_4VuMuBR8rTPvjXLMVhNBFbr3SHgNyxfnKQUA@mail.gmail.com>
	(huang ying's message of "Wed, 25 Jul 2012 21:30:52 +0800")
Message-ID: <874now7xi8.fsf@nemi.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

huang ying <huang.ying.caritas@gmail.com> writes:

> Hi, Bjorn,
>
> Thank you very much for your detailed information.
>
> On Wed, Jul 25, 2012 at 5:58 PM, Bjørn Mork <bjorn@mork.no> wrote:
>> Huang Ying <ying.huang@intel.com> writes:
>>> On Wed, 2012-07-25 at 06:08 +0200, Bjørn Mork wrote:
>>>> Enabling autosuspend for USB causes hotplug failure in the current
>>>> linux-next. Newly plugged devices are not detected at all until the
>>>> port/controller is manually powered on by writing "on" to power/control.
>>>> Testing is pretty simple:
>>>>
>>>>   1) for f in /sys/bus/usb/devices/*/power/control; do echo auto > $f; done
>>>
>>> Have you done:
>>>
>>> for f in /sys/bus/pci/devices/*/power/confol; do echo auto > $f; done
>>>
>>> ?
>>>
>>> If not, the pci device will not be suspended at all.
>>
>> Yes, sorry for missing that.  I had it automatically enabled.  Yes,
>> autosuspend for the PCI device and all child devices must be enabled for
>> the device to be suspended at all, of course.
>>
>>>>   2) wait for the controllers to suspend
>>>>   3) plugin a new USB device
>>>
>>> After plugin the new USB device, is there anything in dmesg?
>>
>> No. Absolutely nothing, so the USB devices is not enumerated.  Another
>> indication of the same:  Plugging a device like an Android phone, which
>> normally detects being connected to a host and presents a device type
>> menu to the user, results in the charging LED lighting up but no menu.
>>
>>
>> Trying to show the sequence of events:
>>
>> 1)  the controllers are suspended:
>>
>> Jul 25 11:27:12 nemi kernel: [   38.962792] uhci_hcd 0000:00:1a.2: power state changed by ACPI to D2
>> Jul 25 11:27:12 nemi kernel: [   39.006718] uhci_hcd 0000:00:1d.0: power state changed by ACPI to D2
>> Jul 25 11:27:15 nemi kernel: [   41.808471] uhci_hcd 0000:00:1a.0: power state changed by ACPI to D2
>> Jul 25 11:27:15 nemi kernel: [   41.824123] ehci_hcd 0000:00:1a.7: power state changed by ACPI to D2
>> Jul 25 11:27:15 nemi kernel: [   41.824194] ehci_hcd 0000:00:1d.7: power state changed by ACPI to D2
>
> Here uhci controller is put into D2
>
> [snip]
>>
>> Doing the same with commit 448bd857d reverted:
>>
>>
>> 1)  the controllers are suspended (to state D3? instead of D2?):
>>
>> Jul 25 11:34:01 nemi kernel: [   37.064955] uhci_hcd 0000:00:1a.2: power state changed by ACPI to D3
>> Jul 25 11:34:01 nemi kernel: [   37.106586] uhci_hcd 0000:00:1d.0: power state changed by ACPI to D3
>> Jul 25 11:34:04 nemi kernel: [   39.808329] uhci_hcd 0000:00:1a.0: power state changed by ACPI to D3
>> Jul 25 11:34:04 nemi kernel: [   39.840054] ehci_hcd 0000:00:1d.7: power state changed by ACPI to D3
>> Jul 25 11:34:04 nemi kernel: [   39.840068] ehci_hcd 0000:00:1a.7: power state changed by ACPI to D3
>
> With commit reverted, the uhci_controller is put into D3 (ACPI D3cold).
>
> And the uhci controller on your system may not work properly under D2
> state, while OK in D3 state, and the commit will make uhci controller
> choose D2 instead of D3.
>
> Please try following command line before testing.
>
> for f in /sys/bus/pci/devices/*/d3cold_allowed; do echo 1 > $f; done

That made it work.  The USB controllers ended up in D4 though:

Jul 25 15:52:33 nemi kernel: [  152.753280] uhci_hcd 0000:00:1a.0: power state changed by ACPI to D0
Jul 25 15:52:33 nemi kernel: [  152.753453] uhci_hcd 0000:00:1a.0: setting latency timer to 64
Jul 25 15:52:33 nemi kernel: [  152.753619] uhci_hcd 0000:00:1a.0: power state changed by ACPI to D4
Jul 25 15:52:33 nemi kernel: [  152.753875] uhci_hcd 0000:00:1a.1: setting latency timer to 64
Jul 25 15:52:33 nemi kernel: [  152.754153] uhci_hcd 0000:00:1a.2: power state changed by ACPI to D0
Jul 25 15:52:33 nemi kernel: [  152.754279] uhci_hcd 0000:00:1a.2: setting latency timer to 64
Jul 25 15:52:33 nemi kernel: [  152.754432] uhci_hcd 0000:00:1a.2: power state changed by ACPI to D4
Jul 25 15:52:33 nemi kernel: [  152.754668] ehci_hcd 0000:00:1a.7: setting latency timer to 64
Jul 25 15:52:33 nemi kernel: [  152.768089] ehci_hcd 0000:00:1a.7: power state changed by ACPI to D4
Jul 25 15:52:33 nemi kernel: [  152.768573] uhci_hcd 0000:00:1d.0: power state changed by ACPI to D0
Jul 25 15:52:33 nemi kernel: [  152.768726] uhci_hcd 0000:00:1d.0: setting latency timer to 64
Jul 25 15:52:33 nemi kernel: [  152.768891] uhci_hcd 0000:00:1d.0: power state changed by ACPI to D4
Jul 25 15:52:33 nemi kernel: [  152.769144] uhci_hcd 0000:00:1d.1: setting latency timer to 64
Jul 25 15:52:33 nemi kernel: [  152.769530] uhci_hcd 0000:00:1d.2: setting latency timer to 64
Jul 25 15:52:33 nemi kernel: [  152.769902] ehci_hcd 0000:00:1d.7: setting latency timer to 64
Jul 25 15:52:33 nemi kernel: [  152.784189] ehci_hcd 0000:00:1d.7: power state changed by ACPI to D4


was that expected?  Anyway, waking up the controller from this state by
plugging a USB device works, so it's a perfectly OK workaround.  Is this
something that could/should be implemented as a system specific quirk,
or is the problem more generic?  Even if it is a ACPI implementation
issue I would expect it to be common to a number of Lenovo laptops of
the same generation as mine (~2008).

> And please provide the output of the following command line.
>
> acpidump

Attached.  Thanks a lot for all your help debugging this issue.


Bjørn

