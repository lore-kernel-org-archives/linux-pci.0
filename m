Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <51BDEF7F.1070107@gmail.com>
Date: Mon, 17 Jun 2013 01:01:51 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	"Alexander E . Patrakov" <patrakov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yijing Wang <wangyijing@huawei.com>,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
	stable@vger.kernel.org, Jiang Liu <jiang.liu@huawei.com>
Subject: Re: [BUGFIX v2 2/4] ACPI, DOCK: resolve possible deadlock scenarios
References: <1371238081-32260-1-git-send-email-jiang.liu@huawei.com> <51BBC6FC.2020002@gmail.com> <8974656.5GmDyxHW7F@vostro.rjw.lan> <18797091.iPZsNWFGi1@vostro.rjw.lan>
In-Reply-To: <18797091.iPZsNWFGi1@vostro.rjw.lan>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/16/2013 05:20 AM, Rafael J. Wysocki wrote:
> On Saturday, June 15, 2013 10:17:42 PM Rafael J. Wysocki wrote:
>> On Saturday, June 15, 2013 09:44:28 AM Jiang Liu wrote:
[...]
>> When it returns from unregister_hotplug_dock_device(), nothing prevents it
>> from accessing whatever it wants, because ds->hp_lock is not used outside
>> of the add/del and hotplug_dock_devices().  So, the actual role of
>> ds->hp_lock (not the one that it is supposed to play, but the real one)
>> is to prevent addition/deletion from happening when hotplug_dock_devices()
>> is running.  [Yes, it does protect the list, but since the list is in fact
>> unnecessary, that doesn't matter.]
>>
>>> If we simply use a flag to mark presence of registered callback, we 
>>> can't achieve the second goal.
>>
>> I don't mean using the flag *alone*.
>>
>>> Take the sony laptop as an example. It has several PCI 
>>> hotplug
>>> slot associated with the dock station:
>>> [   28.829316] acpiphp_glue: _handle_hotplug_event_func: Bus check 
>>> notify on \_SB_.PCI0.RP07.LPMB
>>> [   30.174964] acpiphp_glue: _handle_hotplug_event_func: Bus check 
>>> notify on \_SB_.PCI0.RP07.LPMB.LPM0
>>> [   30.174973] acpiphp_glue: _handle_hotplug_event_func: Bus check 
>>> notify on \_SB_.PCI0.RP07.LPMB.LPM1
>>> [   30.174979] acpiphp_glue: _handle_hotplug_event_func: Bus check 
>>> notify on \_SB_.PCI0.RP07.LPMB.LPM2
>>> [   30.174985] acpiphp_glue: _handle_hotplug_event_func: Bus check 
>>> notify on \_SB_.PCI0.RP07.LPMB.LPM2.LPRI.LPR0.GFXA
>>> [   30.175020] acpiphp_glue: _handle_hotplug_event_func: Bus check 
>>> notify on \_SB_.PCI0.RP07.LPMB.LPM2.LPRI.LPR0.GHDA
>>> [   30.175040] acpiphp_glue: _handle_hotplug_event_func: Bus check 
>>> notify on \_SB_.PCI0.RP07.LPMB.LPM2.LPRI.LPR1.LPCI.LPC0.DLAN
>>> [   30.175050] acpiphp_glue: _handle_hotplug_event_func: Bus check 
>>> notify on \_SB_.PCI0.RP07.LPMB.LPM2.LPRI.LPR1.LPCI.LPC1.DODD
>>> [   30.175060] acpiphp_glue: _handle_hotplug_event_func: Bus check 
>>> notify on \_SB_.PCI0.RP07.LPMB.LPM2.LPRI.LPR1.LPCI.LPC2.DUSB
>>>
>>> So it still has some race windows if we undock the station while 
>>> repeatedly rescanning/removing
>>> the PCI bus for \_SB_.PCI0.RP07.LPMB.LPM0 through sysfs interfaces.
> 
> Which sysfs interfaces do you mean, by the way?
> 
> If you mean "eject", then it takes acpi_scan_lock and hotplug_dock_devices()
> should always be run under acpi_scan_lock too.  It isn't at the moment,
> because write_undock() doesn't take acpi_scan_lock(), but this is an obvious
> bug (so I'm going to send a patch to fix it in a while).
> 
> With that bug fixed, the possible race between acpi_eject_store() and
> hotplug_dock_devices() should be prevented from happening, so perhaps we're
> worrying about something that cannot happen?
Hi Rafael,
	I mean the "remove" method of each PCI device, and the "power" method
of PCI hotplug slot here.
	These methods may be used to remove P2P bridges with associated ACPIPHP
hotplug slots, which in turn will cause invoking of
unregister_hotplug_dock_device().
	So theoretical we may trigger the bug by undocking while repeatedly
adding/removing P2P bridges with ACPIPHP hotplug slot through PCI
"rescan" and "remove" sysfs interface,
Regards!
Gerry
> 
> Rafael
> 
> 

