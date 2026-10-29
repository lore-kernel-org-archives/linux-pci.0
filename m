Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264383;
	b=L9DO+mrYCL8LnWpu5qNboi6S0M0iG6Ki6JIpd8XNnlM8dzDO90eNHbtmXAWmT0BPIzUk
	 Ny/RPhScVN6GvJxLya53A9FKIQE5Bo81lpSFxeh1uLUT4cvsLLODVAWhl8TRw33N+987i
	 3RhXrs6O71VxkqBoOvTV+Mqa7mVYCR/HoMrmZkYV69ryHC/NCIaSGpNCBHZRCO8v7lcrY
	 TmXiDLl1SnSIlV/fhweDfbIiF8iYhIKBBFZNlq63udbmoSYQYw3n1Rfmlc2gHh8wDN8hV
	 ak7yv0ne9Iu01lJtT0Qte4YSu7kLTpR5gDQIW2rP4j8KMrsiBpquz4QXMR5fzsy9Hbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264383;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EWgIkiGG+9C3t4UZx8jQyb/h8aaD9D1BomPU2LdA7YI=;
	b=pS3EBXwsaDwBBDxgEOyaikpaFy28VsxOiatVhqWEPwWM7eLIeVepQOWdwQ6/IYCnGpf/
	 x+GJUaCW2n5bG+9Kq6smrcLDGTtmm9R55eFbP4ntIWyqDyGml3IZJbsmmoyp6+2nUiX24
	 2IwZPiapLg+0TGC5mAsrezc2lqZHkP334qobl3OLWNoVJoIs2BMTKU4Dc/Mn6gvAuiVOe
	 yhFwow1gZpwFxiuku/uOgtpjkcIR8UmKRV4NAzPyayV2OMTd4UcN3Sizou2LmeHwaL5sS
	 bUzUwAHo8QuAtamgNpe9P3y6gHJqGX7rJEQ+gqaD7UcvFJ9o6Opb2tyErZRSssE2q5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Qi2/jq4a";
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1CD606A31F
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 08:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F1CD606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qi2/jq4a
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so2887503eec.1
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 01:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793264382; x=1793869182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EWgIkiGG+9C3t4UZx8jQyb/h8aaD9D1BomPU2LdA7YI=;
        b=Qi2/jq4afQD4LZt+PZtRMASfRl+J+ccJhe0O0E/DfjB2yNciffUvLoLJDn/6LY/l1Y
         4yGgRorgfRzDpgIYcMvHKJlFouz1kyEx/au5yfO7jE125Ij+A4zasZ2J+bAQJJJzvP6b
         UGccBoblZkkIqzI2Hdg0ryhaJ81jrr6qCTNpdAZcTWnPPk4iDoAx/YIO11jVrQc9ES0y
         ymciG6i8hrbZXRzHRR3ggBkZy7Lx0Q8uD6VoE4mqk+Ex7dw2/9ILWFfTzPIBNuxSss+B
         qpKPFctR4RtIjCFzQ34vwHj71QBPUSpVfjUrtfE5Pdw0CD9uRbl+g0Sq8R7ueaSTKSGK
         3ZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793264382; x=1793869182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EWgIkiGG+9C3t4UZx8jQyb/h8aaD9D1BomPU2LdA7YI=;
        b=KtLy4jP1AjdO7NstNUttEMmg3Ax3WBcBK4Q+s0u4X0KLsz/+RX1ri6zKfCe1iZJOLT
         COWIx7/q5jFT3awaxYoKFtDa7lF0nvm5ZUGxM2r/JfE66xe+5n/X1xeuSgnfwfBmi3Xu
         skbSrRk4udhql0Kqeagpw6MiLyec94DHvUHAB/6jg9QQnCrZ3VaSDMcAvIodjbGb8vuZ
         15JS2lpS49iijyTE7AfUBilde1qc3UwPCBgrdH4U2uuT0szEcIdBI47QZOpk5NmXPUf+
         Ev5GC2A3sTYHUZ2RYsFRDS3pJT7SKpheGEQNkDxdg4TSwNVNcB8cuPVuLDb/mX4ZFnVA
         VB8w==
X-Forwarded-Encrypted: i=1; AKwUvByefAvG5gO/fiDfknyu8i6VqQmcr4VcHqILeHG7/aaakWbDj/UGuR1GbxTaZvH1mxOYfXexU99f6rI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJCE0FfkdpGCX9QLuP03Jto1ydfqLuTSxMxzEHCIvVaM3mu0cRn
	KDSSj1VPykwaYgr0wLfsB4EqrR1D8jXU/YYUJ88jjTdt6OSVyx3GMQM=
X-Gm-Gg: AYBFou1vN02pSbmImrbd4rxM3i9CfWlvKAoYbf+htdRyJ0brxqYcdfZmyLOkRgXIJGA
	ilv3QMcrb7Zu5Eo9aMZx3lUbveQ3uzpBr/tG3mvmtwXEpprlM5w9o79TMJl54y1AINqDyLdLvaQ
	IGbfMxiXhWBLYQ3oSZ0WdshG7UzCxz/3Bk2A/D/psp+JVZ9FUD/kSbDdxDPALzYiN1NR3es3+U0
	mjm9ldmCeMlotpp9YqS+HWHEC5rG0NAheHocBVwbEhH73KqbgFA4mvt+5hgmHYiEhfUD+VnMzaH
	Y+TsL9U+8bNMz36r/J+vgEpjFmFDEcbk9KOq3opqz+LzRPAXHpdu65S6QKHUsuLozsPnOJbV7Fy
	bL68/JVclO1KlyzE34gSSRTHZjbF37a+57NZ5ZbGBB2IC6nkqezAYcXMsC7EXEAYPC3yv/LG6d+
	IQPRxuDgPK74yBan+4KkqwzGN1Yv0zOqzDqxvUSVGpSShLNH8M3aub8t7h1+k3iQI4uWRc2l268
	j0qdCWX3NSRUKiNu/iLOC6xCJTt0xSDlmquxYvZaKJfm0BSWkobprWg8vyBVyHxoOsJhw3vX363
	U7uMY5TSZjP3vdmj/oX6i4y1JnLjfFpnObMB60kEGGZwtv2UTPGZlgjPstbleg==
X-Received: by 2002:a05:693c:20c8:10b0:36a:1e0a:accb with SMTP id 5a478bee46e88-36a203e2f43mr7265770eec.35.1793264381578;
        Thu, 29 Oct 2026 01:59:41 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([27.60.20.232])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a23641e78sm16497937eec.0.2026.10.29.01.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 01:59:41 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sebastian Reichel <sre@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-leds@vger.kernel.org,
	mfd@lists.linux.dev,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH 08/14] treewide: Add a flag to detect the Apple T2 chip
Date: Thu, 29 Oct 2026 04:52:05 -0400
Message-ID: <20261029085504.3547-9-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
References: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
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

Add a flag to detect Apple T2 chips on Intel Macs.
Cache the result to avoid repeated checks. That will
be used in upcoming patches.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 arch/x86/kernel/quirks.c                      | 37 ++++++++++++++++++
 include/linux/platform_data/x86/apple.h       |  5 +++
 .../platform_certs/keyring_handler.h          |  8 ----
 security/integrity/platform_certs/load_uefi.c | 38 ++++---------------
 4 files changed, 50 insertions(+), 38 deletions(-)

diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
index a92f18db9..6651e5d4d 100644
--- a/arch/x86/kernel/quirks.c
+++ b/arch/x86/kernel/quirks.c
@@ -664,8 +664,45 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2083, quirk_intel_purley_xeon_ras
 bool x86_apple_machine;
 EXPORT_SYMBOL(x86_apple_machine);
 
+bool has_apple_t2_chip;
+EXPORT_SYMBOL(has_apple_t2_chip);
+
+static const char * const __initconst apple_t2_models[] = {
+	"MacBookPro15,1",
+	"MacBookPro15,2",
+	"MacBookPro15,3",
+	"MacBookPro15,4",
+	"MacBookPro16,1",
+	"MacBookPro16,2",
+	"MacBookPro16,3",
+	"MacBookPro16,4",
+	"MacBookAir8,1",
+	"MacBookAir8,2",
+	"MacBookAir9,1",
+	"Macmini8,1",
+	"MacPro7,1",
+	"iMac20,1",
+	"iMac20,2",
+	"iMacPro1,1",
+};
+
 void __init early_platform_quirks(void)
 {
 	x86_apple_machine = dmi_match(DMI_SYS_VENDOR, "Apple Inc.") ||
 			    dmi_match(DMI_SYS_VENDOR, "Apple Computer, Inc.");
+
+	if (x86_apple_machine) {
+		const char *product_name = dmi_get_system_info(DMI_PRODUCT_NAME);
+		int i;
+
+		if (!product_name)
+			return;
+
+		for (i = 0; i < ARRAY_SIZE(apple_t2_models); i++) {
+			if (!strcmp(product_name, apple_t2_models[i])) {
+				has_apple_t2_chip = true;
+				break;
+			}
+		}
+	}
 }
diff --git a/include/linux/platform_data/x86/apple.h b/include/linux/platform_data/x86/apple.h
index 079e816c3..47b27dcea 100644
--- a/include/linux/platform_data/x86/apple.h
+++ b/include/linux/platform_data/x86/apple.h
@@ -6,8 +6,13 @@
  * x86_apple_machine - whether the machine is an x86 Apple Macintosh
  */
 extern bool x86_apple_machine;
+/**
+ * has_apple_t2_chip - whether the machine has the Apple T2 chip
+ */
+extern bool has_apple_t2_chip;
 #else
 #define x86_apple_machine false
+#define has_apple_t2_chip false
 #endif
 
 #endif
diff --git a/security/integrity/platform_certs/keyring_handler.h b/security/integrity/platform_certs/keyring_handler.h
index f92895cc5..a355f4400 100644
--- a/security/integrity/platform_certs/keyring_handler.h
+++ b/security/integrity/platform_certs/keyring_handler.h
@@ -45,11 +45,3 @@ efi_element_handler_t get_handler_for_code_signing_keys(const efi_guid_t *sig_ty
 efi_element_handler_t get_handler_for_dbx(const efi_guid_t *sig_type);
 
 #endif
-
-#ifndef UEFI_QUIRK_SKIP_CERT
-#define UEFI_QUIRK_SKIP_CERT(vendor, product) \
-		 .matches = { \
-			DMI_MATCH(DMI_BOARD_VENDOR, vendor), \
-			DMI_MATCH(DMI_PRODUCT_NAME, product), \
-		},
-#endif
diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index c0d694844..b4096d4c8 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -3,42 +3,16 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/cred.h>
-#include <linux/dmi.h>
 #include <linux/err.h>
 #include <linux/efi.h>
 #include <linux/slab.h>
 #include <linux/ima.h>
+#include <linux/platform_data/x86/apple.h>
 #include <keys/asymmetric-type.h>
 #include <keys/system_keyring.h>
 #include "../integrity.h"
 #include "keyring_handler.h"
 
-/*
- * On T2 Macs reading the db and dbx efi variables to load UEFI Secure Boot
- * certificates causes occurrence of a page fault in Apple's firmware and
- * a crash disabling EFI runtime services. The following quirk skips reading
- * these variables.
- */
-static const struct dmi_system_id uefi_skip_cert[] = {
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro15,1") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro15,2") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro15,3") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro15,4") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro16,1") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro16,2") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro16,3") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro16,4") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookAir8,1") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookAir8,2") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookAir9,1") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "Macmini8,1") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacPro7,1") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "iMac20,1") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "iMac20,2") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "iMacPro1,1") },
-	{ }
-};
-
 /*
  * Look to see if a UEFI variable called MokIgnoreDB exists and return true if
  * it does.
@@ -165,10 +139,14 @@ static int __init load_uefi_certs(void)
 	unsigned long dbsize = 0, dbxsize = 0, mokxsize = 0;
 	efi_status_t status;
 	int rc = 0;
-	const struct dmi_system_id *dmi_id;
 
-	dmi_id = dmi_first_match(uefi_skip_cert);
-	if (dmi_id) {
+	/*
+	 * On T2 Macs reading the db and dbx efi variables to load UEFI Secure Boot
+	 * certificates causes occurrence of a page fault in Apple's firmware and
+	 * a crash disabling EFI runtime services. The following quirk skips reading
+	 * these variables.
+	 */
+	if (has_apple_t2_chip) {
 		pr_err("Reading UEFI Secure Boot Certs is not supported on T2 Macs.\n");
 		return false;
 	}
-- 
2.55.0

