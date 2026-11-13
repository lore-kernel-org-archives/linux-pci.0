Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794534526;
	b=XEmpWyBHYyagTjVDIJIuzXWpkDvugLF67e7I0ngdj2D3ReL8rZNiNytjxDymbOC3P5fD
	 seO/hRu/OLxdMHESs5jKLiUnf7CTeaVjMpcYS6azxqjOrUoD8uGrFgRIRaNdchH6AZugT
	 ePRB0nrSKjfE9sE1eu5e2RxH4BiTTTTrY0Tk7fUppnqLJUN6Bv71dUvQep9jT+ldl+bNF
	 7BqsVxTJ/oc1uhrfnUKT0YtRSqkBdEhjylZSoFTMJ1lODal1wn2cjjLugNzz5qsDHAVM1
	 8SSzd+/zda3Qtkmr7aq6r3Ze819fmrMgALG6r3IPf+SAQ1sqrGQEoYe31e5FQ3WbnIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794534526;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=rn8grC775Ey3TzRfGbKCrReUP+B5RldmfzTK5ezkSBI=;
	b=FD9fFMfpLDWASPsY0ymWFIw21Wryiz0Xl/6Pj53s2uCpgAXeGL8vtrBiwA4n/Fnpcgyr
	 d4LPZ1TOe5Q00ukezPIks4yPAE3671pNGL6t965NBg40j34SIckNITLuwbjfkBmY8JvWU
	 NeWaUaTC3qNYeJTQ9CSSwSdCRc5GSeF1zBXfBlXSfD3Var2I0Uq3NxnK0rclSJ4K80chp
	 FwQIim7dl2rOxfVUzcDZr+Z4uBzSIsERxQXk4sF3XqWSwtoSWDB2MRGz45YD27hYIp3zs
	 Y6affocOpdyGJ++9ITknaKXatpw4RkKcci3s8LugmOG2aNsEMRHSX0hUrS7bpfRSLZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Y25sPzhI;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2146D606A323;
	Fri, 13 Nov 2026 01:48:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2146D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Y25sPzhI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=rn
	8grC775Ey3TzRfGbKCrReUP+B5RldmfzTK5ezkSBI=; b=Y25sPzhI6IPexhitxx
	1rSVo3kR8HOxknKmLcDlGfSLZURayI6PBz4bwUr9HDTgSC9hMK1RKWJh2/pU3PKq
	Vx9n9aklVQrJMFQfSUlbiL8yxPx2+ds49pFcfcRezCby0iy/dHbAHMwpgk+b1ht/
	3SPRF/e5FGpj+Xz1CXnsB2ZN8=
Received: from oc-ThinkStation-P7.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD331xobPZqa7yxGw--.61801S2;
	Fri, 13 Nov 2026 09:48:26 +0800 (CST)
From: Kean Ren <rh_king@163.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Disable spurious s2idle wake from the NVMe root port on ThinkPad P1 Gen 9
Date: Fri, 13 Nov 2026 09:48:23 +0800
Message-ID: <20261113014824.2396883-1-rh_king@163.com>
X-Mailer: git-send-email 2.43.0
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
X-CM-TRANSID:_____wD331xobPZqa7yxGw--.61801S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWrykZryDuFWxJw43ur48Zwb_yoWrJry5pF
	W5Jr98tr48Wry2qFs3Ar1jgFn5Ar93t34rKrs7C3s0y3ZxArn09FWxKryaqFy7CFsagw4a
	ga1kAr1UuFW8GaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U9NVkUUUUU=
X-CM-SenderInfo: 5ukbyxlqj6il2tof0z/xtbC3wqNPGr2bGoTeQAA3U

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
writing.  Match the model only; if a fixed BIOS is released later, this
quirk can be removed or restricted to the affected BIOS versions.

Verified on 21UFZE0PCN:
 - gpe6F increments by one per suspend/resume on both BIOS versions;
 - masking gpe6F, or disabling RP05 wake via /proc/acpi/wakeup, makes
   s2idle stay asleep;
 - with this quirk, /proc/acpi/wakeup reports RP05 as disabled and
   gpe6F no longer increments across repeated suspends.

Signed-off-by: Kean Ren <rh_king@163.com>
---
 drivers/pci/quirks.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7f1f47ea2ee4..daccfbbec821 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6595,3 +6595,55 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
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
+ * of writing.  Match the model only; if a fixed BIOS is released later,
+ * this quirk can be removed or restricted to the affected BIOS
+ * versions.
+ */
+static const struct dmi_system_id p1g9_rp05_wakeup_dmi[] __initconst = {
+	{
+		.ident = "Lenovo ThinkPad P1 Gen 9 (21UF)",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21UFZE0PCN"),
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

