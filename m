Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284394;
	b=bB011X1THbRHsyAL3ALWTzBdxiV9+PuCmDaoxStT5KYzy3SeeCjvzaxxtMGBt3Wd6cSl
	 FDrU1gr+XA+w7s/PLc6yt2AV31ynRRRfYgj/8/5IV2UeU2N36Olv30g5SC7Rhoo0KCTpg
	 Ic/CX1+xjpkDM00F9kjrJlJHhOGsxP+zibCZHIU4eE1oEV85h4MItFvN4m0u9f5zlmxWa
	 phslm//zKE/8aNRjNGqO0cuSA8xuvACJF8Uh318sS5agH7UVtvhvJqcC3qnd24D3vPTfn
	 Hrgk0t5KlFgXy6zWkgNY1U7L/aq6DANCiDQC1Pm3tRcyAIfQMBy5ETqXrGflce3gbVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3AxS6ewNN37c8Z1T2Uoj4Jwsnbq6o66JX4RBhLIPEDs=;
	b=atdvooaRIqNOTDy/louj47WTZYR0/hsr+aLzeK4TKcEsi4OmioG0FVtE9P3LImzrrhLY
	 pURC+l6CZ0IMjXKoP1LRwvKYYUhQPwhgT1hlhf4crOjYL8WxDNVoSuoxp2Igbl6PoFBqR
	 ACKV7m1+iRCJTMkUOmWImAu0JSrFtZ5+JLbN3vpjlFtWiKd6nmSt0I7/ym2TDLlpBIogX
	 DpYFi0VEqC2dDMpXrikPf9KF9f2cqWZ0FFJ78qE7CSDkR1vQHJ5oSy2z/9GYdfrym0+zS
	 AiNlkNlb030w+0Y8yCFW4z/cLWzhMUbMrBHjCb+cDUPjogfr34ZkL+eKUjOWK4NWnSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bAdLG6I0;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426F160A2637
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 04:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 426F160A2637
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bAdLG6I0
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3720addb068so2720672eec.1
        for <linux-pci@vger.kernel.org>; Mon, 09 Nov 2026 20:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794284393; x=1794889193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3AxS6ewNN37c8Z1T2Uoj4Jwsnbq6o66JX4RBhLIPEDs=;
        b=bAdLG6I0SEmoBfqYyUKe4jfQKmj4cvRp+anU2Oj5X0c+tjnjU59+VA8jKT18ZQe/my
         1NrBxCtLGndpR7JX52vRaLI/OHEVVmEBDmojm8MthHWn6SR3kGWvFZ44fCtuACa0sgDA
         6QsIpWMMPsrPsXtwmzjWeN0K+kXepme8doarva6YuCZtrU7O/N/BXDGI/28Ae798vZYV
         slUmkSL+oM/WLaktRkrd/0TFjbDoJYl+8vuyHhX766Ljbk6SztVXDT96+gpuH6/Iu9Kc
         c/h49WO/AxN8dbZftCq5H5N5bEBhro/po5jMkc72OtKLfwrKmrsGz/n11bnhfJiQSS7M
         XeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284393; x=1794889193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3AxS6ewNN37c8Z1T2Uoj4Jwsnbq6o66JX4RBhLIPEDs=;
        b=UmvMvECGFU+j3GkxiCDj7wuT0QQ5zTf1AcaYUVuKANsJzdd5gyUi2TJq5gzp0xT6i4
         kxUxxZf9J47Ma9b71GMMiPZa5gPkH05ZqKfGujmB5+IxSnxB6UUbHIrxcM4QZqkv81Bc
         OhOeWuvOvUSHHybWvBxcrjYLYfiUUa6w5Udv6w477yoanqhPJkTYPqgvKudIrDvXVskm
         ZQpE0u+uvCDSWJOjKSRS0g6x8toLY4wNtboDKP6q+BawPWegrENYBoG4W7FE2gUg7YWh
         i0CuVhOTVv/D4uqmiX4c0yT3TH9V6/WzOxAg0eW8nzqg/YjqkknXGyraBgbO7kbYVpVq
         W5fQ==
X-Forwarded-Encrypted: i=1; AL+hErH2sGhxV8KWaIOSTnDanAJWCkQz33SykOxXC2zxh/bWaT2ocEAi+WJ+nkZMGODEVEEodp6OkHXHO+0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+9z9JEeCZQkabyZj4hlkwwlE0cLQS7+HQgJSsGrLMlDroFsYd+
	OajB4UBoQkWMtazGkXTxkz+9yl7fmzX65xS8UFLZJnwuA8i5txvmU5TG
X-Gm-Gg: AYBFou1cVoeG3EWbF8QkH9jEvjjLfzBpEhXAf+PCRoXUU+kT5zmxTCB7QwkcnePpWmB
	LalrGjvkbc7bs/vJzoE98h1615hT8E6IUwgG7lylUkiq+U/4Bl6yxgkiAdmX4Vx427cWP/aQA/v
	YkN7JQtj5/4IwOoCNbVm1y6lOUH8AKazksVk77IfOSqFmQRGgYeBTQ4GQhG0i9B7SvosHvvIOr8
	xQeP5AoWv6I/fosDJ32I3r5iWJw8R/60j40yi02fzZ/qL6uqx2aIP9chUZWEuFjupUdlI94WdV8
	Ix9U4jVy8q3bh2Il9708iD7FKqDOi8oDkAebcfouuG6eEDTJMdqNu27gVvc8mpeofS5U9Wp+4Z1
	C23faxFB1lRqZeMddmPL9eZ7ISbFRWEa6vdLYtPQFA6fygvUUwp4jmvBbpm+EN1P1H2El0iGvxu
	tPPF0JrCNlvmdJGQ2L/B8vP+xIkHfV/8pbPYR0KsfXWSqWMMQPeadmmoa1BtEIhX4xIH28h63ef
	d0hModG/Wz4C+YAe+dYTdSyDGu43wx2YJPADIvSRa3bi8q/2d14p1Nta60aqTdDRCT/PWqfNYw5
	eIZFcHuS+CNSUjy9ikwa5ITOdldjEdqqOFkO0emIMXFncrY=
X-Received: by 2002:a05:701b:2807:b0:144:fb31:a597 with SMTP id a92af1059eb24-1b3b61860eemr1668909c88.47.1794284393237;
        Mon, 09 Nov 2026 20:19:53 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b7ba88sm3540459c88.22.2026.11.09.20.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:19:52 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: bhelgaas@google.com,
	lukas@wunner.de,
	bvanassche@acm.org,
	linux-pci@vger.kernel.org,
	alistair@alistair23.me,
	linux-cxl@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	rust-for-linux@vger.kernel.org,
	jgg@nvidia.com,
	akpm@linux-foundation.org
Cc: gary@garyguo.net,
	a.hindborg@kernel.org,
	wilfred.mallawa@wdc.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	boqun.feng@gmail.com,
	alistair23@gmail.com,
	gregkh@linuxfoundation.org,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	alex.gaynor@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v6 08/25] rust: device: Expose Device as_raw() publicly
Date: Tue, 10 Nov 2026 14:18:15 +1000
Message-ID: <20261110041832.1730924-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110041832.1730924-1-alistair.francis@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
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

We are going to call the as_raw() function later as part of the SPDM
library, so expose it publicly.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/kernel/device.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 2291d85b6849e..be89e9023b09f 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -262,7 +262,8 @@ pub unsafe fn drvdata_borrow<T>(&self) -> Pin<&T> {
 
 impl<Ctx: DeviceContext> Device<Ctx> {
     /// Obtain the raw `struct device *`.
-    pub(crate) fn as_raw(&self) -> *mut bindings::device {
+    #[inline]
+    pub fn as_raw(&self) -> *mut bindings::device {
         self.0.get()
     }
 
-- 
2.56.0

