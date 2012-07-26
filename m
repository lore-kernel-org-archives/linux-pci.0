Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:40839 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752043Ab2GZKgH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jul 2012 06:36:07 -0400
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Huang Ying <ying.huang@intel.com>
Cc: huang ying <huang.ying.caritas@gmail.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Zheng Yan <zheng.z.yan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
Subject: Re: bisected regression, v3.5 -> next-20120724: PCI PM causes USB hotplug failure
References: <Pine.LNX.4.44L0.1207241312050.1164-100000@iolanthe.rowland.org>
	<87r4s0opck.fsf@nemi.mork.no> <87pq7ko532.fsf@nemi.mork.no>
	<1343190864.10311.26.camel@yhuang-dev> <87k3xskvqq.fsf@nemi.mork.no>
	<CAC=cRTOi+=49+_4VuMuBR8rTPvjXLMVhNBFbr3SHgNyxfnKQUA@mail.gmail.com>
	<874now7xi8.fsf@nemi.mork.no> <1343292851.3874.12.camel@yhuang-dev>
Date: Thu, 26 Jul 2012 12:35:32 +0200
In-Reply-To: <1343292851.3874.12.camel@yhuang-dev> (Huang Ying's message of
	"Thu, 26 Jul 2012 16:54:11 +0800")
Message-ID: <87k3xqyfm3.fsf@nemi.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Huang Ying <ying.huang@intel.com> writes:

> Do you have time to try the below patch?

Sure.  Looks OK wrt the USB problems, but may cause problems with the
PCIe WiFi card.  Unless those are related to other changes in -next.

Anyway, for I applied your patch on top of next-20120724 for
consistency (still without Rafael print fix, so we get the D4 below).  
This results in different stats for the uhci_hcd and ehci_hcd:


Jul 26 12:13:42 nemi kernel: [   72.820305] uhci_hcd 0000:00:1a.2: power state changed by ACPI to D2
Jul 26 12:13:42 nemi kernel: [   72.835101] uhci_hcd 0000:00:1d.0: power state changed by ACPI to D2
Jul 26 12:13:44 nemi kernel: [   74.808770] uhci_hcd 0000:00:1a.0: power state changed by ACPI to D2
Jul 26 12:13:44 nemi kernel: [   74.840293] ehci_hcd 0000:00:1d.7: power state changed by ACPI to D4
Jul 26 12:13:44 nemi kernel: [   74.840326] ehci_hcd 0000:00:1a.7: power state changed by ACPI to D4

I assume that is expected, based on the lspci output I posted earlier.
Overall I get a nice mix of allowed/disallowed:



nemi:/home/bjorn# grep . /sys/bus/pci/devices/*/d3cold_allowed
/sys/bus/pci/devices/0000:00:00.0/d3cold_allowed:0
/sys/bus/pci/devices/0000:00:02.0/d3cold_allowed:1
/sys/bus/pci/devices/0000:00:02.1/d3cold_allowed:1
/sys/bus/pci/devices/0000:00:03.0/d3cold_allowed:1
/sys/bus/pci/devices/0000:00:19.0/d3cold_allowed:1
/sys/bus/pci/devices/0000:00:1a.0/d3cold_allowed:0
/sys/bus/pci/devices/0000:00:1a.1/d3cold_allowed:0
/sys/bus/pci/devices/0000:00:1a.2/d3cold_allowed:0
/sys/bus/pci/devices/0000:00:1a.7/d3cold_allowed:1
/sys/bus/pci/devices/0000:00:1b.0/d3cold_allowed:1
/sys/bus/pci/devices/0000:00:1c.0/d3cold_allowed:0
/sys/bus/pci/devices/0000:00:1c.1/d3cold_allowed:0
/sys/bus/pci/devices/0000:00:1d.0/d3cold_allowed:0
/sys/bus/pci/devices/0000:00:1d.1/d3cold_allowed:0
/sys/bus/pci/devices/0000:00:1d.2/d3cold_allowed:0
/sys/bus/pci/devices/0000:00:1d.7/d3cold_allowed:1
/sys/bus/pci/devices/0000:00:1e.0/d3cold_allowed:0
/sys/bus/pci/devices/0000:00:1f.0/d3cold_allowed:0
/sys/bus/pci/devices/0000:00:1f.2/d3cold_allowed:1
/sys/bus/pci/devices/0000:00:1f.3/d3cold_allowed:0
/sys/bus/pci/devices/0000:03:00.0/d3cold_allowed:1


USB hotplugging seems to work fine with this.  But attempting to
unload/reload the wifi drivers resulted in this:




Jul 26 12:20:43 nemi kernel: [  493.812266] iwlwifi 0000:03:00.0: Refused to change power state, currently in D3
Jul 26 12:20:43 nemi kernel: [  493.812331] iwlwifi 0000:03:00.0: pci_resource_len = 0x00002000
Jul 26 12:20:43 nemi kernel: [  493.812335] iwlwifi 0000:03:00.0: pci_resource_base = ffffc900055a4000
Jul 26 12:20:43 nemi kernel: [  493.812339] iwlwifi 0000:03:00.0: HW Revision ID = 0x0
Jul 26 12:20:43 nemi kernel: [  493.812350] iwlwifi 0000:03:00.0: pci_enable_msi failed(0Xffffffea)
Jul 26 12:20:43 nemi kernel: [  493.812377] driver: '0000:03:00.0': driver_bound: bound to device 'iwlwifi'
Jul 26 12:20:43 nemi kernel: [  493.812385] bus: 'pci': really_probe: bound device 0000:03:00.0 to driver iwlwifi
Jul 26 12:20:43 nemi kernel: [  493.813634] iwldvm: Intel(R) Wireless WiFi Link AGN driver for Linux, in-tree:
Jul 26 12:20:43 nemi kernel: [  493.813637] iwldvm: Copyright(c) 2003-2012 Intel Corporation
Jul 26 12:20:43 nemi kernel: [  493.813912] device: '0000:03:00.0': device_add
Jul 26 12:20:43 nemi kernel: [  493.813939] PM: Adding info for No Bus:0000:03:00.0
Jul 26 12:20:43 nemi kernel: [  493.813947] firmware 0000:03:00.0: firmware: requesting iwlwifi-5000-5.ucode
Jul 26 12:20:43 nemi kernel: [  493.827551] PM: Removing info for No Bus:0000:03:00.0
Jul 26 12:20:43 nemi kernel: [  493.827615] iwlwifi 0000:03:00.0: loaded firmware version 8.83.5.1 build 33692
Jul 26 12:20:43 nemi kernel: [  493.828170] iwlwifi 0000:03:00.0: CONFIG_IWLWIFI_DEBUG disabled
Jul 26 12:20:43 nemi kernel: [  493.828175] iwlwifi 0000:03:00.0: CONFIG_IWLWIFI_DEBUGFS disabled
Jul 26 12:20:43 nemi kernel: [  493.828178] iwlwifi 0000:03:00.0: CONFIG_IWLWIFI_DEVICE_TRACING disabled
Jul 26 12:20:43 nemi kernel: [  493.828182] iwlwifi 0000:03:00.0: CONFIG_IWLWIFI_DEVICE_TESTMODE disabled
Jul 26 12:20:43 nemi kernel: [  493.828185] iwlwifi 0000:03:00.0: CONFIG_IWLWIFI_P2P disabled
Jul 26 12:20:43 nemi kernel: [  493.828190] iwlwifi 0000:03:00.0: Detected Intel(R) Ultimate N WiFi Link 5300 AGN, REV=0xFFFFFFFF
Jul 26 12:20:43 nemi kernel: [  493.828218] iwlwifi 0000:03:00.0: L1 Enabled; Disabling L0S
Jul 26 12:20:43 nemi kernel: [  493.832013] ------------[ cut here ]------------
Jul 26 12:20:43 nemi kernel: [  493.832013] WARNING: at drivers/net/wireless/iwlwifi/iwl-io.c:150 iwl_grab_nic_access+0x47/0x54 [iwlwifi]()
Jul 26 12:20:43 nemi kernel: [  493.832013] Hardware name: 2776LEG
Jul 26 12:20:43 nemi kernel: [  493.832013] Timeout waiting for hardware access (CSR_GP_CNTRL 0xffffffff)
Jul 26 12:20:43 nemi kernel: [  493.832013] Modules linked in: iwldvm iwlwifi mac80211 cfg80211 cpufreq_userspace cpufreq_stats cpufreq_conservative cpufreq_powersave xt_multiport xt_hl ip6table_filter iptable_filter ip_tables ip6_tables x_tables rfcomm bnep binfmt_misc fuse nfsd nfs lockd fscache auth_rpcgss nfs_acl sunrpc 8021q garp stp llc tun ext2 loop snd_hda_codec_conexant snd_hda_intel snd_hda_codec snd_hwdep snd_pcm_oss snd_mixer_oss snd_pcm thinkpad_acpi snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd_timer snd_seq_device arc4 snd i915 coretemp kvm_intel qcserial drm_kms_helper usb_wwan acpi_cpufreq drm psmouse lpc_ich i2c_algo_bit soundcore usbserial qmi_wwan usbnet mii cdc_wdm kvm microcode btusb evdev bluetooth i2c_i801 serio_raw mfd_core rfkill mei snd_page_alloc crc16 i2c_core battery nvram ac video wmi mperf processor button ext3 mbcache jbd sha256_generic ablk_helper cryptd aes_x86_64 aes_generic cbc dm_crypt dm_mod nbd sd_mod crc_t10dif sr_mod cdrom uhci_hcd ahci libahci libata ehci_hc
Jul 26 12:20:43 nemi kernel: d scsi_mod thermal thermal_sys usbcore usb_common e1000e [last unloaded: cfg80211]
Jul 26 12:20:43 nemi kernel: [  493.832013] Pid: 200, comm: kworker/0:2 Not tainted 3.5.0-rc2-next-20120724+ #23
Jul 26 12:20:43 nemi kernel: [  493.832013] Call Trace:
Jul 26 12:20:43 nemi kernel: [  493.832013]  [<ffffffff8103d0fd>] ? warn_slowpath_common+0x78/0x8c
Jul 26 12:20:43 nemi kernel: [  493.832013]  [<ffffffff8103d1af>] ? warn_slowpath_fmt+0x45/0x4a
Jul 26 12:20:43 nemi kernel: [  493.832013]  [<ffffffffa03822be>] ? iwl_grab_nic_access+0x47/0x54 [iwlwifi]
Jul 26 12:20:43 nemi kernel: [  493.832013]  [<ffffffffa0382590>] ? iwl_write_prph+0x29/0x56 [iwlwifi]
Jul 26 12:20:43 nemi kernel: [  493.832013]  [<ffffffffa03882cb>] ? iwl_apm_init+0x13a/0x16b [iwlwifi]
Jul 26 12:20:43 nemi kernel: [  493.832013]  [<ffffffffa03883fd>] ? iwl_trans_pcie_start_hw+0x101/0x15b [iwlwifi]
Jul 26 12:20:43 nemi kernel: [  493.832013]  [<ffffffffa026aa5b>] ? iwl_op_mode_dvm_start+0x246/0x96a [iwldvm]
Jul 26 12:20:43 nemi kernel: [  493.832013]  [<ffffffffa03835d1>] ? iwl_ucode_callback+0x9e5/0xad8 [iwlwifi]
Jul 26 12:20:43 nemi kernel: [  493.832013]  [<ffffffff812793c2>] ? _request_firmware_prepare+0x1e2/0x1e2
Jul 26 12:20:43 nemi kernel: [  493.832013]  [<ffffffff81279471>] ? request_firmware_work_func+0xaf/0xe4
Jul 26 12:20:43 nemi kernel: [  493.832013]  [<ffffffff81054dea>] ? process_one_work+0x1ff/0x311
Jul 26 12:20:43 nemi kernel: [  493.832013]  [<ffffffff810550f7>] ? worker_thread+0x1fb/0x2fb
Jul 26 12:20:43 nemi kernel: [  493.832013]  [<ffffffff81054efc>] ? process_one_work+0x311/0x311
Jul 26 12:20:43 nemi kernel: [  493.832013]  [<ffffffff81054efc>] ? process_one_work+0x311/0x311
Jul 26 12:20:43 nemi kernel: [  493.832013]  [<ffffffff810588fd>] ? kthread+0x81/0x89
Jul 26 12:20:43 nemi kernel: [  493.832013]  [<ffffffff813703c4>] ? kernel_thread_helper+0x4/0x10
Jul 26 12:20:43 nemi kernel: [  493.832013]  [<ffffffff8105887c>] ? kthread_freezable_should_stop+0x53/0x53
Jul 26 12:20:43 nemi kernel: [  493.832013]  [<ffffffff813703c0>] ? gs_change+0x13/0x13
Jul 26 12:20:43 nemi kernel: [  493.832013] ---[ end trace fcaaf916dd43b7ca ]---
Jul 26 12:20:43 nemi kernel: [  493.864785] iwlwifi 0000:03:00.0: bad EEPROM/OTP signature, type=OTP, EEPROM_GP=0x00000007
Jul 26 12:20:43 nemi kernel: [  493.864791] iwlwifi 0000:03:00.0: EEPROM not found, EEPROM_GP=0xffffffff
Jul 26 12:20:43 nemi kernel: [  493.864795] iwlwifi 0000:03:00.0: Unable to init EEPROM


That does not look good...

The bridge and WiFi devices power status at this point is:

bjorn@nemi:~$  grep . /sys/bus/pci/devices/0000:00:1c.1/power/*
/sys/bus/pci/devices/0000:00:1c.1/power/async:enabled
grep: /sys/bus/pci/devices/0000:00:1c.1/power/autosuspend_delay_ms: Input/output error
/sys/bus/pci/devices/0000:00:1c.1/power/control:auto
/sys/bus/pci/devices/0000:00:1c.1/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:00:1c.1/power/runtime_active_time:390576
/sys/bus/pci/devices/0000:00:1c.1/power/runtime_enabled:enabled
/sys/bus/pci/devices/0000:00:1c.1/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1c.1/power/runtime_suspended_time:697004
/sys/bus/pci/devices/0000:00:1c.1/power/runtime_usage:0
/sys/bus/pci/devices/0000:00:1c.1/power/wakeup:disabled

bjorn@nemi:~$ grep . /sys/bus/pci/devices/0000:03:00.0/power/*
/sys/bus/pci/devices/0000:03:00.0/power/async:enabled
grep: /sys/bus/pci/devices/0000:03:00.0/power/autosuspend_delay_ms: Input/output error
/sys/bus/pci/devices/0000:03:00.0/power/control:auto
/sys/bus/pci/devices/0000:03:00.0/power/runtime_active_kids:0
/sys/bus/pci/devices/0000:03:00.0/power/runtime_active_time:0
/sys/bus/pci/devices/0000:03:00.0/power/runtime_enabled:disabled
/sys/bus/pci/devices/0000:03:00.0/power/runtime_status:unsupported
/sys/bus/pci/devices/0000:03:00.0/power/runtime_suspended_time:70220
/sys/bus/pci/devices/0000:03:00.0/power/runtime_usage:0
/sys/bus/pci/devices/0000:03:00.0/power/wakeup:disabled



I don't really understand the last one.  How can suspended_time > 0 when
status is unsupported and autosuspend is disabled?



Bjørn
