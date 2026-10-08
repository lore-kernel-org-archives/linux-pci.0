Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789F135AC00;
	Thu,  8 Oct 2026 23:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791501467; cv=none; b=S3rwVJBu+Q9FnrK1VtLiTBWRFRz6iOr6z0DfR5ocGwDi3gTyhxQVUxltbaZczmSCK3IlHPjiXHOIRdiS8+VSkYuqSjzl0HSCbmsLGU9keja/zWlDrCd1L89kiSOxGXyHFR8uwRidXg7P2Vz4U+JiayHokvxUk1Ut8hFLHAg1Opc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791501467; c=relaxed/simple;
	bh=UZzmpaebYk3m6FnMDIYJ8kPFleAPjeYkNTgC/dfxOKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CPNR9otp/UiTg7pfUej0H6/sf0wIWlICjB8gmGYn480LcZdOqV6QO1uZCvA7enonraWBuEDE709tL7kdbVTS683fGEzSPUqG5nsrhzI0OhzYqH5DZhbHBrLkcPbegKon4w0RI1WaFr6603DNA6FuZkpkrFmDlL9QjEWYg1CllMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYg+tCJw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYg+tCJw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE16F1F000FF;
	Thu,  8 Oct 2026 23:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791501466;
	bh=0IQmUC4rybmSNfoRGU0HNL2L1MjjPpMUfkXm4Z+aTqk=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=VYg+tCJwuM4sSDuiz03IMDTgiRzoInWXwTI1krJMdhjNc3qaMObmESR+LGugqND0+
	 MhYdOEYXp8PfV+Gx73D2jArXQjJ6I4HGeX5iLl2QUs62shorU8PHnEM7BSAqhZ5ivp
	 /W5lcROGgz09fMMpEMlQE+ZDnOUPAjR+NuGwe9YHWp917Lr/T0FO9ExagsOp0YpgTT
	 FaPioV9mv0nbp3aBL6eTVI48Kd4DNgXh7Mco9khUEzcWfPGS55JhOmX86DfzAGaij2
	 RqlnA+7x0QYHth3VpZctzczPox96QSM9YtyfbmJCor2EPTypHTVH+mISAFAHzu5kUT
	 9cL4nQCQl+E1g==
Date: Thu, 8 Oct 2026 18:17:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Francisco =?utf-8?B?QmVsdHLDoW4gTWlsbGFsw6lu?= <fbeltranmillalen@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Lukas Wunner <lukas@wunner.de>, linux-usb@vger.kernel.org
Subject: Re: [PATCH] PCI: Extend Apple Thunderbolt power quirk to Alpine Ridge
Message-ID: <20261008231744.GA938694@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260924132815.24430-1-fbeltranmillalen@gmail.com>

[+cc Andreas (author of 1df5172c5c25 ("PCI: Suspend/resume quirks for
Apple thunderbolt"), Mika, Yehezkel, Lukas, linux-usb]

On Thu, Sep 24, 2026 at 10:28:15AM -0300, Francisco Beltrán Millalén wrote:
> On Macs with an Alpine Ridge Thunderbolt 3 controller, suspending to RAM
> with anything plugged into a USB-C port leaves the PCIe link between the
> root port and the controller's upstream bridge permanently untrained on
> resume.  The link does not merely fall back to a lower speed: it never
> starts.  On a MacBookPro14,3 the root port reports
> 
>   LnkSta:  Speed 2.5GT/s, Width x0
>   LnkSta2: EqualizationComplete- EqualizationPhase1- Phase2- Phase3-
> 
> with no correctable, non-fatal or fatal errors logged, and the link
> training state machine stuck at its first state.  Both Thunderbolt
> controllers, both integrated xHCIs and all four USB-C ports are lost
> until reboot.  Measured 15 failures out of 15 with a device attached,
> against 5 successes out of 5 with the ports empty; it follows the device,
> not the port, and affects either controller.
> 
> Nothing recovers the link afterwards: neither the firmware's own eleven
> retrain attempts, nor a secondary bus reset, nor bringing the controller
> out of L2, nor cutting its power entirely once the link is already down.
> 
> macOS does not hit this because it powers the controller down on the way
> into suspend.  Its AppleThunderboltNHIType3 driver calls SXFP() from
> lateSleep, and the firmware of the affected machines defines exactly that
> method: SXIO, SXLV, XRPE and XRIN, used by the drivers for older
> controllers, are not present at all.
> 
> quirk_apple_poweroff_thunderbolt() already does this for Cactus Ridge, so
> extend it rather than adding a second one.  Alpine Ridge needs only
> SXFP(0); keying the short sequence off the device ID as well as off the
> absence of SXIO/SXLV keeps Cactus Ridge behaviour unchanged.
> 
> It does need a different hook, though.  Cactus Ridge is handled as late
> as possible, in the upstream bridge's suspend_noirq.  For Alpine Ridge
> that does not prevent the failure: by the time the fixup runs there, the
> bridges of both switches have already become inaccessible --
> pci_save_state() on them has failed -- and the link still does not come
> up on resume.  Hooking the
> fixup one phase earlier, while every device below the switch is still in
> D0, makes the branch resume intact.  That also matches where macOS does
> it: SXFP() is called from lateSleep, ahead of the PCI teardown rather
> than in the middle of it.
> 
> The earlier hook needs one extra guard.  pci_fixup_suspend also runs from
> pci_pm_runtime_suspend(), and pm_suspend_via_firmware() does not
> distinguish the two cases: PM_SUSPEND_FLAG_FW_SUSPEND is only cleared at
> the beginning of the next system suspend, so it reads as set while the
> system is running again.  Without pm_suspend_in_progress() the
> controller would be powered down under a runtime-suspending bridge.
> Cactus Ridge is unaffected, as pci_fixup_suspend_late has no runtime
> counterpart, so the check is confined to the Alpine Ridge branch.
> 
> I cannot say with certainty what the platform does in between, only what
> is observed: suspend_noirq is too late and suspend_late works, on 7 out
> of 7 cycles.  For what it is worth, the firmware's own power protocol
> does not appear to be involved: the ACPI methods that drop the rails are
> all guarded on variables that only RTPC() ever writes, RTPC() is called
> by macOS and never by Linux, and those variables still read as set after
> several suspend/resume cycles on Linux.
> 
> With this, the branch comes back intact across suspend with a device
> attached: both upstream bridges enumerate, the link comes up at 8 GT/s
> x4 with equalisation complete, and USB devices are re-enumerated at
> SuperSpeed by the integrated xHCI instead of falling back to the 2.0 path
> wired straight to the PCH.  Twelve suspend/resume cycles in a single boot
> without a failure -- six of them with a USB 3 SSD attached across the
> suspend, one with it plugged in while suspended, and including lid-close
> and idle-triggered suspends -- against fifteen failures out of fifteen
> without the quirk.
> 
> Trade-off worth stating: cutting power to the controller also removes its
> ability to wake the machine, so plugging something into a USB-C port no
> longer wakes it from suspend.  Measured: with the machine suspended for
> 89 seconds, plugging the SSD into a free USB-C port did not wake it, and
> the device was enumerated 0.3 s after the machine was woken by opening
> the lid.  Opening the lid, the power button and the
> internal keyboard (which is not behind these controllers) are unaffected,
> and hotplug detection while the machine is awake is unaffected as well.
> Gating the quirk on device_may_wakeup() would disable it outright on the
> affected machines, so it is not conditional on that.
> 
> Cutting power a phase earlier has one visible consequence worth spelling
> out, since the Cactus Ridge hook does not have it: devices below the
> switch reach their own suspend_noirq after the controller is already
> off, so pci_save_state() on them fails.  In practice this is limited to
> the integrated xHCI of a branch with nothing plugged in: with a device
> attached on one side only that side stays accessible, and with both sides
> empty both xHCIs report it -- and xhci-hcd handles it as the
> ordinary "root hub lost power or was reset" path and reinitialises the
> controller on resume; the branch comes back complete.  It is also
> strictly less than what happens without the quirk, where the whole
> branch, bridges included, goes inaccessible instead of a single
> endpoint.  It is also cleaner with
> 
>   https://lore.kernel.org/linux-pci/20260924124221.12374-1-fbeltranmillalen@gmail.com/
> 
> applied, which stops pci_save_state() from storing all-ones and marking
> the state as saved when the device is already gone.  That series and this
> quirk were developed together on the same machine: the series keeps the
> resume from writing garbage back, and this patch keeps the controller
> from disappearing in the first place.  Neither depends on the other to
> build or to be correct.
> 
> Notes and limitations:
> 
>   * Only the 4C bridge (8086:1578) is added.  The 2C variant very likely
>     needs the same treatment but I have no hardware to test it on, so I
>     am not declaring it.
>   * Tested only with USB devices behind the controller's integrated
>     xHCI, not with a real Thunderbolt device.
>   * Depends on the platform suspending via firmware (mem_sleep=deep);
>     pm_suspend_via_firmware() already guards this.
>   * pm_suspend_in_progress() is false during hibernation, so unlike the
>     Cactus Ridge path this does not run on hibernate.  I have no way to
>     test that path on this machine (the hibernate targets are masked),
>     and leaving it out is the conservative choice.
> 
> Tested on 6.18.49 on a MacBookPro14,3.

Thanks for all this detail.  I think it's too much for a commit log,
but it would be good to have it after the "---" where it's in the
email but not the git commit.  This is easily accessible via the
"Link: https://patch.msgid.link/" tag that we add when applying.

> Signed-off-by: Francisco Beltrán Millalén <fbeltranmillalen@gmail.com>
> ---
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3879,7 +3879,7 @@
>   */
>  static void quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
>  {
> -	acpi_handle bridge, SXIO, SXFP, SXLV;
> +	acpi_handle bridge, SXIO = NULL, SXFP = NULL, SXLV = NULL;
>  
>  	if (!x86_apple_machine)
>  		return;
> @@ -3906,8 +3906,34 @@
>  	 * associated ACPI methods. This implicitly checks that we are at
>  	 * the right bridge.
>  	 */
> +	if (ACPI_FAILURE(acpi_get_handle(bridge, "DSB0.NHI0.SXFP", &SXFP)))
> +		return;
> +
> +	/*
> +	 * Alpine Ridge uses a shorter sequence: macOS' AppleThunderboltNHIType3
> +	 * calls only SXFP() from its lateSleep handler, and the firmware of the
> +	 * affected machines does not even define SXIO or SXLV.  Keying this off
> +	 * the device ID as well keeps the longer sequence for Cactus Ridge.
> +	 */
> +	if (dev->device == PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_BRIDGE) {
> +		/*
> +		 * Unlike the suspend_late fixup used for Cactus Ridge, the
> +		 * suspend fixup also runs on runtime suspend, and
> +		 * pm_suspend_via_firmware() is not enough to tell the two
> +		 * apart: that flag is only cleared at the beginning of the
> +		 * next system suspend, so it stays set while the system is
> +		 * running again.  Without this check the controller would be
> +		 * powered down under a runtime-suspending bridge.
> +		 */
> +		if (!pm_suspend_in_progress())
> +			return;
> +
> +		pci_info(dev, "quirk: cutting power to Thunderbolt controller...\n");
> +		acpi_execute_simple_method(SXFP, NULL, 0);
> +		return;
> +	}
> +
>  	if (ACPI_FAILURE(acpi_get_handle(bridge, "DSB0.NHI0.SXIO", &SXIO))
> -	    || ACPI_FAILURE(acpi_get_handle(bridge, "DSB0.NHI0.SXFP", &SXFP))
>  	    || ACPI_FAILURE(acpi_get_handle(bridge, "DSB0.NHI0.SXLV", &SXLV)))
>  		return;
>  	pci_info(dev, "quirk: cutting power to Thunderbolt controller...\n");
> @@ -3923,6 +3949,22 @@
>  DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
>  			       PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
>  			       quirk_apple_poweroff_thunderbolt);
> +
> +/*
> + * Alpine Ridge needs the opposite of the above: SXFP() has to run while the
> + * switch is still up, not once it is being torn down.
> + *
> + * Hooked at suspend_noirq like Cactus Ridge it does not prevent the failure:
> + * by the time the upstream bridge is reached, the bridges of both switches have
> + * already become inaccessible -- pci_save_state() on them fails -- and the link
> + * still does not come up on resume.  Hooked one phase earlier, while every device below the
> + * switch is still in D0, the branch resumes intact.  That is also where macOS
> + * does it: AppleThunderboltNHIType3 calls SXFP() from lateSleep, ahead of the
> + * PCI teardown rather than in the middle of it.

Wrap these to fit in 80 columns like the rest of the file.  Ideally 75
or so; that allows minor changes and typo fixes without overflowing.

> + */
> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_INTEL,
> +			  PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_BRIDGE,
> +			  quirk_apple_poweroff_thunderbolt);
>  #endif
>  
>  /*
