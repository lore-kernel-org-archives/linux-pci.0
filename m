Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:48656 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754553Ab3GKURU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jul 2013 16:17:20 -0400
Received: by mail-oa0-f52.google.com with SMTP id g12so11913762oah.11
        for <linux-pci@vger.kernel.org>; Thu, 11 Jul 2013 13:17:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51DEFE6F.7040507@gmx.de>
References: <51DEFE6F.7040507@gmx.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 11 Jul 2013 14:16:59 -0600
Message-ID: <CAErSpo72dcMW26yF35feuoy=RJnPorZxX9x==N6E89gsxBpkuw@mail.gmail.com>
Subject: Re: 3.10: disabling already-disabled device
To: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Konstantin Khlebnikov <khlebnikov@openvz.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	"e1000-devel@lists.sourceforge.net"
	<e1000-devel@lists.sourceforge.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Konstantin, Rafael, e1000 list]

Thanks for the report; hopefully the folks I cc'd will have some ideas.

On Thu, Jul 11, 2013 at 12:50 PM, Toralf Förster <toralf.foerster@gmx.de> wrote:
> Found this today in the log at a 3.10.0 kernel at a 32 bit stable Gentoo
> at a ThinkPad T420 :
>
> Jul 10 19:22:17 n22 kernel: PM: Entering mem sleep
> Jul 10 19:22:17 n22 kernel: Suspending console(s) (use no_console_suspend to debug)
> Jul 10 19:22:17 n22 kernel: sd 0:0:0:0: [sda] Synchronizing SCSI cache
> Jul 10 19:22:17 n22 kernel: sd 0:0:0:0: [sda] Stopping disk
> Jul 10 19:22:17 n22 kernel: ------------[ cut here ]------------
> Jul 10 19:22:17 n22 kernel: WARNING: at drivers/pci/pci.c:1397 pci_disable_device+0x85/0x90()
> Jul 10 19:22:17 n22 kernel: Hardware name: 4180F65
> Jul 10 19:22:17 n22 kernel: Device e1000e
> Jul 10 19:22:17 n22 kernel: disabling already-disabled device
> Jul 10 19:22:17 n22 kernel: Modules linked in: dm_mod i915 sr_mod coretemp acpi_cpufreq cdrom mperf cfbfillrect cfbimgblt i2c_algo_bit cfbcopyarea intel_agp fbcon intel_gtt bitblit softcursor hid_cherry hid_generic font psmouse evdev usbhid hid video drm_kms_helper drm agpgart thermal wmi processor thinkpad_acpi tpm_tis thermal_sys tpm i2c_i801 nvram e1000e battery i2c_core hwmon tpm_bios 8250_pci fb ac button fbdev 8250_core ptp serial_core pps_core [last unloaded: microcode]
> Jul 10 19:22:17 n22 kernel: Pid: 1363, comm: kworker/u:73 Not tainted 3.9.0-rc2+ #27
> Jul 10 19:22:17 n22 kernel: Call Trace:
> Jul 10 19:22:17 n22 kernel: [<c1034b72>] warn_slowpath_common+0x72/0xa0
> Jul 10 19:22:17 n22 kernel: [<c12384a5>] ? pci_disable_device+0x85/0x90
> Jul 10 19:22:17 n22 kernel: [<c12384a5>] ? pci_disable_device+0x85/0x90
> Jul 10 19:22:17 n22 kernel: [<c1034c43>] warn_slowpath_fmt+0x33/0x40
> Jul 10 19:22:17 n22 kernel: [<c12384a5>] pci_disable_device+0x85/0x90
> Jul 10 19:22:17 n22 kernel: [<f856dcda>] __e1000_shutdown+0x2ba/0x7e0 [e1000e]
> Jul 10 19:22:17 n22 kernel: [<c139b4af>] ? klist_next+0x2f/0xd0
> Jul 10 19:22:17 n22 kernel: [<c12456b0>] ? release_pcie_device+0x20/0x20
> Jul 10 19:22:17 n22 kernel: [<f856e260>] e1000_suspend+0x20/0x50 [e1000e]
> Jul 10 19:22:17 n22 kernel: [<c123afdc>] pci_pm_suspend+0x5c/0x120
> Jul 10 19:22:17 n22 kernel: [<c12a81f1>] dpm_run_callback.isra.4+0x31/0x60
> Jul 10 19:22:17 n22 kernel: [<c12aa4de>] ? pm_wakeup_pending+0xde/0x170
> Jul 10 19:22:17 n22 kernel: [<c123af80>] ? pci_pm_freeze+0xb0/0xb0
> Jul 10 19:22:17 n22 kernel: [<c12a8420>] __device_suspend+0xc0/0x180
> Jul 10 19:22:17 n22 kernel: [<c12a891f>] async_suspend+0x1f/0x90
> Jul 10 19:22:17 n22 kernel: [<c105afb8>] async_run_entry_fn+0x38/0x140
> Jul 10 19:22:17 n22 kernel: [<c104ecb5>] process_one_work+0x105/0x300
> Jul 10 19:22:17 n22 kernel: [<c104d835>] ? start_worker+0x25/0x30
> Jul 10 19:22:17 n22 kernel: [<c105027c>] ? manage_workers+0x1ac/0x2c0
> Jul 10 19:22:17 n22 kernel: [<c105048a>] worker_thread+0xfa/0x2e0
> Jul 10 19:22:17 n22 kernel: [<c1050390>] ? manage_workers+0x2c0/0x2c0
> Jul 10 19:22:17 n22 kernel: [<c1054ca4>] kthread+0x94/0xa0
> Jul 10 19:22:17 n22 kernel: [<c13af6b7>] ret_from_kernel_thread+0x1b/0x28
> Jul 10 19:22:17 n22 kernel: [<c1054c10>] ? flush_kthread_work+0xd0/0xd0
> Jul 10 19:22:17 n22 kernel: ---[ end trace 3ee05c9da496cc06 ]---
> Jul 10 19:22:17 n22 kernel: i915 0000:00:02.0: power state changed by ACPI to D3hot
> Jul 10 19:22:17 n22 kernel: PM: suspend of devices complete after 719.702 msecs
>
> --
> MfG/Sincerely
> Toralf Förster
> pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
