Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:53500 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755728AbdCLM1M (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 12 Mar 2017 08:27:12 -0400
Date: Sun, 12 Mar 2017 13:26:21 +0100
From: Borislav Petkov <bp@alien8.de>
To: lkml@pengaru.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>, vcaputo@pengaru.com,
        linux-pci@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [BUG] 4.11.0-rc1 panic on shutdown X61s
Message-ID: <20170312122621.GA2823@nazgul.tnic>
References: <20170312053723.GH802@shells.gnugeneration.com>
 <20170312115703.GA18197@nazgul.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170312115703.GA18197@nazgul.tnic>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Mar 12, 2017 at 12:57:03PM +0100, Borislav Petkov wrote:
> On Sat, Mar 11, 2017 at 09:37:23PM -0800, lkml@pengaru.com wrote:
> > Hello list,
> > 
> > Here's a photo of the panic, on imgur to be kind to vger:
> > http://imgur.com/a/wZI32
> > 
> > I'm out on a sailboat so can't really do much, but had a chance with internet
> 
> So you didn't bring another box with you on the sailboat to connect it to the
> laptop over netconsole to catch full dmesg, did you?

Hahah, you're so in luck: I just sent this mail and hibernated my laptop
and got the same BUG. What's the chance of that happening?! Apparently
big enough.

But I was able to catch the warning before it too. So the question is,
do you have an e1000e eth controller in that machine too?

Because the symptoms below are consistent with the observed behavior:
e1000e fails to initialize MSI interrupts for whatever reason and falls
back to legacy interrupts.

Then, PCI core shuts down and BUGs because the msi_list is empty.

Anyway, lemme add e1000e people too to the fun thread.

[ 8295.723895] hib.sh (19178): drop_caches: 3
[ 8295.961695] PM: Syncing filesystems ... 
[ 8295.972559] done.
[ 8295.974699] Freezing user space processes ... (elapsed 0.001 seconds) done.
[ 8295.978484] PM: Preallocating image memory... done (allocated 197963 pages)
[ 8296.150973] PM: Allocated 791852 kbytes in 0.17 seconds (4657.95 MB/s)
[ 8296.151832] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[ 8296.155781] ACPI : EC: event blocked
[ 8296.449268] PM: freeze of devices complete after 294.716 msecs
[ 8296.469566] PM: late freeze of devices complete after 20.241 msecs
[ 8296.473369] ACPI : EC: interrupt blocked
[ 8296.477572] PM: noirq freeze of devices complete after 7.949 msecs
[ 8296.477605] Disabling non-boot CPUs ...
[ 8296.502106] Broke affinity for irq 16
[ 8296.502115] Broke affinity for irq 18
[ 8296.502124] Broke affinity for irq 23
[ 8296.503211] smpboot: CPU 1 is now offline
[ 8296.538391] Broke affinity for irq 16
[ 8296.538402] Broke affinity for irq 18
[ 8296.538412] Broke affinity for irq 23
[ 8296.538423] Broke affinity for irq 26
[ 8296.539527] smpboot: CPU 2 is now offline
[ 8296.578171] Broke affinity for irq 1
[ 8296.578180] Broke affinity for irq 8
[ 8296.578185] Broke affinity for irq 9
[ 8296.578191] Broke affinity for irq 12
[ 8296.578198] Broke affinity for irq 16
[ 8296.578204] Broke affinity for irq 18
[ 8296.578211] Broke affinity for irq 23
[ 8296.578218] Broke affinity for irq 26
[ 8296.578223] Broke affinity for irq 27
[ 8296.578228] Broke affinity for irq 28
[ 8296.579287] smpboot: CPU 3 is now offline
[ 8296.590166] PM: Creating hibernation image:
[ 8296.853347] PM: Need to copy 196464 pages
[ 8296.591954] Suspended for 284.763 seconds
[ 8296.592077] Enabling non-boot CPUs ...
[ 8296.603399] x86: Booting SMP configuration:
[ 8296.603423] smpboot: Booting Node 0 Processor 1 APIC 0x1
[ 8296.607663]  cache: parent cpu1 should not be sleeping
[ 8296.608456] CPU1 is up
[ 8296.627426] smpboot: Booting Node 0 Processor 2 APIC 0x2
[ 8296.631362]  cache: parent cpu2 should not be sleeping
[ 8296.632124] CPU2 is up
[ 8296.647451] smpboot: Booting Node 0 Processor 3 APIC 0x3
[ 8296.651451]  cache: parent cpu3 should not be sleeping
[ 8296.652258] CPU3 is up
[ 8296.659200] ACPI : EC: interrupt unblocked
[ 8296.662221] sdhci-pci 0000:02:00.0: MMC controller base frequency changed to 50Mhz.
[ 8296.703214] PM: noirq restore of devices complete after 44.358 msecs
[ 8296.704523] PM: early restore of devices complete after 1.246 msecs
[ 8296.777628] usb usb1: root hub lost power or was reset
[ 8296.777758] ACPI : EC: event unblocked
[ 8296.778121] usb usb2: root hub lost power or was reset
[ 8296.779447] rtc_cmos 00:02: System wakeup disabled by ACPI
[ 8296.779671] usb usb3: root hub lost power or was reset
[ 8296.779685] usb usb4: root hub lost power or was reset
[ 8296.781545] ehci-pci 0000:00:1a.0: cache line size of 64 is not supported
[ 8296.782034] ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
[ 8296.788359] sd 0:0:0:0: [sda] Starting disk
[ 8296.788439] sd 2:0:0:0: [sdb] Starting disk
[ 8296.934415] ------------[ cut here ]------------
[ 8296.934428] WARNING: CPU: 0 PID: 19229 at drivers/pci/msi.c:1052 __pci_enable_msi_range+0x39e/0x3f0
[ 8296.934440] Modules linked in: ctr ccm fuse ntfs msdos ext2 msr cpufreq_powersave cpufreq_userspace cpufreq_conservative binfmt_misc uinput vfat fat loop dm_crypt dm_mod hid_generic usbhid hid snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic x86_pkg_temp_thermal coretemp kvm_intel kvm irqbypass crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel iTCO_wdt aes_x86_64 iTCO_vendor_support crypto_simd cryptd glue_helper intel_cstate arc4 intel_rapl_perf pcspkr i2c_i801 snd_hda_intel snd_hda_codec snd_hwdep snd_hda_core sdhci_pci sdhci sg snd_pcm ehci_pci lpc_ich e1000e xhci_pci mmc_core snd_timer mfd_core ehci_hcd xhci_hcd wmi thinkpad_acpi nvram snd soundcore led_class ac battery serio_raw thermal [last unloaded: cfg80211]
[ 8296.934584] CPU: 0 PID: 19229 Comm: kworker/u8:49 Not tainted 4.10.0+ #2
[ 8296.934593] Hardware name: LENOVO 2320CTO/2320CTO, BIOS G2ET86WW (2.06 ) 11/13/2012
[ 8296.934605] Workqueue: events_unbound async_run_entry_fn
[ 8296.934613] Call Trace:
[ 8296.934621]  dump_stack+0x67/0x92
[ 8296.934629]  __warn+0xcb/0xf0
[ 8296.934636]  ? pci_pm_suspend_noirq+0x190/0x190
[ 8296.934644]  warn_slowpath_null+0x1d/0x20
[ 8296.934650]  __pci_enable_msi_range+0x39e/0x3f0
[ 8296.934662]  ? e1000_get_phy_info_82577+0x21/0x110 [e1000e]
[ 8296.934671]  ? pci_pm_suspend_noirq+0x190/0x190
[ 8296.934678]  pci_enable_msi+0x1a/0x30
[ 8296.934686]  e1000e_set_interrupt_capability+0x3c/0x110 [e1000e]
[ 8296.934697]  e1000e_pm_thaw+0x22/0x60 [e1000e]
[ 8296.934707]  e1000e_pm_resume+0x25/0x30 [e1000e]
[ 8296.934714]  pci_pm_restore+0x79/0xb0
[ 8296.934723]  dpm_run_callback+0x4e/0x2d0
[ 8296.934730]  device_resume+0x9d/0x1a0
[ 8296.934737]  async_resume+0x1d/0x50
[ 8296.934743]  async_run_entry_fn+0x37/0xe0
[ 8296.934752]  process_one_work+0x1e8/0x730
[ 8296.934759]  ? process_one_work+0x169/0x730
[ 8296.934768]  worker_thread+0x48/0x4e0
[ 8296.934777]  kthread+0x101/0x140
[ 8296.934783]  ? process_one_work+0x730/0x730
[ 8296.934790]  ? kthread_create_on_node+0x40/0x40
[ 8296.934798]  ret_from_fork+0x2e/0x40
[ 8296.934809] ---[ end trace 6ab732218e829ce9 ]---
[ 8296.934875] e1000e 0000:00:19.0 eth0: Failed to initialize MSI interrupts.  Falling back to legacy interrupts.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
