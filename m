Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=141.14.17.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794615406;
	b=2KNynAppmOsb4LHO0C12dSUEQ6zFQnd84i6eyHFPplSuS9mfs9LMNzTFTdXYWS28uMif
	 jb+xWgHojFan/FrWpIwNSk3tQNI+iWoQ1HKBcj77AddoOe/xxExhjZALrdyvuHmzZWsbO
	 0foGMBRwNwD5sEuywnQDlQMXffM7R7IsZst/FhzxUAKaN03xNr5gbLDtqOM21KK4Y8rva
	 MPDIfMQjTHH8DpSL7e2jDCQzvY5wi+jCYq0ejSstuK8FNZhQwaLwaj5qW+6hZ2/VpQrDZ
	 wUQZ8ZdaWP/ANDKBq7jZJCXshgLGaHaGgtwxpyISffw5ls5KzfJm60kGiYZjCh+Sc1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794615406;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:DKIM-Signature;
	bh=FTMw85ZyH6d6sONkFirjgiNZJIu5MVHgxe+h1oTZuUE=;
	b=QC6y0QmKBIgRGr5w8J4mOa8/e+djRq7+DiPr7VhbqnMZ2JzrQXkNbqPKmHTADYNjgOio
	 8Hx7SZ49eFJjM7LmRJgOnynNXggqt2eDAiGEicnEC3gGqAi7fX4xDN1ObgGK7xXBF9hZh
	 0aEZ54lcizl8b9wT7fNt5VC1XW1316ThLGvdfdUWVm9gV7+SODkTAfKHMVpmJ7zFIMvKX
	 s8ps7pIJjllChLTKEKPE0fc3HPYqBldq0ETM1iOFR9F1DK8trOr+jIgbVf5WFnptjQF1h
	 f/A6JcUveTyLSdbGViCV1GQYqwZTxtoEqUjqBDjOkPuQjjNtRmrOcFscSArr4q2I4pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=molgen.mpg.de;
	spf=pass smtp.mailfrom=molgen.mpg.de;
	dkim=pass header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=cF+0hF1F;
	arc=none smtp.remote-ip=141.14.17.11
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A967606A886;
	Sat, 14 Nov 2026 00:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A967606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=cF+0hF1F
Received: from abreu.speedport.ip (p5b13abd5.dip0.t-ipconnect.de [91.19.171.213])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1BE2F4C2F3FFF2;
	Sat, 14 Nov 2026 01:16:10 +0100 (CET)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <westeri@kernel.org>,
	linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [RFC PATCH] PM: sleep: Allow direct-complete for wakeup devices in suspend-to-idle
Date: Sat, 14 Nov 2026 01:15:50 +0100
Message-ID: <20261114001551.219620-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de; s=20260906; 
	t=1794615371; 
	h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding; 
	bh=FTMw85ZyH6d6sONkFirjgiNZJIu5MVHgxe+h1oTZuUE=; 
	b=cF+0hF1FC4n3Kk54VGEVf+60kDNRej96d+n/x397szJggD4dsjcOk0/MUbp/SJtSp0+K62skY6xE
	iXsJX9kdwDDf0qiSDTycRec0aFVGplzKpvZ1wRGQHRpO1PTkgNyS/Nm3qAAOdAwWLYtyX7vS5CwPGK
	A+3C1jxyPN4ffJGr4AmBFcCTBWT1ycdOz49hVi0O1s4zD6qGU/hR3Nbdegpe3+dB/sQFPNQBTMGtvR
	6PkgEThg/FJJeaw7NXZbue4BllEmboGVYwwgh3Rq0ufsjNssRjBvP1jjx6WrJMdc/ryfkRLOgp5Aw1
	yCDaEbyZfHXAFghVjyyKT8XeZ+mqYiGw==

Since commit dc351d4c5f4f ("PM / core: Propagate dev->power.wakeup_path
when no callbacks"), device_suspend() clears direct_complete for every
device with wakeup enabled or in the wakeup path of a child.  That commit
addressed a device without PM callbacks, where no ->prepare() callback has
looked at the device, but the check applies to all devices.

For PCI devices, ->prepare() already takes wakeup into account:
pci_pm_prepare() only returns 1 if pci_dev_need_resume() is false, which
compares device_may_wakeup() with the ACPI wakeup configuration the device
got for runtime PM (acpi_pci_need_resume()) and computes the target state
with pci_target_state(dev, device_may_wakeup(dev)), and it then adjusts
PME with pci_dev_adjust_pme().  For a device with wakeup enabled, this
decision is discarded right afterwards.  As PCI bridges that can do D3
(pci_acpi_setup()), PCI USB host controllers (usb_hcd_pci_probe()) and
Thunderbolt NHIs (nhi_probe()) enable wakeup by default, direct-complete is
effectively limited to devices with wakeup disabled on x86 laptops.  On a
Dell XPS 13 9310 (Tiger Lake) these runtime-suspended functions are
affected:

    0000:00:07.0 pcieport     D3cold  wakeup=enabled
    0000:00:07.2 pcieport     D3cold  wakeup=enabled
    0000:00:0d.0 xhci_hcd     D3cold  wakeup=enabled
    0000:00:0d.2 thunderbolt  D3cold  wakeup=enabled
    0000:00:0d.3 thunderbolt  D3cold  wakeup=enabled
    0000:00:14.0 xhci_hcd     D3hot   wakeup=enabled

There, every suspend-to-idle resume spends 231 ms of the noirq phase
powering up the empty Thunderbolt root ports 00:07.0 and 00:07.2 and the
NHIs 00:0d.2 and 00:0d.3 from D3cold (ACPI _ON of the TBT0/TBT1 power
resources ~125 ms, root port _PS0 ~108 ms), only to runtime-suspend them
again after the resume.  That is more than a third of the kernel resume
(641 ms with the panel lit, 427 ms with it off, from the end of
machine_suspend to "PM: suspend exit"):

    230.77 ms  noirq bus  pcieport     0000:00:07.2
    227.40 ms  noirq bus  pcieport     0000:00:07.0
    142.53 ms  noirq bus  thunderbolt  0000:00:0d.3
    137.27 ms  noirq bus  thunderbolt  0000:00:0d.2

In suspend-to-idle no firmware is involved in the transition, and a device
left in runtime suspend keeps the wakeup configuration it got for runtime
PM.  So allow direct-complete for wakeup devices there, and propagate
wakeup_path from a direct-completed device to its parent, as
device_suspend() does for devices that go through the callbacks.

Together with three more changes the Thunderbolt functions stay in D3cold,
and the noirq phase takes 33 ms instead of 232 ms with the panel off, and
34 ms instead of 231 ms with the panel lit (medians of 3-4 cycles).

Fixes: dc351d4c5f4f ("PM / core: Propagate dev->power.wakeup_path when no callbacks")
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---

Notes:

Other three changes:

- PCI/portdrv: no DPM_FLAG_NO_DIRECT_COMPLETE for ports on a root bus, as
  the reason for it in commit 52be9464aa7e ("PCI/portdrv: Resume upon exit
  from system suspend if left runtime suspended"), a parent going through
  D3cold, does not apply to them,
- thunderbolt: nhi_complete() does not runtime-resume a direct-completed
  NHI,
- ACPI: power: __acpi_power_on() resumes only dependents whose _PR0
  resources are all on.  Otherwise resuming the xHCI 00:0d.0 during system
  suspend (xhci-pci does not set DPM_FLAG_SMART_SUSPEND) turns on the
  shared D3C resource and runtime-resumes the root ports and NHIs, which
  also need TBT0/TBT1.

This is an RFC, because the runtime wakeup configuration of a device can
differ from the one its driver sets up for system sleep.  For example,
tb_switch_suspend() also arms wake on DisplayPort for runtime suspend, and
if user space disables wakeup for a Thunderbolt router, a direct-completed
NHI still wakes up the system when a device is connected.  Maybe
subsystems should opt in with a flag instead.

An alternative is to keep the check for devices relying on
no_pm_callbacks, where nothing has looked at the wakeup settings, to drop
it for devices whose ->prepare() returned a positive value, and to
propagate wakeup_path from direct-completed devices in both cases.  That
works for all sleep states, but does not help in the example above: the
Thunderbolt domain and host router devices (domain0, 0-0) below the NHI
have no PM callbacks, but wakeup enabled, so they still go through
device_suspend() and clear direct_complete of the NHI with
dpm_clear_superiors_direct_complete().

Tested on the Dell XPS 13 9310 with Linux 7.4-rc1 and the three changes
above (plus a fix that keeps the absent root ports TRP1/TRP3 from being
powered up at boot, without which TBT0/TBT1 never turn off): 17
suspend-to-idle cycles of 6-8 s with rtcwake and sleepgraph, no failures,
111 s in hardware sleep in total (/sys/power/suspend_stats/total_hw_sleep).
Hot-plugging during suspend was not tested.

Tool use (Documentation/process/generated-content.rst): the analysis, the
code change and this changelog were drafted by an LLM coding assistant
(Claude Opus 5.5 via Claude Code), in a session asked to "instrument S0ix
resume [on the Dell XPS 13 9310], and halve the time".  It traced the
resume with sleepgraph, function_graph and kprobes/rpm tracepoints, built
the test kernels and ran the measurements on the laptop.

 drivers/base/power/main.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 88a31e09e4f3f..f36c38d1585b0 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1999,8 +1999,14 @@ static void device_suspend(struct device *dev, pm_message_t state, bool async)
 	if (dev->power.syscore)
 		goto Complete;
 
-	/* Avoid direct_complete to let wakeup_path propagate. */
-	if (device_may_wakeup(dev) || device_wakeup_path(dev))
+	/*
+	 * Avoid direct_complete to let wakeup_path propagate.  In
+	 * suspend-to-idle, though, no firmware is involved and a device left in
+	 * runtime suspend keeps the wakeup configuration it got for runtime PM,
+	 * so allow direct_complete there and propagate wakeup_path below.
+	 */
+	if ((device_may_wakeup(dev) || device_wakeup_path(dev)) &&
+	    pm_suspend_target_state != PM_SUSPEND_TO_IDLE)
 		dev->power.direct_complete = false;
 
 	if (dev->power.direct_complete) {
@@ -2009,6 +2015,10 @@ static void device_suspend(struct device *dev, pm_message_t state, bool async)
 			if (pm_runtime_status_suspended(dev)) {
 				pm_dev_dbg(dev, state, "direct-complete ");
 				dev->power.is_suspended = true;
+				if (device_may_wakeup(dev))
+					dev->power.wakeup_path = true;
+
+				dpm_propagate_wakeup_to_parent(dev);
 				goto Complete;
 			}
 

base-commit: 5fcaa701fd2d61b003dff89bbb9dd29ed6123740
-- 
2.54.0

