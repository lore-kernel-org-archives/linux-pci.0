Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078800;
	b=Vqw2T0SZWQoZWgqdUKTA64Z+sg+LMlKhX0gYGqT7Pi5yKcpAmJQMd1/mkkuqkf4+wh3E
	 6kE8rsRTP5eRnr2Lwc83RDENsY0WH5mpj8FCoTKQWQ/0xDWUsUyLocmY/36s+t8zA2Zki
	 Y3h/4a7cnoD1hgVQrwOlbM7l7QbuRJbtIt1uCvwdtUaaEi8x+YgwnzRCtWoID6anhFxsz
	 8zVIXe40eqx2ALGjGpGC4xlZsslaSY33qb14g+JOP/s1Yp4R4wXQdYaeS6HmEA4WDr4l5
	 9W8kzbcet+AxZGReWb/Xp9Kq70yOPwuoR4hWA+7Admtg8RXNhR/oRzuMXsEQAORqAfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078800;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0x6mTxkP4nBs1deJf2I2SUu12QHLK1lhJg3onPx8YVk=;
	b=NYAOBZ/nW7BNNt7BlBs9iqsFaUjG/1aipFAjLl5ZIR6gPzCcTjfby2eqsWbTdYgXjm+1
	 L6ZYVucqCj9TFspHcffW17Sc7HjUjdmKR2EElDJq3gKG9CsAwma8y1T08v6J+Bhl8tUiF
	 d2lK41eB2qwqavugqugEoRFfcKQRW8kouhcVK6PXLSaUoeeH5wgDkIvN3a+OR/GXsYWl0
	 /PuCEFYvPiw44NcJBx4guZ+pImDJ+rptZ/5JOxM4hrTfji6RjFJoqzIpkrJBKYHraG5ju
	 8noBhYKpl0dITOmCWuJ/4JKEMcgSxtNddaRAqGhiBy2yvG3AGZdu7IWpckhJOm7Gapw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Ghwts+3/";
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10BC606A320
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 05:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C10BC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ghwts+3/
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e9cf928dc9so2588895ad.0
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 22:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793078799; x=1793683599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0x6mTxkP4nBs1deJf2I2SUu12QHLK1lhJg3onPx8YVk=;
        b=Ghwts+3/hrGnnAzwWpysKTB0hd2asbwn/FondnpQC/sUw0xIjOVjhFF0wm2h4+l9gp
         sPRtbxsmY/EyoJkhZl1vLxdsnp0D8G0TMs2AFYXw5ecowDoGCO5LphDoFPKGwGrNq103
         pFBFIoKYQgOQy7lbkYEPy3zS+4TzoeMU9Y1KKn/yro9QDnvolQV2aJQ6W5gexYqglT2o
         58tX26UzbtduhhMjUBofOx/nRAOsSCtFyMhOk/m47o1Ddgb9e7JgJuck3DDpNs+311iD
         uITJl0bAiZRyUun61ZziSK9euut3tVMF52n2IITtzTEV5lIHjff16P2x13v775iQxx3p
         OcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078799; x=1793683599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0x6mTxkP4nBs1deJf2I2SUu12QHLK1lhJg3onPx8YVk=;
        b=OpjFHlwhaXPaChZFKfFfPI030zwJb9sMXPC6kKSyOYkS/GSPmAM3qtyndAHjPYyKEZ
         6+qWKqU93YHzR2bMTPAblXoblIpxuWpjciY5Ufb3R1qcsQsOSpRGTLbjm9+jnabg4xb2
         jmtsppks9Q/J5IvY6YqXqoiaINTioy8iqnvJJJmRa+Rln6Cxg2mQKAjhsly7mBqSEIRv
         w51t4EHIR2Vl/uiffoJTcblc3cV67xmxoc0rr94im5HrwZnFVq0Mi+xix1bJRRSgOotQ
         iUwkcr38p4Rwmf9KgjvuCKPP+R70Ennui9Zz+Psh7wN2BgZn/IySVfHYfsSEg8lLwB/w
         9tYQ==
X-Forwarded-Encrypted: i=1; AKwUvBzsdsTfDDl2zUwG6vz/yH2rXGb/3uT3PNBZpJiMhk2q4j0+ZoixZBAEC89PFx3oXnH64UeCR4L6k/s=@vger.kernel.org
X-Gm-Message-State: AFq9FYLPM7DYBktFdZY5pub7i4sU99fWoKveVwJQcU3fPl5XtLWuNS3m
	zS8pBFP/XzIJv9reQj8xanbhVgkWlEGbOSNelJgOEve5BGotChGdGztv
X-Gm-Gg: AYBFou2sOpRKHr9dzVyLTIcmXuyX9xMImYhQP0iGwjl+OEZR/n8gjCv6JDMCLQRnP5X
	1TAiJ6khX0CHcLm6zYBUjaCHjRcjCz/i5kQvuIYmMHnfOC8gh9eBoKsKtugQKvWeB0tJEiZyos7
	/gErqsnZfuUB1WqElhW2Y85607r5fsoDjUdUc6NvXPCVBwuuLakeYqEdLdAdhZOUdOSmKUgKUkl
	B7VP1MQ8jjFcLPK66v4y2eY/XJPoc00KatBgPuELispo6jqeMYuA82ImPoMLRpCaECWn73usl4H
	8PAnlr/gWppzYuBMfZVjD+SV0OiWmAXnRAURGrKv86+unGsOGuHSQLmgxAIaXO9TwGZ+vvxa6id
	rZKf5TR+O6kKcjL/kMOsWsrS4MLY9ZvQTeftzwPx4fwCBiSxvprA9lQOe6lLmUxmaMHJt0Bp2PF
	tddWIxtCRfhLPbeUrJcwZke7OvLQBCJWpOBDzYNqEvtv5uDkngPrvuTBG99dwA3zvQKEyuzoxA0
	NtD0L9A8e0ZKsFkjAIls9vhV1c6Ge11zVf3270UlvJLhKNBY+gGIMEZG/bemwnTY9zz6BOjkNeX
	O6hq/u/BsQHLYJZfi88=
X-Received: by 2002:a17:902:e946:b0:2ea:dee6:d672 with SMTP id d9443c01a7336-2eae3ed93b0mr9549575ad.19.1793078799174;
        Mon, 26 Oct 2026 22:26:39 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9757bsm3307715ad.58.2026.10.26.22.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:26:38 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: akpm@linux-foundation.org,
	bhelgaas@google.com,
	lukas@wunner.de,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	alistair@alistair23.me,
	rust-for-linux@vger.kernel.org,
	jic23@kernel.org
Cc: ojeda@kernel.org,
	aliceryhl@google.com,
	a.hindborg@kernel.org,
	alistair23@gmail.com,
	wilfred.mallawa@wdc.com,
	bjorn3_gh@protonmail.com,
	gregkh@linuxfoundation.org,
	boqun.feng@gmail.com,
	benno.lossin@proton.me,
	gary@garyguo.net,
	tmgross@umich.edu,
	alex.gaynor@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 07/23] rust: add bindings for hash.h
Date: Tue, 27 Oct 2026 15:25:20 +1000
Message-ID: <20261027052536.1722081-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027052536.1722081-1-alistair.francis@wdc.com>
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
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

From: Alistair Francis <alistair.francis@wdc.com>

Make the functions crypto_shash_descsize(), crypto_shash_digestsize()
and crypto_free_shash() available to Rust.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/hash.c             | 22 ++++++++++++++++++++++
 rust/helpers/helpers.c          |  1 +
 3 files changed, 24 insertions(+)
 create mode 100644 rust/helpers/hash.c

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 3791af0aadc73..4992bc3194e7e 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -28,6 +28,7 @@
  */
 #include <linux/hrtimer_types.h>
 
+#include <crypto/hash.h>
 #include <linux/acpi.h>
 #include <linux/gpu_buddy.h>
 #include <drm/drm_device.h>
diff --git a/rust/helpers/hash.c b/rust/helpers/hash.c
new file mode 100644
index 0000000000000..0d88752084673
--- /dev/null
+++ b/rust/helpers/hash.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <crypto/hash.h>
+
+#ifdef CONFIG_CRYPTO
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
+
+#endif /* CONFIG_CRYPTO */
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index d62c7be1ca7bd..0dcdad905f0ef 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -67,6 +67,7 @@
 #include "fs.c"
 #include "fwctl.c"
 #include "gpu.c"
+#include "hash.c"
 #include "interrupt.c"
 #include "io.c"
 #include "irq.c"
-- 
2.56.0

