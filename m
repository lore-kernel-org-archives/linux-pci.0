Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CC2330315
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 04:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782190520; cv=none; b=BQzQHn5N9iP5CT+pc2Gn15H/Xs1dJ3ndRLuwRfoyL3wrfYyNTb2ay6Nb6bS6QeDZQRbl2hQPpIbSVpEFUaSKnraRMndhLnPx5HdtGYdRmjlPHLSvBupA/75w/4j4MEIp3I2PMIcuT81Y9EEJMepp7bnD5przslE/bSwnUtN7ISA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782190520; c=relaxed/simple;
	bh=UhN/SYjFF74IiXuce+RokyZK21jFAxj7CCJGM8/sKkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YxEPrSxeJGoznnEO5QsyxERD/aZ806s0GrdzAVqzv2b9XF8K/RI0c5BFeNjOkhWjEoVEOVH0jIaNXlJospfSBTByjh4f/FoUIM3cd06UEVavtDXlkxxzN4+tSWyJlJcPHh71jyDwn5TdPiD1wR5hsQe8rCa22srw8hVF3Ph3gRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abSQilYA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abSQilYA"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c6bdb8a8bdso26649005ad.1
        for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 21:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782190518; x=1782795318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yp78ZZXGgyZ3PuT2aDR8qxzXozttahBrxUZ5/W47was=;
        b=abSQilYATLydMuXjRLE61FfYdjFE6PRWWKGaTGwlDWfk/XNhoynHVvp0TW23fsiD58
         5QjIC8yMsSQXpeHnDrF1+mqMI8s/y0Zt7Illz/nmpQCvyd0w+NBYKv5CZIoR6zhcmC+5
         oRaDHzqOF5MBheo+cCejYyZ8690S+32RArClppZhmRc0pmdRkSPBFUb37LWs1IwBC/4E
         hqgQlgSJa0OQ1gAhwmKoVCVxMaV113WPzl1PGvEKWMeTpuQ6kk9o2bqnZ3954VyNQOUh
         Kgtowxcc5V9XmKuBW58s9QAieDEv/ecxptvRkiuU2ETQ8kxbyDav8mMtZjCphjlVqMTx
         /RiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782190518; x=1782795318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yp78ZZXGgyZ3PuT2aDR8qxzXozttahBrxUZ5/W47was=;
        b=fMdKAFzm3C5OE29GVA9vliUdpCb06IDCzZE//WJIaHlFWB0xDwwxDHyk5Nm/0dp0Av
         1N1BfYQtFwiPfilKyQos7jlZAwLedr3MSMjDl8JsOk6MQcuqKCDMY71Knym2w55IEwoU
         BDScbPqy9v/n1rWhEU/eHUkzBfjEvVSBAHGo5OJCClCRHHXDcBuf0jwt8X8Lfkva6tx2
         T6c6nAHo37tW61JBQLWIkQ/faJ61ZEjDX0Ww3j1Dwm7TuR1O8P7FP1jblTOtKJe9DWcV
         k1Ao7pMX5oxleiCs8aBegCBheZMCQoAqx/ACHRktO44sHLpxdEkcs6JFV0PO7Rx4VFcp
         /RBA==
X-Forwarded-Encrypted: i=1; AHgh+RqcV1dSZ/d8ax8iVpdryu+kKROnQ1U7qUbclJd6ZdZ3HGbicJnmZSMV0mlwclXTSq0CAcCXP+VXwUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjjCaK1fuBLjIPNdeDXQTEVQ0XJ6Qu9m1eOc/91mMMRZ6SBs8l
	fsyKwvazM5u0UYsg2NVDVsmGGmxqy2/fofBV4afmRXlSyoakns8wF/+F
X-Gm-Gg: AfdE7clnXGIYYcXYk27dPmvDxZSKC6hXCiaWp1/DsFTZBuQgOEMpChQrMVMwMFVuL0a
	CNruV4B89R3js6AMwLZKP/b2P4WP/KdX5cQV4+vGY+Bzpm5wqLj2055fASAq7slYx2DkUv4qVIb
	Ypoz/ggPzeX2FkCY+2SG3EnjTX+SyUCtCD7J2c0C+U40jx+ycC9kOWYVxaC3w04hubu6l5OqSrE
	Z8X/HrxsFxYH+6xVe8DTlA9C+XwH7z07S3+52ANHUDQ1KL4iCozOwyQDixpobZzQiIuPHnqTKRo
	FwXmga61fMnG7bgl3Q5FhYdMu8UPSfJ0sY2U9641S/8/WWKwgJA07xQK49ZAk8EK3iGTz3RMyQh
	OUfLnLweL23KclhgnTrpMqsiP9TndQHW6efNqY/XUczaxwz6lctF5WV1L2iO0YLrhko+0Wh534z
	rY05ejeqkETw2Qv3oZP7binpVU8Qc5HQ==
X-Received: by 2002:a17:902:ce86:b0:2c1:69cb:4423 with SMTP id d9443c01a7336-2c7c75d9c76mr16144825ad.14.1782190517684;
        Mon, 22 Jun 2026 21:55:17 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8cf0sm89734785ad.50.2026.06.22.21.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 21:55:17 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: akpm@linux-foundation.org,
	rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	jic23@kernel.org,
	bhelgaas@google.com,
	lukas@wunner.de,
	alistair@alistair23.me,
	linux-cxl@vger.kernel.org,
	djbw@kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan.Cameron@huawei.com
Cc: alistair23@gmail.com,
	boqun.feng@gmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	bjorn3_gh@protonmail.com,
	gary@garyguo.net,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	tmgross@umich.edu,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 07/21] rust: add bindings for hash.h
Date: Tue, 23 Jun 2026 14:53:52 +1000
Message-ID: <20260623045406.2589547-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623045406.2589547-1-alistair.francis@wdc.com>
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
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
index 1124785e210b..1cce0176e4b5 100644
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
index 998e31052e66..ca2884f6446e 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -62,6 +62,7 @@
 #include "drm.c"
 #include "drm_gpuvm.c"
 #include "err.c"
+#include "hash.c"
 #include "irq.c"
 #include "fs.c"
 #include "gpu.c"
-- 
2.54.0

