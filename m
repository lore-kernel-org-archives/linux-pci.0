Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.203
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794345827;
	b=iTmxgUq7t/Ocrln5/4C8LiBoC+kDKA1vKCBl5b1Z9RGohmsbzSVmJqF9agFePMXkxbNY
	 jRpPP7X3O8NAzztWoBLcspRvO7+7JR7KolLlXBvApvS4pbIXoxCRWdzVUzid8AgzbOEmb
	 YRM7aK3Pb3kBMHGvMXbBx26u+3+FF7YeKnJJca5+8wwTqNt2sFsgfYdxXTXP1fWeQVxIB
	 TMtzsKsSGbLfOyhCcOFnb5r2sJb4vrly2eFF8yEm6MdV2MR5PexLMKInZOATDNtu3Ta1h
	 5wygKp/nHrl9tYN8nQ+5ApgwzG44HoSGVzTZ7EaClpnPAdVGA1579TRakSLOusEUDMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794345827;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=WjjLn9OW/dh8Ooz1Del+NUReCfrVoH+dbIK19cMu41M=;
	b=QR3K4AqTLWVyHoVbtP+wlYEBDqB9jUBufBKClRcoh3BYTJiKBouIS0Gjy9v46ZhGGR7g
	 YEdMZgMgfY4ArBwmmkZrKsdW5guQ7zEhrCM6GyGpT+GiKKyXp4cHpyKj4mXe0BFcfxaFY
	 NOCVYuwvZzfIepGw16hpWtnwazyMoug0DZ/PsMKM547lunGBgxu4L+A0NDNEQKokhV8zh
	 wWUyRvCHT/n3939cCNcv/xDKCjnhGkY78y0ds/XbJLivGGfcMw1le4WwGslBWcmbCMTqF
	 Lb3u+GNLiubJpkQXRJL9vmM6KtdW9wmVx5qs8QWqiAoDbgbW5xHpcPynVnNcCy0qN+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v55Fqf6n;
	arc=none smtp.remote-ip=74.125.231.203
Received: from mail-oi2-f11.google.com (mail-oi2-f11.google.com [74.125.231.203])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C979606A32A
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 21:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C979606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v55Fqf6n
Received: by mail-oi2-f11.google.com with SMTP id 5614622812f47-5681e6e7818so1005175b6e.0
        for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 13:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794345826; x=1794950626; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WjjLn9OW/dh8Ooz1Del+NUReCfrVoH+dbIK19cMu41M=;
        b=v55Fqf6nesjUwl7S3WGtyZfnSRtBELCeXx7+0keF4UefA4+3rdaZ1t8XR8QWXLajp1
         7WOU8hT7hqldekzu1sz3P+CqJN9xW5a+O8G+qHtFBayaPgSA7GkWerAmEcDHK8toyJKR
         MpfZHKeHyicTjkYxEUhKMpvNLDMdTIqvwSKTfPVXWFTqCdMUmlgRVx/PBzthmaqXIfzJ
         aLl/f+2tLGXMk2DHYFn1an1PUaXW8qKLU2hmPOLi+Ax9BNP4tJoGqpCkJxUQ8gVk+Bip
         Fr+DxJKopPuj+79l/jMmJQoI8qoZARITMKgJx8YBhvZQ+D5XBk/VpOk5far5YKujeGdw
         bdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794345826; x=1794950626;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WjjLn9OW/dh8Ooz1Del+NUReCfrVoH+dbIK19cMu41M=;
        b=CkrOXSgjAn9wVX4VyqvHiUyLW6f03Twvsw9gm2XUmhfrrUHSpd4qU/99EqYS3mm7wu
         NJ/B6vpd5xYh6an97Iv/KTZobrkMnfDezy3dM51dk407jiLN3PxBMCmbCp7DzamKMA0U
         Uyn1SK8om5xGnG/hc2vtEPI7/KYpUmLzVfmZOiHuxusUrKWws6/QJdcMS7bqaV0GC+gX
         BKxnn/g9Gfl4Qe7viTOY1cN/ALaZTL1V9KoHTLV+q0H5YC+ZfYar/tNTTXLrmLAzt1p6
         ZXlXKo3zgsC38QmSyQRK5KbwL0q9peD3ajk8aVzRbPsvRKY75vz+wMWhQuyZcJyqXOl7
         AqhQ==
X-Forwarded-Encrypted: i=1; AL+hErHbMjkoyjn1xLzsXYi74P2gllraupNRPh1ZrEOIKPbzQqRLaRXgxeN2ogeQtRwcmTZf4tO5SLIU5dQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/fPcPiNctzl0vqWGAqOtReoFJooVblUI8NuBjA0XbR9owPnPOl
	jC/LuLSqWb80aXfQ1D40nhgf5kHU8aCkNE79dV9w2QCAOroKPFwJrnZe
X-Gm-Gg: AYBFou1QrMmK3B0bc8/wgzwoG9Zx7rPEmKdbEp+X2LIq7bECvJ/Cvc34lcYsMbQ9jh4
	XV5wwSu22VOlP6Tq0V72pt79WMWmcK4738lFO4ggxB/54Ribm7c0FlVtZmiJLCC7vrUeC7HnDDa
	NtX7WZ51gcpO3Gp+Nc4+NSNm2ps9SY5paI1ix2m7e0+eGGYeLunl4Rxjml3u43hdQpGRSGY4j9N
	UswL6WIcrc3PHTc4KkwwZrzORrL49VCPueBFL/KHsStkFKd9Hr5dfOR9KH6Zu23He6RJLy70Pbf
	fqujYc66UizwvjjrrtaM1H2UhpijHsq9dRyxChzJIgiekcpumtu2emWGYafya7Fxu4PSMDiZxxY
	Z9CnIZu9EJcvd2b/KbMBgVcsc1/fmgS0ELj1h4HZidnrx7v+a4H/hbtxzLQi54prmeaM+7MdWfe
	mn8su/9ixwai1+PH2Ey6QnXvBT7azleVuGjHTR89114985efuFSOpkba18UI2oTpjjhjI9yZ0V2
	OzTqeYWUf9a3rB7vBj1U6pFHOpI9CGJYZ3muTK4YzhMX6THwmkTHwcjbcMdjenM8EPWspdE5of5
	VAwxYaB14iTQqkOCQnG7/K7Y2w==
X-Received: by 2002:a05:6808:c3ea:b0:4ab:230c:5faa with SMTP id 5614622812f47-56b963a7115mr210675b6e.18.1794345826045;
        Tue, 10 Nov 2026 13:23:46 -0800 (PST)
Received: from [192.168.18.164] ([2600:8804:5716:d800::f01a])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5690504c276sm3229558b6e.4.2026.11.10.13.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 13:23:45 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Tue, 10 Nov 2026 15:23:44 -0600
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
Message-Id: <20261110-broken-gpe-legion-v4-1-3668ce0c2efd@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794345824; l=6414;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=4fzh2Kt6hyJZoUipRYGxY1lLhGP5S0v640iNKn5d27A=;
 b=BreNeT4+5sRjWVoRkW2qHGfabP2EUtz4OE0rjq6itQKYCjr7cFCA+NpiP84bvcym91Vki98hM
 81kllDoWdsfCN/wa1RID/Ws+3CTH0kaYEW50aB9mvRfV9V82p0OPCD2
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

