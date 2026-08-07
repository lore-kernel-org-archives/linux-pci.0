Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E599C3B19D0;
	Fri,  7 Aug 2026 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786092839; cv=none; b=EkNeM3sxbkhYRP4r7bmqLdy1YPZ3HTlYfOi8GtUdoFU6OJyy1EUO9KM5XDGyZxKSZh/04p4owmfiekXzrzemCYeqM53W5VM7GZngP+R62W1rgg0PleSEKx3Pb1b/vDX4hjmVHkzjEstF851diSCCArXIuk5n/3s5bS12q40lhIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786092839; c=relaxed/simple;
	bh=23qsEFqvOs3i3JTL26SnDSfYWugKyxCQG4uBV8GmIMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keZikYTQ0EsmG3g63cE+zl4zmq/G8ZeZD0qAfO+9hs9juLqq8KySHoYgCdn4x2JGO9bGMCgyQ+EuEmpHRoqb4Bg6eQesYhZE37aYJ+tS5BA63I/lp5sn4/QCYFMnddnFgpNVrIM9hFDuWhpCFbwykGKQvVBSv9mi3H+cn912VLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 0057110612;
	Fri, 07 Aug 2026 10:53:48 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id DA73C602CF8B; Fri,  7 Aug 2026 10:53:47 +0200 (CEST)
Date: Fri, 7 Aug 2026 10:53:47 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pci: quirks: Disable native PCIe hotplug on MSI Claw
 A8 root bridge
Message-ID: <anWdGzfD7HxglsOB@wunner.de>
References: <20260806214808.1202819-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806214808.1202819-1-derekjohn.clark@gmail.com>

On Thu, Aug 06, 2026 at 09:48:08PM +0000, Derek J. Clark wrote:
> The MSI Claw A8 (MS-1T8K) hard-locks on resume from s2idle whenever an
> SD/MMC card is present in the onboard Realtek RTS525A card reader
> (10ec:525a), which sits behind root port 0000:00:02.2.

The RTS525A is known to falsely claim that it supports ASPM L0s,
even though it only supports L1.  There is a patch pending to
work around this hardware erratum, I'm wondering whether it
makes the issue go away on the MSI Claw A8?

https://lore.kernel.org/r/20260707021527.639611-1-max.lee@canonical.com/

> The reader's PCIe endpoint is fixed/soldered and not user-hotpluggable.
> Firmware advertises this root port as PCIe hotplug-capable

That looks like an oversight on the part of MSI.  Is there a BIOS update
available which clears the Hot-Plug Capable bit in the Slot Capabilities
Register?  (I'm *assuming* that bit is set -- I haven't seen any dmesg
or lspci -vvv output in your e-mails, perhaps you could open a bug
at bugzilla.kernel.org and upload it there.)

> When native hotplug is OS-owned,
> resuming from s2idle races the port's hotplug/PME resume handling
> against the RTS525A's own resume sequence when a card is present,
> hard-locking the system.

This sounds like a driver bug in rtsx_pci which needs to be root-caused
and fixed, rather than worked around.

pciehp (the OS-native PCIe hotplug driver) normally doesn't de-enumerate
and re-enumerate devices on resume from system sleep.  It uses a heuristic
to determine whether the device in the slot was replaced during system
sleep and synthesizes a hotplug event if it believes there's now a different
device in the slot.  Otherwise it just leaves the device in the slot alone.
The replacement detection is in pciehp_device_replaced(),
drivers/pci/hotplug/pciehp_hpc.c line 567.  You could try hacking
that function to return false and see if it helps.

The heuristic looks at the Vendor ID and Device ID in config space.
I do recall that a different type of card readers, RTS5261, trigger
a hotplug event when a regular UHS card is replaced with an SD Express
card.  The card reader is hot-unplugged and the SD Express card appears
as an NVMe drive with a different Device ID in config space:

https://lore.kernel.org/r/20231016040132.23824-1-kai.heng.feng@canonical.com/

That said, I'm not even sure RTS525A supports SD Express.

What kind of card do you have inserted in the card reader, is it UHS
or SD Express?  Does the issue go away if you eject the card before
going to system sleep?

> +++ b/drivers/pci/quirks.c
[...]
> +/*
> + * The MSI Claw A8 firmware advertises native PCIe hotplug support for
> + * this root port, but native hotplug handling causes resume failures.
> + * Prevent the PCIe port driver from claiming native hotplug ownership
> + * of this port.
> + */
> +static void quirk_claw_a8_no_native_hotplug(struct pci_dev *pdev)
> +{
> +	if (!dmi_match(DMI_BOARD_NAME, "MS-1T8K"))
> +		return;
> +
> +	if (pdev->bus->number != 0 ||
> +	    PCI_SLOT(pdev->devfn) != 2 ||
> +	    PCI_FUNC(pdev->devfn) != 2)
> +		return;
> +
> +	pci_info(pdev, "disabling native PCIe hotplug\n");
> +	pdev->is_hotplug_bridge = 0;
> +	pdev->is_pciehp = 0;
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, 0x150b,
> +			 quirk_claw_a8_no_native_hotplug);

Unfortunately this is just a workaround that happens to make the
issue disappear, but we'd really want to identify the root cause
first.

If you boot with no_console_suspend, are you able to see any messages
on suspend or resume that could help us understand what is going on?

Thanks,

Lukas
