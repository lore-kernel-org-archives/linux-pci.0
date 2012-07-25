Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:49181 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102Ab2GYKAA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 25 Jul 2012 06:00:00 -0400
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Huang Ying <ying.huang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	Zheng Yan <zheng.z.yan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
Subject: Re: bisected regression, v3.5 -> next-20120724: PCI PM causes USB hotplug failure
References: <Pine.LNX.4.44L0.1207241312050.1164-100000@iolanthe.rowland.org>
	<87r4s0opck.fsf@nemi.mork.no> <87pq7ko532.fsf@nemi.mork.no>
	<1343190864.10311.26.camel@yhuang-dev>
Date: Wed, 25 Jul 2012 11:58:37 +0200
In-Reply-To: <1343190864.10311.26.camel@yhuang-dev> (Huang Ying's message of
	"Wed, 25 Jul 2012 12:34:24 +0800")
Message-ID: <87k3xskvqq.fsf@nemi.mork.no>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Huang Ying <ying.huang@intel.com> writes:
> On Wed, 2012-07-25 at 06:08 +0200, Bj=C3=B8rn Mork wrote:
>> Enabling autosuspend for USB causes hotplug failure in the current
>> linux-next. Newly plugged devices are not detected at all until the
>> port/controller is manually powered on by writing "on" to power/control.
>> Testing is pretty simple:
>>=20
>>   1) for f in /sys/bus/usb/devices/*/power/control; do echo auto > $f; d=
one
>
> Have you done:
>
> for f in /sys/bus/pci/devices/*/power/confol; do echo auto > $f; done
>
> ?
>
> If not, the pci device will not be suspended at all.

Yes, sorry for missing that.  I had it automatically enabled.  Yes,
autosuspend for the PCI device and all child devices must be enabled for
the device to be suspended at all, of course.

>>   2) wait for the controllers to suspend
>>   3) plugin a new USB device
>
> After plugin the new USB device, is there anything in dmesg?

No. Absolutely nothing, so the USB devices is not enumerated.  Another
indication of the same:  Plugging a device like an Android phone, which
normally detects being connected to a host and presents a device type
menu to the user, results in the charging LED lighting up but no menu.


Trying to show the sequence of events:

1)  the controllers are suspended:

Jul 25 11:27:12 nemi kernel: [   38.962792] uhci_hcd 0000:00:1a.2: power st=
ate changed by ACPI to D2
Jul 25 11:27:12 nemi kernel: [   39.006718] uhci_hcd 0000:00:1d.0: power st=
ate changed by ACPI to D2
Jul 25 11:27:15 nemi kernel: [   41.808471] uhci_hcd 0000:00:1a.0: power st=
ate changed by ACPI to D2
Jul 25 11:27:15 nemi kernel: [   41.824123] ehci_hcd 0000:00:1a.7: power st=
ate changed by ACPI to D2
Jul 25 11:27:15 nemi kernel: [   41.824194] ehci_hcd 0000:00:1d.7: power st=
ate changed by ACPI to D2

2) I connect a new USB device here

3) I read all power/files triggering this warning (as expected),
  included for timing info - this happens a while after connecting the
  USB device:

Jul 25 11:28:34 nemi kernel: [  121.440558] WARNING! power/level is depreca=
ted; use power/control instead



4) I wake up the usb2 bus I connected the device to, and it is
immediately found (no info about power state change here?):

nemi:/home/bjorn# echo on > /sys/bus/usb/devices/usb2/power/control=20


Jul 25 11:29:32 nemi kernel: [  179.121418] ehci_hcd 0000:00:1d.7: setting =
latency timer to 64
Jul 25 11:29:32 nemi kernel: [  179.364088] usb 2-1: new high-speed USB dev=
ice number 3 using ehci_hcd
Jul 25 11:29:33 nemi kernel: [  179.500042] usb 2-1: New USB device found, =
idVendor=3D0fce, idProduct=3D2138
Jul 25 11:29:33 nemi kernel: [  179.500055] usb 2-1: New USB device strings=
: Mfr=3D1, Product=3D2, SerialNumber=3D3
Jul 25 11:29:33 nemi kernel: [  179.500063] usb 2-1: Product: SEMC HSUSB De=
vice
Jul 25 11:29:33 nemi kernel: [  179.500069] usb 2-1: Manufacturer: SEMC
Jul 25 11:29:33 nemi kernel: [  179.500075] usb 2-1: SerialNumber: 43423531=
314D42573144




Doing the same with commit 448bd857d reverted:


1)  the controllers are suspended (to state D3? instead of D2?):

Jul 25 11:34:01 nemi kernel: [   37.064955] uhci_hcd 0000:00:1a.2: power st=
ate changed by ACPI to D3
Jul 25 11:34:01 nemi kernel: [   37.106586] uhci_hcd 0000:00:1d.0: power st=
ate changed by ACPI to D3
Jul 25 11:34:04 nemi kernel: [   39.808329] uhci_hcd 0000:00:1a.0: power st=
ate changed by ACPI to D3
Jul 25 11:34:04 nemi kernel: [   39.840054] ehci_hcd 0000:00:1d.7: power st=
ate changed by ACPI to D3
Jul 25 11:34:04 nemi kernel: [   39.840068] ehci_hcd 0000:00:1a.7: power st=
ate changed by ACPI to D3

2) plugging a USB device causes immediate wakeup (and logs changes state
   to D0):

Jul 25 11:34:43 nemi kernel: [   78.575357] ehci_hcd 0000:00:1d.7: power st=
ate changed by ACPI to D0
Jul 25 11:34:43 nemi kernel: [   78.588162] ehci_hcd 0000:00:1d.7: power st=
ate changed by ACPI to D0
Jul 25 11:34:43 nemi kernel: [   78.588292] ehci_hcd 0000:00:1d.7: setting =
latency timer to 64
Jul 25 11:34:43 nemi kernel: [   78.832337] usb 2-1: new high-speed USB dev=
ice number 3 using ehci_hcd
Jul 25 11:34:43 nemi kernel: [   78.968286] usb 2-1: New USB device found, =
idVendor=3D0fce, idProduct=3D2138
Jul 25 11:34:43 nemi kernel: [   78.968300] usb 2-1: New USB device strings=
: Mfr=3D1, Product=3D2, SerialNumber=3D3
Jul 25 11:34:43 nemi kernel: [   78.968307] usb 2-1: Product: SEMC HSUSB De=
vice
Jul 25 11:34:43 nemi kernel: [   78.968314] usb 2-1: Manufacturer: SEMC




>>=20
>> I've bisected the regression down to this commit:
>>=20
>>=20
>> commit 448bd857d48e69b33ef323739dc6d8ca20d4cda7
>> Author: Huang Ying <ying.huang@intel.com>
>> Date:   Sat Jun 23 10:23:51 2012 +0800
>>=20
>>     PCI/PM: add PCIe runtime D3cold support
>>=20=20=20=20=20
>>=20
>> Looks like this somehow powers down my USB host controllers in such a
>> way that they are unable to detect connections to their ports.  The
>> system is a pretty standard 4 year old intel based laptop.  Full lspci
>> listing is attached.
>>
>> Please let me know if you need further information.  And please fix this
>> before rc1.  It effectively makes USB non-functional if autosuspend is
>> enabled.
>
> Can you provide the output of the following command lines?
>
> grep . /sys/bus/pci/devices/*/power/*
> grep . /sys/bus/usb/devices/*/power/*
> lsusb
>
> After the controllers suspended.

I've attached two copies of this output:=20=20

 - powerstate-withbug.txt, from a plain next-20120724 kernel
 - powerstate-reverted.txt, from a next-20120724 kernel with commit
   448bd857d reverted

I cannot really see any interesting differences in these.  But the D3/D2
difference in the kernel log might be of interest?



Bj=C3=B8rn


--=-=-=
Content-Type: text/plain
Content-Disposition: inline; filename=powerstate-withbug.txt

/sys/bus/usb/devices/1-0:1.0/power/async:enabled
/sys/bus/usb/devices/1-0:1.0/power/runtime_active_kids:0
/sys/bus/usb/devices/1-0:1.0/power/runtime_enabled:enabled
/sys/bus/usb/devices/1-0:1.0/power/runtime_status:suspended
/sys/bus/usb/devices/1-0:1.0/power/runtime_usage:0
/sys/bus/usb/devices/1-6:1.0/power/async:enabled
/sys/bus/usb/devices/1-6:1.0/power/runtime_active_kids:0
/sys/bus/usb/devices/1-6:1.0/power/runtime_enabled:disabled
/sys/bus/usb/devices/1-6:1.0/power/runtime_status:unsupported
/sys/bus/usb/devices/1-6:1.0/power/runtime_usage:0
/sys/bus/usb/devices/1-6:1.1/power/async:enabled
/sys/bus/usb/devices/1-6:1.1/power/runtime_active_kids:0
/sys/bus/usb/devices/1-6:1.1/power/runtime_enabled:disabled
/sys/bus/usb/devices/1-6:1.1/power/runtime_status:unsupported
/sys/bus/usb/devices/1-6:1.1/power/runtime_usage:0
/sys/bus/usb/devices/1-6/power/active_duration:37124
/sys/bus/usb/devices/1-6/power/async:enabled
/sys/bus/usb/devices/1-6/power/autosuspend:2
/sys/bus/usb/devices/1-6/power/autosuspend_delay_ms:2000
/sys/bus/usb/devices/1-6/power/connected_duration:119252
/sys/bus/usb/devices/1-6/power/control:auto
/sys/bus/usb/devices/1-6/power/level:auto
/sys/bus/usb/devices/1-6/power/persist:1
/sys/bus/usb/devices/1-6/power/runtime_active_kids:0
/sys/bus/usb/devices/1-6/power/runtime_active_time:36896
/sys/bus/usb/devices/1-6/power/runtime_enabled:enabled
/sys/bus/usb/devices/1-6/power/runtime_status:suspended
/sys/bus/usb/devices/1-6/power/runtime_suspended_time:82112
/sys/bus/usb/devices/1-6/power/runtime_usage:0
/sys/bus/usb/devices/2-0:1.0/power/async:enabled
/sys/bus/usb/devices/2-0:1.0/power/runtime_active_kids:0
/sys/bus/usb/devices/2-0:1.0/power/runtime_enabled:enabled
/sys/bus/usb/devices/2-0:1.0/power/runtime_status:suspended
/sys/bus/usb/devices/2-0:1.0/power/runtime_usage:0
/sys/bus/usb/devices/2-4:1.0/power/async:enabled
/sys/bus/usb/devices/2-4:1.0/power/runtime_active_kids:0
/sys/bus/usb/devices/2-4:1.0/power/runtime_enabled:enabled
/sys/bus/usb/devices/2-4:1.0/power/runtime_status:suspended
/sys/bus/usb/devices/2-4:1.0/power/runtime_usage:0
/sys/bus/usb/devices/2-4:1.19/power/async:enabled
/sys/bus/usb/devices/2-4:1.19/power/runtime_active_kids:0
/sys/bus/usb/devices/2-4:1.19/power/runtime_enabled:enabled
/sys/bus/usb/devices/2-4:1.19/power/runtime_status:suspended
/sys/bus/usb/devices/2-4:1.19/power/runtime_usage:0
/sys/bus/usb/devices/2-4:1.20/power/async:enabled
/sys/bus/usb/devices/2-4:1.20/power/runtime_active_kids:0
/sys/bus/usb/devices/2-4:1.20/power/runtime_enabled:disabled
/sys/bus/usb/devices/2-4:1.20/power/runtime_status:unsupported
/sys/bus/usb/devices/2-4:1.20/power/runtime_usage:0
/sys/bus/usb/devices/2-4:1.2/power/async:enabled
/sys/bus/usb/devices/2-4:1.2/power/runtime_active_kids:0
/sys/bus/usb/devices/2-4:1.2/power/runtime_enabled:enabled
/sys/bus/usb/devices/2-4:1.2/power/runtime_status:suspended
/sys/bus/usb/devices/2-4:1.2/power/runtime_usage:0
/sys/bus/usb/devices/2-4:1.3/power/async:enabled
/sys/bus/usb/devices/2-4:1.3/power/runtime_active_kids:0
/sys/bus/usb/devices/2-4:1.3/power/runtime_enabled:enabled
/sys/bus/usb/devices/2-4:1.3/power/runtime_status:suspended
/sys/bus/usb/devices/2-4:1.3/power/runtime_usage:0
/sys/bus/usb/devices/2-4:1.8/power/async:enabled
/sys/bus/usb/devices/2-4:1.8/power/runtime_active_kids:0
/sys/bus/usb/devices/2-4:1.8/power/runtime_enabled:enabled
/sys/bus/usb/devices/2-4:1.8/power/runtime_status:suspended
/sys/bus/usb/devices/2-4:1.8/power/runtime_usage:0
/sys/bus/usb/devices/2-4/power/active_duration:36976
/sys/bus/usb/devices/2-4/power/async:enabled
/sys/bus/usb/devices/2-4/power/autosuspend:2
/sys/bus/usb/devices/2-4/power/autosuspend_delay_ms:2000
/sys/bus/usb/devices/2-4/power/connected_duration:119000
/sys/bus/usb/devices/2-4/power/control:auto
/sys/bus/usb/devices/2-4/power/level:auto
/sys/bus/usb/devices/2-4/power/persist:1
/sys/bus/usb/devices/2-4/power/runtime_active_kids:0
/sys/bus/usb/devices/2-4/power/runtime_active_time:36748
/sys/bus/usb/devices/2-4/power/runtime_enabled:enabled
/sys/bus/usb/devices/2-4/power/runtime_status:suspended
/sys/bus/usb/devices/2-4/power/runtime_suspended_time:82008
/sys/bus/usb/devices/2-4/power/runtime_usage:0
/sys/bus/usb/devices/2-4/power/wakeup:disabled
/sys/bus/usb/devices/3-0:1.0/power/async:enabled
/sys/bus/usb/devices/3-0:1.0/power/runtime_active_kids:0
/sys/bus/usb/devices/3-0:1.0/power/runtime_enabled:enabled
/sys/bus/usb/devices/3-0:1.0/power/runtime_status:suspended
/sys/bus/usb/devices/3-0:1.0/power/runtime_usage:0
/sys/bus/usb/devices/3-2:1.0/power/async:enabled
/sys/bus/usb/devices/3-2:1.0/power/runtime_active_kids:0
/sys/bus/usb/devices/3-2:1.0/power/runtime_enabled:disabled
/sys/bus/usb/devices/3-2:1.0/power/runtime_status:unsupported
/sys/bus/usb/devices/3-2:1.0/power/runtime_usage:0
/sys/bus/usb/devices/3-2/power/active_duration:36736
/sys/bus/usb/devices/3-2/power/async:enabled
/sys/bus/usb/devices/3-2/power/autosuspend:2
/sys/bus/usb/devices/3-2/power/autosuspend_delay_ms:2000
/sys/bus/usb/devices/3-2/power/connected_duration:118616
/sys/bus/usb/devices/3-2/power/control:auto
/sys/bus/usb/devices/3-2/power/level:auto
/sys/bus/usb/devices/3-2/power/persist:1
/sys/bus/usb/devices/3-2/power/runtime_active_kids:0
/sys/bus/usb/devices/3-2/power/runtime_active_time:36496
/sys/bus/usb/devices/3-2/power/runtime_enabled:enabled
/sys/bus/usb/devices/3-2/power/runtime_status:suspended
/sys/bus/usb/devices/3-2/power/runtime_suspended_time:81864
/sys/bus/usb/devices/3-2/power/runtime_usage:0
/sys/bus/usb/devices/3-2/power/wakeup:disabled
/sys/bus/usb/devices/4-0:1.0/power/async:enabled
/sys/bus/usb/devices/4-0:1.0/power/runtime_active_kids:0
/sys/bus/usb/devices/4-0:1.0/power/runtime_enabled:enabled
/sys/bus/usb/devices/4-0:1.0/power/runtime_status:suspended
/sys/bus/usb/devices/4-0:1.0/power/runtime_usage:0
/sys/bus/usb/devices/4-2:1.0/power/async:enabled
/sys/bus/usb/devices/4-2:1.0/power/runtime_active_kids:0
/sys/bus/usb/devices/4-2:1.0/power/runtime_enabled:enabled
/sys/bus/usb/devices/4-2:1.0/power/runtime_status:suspended
/sys/bus/usb/devices/4-2:1.0/power/runtime_usage:0
/sys/bus/usb/devices/4-2:1.1/power/async:enabled
/sys/bus/usb/devices/4-2:1.1/power/runtime_active_kids:0
/sys/bus/usb/devices/4-2:1.1/power/runtime_enabled:enabled
/sys/bus/usb/devices/4-2:1.1/power/runtime_status:suspended
/sys/bus/usb/devices/4-2:1.1/power/runtime_usage:0
/sys/bus/usb/devices/4-2:1.2/power/async:enabled
/sys/bus/usb/devices/4-2:1.2/power/runtime_active_kids:0
/sys/bus/usb/devices/4-2:1.2/power/runtime_enabled:disabled
/sys/bus/usb/devices/4-2:1.2/power/runtime_status:unsupported
/sys/bus/usb/devices/4-2:1.2/power/runtime_usage:0
/sys/bus/usb/devices/4-2:1.3/power/async:enabled
/sys/bus/usb/devices/4-2:1.3/power/runtime_active_kids:0
/sys/bus/usb/devices/4-2:1.3/power/runtime_enabled:disabled
/sys/bus/usb/devices/4-2:1.3/power/runtime_status:unsupported
/sys/bus/usb/devices/4-2:1.3/power/runtime_usage:0
/sys/bus/usb/devices/4-2/power/active_duration:26552
/sys/bus/usb/devices/4-2/power/async:enabled
/sys/bus/usb/devices/4-2/power/autosuspend:2
/sys/bus/usb/devices/4-2/power/autosuspend_delay_ms:2000
/sys/bus/usb/devices/4-2/power/connected_duration:118200
/sys/bus/usb/devices/4-2/power/control:auto
/sys/bus/usb/devices/4-2/power/level:auto
/sys/bus/usb/devices/4-2/power/persist:1
/sys/bus/usb/devices/4-2/power/runtime_active_kids:0
/sys/bus/usb/devices/4-2/power/runtime_active_time:26376
/sys/bus/usb/devices/4-2/power/runtime_enabled:enabled
/sys/bus/usb/devices/4-2/power/runtime_status:suspended
/sys/bus/usb/devices/4-2/power/runtime_suspended_time:91568
/sys/bus/usb/devices/4-2/power/runtime_usage:0
/sys/bus/usb/devices/4-2/power/wakeup:disabled
/sys/bus/usb/devices/5-0:1.0/power/async:enabled
/sys/bus/usb/devices/5-0:1.0/power/runtime_active_kids:0
/sys/bus/usb/devices/5-0:1.0/power/runtime_enabled:enabled
/sys/bus/usb/devices/5-0:1.0/power/runtime_status:suspended
/sys/bus/usb/devices/5-0:1.0/power/runtime_usage:0
/sys/bus/usb/devices/6-0:1.0/power/async:enabled
/sys/bus/usb/devices/6-0:1.0/power/runtime_active_kids:0
/sys/bus/usb/devices/6-0:1.0/power/runtime_enabled:enabled
/sys/bus/usb/devices/6-0:1.0/power/runtime_status:suspended
/sys/bus/usb/devices/6-0:1.0/power/runtime_usage:0
/sys/bus/usb/devices/7-0:1.0/power/async:enabled
/sys/bus/usb/devices/7-0:1.0/power/runtime_active_kids:0
/sys/bus/usb/devices/7-0:1.0/power/runtime_enabled:enabled
/sys/bus/usb/devices/7-0:1.0/power/runtime_status:suspended
/sys/bus/usb/devices/7-0:1.0/power/runtime_usage:0
/sys/bus/usb/devices/8-0:1.0/power/async:enabled
/sys/bus/usb/devices/8-0:1.0/power/runtime_active_kids:0
/sys/bus/usb/devices/8-0:1.0/power/runtime_enabled:enabled
/sys/bus/usb/devices/8-0:1.0/power/runtime_status:suspended
/sys/bus/usb/devices/8-0:1.0/power/runtime_usage:0
/sys/bus/usb/devices/usb1/power/active_duration:40060
/sys/bus/usb/devices/usb1/power/async:enabled
/sys/bus/usb/devices/usb1/power/autosuspend:2
/sys/bus/usb/devices/usb1/power/autosuspend_delay_ms:2000
/sys/bus/usb/devices/usb1/power/connected_duration:119692
/sys/bus/usb/devices/usb1/power/control:auto
/sys/bus/usb/devices/usb1/power/level:auto
/sys/bus/usb/devices/usb1/power/runtime_active_kids:0
/sys/bus/usb/devices/usb1/power/runtime_active_time:40044
/sys/bus/usb/devices/usb1/power/runtime_enabled:enabled
/sys/bus/usb/devices/usb1/power/runtime_status:suspended
/sys/bus/usb/devices/usb1/power/runtime_suspended_time:79632
/sys/bus/usb/devices/usb1/power/runtime_usage:0
/sys/bus/usb/devices/usb1/power/wakeup:disabled
/sys/bus/usb/devices/usb2/power/active_duration:40044
/sys/bus/usb/devices/usb2/power/async:enabled
/sys/bus/usb/devices/usb2/power/autosuspend:2
/sys/bus/usb/devices/usb2/power/autosuspend_delay_ms:2000
/sys/bus/usb/devices/usb2/power/connected_duration:119680
/sys/bus/usb/devices/usb2/power/control:auto
/sys/bus/usb/devices/usb2/power/level:auto
/sys/bus/usb/devices/usb2/power/runtime_active_kids:0
/sys/bus/usb/devices/usb2/power/runtime_active_time:40028
/sys/bus/usb/devices/usb2/power/runtime_enabled:enabled
/sys/bus/usb/devices/usb2/power/runtime_status:suspended
/sys/bus/usb/devices/usb2/power/runtime_suspended_time:79636
/sys/bus/usb/devices/usb2/power/runtime_usage:0
/sys/bus/usb/devices/usb2/power/wakeup:disabled
/sys/bus/usb/devices/usb3/power/active_duration:40024
/sys/bus/usb/devices/usb3/power/async:enabled
/sys/bus/usb/devices/usb3/power/autosuspend:2
/sys/bus/usb/devices/usb3/power/autosuspend_delay_ms:2000
/sys/bus/usb/devices/usb3/power/connected_duration:119660
/sys/bus/usb/devices/usb3/power/control:auto
/sys/bus/usb/devices/usb3/power/level:auto
/sys/bus/usb/devices/usb3/power/runtime_active_kids:0
/sys/bus/usb/devices/usb3/power/runtime_active_time:40024
/sys/bus/usb/devices/usb3/power/runtime_enabled:enabled
/sys/bus/usb/devices/usb3/power/runtime_status:suspended
/sys/bus/usb/devices/usb3/power/runtime_suspended_time:79636
/sys/bus/usb/devices/usb3/power/runtime_usage:0
/sys/bus/usb/devices/usb3/power/wakeup:disabled
/sys/bus/usb/devices/usb4/power/active_duration:31056
/sys/bus/usb/devices/usb4/power/async:enabled
/sys/bus/usb/devices/usb4/power/autosuspend:2
/sys/bus/usb/devices/usb4/power/autosuspend_delay_ms:2000
/sys/bus/usb/devices/usb4/power/connected_duration:119656
/sys/bus/usb/devices/usb4/power/control:auto
/sys/bus/usb/devices/usb4/power/level:auto
/sys/bus/usb/devices/usb4/power/runtime_active_kids:0
/sys/bus/usb/devices/usb4/power/runtime_active_time:31056
/sys/bus/usb/devices/usb4/power/runtime_enabled:enabled
/sys/bus/usb/devices/usb4/power/runtime_status:suspended
/sys/bus/usb/devices/usb4/power/runtime_suspended_time:88600
/sys/bus/usb/devices/usb4/power/runtime_usage:0
/sys/bus/usb/devices/usb4/power/wakeup:disabled
/sys/bus/usb/devices/usb5/power/active_duration:4020
/sys/bus/usb/devices/usb5/power/async:enabled
/sys/bus/usb/devices/usb5/power/autosuspend:2
/sys/bus/usb/devices/usb5/power/autosuspend_delay_ms:2000
/sys/bus/usb/devices/usb5/power/connected_duration:119656
/sys/bus/usb/devices/usb5/power/control:auto
/sys/bus/usb/devices/usb5/power/level:auto
/sys/bus/usb/devices/usb5/power/runtime_active_kids:0
/sys/bus/usb/devices/usb5/power/runtime_active_time:4020
/sys/bus/usb/devices/usb5/power/runtime_enabled:enabled
/sys/bus/usb/devices/usb5/power/runtime_status:suspended
/sys/bus/usb/devices/usb5/power/runtime_suspended_time:115636
/sys/bus/usb/devices/usb5/power/runtime_usage:0
/sys/bus/usb/devices/usb5/power/wakeup:disabled
/sys/bus/usb/devices/usb6/power/active_duration:2104
/sys/bus/usb/devices/usb6/power/async:enabled
/sys/bus/usb/devices/usb6/power/autosuspend:2
/sys/bus/usb/devices/usb6/power/autosuspend_delay_ms:2000
/sys/bus/usb/devices/usb6/power/connected_duration:119652
/sys/bus/usb/devices/usb6/power/control:auto
/sys/bus/usb/devices/usb6/power/level:auto
/sys/bus/usb/devices/usb6/power/runtime_active_kids:0
/sys/bus/usb/devices/usb6/power/runtime_active_time:2104
/sys/bus/usb/devices/usb6/power/runtime_enabled:enabled
/sys/bus/usb/devices/usb6/power/runtime_status:suspended
/sys/bus/usb/devices/usb6/power/runtime_suspended_time:117548
/sys/bus/usb/devices/usb6/power/runtime_usage:0
/sys/bus/usb/devices/usb6/power/wakeup:disabled
/sys/bus/usb/devices/usb7/power/active_duration:4012
/sys/bus/usb/devices/usb7/power/async:enabled
/sys/bus/usb/devices/usb7/power/autosuspend:2
/sys/bus/usb/devices/usb7/power/autosuspend_delay_ms:2000
/sys/bus/usb/devices/usb7/power/connected_duration:119648
/sys/bus/usb/devices/usb7/power/control:auto
/sys/bus/usb/devices/usb7/power/level:auto
/sys/bus/usb/devices/usb7/power/runtime_active_kids:0
/sys/bus/usb/devices/usb7/power/runtime_active_time:4012
/sys/bus/usb/devices/usb7/power/runtime_enabled:enabled
/sys/bus/usb/devices/usb7/power/runtime_status:suspended
/sys/bus/usb/devices/usb7/power/runtime_suspended_time:115636
/sys/bus/usb/devices/usb7/power/runtime_usage:0
/sys/bus/usb/devices/usb7/power/wakeup:disabled
/sys/bus/usb/devices/usb8/power/active_duration:2104
/sys/bus/usb/devices/usb8/power/async:enabled
/sys/bus/usb/devices/usb8/power/autosuspend:2
/sys/bus/usb/devices/usb8/power/autosuspend_delay_ms:2000
/sys/bus/usb/devices/usb8/power/connected_duration:119644
/sys/bus/usb/devices/usb8/power/control:auto
/sys/bus/usb/devices/usb8/power/level:auto
/sys/bus/usb/devices/usb8/power/runtime_active_kids:0
/sys/bus/usb/devices/usb8/power/runtime_active_time:2104
/sys/bus/usb/devices/usb8/power/runtime_enabled:enabled
/sys/bus/usb/devices/usb8/power/runtime_status:suspended
/sys/bus/usb/devices/usb8/power/runtime_suspended_time:117540
/sys/bus/usb/devices/usb8/power/runtime_usage:0
/sys/bus/usb/devices/usb8/power/wakeup:disabled
/sys/bus/pci/devices/0000:00:00.0/power/async:enabled
/sys/bus/pci/devices/0000:00:00.0/power/control:auto
/sys/bus/pci/devices/0000:00:00.0/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:00.0/power/runtime_active_time:120464
/sys/bus/pci/devices/0000:00:00.0/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:00:00.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:00.0/power/runtime_suspended_time:0
/sys/bus/pci/devices/0000:00:00.0/power/runtime_usage:1
/sys/bus/pci/devices/0000:00:02.0/power/async:enabled
/sys/bus/pci/devices/0000:00:02.0/power/control:auto
/sys/bus/pci/devices/0000:00:02.0/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:02.0/power/runtime_active_time:104204
/sys/bus/pci/devices/0000:00:02.0/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:00:02.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:02.0/power/runtime_suspended_time:0
/sys/bus/pci/devices/0000:00:02.0/power/runtime_usage:1
/sys/bus/pci/devices/0000:00:02.1/power/async:enabled
/sys/bus/pci/devices/0000:00:02.1/power/control:auto
/sys/bus/pci/devices/0000:00:02.1/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:02.1/power/runtime_active_time:0
/sys/bus/pci/devices/0000:00:02.1/power/runtime_enabled:disabled
/sys/bus/pci/devices/0000:00:02.1/power/runtime_status:unsupported
/sys/bus/pci/devices/0000:00:02.1/power/runtime_suspended_time:0
/sys/bus/pci/devices/0000:00:02.1/power/runtime_usage:0
/sys/bus/pci/devices/0000:00:03.0/power/async:enabled
/sys/bus/pci/devices/0000:00:03.0/power/control:auto
/sys/bus/pci/devices/0000:00:03.0/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:03.0/power/runtime_active_time:105364
/sys/bus/pci/devices/0000:00:03.0/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:00:03.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:03.0/power/runtime_suspended_time:0
/sys/bus/pci/devices/0000:00:03.0/power/runtime_usage:1
/sys/bus/pci/devices/0000:00:03.0/power/wakeup:disabled
/sys/bus/pci/devices/0000:00:19.0/power/async:enabled
/sys/bus/pci/devices/0000:00:19.0/power/control:auto
/sys/bus/pci/devices/0000:00:19.0/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:19.0/power/runtime_active_time:27628
/sys/bus/pci/devices/0000:00:19.0/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:00:19.0/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:19.0/power/runtime_suspended_time:92316
/sys/bus/pci/devices/0000:00:19.0/power/runtime_usage:0
/sys/bus/pci/devices/0000:00:19.0/power/wakeup:disabled
/sys/bus/pci/devices/0000:00:1a.0/power/async:enabled
/sys/bus/pci/devices/0000:00:1a.0/power/control:auto
/sys/bus/pci/devices/0000:00:1a.0/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:1a.0/power/runtime_active_time:40024
/sys/bus/pci/devices/0000:00:1a.0/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:00:1a.0/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1a.0/power/runtime_suspended_time:79640
/sys/bus/pci/devices/0000:00:1a.0/power/runtime_usage:0
/sys/bus/pci/devices/0000:00:1a.0/power/wakeup:enabled
/sys/bus/pci/devices/0000:00:1a.0/power/wakeup_abort_count:0
/sys/bus/pci/devices/0000:00:1a.0/power/wakeup_active:0
/sys/bus/pci/devices/0000:00:1a.0/power/wakeup_active_count:0
/sys/bus/pci/devices/0000:00:1a.0/power/wakeup_count:0
/sys/bus/pci/devices/0000:00:1a.0/power/wakeup_expire_count:0
/sys/bus/pci/devices/0000:00:1a.0/power/wakeup_last_time_ms:1788
/sys/bus/pci/devices/0000:00:1a.0/power/wakeup_max_time_ms:0
/sys/bus/pci/devices/0000:00:1a.0/power/wakeup_total_time_ms:0
/sys/bus/pci/devices/0000:00:1a.1/power/async:enabled
/sys/bus/pci/devices/0000:00:1a.1/power/control:auto
/sys/bus/pci/devices/0000:00:1a.1/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:1a.1/power/runtime_active_time:37172
/sys/bus/pci/devices/0000:00:1a.1/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:00:1a.1/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1a.1/power/runtime_suspended_time:82488
/sys/bus/pci/devices/0000:00:1a.1/power/runtime_usage:0
/sys/bus/pci/devices/0000:00:1a.1/power/wakeup:enabled
/sys/bus/pci/devices/0000:00:1a.1/power/wakeup_abort_count:0
/sys/bus/pci/devices/0000:00:1a.1/power/wakeup_active:0
/sys/bus/pci/devices/0000:00:1a.1/power/wakeup_active_count:0
/sys/bus/pci/devices/0000:00:1a.1/power/wakeup_count:0
/sys/bus/pci/devices/0000:00:1a.1/power/wakeup_expire_count:0
/sys/bus/pci/devices/0000:00:1a.1/power/wakeup_last_time_ms:1789
/sys/bus/pci/devices/0000:00:1a.1/power/wakeup_max_time_ms:0
/sys/bus/pci/devices/0000:00:1a.1/power/wakeup_total_time_ms:0
/sys/bus/pci/devices/0000:00:1a.2/power/async:enabled
/sys/bus/pci/devices/0000:00:1a.2/power/control:auto
/sys/bus/pci/devices/0000:00:1a.2/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:1a.2/power/runtime_active_time:37172
/sys/bus/pci/devices/0000:00:1a.2/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:00:1a.2/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1a.2/power/runtime_suspended_time:82488
/sys/bus/pci/devices/0000:00:1a.2/power/runtime_usage:0
/sys/bus/pci/devices/0000:00:1a.2/power/wakeup:enabled
/sys/bus/pci/devices/0000:00:1a.2/power/wakeup_abort_count:0
/sys/bus/pci/devices/0000:00:1a.2/power/wakeup_active:0
/sys/bus/pci/devices/0000:00:1a.2/power/wakeup_active_count:0
/sys/bus/pci/devices/0000:00:1a.2/power/wakeup_count:0
/sys/bus/pci/devices/0000:00:1a.2/power/wakeup_expire_count:0
/sys/bus/pci/devices/0000:00:1a.2/power/wakeup_last_time_ms:1794
/sys/bus/pci/devices/0000:00:1a.2/power/wakeup_max_time_ms:0
/sys/bus/pci/devices/0000:00:1a.2/power/wakeup_total_time_ms:0
/sys/bus/pci/devices/0000:00:1a.7/power/async:enabled
/sys/bus/pci/devices/0000:00:1a.7/power/control:auto
/sys/bus/pci/devices/0000:00:1a.7/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:1a.7/power/runtime_active_time:40076
/sys/bus/pci/devices/0000:00:1a.7/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:00:1a.7/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1a.7/power/runtime_suspended_time:79624
/sys/bus/pci/devices/0000:00:1a.7/power/runtime_usage:0
/sys/bus/pci/devices/0000:00:1a.7/power/wakeup:enabled
/sys/bus/pci/devices/0000:00:1a.7/power/wakeup_abort_count:0
/sys/bus/pci/devices/0000:00:1a.7/power/wakeup_active:0
/sys/bus/pci/devices/0000:00:1a.7/power/wakeup_active_count:0
/sys/bus/pci/devices/0000:00:1a.7/power/wakeup_count:0
/sys/bus/pci/devices/0000:00:1a.7/power/wakeup_expire_count:0
/sys/bus/pci/devices/0000:00:1a.7/power/wakeup_last_time_ms:1765
/sys/bus/pci/devices/0000:00:1a.7/power/wakeup_max_time_ms:0
/sys/bus/pci/devices/0000:00:1a.7/power/wakeup_total_time_ms:0
/sys/bus/pci/devices/0000:00:1b.0/power/async:enabled
/sys/bus/pci/devices/0000:00:1b.0/power/control:auto
/sys/bus/pci/devices/0000:00:1b.0/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:1b.0/power/runtime_active_time:101776
/sys/bus/pci/devices/0000:00:1b.0/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:00:1b.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1b.0/power/runtime_suspended_time:0
/sys/bus/pci/devices/0000:00:1b.0/power/runtime_usage:1
/sys/bus/pci/devices/0000:00:1b.0/power/wakeup:disabled
/sys/bus/pci/devices/0000:00:1c.0/power/async:enabled
/sys/bus/pci/devices/0000:00:1c.0/power/control:auto
/sys/bus/pci/devices/0000:00:1c.0/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:1c.0/power/runtime_active_time:38056
/sys/bus/pci/devices/0000:00:1c.0/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:00:1c.0/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1c.0/power/runtime_suspended_time:82464
/sys/bus/pci/devices/0000:00:1c.0/power/runtime_usage:0
/sys/bus/pci/devices/0000:00:1c.0/power/wakeup:disabled
/sys/bus/pci/devices/0000:00:1c.1/power/async:enabled
/sys/bus/pci/devices/0000:00:1c.1/power/control:auto
/sys/bus/pci/devices/0000:00:1c.1/power/runtime_active_kids:1
/sys/bus/pci/devices/0000:00:1c.1/power/runtime_active_time:120520
/sys/bus/pci/devices/0000:00:1c.1/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:00:1c.1/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1c.1/power/runtime_suspended_time:0
/sys/bus/pci/devices/0000:00:1c.1/power/runtime_usage:0
/sys/bus/pci/devices/0000:00:1c.1/power/wakeup:disabled
/sys/bus/pci/devices/0000:00:1d.0/power/async:enabled
/sys/bus/pci/devices/0000:00:1d.0/power/control:auto
/sys/bus/pci/devices/0000:00:1d.0/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:1d.0/power/runtime_active_time:37212
/sys/bus/pci/devices/0000:00:1d.0/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:00:1d.0/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1d.0/power/runtime_suspended_time:82444
/sys/bus/pci/devices/0000:00:1d.0/power/runtime_usage:0
/sys/bus/pci/devices/0000:00:1d.0/power/wakeup:enabled
/sys/bus/pci/devices/0000:00:1d.0/power/wakeup_abort_count:0
/sys/bus/pci/devices/0000:00:1d.0/power/wakeup_active:0
/sys/bus/pci/devices/0000:00:1d.0/power/wakeup_active_count:0
/sys/bus/pci/devices/0000:00:1d.0/power/wakeup_count:0
/sys/bus/pci/devices/0000:00:1d.0/power/wakeup_expire_count:0
/sys/bus/pci/devices/0000:00:1d.0/power/wakeup_last_time_ms:1797
/sys/bus/pci/devices/0000:00:1d.0/power/wakeup_max_time_ms:0
/sys/bus/pci/devices/0000:00:1d.0/power/wakeup_total_time_ms:0
/sys/bus/pci/devices/0000:00:1d.1/power/async:enabled
/sys/bus/pci/devices/0000:00:1d.1/power/control:auto
/sys/bus/pci/devices/0000:00:1d.1/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:1d.1/power/runtime_active_time:37220
/sys/bus/pci/devices/0000:00:1d.1/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:00:1d.1/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1d.1/power/runtime_suspended_time:82436
/sys/bus/pci/devices/0000:00:1d.1/power/runtime_usage:0
/sys/bus/pci/devices/0000:00:1d.1/power/wakeup:enabled
/sys/bus/pci/devices/0000:00:1d.1/power/wakeup_abort_count:0
/sys/bus/pci/devices/0000:00:1d.1/power/wakeup_active:0
/sys/bus/pci/devices/0000:00:1d.1/power/wakeup_active_count:0
/sys/bus/pci/devices/0000:00:1d.1/power/wakeup_count:0
/sys/bus/pci/devices/0000:00:1d.1/power/wakeup_expire_count:0
/sys/bus/pci/devices/0000:00:1d.1/power/wakeup_last_time_ms:1802
/sys/bus/pci/devices/0000:00:1d.1/power/wakeup_max_time_ms:0
/sys/bus/pci/devices/0000:00:1d.1/power/wakeup_total_time_ms:0
/sys/bus/pci/devices/0000:00:1d.2/power/async:enabled
/sys/bus/pci/devices/0000:00:1d.2/power/control:auto
/sys/bus/pci/devices/0000:00:1d.2/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:1d.2/power/runtime_active_time:37220
/sys/bus/pci/devices/0000:00:1d.2/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:00:1d.2/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1d.2/power/runtime_suspended_time:82432
/sys/bus/pci/devices/0000:00:1d.2/power/runtime_usage:0
/sys/bus/pci/devices/0000:00:1d.2/power/wakeup:enabled
/sys/bus/pci/devices/0000:00:1d.2/power/wakeup_abort_count:0
/sys/bus/pci/devices/0000:00:1d.2/power/wakeup_active:0
/sys/bus/pci/devices/0000:00:1d.2/power/wakeup_active_count:0
/sys/bus/pci/devices/0000:00:1d.2/power/wakeup_count:0
/sys/bus/pci/devices/0000:00:1d.2/power/wakeup_expire_count:0
/sys/bus/pci/devices/0000:00:1d.2/power/wakeup_last_time_ms:1805
/sys/bus/pci/devices/0000:00:1d.2/power/wakeup_max_time_ms:0
/sys/bus/pci/devices/0000:00:1d.2/power/wakeup_total_time_ms:0
/sys/bus/pci/devices/0000:00:1d.7/power/async:enabled
/sys/bus/pci/devices/0000:00:1d.7/power/control:auto
/sys/bus/pci/devices/0000:00:1d.7/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:1d.7/power/runtime_active_time:40060
/sys/bus/pci/devices/0000:00:1d.7/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:00:1d.7/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1d.7/power/runtime_suspended_time:79628
/sys/bus/pci/devices/0000:00:1d.7/power/runtime_usage:0
/sys/bus/pci/devices/0000:00:1d.7/power/wakeup:enabled
/sys/bus/pci/devices/0000:00:1d.7/power/wakeup_abort_count:0
/sys/bus/pci/devices/0000:00:1d.7/power/wakeup_active:0
/sys/bus/pci/devices/0000:00:1d.7/power/wakeup_active_count:0
/sys/bus/pci/devices/0000:00:1d.7/power/wakeup_count:0
/sys/bus/pci/devices/0000:00:1d.7/power/wakeup_expire_count:0
/sys/bus/pci/devices/0000:00:1d.7/power/wakeup_last_time_ms:1781
/sys/bus/pci/devices/0000:00:1d.7/power/wakeup_max_time_ms:0
/sys/bus/pci/devices/0000:00:1d.7/power/wakeup_total_time_ms:0
/sys/bus/pci/devices/0000:00:1e.0/power/async:enabled
/sys/bus/pci/devices/0000:00:1e.0/power/control:auto
/sys/bus/pci/devices/0000:00:1e.0/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:1e.0/power/runtime_active_time:0
/sys/bus/pci/devices/0000:00:1e.0/power/runtime_enabled:disabled
/sys/bus/pci/devices/0000:00:1e.0/power/runtime_status:unsupported
/sys/bus/pci/devices/0000:00:1e.0/power/runtime_suspended_time:0
/sys/bus/pci/devices/0000:00:1e.0/power/runtime_usage:0
/sys/bus/pci/devices/0000:00:1e.0/power/wakeup:disabled
/sys/bus/pci/devices/0000:00:1f.0/power/async:enabled
/sys/bus/pci/devices/0000:00:1f.0/power/control:auto
/sys/bus/pci/devices/0000:00:1f.0/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:1f.0/power/runtime_active_time:0
/sys/bus/pci/devices/0000:00:1f.0/power/runtime_enabled:disabled
/sys/bus/pci/devices/0000:00:1f.0/power/runtime_status:unsupported
/sys/bus/pci/devices/0000:00:1f.0/power/runtime_suspended_time:0
/sys/bus/pci/devices/0000:00:1f.0/power/runtime_usage:0
/sys/bus/pci/devices/0000:00:1f.2/power/async:enabled
/sys/bus/pci/devices/0000:00:1f.2/power/control:auto
/sys/bus/pci/devices/0000:00:1f.2/power/runtime_active_kids:4
/sys/bus/pci/devices/0000:00:1f.2/power/runtime_active_time:119672
/sys/bus/pci/devices/0000:00:1f.2/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:00:1f.2/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1f.2/power/runtime_suspended_time:0
/sys/bus/pci/devices/0000:00:1f.2/power/runtime_usage:1
/sys/bus/pci/devices/0000:00:1f.2/power/wakeup:disabled
/sys/bus/pci/devices/0000:00:1f.3/power/async:enabled
/sys/bus/pci/devices/0000:00:1f.3/power/control:auto
/sys/bus/pci/devices/0000:00:1f.3/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:1f.3/power/runtime_active_time:105156
/sys/bus/pci/devices/0000:00:1f.3/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:00:1f.3/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1f.3/power/runtime_suspended_time:0
/sys/bus/pci/devices/0000:00:1f.3/power/runtime_usage:1
/sys/bus/pci/devices/0000:03:00.0/power/async:enabled
/sys/bus/pci/devices/0000:03:00.0/power/control:auto
/sys/bus/pci/devices/0000:03:00.0/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:03:00.0/power/runtime_active_time:104580
/sys/bus/pci/devices/0000:03:00.0/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:03:00.0/power/runtime_status:active
/sys/bus/pci/devices/0000:03:00.0/power/runtime_suspended_time:0
/sys/bus/pci/devices/0000:03:00.0/power/runtime_usage:1
/sys/bus/pci/devices/0000:03:00.0/power/wakeup:disabled
Bus 001 Device 004: ID 17ef:4807 Lenovo UVC Camera
Bus 002 Device 002: ID 1199:68a2 Sierra Wireless, Inc. 
Bus 003 Device 002: ID 08ff:2810 AuthenTec, Inc. AES2810
Bus 004 Device 002: ID 0a5c:2145 Broadcom Corp. Bluetooth with Enhanced Data Rate II
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 005 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 006 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 007 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 008 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub

--=-=-=
Content-Type: text/plain
Content-Disposition: inline; filename=powerstate-reverted.txt

/sys/bus/usb/devices/1-0:1.0/power/async:enabled
/sys/bus/usb/devices/1-0:1.0/power/runtime_active_kids:0
/sys/bus/usb/devices/1-0:1.0/power/runtime_enabled:enabled
/sys/bus/usb/devices/1-0:1.0/power/runtime_status:suspended
/sys/bus/usb/devices/1-0:1.0/power/runtime_usage:0
/sys/bus/usb/devices/1-6:1.0/power/async:enabled
/sys/bus/usb/devices/1-6:1.0/power/runtime_active_kids:0
/sys/bus/usb/devices/1-6:1.0/power/runtime_enabled:disabled
/sys/bus/usb/devices/1-6:1.0/power/runtime_status:unsupported
/sys/bus/usb/devices/1-6:1.0/power/runtime_usage:0
/sys/bus/usb/devices/1-6:1.1/power/async:enabled
/sys/bus/usb/devices/1-6:1.1/power/runtime_active_kids:0
/sys/bus/usb/devices/1-6:1.1/power/runtime_enabled:disabled
/sys/bus/usb/devices/1-6:1.1/power/runtime_status:unsupported
/sys/bus/usb/devices/1-6:1.1/power/runtime_usage:0
/sys/bus/usb/devices/1-6/power/active_duration:35204
/sys/bus/usb/devices/1-6/power/async:enabled
/sys/bus/usb/devices/1-6/power/autosuspend:2
/sys/bus/usb/devices/1-6/power/autosuspend_delay_ms:2000
/sys/bus/usb/devices/1-6/power/connected_duration:70960
/sys/bus/usb/devices/1-6/power/control:auto
/sys/bus/usb/devices/1-6/power/level:auto
/sys/bus/usb/devices/1-6/power/persist:1
/sys/bus/usb/devices/1-6/power/runtime_active_kids:0
/sys/bus/usb/devices/1-6/power/runtime_active_time:34976
/sys/bus/usb/devices/1-6/power/runtime_enabled:enabled
/sys/bus/usb/devices/1-6/power/runtime_status:suspended
/sys/bus/usb/devices/1-6/power/runtime_suspended_time:35740
/sys/bus/usb/devices/1-6/power/runtime_usage:0
/sys/bus/usb/devices/2-0:1.0/power/async:enabled
/sys/bus/usb/devices/2-0:1.0/power/runtime_active_kids:0
/sys/bus/usb/devices/2-0:1.0/power/runtime_enabled:enabled
/sys/bus/usb/devices/2-0:1.0/power/runtime_status:suspended
/sys/bus/usb/devices/2-0:1.0/power/runtime_usage:0
/sys/bus/usb/devices/2-4:1.0/power/async:enabled
/sys/bus/usb/devices/2-4:1.0/power/runtime_active_kids:0
/sys/bus/usb/devices/2-4:1.0/power/runtime_enabled:enabled
/sys/bus/usb/devices/2-4:1.0/power/runtime_status:suspended
/sys/bus/usb/devices/2-4:1.0/power/runtime_usage:0
/sys/bus/usb/devices/2-4:1.19/power/async:enabled
/sys/bus/usb/devices/2-4:1.19/power/runtime_active_kids:0
/sys/bus/usb/devices/2-4:1.19/power/runtime_enabled:enabled
/sys/bus/usb/devices/2-4:1.19/power/runtime_status:suspended
/sys/bus/usb/devices/2-4:1.19/power/runtime_usage:0
/sys/bus/usb/devices/2-4:1.20/power/async:enabled
/sys/bus/usb/devices/2-4:1.20/power/runtime_active_kids:0
/sys/bus/usb/devices/2-4:1.20/power/runtime_enabled:disabled
/sys/bus/usb/devices/2-4:1.20/power/runtime_status:unsupported
/sys/bus/usb/devices/2-4:1.20/power/runtime_usage:0
/sys/bus/usb/devices/2-4:1.2/power/async:enabled
/sys/bus/usb/devices/2-4:1.2/power/runtime_active_kids:0
/sys/bus/usb/devices/2-4:1.2/power/runtime_enabled:enabled
/sys/bus/usb/devices/2-4:1.2/power/runtime_status:suspended
/sys/bus/usb/devices/2-4:1.2/power/runtime_usage:0
/sys/bus/usb/devices/2-4:1.3/power/async:enabled
/sys/bus/usb/devices/2-4:1.3/power/runtime_active_kids:0
/sys/bus/usb/devices/2-4:1.3/power/runtime_enabled:enabled
/sys/bus/usb/devices/2-4:1.3/power/runtime_status:suspended
/sys/bus/usb/devices/2-4:1.3/power/runtime_usage:0
/sys/bus/usb/devices/2-4:1.8/power/async:enabled
/sys/bus/usb/devices/2-4:1.8/power/runtime_active_kids:0
/sys/bus/usb/devices/2-4:1.8/power/runtime_enabled:enabled
/sys/bus/usb/devices/2-4:1.8/power/runtime_status:suspended
/sys/bus/usb/devices/2-4:1.8/power/runtime_usage:0
/sys/bus/usb/devices/2-4/power/active_duration:35056
/sys/bus/usb/devices/2-4/power/async:enabled
/sys/bus/usb/devices/2-4/power/autosuspend:2
/sys/bus/usb/devices/2-4/power/autosuspend_delay_ms:2000
/sys/bus/usb/devices/2-4/power/connected_duration:70708
/sys/bus/usb/devices/2-4/power/control:auto
/sys/bus/usb/devices/2-4/power/level:auto
/sys/bus/usb/devices/2-4/power/persist:1
/sys/bus/usb/devices/2-4/power/runtime_active_kids:0
/sys/bus/usb/devices/2-4/power/runtime_active_time:34828
/sys/bus/usb/devices/2-4/power/runtime_enabled:enabled
/sys/bus/usb/devices/2-4/power/runtime_status:suspended
/sys/bus/usb/devices/2-4/power/runtime_suspended_time:35636
/sys/bus/usb/devices/2-4/power/runtime_usage:0
/sys/bus/usb/devices/2-4/power/wakeup:disabled
/sys/bus/usb/devices/3-0:1.0/power/async:enabled
/sys/bus/usb/devices/3-0:1.0/power/runtime_active_kids:0
/sys/bus/usb/devices/3-0:1.0/power/runtime_enabled:enabled
/sys/bus/usb/devices/3-0:1.0/power/runtime_status:suspended
/sys/bus/usb/devices/3-0:1.0/power/runtime_usage:0
/sys/bus/usb/devices/3-2:1.0/power/async:enabled
/sys/bus/usb/devices/3-2:1.0/power/runtime_active_kids:0
/sys/bus/usb/devices/3-2:1.0/power/runtime_enabled:disabled
/sys/bus/usb/devices/3-2:1.0/power/runtime_status:unsupported
/sys/bus/usb/devices/3-2:1.0/power/runtime_usage:0
/sys/bus/usb/devices/3-2/power/active_duration:34820
/sys/bus/usb/devices/3-2/power/async:enabled
/sys/bus/usb/devices/3-2/power/autosuspend:2
/sys/bus/usb/devices/3-2/power/autosuspend_delay_ms:2000
/sys/bus/usb/devices/3-2/power/connected_duration:70324
/sys/bus/usb/devices/3-2/power/control:auto
/sys/bus/usb/devices/3-2/power/level:auto
/sys/bus/usb/devices/3-2/power/persist:1
/sys/bus/usb/devices/3-2/power/runtime_active_kids:0
/sys/bus/usb/devices/3-2/power/runtime_active_time:34580
/sys/bus/usb/devices/3-2/power/runtime_enabled:enabled
/sys/bus/usb/devices/3-2/power/runtime_status:suspended
/sys/bus/usb/devices/3-2/power/runtime_suspended_time:35488
/sys/bus/usb/devices/3-2/power/runtime_usage:0
/sys/bus/usb/devices/3-2/power/wakeup:disabled
/sys/bus/usb/devices/4-0:1.0/power/async:enabled
/sys/bus/usb/devices/4-0:1.0/power/runtime_active_kids:0
/sys/bus/usb/devices/4-0:1.0/power/runtime_enabled:enabled
/sys/bus/usb/devices/4-0:1.0/power/runtime_status:suspended
/sys/bus/usb/devices/4-0:1.0/power/runtime_usage:0
/sys/bus/usb/devices/4-2:1.0/power/async:enabled
/sys/bus/usb/devices/4-2:1.0/power/runtime_active_kids:0
/sys/bus/usb/devices/4-2:1.0/power/runtime_enabled:enabled
/sys/bus/usb/devices/4-2:1.0/power/runtime_status:suspended
/sys/bus/usb/devices/4-2:1.0/power/runtime_usage:0
/sys/bus/usb/devices/4-2:1.1/power/async:enabled
/sys/bus/usb/devices/4-2:1.1/power/runtime_active_kids:0
/sys/bus/usb/devices/4-2:1.1/power/runtime_enabled:enabled
/sys/bus/usb/devices/4-2:1.1/power/runtime_status:suspended
/sys/bus/usb/devices/4-2:1.1/power/runtime_usage:0
/sys/bus/usb/devices/4-2:1.2/power/async:enabled
/sys/bus/usb/devices/4-2:1.2/power/runtime_active_kids:0
/sys/bus/usb/devices/4-2:1.2/power/runtime_enabled:disabled
/sys/bus/usb/devices/4-2:1.2/power/runtime_status:unsupported
/sys/bus/usb/devices/4-2:1.2/power/runtime_usage:0
/sys/bus/usb/devices/4-2:1.3/power/async:enabled
/sys/bus/usb/devices/4-2:1.3/power/runtime_active_kids:0
/sys/bus/usb/devices/4-2:1.3/power/runtime_enabled:disabled
/sys/bus/usb/devices/4-2:1.3/power/runtime_status:unsupported
/sys/bus/usb/devices/4-2:1.3/power/runtime_usage:0
/sys/bus/usb/devices/4-2/power/active_duration:25788
/sys/bus/usb/devices/4-2/power/async:enabled
/sys/bus/usb/devices/4-2/power/autosuspend:2
/sys/bus/usb/devices/4-2/power/autosuspend_delay_ms:2000
/sys/bus/usb/devices/4-2/power/connected_duration:69908
/sys/bus/usb/devices/4-2/power/control:auto
/sys/bus/usb/devices/4-2/power/level:auto
/sys/bus/usb/devices/4-2/power/persist:1
/sys/bus/usb/devices/4-2/power/runtime_active_kids:0
/sys/bus/usb/devices/4-2/power/runtime_active_time:25612
/sys/bus/usb/devices/4-2/power/runtime_enabled:enabled
/sys/bus/usb/devices/4-2/power/runtime_status:suspended
/sys/bus/usb/devices/4-2/power/runtime_suspended_time:44040
/sys/bus/usb/devices/4-2/power/runtime_usage:0
/sys/bus/usb/devices/4-2/power/wakeup:disabled
/sys/bus/usb/devices/5-0:1.0/power/async:enabled
/sys/bus/usb/devices/5-0:1.0/power/runtime_active_kids:0
/sys/bus/usb/devices/5-0:1.0/power/runtime_enabled:enabled
/sys/bus/usb/devices/5-0:1.0/power/runtime_status:suspended
/sys/bus/usb/devices/5-0:1.0/power/runtime_usage:0
/sys/bus/usb/devices/6-0:1.0/power/async:enabled
/sys/bus/usb/devices/6-0:1.0/power/runtime_active_kids:0
/sys/bus/usb/devices/6-0:1.0/power/runtime_enabled:enabled
/sys/bus/usb/devices/6-0:1.0/power/runtime_status:suspended
/sys/bus/usb/devices/6-0:1.0/power/runtime_usage:0
/sys/bus/usb/devices/7-0:1.0/power/async:enabled
/sys/bus/usb/devices/7-0:1.0/power/runtime_active_kids:0
/sys/bus/usb/devices/7-0:1.0/power/runtime_enabled:enabled
/sys/bus/usb/devices/7-0:1.0/power/runtime_status:suspended
/sys/bus/usb/devices/7-0:1.0/power/runtime_usage:0
/sys/bus/usb/devices/8-0:1.0/power/async:enabled
/sys/bus/usb/devices/8-0:1.0/power/runtime_active_kids:0
/sys/bus/usb/devices/8-0:1.0/power/runtime_enabled:enabled
/sys/bus/usb/devices/8-0:1.0/power/runtime_status:suspended
/sys/bus/usb/devices/8-0:1.0/power/runtime_usage:0
/sys/bus/usb/devices/usb1/power/active_duration:38188
/sys/bus/usb/devices/usb1/power/async:enabled
/sys/bus/usb/devices/usb1/power/autosuspend:2
/sys/bus/usb/devices/usb1/power/autosuspend_delay_ms:2000
/sys/bus/usb/devices/usb1/power/connected_duration:71404
/sys/bus/usb/devices/usb1/power/control:auto
/sys/bus/usb/devices/usb1/power/level:auto
/sys/bus/usb/devices/usb1/power/runtime_active_kids:0
/sys/bus/usb/devices/usb1/power/runtime_active_time:38168
/sys/bus/usb/devices/usb1/power/runtime_enabled:enabled
/sys/bus/usb/devices/usb1/power/runtime_status:suspended
/sys/bus/usb/devices/usb1/power/runtime_suspended_time:33216
/sys/bus/usb/devices/usb1/power/runtime_usage:0
/sys/bus/usb/devices/usb1/power/wakeup:disabled
/sys/bus/usb/devices/usb2/power/active_duration:38168
/sys/bus/usb/devices/usb2/power/async:enabled
/sys/bus/usb/devices/usb2/power/autosuspend:2
/sys/bus/usb/devices/usb2/power/autosuspend_delay_ms:2000
/sys/bus/usb/devices/usb2/power/connected_duration:71384
/sys/bus/usb/devices/usb2/power/control:auto
/sys/bus/usb/devices/usb2/power/level:auto
/sys/bus/usb/devices/usb2/power/runtime_active_kids:0
/sys/bus/usb/devices/usb2/power/runtime_active_time:38152
/sys/bus/usb/devices/usb2/power/runtime_enabled:enabled
/sys/bus/usb/devices/usb2/power/runtime_status:suspended
/sys/bus/usb/devices/usb2/power/runtime_suspended_time:33216
/sys/bus/usb/devices/usb2/power/runtime_usage:0
/sys/bus/usb/devices/usb2/power/wakeup:disabled
/sys/bus/usb/devices/usb3/power/active_duration:38152
/sys/bus/usb/devices/usb3/power/async:enabled
/sys/bus/usb/devices/usb3/power/autosuspend:2
/sys/bus/usb/devices/usb3/power/autosuspend_delay_ms:2000
/sys/bus/usb/devices/usb3/power/connected_duration:71372
/sys/bus/usb/devices/usb3/power/control:auto
/sys/bus/usb/devices/usb3/power/level:auto
/sys/bus/usb/devices/usb3/power/runtime_active_kids:0
/sys/bus/usb/devices/usb3/power/runtime_active_time:38152
/sys/bus/usb/devices/usb3/power/runtime_enabled:enabled
/sys/bus/usb/devices/usb3/power/runtime_status:suspended
/sys/bus/usb/devices/usb3/power/runtime_suspended_time:33220
/sys/bus/usb/devices/usb3/power/runtime_usage:0
/sys/bus/usb/devices/usb3/power/wakeup:disabled
/sys/bus/usb/devices/usb4/power/active_duration:30168
/sys/bus/usb/devices/usb4/power/async:enabled
/sys/bus/usb/devices/usb4/power/autosuspend:2
/sys/bus/usb/devices/usb4/power/autosuspend_delay_ms:2000
/sys/bus/usb/devices/usb4/power/connected_duration:71372
/sys/bus/usb/devices/usb4/power/control:auto
/sys/bus/usb/devices/usb4/power/level:auto
/sys/bus/usb/devices/usb4/power/runtime_active_kids:0
/sys/bus/usb/devices/usb4/power/runtime_active_time:30168
/sys/bus/usb/devices/usb4/power/runtime_enabled:enabled
/sys/bus/usb/devices/usb4/power/runtime_status:suspended
/sys/bus/usb/devices/usb4/power/runtime_suspended_time:41204
/sys/bus/usb/devices/usb4/power/runtime_usage:0
/sys/bus/usb/devices/usb4/power/wakeup:disabled
/sys/bus/usb/devices/usb5/power/active_duration:4156
/sys/bus/usb/devices/usb5/power/async:enabled
/sys/bus/usb/devices/usb5/power/autosuspend:2
/sys/bus/usb/devices/usb5/power/autosuspend_delay_ms:2000
/sys/bus/usb/devices/usb5/power/connected_duration:71360
/sys/bus/usb/devices/usb5/power/control:auto
/sys/bus/usb/devices/usb5/power/level:auto
/sys/bus/usb/devices/usb5/power/runtime_active_kids:0
/sys/bus/usb/devices/usb5/power/runtime_active_time:4156
/sys/bus/usb/devices/usb5/power/runtime_enabled:enabled
/sys/bus/usb/devices/usb5/power/runtime_status:suspended
/sys/bus/usb/devices/usb5/power/runtime_suspended_time:67204
/sys/bus/usb/devices/usb5/power/runtime_usage:0
/sys/bus/usb/devices/usb5/power/wakeup:disabled
/sys/bus/usb/devices/usb6/power/active_duration:2136
/sys/bus/usb/devices/usb6/power/async:enabled
/sys/bus/usb/devices/usb6/power/autosuspend:2
/sys/bus/usb/devices/usb6/power/autosuspend_delay_ms:2000
/sys/bus/usb/devices/usb6/power/connected_duration:71356
/sys/bus/usb/devices/usb6/power/control:auto
/sys/bus/usb/devices/usb6/power/level:auto
/sys/bus/usb/devices/usb6/power/runtime_active_kids:0
/sys/bus/usb/devices/usb6/power/runtime_active_time:2136
/sys/bus/usb/devices/usb6/power/runtime_enabled:enabled
/sys/bus/usb/devices/usb6/power/runtime_status:suspended
/sys/bus/usb/devices/usb6/power/runtime_suspended_time:69224
/sys/bus/usb/devices/usb6/power/runtime_usage:0
/sys/bus/usb/devices/usb6/power/wakeup:disabled
/sys/bus/usb/devices/usb7/power/active_duration:4148
/sys/bus/usb/devices/usb7/power/async:enabled
/sys/bus/usb/devices/usb7/power/autosuspend:2
/sys/bus/usb/devices/usb7/power/autosuspend_delay_ms:2000
/sys/bus/usb/devices/usb7/power/connected_duration:71356
/sys/bus/usb/devices/usb7/power/control:auto
/sys/bus/usb/devices/usb7/power/level:auto
/sys/bus/usb/devices/usb7/power/runtime_active_kids:0
/sys/bus/usb/devices/usb7/power/runtime_active_time:4148
/sys/bus/usb/devices/usb7/power/runtime_enabled:enabled
/sys/bus/usb/devices/usb7/power/runtime_status:suspended
/sys/bus/usb/devices/usb7/power/runtime_suspended_time:67208
/sys/bus/usb/devices/usb7/power/runtime_usage:0
/sys/bus/usb/devices/usb7/power/wakeup:disabled
/sys/bus/usb/devices/usb8/power/active_duration:2128
/sys/bus/usb/devices/usb8/power/async:enabled
/sys/bus/usb/devices/usb8/power/autosuspend:2
/sys/bus/usb/devices/usb8/power/autosuspend_delay_ms:2000
/sys/bus/usb/devices/usb8/power/connected_duration:71352
/sys/bus/usb/devices/usb8/power/control:auto
/sys/bus/usb/devices/usb8/power/level:auto
/sys/bus/usb/devices/usb8/power/runtime_active_kids:0
/sys/bus/usb/devices/usb8/power/runtime_active_time:2128
/sys/bus/usb/devices/usb8/power/runtime_enabled:enabled
/sys/bus/usb/devices/usb8/power/runtime_status:suspended
/sys/bus/usb/devices/usb8/power/runtime_suspended_time:69224
/sys/bus/usb/devices/usb8/power/runtime_usage:0
/sys/bus/usb/devices/usb8/power/wakeup:disabled
/sys/bus/pci/devices/0000:00:00.0/power/async:enabled
/sys/bus/pci/devices/0000:00:00.0/power/control:auto
/sys/bus/pci/devices/0000:00:00.0/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:00.0/power/runtime_active_time:72052
/sys/bus/pci/devices/0000:00:00.0/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:00:00.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:00.0/power/runtime_suspended_time:0
/sys/bus/pci/devices/0000:00:00.0/power/runtime_usage:1
/sys/bus/pci/devices/0000:00:02.0/power/async:enabled
/sys/bus/pci/devices/0000:00:02.0/power/control:auto
/sys/bus/pci/devices/0000:00:02.0/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:02.0/power/runtime_active_time:57832
/sys/bus/pci/devices/0000:00:02.0/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:00:02.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:02.0/power/runtime_suspended_time:0
/sys/bus/pci/devices/0000:00:02.0/power/runtime_usage:1
/sys/bus/pci/devices/0000:00:02.1/power/async:enabled
/sys/bus/pci/devices/0000:00:02.1/power/control:auto
/sys/bus/pci/devices/0000:00:02.1/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:02.1/power/runtime_active_time:0
/sys/bus/pci/devices/0000:00:02.1/power/runtime_enabled:disabled
/sys/bus/pci/devices/0000:00:02.1/power/runtime_status:unsupported
/sys/bus/pci/devices/0000:00:02.1/power/runtime_suspended_time:0
/sys/bus/pci/devices/0000:00:02.1/power/runtime_usage:0
/sys/bus/pci/devices/0000:00:03.0/power/async:enabled
/sys/bus/pci/devices/0000:00:03.0/power/control:auto
/sys/bus/pci/devices/0000:00:03.0/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:03.0/power/runtime_active_time:58044
/sys/bus/pci/devices/0000:00:03.0/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:00:03.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:03.0/power/runtime_suspended_time:0
/sys/bus/pci/devices/0000:00:03.0/power/runtime_usage:1
/sys/bus/pci/devices/0000:00:03.0/power/wakeup:disabled
/sys/bus/pci/devices/0000:00:19.0/power/async:enabled
/sys/bus/pci/devices/0000:00:19.0/power/control:auto
/sys/bus/pci/devices/0000:00:19.0/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:19.0/power/runtime_active_time:26732
/sys/bus/pci/devices/0000:00:19.0/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:00:19.0/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:19.0/power/runtime_suspended_time:44896
/sys/bus/pci/devices/0000:00:19.0/power/runtime_usage:0
/sys/bus/pci/devices/0000:00:19.0/power/wakeup:disabled
/sys/bus/pci/devices/0000:00:1a.0/power/async:enabled
/sys/bus/pci/devices/0000:00:1a.0/power/control:auto
/sys/bus/pci/devices/0000:00:1a.0/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:1a.0/power/runtime_active_time:38152
/sys/bus/pci/devices/0000:00:1a.0/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:00:1a.0/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1a.0/power/runtime_suspended_time:33224
/sys/bus/pci/devices/0000:00:1a.0/power/runtime_usage:0
/sys/bus/pci/devices/0000:00:1a.0/power/wakeup:enabled
/sys/bus/pci/devices/0000:00:1a.0/power/wakeup_abort_count:0
/sys/bus/pci/devices/0000:00:1a.0/power/wakeup_active:0
/sys/bus/pci/devices/0000:00:1a.0/power/wakeup_active_count:0
/sys/bus/pci/devices/0000:00:1a.0/power/wakeup_count:0
/sys/bus/pci/devices/0000:00:1a.0/power/wakeup_expire_count:0
/sys/bus/pci/devices/0000:00:1a.0/power/wakeup_last_time_ms:1659
/sys/bus/pci/devices/0000:00:1a.0/power/wakeup_max_time_ms:0
/sys/bus/pci/devices/0000:00:1a.0/power/wakeup_total_time_ms:0
/sys/bus/pci/devices/0000:00:1a.1/power/async:enabled
/sys/bus/pci/devices/0000:00:1a.1/power/control:auto
/sys/bus/pci/devices/0000:00:1a.1/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:1a.1/power/runtime_active_time:35404
/sys/bus/pci/devices/0000:00:1a.1/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:00:1a.1/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1a.1/power/runtime_suspended_time:35972
/sys/bus/pci/devices/0000:00:1a.1/power/runtime_usage:0
/sys/bus/pci/devices/0000:00:1a.1/power/wakeup:enabled
/sys/bus/pci/devices/0000:00:1a.1/power/wakeup_abort_count:0
/sys/bus/pci/devices/0000:00:1a.1/power/wakeup_active:0
/sys/bus/pci/devices/0000:00:1a.1/power/wakeup_active_count:0
/sys/bus/pci/devices/0000:00:1a.1/power/wakeup_count:0
/sys/bus/pci/devices/0000:00:1a.1/power/wakeup_expire_count:0
/sys/bus/pci/devices/0000:00:1a.1/power/wakeup_last_time_ms:1660
/sys/bus/pci/devices/0000:00:1a.1/power/wakeup_max_time_ms:0
/sys/bus/pci/devices/0000:00:1a.1/power/wakeup_total_time_ms:0
/sys/bus/pci/devices/0000:00:1a.2/power/async:enabled
/sys/bus/pci/devices/0000:00:1a.2/power/control:auto
/sys/bus/pci/devices/0000:00:1a.2/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:1a.2/power/runtime_active_time:35396
/sys/bus/pci/devices/0000:00:1a.2/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:00:1a.2/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1a.2/power/runtime_suspended_time:35968
/sys/bus/pci/devices/0000:00:1a.2/power/runtime_usage:0
/sys/bus/pci/devices/0000:00:1a.2/power/wakeup:enabled
/sys/bus/pci/devices/0000:00:1a.2/power/wakeup_abort_count:0
/sys/bus/pci/devices/0000:00:1a.2/power/wakeup_active:0
/sys/bus/pci/devices/0000:00:1a.2/power/wakeup_active_count:0
/sys/bus/pci/devices/0000:00:1a.2/power/wakeup_count:0
/sys/bus/pci/devices/0000:00:1a.2/power/wakeup_expire_count:0
/sys/bus/pci/devices/0000:00:1a.2/power/wakeup_last_time_ms:1672
/sys/bus/pci/devices/0000:00:1a.2/power/wakeup_max_time_ms:0
/sys/bus/pci/devices/0000:00:1a.2/power/wakeup_total_time_ms:0
/sys/bus/pci/devices/0000:00:1a.7/power/async:enabled
/sys/bus/pci/devices/0000:00:1a.7/power/control:auto
/sys/bus/pci/devices/0000:00:1a.7/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:1a.7/power/runtime_active_time:38220
/sys/bus/pci/devices/0000:00:1a.7/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:00:1a.7/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1a.7/power/runtime_suspended_time:33196
/sys/bus/pci/devices/0000:00:1a.7/power/runtime_usage:0
/sys/bus/pci/devices/0000:00:1a.7/power/wakeup:enabled
/sys/bus/pci/devices/0000:00:1a.7/power/wakeup_abort_count:0
/sys/bus/pci/devices/0000:00:1a.7/power/wakeup_active:0
/sys/bus/pci/devices/0000:00:1a.7/power/wakeup_active_count:0
/sys/bus/pci/devices/0000:00:1a.7/power/wakeup_count:0
/sys/bus/pci/devices/0000:00:1a.7/power/wakeup_expire_count:0
/sys/bus/pci/devices/0000:00:1a.7/power/wakeup_last_time_ms:1641
/sys/bus/pci/devices/0000:00:1a.7/power/wakeup_max_time_ms:0
/sys/bus/pci/devices/0000:00:1a.7/power/wakeup_total_time_ms:0
/sys/bus/pci/devices/0000:00:1b.0/power/async:enabled
/sys/bus/pci/devices/0000:00:1b.0/power/control:auto
/sys/bus/pci/devices/0000:00:1b.0/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:1b.0/power/runtime_active_time:54808
/sys/bus/pci/devices/0000:00:1b.0/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:00:1b.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1b.0/power/runtime_suspended_time:0
/sys/bus/pci/devices/0000:00:1b.0/power/runtime_usage:1
/sys/bus/pci/devices/0000:00:1b.0/power/wakeup:disabled
/sys/bus/pci/devices/0000:00:1c.0/power/async:enabled
/sys/bus/pci/devices/0000:00:1c.0/power/control:auto
/sys/bus/pci/devices/0000:00:1c.0/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:1c.0/power/runtime_active_time:36172
/sys/bus/pci/devices/0000:00:1c.0/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:00:1c.0/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1c.0/power/runtime_suspended_time:35940
/sys/bus/pci/devices/0000:00:1c.0/power/runtime_usage:0
/sys/bus/pci/devices/0000:00:1c.0/power/wakeup:disabled
/sys/bus/pci/devices/0000:00:1c.1/power/async:enabled
/sys/bus/pci/devices/0000:00:1c.1/power/control:auto
/sys/bus/pci/devices/0000:00:1c.1/power/runtime_active_kids:1
/sys/bus/pci/devices/0000:00:1c.1/power/runtime_active_time:72108
/sys/bus/pci/devices/0000:00:1c.1/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:00:1c.1/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1c.1/power/runtime_suspended_time:0
/sys/bus/pci/devices/0000:00:1c.1/power/runtime_usage:0
/sys/bus/pci/devices/0000:00:1c.1/power/wakeup:disabled
/sys/bus/pci/devices/0000:00:1d.0/power/async:enabled
/sys/bus/pci/devices/0000:00:1d.0/power/control:auto
/sys/bus/pci/devices/0000:00:1d.0/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:1d.0/power/runtime_active_time:35432
/sys/bus/pci/devices/0000:00:1d.0/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:00:1d.0/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1d.0/power/runtime_suspended_time:35932
/sys/bus/pci/devices/0000:00:1d.0/power/runtime_usage:0
/sys/bus/pci/devices/0000:00:1d.0/power/wakeup:enabled
/sys/bus/pci/devices/0000:00:1d.0/power/wakeup_abort_count:0
/sys/bus/pci/devices/0000:00:1d.0/power/wakeup_active:0
/sys/bus/pci/devices/0000:00:1d.0/power/wakeup_active_count:0
/sys/bus/pci/devices/0000:00:1d.0/power/wakeup_count:0
/sys/bus/pci/devices/0000:00:1d.0/power/wakeup_expire_count:0
/sys/bus/pci/devices/0000:00:1d.0/power/wakeup_last_time_ms:1674
/sys/bus/pci/devices/0000:00:1d.0/power/wakeup_max_time_ms:0
/sys/bus/pci/devices/0000:00:1d.0/power/wakeup_total_time_ms:0
/sys/bus/pci/devices/0000:00:1d.1/power/async:enabled
/sys/bus/pci/devices/0000:00:1d.1/power/control:auto
/sys/bus/pci/devices/0000:00:1d.1/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:1d.1/power/runtime_active_time:35440
/sys/bus/pci/devices/0000:00:1d.1/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:00:1d.1/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1d.1/power/runtime_suspended_time:35924
/sys/bus/pci/devices/0000:00:1d.1/power/runtime_usage:0
/sys/bus/pci/devices/0000:00:1d.1/power/wakeup:enabled
/sys/bus/pci/devices/0000:00:1d.1/power/wakeup_abort_count:0
/sys/bus/pci/devices/0000:00:1d.1/power/wakeup_active:0
/sys/bus/pci/devices/0000:00:1d.1/power/wakeup_active_count:0
/sys/bus/pci/devices/0000:00:1d.1/power/wakeup_count:0
/sys/bus/pci/devices/0000:00:1d.1/power/wakeup_expire_count:0
/sys/bus/pci/devices/0000:00:1d.1/power/wakeup_last_time_ms:1680
/sys/bus/pci/devices/0000:00:1d.1/power/wakeup_max_time_ms:0
/sys/bus/pci/devices/0000:00:1d.1/power/wakeup_total_time_ms:0
/sys/bus/pci/devices/0000:00:1d.2/power/async:enabled
/sys/bus/pci/devices/0000:00:1d.2/power/control:auto
/sys/bus/pci/devices/0000:00:1d.2/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:1d.2/power/runtime_active_time:35440
/sys/bus/pci/devices/0000:00:1d.2/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:00:1d.2/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1d.2/power/runtime_suspended_time:35916
/sys/bus/pci/devices/0000:00:1d.2/power/runtime_usage:0
/sys/bus/pci/devices/0000:00:1d.2/power/wakeup:enabled
/sys/bus/pci/devices/0000:00:1d.2/power/wakeup_abort_count:0
/sys/bus/pci/devices/0000:00:1d.2/power/wakeup_active:0
/sys/bus/pci/devices/0000:00:1d.2/power/wakeup_active_count:0
/sys/bus/pci/devices/0000:00:1d.2/power/wakeup_count:0
/sys/bus/pci/devices/0000:00:1d.2/power/wakeup_expire_count:0
/sys/bus/pci/devices/0000:00:1d.2/power/wakeup_last_time_ms:1682
/sys/bus/pci/devices/0000:00:1d.2/power/wakeup_max_time_ms:0
/sys/bus/pci/devices/0000:00:1d.2/power/wakeup_total_time_ms:0
/sys/bus/pci/devices/0000:00:1d.7/power/async:enabled
/sys/bus/pci/devices/0000:00:1d.7/power/control:auto
/sys/bus/pci/devices/0000:00:1d.7/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:1d.7/power/runtime_active_time:38200
/sys/bus/pci/devices/0000:00:1d.7/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:00:1d.7/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1d.7/power/runtime_suspended_time:33196
/sys/bus/pci/devices/0000:00:1d.7/power/runtime_usage:0
/sys/bus/pci/devices/0000:00:1d.7/power/wakeup:enabled
/sys/bus/pci/devices/0000:00:1d.7/power/wakeup_abort_count:0
/sys/bus/pci/devices/0000:00:1d.7/power/wakeup_active:0
/sys/bus/pci/devices/0000:00:1d.7/power/wakeup_active_count:0
/sys/bus/pci/devices/0000:00:1d.7/power/wakeup_count:0
/sys/bus/pci/devices/0000:00:1d.7/power/wakeup_expire_count:0
/sys/bus/pci/devices/0000:00:1d.7/power/wakeup_last_time_ms:1657
/sys/bus/pci/devices/0000:00:1d.7/power/wakeup_max_time_ms:0
/sys/bus/pci/devices/0000:00:1d.7/power/wakeup_total_time_ms:0
/sys/bus/pci/devices/0000:00:1e.0/power/async:enabled
/sys/bus/pci/devices/0000:00:1e.0/power/control:auto
/sys/bus/pci/devices/0000:00:1e.0/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:1e.0/power/runtime_active_time:0
/sys/bus/pci/devices/0000:00:1e.0/power/runtime_enabled:disabled
/sys/bus/pci/devices/0000:00:1e.0/power/runtime_status:unsupported
/sys/bus/pci/devices/0000:00:1e.0/power/runtime_suspended_time:0
/sys/bus/pci/devices/0000:00:1e.0/power/runtime_usage:0
/sys/bus/pci/devices/0000:00:1e.0/power/wakeup:disabled
/sys/bus/pci/devices/0000:00:1f.0/power/async:enabled
/sys/bus/pci/devices/0000:00:1f.0/power/control:auto
/sys/bus/pci/devices/0000:00:1f.0/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:1f.0/power/runtime_active_time:0
/sys/bus/pci/devices/0000:00:1f.0/power/runtime_enabled:disabled
/sys/bus/pci/devices/0000:00:1f.0/power/runtime_status:unsupported
/sys/bus/pci/devices/0000:00:1f.0/power/runtime_suspended_time:0
/sys/bus/pci/devices/0000:00:1f.0/power/runtime_usage:0
/sys/bus/pci/devices/0000:00:1f.2/power/async:enabled
/sys/bus/pci/devices/0000:00:1f.2/power/control:auto
/sys/bus/pci/devices/0000:00:1f.2/power/runtime_active_kids:4
/sys/bus/pci/devices/0000:00:1f.2/power/runtime_active_time:71380
/sys/bus/pci/devices/0000:00:1f.2/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:00:1f.2/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1f.2/power/runtime_suspended_time:0
/sys/bus/pci/devices/0000:00:1f.2/power/runtime_usage:1
/sys/bus/pci/devices/0000:00:1f.2/power/wakeup:disabled
/sys/bus/pci/devices/0000:00:1f.3/power/async:enabled
/sys/bus/pci/devices/0000:00:1f.3/power/control:auto
/sys/bus/pci/devices/0000:00:1f.3/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:1f.3/power/runtime_active_time:54952
/sys/bus/pci/devices/0000:00:1f.3/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:00:1f.3/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1f.3/power/runtime_suspended_time:0
/sys/bus/pci/devices/0000:00:1f.3/power/runtime_usage:1
/sys/bus/pci/devices/0000:03:00.0/power/async:enabled
/sys/bus/pci/devices/0000:03:00.0/power/control:auto
/sys/bus/pci/devices/0000:03:00.0/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:03:00.0/power/runtime_active_time:56836
/sys/bus/pci/devices/0000:03:00.0/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:03:00.0/power/runtime_status:active
/sys/bus/pci/devices/0000:03:00.0/power/runtime_suspended_time:0
/sys/bus/pci/devices/0000:03:00.0/power/runtime_usage:1
/sys/bus/pci/devices/0000:03:00.0/power/wakeup:disabled
Bus 001 Device 004: ID 17ef:4807 Lenovo UVC Camera
Bus 002 Device 002: ID 1199:68a2 Sierra Wireless, Inc. 
Bus 003 Device 002: ID 08ff:2810 AuthenTec, Inc. AES2810
Bus 004 Device 002: ID 0a5c:2145 Broadcom Corp. Bluetooth with Enhanced Data Rate II
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 005 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 006 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 007 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 008 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 001 Device 004: ID 17ef:4807 Lenovo UVC Camera
Bus 002 Device 003: ID 0fce:2138 Sony Ericsson Mobile Communications AB Xperia X10 mini pro (Debug)
Bus 002 Device 002: ID 1199:68a2 Sierra Wireless, Inc. 
Bus 003 Device 002: ID 08ff:2810 AuthenTec, Inc. AES2810
Bus 004 Device 002: ID 0a5c:2145 Broadcom Corp. Bluetooth with Enhanced Data Rate II
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 005 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 006 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 007 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 008 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub

--=-=-=--
