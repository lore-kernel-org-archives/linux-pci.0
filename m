Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com [74.125.227.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F67F486403
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 13:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790256567; cv=none; b=dgvr+1KmusU2sMaT8vfb3IOlX2J8hHHTSr/1D9iWSRGSlo4hhr6Zf3zTGX67Jd7LogF84J6RASCR8W8wnK6tKA3G2tr1i5e/zyxETgXNv+1ZT91hU9Kx/A0Ckl753lZV5CUt252kRULl4ZjH8AMRUS/e0+lusvf2SfUPwEoDog4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790256567; c=relaxed/simple;
	bh=2b3dzNDHb6p5o6L8IhZiMGWrYX5yxOgf7BIMickiWCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aaP/RcuQ5dAOqF3TjkU8njc8vh5IqTuzj0VrnXs9ztDnQeaGUSC6EoMCpCDP6nXNplTRO2mAS4b6NRXuvpSOta5Ur11nss0vitGF5x6ZgYPdHVacahnfPxYunyuubOzFiE4PjL0ElNRXsBwIsJplN6rzCd/BT+TNqq4utWArutg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nuaVf9dk; arc=none smtp.client-ip=74.125.227.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nuaVf9dk"
Received: by mail-vs2-f41.google.com with SMTP id 71dfb90a1353d-5c9031e714dso791670e0c.3
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 06:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790256555; x=1790861355; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WiOjRaKfF0vUqv8jQnQqyvZEh2gZF6+fO0ZCS3cuQxg=;
        b=nuaVf9dkdi7WZPWlERMIf6U+9X8w+G3PFxIHFIcQ05JEufsj6KQMuqiJCBurGUmnMt
         kIhPAXY3sTE7AMFJ3ksHi09WPngEe0eQoYF06C0KH+D+7Bnqxe6cQq3Ai9TheDg1/02R
         ViZe+wC1q/VrcgXTx69U7m6mdzxfTHPVjww66mew2jEuFb8ZjEf3qQBDePIlYQ8MGPhP
         tLQ8E393ah1Y2O7ST5iw6x0O7T64qeG7+UEZGRvSW8uHyE2F0ZWNnyPNFD1XkPIPeJxc
         32XAsMZfNHxNsooDmTDtTY5TRnX1IzfTBo8QHELMS5IcJ50lNPvYZbZr+guu/5sO2YWk
         h+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790256555; x=1790861355;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WiOjRaKfF0vUqv8jQnQqyvZEh2gZF6+fO0ZCS3cuQxg=;
        b=aoshCee/eVP5QU7n5sfLNJCSwC5vR0HvxZtx4yDajWwRZnB54mkRq+GAacjQqEfhPV
         toyjUgDEnst6+k1TA7DcrI11vA84AtzoPVMmiRMdv7sgqcw0qkjwH2mttQ6GAGLN30hy
         WaGZWFxtuNLWtHjQTc4wOtCVlMxdS0iA7MGFA9b0gyvUe1eSEZzB6d9UtLJxmRoK27qq
         W0N8c9YWwEUEXVhT9PSghH65nSBPIx8uOvbs4VeJU6HFc5oy4Yx6+xkhq+SQBCOMhyY3
         6elxsMfAyBDhR0kdh/LlJTCjh4uqm4A4wZ+lkH9WWUKGiIdq26Q27tITFZuaV7flAz+u
         MzdA==
X-Forwarded-Encrypted: i=1; AKwUvBwMlATINWggT1sFGHa9RAPo4PmHEiznQwYo/zCOnUVxeqT+UtblvSEUI9bU/YEPzo5EKbcN5Ik937k=@vger.kernel.org
X-Gm-Message-State: AFuF++mmXaOtVm/fPaitW634Rbay5wi9yV5ztDP+5u72EfqyRT/Dtma7
	vOrbhBdtiJSEaHHqTAkXZmWTGl6ficlxKS+TSH0uepRzVJtO65tM8ieS
X-Gm-Gg: AYBFou3zXE8yIkZgb007uqXMNYK3imW/vB2BAOdYx0bizmNchVT3WKgWZhZwpQq1fsb
	M8Y3uNvLt6u2/5K67vQhYVMf+qmbRSQSyuFsDm1ylKkWUXgVL9hiVC8INfwa37KsOflskxi3+50
	5+aEfnFY6uHH2JgLqgBoHYwe6M/zgwcyOt2HbqAJWfkAeXU7xDseDbOix6xK2fN0aB1CJm91ZVz
	7+N8f4fR4viq16J1JZiUO7uPxYPtkNZe1JXxQjJobjyQNs+eOVwv9rfBNM44jNwf5dvzB7xxhiu
	A8G9eI1ksdtNAHpdpBjGhY1++olDnLvcg6xonKNz3eBOit5kJ9vJJQ/wGn9lXFxbM4aq4D6Vw2L
	kYtCNuNkoBQekQNhxTZmM+ax9+kSHdNkVZDE/Kn4btjuTZyhwlyKshnC/mLekrZ7znhisncLoyO
	0Jhk/Hh8gSREZGnz3zMHgAVM+TMQ3HbEINdpdEjEWyQ49YY/YJwsXh62Y0yrAttuVZBbw5aUKtG
	WcoClu6Qg==
X-Received: by 2002:a05:6122:2985:b0:5c9:a60d:3278 with SMTP id 71dfb90a1353d-5cb0b583951mr1377425e0c.12.1790256555017;
        Thu, 24 Sep 2026 06:29:15 -0700 (PDT)
Received: from maclinux ([2803:c600:9110:8ba5:43a9:9b8b:ebdc:6411])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c9f03c7d18sm6571974e0c.1.2026.09.24.06.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 06:29:14 -0700 (PDT)
From: =?UTF-8?q?Francisco=20Beltr=C3=A1n=20Millal=C3=A9n?= <fbeltranmillalen@gmail.com>
To: rafael@kernel.org,
	bhelgaas@google.com,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: lenb@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: PCI: take native PME control on Apple machines
Date: Thu, 24 Sep 2026 10:28:59 -0300
Message-ID: <20260924132859.24751-1-fbeltranmillalen@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since commit 7bc5a2bad0b8 ("ACPI: Support _OSI("Darwin") correctly")
negotiate_os_control() skips the _OSC handshake on Apple machines and
hardcodes the set of features the OS takes over, because those firmwares
return failure once _OSI("Darwin") has been acknowledged.  The hardcoded
set is ~OSC_PCI_EXPRESS_PME_CONTROL, i.e. everything except PME.  No
reason was given for leaving PME out.

The result is that host_bridge->native_pme stays 0, so portdrv never
registers the PME service for any root port.  A PCIe device that
runtime suspends still arms PME# (the PCI core enables it because
pci_dev_run_wake() only looks at capability), asserts it when it needs
attention, and is never resumed: no service handles the root port
interrupt, and the polling fallback in pci_pme_list_scan() skips the
device whenever the bridge above it is runtime suspended, which is
exactly when the device itself is suspended.

On a MacBookPro14,3 this silently breaks USB-C hotplug.  Both xHCI
controllers sit inside the Thunderbolt (Alpine Ridge) switches and
runtime suspend to D3hot when idle, together with their parent
bridges.  Plugging a SuperSpeed device in is then never noticed:

  0000:7d:00.0 suspended, PMCSR 0x8103 (D3hot, PME_En=1, PME_Status=1)
  ... no kernel message at all, for minutes ...

The device only appears once something else resumes the controller,
which makes it look intermittent.  The firmware on this machine does not
handle PME on behalf of the OS either: XHC2/XHC3 declare _PRW returning
GPE 0x6D, that GPE is enabled and has never fired, and its _L6D handler
notifies PWRB, XHC1 and HDEF only - never XHC2 or XHC3.

With PME control taken, the root port PME interrupt is serviced and the
controller is resumed as soon as something is plugged in.

Use calculate_control() for the assumed set rather than open coding it:
that is by definition the set that would have been requested, it drops a
magic constant, and on a kernel built without some of those features it
no longer claims control of services the OS cannot provide.

Note this also makes pme_is_native() true for pciehp (drivers/pci/
hotplug/pciehp_core.c), so hotplug ports now disable their interrupt
across suspend and clear spurious events on resume, as they do on every
non-Apple machine.  x86_apple_machine covers Macs back to 2006, so this
reaches models that were never tested with native PME.

Tested on a MacBookPro14,3, 6.18.49, with a USB 3.1 SATA enclosure:

  - before: plugged in at 09:20 with 0000:7d:00.0 runtime suspended, still
    invisible at 09:21 with PME_Status latched at 1; only appeared when
    0000:7d:00.0 was forced to power/control=on.
  - with pcie_ports=native (which reaches the same code path in
    get_port_device_capability()): pcie_pme bound to 5 root ports, and the
    same enclosure enumerated in the same second it was plugged in, 66 s
    after the controller had suspended, with nothing forced.
  - with this patch, nothing forced: pcie_pme bound to 5 root ports and the
    _OSC line now reads "OS assumes control of [PCIeHotplug SHPCHotplug PME
    AER PCIeCapability LTR DPC]".  The enclosure was unplugged at 20:42:13,
    0000:7d:00.0 runtime suspended to D3hot, and on plugging it back in at
    20:43:06 (53 s later) the root port took a PME interrupt and the device
    enumerated in the same second.
  - wifi, internal keyboard, touchbar and audio all came up; 66 warnings
    and 45 errors during boot, against 65/43 on the distribution kernel.

One rough edge, reproducible on both boots: the port driver logs
"PME: Spurious native interrupt!" right before the device is resumed.
pcie_pme_handle_request() falls back to pcie_pme_walk_bus() when the root
port reports its own requester ID without PCI_PM_CTRL_PME_STATUS set, and
that walk skips PCIe devices, so the xHCI is never attributed.  The device
is still resumed and the wakeup works, but attributing PMEs from PCIe
devices behind a switch looks like a separate shortcoming; it is not
addressed here.

Boot with pcie_ports=native also showed no new AER/DPC activity and
slightly fewer warnings than a boot without it, so taking the remaining
control bit does not appear to disturb anything else on this machine.

Fixes: 7bc5a2bad0b8 ("ACPI: Support _OSI("Darwin") correctly")
Signed-off-by: Francisco Beltrán Millalén <fbeltranmillalen@gmail.com>
---
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -568,9 +568,14 @@
 	 * Apple always return failure on _OSC calls when _OSI("Darwin") has
 	 * been called successfully. We know the feature set supported by the
 	 * platform, so avoid calling _OSC at all
+	 *
+	 * Assume control of the same features that would have been requested,
+	 * PCIe PME included.  Leaving PME out disables the PME service for
+	 * every root port, and nothing takes over: a device that runtime
+	 * suspends asserts PME# and is never resumed.
 	 */
 	if (x86_apple_machine) {
-		root->osc_control_set = ~OSC_PCI_EXPRESS_PME_CONTROL;
+		root->osc_control_set = calculate_control();
 		decode_osc_control(root, "OS assumes control of",
 				   root->osc_control_set);
 		return;
