Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0E8324B1F
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 05:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784612736; cv=none; b=Z9W9AeRDE/kA+bRNckhnFKuKhc/0UrSW87xtLG5Z+K0uEXie7YFvPgdIqLpxJUF8ygNOgt1WSIwNQ4MAT7CKbP4/dmNnqIlhKzCNzyZqoN9vSX7nc2JkxirNbJA/jLiCchK8P/xDRn91gj0y2ukiSdyXAjB/fkRexxCMzjNs9pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784612736; c=relaxed/simple;
	bh=lr26kXFL1hHfgp2b30tVNsktdYjyhepmuSF83pAOJs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fclxBm9EoB6M0Da7Hftd9A3u/hlRa7VSN5dWkGFNWtHZEItDQq+Nv1snxv+h4++vlAWkSYwl2Z0ki6Yncv1OSMQlKokLHcYCPqKaktwh29Rye1qR3cIeewq9eM1bkyvXVA+bDE7AkfjcESZpPXTR0MG1tcrgMV7zNWngGsOOnM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rL6hZrDG; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rL6hZrDG"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cb5b8572b70so2657151a12.2
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 22:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784612734; x=1785217534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jKhFN9zG5GWfS1y9kxMxjS3nA8FNjbgYmSAyZRA2lkM=;
        b=rL6hZrDG4vWzOMGEnOt8fSiyJQhnIHfcE2/kIPQB7uoBZwFxrkylTZo8e5yH1/53OF
         0qPy4TlB9YB+R9KSSMap5kQ3tbJXAQUiXjnVSbhbt71gkzjCO+yCLH+G8WGf1KkNhaBE
         KVQ1ScWAmnFQ1rwHztpRsUUtaLs+eZi11JJf0jhTEals7Ke2eXgMr4aj5wVP0RHfOMqL
         cE8BghKMN/rCY/eEhCZMN1F/vCAPT6rSPGq644RQLSvr4a4+QRKr/koMBUvBPjkSCXMt
         kCHvqWxOJAMxX8RZ2AnYU3bTVbYSh6unAFcHfxo7427eFrfkUO5xOo2yObK+oNgPmxiO
         +hwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784612734; x=1785217534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jKhFN9zG5GWfS1y9kxMxjS3nA8FNjbgYmSAyZRA2lkM=;
        b=ZMT5sBFibAIQBgPq9sFgScUi64ospeARp49hm4GZceERgheWjyIsnlY43BadHbb25I
         +unjKayvZviwohTppklDPneikMWNllCWjuUwNhjN6w3ux247+ayofkUj5Im33rGr/5Ry
         BVpwqN9Od3MO1ZDcHcy88E6mfSm3JKvFINoLJ3MGp1pTGjW+Qexvft7lpO//cY0HFU1A
         oDbQb1A5W4LJn8hA527dS1TkiDsRjAhCk9r9tfMUavvA8nZpMaIULbuxIwhkhab7aPM4
         EXtjK+NKH1a+TA2gDoQKMFUQml7BFUyiw5g1sc2pY2A4PQN+rSbNzT0i2DVZgVAE1GLv
         JE4A==
X-Forwarded-Encrypted: i=1; AHgh+Rrlhy2g2uoJI+JCVnndkRb8nJKToqTwqzHJ12dppeTyiT7mB0YWOf+wPmaK3UtihDmAX+qsxgtoPPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjv7MRik2Z+er3+u3ghsLNdj3GqsKoXf++CSnijrB+HCW1Z3Fw
	Qm5aOGMhzURcDly01zijIMwtOeE6g5NjpX3pnr96EmbInBmoZuQ8ass=
X-Gm-Gg: AfdE7cmoNy6phT1kl+5lmt7DMITXgbaT0vgAV2zl0+NsGD4LKwD48hPinQmsnQkK4VU
	eiq4Pc8W/cGuFCF6J7OO01vVWKEKbXPlaFZE/lhjQb5ZVT13FUA97I9PDNlhKAdEEmk3qJE8dcR
	ND8O/NBVySkNSD6UJZ6bM3Yj2vSr3rANQm57KwcEAbwi5o6epTQ3yCnd6CgiTEmwzCanchTaeYv
	7cGaupJBblQx9f+YCdOMe2TEbSsA7Pi6+n0UUeGHx/VcjjFN2Lp7Rl2paqTFL+fVyGCdHWGmDR9
	h5uMWv81uTMdO0hgfcCV1/ytpzwqAqN+0BZ7Kh+dY/nfyPs4FSnPEdj1+DEdzEaZ+FoBY0ycMN7
	v2tkr/FjjUDez4QR6qruy3ZPk1GoOuK8kRUZLC2o59LywXCw+ctPl3E2qpk1HOoPohxYYVgBNJA
	y3M/GfPtCcmO00onrYt1bA44xu4BR/vXQj75rvke1h8Y1l7p8H
X-Received: by 2002:a05:6a21:485:b0:3bf:6acf:2940 with SMTP id adf61e73a8af0-3c3ad5d51e8mr18203546637.11.1784612734470;
        Mon, 20 Jul 2026 22:45:34 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([27.60.20.188])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1bb770sm46620876eec.16.2026.07.20.22.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 22:45:33 -0700 (PDT)
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
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 1/2] treewide: Add a flag to detect the Apple T2 chip
Date: Tue, 21 Jul 2026 01:45:01 -0400
Message-ID: <20260721054506.11871-2-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721054506.11871-1-atharvatiwarilinuxdev@gmail.com>
References: <20260721054506.11871-1-atharvatiwarilinuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a flag to detect Apple T2 chips on Intel Macs.
Cache the result to avoid repeated checks. That will
be used in upcoming patches.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 arch/x86/kernel/quirks.c                      | 105 ++++++++++++++++++
 include/linux/platform_data/x86/apple.h       |   5 +
 security/integrity/platform_certs/load_uefi.c |  38 ++-----
 3 files changed, 118 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
index a92f18db9610..74b29738d404 100644
--- a/arch/x86/kernel/quirks.c
+++ b/arch/x86/kernel/quirks.c
@@ -664,8 +664,113 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2083, quirk_intel_purley_xeon_ras
 bool x86_apple_machine;
 EXPORT_SYMBOL(x86_apple_machine);
 
+bool has_apple_t2_chip;
+EXPORT_SYMBOL(has_apple_t2_chip);
+
+static const struct dmi_system_id apple_t2_devices[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro15,1"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro15,2"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro15,3"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro15,4"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro16,1"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro16,2"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro16,3"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro16,4"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookAir8,1"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookAir8,2"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookAir9,1"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Macmini8,1"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacPro7,1"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "iMac20,1"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "iMac20,2"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "iMacPro1,1"),
+		},
+	},
+	{ }
+};
+
 void __init early_platform_quirks(void)
 {
 	x86_apple_machine = dmi_match(DMI_SYS_VENDOR, "Apple Inc.") ||
 			    dmi_match(DMI_SYS_VENDOR, "Apple Computer, Inc.");
+
+	has_apple_t2_chip = dmi_check_system(apple_t2_devices);
 }
diff --git a/include/linux/platform_data/x86/apple.h b/include/linux/platform_data/x86/apple.h
index 079e816c3c21..50bbcc5134fc 100644
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
+#define has_t2_chip false
 #endif
 
 #endif
diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index c0d6948446c3..b4096d4c828d 100644
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
2.43.0

