Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793351;
	b=BwVZkJYCceBHdnNl/Oc2NQfab7Oh+yghGXayl7ib7XnkWyuSS9YE0d2lIKmnVDtbNj8e
	 Fo5zxlRqZlyN0I/xowvwNzHe1SlzFhIUnXQ/upqoweBCqvlH3PMP+epRZf12EgKFgzkif
	 RpTDmJ0jck1X4ywhATUkqnIZeHTgWyepc2BgtORz6DdrbBuHfhSgXt/HPI+NjcSuJ6WrU
	 xBXgDf4P6JvOZQorudTiSvKG8SQZHb8ZkVrXDdV2nrcI64xLSX+VqJgNT16jWREiLLOqq
	 9I/YqmwNaSQLh2dXa6DIgT8Yttlu6NXF5hLCQEbRzPfLDjmTI95iJ/M8mCX48KJIgUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793351;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=c9uHdlqrKsh0zgGsa5+22iZSmPYjqw3jpLcyzLQGrFI=;
	b=SyVY0cd00ummQInPe6Dm8O2y8H+2lRrK5QWFSrhkYTbtS7gy64t1gouk2i7OS6rSlYDV
	 go2bs2YeSbL++maN/LPwLhUL7JTjwxuidxj35hb426IOBaDmrQ+R7knQ8lD5VYz3Azd9u
	 D4U8BWf8eOj5SPG9/UHIdL1Q2PN/5infqbhrJEMoWsBqaT6B9p2JmF4KgZaSb+acMJkuY
	 t11yLrAsO3ZDc2V4Mna8vhQ4Kn/u80hNQN6MOTE+ovk2FLndj3BLrZLS6lCm2aks34AMW
	 Iz3X/Tlz6oEd2aH5TcHYrRwGGtkXjHTWea2G2daSXGi34FuzIekGVs+Gqr8Yp1H61Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=V+hEkqUL;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6526606A31C;
	Mon, 16 Nov 2026 01:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6526606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=V+hEkqUL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=c9
	uHdlqrKsh0zgGsa5+22iZSmPYjqw3jpLcyzLQGrFI=; b=V+hEkqULaBCtg+T+dN
	SI6YQ2NKE/7HYXATpDZEk3yfMQoc+3rcqJQwy2wHuI+41GaiYHMumoMPC2SvM4HU
	5UknbXTOz/f+v3FtJLsnUUL1jibrZ2MEzuzZeVuCbPoAO9WWt+nQ+nGgv61rD+Fd
	WgTpDmYnKAE+YN5AEaz2rXztk=
Received: from oc-ThinkStation-P7.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3P753X_pqj33vIQ--.46208S2;
	Mon, 16 Nov 2026 09:42:18 +0800 (CST)
From: Kean Ren <rh_king@163.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: Disable spurious s2idle wake from the NVMe root port on ThinkPad P1 Gen 9
Date: Mon, 16 Nov 2026 09:42:14 +0800
Message-ID: <20261116014214.102524-1-rh_king@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113014824.2396883-1-rh_king@163.com>
References: <20261113014824.2396883-1-rh_king@163.com>
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
X-CM-TRANSID:_____wD3P753X_pqj33vIQ--.46208S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWrykZryDuF1xuFyfXF1kKrg_yoWrAr47pr
	W5Jr95tr4kWrW2qF4fAr4UWFn5Ars5K34rKrs7C3s0y3Z8Ar15KFWxKryaqFy7JFZ3Ww4a
	qa18tF1DuFWkGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UP8nOUUUUU=
X-CM-SenderInfo: 5ukbyxlqj6il2tof0z/xtbC4BtP-Wr6X3tCfQAA3C

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
Changes in v2:
- Match the 21UF model prefix instead of the full 21UFZE0PCN MTM so the
  quirk also covers the other ThinkPad P1 Gen 9 factory configurations
  that share the same platform and firmware.

 drivers/pci/quirks.c | 54 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7f1f47ea2ee4..5bf55413a68f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6595,3 +6595,57 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
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
+	if (device_can_wakeup(&rp->dev)) {
+		device_set_wakeup_enable(&rp->dev, false);
+		pci_info(rp, "disabled spurious s2idle wake (BIOS %s)\n",
+			 dmi_get_system_info(DMI_BIOS_VERSION));
+	} else {
+		pci_warn(rp, "wakeup not enabled, cannot disable spurious s2idle wake\n");
+	}
+	pci_dev_put(rp);
+
+	return 0;
+}
+late_initcall(pci_fixup_p1g9_rp05_wakeup);
-- 
2.43.0

