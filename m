Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48310 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429Ab2E1FiP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 May 2012 01:38:15 -0400
Received: by yenm10 with SMTP id m10so1170250yen.19
        for <linux-pci@vger.kernel.org>; Sun, 27 May 2012 22:38:15 -0700 (PDT)
Date: Mon, 28 May 2012 00:38:07 -0500
From: Jonathan Nieder <jrnieder@gmail.com>
To: Jeroen Nijhof <jeroen@nijhof.co.uk>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: HP Pavilion dv6 laptop fails to boot with
 CONFIG_HOTPLUG_PCI_ACPI=y
Message-ID: <20120528053807.GA10976@burratino>
References: <87obp91jgc.fsf@tux.huis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87obp91jgc.fsf@tux.huis>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

(just forwarding without attachments to appease mail filters)
Hi,

Jeroen Nijhof wrote:

> My laptop stopped booting (properly) after upgrading
[...]
> I reported that as  http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=665493 .
>
> Further investigation shows the difference was not the extra patches,
> but a configuration change: I narrowed it down to the change from
>
>            CONFIG_HOTPLUG_PCI_ACPI=m
>  to 
>            CONFIG_HOTPLUG_PCI_ACPI=y
>
> Namely, configuring linux-stable v3.2.15 with the attached
> config-3.2.15-good booted alright, but with
> config-3.2.15-bad, with CONFIG_HOTPLUG_PCI_ACPI changed from 'm' to 'y'
> it did not -- failing one way or the other 100% of the time.

Thanks.  I'm cc-ing Bjorn Helgaas because it seems that your message
didn't hit the linux-pci list.  (Maybe it hit some length limit?)

> The problem persists with Debian's linux-image-3.3.0-trunk-amd64:amd64 
> v. 3.3.6-1~experimental.1 . And also with upstream v3.4.0: 
> compiled with the attached config-3.4.0-good (= Debian's
> config-3.2.0-1-amd64  + make oldconfig and accept defaults) it boots fine,
> but compiled with config-3.4.0-bad (= config-3.2.0-2-amd64 + make oldconfig)
> it does not.
>
> What happens for the bad v3.4.0 is that the booting gets half-way,
> but then gets stuck after "cfg80221: Calling CRDA for country: US".
> Pressing control-C then makes it continue with
> "Starting Braille terminal driver". Since /etc/rcS.d contains
> S01mountkernfs.sh, S02udev and S03brltty, in that order,
> it seems that it was stuck in S02udev.
>
> It then continues to the extent that I can log in, but it keeps
> switching virtual terminals every few seconds. I did manage to capture
> dmesg, though -- attached as dmesg-3.4.0-bad (up to 7.83 s before the control-C,
> from 34.94 after the control-C). 
> Please note the Oops at 6.23s: 
>
> [    6.231033] [drm:drm_pci_agp_init] *ERROR* Cannot initialize the agpgart module.
> [    6.233172] BUG: unable to handle kernel NULL pointer dereference at           (null)
> [    6.233325] IP: [<ffffffff8135804d>] __mutex_lock_common.isra.5+0xa0/0x167
> [    6.233426] PGD 0 
> [    6.233513] Oops: 0002 [#1] SMP 
>
> Also, udevd starts complaining continuously:
>
> udevd[364]: timeout: killing '/sbin/modprobe -b pci:v00008086d00001C20sv0000103Csd00003581bc04sc03i00' [411]
> udevd[366]: timeout: killing '/sbin/modprobe -b pci:v00001002d00006760sv0000103Csd00003581bc03sc00i00' [411]
>
> So it looks like it got stuck with the Intel audio controller (00:1b.0)
> and the Radeon VGA controler (01:00.0)

Gah.

> A following warm reboot is even worse: now it doesn't get further than
>
> Loading, please wait...
> modprobe: module unix not found in modules.dep
> INIT: version 2.88 booting
> [info] Using makefile-style concurrent booting in runlevel S
> [ ok ] Starting the hotplug events dispatcher: udevd
> [ ok ] Synthesizing the initial hotplug events...done
> [....] Waiting for /dev to be fully populated....
>
> -- and then it is stuck completely (that was with the 'normal' boot with
> the 'silent' parameter set)
>
> Since the Oops mentioned a lock, I thought I'ld try turn on lockdep,
> starting from config-3.4.0-bad and set
> CONFIG_LOCKDEP=y and CONFIG_PROVE_LOCKING=y , resulting in
> config-3.4.0-also-good . Unfortunately, this one boots without problems!
> The dmesg output from this kernel is attached as dmesg-3.4.0-also-good.
>
> Finally, I've attached the output of acpidump (acpidump.out).
>
> Any suggestions on how to narrow it down further? I'ld be happy to try
> some patches.

Thanks for a thorough report.  linux-pci folks: the attachments from
Jeroen's original message can be found at [1].  Ideas?

Thanks,
Jonathan

[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?msg=27;bug=665493
