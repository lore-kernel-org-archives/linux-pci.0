Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF75D46C837
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 16:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590646; cv=none; b=M/vIz/LYLDASrEmVKpFBop0vIM+VSMZ7ChLVDD+J0PczfVh4eaSCq9Mp4z+GfwH0x2EvwfRM2Lan7XyJfBsfGLbwgn1UN9zvcm+uT4jhh1GTm08S1tGF/cCKTwyiJz04UBT6SmnrS6IO9IuKoM+yMB6GnrYW4hzDsto9KTYZLV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590646; c=relaxed/simple;
	bh=qPFbyNfgpwg9yWO/kca52NMFXHq9EURI69hJLqr0qrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AixjIbY5X7MqwmkxInJTdVAlJfOyGhG5G/faQDBCXluvtUD13wvS+bcRaJ4hGdZrjZkojKRF8kDKtA05NItoXw7AuCj5NIaIZrqvrwjc6txJK0IZb0deASal/abTQqpJ8soDs71BvTy/CmO3o1ykDviuKNvgifLixuEG4929vHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=h1wzptdP; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="h1wzptdP"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66d0c8d0d6eso757276d50.1
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 09:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1787590643; x=1788195443; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jo/Xp3hk+Y605226pQBHdS6U5/IvpUZWChA5HanrmAI=;
        b=h1wzptdPqkr+QfphaDJJo4lY4zulUAnPCqNDH4x4r3fndjvbw08ACoC2xWZECrnNXi
         kyWjzfwWeiFuJgk9wgJxhLGtdkHu8Dub/jJW8pZizv29QT21v9lJhQteI6p1ePrKQdS3
         mWB7sx6wQABbo3jRs32YobCoEAzev4iK64pXy3G7vaZzEBWh5YmEICcfDWWBpqyCnCqt
         w9NSf8pAApMmDScZ7w4oVlJonidz1et+8czqw+CSSMtKYtjOlqLQHTSS0CxaNjlQlZRv
         NjfJn8AeKQSGfRpfAW1qZr2DLa9CpXyJDnQfL+ULPSeO7CwJlZJJyaSzmAg7JzN+2v/0
         XAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787590643; x=1788195443;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jo/Xp3hk+Y605226pQBHdS6U5/IvpUZWChA5HanrmAI=;
        b=LKPfbZVi0xSkZfUfWUwgwEtdvPrf41uUiaXLWdaBH8SmmWcktUm9H//Sh+15WCKmxO
         ejjNFeJJ1l5q/pp3H4AHlaapzpj7xL7wiRaNQOFLTlInAws4wE+Og/uMKbyjmfCbZQ4x
         k5/uKLd0qeiIwa+UCXxFzoBfg2Med85o4qt4IFGNDRMbmVi6BbW95EdJNg+nMZ9dczo0
         atN4TTzZzcOs3n7BVQyk3YsMhJjpnF+cIUTOzeMmh80ogyTAcmL5pgQUcuCrusw5T3e0
         JSUoWgvUT1Rssjv43VTsNcQLMP9alMKLmzZoVsDpuPNO9yKJXCT4dwL0n6c3Y6WwLv1n
         YTjw==
X-Gm-Message-State: AFuF++m+bsr+Hu71B1QTsulnTVXU8Oxsm8ZLlFIZDA852V8EEp8HDW/d
	roBh9ReZ29TDfti2Uyg8pm/Rw8CupfllgQHJkTzVG1h8Ubc4xjXP7HYwYUnGIkqLQeU=
X-Gm-Gg: AR+sD10ze23aLP1wTSzibEx9nSj1h9FJLhTeh5hR7RGMU+dwTuYi7DCOsgTCabLmcaY
	u2D1o2LuF9flSokb6ub+jAvZyW0AJaqVtAU+Sg+UXbIKfYlA+CTqjmYEuA8zPQpYuVKZbCffHKt
	ZBPy/5ZarRvXiQn2eOCl8Nh03cOdssnBxTbBVTfevgwZjPxEZUsKjbbNfVOKpb4GAZOQNSTPsEi
	vVjf1FXaXR9mew8Xf76AIZwn/SA2H/NjZCa7UHXz21Vv9CjPsUUgw6tLKtbqg8XRB9DUKIuHPHW
	iwqo0xWaokG7N1aZHxhZg+xG7apJPwtlijk9KPUTrSdK3+EcqjSk24LAD7arfLKKKB6CMntYcu3
	P1ILVrNZQzj4xCj3SL+dKsaotjDmQ3n8pegYL+56bvTUkU36tahN1UayKNsETAnxrZpxcRNrgGF
	zBXEaEBaj12X8LCNEAUvJmAJGszfohC6z+lUg6w/nhae6Ocfm0QidP1c9VCffJxWp95YE2gNcf2
	ZF/CWsZf9r1hniLXThezCMDIW+bmfizYwvG6ozya/3zsh8+pBY=
X-Received: by 2002:a05:690e:4287:20b0:66b:14e5:d226 with SMTP id 956f58d0204a3-66d14aea4b3mr99471d50.34.1787590643448;
        Mon, 24 Aug 2026 09:57:23 -0700 (PDT)
Received: from [10.200.24.109] ([12.55.13.134])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66cf4665056sm4137612d50.8.2026.08.24.09.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 09:57:23 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Mon, 24 Aug 2026 11:57:06 -0500
Subject: [PATCH 1/2] PCI: Add Tenstorrent vendor ID to linux/pci_ids.h
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-blackhole_quirk-v1-1-fc004672cdbd@oss.tenstorrent.com>
References: <20260824-blackhole_quirk-v1-0-fc004672cdbd@oss.tenstorrent.com>
In-Reply-To: <20260824-blackhole_quirk-v1-0-fc004672cdbd@oss.tenstorrent.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 joelsmith@tenstorrent.com, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1

Add Tenstorrent vendor ID to pci_ids.h. This will be used to apply a
pci quirk for the Tenstorrent Blackhole card.

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 1c9d40e09107d..8ebe4c468d39d 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2630,6 +2630,8 @@
 
 #define PCI_VENDOR_ID_ALIBABA		0x1ded
 
+#define PCI_VENDOR_ID_TENSTORRENT		0x1e52
+
 #define PCI_VENDOR_ID_CXL		0x1e98
 
 #define PCI_VENDOR_ID_TEHUTI		0x1fc9

-- 
2.43.0

