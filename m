Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:38008 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756316Ab2GYNay convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jul 2012 09:30:54 -0400
MIME-Version: 1.0
In-Reply-To: <87k3xskvqq.fsf@nemi.mork.no>
References: <Pine.LNX.4.44L0.1207241312050.1164-100000@iolanthe.rowland.org>
	<87r4s0opck.fsf@nemi.mork.no>
	<87pq7ko532.fsf@nemi.mork.no>
	<1343190864.10311.26.camel@yhuang-dev>
	<87k3xskvqq.fsf@nemi.mork.no>
Date: Wed, 25 Jul 2012 21:30:52 +0800
Message-ID: <CAC=cRTOi+=49+_4VuMuBR8rTPvjXLMVhNBFbr3SHgNyxfnKQUA@mail.gmail.com>
Subject: Re: bisected regression, v3.5 -> next-20120724: PCI PM causes USB
 hotplug failure
From: huang ying <huang.ying.caritas@gmail.com>
To: =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Cc: Huang Ying <ying.huang@intel.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Zheng Yan <zheng.z.yan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi, Bjorn,

Thank you very much for your detailed information.

On Wed, Jul 25, 2012 at 5:58 PM, Bjørn Mork <bjorn@mork.no> wrote:
> Huang Ying <ying.huang@intel.com> writes:
>> On Wed, 2012-07-25 at 06:08 +0200, Bjørn Mork wrote:
>>> Enabling autosuspend for USB causes hotplug failure in the current
>>> linux-next. Newly plugged devices are not detected at all until the
>>> port/controller is manually powered on by writing "on" to power/control.
>>> Testing is pretty simple:
>>>
>>>   1) for f in /sys/bus/usb/devices/*/power/control; do echo auto > $f; done
>>
>> Have you done:
>>
>> for f in /sys/bus/pci/devices/*/power/confol; do echo auto > $f; done
>>
>> ?
>>
>> If not, the pci device will not be suspended at all.
>
> Yes, sorry for missing that.  I had it automatically enabled.  Yes,
> autosuspend for the PCI device and all child devices must be enabled for
> the device to be suspended at all, of course.
>
>>>   2) wait for the controllers to suspend
>>>   3) plugin a new USB device
>>
>> After plugin the new USB device, is there anything in dmesg?
>
> No. Absolutely nothing, so the USB devices is not enumerated.  Another
> indication of the same:  Plugging a device like an Android phone, which
> normally detects being connected to a host and presents a device type
> menu to the user, results in the charging LED lighting up but no menu.
>
>
> Trying to show the sequence of events:
>
> 1)  the controllers are suspended:
>
> Jul 25 11:27:12 nemi kernel: [   38.962792] uhci_hcd 0000:00:1a.2: power state changed by ACPI to D2
> Jul 25 11:27:12 nemi kernel: [   39.006718] uhci_hcd 0000:00:1d.0: power state changed by ACPI to D2
> Jul 25 11:27:15 nemi kernel: [   41.808471] uhci_hcd 0000:00:1a.0: power state changed by ACPI to D2
> Jul 25 11:27:15 nemi kernel: [   41.824123] ehci_hcd 0000:00:1a.7: power state changed by ACPI to D2
> Jul 25 11:27:15 nemi kernel: [   41.824194] ehci_hcd 0000:00:1d.7: power state changed by ACPI to D2

Here uhci controller is put into D2

[snip]
>
> Doing the same with commit 448bd857d reverted:
>
>
> 1)  the controllers are suspended (to state D3? instead of D2?):
>
> Jul 25 11:34:01 nemi kernel: [   37.064955] uhci_hcd 0000:00:1a.2: power state changed by ACPI to D3
> Jul 25 11:34:01 nemi kernel: [   37.106586] uhci_hcd 0000:00:1d.0: power state changed by ACPI to D3
> Jul 25 11:34:04 nemi kernel: [   39.808329] uhci_hcd 0000:00:1a.0: power state changed by ACPI to D3
> Jul 25 11:34:04 nemi kernel: [   39.840054] ehci_hcd 0000:00:1d.7: power state changed by ACPI to D3
> Jul 25 11:34:04 nemi kernel: [   39.840068] ehci_hcd 0000:00:1a.7: power state changed by ACPI to D3

With commit reverted, the uhci_controller is put into D3 (ACPI D3cold).

And the uhci controller on your system may not work properly under D2
state, while OK in D3 state, and the commit will make uhci controller
choose D2 instead of D3.

Please try following command line before testing.

for f in /sys/bus/pci/devices/*/d3cold_allowed; do echo 1 > $f; done

And please provide the output of the following command line.

acpidump

Best Regards,
Huang Ying

[snip]
