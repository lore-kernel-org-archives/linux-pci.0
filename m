Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Faerbit <faerbit@gmail.com>
Cc: linux-pci@vger.kernel.org,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: Hibernation problem with 3.14 kernel
Date: Sun, 20 Apr 2014 01:26:13 +0200
Message-ID: <1438736.ANSVkEtpCM@vostro.rjw.lan>
In-Reply-To: <534EEE4D.7070203@gmail.com>
References: <534EEE4D.7070203@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, April 16, 2014 10:55:41 PM Faerbit wrote:
> Hi everyone,

Hi,

> I hope I am posting in the right section.
> Since the upgrade to kernel 3.14 I am unable to hibernate.
> I am using Archlinux.
> I am hibernating with "systemctl hibernate".
> It always fails to freeze device 00:08:
> 
> journalctl tells me:
> kernel: serial 00:08: disable failed
> kernel: dpm_run_callback(): pnp_bus_freeze+0x0/0x20 returns -5
> kernel: PM: Device 00:08 failed to freeze: error -5
> 
> lspci -v tells me:
> 
> 0:08.0 PCI bridge: NVIDIA Corporation MCP78S [GeForce 8200] PCI Bridge
> (rev a1) (prog-if 01 [Subtractive decode])
>     Flags: bus master, 66MHz, fast devsel, latency 0
>     Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
>     Capabilities: [b8] Subsystem: ASUSTeK Computer Inc. Device 82e7
>     Capabilities: [8c] HyperTransport: MSI Mapping Enable+ Fixed-
> 
> My mainboard is a ASUS M4N98TD EVO.

It's not that device, what fails is a serial drvier.

> What does error code -5 mean?

This is an error code returned by the driver, I'm not sure what it means
for pnp_bus_freeze() from the top of my head (will check later).

> How do I debug this further?

If that's 100% reproducible, you can try to bisect.

> Should I file a bug?

Yes, please.  At bugzilla.kernel.org, against power management (hibernation/suspend).

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
