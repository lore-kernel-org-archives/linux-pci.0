Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B052234D4DE
	for <linux-pci@vger.kernel.org>; Wed, 11 Feb 2026 03:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770780751; cv=none; b=gZklmNJ6ZtnXtPjXEnvKGFLkJ1pMsb3voJQNHfAJP13R755ll7HGqzBzkz+wQHOD6tXJwv5IIMJgobOK9Z04kd8NpqvLl/EnwOAa6G4hPCJ/zevCnZlPmGmJMjEemp9IwDkOfoAog6fb28cx5Y40lnIipw6ktQO3a/ZFmrE2NhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770780751; c=relaxed/simple;
	bh=dNpi1NMAaQ5h9qqbmQ1Z0VBLphRlK4MYeHJdgBkEl2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MT/0llrzYO3QEmSAYEidQBAzj4HCE0eXDtRCbnWbzCSDodnt+ATxQEp05nQ0E9r2/MtU7oqaMqP/DutAOINc4p2Qh1ABZAKjZ03KoSVPFLEDP4QCihRjW6m8cwj1bo2o4gQSnNoZ+G8SdCRVfJ1ea1kLEwEXkXM+9VS5jWP5Qx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mY0cd+sb; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mY0cd+sb"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82318b640beso857508b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 19:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770780749; x=1771385549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Hd4JNZlcn7oVuweMnFnRxHFMq+VGi5u1+C/ZJTSOAc=;
        b=mY0cd+sbu8JVYqnTxyljkX7xHNpQ/WPcfvw+VJNyBREzjLBE0ICSuNdsX8PfeCCfND
         bLdUpVoNjPwMKHNmKk+kcY1WbhfZ2Kb/ADA8pgXRqjoIbNzOduTiLZAcrNmHt7ToxL+L
         RlAhYQFBYHXcbeth2C6tUXMEpYfqhrmHt4MJafaUhq/jpw/WTF8IfOIK/lqVWr3LJKBI
         xLyg7g5jwSn7HtQ82Q6R28NY5TNFeNaLUGnHxco9zn6ykzQP2Z+NWysX2XnzQHAUKD58
         cCkgYCjIJ0m/ol+SlFTuVNcCdFP+D42ab2XIRwRzX86FLYZwe8EnTuF6QnwNwBI4ZfEt
         hjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770780749; x=1771385549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Hd4JNZlcn7oVuweMnFnRxHFMq+VGi5u1+C/ZJTSOAc=;
        b=busot72qn0JmGQEw7iO7jsl9Or3FSa2YxK90D+IwmqgCFNigx24OzYg+wgr/37IhVU
         X7OM2zr4Vg+MLz+0SIzcV4/dk4C1v5U2yC5kH3lY/iXT61i0z9fMT+auW9lttL+ioblC
         c5ZY3yahQ84SJsrJYX6wfmMxb5JaTHYhWUZW5cFAkzK2BrvCJjcyCXqnbfBXMEyNG8yz
         /x8v1PVN5nkA2hQx7WCgSWAnZUgFVjE7UAr02ACjZR4OPZjsmBVgIVJOqervAj+i8tjC
         d51qrDayOKBbwb5b3KX8hKEWocdBbu9HQ/ILYxgYSDCqC/TrQfk6v7lFs8p0apDLhEtW
         QQsw==
X-Forwarded-Encrypted: i=1; AJvYcCWg5r5vg9jNqNCfShpvv4hG/LiX9hPzxoiyeMw+KO3WKW0Sld5nwWEnV0JEoIb0/CNoQ5rqgBv0I2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8W+exmyVO3O/x/8P0j2M1oXtDgAIpPzIgVnMgkilaitBMZf/p
	owrpG1g8DdP0bRfNcSTloGYEJ8ik5AHmGn2in9Yfq6M7Qr0RvTl+f278
X-Gm-Gg: AZuq6aK5L/htqFmCV6RkRBgttAgrwgk7liLvcidNLmhNXazYIKlEZAqk+XatVY8Mnv4
	J/KRklHsY75u4KKSt1YPggpW3VMpkHjfcNMNAcuVYRugxLNFqi9SFK4DFg2Sr8MHV9IL5Yba/lc
	ldr+mlE4L9PV3HuivqRoVVf2nRpCO7zmB08/pbF43iEEhIkZwo8qZXUBJ7ZtHufWy9QkgyGQmSX
	KNL2qNJsSKb/4H1eR8Kvy1J4PYIgathAPlDNNSNngZT3adpeLCKssyCqYx+GV5Ro+UulDwnZ1WG
	927cELGBHKS0KFZpZDkvFNZlqN752sv9/pF/2ZskfkYoHO8MRBoMrRe1/B6OYczBgeJIK8zj8/W
	9bUS6CxA1xpDrDr9Hz06V5HMx/BCc85UtVdxOCWttNHymJkrvnCsOw8AYLvujLN9tUAK0yskxbW
	6q2VH4Dokq6Di8cMsAJV/RVhLxFikpa0qbmCk0SmtzBSXfsK18Zzvd
X-Received: by 2002:a05:6a20:c793:b0:38e:9405:beff with SMTP id adf61e73a8af0-393ad3b6d6bmr16299563637.65.1770780749068;
        Tue, 10 Feb 2026 19:32:29 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197d63c9sm464856a12.20.2026.02.10.19.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 19:32:28 -0800 (PST)
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
Subject: [RFC v3 23/27] rust: allow extracting the buffer from a CString
Date: Wed, 11 Feb 2026 13:29:30 +1000
Message-ID: <20260211032935.2705841-24-alistair.francis@wdc.com>
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

The kernel CString is a wrapper aroud a KVec. This patch allows
retrieving the underlying buffer and consuming the CString. This allows
users to create a CString from a string and then retrieve the underlying
buffer.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 rust/kernel/str.rs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index fa87779d2253..17426db83c9f 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -844,6 +844,11 @@ pub fn try_from_fmt(args: fmt::Arguments<'_>) -> Result<Self, Error> {
         // exist in the buffer.
         Ok(Self { buf })
     }
+
+    /// Return the internal buffer while consuming the original [`CString`]
+    pub fn into_vec(self) -> KVec<u8> {
+        self.buf
+    }
 }
 
 impl Deref for CString {
-- 
2.52.0

