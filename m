Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078807;
	b=PoyPFqkFR4thQQ4h/SlSf7gk5Ujk8degi47Ky+viVp3B+SVYJFzBdMpITpl6a5GPv5aV
	 adHMrDppuEJSWa4pkXwF4DsAVyt3fG56Binu9Tmfn6PozSZQ9RORmVDR4Mf7GoyhcZc4N
	 Bz3sFF21nJZNhtdBPS7tC58oOx9JI/C5Co0dEVflNxHC70GuG6nSILmi7AGTV7IVbbMeo
	 6Nab8Mzca8HfMkYFZEUEDzVQTHmq8wIYzr/rlLCZNfdlQCHjdO0OqdANWbd+64HgRJKpp
	 VXG8GLp+6fHi9LCOBs/1KhL1isOa9N9cVIzGcqfL9g2FELE+KmjufHklYvizuf11Naw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=T6TW1w2jznm3rH8N3w9X8qOCKxQ7D6pil2Ovq4EdpOw=;
	b=UhIyJE0yGtmSmpYzTc2fidPcU586SpWHB3caAzYt7bihR3lAHtxeQMpazx7MzYetZ2vX
	 1bJ+0Usk68cRgcLKzaXrrMdEDVEqzkCvyU8jr3drDYq0PPgv4WWuJKLeuIC38ttsqfMH+
	 fBywS93gMDYdHaKecBT803tcdjDxEHCueud738QTs9tfc2H0ExVs4bSVvidOb+V7h/OYq
	 vtwquP/Fm7/MZkFQB4ZzQmEiMgD+qPjRLRFbvdmObFFpmsPzIoAoRTO9dkiL+przA+1Oa
	 cUr7te0X/z3Lfw+nzkxjQu9Ctd/8RSBv1eQuwi1a8kjzPsCnTNaISYvRwoQgwL/y4VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l7YWkduk;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3A6606A31D
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 05:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E3A6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l7YWkduk
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ea94541adbso11907905ad.2
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 22:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793078806; x=1793683606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T6TW1w2jznm3rH8N3w9X8qOCKxQ7D6pil2Ovq4EdpOw=;
        b=l7YWkdukGmEONpkg0BtkGWQSy4WllYCXyMIThhAIhTu4ED1/cSGJS5s1knAlHS8ZRo
         gfUwxmkyGTt4ImNVxavYKNF2Mtx0+s1gjwUVvDVAPZpkXf73GqiwBS5qKANmmXwJKQS5
         EEMlVMToU857uf7c5BbibthK6rylk2h5HT8vRc5k9JGxKhlmM9rRcktlW35VSFOjjr0Y
         IPXQ8SLb9FsfwzaoXHUohBXVTmaETd/buHwaL5V4xraKuVA9pxcg12MjsvhvgwWlAchI
         Dt9ntpCfAynJ6dx0DdEGpQeJ5+quw9zRaH8An0sdZveuM1g6Ba0/HUvnDlbFSXu7B/GI
         JJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078806; x=1793683606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T6TW1w2jznm3rH8N3w9X8qOCKxQ7D6pil2Ovq4EdpOw=;
        b=sQzGIvAirzdFgZgx966uln5OiuntjP6R7MzaaKQF5Wklywt/FlqOT6FRBY6tbKjw1c
         HWqlghAxlXrkBTr9ezyTW7G3MpGs7sJw9gKb6ooERsnEK+csUakbuOjaZ7DKyOzaZlX3
         WyNafZ1qz+6vGbDT+UQgjk5kw9r5L5/wW4az47oXvT3l6eJkv7u9NGvWOrNdCBfl6b8L
         +Xiq2xnVeLRTslrY9iBjnUA/A5UmS7cOPIzAI1j3wHGANVroaIOk1A/Tth8f+mPg/DQQ
         +Xft2JAZAfYXoWo6XEVzGuR2Ect4dORp1Vx0RdVWgmJqzICDaXEIkWJ8KjV7pLCfHKw1
         +qTg==
X-Forwarded-Encrypted: i=1; AKwUvByQfvu26RIX9vL9U9V8ngDWn7cYw5O16R9pa/ztLEI9hRdffOpwct5SLulClcrmmT3RoRrUCqw8GhU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJa9mVhYemcwixa04SLynQyhgKhfmOTvPfo3TYimJvLQzf/eEYN
	CjZxneEGLBJWAMwRa/Mo4n2eLyDO/vYjzCHywpIdzBFcM1uSWs3R2B6d
X-Gm-Gg: AYBFou00EbvQqSW3yNlIlv/cwFkQFgbJf+s3P3wsmr7WLMrCYPCiOmj5UkROITfj6FM
	S0OpDq5CvfaBD4CmYcUVjIniNGcfCOP9jmoAFI7pIO3H64XFadiIJOyEfFs/UkSD/Kd5GUetSWA
	zgPCGnt2P5oxv+EovcyOJXup4YP87Tfb+VBZkyG69UG0Sjo1UqpZXz+2FEEoWUzlkIpXAe5onk4
	ENrPY008tJGNQ3UEWDVgBW6bZY7C3rQ+SoFXEIKaI6NOr2+fyhjdexwGbhdsistM8EtgNyNquxx
	YxpEynNJqy/61vOULXKxYylxyoE3JB+N3l/D2Pp+cAo9BxVQpt25BbQeprz/xPqj3rxtNhTH262
	ObChvb2pHehEqOkXodalsjItqO5AdDvWrat/jRSBOLTGTgpkFBbtgOdcDGKJn0AV6codMpgIVbs
	z8iFYmFbmnm3Ye6O2aK1ZaEImoNLEGloHvIsS1SxOgMrzvpsmp643YfXjlJ1AMNvgmUD4IxaHv9
	L5m9iNc/G+A9ivLTqWHCc/gHJeViXm6RbYbB989LlJUp3FXMNgeECg+0TIFmRdtH8Ehq+spbQ==
X-Received: by 2002:a17:903:4b4c:b0:2e5:f62e:2eaa with SMTP id d9443c01a7336-2ea9c88872fmr70545755ad.43.1793078806314;
        Mon, 26 Oct 2026 22:26:46 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9757bsm3307715ad.58.2026.10.26.22.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:26:45 -0700 (PDT)
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
Subject: [PATCH v5 08/23] rust: device: Expose Device from_raw() publically
Date: Tue, 27 Oct 2026 15:25:21 +1000
Message-ID: <20261027052536.1722081-9-alistair.francis@wdc.com>
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

We are going to call the from_raw() function later as part of the SPDM
library, so expose it publically.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/kernel/device.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 2291d85b6849e..a355ac9803410 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -262,7 +262,7 @@ pub unsafe fn drvdata_borrow<T>(&self) -> Pin<&T> {
 
 impl<Ctx: DeviceContext> Device<Ctx> {
     /// Obtain the raw `struct device *`.
-    pub(crate) fn as_raw(&self) -> *mut bindings::device {
+    pub fn as_raw(&self) -> *mut bindings::device {
         self.0.get()
     }
 
-- 
2.56.0

