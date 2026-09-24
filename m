Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8955477E
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 13:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790256519; cv=none; b=lfFGoRo4iUSazh/cx5txKBnk5m1yr7cJ+uiys/zN4t3PGK9i8xQ7/8mGgar9B3bkAo/ItyHQnXYhLe6zVO6utyJllPsAiveJbQALmjBVOK6eG4gPeycW+hy7/n5S0h5Ok9RgR79rNWX/GzjGj2oYsGv68rnORA5DLFrKyD3DHLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790256519; c=relaxed/simple;
	bh=lUimMC1hvKUm2K1Bt5yM6aAWTSveEauXO5YE/TkchvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GzXY41gmmRUFlskNQjLMWNuDqdjZoN9PVbgmDzgPpJpgKZDJn5wRbzfQ1WGqWKXOGRL3WdaTI64fZAw4PCHpcBLR+7Ah9p22ZKa54oFYNFdC2j1Misy6Z2hI3qL50+6BjiDFgInR7oXexhVrF03PsMrArY8n0KEZxAq7N40XQCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLGzQIpR; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLGzQIpR"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-33bb1a50f6fso858230eec.2
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 06:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790256509; x=1790861309; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ks0r2jI/9TAO4/7/MXrEkEWawRtQX+38ZOiBfceceLc=;
        b=fLGzQIpRh2h5sAF16F7IynIVQjp7rpWaEYMsaMPojn3jyRh+DljTxMZdWg3p3rC4CR
         I5cHPKqaUDgaxYQOOaayKjj8aYgs7Z3yOtNLlDrIxc7Ku3Z2T2fkL38JIZBVbyJy+1+D
         hUVP3nZODdU56nB4subevo/ChxRiuu4Qh0NnFBUjrthkOF5QHPm9Ju3zQy8KnHQ7Ij11
         gVest82xsKIoKfNxrAkL0cBez8hlYu7H27eXT6O6JdhICqmhev0Z51ZQ22UtxKM0HboA
         BsXfj68hGMqtSPVJDFP+S3dN/2UBsxvUxkDkUZxrGxOhBupRWoKxy8DKAI9wX5sk6Uci
         saZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790256509; x=1790861309;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ks0r2jI/9TAO4/7/MXrEkEWawRtQX+38ZOiBfceceLc=;
        b=xYfuHwf6yHeGZXAu77sjAW3gcYyH+jN/MO7z+dNhXfLSKygl0hFmuahStsAtb7Ug3A
         fvPt6y5Fe4B0VJClRRsdQkj3lQlVjwznMFQBiKFHp6BQx+wxFhzxIetvfe9QmN+DecPP
         asYJrwZOZlgiheEmJnN+WFZSk1oo7EB/QQge8363Q+v9PyrVCJXXbzN57J6KXvqYyT7K
         j62bHr/lu9p5Z68RPtJRf+ZZyHwzc/JGTmUfQ10WcXIj6s8pFTDFkNJ6Z/1t8Qk/CLeL
         ZWbjobYGwwn5r9UUiVfum+n+WKcU4xQPdweY9LgR4SfMYLqLjiGDsNXAjlSV/gSTcZ6g
         VdUw==
X-Forwarded-Encrypted: i=1; AKwUvBzt10LjKrw2ndf//DcWZtHNdQwPrWdANHfgLWQmxQMpBtIR+yFhdOVVnuuYSv1s8aqZGLycJixTzHU=@vger.kernel.org
X-Gm-Message-State: AFuF++k3z4R4QTaN286zN5dMtb7pMpUUy/Ur30MyHzf0CbaemV5GmGeY
	WvSYwUB/yCPnlW/JsdC8MoSsbqvg5LU4iiRY4ckQS9vBP3S6T68QAYmO6WdIFw==
X-Gm-Gg: AYBFou0kU+v/UkZb9Aj+89RvDQpz4L2+Lp0tX4aJavdD0R50B/fctFtW57uz0ytzViw
	8FlNV0y0iQijWKCyVvuBpSH1MirUEzArCx1Tangwl2TZW5adc62t0uR5lTEHujL6czGksH4tMpt
	1oWSzCE9qtEI5yDqNQKjjAlcJ0e8eHIkMXDcFNYltnNmQkdi3FMTSCf+d09F/PLsTM28JL6lSyh
	0gOSHnSGb1+DVupFxim0FWd6Ku3yeCIglm+AoiLl6brbdVJY7x+iXrw4V8OM856h8OKCx2xduef
	tQOererIsRAzo6nTOWGevRXBL5HJoAnEPSpfKxHnsFk1zgqyjE9EvYy0XzBoLsYMWlfVwPSUEfJ
	lKLU2rQMHFLfEwPfNTNOcZIhoUr3514FYd3nAgudYUjgfDawv/Il/BJNeohdnISV9pOycPyVlqI
	aen2916aIsRx3AVVrM34LCeYHRc2fn/r8h8Vsm116zQKq6UCXfYezLIPqBtggAGAyLg7KI3gu3m
	6vQ/K3n
X-Received: by 2002:a05:7301:e10b:b0:33c:141b:73a5 with SMTP id 5a478bee46e88-34006f8c72bmr2044103eec.41.1790256509193;
        Thu, 24 Sep 2026 06:28:29 -0700 (PDT)
Received: from maclinux ([2803:c600:9110:8ba5:43a9:9b8b:ebdc:6411])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e939fdd91sm14839600eec.4.2026.09.24.06.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 06:28:28 -0700 (PDT)
From: =?UTF-8?q?Francisco=20Beltr=C3=A1n=20Millal=C3=A9n?= <fbeltranmillalen@gmail.com>
To: bhelgaas@google.com,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Extend Apple Thunderbolt power quirk to Alpine Ridge
Date: Thu, 24 Sep 2026 10:28:15 -0300
Message-ID: <20260924132815.24430-1-fbeltranmillalen@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Macs with an Alpine Ridge Thunderbolt 3 controller, suspending to RAM
with anything plugged into a USB-C port leaves the PCIe link between the
root port and the controller's upstream bridge permanently untrained on
resume.  The link does not merely fall back to a lower speed: it never
starts.  On a MacBookPro14,3 the root port reports

  LnkSta:  Speed 2.5GT/s, Width x0
  LnkSta2: EqualizationComplete- EqualizationPhase1- Phase2- Phase3-

with no correctable, non-fatal or fatal errors logged, and the link
training state machine stuck at its first state.  Both Thunderbolt
controllers, both integrated xHCIs and all four USB-C ports are lost
until reboot.  Measured 15 failures out of 15 with a device attached,
against 5 successes out of 5 with the ports empty; it follows the device,
not the port, and affects either controller.

Nothing recovers the link afterwards: neither the firmware's own eleven
retrain attempts, nor a secondary bus reset, nor bringing the controller
out of L2, nor cutting its power entirely once the link is already down.

macOS does not hit this because it powers the controller down on the way
into suspend.  Its AppleThunderboltNHIType3 driver calls SXFP() from
lateSleep, and the firmware of the affected machines defines exactly that
method: SXIO, SXLV, XRPE and XRIN, used by the drivers for older
controllers, are not present at all.

quirk_apple_poweroff_thunderbolt() already does this for Cactus Ridge, so
extend it rather than adding a second one.  Alpine Ridge needs only
SXFP(0); keying the short sequence off the device ID as well as off the
absence of SXIO/SXLV keeps Cactus Ridge behaviour unchanged.

It does need a different hook, though.  Cactus Ridge is handled as late
as possible, in the upstream bridge's suspend_noirq.  For Alpine Ridge
that does not prevent the failure: by the time the fixup runs there, the
bridges of both switches have already become inaccessible --
pci_save_state() on them has failed -- and the link still does not come
up on resume.  Hooking the
fixup one phase earlier, while every device below the switch is still in
D0, makes the branch resume intact.  That also matches where macOS does
it: SXFP() is called from lateSleep, ahead of the PCI teardown rather
than in the middle of it.

The earlier hook needs one extra guard.  pci_fixup_suspend also runs from
pci_pm_runtime_suspend(), and pm_suspend_via_firmware() does not
distinguish the two cases: PM_SUSPEND_FLAG_FW_SUSPEND is only cleared at
the beginning of the next system suspend, so it reads as set while the
system is running again.  Without pm_suspend_in_progress() the
controller would be powered down under a runtime-suspending bridge.
Cactus Ridge is unaffected, as pci_fixup_suspend_late has no runtime
counterpart, so the check is confined to the Alpine Ridge branch.

I cannot say with certainty what the platform does in between, only what
is observed: suspend_noirq is too late and suspend_late works, on 7 out
of 7 cycles.  For what it is worth, the firmware's own power protocol
does not appear to be involved: the ACPI methods that drop the rails are
all guarded on variables that only RTPC() ever writes, RTPC() is called
by macOS and never by Linux, and those variables still read as set after
several suspend/resume cycles on Linux.

With this, the branch comes back intact across suspend with a device
attached: both upstream bridges enumerate, the link comes up at 8 GT/s
x4 with equalisation complete, and USB devices are re-enumerated at
SuperSpeed by the integrated xHCI instead of falling back to the 2.0 path
wired straight to the PCH.  Twelve suspend/resume cycles in a single boot
without a failure -- six of them with a USB 3 SSD attached across the
suspend, one with it plugged in while suspended, and including lid-close
and idle-triggered suspends -- against fifteen failures out of fifteen
without the quirk.

Trade-off worth stating: cutting power to the controller also removes its
ability to wake the machine, so plugging something into a USB-C port no
longer wakes it from suspend.  Measured: with the machine suspended for
89 seconds, plugging the SSD into a free USB-C port did not wake it, and
the device was enumerated 0.3 s after the machine was woken by opening
the lid.  Opening the lid, the power button and the
internal keyboard (which is not behind these controllers) are unaffected,
and hotplug detection while the machine is awake is unaffected as well.
Gating the quirk on device_may_wakeup() would disable it outright on the
affected machines, so it is not conditional on that.

Cutting power a phase earlier has one visible consequence worth spelling
out, since the Cactus Ridge hook does not have it: devices below the
switch reach their own suspend_noirq after the controller is already
off, so pci_save_state() on them fails.  In practice this is limited to
the integrated xHCI of a branch with nothing plugged in: with a device
attached on one side only that side stays accessible, and with both sides
empty both xHCIs report it -- and xhci-hcd handles it as the
ordinary "root hub lost power or was reset" path and reinitialises the
controller on resume; the branch comes back complete.  It is also
strictly less than what happens without the quirk, where the whole
branch, bridges included, goes inaccessible instead of a single
endpoint.  It is also cleaner with

  https://lore.kernel.org/linux-pci/20260924124221.12374-1-fbeltranmillalen@gmail.com/

applied, which stops pci_save_state() from storing all-ones and marking
the state as saved when the device is already gone.  That series and this
quirk were developed together on the same machine: the series keeps the
resume from writing garbage back, and this patch keeps the controller
from disappearing in the first place.  Neither depends on the other to
build or to be correct.

Notes and limitations:

  * Only the 4C bridge (8086:1578) is added.  The 2C variant very likely
    needs the same treatment but I have no hardware to test it on, so I
    am not declaring it.
  * Tested only with USB devices behind the controller's integrated
    xHCI, not with a real Thunderbolt device.
  * Depends on the platform suspending via firmware (mem_sleep=deep);
    pm_suspend_via_firmware() already guards this.
  * pm_suspend_in_progress() is false during hibernation, so unlike the
    Cactus Ridge path this does not run on hibernate.  I have no way to
    test that path on this machine (the hibernate targets are masked),
    and leaving it out is the conservative choice.

Tested on 6.18.49 on a MacBookPro14,3.

Signed-off-by: Francisco Beltrán Millalén <fbeltranmillalen@gmail.com>
---
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3879,7 +3879,7 @@
  */
 static void quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
 {
-	acpi_handle bridge, SXIO, SXFP, SXLV;
+	acpi_handle bridge, SXIO = NULL, SXFP = NULL, SXLV = NULL;
 
 	if (!x86_apple_machine)
 		return;
@@ -3906,8 +3906,34 @@
 	 * associated ACPI methods. This implicitly checks that we are at
 	 * the right bridge.
 	 */
+	if (ACPI_FAILURE(acpi_get_handle(bridge, "DSB0.NHI0.SXFP", &SXFP)))
+		return;
+
+	/*
+	 * Alpine Ridge uses a shorter sequence: macOS' AppleThunderboltNHIType3
+	 * calls only SXFP() from its lateSleep handler, and the firmware of the
+	 * affected machines does not even define SXIO or SXLV.  Keying this off
+	 * the device ID as well keeps the longer sequence for Cactus Ridge.
+	 */
+	if (dev->device == PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_BRIDGE) {
+		/*
+		 * Unlike the suspend_late fixup used for Cactus Ridge, the
+		 * suspend fixup also runs on runtime suspend, and
+		 * pm_suspend_via_firmware() is not enough to tell the two
+		 * apart: that flag is only cleared at the beginning of the
+		 * next system suspend, so it stays set while the system is
+		 * running again.  Without this check the controller would be
+		 * powered down under a runtime-suspending bridge.
+		 */
+		if (!pm_suspend_in_progress())
+			return;
+
+		pci_info(dev, "quirk: cutting power to Thunderbolt controller...\n");
+		acpi_execute_simple_method(SXFP, NULL, 0);
+		return;
+	}
+
 	if (ACPI_FAILURE(acpi_get_handle(bridge, "DSB0.NHI0.SXIO", &SXIO))
-	    || ACPI_FAILURE(acpi_get_handle(bridge, "DSB0.NHI0.SXFP", &SXFP))
 	    || ACPI_FAILURE(acpi_get_handle(bridge, "DSB0.NHI0.SXLV", &SXLV)))
 		return;
 	pci_info(dev, "quirk: cutting power to Thunderbolt controller...\n");
@@ -3923,6 +3949,22 @@
 DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
 			       PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
 			       quirk_apple_poweroff_thunderbolt);
+
+/*
+ * Alpine Ridge needs the opposite of the above: SXFP() has to run while the
+ * switch is still up, not once it is being torn down.
+ *
+ * Hooked at suspend_noirq like Cactus Ridge it does not prevent the failure:
+ * by the time the upstream bridge is reached, the bridges of both switches have
+ * already become inaccessible -- pci_save_state() on them fails -- and the link
+ * still does not come up on resume.  Hooked one phase earlier, while every device below the
+ * switch is still in D0, the branch resumes intact.  That is also where macOS
+ * does it: AppleThunderboltNHIType3 calls SXFP() from lateSleep, ahead of the
+ * PCI teardown rather than in the middle of it.
+ */
+DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_INTEL,
+			  PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_BRIDGE,
+			  quirk_apple_poweroff_thunderbolt);
 #endif
 
 /*
