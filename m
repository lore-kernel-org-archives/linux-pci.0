Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF98E346FC4
	for <linux-pci@vger.kernel.org>; Wed, 11 Feb 2026 03:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770780722; cv=none; b=Y7+mv/BmgpBzmrqwWwk2yHGmtmxFvB/k+kdhkrteEygHLztbRr3XvRx7lq8aITvwzIcydTrS8LIaqWDpJ5D1LvDEu/tGMzS4+MeiObIZCTV7hXvJ4xduFxh0Q2TUdsIxkdL/jVGXLYTCR/U5ww+n6xQv5MmL5CUAfj9nH8cNNss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770780722; c=relaxed/simple;
	bh=Z69UWGSO1FnIFTybZW2ptY5C1ZsV33yAkveZ4NGbphA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ur0rxkj+vaSfTCzGfubwSo1tmcH25JyCS97KKQJYH5Pix6kEAxyvdsWyqtBpNtNgNysa8heh2sSsfgsZQLIvGA0kCTTQJd5WC0fTHH4jye9LgZPsPssQfEU3MLkhSqUsRVftipNEREtWG/UDA/fKeDAYyciPcTWDgmVjiruPKeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mr6rQlEl; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mr6rQlEl"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8230d228372so3789264b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 19:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770780721; x=1771385521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sfIotc7x/caqwXPwf+nk7Gcfnkj95FCCwlgWI7Ef+4=;
        b=Mr6rQlElHo1gqS78wcZTyeup5THY7lSLHcPWChE01TknCEKrn1eCD0Grj9iU2C8rsm
         XvP296reOTZl4ixWbiKtD4aFq8G0opqku07f8rzUTwm/l+1NNuRUTu4yDr+3CGwfxdAu
         vHShWYw3Y9dN+2/YYgVNqn05MAygKBd5aJZXv1M890ZAgERi3wSSoW7nkYAIgnrV8hh+
         A44syj5b1T0miAhEOlNI0fY3i0M/UGdoXe0zXu/SCfIFbLMytLP2qhnkI1tfoloQdo3M
         h4e4WjPbZ0r9sWOy4EzHLeMXXqH7XmKg3Ba5WexPir45XQpAFvhLHSDDP0VmxYeDIObN
         mx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770780721; x=1771385521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5sfIotc7x/caqwXPwf+nk7Gcfnkj95FCCwlgWI7Ef+4=;
        b=YIBqPJd4FQ+63kcJGhGpENKAKeeEbWkG+xbf2WtNPFWJZYajgoxLzaQUHX0zZKp/R5
         ifPczbTyBjEfR9Gvd5LkvQxiwfQpdyiVS1o6mH+LNHTkLLQw/AdA+f6FBftNbUIk3nUY
         o/2t6HjiqQ7erjvPcVpvPwUnv2f1Kvg6AsIFvdlz4c6ta4aghB5wD9uPa3crH5mhwpRb
         jcCNghfZT62F7+eXdJKICTW7EjEASa43VR9zNgfSECfoBysf6bIJLFacwPvf3wczq/vc
         T+VGguw4QKaTCN/1nSnTNILg61NHA80y6g31NlPP1jooMccsMkzZNOo8lWa9OoVPTWqX
         fbsw==
X-Forwarded-Encrypted: i=1; AJvYcCXltnFjcRfsLByY3dPuZsyqfqVRY/vcsi4xzXHGs3SNfw/BIMpUNJDipQLtQ42hU1Iuqdgk0eDtgrM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhh0Wj9+xzsAyL/WJfKHtWlo590XlpDIUN6tnenaoLc/ET0zXF
	int7Y1BDJm5pDkSyFGFq4RHNvww+Eh6Or0Sy1pKz4Z1jAqQSp6q8r91P
X-Gm-Gg: AZuq6aJZV+ZZxJZJonIhpOxn0gSY2aXomCpp7tQmgsav0iq/kp2q3P6eeN1/wjzdTvH
	DWay8q7Bv9wSvDQ726X0+muIy8I+DQh99EhObZe/7woyjJGe2XtCEbEc8z7OT7UDQpJ5IRhvaju
	N4on3SoUhoxQDiCzEgNK0U7Plqv8tPBCV3Aj8KWtsr66tEG3G3NSu7Kwr+YcSE02px7z2zh7GXD
	9Q9wBjVO+gP8I//j9/w/rLVRmRPMZMt/InNGq06GOfC5FYaoMQ3AlHJQQ518JygdaDAZJ1HL0D+
	m5Xc7AGG8Auw6Ft5/+AN/x9Uqzy3WBTFPfEniVyEPuhAvHEJmm2BNzYY3FwLTFtUipArev6toJL
	mIBYzEBx5oXSfFG0RrIpEZViJyGKD4BIHNCWqhiVXgYqqlOKV2BHflx+ejPZXqJkEo7jgcGDAr+
	4b4p8YYBjn20gMZyzcYd2ymhuGBn5P9z0naL3n12dEPQ==
X-Received: by 2002:a05:6a20:2443:b0:394:3001:8b59 with SMTP id adf61e73a8af0-39432412df1mr820541637.53.1770780721130;
        Tue, 10 Feb 2026 19:32:01 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197d63c9sm464856a12.20.2026.02.10.19.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 19:32:00 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: bhelgaas@google.com,
	lukas@wunner.de,
	rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: alex.gaynor@gmail.com,
	benno.lossin@proton.me,
	boqun.feng@gmail.com,
	a.hindborg@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	tmgross@umich.edu,
	alistair23@gmail.com,
	ojeda@kernel.org,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	Alistair Francis <alistair@alistair23.me>
Subject: [RFC v3 19/27] PCI/CMA: Support built in X.509 certificates
Date: Wed, 11 Feb 2026 13:29:26 +1000
Message-ID: <20260211032935.2705841-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260211032935.2705841-1-alistair.francis@wdc.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair@alistair23.me>

Support building the X.509 certificates into the CMA certificate store.
This allows certificates to be built into the kernel which can be used
to authenticate PCIe devices via SPDM.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 certs/system_keyring.c        |  4 ----
 drivers/pci/cma.c             | 28 ++++++++++++++++++++++++++++
 include/keys/system_keyring.h |  4 ++++
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index f3d8ea4f70b4..adfc24139133 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -28,10 +28,6 @@ static struct key *machine_trusted_keys;
 static struct key *platform_trusted_keys;
 #endif
 
-extern __initconst const u8 system_certificate_list[];
-extern __initconst const unsigned long system_certificate_list_size;
-extern __initconst const unsigned long module_cert_size;
-
 /**
  * restrict_link_by_builtin_trusted - Restrict keyring addition by built-in CA
  * @dest_keyring: Keyring being linked to.
diff --git a/drivers/pci/cma.c b/drivers/pci/cma.c
index f2c435b04b92..8d64008594e2 100644
--- a/drivers/pci/cma.c
+++ b/drivers/pci/cma.c
@@ -10,6 +10,7 @@
 
 #define dev_fmt(fmt) "CMA: " fmt
 
+#include <keys/system_keyring.h>
 #include <keys/x509-parser.h>
 #include <linux/asn1_decoder.h>
 #include <linux/oid_registry.h>
@@ -218,8 +219,31 @@ void pci_cma_destroy(struct pci_dev *pdev)
 	spdm_destroy(pdev->spdm_state);
 }
 
+/*
+ * Load the compiled-in list of X.509 certificates.
+ */
+static int load_system_certificate_list(void)
+{
+	const u8 *p;
+	unsigned long size;
+
+	pr_notice("Loading compiled-in X.509 certificates for CMA\n");
+
+#ifdef CONFIG_MODULE_SIG
+	p = system_certificate_list;
+	size = system_certificate_list_size;
+#else
+	p = system_certificate_list + module_cert_size;
+	size = system_certificate_list_size - module_cert_size;
+#endif
+
+	return x509_load_certificate_list(p, size, pci_cma_keyring);
+}
+
 __init static int pci_cma_keyring_init(void)
 {
+	int rc;
+
 	pci_cma_keyring = keyring_alloc(".cma", KUIDT_INIT(0), KGIDT_INIT(0),
 					current_cred(),
 					(KEY_POS_ALL & ~KEY_POS_SETATTR) |
@@ -232,6 +256,10 @@ __init static int pci_cma_keyring_init(void)
 		return PTR_ERR(pci_cma_keyring);
 	}
 
+	rc = load_system_certificate_list();
+	if (rc)
+		return rc;
+
 	return 0;
 }
 arch_initcall(pci_cma_keyring_init);
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index a6c2897bcc63..35a33412e175 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -130,4 +130,8 @@ static inline void set_platform_trusted_keys(struct key *keyring)
 }
 #endif
 
+extern __initconst const u8 system_certificate_list[];
+extern __initconst const unsigned long system_certificate_list_size;
+extern __initconst const unsigned long module_cert_size;
+
 #endif /* _KEYS_SYSTEM_KEYRING_H */
-- 
2.52.0

