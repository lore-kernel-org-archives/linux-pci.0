Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8AF346792
	for <linux-pci@vger.kernel.org>; Wed, 11 Feb 2026 03:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770780772; cv=none; b=KVYYGngfiCOjf3l3w+F2WZ2KNxXCbhJIARc3LMZqlOiiscc1FZLYpeaKeXTnWQwZ1HVdolNvi97V5HhPTd8OF5IHh42BVQ/JTLnzUjxutt0rsk+pLB2bFkcLV5d8OjnwhLwGuTUC2wpq27/9Iyi2SBDRftRgw7uRd5mcjOtugGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770780772; c=relaxed/simple;
	bh=vSBHsAMqmP0mTWh5XLC6s4jgQYugzTdX4cOLY716pds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qa+oWy0tPH4i0TOnq3xHjtXMx88uiZIKOSbnPCnSjfhLxW/38NRBHYvUZ7Yl8L/QsBbzRu24dy40H6ha+4V5AE0R8kI2cSEka0uxNtLkm+0t6mx/uo+yDDtuLF/6LMWgga2QkqephrmkA4abK1alxxcxL3/f4S7T6fMQXEGEzqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zox2dZZa; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zox2dZZa"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-81e8a9d521dso3048145b3a.2
        for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 19:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770780770; x=1771385570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dF6bX/QVONfWDQrBCiwnvcbeLdCbDl1IQ4EC8a9rjVk=;
        b=Zox2dZZaeOEmRU3KE/QgDrV8zctrDPtHoKmPoXeYbu8I+pDBVaZ2Rwjsxmlcm4JNmQ
         33Lm13+sbsQ940Ul/9B3K5eilSYAz5awblnZHWIeIP+SDidJ9NWUB8I+geJmpdXmuEpX
         CD7517TXo/+KS9H9Zs5vKiUWvR3V0NjdWBYbI/Qf3JSVdoTK9/EXIgxtR688mxpssVOq
         mcgl8FLgt4A2vcz5oN17PIYVv/3tFCu0d3EM+FVdFcDGmjXAW3IVKRuzt0c53RFydqFA
         91nMutKIqVSASx/S0ku4ISfmrSxa3gmYFD2wReracFk62e89Meuhdd9YYtV/aJzOt6CN
         lFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770780770; x=1771385570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dF6bX/QVONfWDQrBCiwnvcbeLdCbDl1IQ4EC8a9rjVk=;
        b=waeDp3RAAaQTmN+oYNw4F1UxmEO9YWBHMci1hFH6x1XgCQndb9Zkf9mGyOXtgP6rag
         eOoUEZRLnVvUbiCP+Ep4lCP2CHvDeP+YACSyObtAhpPgdKf/MmyerFYs4haaClVOZKPI
         T7vnZegycgIOHyNEoVrgWb/ZVHuEZkCVLvhhip35HlTnL8AHTID66iKP1ZOrNRlYTaUG
         GTtwg1efw6XCgmlKcnWXaBSRD5oCvigzvp8wWkujF84Rh6XZr3dy/3EIJiabJqY603+l
         4O96Q/utvpOKYmoq2YDciT15nukqr6Gjs7VEmX6sqB4w1WpIFR/TYYEkUbdElp8PsplJ
         GJLg==
X-Forwarded-Encrypted: i=1; AJvYcCU7usC0ShcldmZbNFnwIaJmzGvdo8rOfNq/HT2OX8E2VAvjSAZJwDqhqS2tLZ00DbgJm1XWBAemK18=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQvl02kSug3pJpJZc2tXhfN4cgGegBoL+xtcHAK/DqEFKvd2qD
	0waggoD5JdyKH4by+g9n9g8mQEhmfye2ExB3wdkGzL09ZW3LaRvc50kE
X-Gm-Gg: AZuq6aJUrLF2RYLnFCdKBJg9LRGqJUw1tZz7c9Qx4IGS6K7+r02x7NMRZqAqQRstVab
	KRN2Eu5Dzhj6h3NVEkD4q8b1d2mJKJ3fRvLKBRKTuHZdzLKf1SzO1+5cYrQGgJ+oN1lnrmtu1S3
	zC5Bt+P0fuKbG+3FchWAwvbut1jhasx6WgtJ8nnY3GeA/KzgL4bmHF1e0XSP1TPjNhoKdfQzys4
	t/jWPxcXB/WqJ8chE7dx9IWRJWhrfccLj6DkyxR3rKHTjH/Gmh2EgHsgPvtMobOsQLsHOb+n7iX
	VpnjgrPyDE0Amgo++0qfpyYuUFQ1rJ6CZfg9jhsKcyGmrGlLoZOTee6iETNAaozi6Dpov8FVm1Z
	OddWbYDVuCXhX3nVtyccQ8rCGyo204P5bo0zx3lZF7Rt6IRYYJZgGPBNQgLLpxccWNWw/WOPn7S
	RyXo3Wi8QKVFoaYqdEcPHnaThIJiL6Qf8bDqs7D4J8YQ==
X-Received: by 2002:a05:6a20:9f86:b0:35d:d477:a7d6 with SMTP id adf61e73a8af0-3942e35f73cmr1201854637.13.1770780770454;
        Tue, 10 Feb 2026 19:32:50 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197d63c9sm464856a12.20.2026.02.10.19.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 19:32:49 -0800 (PST)
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
	Alistair Francis <alistair.francis@wdc.com>
Subject: [RFC v3 26/27] rust: add bindings for hash_info
Date: Wed, 11 Feb 2026 13:29:33 +1000
Message-ID: <20260211032935.2705841-27-alistair.francis@wdc.com>
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

From: Alistair Francis <alistair.francis@wdc.com>

C code can get the hash_digest_size by indexing into the global
hash_digest_size array. We can't do that in the Rust code, so let's add
a Rust helper function to allow us to get the hash_digest_size.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/helpers/hash_info.c | 8 ++++++++
 rust/helpers/helpers.c   | 1 +
 2 files changed, 9 insertions(+)
 create mode 100644 rust/helpers/hash_info.c

diff --git a/rust/helpers/hash_info.c b/rust/helpers/hash_info.c
new file mode 100644
index 000000000000..d2cbc08b57d1
--- /dev/null
+++ b/rust/helpers/hash_info.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <crypto/hash_info.h>
+
+int rust_helper_get_hash_digest_size(uint32_t offset)
+{
+	return hash_digest_size[offset];
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 4b08b4f1d3a3..34db9eb5e43e 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -31,6 +31,7 @@
 #include "drm.c"
 #include "err.c"
 #include "hash.c"
+#include "hash_info.c"
 #include "irq.c"
 #include "fs.c"
 #include "io.c"
-- 
2.52.0

