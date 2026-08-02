Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818CE38F945;
	Sun,  2 Aug 2026 08:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785660189; cv=none; b=PQv3g5115FHFKTA+B8DgEp+2KP4D5ar4UkqCZRdOr+jfEmaPSH7vfdnF8x/r9JeJ2F5CDRdSCyDlmudSo4DApbT3Df64NRlyH5qRe3Ly23uY04EaewrtDDUheAW6yqTi35ctwV3090+3EXg9jWo9UGruGsUqwEMl/xF+T0fgwkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785660189; c=relaxed/simple;
	bh=t/Mzhl0iWiOWcXG8RMIvG4U92wSkIF65CvQav9fveP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arvZC1sHSGoOm2kBvYtJe0Qiqed+yZTgW2Ej6fd8vxCtwC7jO0xT42oHyJY9qf7ovsFYWgAUtGH1Sx7L3Mepsn/QmaKbegAMmPWfn8C6dDen8AaLP+ZM6PP7349y4ZbXRrl6cHOAROyNVcOJGJx9cWSk8Zlq6YTnhk1Aiv6ANC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 111A635E;
	Sun, 02 Aug 2026 10:42:57 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E63416097A76; Sun,  2 Aug 2026 10:42:56 +0200 (CEST)
Date: Sun, 2 Aug 2026 10:42:56 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Lowne Onema <lowneonema@gmail.com>
Cc: bhelgaas@google.com, rafael.j.wysocki@intel.com,
	alexander.deucher@amd.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: quirks: Prevent D3 for Acer Swift SF515-51T Root
 Port to fix audio
Message-ID: <am8DEH0wfphdAX0n@wunner.de>
References: <CA+1pjEmQgcfhjj56yjuXWVshBM+soFC7RZHaGwaaF=ZFCr1Lyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1pjEmQgcfhjj56yjuXWVshBM+soFC7RZHaGwaaF=ZFCr1Lyg@mail.gmail.com>

On Sat, Aug 01, 2026 at 08:10:25PM +0200, Lowne Onema wrote:
> commit c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for D3 if
> power managed by ACPI") made Root Ports newly eligible for D3 when
> ACPI reports the port as power-manageable. On my Acer Swift
> SF515-51T, this Root Port (Intel Cannon Point-LP PCI Express Root
> Port #9, 8086:9db0, always empty on this SKU) is put into D3 as a
> result, and doing so permanently silences the internal speakers
> until the machine is rebooted.
> 
> Disassembly of this board's ACPI tables shows the Root Port's power
> resource (RP09.PXP) and the SATA port SAT0.PRT1 share GPIO pin
> 0x0402000D as their power enable line. That GPIO also gates a
> rail the internal speaker amplifier depends on, but this dependency
> is not expressed anywhere in ACPI -- HDAS._PR0 only references
> PAUD, so the kernel has no way to know that putting the Root Port in D3
> cuts power the audio codec/amp circuitry needs.
[...]
> I went with a DMI-matched PCI_DEV_FLAGS_NO_D3 quirk since that seems to
> be the go-to pattern in this file for "device breaks in D3" cases (I saw
> quirk_no_ata_d3 above it). Is that the right mechanism here, or would
> you prefer something scoped differently?

It is *one* option.  An alternative approach we've used in similar
cases is to create a device link.  It allows expressing a power
dependency of one device on another device.  E.g. GPUs frequently
expose an HDA controller as Function 1 of a PCI device which is
only accessible if Function 0 (the actual GPU) is powered on.
See quirk_gpu_hda() in drivers/pci/quirks.c.  For this approach
you need two struct device (the supplier and the consumer) and
I'm not sure if the speaker or speaker amplifier is represented
as a struct device.  If it's not, then this approach is not viable.
A workaround might be to use the HDA controller as supplier (to which
the speaker is attached), but that's not perfect.

Another option would be to patch the ACPI tables.  There are several
ways to do this via the initrd, via EFI etc.  See:

admin-guide/acpi/initrd_table_override.rst
https://github.com/xCuri0/ReBarUEFI/wiki/DSDT-Patching
https://wiki.archlinux.org/title/DSDT

Using a DSDT patch benefits other OSes you might have installed,
but doesn't benefit other Linux users who encounter the same problem.

In drivers/acpi/x86/ we carry a number of ACPI quirks for problematic
devices.  Amending that would be a third option to overcome the issue.
The kernel enumerates power resources and the dependencies of devices
on them, basically you'd have to add a quirk to amend those data
structures.  At the bottom of drivers/acpi/power.c, you'll find
existing quirks for products with broken power resource descriptions.
I don't know why these live in power.c, they're x86-specific and
everything in this file is also compiled into kernels for other
ACPI-supporting arches such as arm64.  Generally we try to move such
quirks to files that are only compiled on x86 (such as everything
under drivers/acpi/x86) or at least #ifdef them to CONFIG_X86.

The fourth and best option would be if the vendor would provide
a BIOS update to fix the ACPI table.  Often vendors are loathe
to do this for older products and then a workaround at the OS level
is the only solution, but please double-check that you've got the
latest BIOS version installed.

> Fixes: c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for D3 if
> power managed by ACPI")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=212463
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=214125
> Signed-off-by: paasshme <lowneonema@gmail.com>

A minor nit, you should use your real name in the Signed-off-by tag,
you may want to use "Closes:" instead of "Link:" and you may also
want to add a tag "Cc: stable@vger.kernel.org # v5.10+".

> Apologies in advance for any formatting/process mistakes,
> that's my first patch.

You're doing great!  I am sorry for the breakage caused by my commit!

Thanks,

Lukas
