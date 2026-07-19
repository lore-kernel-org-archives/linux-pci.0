Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE603B813A
	for <linux-pci@vger.kernel.org>; Sun, 19 Jul 2026 18:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784484244; cv=none; b=kblqB8w6HMkFz52vDWXlN63/c8b4SwlBD8NDnxTCvHHSF8bJ77cIj5j556zSv/qw2ksHFOluLYrtfaX88rUxIW+ZGnlEeQT96tTkPev8qCD8mdewHatJEQ/w+mEBjWocx96WFiy31DP0hH3RqPS4XvZS+8+Gb6+fTsh5HiVrrSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784484244; c=relaxed/simple;
	bh=v9HeOFbg7yqaPJFAebJkoHX6/z4ZNAksuMZiGZTzcV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swyEj4Y9DAV5AthwIQZeYxWC7t3R3237YnHrTP21NWquZcPyZJnUoXCEBu1al5P/S9Z3YQJtKavRNRWZPHyPqL/HJzAnFrYwY7BYLw/Xo7FW3ocd3oR89o5wbsxM10xS/VUTkJgM4BTi7EW1UwelAGobwaetw2qoNtLYsanomKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gg7MNV9C; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gg7MNV9C"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so1291495ad.0
        for <linux-pci@vger.kernel.org>; Sun, 19 Jul 2026 11:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784484235; x=1785089035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SdVZ4aGJrm1DuTj3OJVvOnHsBpK+4e3jVQB95QmtQUM=;
        b=gg7MNV9CA9igFeOzIJfAXVNKOwkbLs9PG4eMCYQjLezdWaZeh7jVGLj5Bj+Ifn4bGZ
         9k7C45ijMqgkKegBw2uAAYb2GPAqQ8ebq/LU9PHT/VfBPXsw4/R5BiIXxbb/h6EKYtGl
         jHGI7NRDvxstNnUchf2jW03fLgLCF4a97s4DP+uQ1hn2Kd3dmFBTLw9lNvT4mIC61tgW
         ZiI5dd/5sYZ1v3FyIwphdF9J1lp25UR/KdNFZItpiBWIJon9xb7I23APgu02mGWys9uZ
         VQWOEPF7tUF4JX95pBH7CI77gBwfNsugWDFHrFpz1euzx9cWfs26ekO/zsIKOxDppCUd
         uK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784484235; x=1785089035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SdVZ4aGJrm1DuTj3OJVvOnHsBpK+4e3jVQB95QmtQUM=;
        b=PKUC6Bl7Aodvdple15PiyEubGKIrpGRIPSQ+Edrj+w2nO7ibFT89IwfnnABo5K4yNS
         qh80CRlB+PC66K2LT/Z6fMcNzIWeFzJ8XPpM8qisus89Vp+9a7pndk7uMV7fL0k3Ihpz
         D4p/6DarBUJd5CYsy5BUvGkVuJ3G814xDmGBgPYIANmmLg+Bh5Df/w7PPg+xO3EM+2iq
         BjyE0sD0uROT+rqM42FRlDQhLwUWLmZWkmOciK5trOor/Xm/iyWAjHyudRMZ5hcUonKO
         rHlLslLGyMXFeb8qMWE/BK/ycEoc9s39+cI0FOAcHmQc4x6a+s5LtjF0uMLPE+yNZvgY
         T/Rw==
X-Forwarded-Encrypted: i=1; AHgh+RosRfWjRSNCvKXRy4ur/bKBJn6uqlTaB+iozPuhflt1Iw1+Z3k3VRPJ3AmgmzZT6MHnlI3SER+8BgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT10wL8Sp2WHeX4KmS+n9MHmYJh2J2SH1sJPsThjousDXyG9jI
	t5J26h/obdOSJoUipg6JexTtposaYfG5eatQvqy+1S43+seGdz34rUY=
X-Gm-Gg: AfdE7clRZ4f8n6Rm9tMEce8gOKfWDOhKlOGEDsFIXrONVXykGEkNCRBlZxZ/qgKAnu4
	DNAjiaBNjUH9cp8I2FwFmcTJFIDyoAWa0h30Qk2lJ8AFySjGqdm0PgBaHfYfL4tDWZrQzBJdsGZ
	BzJeYBtGXVaqB/Gw+cRZ1gquD2dwtlmCcX/8EPmfuaeUCk0bEqf6v99jtEY+1nfTw8MpUtBt34j
	V3G+Nh3HMjisHBLVi9Q4Q4MXFdx1BbxTL6uPcJxvKLyaACY+I2SxiXBEgfZfn6vUic/ADRIEM7m
	ug9ms2qP+RVg70i2h5RGPgEpcQatyZr0npXe5OfzVZeE5dr0HYBTlWcdE9WfVieTPgzOgue5NKM
	3T8PqgJH0k0AegbOGd35lIAp3PoWrXbJ946O4i67P8WhDCJhBGlhlxir8/jQbt7ixq5Q9zKD/Q9
	RO0X68j0zE3oF9OOMLyHI0mL2MC6uTGFCAa6NM2pqQ
X-Received: by 2002:a05:6a20:bca2:b0:3c3:bbe6:95c7 with SMTP id adf61e73a8af0-3c3bbe69a9amr6850926637.17.1784484235584;
        Sun, 19 Jul 2026 11:03:55 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([106.194.66.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a02b7f2sm27967645eec.13.2026.07.19.11.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 11:03:54 -0700 (PDT)
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
Subject: [PATCH 1/2] treewide: Add a flag to detect the Apple T2 chip
Date: Sun, 19 Jul 2026 14:03:03 -0400
Message-ID: <20260719180308.1398-2-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260719180308.1398-1-atharvatiwarilinuxdev@gmail.com>
References: <20260719180308.1398-1-atharvatiwarilinuxdev@gmail.com>
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
 arch/x86/pci/fixup.c                          | 10 +++++
 include/linux/platform_data/x86/apple.h       |  5 +++
 security/integrity/platform_certs/load_uefi.c | 38 ++++---------------
 3 files changed, 23 insertions(+), 30 deletions(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index b301c6c8df75..fbd204ca4c6d 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -7,6 +7,7 @@
 #include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/pci.h>
+#include <linux/platform_data/x86/apple.h>
 #include <linux/suspend.h>
 #include <linux/vgaarb.h>
 #include <asm/amd/node.h>
@@ -995,6 +996,15 @@ static void asus_disable_nvme_d3cold(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x9a09, asus_disable_nvme_d3cold);
 
+bool has_t2_chip;
+EXPORT_SYMBOL(has_t2_chip);
+
+static void apple_has_t2_chip(struct pci_dev *pdev)
+{
+	has_t2_chip = true;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_APPLE, 0x1801, apple_has_t2_chip);
+
 #ifdef CONFIG_SUSPEND
 /*
  * Root Ports on some AMD SoCs advertise PME_Support for D3hot and D3cold, but
diff --git a/include/linux/platform_data/x86/apple.h b/include/linux/platform_data/x86/apple.h
index 079e816c3c21..a2ab63bd1eac 100644
--- a/include/linux/platform_data/x86/apple.h
+++ b/include/linux/platform_data/x86/apple.h
@@ -6,8 +6,13 @@
  * x86_apple_machine - whether the machine is an x86 Apple Macintosh
  */
 extern bool x86_apple_machine;
+/**
+ * has_t2_chip - whether the machine has the Apple T2 chip
+ */
+extern bool has_t2_chip;
 #else
 #define x86_apple_machine false
+#define has_t2_chip false
 #endif
 
 #endif
diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index c0d6948446c3..da57ac322e72 100644
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
+	if (has_t2_chip) {
 		pr_err("Reading UEFI Secure Boot Certs is not supported on T2 Macs.\n");
 		return false;
 	}
-- 
2.43.0

