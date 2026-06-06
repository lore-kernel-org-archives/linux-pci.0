Received: from mail.sntiq.com (mail.sntiq.com [45.149.154.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE302B9BA;
	Sat,  6 Jun 2026 20:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.149.154.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780778905; cv=none; b=FvcU2qzsPScYQ0ff8KcEwDbrQriPMh71mBkgl2HhRfyuSttynKmtlPTzxIKAk6UTDRFIfJdOZ/qwM9I6Y+YhYIig1VkywGcAUgDddCKPd9MMa8p9MtAUEnOt+WE8R6l62r2rUg9MkOFvP52uLcHCLFkwy9XKyheXwccVLbD4E4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780778905; c=relaxed/simple;
	bh=NJS+1gnRo13cWn5Qb4zVJR5/2rcakmHdTCU/G41UEog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DQ6bkxN1F1MHS7GB8U4Y1timxYhrC2HEclArxzIXuadgf1FrQzd/JE8eE9V4hD2vMueyl6a5GkGEaZZvFMPcXRa3w+11CH9ahHBtExC83ulJScVyzAoZlKpUtW6/WECZWS+1wKVRykocgij1U4y2cRorasA3+tMq+1YmZUkL2BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntiq.com; spf=pass smtp.mailfrom=sntiq.com; dkim=pass (2048-bit key) header.d=sntiq.com header.i=@sntiq.com header.b=zAzHWrhT; arc=none smtp.client-ip=45.149.154.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntiq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntiq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntiq.com header.i=@sntiq.com header.b="zAzHWrhT"
Received: from node (unknown [145.224.74.243])
	by mail.sntiq.com (Postfix) with ESMTPSA id 180AF800EE;
	Sat,  6 Jun 2026 20:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sntiq.com; s=dkim;
	t=1780778894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SQb9JeKL+scqTl2jLRA5Uwz3PfPgEyDqCt2OIiZ5moM=;
	b=zAzHWrhTkihr34aX3VI+Pa8YGY+YHaJmGNqwamwIb7QzgYthyiMfiHPOWTi/q/XSRgLaLU
	ykpirp9Bb7/DZzGgg/SvqeRx6WVkFFt3pHiXde1rZ5UI0aePVR8JZSKyIee9KC20xHRGkP
	2Zd1noL02c8uk8wEmWU+l2B9IIVI5AU48AdwxF7HWUEssC2LhHWmuVKkWw3+pLtX0t7EJ7
	qLGOskv6aqkw4qlFmueZdYOxF/F6tEt+W5IuBMBKOjXapxf3pz5gEdlLHoT+398idWy4sy
	8SdbDaKld9/QtAgJwh+OON4hLliggkQl8XGISFrKQ/D6uPj+rePJQtO/9z/Hhg==
From: David Glushkov <david.glushkov@sntiq.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Disable async suspend for MSI Raider A18 HX A9WJG audio
Date: Sat,  6 Jun 2026 22:45:47 +0200
Message-ID: <20260606204547.11945-1-david.glushkov@sntiq.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the MSI Raider A18 HX A9WJG, the AMD ACP function and AMD
Azalia/HDA function are exposed as separate PCI functions, but the ACPI
CPMACPV4 table tracks their presence with shared state and uses common
power-gating methods for both.

With asynchronous system suspend/resume, these two functions can resume in
parallel. On this machine that can leave the HDA controller unresponsive,
with CORBRP reads returning 0xffff and the kernel logging:

  snd_hda_intel 0000:6a:00.6: CORB reset timeout#2, CORBRP = 65535

When this happens, HDA speaker playback fails after resume and the ACP
DMIC path can also fail with PDM DMA trigger timeouts. Disabling runtime
PM and D3cold for both functions does not avoid the failure, but disabling
asynchronous PM globally via /sys/power/pm_async does.

Disable async suspend only for the affected MSI subsystem and only for
the two AMD audio functions, so the rest of the system can continue to
use async suspend/resume.

This is independent of the ASoC DMI quirk which exposes the ACP DMIC on
this system; that quirk makes the microphone visible, while this PCI quirk
fixes the resume ordering problem between the ACP and HDA PCI functions.

Tested on MSI Raider A18 HX A9WJG (MS-182L), BIOS E182LAMS.31A, with
pm_async=1 over s2idle. After resume, HDA speaker playback worked and the
PipeWire ACP DMIC source recorded successfully, with no CORB reset timeout,
ACP timeout, or ASoC error in the checked post-resume log.

Link: https://lore.kernel.org/r/20260531214512.170716-1-david.glushkov@sntiq.com
Signed-off-by: David Glushkov <david.glushkov@sntiq.com>
---
 drivers/pci/quirks.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 5d7df95d2010..8702ccfc2265 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1904,6 +1904,25 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_CLASS_STORA
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_JMICRON, 0x2362, quirk_jmicron_async_suspend);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_JMICRON, 0x236f, quirk_jmicron_async_suspend);
 
+/*
+ * MSI Raider A18 HX A9WJG (MS-182L) exposes ACP and Azalia as separate PCI
+ * functions, but ACPI uses shared power gating for both.  If they suspend or
+ * resume in parallel, the HDA controller may become unresponsive.
+ */
+static void quirk_msi_a18_audio_async_suspend(struct pci_dev *dev)
+{
+	if (dev->subsystem_vendor != 0x1462 ||
+	    dev->subsystem_device != 0x14a5)
+		return;
+
+	device_disable_async_suspend(&dev->dev);
+	pci_info(dev, "async suspend disabled to avoid audio power-on ordering issue\n");
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e2,
+			quirk_msi_a18_audio_async_suspend);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e3,
+			quirk_msi_a18_audio_async_suspend);
+
 #ifdef CONFIG_X86_IO_APIC
 static void quirk_alder_ioapic(struct pci_dev *pdev)
 {
-- 
2.54.0

