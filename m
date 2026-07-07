Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB26B3D6473
	for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2026 22:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783462690; cv=none; b=tzt+fHEFoJWru00bdwNMO1fa6UdWTqkGRi4IlbTik9a0fSc55rr+EkwtTj2VAuqbW9sz+HMVKLA1IKF3ggHamMuwa1vp7rU+kN7WpXSq39n+oNJFUJ64Mv2UmiJrPNEtJrCbbrnHZLN0dsGe4Qv/QAMe/ZAAKZAVSUqvC21QpKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783462690; c=relaxed/simple;
	bh=Wx9VvxbnulORWL9ripJr5/wY9f/X/PmDTdCseq26ni4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPG4yWWEplNv/6Eq+lrlxVAkr3ApB0rDsSJHgXmyIEZFITkqoYKxBWA54lfECDUSRj78EzVA92c0vqAMA8/lsAJryGutGJkC9hUuSxrQG37zK8GfeRqDVLkeie2NUlfi+4db/xvi52nrd5Bp4D2Ww5Oc9UiS/H0N6nvoBK4Y3Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZPpbKaT; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZPpbKaT"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84532e3dbf7so28393b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 15:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783462688; x=1784067488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6uhSVxaxBD0j1knqNoG7PvHL4FVCpnsFNmFTlNcL8w=;
        b=CZPpbKaTabNgIBYCWaAEDmkvEBXJVIJK6rxofvFQJzn1CW1rcM0gmtFLiP1oP7Uc5C
         MfbhIxSdKj2zyADxf0z+6V9gQQoUoEWgg4Si7hib4haHHpWKqIPcW9wiQaY/LBi8TOg9
         UwzEaXDm9tAJMf1+z2CMFKuh90eDg7cgE/OmdJw+TqY2p75BUj9KikMOd6goYCdn9Fim
         30OjRlSUgLPTr73KyA7CTEWpbXHmWz37hDU0YUwPCG0phlKhWdkTdJdUN/6xia2oRPqK
         fJ9ClF3ctnUj0JNZsZWn9IWRFUi9GvYtWy7OmyD/OD0Zwm0Di/eUIYlkrMAyghkIhjNL
         Mfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783462688; x=1784067488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n6uhSVxaxBD0j1knqNoG7PvHL4FVCpnsFNmFTlNcL8w=;
        b=B1wsXvNLMeELFZhblnpulXN4V6RyCCyWvQ1I4Zca6WXWS+FwFLbe2L70jz9onlPwSx
         0NLy2kfY5V98NBh/O59U/Rp1Xj7Uec9r1cqKmqlxrBh9sRWMCfjXMPNQ8mBMdnhRAjx8
         qWoUsrmtK3Ir50M2zRdiamDUYT41lAJ2ttGaogGk/qi8astAAkSlY9KUiVE9mvCZYDVo
         jNjwijWRWDYUB5J8DdWcwJGejZrG2hZ/UJhYvHv/enkvis7ByneMnSQ9qmCSlbUuQwb8
         5WclEyhwSd4u0DYPTpwMhqKuW2fXFNV2MNIBRtC8bjcT2U/ZANhO6zBu6Q8ECKvswWf+
         8NEg==
X-Gm-Message-State: AOJu0YyE8h89sbxnuY0r2DQwg8lF+S14i2gPysROg9Uo9atvJhP4j+EA
	1I3na9ISpBZoA4okq2ENKz9ScBkOfOCJ03hBOw4J8Su9F3z/kvSafyNdATzzXy6c
X-Gm-Gg: AfdE7cmQ8TbGANhDVDhUn1QDHmjxbmu8WRLnp/2HxmgXzXycHZ0aLtBmi8Slo1jEUeQ
	Ko0c3pGhwuaflFkxzImcSrWkvg3irjtNexPnz4OxY23loiyf/NmA7cO+qkJClNM/BNJ+MneoNCe
	a8xuoI8c+ionOtC9EERGtpLdKOhYBuYidSowWKrTd1xY/B2kRvLNjVt8e3RzPYTedLJ4FUyZoU2
	3XRufeHgop6OIEfUq5a7wReLOnYIIIlp2uKdKgbb+29xK0J2awqcEgw3ePvUvfUcD2GY1Dspl8M
	QEkFhtjovTiAdIETn6L0OgQb2vUQiL7+GDAIMtELr+G5sirEYdKrQc1jKUuVmW2jKz9SmRErn5r
	aM1mJA5PgQFIfW+PjUxe5Ua1HwckzLHpRZaxv6E9/EVTY3uKcLikusE+oGDhlfwdBtaUbwquvNx
	8H4MUw7/UW/5VjW0SCIaq5TWYDSnsRa/QOB/D4d2P25Fkt+CAr89EpCE4bJGAoTYyOHkw7F8nP2
	OtvXV2sAQ==
X-Received: by 2002:a05:6a00:1883:b0:847:8704:1c48 with SMTP id d2e1a72fcca58-84843029092mr28398b3a.20.1783462688110;
        Tue, 07 Jul 2026 15:18:08 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b9b389sm6180281b3a.13.2026.07.07.15.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:18:07 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH 4/8] x86/pci: move SiS chipset quirks to arch/x86/pci/fixup.c
Date: Tue,  7 Jul 2026 15:17:56 -0700
Message-ID: <20260707221800.920270-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707221800.920270-1-rosenp@gmail.com>
References: <20260707221800.920270-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move SiS-specific PCI quirk handlers from drivers/pci/quirks.c to
arch/x86/pci/fixup.c:

- SiS 5597/496 PCI-PCI transfer disable (quirk_nopcipci)
- SiS 96x south bridge SMBus enable (quirk_sis_96x_smbus)
- SiS 85C503/5513 SMBus detection (quirk_sis_503)

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 arch/x86/pci/fixup.c | 64 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/quirks.c | 64 --------------------------------------------
 2 files changed, 64 insertions(+), 64 deletions(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 81f9cd5d9885..035723d2cb64 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -1991,3 +1991,67 @@ static void quirk_via_cx700_pci_parking_caching(struct pci_dev *dev)
 	}
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, 0x324e, quirk_via_cx700_pci_parking_caching);
+
+/* Chipsets where PCI->PCI transfers vanish or hang */
+static void quirk_nopcipci(struct pci_dev *dev)
+{
+	if ((pci_pci_problems & PCIPCI_FAIL) == 0) {
+		pci_info(dev, "Disabling direct PCI/PCI transfers\n");
+		pci_pci_problems |= PCIPCI_FAIL;
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5597,		quirk_nopcipci);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_496,		quirk_nopcipci);
+
+/* SiS 96x south bridge: BIOS typically hides SMBus device...  */
+static void quirk_sis_96x_smbus(struct pci_dev *dev)
+{
+	u8 val = 0;
+	pci_read_config_byte(dev, 0x77, &val);
+	if (val & 0x10) {
+		pci_info(dev, "Enabling SiS 96x SMBus\n");
+		pci_write_config_byte(dev, 0x77, val & ~0x10);
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_961,		quirk_sis_96x_smbus);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_962,		quirk_sis_96x_smbus);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_963,		quirk_sis_96x_smbus);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_LPC,		quirk_sis_96x_smbus);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_961,		quirk_sis_96x_smbus);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_962,		quirk_sis_96x_smbus);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_963,		quirk_sis_96x_smbus);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_LPC,		quirk_sis_96x_smbus);
+
+/*
+ * ... This is further complicated by the fact that some SiS96x south
+ * bridges pretend to be 85C503/5513 instead.  In that case see if we
+ * spotted a compatible north bridge to make sure.
+ * (pci_find_device() doesn't work yet)
+ *
+ * We can also enable the sis96x bit in the discovery register..
+ */
+#define SIS_DETECT_REGISTER 0x40
+
+static void quirk_sis_503(struct pci_dev *dev)
+{
+	u8 reg;
+	u16 devid;
+
+	pci_read_config_byte(dev, SIS_DETECT_REGISTER, &reg);
+	pci_write_config_byte(dev, SIS_DETECT_REGISTER, reg | (1 << 6));
+	pci_read_config_word(dev, PCI_DEVICE_ID, &devid);
+	if (((devid & 0xfff0) != 0x0960) && (devid != 0x0018)) {
+		pci_write_config_byte(dev, SIS_DETECT_REGISTER, reg);
+		return;
+	}
+
+	/*
+	 * Ok, it now shows up as a 96x.  Run the 96x quirk by hand in case
+	 * it has already been processed.  (Depends on link order, which is
+	 * apparently not guaranteed)
+	 */
+	dev->device = devid;
+	quirk_sis_96x_smbus(dev);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index e8813811d935..71df81882049 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -364,17 +364,6 @@ static void quirk_tigerpoint_bm_sts(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TGP_LPC, quirk_tigerpoint_bm_sts);
 #endif
 
-/* Chipsets where PCI->PCI transfers vanish or hang */
-static void quirk_nopcipci(struct pci_dev *dev)
-{
-	if ((pci_pci_problems & PCIPCI_FAIL) == 0) {
-		pci_info(dev, "Disabling direct PCI/PCI transfers\n");
-		pci_pci_problems |= PCIPCI_FAIL;
-	}
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5597,		quirk_nopcipci);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_496,		quirk_nopcipci);
-
 static void quirk_nopciamd(struct pci_dev *dev)
 {
 	u8 rev;
@@ -1117,59 +1106,6 @@ DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc_ich6_resume);
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc_ich6_resume_early);
 
-/* SiS 96x south bridge: BIOS typically hides SMBus device...  */
-static void quirk_sis_96x_smbus(struct pci_dev *dev)
-{
-	u8 val = 0;
-	pci_read_config_byte(dev, 0x77, &val);
-	if (val & 0x10) {
-		pci_info(dev, "Enabling SiS 96x SMBus\n");
-		pci_write_config_byte(dev, 0x77, val & ~0x10);
-	}
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_961,		quirk_sis_96x_smbus);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_962,		quirk_sis_96x_smbus);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_963,		quirk_sis_96x_smbus);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_LPC,		quirk_sis_96x_smbus);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_961,		quirk_sis_96x_smbus);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_962,		quirk_sis_96x_smbus);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_963,		quirk_sis_96x_smbus);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_LPC,		quirk_sis_96x_smbus);
-
-/*
- * ... This is further complicated by the fact that some SiS96x south
- * bridges pretend to be 85C503/5513 instead.  In that case see if we
- * spotted a compatible north bridge to make sure.
- * (pci_find_device() doesn't work yet)
- *
- * We can also enable the sis96x bit in the discovery register..
- */
-#define SIS_DETECT_REGISTER 0x40
-
-static void quirk_sis_503(struct pci_dev *dev)
-{
-	u8 reg;
-	u16 devid;
-
-	pci_read_config_byte(dev, SIS_DETECT_REGISTER, &reg);
-	pci_write_config_byte(dev, SIS_DETECT_REGISTER, reg | (1 << 6));
-	pci_read_config_word(dev, PCI_DEVICE_ID, &devid);
-	if (((devid & 0xfff0) != 0x0960) && (devid != 0x0018)) {
-		pci_write_config_byte(dev, SIS_DETECT_REGISTER, reg);
-		return;
-	}
-
-	/*
-	 * Ok, it now shows up as a 96x.  Run the 96x quirk by hand in case
-	 * it has already been processed.  (Depends on link order, which is
-	 * apparently not guaranteed)
-	 */
-	dev->device = devid;
-	quirk_sis_96x_smbus(dev);
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503);
-
 #if defined(CONFIG_ATA) || defined(CONFIG_ATA_MODULE)
 
 /*
-- 
2.55.0

