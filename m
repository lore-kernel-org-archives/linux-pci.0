Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF395347BAF
	for <linux-pci@vger.kernel.org>; Wed, 11 Feb 2026 03:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770780730; cv=none; b=nMgwlFn0zB011XsW3BNQWDTvZ61K80vMn64Efq0SZ5dl6HKE+NB3gxUoIq2wxE1YqP6V8OUkCbydfZMOvsY3uqZnyb38jyFOIL+To2j7LDW6+TlQXhCjfBfHHDx6axSUK0c5u9oawQWYpR+Xsmb2Shu3qNKlhbi1bo3k4MBDSKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770780730; c=relaxed/simple;
	bh=BS4wcIwoXxB/BfRlgobZUgb7fvQ0v0BNsMCQMjGrn0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKKu/YXBiKEuV1ZW0ASpYTBuXGCGRj82mAhedSwnBMa4e5O70towIsGMoiyMMZCPYy55hWIYtP5YDK9ojJdUBEpsSRLbr04AUh5Fh4nKBUvtIeGYj10UXG8yJ085f7MiXxozsA/8diIcXNL2qmXOsJ8m/JuLZWjHoDorNtF3AUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jprI8o00; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jprI8o00"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-823210d1d8eso2691906b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 19:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770780728; x=1771385528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oi2wlCfDaGRwhyBd7+2iWudqGoJb/SncUXJkMt9402Q=;
        b=jprI8o00x/piRHbGbfv+vhlDiRy7bl8rTIZubxCtUkcFnIk0PG/z/o2Z6SN9QlNpC2
         AK2g1TctXDWK4gQwcA/UzFx7bzUCfzBj5JUa/Jb0MHCLfsMkUCf46ETIBRt4nH4dNSW0
         9NR1oAr6WzmsOpiyfFCLBikDE0qU0JgH2EGpuOR5DrK/hPjP5WhGzBvl/FJCpt75sF5H
         qeqGN02Skl204CHdm8ms/3H3msbpQhqQWfVZodl7V3/jTUB++ZhmnKmCiroIDWPa4esa
         34I0qfySLErFdOot3YpQ1ImNu4rKFzwMKxMoTNmT5Pexct15VusPiDax7O0hwVoaXLg2
         oKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770780728; x=1771385528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oi2wlCfDaGRwhyBd7+2iWudqGoJb/SncUXJkMt9402Q=;
        b=C4oTxIhl9X1C90Z+Ud9XXxEdQJML2dRYK/scilw13m8+WeYIDgtRQSS87Yj9UcuiV9
         FQw1stmKLHvdnoWhPiHO5mMSLz09dq4eFBFMRMYLmW3qPLyJBPIJjuCms8KaTsBRDhil
         dkT+Szrx6sNiKaLdRxDXNm0QPUHayBPFWofhqa3rHtigbz6yTeqVMdYUAhqnxJbzOSUb
         0q5nKDMMoCpewsph+b2738hESaCz5rEtjtoX8aBOYYWsyiFDgsZwP4k8LToC1PJUSG0M
         g7Do2Lr3LG5SjBSBvAgiztwuc5X8C2bysboO2U6Qi7sANmozd117/sxEiERTtj38OUt/
         YJng==
X-Forwarded-Encrypted: i=1; AJvYcCX3nXW0oolGdRseZQpVPP4UkE0CZGicLaaDbQ0MgcvuYTxA1q6qP0TN6xcIlWSL89aCAcPl4JyGNQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiFw0mucI+Spk1igDZP4zT7ZWvrYsmClZXwhRlB0MK5/m6LHnp
	ioiXKMXGp0XxZOculD+3Ddse/sDLBMwWLwawrJeEIN/IDlsc7+XYsMQ7
X-Gm-Gg: AZuq6aKlsA5NJCJOVmDYODeanEjeNIQ22D2F+YKRNLngNdQcYxZ9cw6jgJWqSQ3boKQ
	kpJ48wszwTb9l1QadfYOwYLpmFEsQ2g2RDfh4ZGQFeDEPoOq+uQ/f5BUIWxpquW+0cN0JErjagP
	+D/By9thi1JFsm0QVSR4IadajOPJXoF/T6ZvHv8VxkMz6XdfgPGzfz+OGwmDUhYkZaRgoCuh/Uh
	L/fihUuPQlNglfKgwVB7Dx6VgVcJC4Aj5QVXHWYwpWWC4QlqONJxhD0hp4gmlCTldbhNAgrSST8
	GEKNvLHkYHFKyYFidggfmdt0SaHE6lqV6UsIZLPKso2AcS5NUNKuyLAkPCiQ1j7sxh4kyhx1q62
	nDAlILfriInYLIASvqOiHOP2nPQwbVJrVCeYqjoj3uW86LSWw7Suirt3/3g+UALnx97s2nWG1oy
	I+cJYRjOn915aQxNSkiNx7MMjvQKBLvskFdffLB0MIPA==
X-Received: by 2002:a05:6a20:cfa9:b0:334:87c2:445 with SMTP id adf61e73a8af0-3942e3c472amr1397613637.36.1770780728067;
        Tue, 10 Feb 2026 19:32:08 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197d63c9sm464856a12.20.2026.02.10.19.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 19:32:07 -0800 (PST)
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
Subject: [RFC v3 20/27] crypto: sha: Load early in boot
Date: Wed, 11 Feb 2026 13:29:27 +1000
Message-ID: <20260211032935.2705841-21-alistair.francis@wdc.com>
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

Work is ongoing to support PCIe device attestation and authentication.
As part of this probing a PCIe device will require generating hashes via
the SPDM protocol to the kernel.

Linux should verify the device before enabling the device, which means we
need the crypto functions to be ready before arch initilisation (where PCIe
init happens). Move the crypto init to postcore to
ensure it's loaded before PCIe devices.

This allows us to verify the certificate chain provided by a PCIe device
via SPDM before we enable it.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 crypto/sha256.c | 2 +-
 crypto/sha3.c   | 2 +-
 crypto/sha512.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/crypto/sha256.c b/crypto/sha256.c
index fb81defe084c..0ebe96f89733 100644
--- a/crypto/sha256.c
+++ b/crypto/sha256.c
@@ -398,7 +398,7 @@ static int __init crypto_sha256_mod_init(void)
 {
 	return crypto_register_shashes(algs, ARRAY_SIZE(algs));
 }
-module_init(crypto_sha256_mod_init);
+postcore_initcall(crypto_sha256_mod_init);
 
 static void __exit crypto_sha256_mod_exit(void)
 {
diff --git a/crypto/sha3.c b/crypto/sha3.c
index 8f364979ec89..d37ce694b50a 100644
--- a/crypto/sha3.c
+++ b/crypto/sha3.c
@@ -145,7 +145,7 @@ static int __init crypto_sha3_mod_init(void)
 {
 	return crypto_register_shashes(algs, ARRAY_SIZE(algs));
 }
-module_init(crypto_sha3_mod_init);
+postcore_initcall(crypto_sha3_mod_init);
 
 static void __exit crypto_sha3_mod_exit(void)
 {
diff --git a/crypto/sha512.c b/crypto/sha512.c
index d320fe53913f..6effa6043b55 100644
--- a/crypto/sha512.c
+++ b/crypto/sha512.c
@@ -404,7 +404,7 @@ static int __init crypto_sha512_mod_init(void)
 {
 	return crypto_register_shashes(algs, ARRAY_SIZE(algs));
 }
-module_init(crypto_sha512_mod_init);
+postcore_initcall(crypto_sha512_mod_init);
 
 static void __exit crypto_sha512_mod_exit(void)
 {
-- 
2.52.0

