Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:61336 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723Ab3B1LvX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Feb 2013 06:51:23 -0500
Message-ID: <512F4494.5050301@huawei.com>
Date: Thu, 28 Feb 2013 19:50:44 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
CC: Yinghai Lu <yinghai@kernel.org>,
	Myron Stowe <myron.stowe@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Joe Lawrence <Joe.Lawrence@stratus.com>,
	<linux-pci@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>,
	Myron Stowe <mstowe@redhat.com>,
	David Bulkow <david.bulkow@stratus.com>
Subject: Re: [PATCH 1/2] PCI: ASPM exit link state code could skip devices
References: <alpine.DEB.2.02.1301181302260.31163@jlaw-desktop.mno.stratus.com> <alpine.DEB.2.02.1301181322500.31163@jlaw-desktop.mno.stratus.com> <51122BED.8090308@cn.fujitsu.com> <CAErSpo6aGiuBbgcVfcduPk++7B_zzuk2Y+fjLiJBvdOqnU+Qmw@mail.gmail.com> <5122F276.80807@cn.fujitsu.com> <CAErSpo7BeCiKHecJgX9GBR7DYf4M9mrXK+qMLMDXFykxq5C7sQ@mail.gmail.com> <512AFDB7.5030105@cn.fujitsu.com> <CAL-B5D0xN6bs3oXugS9FOS5bQiFRJQ9766u5wsXw4UQdUmwfyw@mail.gmail.com> <512DAAC9.8030400@cn.fujitsu.com> <CAE9FiQU6Sj=wkare0VCJwP1Yr09o=xVMrhsY_xJ1_41=YMkwMg@mail.gmail.com> <512F35D3.6080009@cn.fujitsu.com>
In-Reply-To: <512F35D3.6080009@cn.fujitsu.com>
Content-Type: multipart/mixed;
	boundary="------------060303030008070102030003"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--------------060303030008070102030003
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On 2013/2/28 18:47, Gu Zheng wrote:
> On 02/27/2013 02:47 PM, Yinghai Lu wrote:
> 
>> On Tue, Feb 26, 2013 at 10:42 PM, Gu Zheng <guz.fnst@cn.fujitsu.com> wrote:
>>>     I just agree with Bjorn's analysis. And I have test Yinghai's patch on kernel 3.8
>>> , but it seems does not work. More infos, please refer to bugzilla:
>>> https://bugzilla.kernel.org/show_bug.cgi?id=54411
>>
>> you need to test that on linus's tree of 2013-02-26.
>> or v3.9-rc1
> 
> Hi Yinghai,
> 	I test your patch on linus' tree of 2-26
> commit d895cb1af15c04c522a25c79cc429076987c089b
> But it still does not work~

I found another problem when doing device remove by /sys/..../$device/remove and acpi hotplug.
Because remove_callback() function was called in workqueue. The device which was hold by
remove_callback() may be removed by other interfaces like acpiphp/pciehp, upstream device remove....
So once remove_callback() try to remove this device again(which was removed), system may panic.

panic info found in my machine:
kworker/u:3[273]: Oops 11003706212352 [1]
Modules linked in: raw snd_pcm_oss snd_mixer_oss snd_seq snd_seq_device nfsv3 nf
s_acl iptable_filter ip_tables x_tables nfs fscache dns_resolver lockd sunrpc cp
ufreq_conservative cpufreq_userspace cpufreq_powersave acpi_cpufreq binfmt_misc
fuse nls_iso8859_1 loop ipmi_si ipmi_devintf ipmi_msghandler dm_mod snd_hda_code
c_hdmi snd_hda_intel igb snd_hda_codec snd_hwdep snd_pcm snd_timer iTCO_wdt iTCO
_vendor_support snd ppdev soundcore serio_raw lpc_ich mfd_core snd_page_alloc sg
 ehci_pci mptctl ptp pps_core i2c_i801 parport_pc i2c_core hid_generic parport c
ontainer button usbhid hid uhci_hcd ehci_hcd usbcore usb_common sd_mod crc_t10di
f ext3 mbcache jbd fan processor ide_pci_generic ide_core mptsas mptscsih mptbas
e scsi_transport_sas ata_piix libata scsi_mod thermal thermal_sys hwmon

Pid: 273, CPU 29, comm:          kworker/u:3
psr : 0000121008526038 ifs : 8000000000000307 ip  : [<a0000001004d3e21>]    Tain
ted: G    B        (3.8.0-rc2-pci-bind)
ip is at pci_destroy_dev+0x61/0x160
unat: 0000000000000000 pfs : 0000000000000307 rsc : 0000000000000003
rnat: 0000000000000000 bsps: 0000000000000000 pr  : 0000018000019585
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c9e70433f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a0000001004d3df0 b6  : a0000001004c92a0 b7  : a00000010000b4e0
f6  : 000000000000000000000 f7  : 1003e00000018ac0017c7
f8  : 1003e0044b82fa09b5a53 f9  : 1003e00002779e56ddcba
f10 : 1003e17b2cb67d049962e f11 : 1003e0000000000000c56
r1  : a0000001015ae780 r2  : 0000000000100100 r3  : 0000000000100108
r8  : a0000001013af748 r9  : 0000000000000000 r10 : 0000000000200201
r11 : 000000000000d5a4 r12 : e0000007059afdd0 r13 : e0000007059a0000
r14 : 0000000000200200 r15 : 0000000000200200 r16 : 0000000000100100
r17 : e00000170353da88 r18 : e000001f03503e80 r19 : e00000170353da90
r20 : 0000000000000000 r21 : 0000000000000000 r22 : a0000001013cc608
r23 : 0000000000000063 r24 : 000000000000006b r25 : 000000000000006c
r26 : 000000000000006f r27 : a000000101a82cc0 r28 : 0000000000000000
r29 : 0000000000000000 r30 : 000000000000d5a2 r31 : 000000000000d5a2

Call Trace:
 [<a000000100015f00>] show_stack+0x80/0xa0
                                sp=e0000007059af990 bsp=e0000007059a1400
 [<a000000100016560>] show_regs+0x640/0x920
                                sp=e0000007059afb60 bsp=e0000007059a13a0
 [<a0000001000418f0>] die+0x190/0x2c0
                                sp=e0000007059afb70 bsp=e0000007059a1360
 [<a00000010094b370>] ia64_do_page_fault+0xbd0/0xc00
                                sp=e0000007059afb70 bsp=e0000007059a12d0
 [<a00000010000bd40>] ia64_native_leave_kernel+0x0/0x270
                                sp=e0000007059afc00 bsp=e0000007059a12d0
 [<a0000001004d3e20>] pci_destroy_dev+0x60/0x160
                                sp=e0000007059afdd0 bsp=e0000007059a1298
 [<a0000001004d44a0>] pci_remove_bus_device+0xc0/0xe0
                                sp=e0000007059afdd0 bsp=e0000007059a1258
 [<a0000001004d44f0>] pci_stop_and_remove_bus_device+0x30/0x60
                                sp=e0000007059afdd0 bsp=e0000007059a1238
 [<a0000001004e33d0>] remove_callback+0xf0/0x1c0
                                sp=e0000007059afdd0 bsp=e0000007059a1208
 [<a00000010034d730>] sysfs_schedule_callback_work+0x50/0x120
                                sp=e0000007059afdd0 bsp=e0000007059a11d0
 [<a0000001000b85a0>] process_one_work+0x520/0xa80
                                sp=e0000007059afdd0 bsp=e0000007059a1140
 [<a0000001000b98b0>] worker_thread+0x330/0xde0
                                sp=e0000007059afdd0 bsp=e0000007059a1070
 [<a0000001000cd070>] kthread+0x150/0x180
                                sp=e0000007059afdd0 bsp=e0000007059a1038
 [<a00000010000bb30>] call_payload+0x50/0x80
                                sp=e0000007059afe30 bsp=e0000007059a1020
Unable to handle kernel NULL pointer dereference (address 0000000000000038)
kworker/u:3[273]: Oops 8813272891392 [2]
Modules linked in: raw snd_pcm_oss snd_mixer_oss snd_seq snd_seq_device nfsv3 nf
s_acl iptable_filter ip_tables x_tables nfs fscache dns_resolver lockd sunrpc cp
ufreq_conservative cpufreq_userspace cpufreq_powersave acpi_cpufreq binfmt_misc
fuse nls_iso8859_1 loop ipmi_si ipmi_devintf ipmi_msghandler dm_mod snd_hda_code
c_hdmi snd_hda_intel igb snd_hda_codec snd_hwdep snd_pcm snd_timer iTCO_wdt iTCO
_vendor_support snd ppdev soundcore serio_raw lpc_ich mfd_core snd_page_alloc sg
 ehci_pci mptctl ptp pps_core i2c_i801 parport_pc i2c_core hid_generic parport c
ontainer button usbhid hid uhci_hcd ehci_hcd usbcore usb_common sd_mod crc_t10di
f ext3 mbcache jbd fan processor ide_pci_generic ide_core mptsas mptscsih mptbas
e scsi_transport_sas ata_piix libata scsi_mod thermal thermal_sys hwmon

Pid: 273, CPU 29, comm:          kworker/u:3
psr : 0000101008022038 ifs : 8000000000000309 ip  : [<a0000001000c21b0>]    Tain
ted: G    B D      (3.8.0-rc2-pci-bind)
ip is at wq_worker_sleeping+0x30/0x180
unat: 0000000000000000 pfs : 0000000000000309 rsc : 0000000000000003
rnat: 000000000000040e bsps: 0000000000000003 pr  : 000565501552a5d5
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70033f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a0000001000c21a0 b6  : a0000001000fdc80 b7  : a0000001000ffbe0
f6  : 0ffefaec33e1f63409a90 f7  : 0fff1ed2d4e22a0000000
f8  : 10017a916000000000000 f9  : 1000ebb80000000000000
f10 : 10007e6dbd1941e705b2d f11 : 1003e00000000000001cd
r1  : a0000001015ae780 r2  : 0000000000000000 r3  : 0000000000000038
r8  : 0000000000000000 r9  : 0000000000000000 r10 : e000001800206280
r11 : e0000018002063a0 r12 : e0000007059afb60 r13 : e0000007059a0000
r14 : ffffffffffffffd8 r15 : e0000018002062f4 r16 : 0000315801ec75e5
r17 : e000001800206bd0 r18 : e0000018002063a0 r19 : 000000000315801e
r20 : e000001800206360 r21 : a0000001014fb630 r22 : e0000018002062e0
r23 : a000000101b2cb88 r24 : e0000007059a0070 r25 : e000001800206b40
r26 : 00000000000001cc r27 : 000000000000bb80 r28 : 000000000000bb7f
r29 : 000000000420806c r30 : e0000007059a0014 r31 : 000000000000b9dd

Call Trace:
 [<a000000100015f00>] show_stack+0x80/0xa0
                                sp=e0000007059af720 bsp=e0000007059a1740
 [<a000000100016560>] show_regs+0x640/0x920
                                sp=e0000007059af8f0 bsp=e0000007059a16e8
 [<a0000001000418f0>] die+0x190/0x2c0
                                sp=e0000007059af900 bsp=e0000007059a16a8
 [<a00000010094b150>] ia64_do_page_fault+0x9b0/0xc00
                                sp=e0000007059af900 bsp=e0000007059a1618
 [<a00000010000bd40>] ia64_native_leave_kernel+0x0/0x270
                                sp=e0000007059af990 bsp=e0000007059a1618
 [<a0000001000c21b0>] wq_worker_sleeping+0x30/0x180
                                sp=e0000007059afb60 bsp=e0000007059a15c8
 [<a0000001009430f0>] __schedule+0x14f0/0x16c0
                                sp=e0000007059afb60 bsp=e0000007059a1458
 [<a000000100943580>] schedule+0x60/0x140
                                sp=e0000007059afb70 bsp=e0000007059a1400
 [<a00000010008e050>] do_exit+0x6d0/0xc20
                                sp=e0000007059afb70 bsp=e0000007059a13a0
 [<a0000001000419c0>] die+0x260/0x2c0
                                sp=e0000007059afb70 bsp=e0000007059a1360
 [<a00000010094b370>] ia64_do_page_fault+0xbd0/0xc00
                                sp=e0000007059afb70 bsp=e0000007059a12d0
 [<a00000010000bd40>] ia64_native_leave_kernel+0x0/0x270
                                sp=e0000007059afc00 bsp=e0000007059a12d0
 [<a0000001004d3e20>] pci_destroy_dev+0x60/0x160
                                sp=e0000007059afdd0 bsp=e0000007059a1298
 [<a0000001004d44a0>] pci_remove_bus_device+0xc0/0xe0
                                sp=e0000007059afdd0 bsp=e0000007059a1258
 [<a0000001004d44f0>] pci_stop_and_remove_bus_device+0x30/0x60
                                sp=e0000007059afdd0 bsp=e0000007059a1238
 [<a0000001004e33d0>] remove_callback+0xf0/0x1c0
                                sp=e0000007059afdd0 bsp=e0000007059a1208
 [<a00000010034d730>] sysfs_schedule_callback_work+0x50/0x120
                                sp=e0000007059afdd0 bsp=e0000007059a11d0
 [<a0000001000b85a0>] process_one_work+0x520/0xa80
                                sp=e0000007059afdd0 bsp=e0000007059a1140
 [<a0000001000b98b0>] worker_thread+0x330/0xde0
                                sp=e0000007059afdd0 bsp=e0000007059a1070
 [<a0000001000cd070>] kthread+0x150/0x180
                                sp=e0000007059afdd0 bsp=e0000007059a1038
 [<a00000010000bb30>] call_payload+0x50/0x80
                                sp=e0000007059afe30 bsp=e0000007059a1020
Fixing recursive fault but reboot is needed!

I hope this patch can fix your problem too.


> 
> Thanks
> Gu
> 
>>
>> Thanks
>>
>> Yinghai
>>
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


-- 
Thanks!
Yijing

--------------060303030008070102030003
Content-Type: text/x-patch;
	name="0001-PCI-check-device-is_added-flag-in-remove_callback.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-PCI-check-device-is_added-flag-in-remove_callback.patch"

>From ba405b9ea86d8ebd4fd9754aef67d986b0835f9a Mon Sep 17 00:00:00 2001
From: Yijing Wang <wangyijing@huawei.com>
Date: Thu, 28 Feb 2013 19:51:40 +0800
Subject: [PATCH] PCI: check device is_added flag in remove_callback()

Currently, remove_store() function use device_schedule_callback()
mechanism to do device remove action. It will queue remove_callback()
into sysfs_workqueue. If this device was removed by other interfaces
like acpiphp/pciehp between device_schedule_callback() function and
remove_callback() function. This patch add is_added flag check
in remove_callback() to avoid remove a removed device again.


+-07.0-[0000:05]--+-00.0  nVidia Corporation GT218 [GeForce G210]
|                 \-00.1  nVidia Corporation High Definition Audio Controller

#echo 1 > /sys/bus/pci/devices/0000:05:00.0/remove
#echo 0 > /sys/bus/pci/slots/0/power (address: 0000:05:00, slot attached to 0000:00:07.0)

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pci-sysfs.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 9c6e9bb..6b77133 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -331,7 +331,8 @@ static void remove_callback(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 
 	mutex_lock(&pci_remove_rescan_mutex);
-	pci_stop_and_remove_bus_device(pdev);
+	if (pdev->is_added)
+		pci_stop_and_remove_bus_device(pdev);
 	mutex_unlock(&pci_remove_rescan_mutex);
 }
 
-- 
1.7.1


--------------060303030008070102030003--
