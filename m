Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794345864;
	b=SE1XKyc2rx+FEQqLWoLfRluiTOUPwU5PWYZR+cUgqo5qV2Y3EDuiLDo+o4akxcoXOP15
	 65zFmLFMqVCFlfeLlyDlJi/GB3OPl1T+JiGW34Y9YwGgYJ6rWEbTQF0suNI/WkGfLNUJm
	 +UuUINquX34yqnXcy/NbS31XhpoSL51IK4WRiUOwXUjk7ghMxlRADPMPie9A4h5LueoG+
	 +tr+uZ+zhlbHQBijE7ctW9qCIfEEzM7jdhBvfwuvwkX7+nOCOo9tppt/OPzVcFKH2zE7u
	 wYpUImPdid7m9lDy/6YcDATpI6Vmo25Pitj9r9fiZROTycE9V+ExOTuVi1NwpQAVOkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794345864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=WjjLn9OW/dh8Ooz1Del+NUReCfrVoH+dbIK19cMu41M=;
	b=Gnc2OADmaMzV7CG8PGe0tereS2yPCydTy0S5VMwDAgEELUHfXK1m+IKCFmTBVVHQvs0O
	 VDjCc71hLqXBWrjeo+hbjf1g7KO6TOX1I6RBox8x8Em+9TwN+Ubzac8vOqEfEqD/5pWr1
	 LiCO9SXR4NTdw7WVIu677FURlIZQwYAzQT89VlTA4i+ncw6iZ7HDEANA+yG3N3mJPc/WA
	 JpFBXN6iY6v7uxI+1ztmp0rr67O191C/3dzwE/I9brp8uY0jdJMAdGw3tkzxdmgbUQW2Z
	 vFpNNDEVvyzK/ym5UK5NaGSUFoOPzMlEQKdP86oHtj3mgZmFA+uqrO5YzxsQCZpGZdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LZeIR7jz;
	arc=none smtp.remote-ip=74.125.231.133
Received: from mail-oo2-f5.google.com (mail-oo2-f5.google.com [74.125.231.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6630606A320
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 21:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6630606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LZeIR7jz
Received: by mail-oo2-f5.google.com with SMTP id 46e09a7af769-8458555b6a8so794194a34.0
        for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 13:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794345863; x=1794950663; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WjjLn9OW/dh8Ooz1Del+NUReCfrVoH+dbIK19cMu41M=;
        b=LZeIR7jz+8PUTZOKod2uSPWTzAwELN5uiGu3KaHEfc9cwVEX6Q6WyMgKPfVv1IfFlH
         EM4w8UXaeiFNWUPfd6XbrV+lYhxvTE05jNP6CHVP/cSZE5JaNOyQkSTdlTdbkt+ZI9hv
         HRYtN30DFzuYzCVYLciROC0/i2nW/QtfNXSFjxkXrHJfB5l85Z/Vgkt9XpuG73NOmpE4
         cIq4sar+RMgAtXnejeWfLUb7aXn2e0crn4ZOZXCK0c4cu+yYEyHDMxdYw+DH1uvrfzUN
         AwCJMMUYn4N25gLjH9ylrC5SZS4IlaKRgwdpIGzCuHdFRKfx+QuzyCmijidEp1pzXV1j
         YCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794345863; x=1794950663;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WjjLn9OW/dh8Ooz1Del+NUReCfrVoH+dbIK19cMu41M=;
        b=cNAN7ZNoVEg5OMlmiHupeYbcD8MSf+sgiYbehflJ7BRhnemOtMHjVT2obck/Xs/qpv
         ZJF96QEm/ZaAX1f2C3CMHC/vmZlHlNkE0H1Zv0IwkNUFEtuFFp/wNxY/dpjyAyzuLxHA
         UcgIG5K6T5mbAhQB6qxLRPSlGkMbknU4EcfDphL+1jIQj85jc6tSspQHaqgcQCOJCSdP
         Qz5pWEFlwVoU2fZsipI/z2K/kAo2CRW42OahzNwVY6dSBqurPzkXQhA9+uRE8HSCOeWd
         NrdL/k+zYq6uEWPVLg8w0Cl/N2Tr4f8wQ27JgFqpdSq8El1cMTDabBh6inBe7jkK0ZRv
         z4JQ==
X-Forwarded-Encrypted: i=1; AL+hErFkJYfn/P9oJHCBrPcD8P2Bpz2MY1Wm3zyJjiZngWUC/6EJJ+geS7/jnDhn11WNsg/na6J2XQPfCIY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/5kWWmWlkvSo9A0iI6Vfg0W5YG8i1TTyRh52sXubhF9XvSXwYt
	uhslnsSxlu1o+uBaJp6RH+GnIE3VGABKEFrxCvOLf91lZwfMnMdnLNwT
X-Gm-Gg: AYBFou0WOY/oXSD6zdkXsU4IrGNLbV6p5lFWUiihW9Xt2jwZM2RxPk12ZUhFvheH6SJ
	MK5ESr/AJ8047szlNtHA2qjEct1+aV23q/AEnQSy/6Maw3INGITsr04dUsKUa7EgCDmnmQZvh+E
	ZenxVISgQlB2vEkO9eYLWvM1Qk1v6Db5B/z2smm36gwv9yycAktUJaFw8TtKbVei/gOoURCtXWF
	ccxaxGe5WvssSLthRx0r7xNnBT7jUDr5DXgZFtHM7sDKOGMGVptS6jvzxvV5dvbn34rHkdrQmsD
	GmqR1uoRT5UtYONW/MmwNtdY0t7DYgF7Ze22fHRoS7vvosM3q4Fq8W0U3TYYOzEgpQDUcjVpIJK
	08malVmxPSQrh7t16W/0hgeg9VZJrnGpPzssARFCN03080kh3p5rOztDHftvf6aawuwqbPfvLRo
	NN+nicWK4akyTV8aff+VVTLMLpU2YcEWdaiqjV2Agq6J6gVoHzI9HsmQbAVrbMV/Wff1fT4Ai0O
	AYo9EVyUZeFr6Bo9PdIk0+8SXpNw72y0bBIghTsdJ1mWNr0J8B0cMgXC42NXTgx6g17Ubcs2nbg
	MJkBpgHhzWPPi71Mj7Esgs0x8CrdO55/8GViRvNw+azSJg==
X-Received: by 2002:a05:6830:4424:b0:80b:6f52:3629 with SMTP id 46e09a7af769-860f25e8e97mr185419a34.1.1794345862778;
        Tue, 10 Nov 2026 13:24:22 -0800 (PST)
Received: from [192.168.18.164] ([2600:8804:5716:d800::f01a])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dcb5f7b4sm2845528a34.4.2026.11.10.13.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 13:24:22 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Tue, 10 Nov 2026 15:24:16 -0600
Subject: [PATCH v4] pci: Add broken-GPE quirk for some Lenovo Legions with
 Nvidia GPUs
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-broken-gpe-legion-v4-1-c672bb1c4d91@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/32OQQ6CMBREr9L8td+0pWBh5T2Mi1p+oQrUtEgkh
 LsbMHHpcpKZN2+BRNFTgootEGnyyYcBKqYODGxrhobQ11AxkFwWgvMcbzE8aMDmSdhR48OApS2
 dPplcl9rCgcEzkvPvnXm5fnN63e5kxw20NVwMPY5tJPNjcy2F5Lzgp2MhRaYECuzmV03nSHVrx
 qMN/TZtfRpDnHffKdsu/qlNGQp0qnSqyGulyZ6b3vhuh13Xdf0Ap2dkPP8AAAA=
X-Change-ID: 20261005-broken-gpe-legion-9c9f87a5898c
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, Timur Tabi <ttabi@nvidia.com>, 
 John Hubbard <jhubbard@nvidia.com>, linux-pci@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Lyude Paul <lyude@redhat.com>, Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794345860; l=6414;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=4fzh2Kt6hyJZoUipRYGxY1lLhGP5S0v640iNKn5d27A=;
 b=9YJQTspVWw3SNIHz6DL8fo+E22qGFlOGPsa0xkwd+6tDhnlXfgCbGXQcYPGp4N3hDZTZY7I7z
 YY7fTaOLSYWCVHkiWRKOfP4aVMy0h7QLlgwP6QYEzPL6vHuIQCvyKv/
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

From: Lyude Paul <lyude@redhat.com>

On certain Lenovo Legion devices (including the 16APH8, 16AHP9, and
15AHP9), the firmware appears to enjoy firing a GPE on the parent PCIe
port of the nvidia GPU very shortly after the GPU enters D3Cold. This means
that every time the GPU is runtime suspended, ACPI firmware immediately
wakes up its parent PCIe port, which then wakes up the GPU. Once it falls
asleep again, the cycle repeats.

Note, this bug doesn't require Nvidia's driver. It happens on nouveau and
nova as well, and it even seems possible for this to happen without any
driver loaded.

This seems to simply be a bug. Luckily, there is nothing that we actually
need ACPI wakeup events for on the GPU. Events such as display connector
hotplug events in D3Cold come through as ACPI_VIDEO events which aren't
affected by this quirk.

Reported-by: Ryan Brue <ryanbrue.dev@gmail.com>
Link: https://github.com/NVIDIA/open-gpu-kernel-modules/issues/905
Co-developed-by: Ryan Brue <ryanbrue.dev@gmail.com>
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
Bjorn, please pick this up if it looks good. Derek J. Clark graciously sent
a message to the Lenovo team on my behalf, but noted that the Legion side
of the business doesn't have a fully fleshed-out Linux team, and that Mark
has been helping out in their free time.

I imagine this patch has been missed by them. The patch has been tested by
many users in the linked issue, and I have been running it personally since
the patch was made.
---
Changes in v4:
- Rebased onto v7.4-rc2. No functional change.
- Ccing stable, as well as other addresses I missed when taking over the
  patchset from Lyude.
- Link to v3: https://patch.msgid.link/20261005-broken-gpe-legion-v3-1-f49f465d48ec@gmail.com
Changes in v3:
- Add the Lenovo LOQ 15AHP9 to the quirk table (@jindalpratik on GitHub)
- Also match Nvidia RTX 4070 Max-Q (0x2860), which similarly refuses to
  stay in D3Cold (@inigo001 on GitHub)
- Link to v2: https://patch.msgid.link/20260821200607.621341-1-lyude@redhat.com
Changes in v2:
- Don't forget to actually use parent_adev with acpi_remove_pm_notifier()
- Check if parent_adev is NULL (could happen if booted with acpi=off), just
  consider it a no-op if it is.
- Base the patch off Linux master instead, I based it off drm-misc-next by
  mistake because I'm too used to working on DRM drivers :).
- Link to v1: https://patch.msgid.link/20260821181203.82722-1-lyude@redhat.com
---

Tested on all the modified Legion devices. The Nvidia dGPU properly goes
into D3Cold with the patch, whereas without it, the dGPU will wake up
shortly after going to D3Cold. See the linked open-gpu-kernel-modules
issue for more details.
---
 drivers/pci/quirks.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7f1f47ea2ee4..c2269c367279 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6336,6 +6336,94 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
 			      PCI_CLASS_DISPLAY_VGA, 8,
 			      quirk_reset_lenovo_thinkpad_p50_nvgpu);
 
+#ifdef CONFIG_ACPI
+#ifdef CONFIG_DMI
+static const struct dmi_system_id nvidia_dgpu_broken_gpe_quirk_table[] = {
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "15AHP9"),
+		},
+	},
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "16APH8"),
+		},
+	},
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "16AHP9"),
+		},
+	},
+	{}
+};
+
+/*
+ * On the Lenovo Legion Slim 5 16APH8 and 16AHP9, the firmware appears to enjoy
+ * firing a GPE on the parent PCIe port of the nvidia GPU very shortly after the
+ * GPU enters D3Cold. This means that every time the GPU is runtime suspended,
+ * ACPI firmware immediately wakes up its parent PCIe port, which then wakes up
+ * the GPU. Once it falls asleep again, the cycle repeats.
+ *
+ * See: https://github.com/NVIDIA/open-gpu-kernel-modules/issues/905
+ *
+ * Note, this bug doesn't require Nvidia's driver. It happens on nouveau and
+ * nova as well, and it even seems possible for this to happen without any
+ * driver loaded.
+ *
+ * This seems to simply be a bug. Luckily, there is nothing that we actually
+ * need ACPI wakeup events for on the GPU. Events such as display connector
+ * hotplug events in D3Cold come through as ACPI_VIDEO events which aren't
+ * affected by this quirk.
+ *
+ * So, workaround this by disabling wakeup events for the parent PCIe port of
+ * the GPU.
+ */
+static void quirk_nvidia_dgpu_broken_gpe(struct pci_dev *pdev)
+{
+	struct acpi_device *parent_adev;
+	struct device *parent_dev;
+	int ret;
+
+	/* Just to be extra safe and make sure we don't try this on an eGPU */
+	if (pci_is_thunderbolt_attached(pdev))
+		return;
+
+	ret = dmi_check_system(nvidia_dgpu_broken_gpe_quirk_table);
+	if (ret == 0)
+		return;
+
+	pci_info(pdev, FW_BUG "GPU PCIe port has broken wakeup events, disabling\n");
+
+	parent_dev = pci_physfn(pdev)->dev.parent;
+	if (!parent_dev) {
+		pci_err(pdev,
+			"Can't find PCIe parent? Your Nvidia GPU will have broken runtime PM\n");
+		return;
+	}
+
+	parent_adev = ACPI_COMPANION(parent_dev);
+	if (!parent_adev) /* No ACPI? That means no GPE, and nothing to do here. */
+		return;
+
+	/* The spurious GPEs will be sent from the ACPI device for the PCIe port this GPU is
+	 * connected to, so remove our PM notifier to turn them into a no-op.
+	 */
+	ret = acpi_remove_pm_notifier(parent_adev);
+	if (ACPI_FAILURE(ret))
+		pci_err(pdev, "Removing PM notifier failed: %d\n", ret);
+}
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x28e0,
+			      PCI_CLASS_DISPLAY_VGA, 8,
+			      quirk_nvidia_dgpu_broken_gpe);
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x2860,
+			      PCI_CLASS_DISPLAY_VGA, 8,
+			      quirk_nvidia_dgpu_broken_gpe);
+#endif
+#endif
+
 /*
  * Device [1b21:2142]
  * When in D0, PME# doesn't get asserted when plugging USB 3.0 device.

---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261005-broken-gpe-legion-9c9f87a5898c

Best regards,
-- 
Ryan Brue <ryanbrue.dev@gmail.com>

