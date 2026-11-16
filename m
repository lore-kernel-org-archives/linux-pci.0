Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794812191;
	b=YBz0Cmojzw950iY1cLT+17Y/8cfP1bh9s4q28uCugRlmX+CFLntN6vdFtHiOXtz6mKKV
	 6KpOtVJ/Y5yXyXFVnV2GvYdZOrvP6hpwqQj1ZcNQYZ3DwN0Pegy6prjJcdOOQyOGHr7Gb
	 XlJrsz71d4gUt3PGxj2ZhZAqC8hrxK3Ge4Qz7IsWOpbHDr2vtlfsel5UMytdNlfgDkSre
	 NLzc/2AFia1jypsfv+qMFJkM7RlSTJTy7TKHX2jSSceAH21OPBxIorYugpXYeKd1mJeM9
	 Ci49w5QzNF0fkMZPJNdW2Xd8yA8As3KcPfm7U5+KIcU/h3wKgeO7mO8YFaTQmq3HJvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794812191;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=e+t1IlMmZp+mAKjHcUt2DYE7a4RZaPV2rW6OG/x3xWw=;
	b=XT9MCcRikphYS5MOU01f5L8HuLiXW6Vxta33g5k2pvCR4cD0ikdl30FZXS4XQ2vpeMzX
	 cKM2fTZEUECpUXcezkmzMy8jXUeJzOcT1UCxacjeSIAIZTyez2y0LVF9+meeZaQGy4lH7
	 EU6X18y+Cg+hi17U6pIhjS+MqEjHt62W0+DTVQylfV7xBPdAmNXnLfHBd5/e4TQMbbWXa
	 KpyV4deszPC9VFLtDTWWU997jxtx6ZnzN371lGB9uEs1Gb9fntVpNjax8765w/50uIb/M
	 dpbW1hYyCSH0lBRxv/eTFl/wn9xVIgWkglpHTbJoB1N/jVAmpupq56+X4tmONgPDasQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="TPhUF2/z";
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E92A606A31C;
	Mon, 16 Nov 2026 06:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E92A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=TPhUF2/z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=e+
	t1IlMmZp+mAKjHcUt2DYE7a4RZaPV2rW6OG/x3xWw=; b=TPhUF2/zfq3e4hd/5r
	o74a8RxWu1Y/ylWWm5dtXJrZCLFv+Rw5L2VnA0IKupEHSvTG2SWY5KePZVA+YLPi
	QvVtk6JpxRDSEjUx59CfaUlauwNm6UQV9N71CGiS7OugWgrajZLc7tTTkzpRK+QF
	ClxCgYvbucqHaYY1vVGhcJp70=
Received: from oc-ThinkStation-P7.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDXX+YNqfpqhqsOHg--.19141S2;
	Mon, 16 Nov 2026 14:56:17 +0800 (CST)
From: Kean Ren <rh_king@163.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] PCI: Disable spurious s2idle wake from the NVMe root port on ThinkPad P1 Gen 9
Date: Mon, 16 Nov 2026 14:56:12 +0800
Message-ID: <20261116065612.230481-1-rh_king@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116014214.102524-1-rh_king@163.com>
References: <20261116014214.102524-1-rh_king@163.com>
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
X-CM-TRANSID:_____wDXX+YNqfpqhqsOHg--.19141S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWrykZryDuF4DKF13ZF45GFg_yoWrur13pr
	WrJF95Kr4kWrW2vFs3Ar4UWFn5ArsYk34rKrZ7C3s0k3ZxArn0kFWxtryYqFy7JFZ3Ww4a
	qa1rtr1kuF4DJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UP8nOUUUUU=
X-CM-SenderInfo: 5ukbyxlqj6il2tof0z/xtbC3xHHdmr6qRFDcwAA3n

On Lenovo ThinkPad P1 Gen 9 (21UF, Panther Lake), firmware enables the
ACPI wake capability (_PRW) of PCIe root port 00:1c.4, which is the root
port of the primary NVMe SSD.  When the NVMe controller is put into D3
during system suspend, a spurious PME is raised on that root port, which
sets ACPI GPE 0x6F (SCI).  The SCI fires during the noirq suspend phase
and aborts s2idle before it reaches the low-power state: every suspend
is followed by a wake within ~2.5 seconds with practically zero s2idle
residency.

The downstream NVMe device is not a wake source (its own ACPI wake is
disabled), so the spurious event comes from the root port's wake/PME
path.  Disable the root port's wake capability as well.

No firmware with a fix is available: the issue reproduces with BIOS
N4SET31W (1.10) and N4SET32W (1.11), the latest version at the time of
writing.  Match the 21UF model prefix; all 21UF SKUs share the same
platform and firmware, and the remaining MTM characters encode the
factory configuration and region.  If a fixed BIOS is released later,
this quirk can be removed or restricted to the affected BIOS versions.

Verified on 21UFZE0PCN:
 - gpe6F increments by one per suspend/resume on both BIOS versions;
 - masking gpe6F, or disabling RP05 wake via /proc/acpi/wakeup, makes
   s2idle stay asleep;
 - with this quirk, /proc/acpi/wakeup reports RP05 as disabled and
   gpe6F no longer increments across repeated suspends.

Signed-off-by: Kean Ren <rh_king@163.com>
---
Changes in v3:
- Check device_may_wakeup() instead of device_can_wakeup(): the latter is
  set for all PME-capable devices, whether or not wakeup is enabled, so the
  quirk could log a disable that did not actually happen.  Drop the
  corresponding warning; there is nothing to do if wakeup is not enabled.

Changes in v2:
- Match the 21UF model prefix instead of the full 21UFZE0PCN MTM so the
  quirk also covers the other ThinkPad P1 Gen 9 factory configurations
  that share the same platform and firmware.

 drivers/pci/quirks.c | 56 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7f1f47ea2ee4..6ede2ea49b3a 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6595,3 +6595,59 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
 #endif
+
+/*
+ * Lenovo ThinkPad P1 Gen 9 (21UF): the firmware enables the ACPI wake
+ * capability of PCIe root port 00:1c.4, which is the root port of the
+ * primary NVMe SSD.  When the NVMe controller is put into D3 during
+ * system suspend, a spurious PME is raised on that root port, which in
+ * turn fires ACPI GPE 0x6F (SCI) and aborts s2idle before the system
+ * reaches the low-power state.  The NVMe device itself is not a wake
+ * source (its own ACPI wake is disabled), so disable the root port's
+ * wake capability as well.
+ *
+ * No firmware with a fix is available: the issue reproduces with BIOS
+ * N4SET31W (1.10) and N4SET32W (1.11), the latest version at the time
+ * of writing.  Match the 21UF model prefix (the remaining MTM
+ * characters encode the factory configuration and region); if a fixed
+ * BIOS is released later, this quirk can be removed or restricted to
+ * the affected BIOS versions.
+ */
+static const struct dmi_system_id p1g9_rp05_wakeup_dmi[] __initconst = {
+	{
+		.ident = "Lenovo ThinkPad P1 Gen 9 (21UF)",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			/* 21UF = ThinkPad P1 Gen 9 model; suffix is the SKU. */
+			DMI_MATCH(DMI_PRODUCT_NAME, "21UF"),
+		},
+	},
+	{ }
+};
+
+static int __init pci_fixup_p1g9_rp05_wakeup(void)
+{
+	struct pci_dev *rp;
+
+	if (!dmi_check_system(p1g9_rp05_wakeup_dmi))
+		return 0;
+
+	/* Root port of the primary NVMe SSD (05:00.0). */
+	rp = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0x1c, 4));
+	if (!rp)
+		return 0;
+
+	/*
+	 * Disable wakeup only if it is enabled: device_can_wakeup() is set
+	 * for all PME-capable devices, even when wakeup is disabled.
+	 */
+	if (device_may_wakeup(&rp->dev)) {
+		device_set_wakeup_enable(&rp->dev, false);
+		pci_info(rp, "disabled spurious s2idle wake (BIOS %s)\n",
+			 dmi_get_system_info(DMI_BIOS_VERSION));
+	}
+	pci_dev_put(rp);
+
+	return 0;
+}
+late_initcall(pci_fixup_p1g9_rp05_wakeup);
-- 
2.43.0

