Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E3922157B
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 01:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790558448; cv=none; b=EkUxxty+uGuwqfdDrOgTE4CfjxMErNCgSKdYuTUiHF2kBr+Ct4mZxVk1RCScbuorbV5+5zdVIdhnideFPq+Bzni4ED4u13zkVJ0bq95tQrF8hvCFMp+3CrZoAOLXS/98Jfh7Xqv6cfr1PBGr2RUWsV31TmaTJ1rKP+E8HEsBbK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790558448; c=relaxed/simple;
	bh=7Yw8TRdsC8iJj4zKIDBj3vysMEmn/ITvAglewvj0fLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=toOzN5143Gi+ueuu0yi7TljdB0loU4DIelcpV+xlzHANpC+AESlL398eb6I8D6EscY+SWTepe0PaCw4vurJylAktwVX8CG34WjTuH+QHYAke5rp0kuF+OPYw2C0FyG22jjl1sFK1rkCGoaRtTw0ZCpBTu7LJi7Sk2BbDlpwgW/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxkENCEA; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxkENCEA"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd5cf02so1267131a91.3
        for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790558446; x=1791163246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uiz6c8lHl0mIc3Nv6bMi5cOROWKCJXWfj0lE81TYGfE=;
        b=UxkENCEAToW8Yqw/Z/an6HYAcFzypxasuWnBzkdMw+xLQFBPCtJduad2eHvSy77v9h
         jH86mdNrQlHujJwD2TfbExYKkavrSTbr3DbjCI0Sje63weM5qAB2aBVFjGitv2Uy6RVf
         pCWoEQiuDBk9zbAkYDv4Gom6zN+veTM57lQYJBKBGjU5Ob0qh3SL1K+uLBCPNPYCLy58
         cj1tlqlgBJM1d3xM4sCpZBLX9IcvYx9hAYOEyDvtsmDzX5tYMSeE7RChF5v3XZtebNBC
         9BpxF9yqSHrseFIcAzbxD6dS9VsrRN/KEQLGVOQ5oLejSvPZjhGYmTB/QE/J4vP8iBqg
         PG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790558446; x=1791163246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uiz6c8lHl0mIc3Nv6bMi5cOROWKCJXWfj0lE81TYGfE=;
        b=p1TMS/RhozEn0skNM4ySf5tZ+MQPtuT6LlQXi2LWhyrPzr9UWsEceKf+pCOiygEFX4
         UCNODzfTrhdDQkzb63wGohPkRwkKOiHtdcCPFJsBVwhFEIwCLf+PqZ7t09wlNHgfQbaf
         0YxALqvMEFhAOv5sY/xCIvbEQv6CovX9ExAnOF7TdiCe4Rbo+KKB5tDEw5sDEqtn17uN
         nbHnmvi7d6Ze17MXfBGTuvDHATbrZM2z++R10JMQB2aXoSFa4FMRShAeZM3Bu7IaCNMf
         lvMSHpsmK5oCIJLMaxOgVpbrTwy5g2Ap+VisO9zVaygp/1pdB9fs/rpOI+AnFdefgqmS
         USVw==
X-Forwarded-Encrypted: i=1; AKwUvByeliFjzy5oi5bgx4KY0ChHW/S2IkG1fnQLzx+zGFmOYIYn/uShNylTHn7VavGNumHCegK2i/yXBHs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJSh6ZpSWf+wEsL+b0grYSOW3ivMib8UyQgEtrln1MNLZdrYCTU
	mUL9IUCu8VaP8N3dOnvHit6IJAeDdc482QdOMToMwVGAAHYTPGw6kEOi
X-Gm-Gg: AYBFou2NuGO8hZ4zj8una+rkdph4O6+v3TeMliFdOK4ukTRJCyVfp3B2YOnENPAwq/F
	27P0uTt1qnXLfCB23MgE7MC0ue9kAe3J1/kbE8IQJVMCAFjtfDuXcrXSOdXTBRNVxrRyT9HOXzh
	Qd8kyhvMXb0AHqcpCcSt9Zzgx0yiYd+KG4YOEOa4W4NZgmwUvdLf1XVTgmfcbC1y7XZHl4X4hgo
	jFBEl4CD16Ji0QBZLDwC7POkI0RugDjdX2hJubHTJiYsQK8hlI2en8ZPhTFAOJzyz4r6W/48gd7
	sP021OzxFlbuovuX5J83tn2GIZTA2xbEIOpL6YVX4H/gzlEMqNKuXHDFzyVcqfvEjA5+t3N7PzD
	WE+2yM2362IIbtPFFEjiXtHgINYJhNPwIF9Z53b7Ano1pG4yE+5oBBUcNzoyMsHQoGi13oRci0A
	mbg1yo1enxvBpyDw0kt2N19bDeO8K/J72jFUIUekqSQv57yXaPn+oaC1lAcAFv3joHwO7ksLj3u
	Sa5OnurcrUgvnRe
X-Received: by 2002:a17:90a:e7d2:b0:3a0:ed1d:8e0e with SMTP id 98e67ed59e1d1-3a0ed1d9254mr3939086a91.0.1790558445915;
        Sun, 27 Sep 2026 18:20:45 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0e151be04sm11010527a91.9.2026.09.27.18.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 18:20:44 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: linux-cxl@vger.kernel.org,
	akpm@linux-foundation.org,
	Jonathan.Cameron@huawei.com,
	bhelgaas@google.com,
	djbw@kernel.org,
	alistair@alistair23.me,
	lukas@wunner.de,
	rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	jic23@kernel.org,
	linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	bjorn3_gh@protonmail.com,
	ojeda@kernel.org,
	tmgross@umich.edu,
	gary@garyguo.net,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	alistair23@gmail.com,
	benno.lossin@proton.me,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	a.hindborg@kernel.org
Subject: [PATCH v4 21/22] rust: allow extracting the buffer from a CString
Date: Mon, 28 Sep 2026 11:20:20 +1000
Message-ID: <20260928012021.484003-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928012021.484003-1-alistair.francis@wdc.com>
References: <20260928012021.484003-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair@alistair23.me>

The kernel CString is a wrapper around a KVec. This patch allows
retrieving the underlying buffer and consuming the CString. This allows
users to create a CString from a string and then retrieve the underlying
buffer.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/str.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index a556788bcc5e..3fd8a218547f 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -870,6 +870,12 @@ pub fn try_from_fmt(args: fmt::Arguments<'_>) -> Result<Self, Error> {
         // exist in the buffer.
         Ok(Self { buf })
     }
+
+    /// Return the internal buffer while consuming the original [`CString`]
+    #[inline]
+    pub fn into_vec(self) -> KVec<u8> {
+        self.buf
+    }
 }
 
 impl Deref for CString {
-- 
2.55.0

