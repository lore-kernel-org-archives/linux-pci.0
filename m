Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D893976A9
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 01:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788224705; cv=none; b=RnlvnKQgiPpfJKr+ee/wX2ZuggSy4YmGlMEnlwLJigsXAq3V84A45S+nMpbjAqDVh5jhLqZxT0E9kykrm4frmFkUxCmcM9Epdx1+15rz6YEZ0KaCmsHijQPugtXXqDDrIvDCgfYVMhJNs36LT6gga+GZVUUnvGfqsSl7D7J0C/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788224705; c=relaxed/simple;
	bh=7H9GI30AsWmAlTdg30uohie4gLRcANCA6UmHmEupp3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GuwigwIR41xN4Gr08SQARvyCWKj1n3J59KS1ph12svtAd7Y2ntsRf2ACcIVj7JwLWmTuDmL6Nct/uBFKr/Eobsmds7xzAB52uW7+fFqTmJ8G17QnzrDdQ6M1WbaFBXaEFhg11fCMzG0EXnUJ5vcPHhjfXPNyq0pQCgl7vWZzjE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+YQ2TYC; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+YQ2TYC"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso272088a12.2
        for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 18:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788224702; x=1788829502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jWbFM6ywa1yjj692OE0MrLQnEnm7JyCgqunSYul2orw=;
        b=d+YQ2TYCuKChwoPQfL5IsXw8KZDWudgQ5nl55KRLhDWcU/gJC7uZKUR3Rsa/hvrFIu
         1zjw7xN2aiWcDdflQlzlDhDMg77O2eY3YssOVRaf2XiZtm5rediRfOrjYTmzSJdEpWTP
         Etuy2TgNIKbTKKGOWNpne0L+sq8ENRQYtdnHtwvhCBmxZg6KB9F4g4A7X1n4M+PJpz9Y
         ILDCryRfLkRlNnRi8i7BYNjxR/d4/TkjfRKcXgwPLCXMbRaU/8yJHZzS4/uOnjuup5va
         Ww4MNUHPwhYNpt1U3+/xZ5Ou4r0FnLhO2m7lDhhLye1J9nQ4GWB69Gk2gc+HtyXqHFD8
         uxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788224702; x=1788829502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jWbFM6ywa1yjj692OE0MrLQnEnm7JyCgqunSYul2orw=;
        b=lmjuVThQ/xs9CUL/ATgXU1lKUEgJsNV2juHyHaCGabhtuODhWDoJzmhvyw4Bfcw+5q
         rH2Kw/OagVkfWDV7aXXxoyqV8RQ2WGkULtTNClBXCwTjG7I+zrFq2H2lV8ch7kpA/JCD
         ymmTmB1bshYQWt3aApGZsk3qsVB34nx9/YiqiFbWVLCalgc8l4+T1YKsRb7J47iIcsjn
         kSAUiMLQ6oI+udvFi3NwjQoz/7uFDt6P6vSl2xmzLrhgOSlDQNarg3IzDAOQYZndOVPA
         0paN5AwfUDJsNDbRfIqalGhKaBejQapGlqlPyUMqPHQrRpmEa9RSRDaCsiXfM1cXsrAc
         fLSg==
X-Gm-Message-State: AFuF++nqjnaDO47hZTl/CsHGgvN3Y47xh0tFdxUaX/1qleEPN2kZih/M
	mRrmT4hEcdj6XeCGTaptOdNBIzow128+sgEyFqaOZqF9OqhkKHT+KYTl2Ry6VQ==
X-Gm-Gg: AYBFou3eMoTpdiYNJg6cQPyqJtFEJ1XzUT2St0OI/6W9HtDru4tynTtIPt18+JxkslU
	eRJp/f5m+3HOhi+Fm1QO/a9QF3cUe4GWFOZd+8JMD5MeEEqM5uTdjekk3kH98cEy/FTApX4PMGP
	FqLOQbm5dDtZ+KJnz5CbqauwQrmse1HL9PDZBFqFHgoX26UwTtXLOJHnCbOrrcEXFc0f5mhcz0A
	uVWH7RcyCKDwSwoPt0Q1ejUUIydTG4cQSEHyy0c7WClB5ytGmZtmChPYNrAaUd0mmsRX74SCdIb
	wjkdnzkrCU8W14GLUf80ECsYdU41gcU3JAO4STdOHMXOs5KDJ1g9224Y2RsO0yzKskfWjJ0Jxq/
	L4dsh7fW1mnm4ekmleoiqOOD2y/yeaju7yx51wZgrSV2ZttVegO5Z/BvcE/dl+C7n2uZBEffHBh
	LkB2+s3MxgkZ7DL14s81HXBFncUg/Kn3f3XUPBP2FmXNTiBAL/foJhuOfZA5zBj/7anHOpURG0r
	eOCqw==
X-Received: by 2002:a17:90b:164b:b0:38e:6a44:671b with SMTP id 98e67ed59e1d1-396d0c79e8amr44052502a91.0.1788224702403;
        Mon, 31 Aug 2026 18:05:02 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d49e9e0sm2372024a91.11.2026.08.31.18.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:05:01 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	djbw@kernel.org,
	rust-for-linux@vger.kernel.org,
	lukas@wunner.de,
	alistair@alistair23.me,
	jic23@kernel.org,
	linux-cxl@vger.kernel.org,
	bhelgaas@google.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Cc: gary@garyguo.net,
	ojeda@kernel.org,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	wilfred.mallawa@wdc.com,
	tmgross@umich.edu,
	alistair23@gmail.com,
	boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 07/21] rust: add bindings for hash.h
Date: Tue,  1 Sep 2026 11:03:33 +1000
Message-ID: <20260901010347.2614656-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901010347.2614656-1-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

Make the functions crypto_shash_descsize(), crypto_shash_digestsize()
and crypto_free_shash() available to Rust.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/hash.c             | 18 ++++++++++++++++++
 rust/helpers/helpers.c          |  1 +
 3 files changed, 20 insertions(+)
 create mode 100644 rust/helpers/hash.c

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 4b31aa7f432f..fd223b6c5aaf 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -30,6 +30,7 @@
 
 #include <linux/acpi.h>
 #include <linux/gpu_buddy.h>
+#include <crypto/hash.h>
 #include <drm/drm_device.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_file.h>
diff --git a/rust/helpers/hash.c b/rust/helpers/hash.c
new file mode 100644
index 000000000000..23a63618a370
--- /dev/null
+++ b/rust/helpers/hash.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <crypto/hash.h>
+
+__rust_helper unsigned int rust_helper_crypto_shash_descsize(struct crypto_shash *tfm)
+{
+	return crypto_shash_descsize(tfm);
+}
+
+__rust_helper unsigned int rust_helper_crypto_shash_digestsize(struct crypto_shash *tfm)
+{
+	return crypto_shash_digestsize(tfm);
+}
+
+__rust_helper void rust_helper_crypto_free_shash(struct crypto_shash *tfm)
+{
+	crypto_free_shash(tfm);
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 440fb7638e3c..09ec69f736b1 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -66,6 +66,7 @@
 #include "fs.c"
 #include "fwctl.c"
 #include "gpu.c"
+#include "hash.c"
 #include "interrupt.c"
 #include "io.c"
 #include "irq.c"
-- 
2.55.0

