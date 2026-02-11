Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF89344D8B
	for <linux-pci@vger.kernel.org>; Wed, 11 Feb 2026 03:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770780716; cv=none; b=IumeY/7BtqdECOTl+6tEU1Up50SpS695qNWJYeoqN1rujycP2vsS117RHX1ZdbUpwwPAjPubgZezXXsRz094ca45n230qFvQlM8OtmnKvL5O1k7DZ0ojGLBtuDJPw5XP/nUJ74x7/ygV/eDUIM298BDC+DnCsnxIdbHTRfnMEas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770780716; c=relaxed/simple;
	bh=KNLtsCq5Xccubow9+9/OB82GtlxnV14UrMdv6HEW9qY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wp64gtrtS74FDtiUEy2EHuQ8FsYFhrLHQHxAHxtTsl1Qwfzmcqg5uIjgriD8Uc20qIy4V0dRZv9NdFOJj6a4rkcz3AgwPpcEwYjeFc7ix2kdxFMfQzfzYzX+ae/FTE+6lvHkKc8FEKcKspSyQN7rf4a5q3nXOHkMWt5F2qXgQtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPQj/TJg; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPQj/TJg"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c6dcdc955a1so1774909a12.2
        for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 19:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770780714; x=1771385514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5JPAdrKU7Ml6bcvlYeqQgOx8uh8kBG9Pa/UFqehRTk=;
        b=IPQj/TJgDXvdp9r6uulaZ9dh6nW9RJgW0rXU02yDqejExTrF6hA24AgQVkMucTf0ro
         dDk2Wyf3auC0wr2EmgpbbVGk/uPvJLUyPRYF/MrnAFUwClvDjYCAtt0LAkonm2L75RD7
         8mZJcm/a36We7KySCUIezcJwpoBNU1jiLt6+Ly7V9+eWdlX6Cj+duGMKnltIwC6mFtdN
         QOFZcX7+6azOuTgqlpBnP8mtb4T3XlN+PoYiEQ+Ok8XmrBmzXC8qncF27AVuZquM8a/e
         H+gByshmd1Dh+pYC1YDA2+RnJ0n8Eyg/nqTfDhAxCKiQF/rwMSvjtenNaIXp5iIKKCLD
         k5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770780714; x=1771385514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M5JPAdrKU7Ml6bcvlYeqQgOx8uh8kBG9Pa/UFqehRTk=;
        b=mYbGviP5IUTFU63SLTOu6oy+AqyvjmNmfHOb+IH8RSrNAMxtH8yOuaD3Gb10XnN8xw
         ODm06PLJL1fUqjHes+zrRcAY0cgVbxaS1UmczEK8mWqAPWKAaJ6/GtwEwrEtJg6zeBIw
         3Vmio7KkzJuuB+cIKjkEFihcd1mGQEbpXXjXvS8MwIp7Zn9a09UChyaPtAsL8kIyolYE
         zqNUBKAQBE+5T0oH0iyX/FFSLemelmojoFKjTU0J1/6jtFLu5BxKPe/UV5MHG6Rpyg5A
         aKp15ljsS7kJy62v2CtwMA4kd9X4a18RnGKrhm80xHxJ8t+AICV9tB3dA+WSaWtdK46L
         Szdw==
X-Forwarded-Encrypted: i=1; AJvYcCVAZY5UgVIPE/xMBwnV29S2hT8mfip+zNIePZuDUaEtK02GHL7zwZElyasyqclZLiAF+W6q8sdgPWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsx48uPqXaX6YJ+u8ibj5BdFZzyPZcnskhaWZ96hJDLpBqBBl/
	otT0wIEWcdjVTFioD6WpO+ivp/gWySC2moOxBkybqsvWSrzsGxE1L5MxAv7UkjIEqdk=
X-Gm-Gg: AZuq6aKlXoO5tXnIbqw8GsBoCxc7qKtr67x58JMd8hTsqHNAVRsIFXSIrAFlZ+EENU9
	/iX6vZQBsU9r8uspH+O+mPjM1irRquBrltPRGpmvmZUkGLmujznw+urBkwgzRsFjJwjl2D9Qtc6
	G/wwXHdtv2xDLg8q2dK/Nbbi+qoCwHIs4M/i4HFo5CfVydmlBb9u7K9zTY0FfUw8JoIdF2VEE4P
	PmOvhaieo4BhavQ6M0Ntt24Z6KhYaBMMUTovCkuP/GXi92kZwE7ASt4BHreptmRgxeDgFmQpTvW
	m4CxIrMBGc3A2yLXkneS06cfGq9V5l/DcM7zy2QRr2aLxlghgtKmEqKhKiNqetnFIb+RblrPI7M
	nxZJmMzS95021zUruIBI1kvKezkXLh/fbsbYhPSdMH7OyIa84I0OS5lwWuGvcpeRatENYRTbcOF
	HwkCzb6t76ERggrnX3zBInV5wnhWnRcLL60i+k6Hd3VQ==
X-Received: by 2002:a05:6a21:2d42:b0:38d:ef23:12cf with SMTP id adf61e73a8af0-3943243dba2mr720441637.61.1770780714136;
        Tue, 10 Feb 2026 19:31:54 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197d63c9sm464856a12.20.2026.02.10.19.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 19:31:53 -0800 (PST)
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
Subject: [RFC v3 18/27] KEYS: Load keyring and certificates early in boot
Date: Wed, 11 Feb 2026 13:29:25 +1000
Message-ID: <20260211032935.2705841-19-alistair.francis@wdc.com>
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

Work is ongoing to support PCIe device attestation and authentication.
As part of this a PCIe device will provide a certificate chain via the
SPDM protocol to the kernel.

Linux should verify the chain before enabling the device, which means we
need the certificate store ready before arch initilisation (where PCIe
init happens). Move the certificate and keyring init to postcore to
ensure it's loaded before PCIe devices.

This allows us to verify the certificate chain provided by a PCIe device
via SPDM before we enable it.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 certs/system_keyring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 9de610bf1f4b..f3d8ea4f70b4 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -260,7 +260,7 @@ static __init int system_trusted_keyring_init(void)
 /*
  * Must be initialised before we try and load the keys into the keyring.
  */
-device_initcall(system_trusted_keyring_init);
+postcore_initcall(system_trusted_keyring_init);
 
 __init int load_module_cert(struct key *keyring)
 {
@@ -293,7 +293,7 @@ static __init int load_system_certificate_list(void)
 
 	return x509_load_certificate_list(p, size, builtin_trusted_keys);
 }
-late_initcall(load_system_certificate_list);
+postcore_initcall(load_system_certificate_list);
 
 #ifdef CONFIG_SYSTEM_DATA_VERIFICATION
 
-- 
2.52.0

