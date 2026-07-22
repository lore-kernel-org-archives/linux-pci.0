Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04DF194AE6
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 02:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784686512; cv=none; b=tM/AOrpWVDeUR5UIHtKyc3nYvIQxkgB2iYxfDXgMu8Vm3KOPHft1FsEQzJCo9tiCK2rMoijWIPYWVxNBwM8SecL8C3H6hYlPwYupJ2Sn7OwvMIWbA5lksZyMYOKc26M2BoXP5PPJJ+yl840UiLtpACse1dj1C/WJ2zJb9bWanJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784686512; c=relaxed/simple;
	bh=N1Ad64KJtNChNCSgLmNfVWILIcCbhndoU7vrTP/VeFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EBN8cPu/E4pgZTif05xt02j6ZhaHVf5xMxz8P8DYiXJIQSZY52zFtdi/J6y5A9Ig1ca8eGPDomVkZ2dy4tS3/m1ieIwNojgOi0CxXp8hHwD1eeyuYjmFhpr/+XYGWtrDGV65iVdJxPrQrSMYXvtKAyoUounJlVd4mzFHxs+jyM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nikableh.moe; spf=pass smtp.mailfrom=nikableh.moe; dkim=pass (2048-bit key) header.d=nikableh.moe header.i=@nikableh.moe header.b=jE1HbxAO; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=CzltHOXg; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nikableh.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nikableh.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nikableh.moe header.i=@nikableh.moe header.b="jE1HbxAO";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="CzltHOXg"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=jE1HbxAOa19TtU2Q5X5cEuXglSp0KkMm3hQa9oCWOr87UeP34T7C1LEQSV1c2Iu7+vmwrJaALN+yihYrRMm3AtcaVFGm/MONNaKTFtpjdq4IaprgKs0Fv+0YDxiFfJb8zsqFpNMz3mAC6+N2NZBAWObae4urNto+1KSfla3lXhlMVNG97xGRa0OcK2AdkF9txr/cQGsQ+44+Oi6lU9LFNErVXRNoMXu4AG2c6z84PD6Wx9fO7NnX/0EmeijEV1PJn72VhMvx9pMylcXNwl22BvBrxs3qiCpwnDU67XffhXpLU9EhOyx2riLwQr8hNEGEDQe1gq+0pvlo75D29+ZGug==; s=purelymail2; d=nikableh.moe; v=1; bh=N1Ad64KJtNChNCSgLmNfVWILIcCbhndoU7vrTP/VeFI=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=CzltHOXg04qFuPVB5PlhYINuSb1YnobVZUGQBHz9Jcrdv9FNx1FME6VFEfiaEZUi6lvyu2WOHlRlFnM0OUg0KX7AzCZQgqtO+yqJ/BEaKPoARmPiSjh8Ib4m3e1sw4QVr0keso1vOwhsZKoyqHiwLpznZvvmJ6H7AqdSCbjUK2g6ZtRbTlszTp2Bz0kVz2aiCL28abKFiIdeAKrH25oxQw3vX3afHPg1qnxRXdKxcP028GyX0M9bLNvsPgHvFDWGulyNuftAZnLgul33Bn9ptxMDUpGHWcKJpP41j1oIjzdiX/3yr/tZvUfy6CIh3WHQ9293Qcdj6aKbKDgp+Sixrw==; s=purelymail2; d=purelymail.com; v=1; bh=N1Ad64KJtNChNCSgLmNfVWILIcCbhndoU7vrTP/VeFI=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 209604:18551:null:purelymail
X-Pm-Original-To: linux-pci@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 840739231;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 22 Jul 2026 02:14:45 +0000 (UTC)
From: Nika Krasnova <nika@nikableh.moe>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nika Krasnova <nika@nikableh.moe>
Subject: [PATCH] x86/PCI: Disable D3cold on Intel BE200 Wi-Fi on Lenovo IdeaPad Pro 5 14IAH10
Date: Wed, 22 Jul 2026 04:13:15 +0200
Message-ID: <20260722021321.68902-1-nika@nikableh.moe>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

On the Lenovo IdeaPad Pro 5 14IAH10, the Intel BE200 Wi-Fi (8086:272b,
iwlwifi) fails to power back on from D3cold after a suspend-to-idle
(s2idle) cycle.  On resume the platform reports a successful ACPI D0
transition, but the device is left unpowered: config space reads back
as 0xffffffff, the firmware reset times out, and the wiphy fails to
resume:

  iwlwifi 0000:01:00.0: power state changed by ACPI to D0
  iwlwifi 0000:01:00.0: restore config 0x2c: 0xffffffff -> 0x00f48086
  ieee80211 phy0: PM: failed to resume async: error -110

The device stays unusable until a full power cycle; an iwlwifi module
reload and a PCI remove/rescan do not recover it, confirming the device
is genuinely unpowered rather than in a bad software state.

Setting the device's d3cold_allowed to 0 keeps it in D3hot across
suspend and resumes reliably, so the platform does not correctly restore
power to the M.2 Wi-Fi slot on the s2idle resume path.  This mirrors the
untested-vendor-transition pattern already handled for the Asus B1400
NVMe (see asus_disable_nvme_d3cold): the reference OS does not appear to
exercise the D3cold->D0 path, so it is left untested.

Add a DMI-matched fixup that forbids D3cold for the BE200 on this model.
Match on the product rather than the BIOS version so the workaround
survives BIOS updates that do not address the issue.

Signed-off-by: Nika Krasnova <nika@nikableh.moe>
Assisted-by: Claude:claude-opus-4-8
---

Not sure arch/x86/pci/fixup.c is the right home versus a PCI quirk in
drivers/pci/quirks.c; would be happy to move it.

The latest BIOS from Lenovo for this model (QLCN35WW, 2025-12-23) is
installed and the failure is still present, so there is currently no
firmware-level fix.

Tested on the affected machine: with this patch applied and my local
d3cold_allowed=3D0 udev workaround removed, the BE200 resumes from s2idle
across repeated suspend/resume cycles with no iwlwifi errors.

 arch/x86/pci/fixup.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index b301c6c8df75..3117f313930e 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -995,6 +995,39 @@ static void asus_disable_nvme_d3cold(struct pci_dev *p=
dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x9a09, asus_disable_nvme_d3c=
old);
=20
+/*
+ * Disable D3cold on the Intel BE200 Wi-Fi on Lenovo IdeaPad Pro 5 14IAH10
+ *
+ * On this platform the BE200 (8086:272b) fails to power back on from D3co=
ld
+ * after an s2idle cycle: all config and CSR reads return 0xffffffff, the
+ * driver's firmware reset times out ("timeout waiting for FW reset ACK
+ * (inta_hw=3D0xffffffff)") and re-probe fails with -EIO.  A module reload=
 and a
+ * PCI remove/rescan cannot revive the device; only a full platform power =
cycle
+ * does.  This looks like an untested transition by the vendor: the refere=
nce
+ * OS does not appear to exercise the D3cold->D0 path.
+ *
+ * Forbidding D3cold keeps the card in D3hot across suspend, which resumes
+ * reliably at the cost of a small amount of power while suspended.  Match=
 on
+ * the product only (not the BIOS version) so the workaround survives BIOS
+ * updates that do not address the issue.
+ */
+static const struct dmi_system_id lenovo_be200_broken_d3cold_table[] =3D {
+=09{
+=09=09.matches =3D {
+=09=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+=09=09=09=09DMI_MATCH(DMI_PRODUCT_VERSION, "IdeaPad Pro 5 14IAH10"),
+=09=09},
+=09},
+=09{}
+};
+
+static void lenovo_disable_be200_d3cold(struct pci_dev *pdev)
+{
+=09if (dmi_check_system(lenovo_be200_broken_d3cold_table) > 0)
+=09=09pci_d3cold_disable(pdev);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x272b, lenovo_disable_be200_=
d3cold);
+
 #ifdef CONFIG_SUSPEND
 /*
  * Root Ports on some AMD SoCs advertise PME_Support for D3hot and D3cold,=
 but
--=20
2.54.0

