Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792900995;
	b=cJ5Wm8TINGwdcOjCQhJjVf+E3g+9/x+ergB+sGv0YqVcwTNgdku+MW5SkOFELoMDw7gI
	 YllPCqfuB7mtvVYwa48ez9lNIYGphjKlq/Z95ncqTdfahMtzZwEaOXebHesCAqw2B7bXy
	 kG4VwMhr79m1TNC88mEjUpkpO2XbtF+12ythkcqb9leYEckYOnkV9UFXOGG/iIPl9t5UZ
	 Xv+GN5HYx/UKq/22S2/7KcXix38bXBogWWY40Xvy7DOP1OAbTF6A2nD4ftXS9gY3VMDJh
	 kNfhTJw5Zia++MiD0IrfLqMcNMJ4W016xgnJsq1saunpwKc81zOLwg9V/8ickZifi1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792900995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8otCCaRP0Tpt6gI7v9Cl/9PTuNgaCX14b6WSefLzu7E=;
	b=oLaUnoa0/4OWvh6WIGSguqlfsGghcl5LTDs1FZ0ZzZPpBztjJyi0D5kBAjUnoClgQ4d0
	 Sj0zDGI36ywfhlCmqbAocWywihWe/LbOdRqVqk0aDpmEkXyH3zOAEaxXdXUBsfOBSPljp
	 n1+mJjx5egg3cPxgwA8ExugFL/aHpJW2VaUnHsbsggW9hXPVrVLIZOOCqAFlJSM4w/tSB
	 YPPlEGC3GVK92fThWsU+aPLdEn89Umz3Ju5yivObu+JoGBcBO36i7Da9I7Zgbs7mIDBVj
	 KaQFMQOq7nI/akme75BRYW6pFY3YfsKwrGMm+utQs6yHcwLkAyAVmINiS0w3cmSBN5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EenkfJyi;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7777A606A328
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 04:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7777A606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EenkfJyi
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3282db206d3so3559862eec.0
        for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2026 21:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792900995; x=1793505795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8otCCaRP0Tpt6gI7v9Cl/9PTuNgaCX14b6WSefLzu7E=;
        b=EenkfJyiA3/VYe8HyQgDdOUHVOSNvWURr4ZBMWVcbQxClz1YEQgD9UiU5XUYDA2tKT
         45lTtDdSuNDI98h9aBuzgrXcZfNiYFkrTMvq6ajLGJkUTxy9+I51Ll5FW4DrQwC28XCE
         wyzFDNqjxnZCenhfS1ADboNBN8F5gflbHP74HY7jZh9+ZXf0F9ggpDi3w5pui0VfJkQ+
         N1knlotoTJJ+8g6mlRaum/eiz6z49DYGn3LXkDn4YnqM1LM/FXYHo3GAZrDguQqt54JI
         fIJK1YaJCW8PtVvjGMWufuV0/pQDdxNBBbwq0ob7lmEpomX8xUyweUqymMPr7WsvljTg
         74kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792900995; x=1793505795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8otCCaRP0Tpt6gI7v9Cl/9PTuNgaCX14b6WSefLzu7E=;
        b=HNP9fZ2tefnl9jewkUmixogLpBXUJCZrFyiIOiHxckjfjqldnUda/NwedbkkBdPUhR
         ieDI0BZKr0UFG/VC62F3n664aKQ05TZeP2spMa5xx9HlEALTqObOkDebsHWEH5hbBMwe
         C9XomHDYOMudYp3Jr9VPeV2Ql+0LDoHG/Ocsd4FJ6fgHnoiKNaXN3qBBtbuSWEmn34gq
         A0sQn41b73AuikCIdOet3hUi1Kyfhs/Tsy+OAvcbwzySRd20PX6i/DEXD+KPCxs2N+IP
         10L7/Mog3jgmgq155uEUKTnX/PAoEjUHcCB1B5Hi5iGV4xqODW9+38UW7nSeXcc8O6hc
         1Ngw==
X-Forwarded-Encrypted: i=1; AKwUvBwlh5tVJxp7lfgac7pOMf1m5XSv9QAkmRo85OH5nYLZPZxX5gt5QiJSseyf+5hsATlFtbA8cnopiSA=@vger.kernel.org
X-Gm-Message-State: AFq9FYL+zSZSIiSraLKZy08nmBxqQxEXRfdLFHurUjoOPg6ZzSbfKQ8O
	2Llo4KuU7sfKdtrt73Tnh7G+cWyjLVLztj1Afz8qQMoN1F0gewjAXvY=
X-Gm-Gg: AYBFou3OJpo0sTzIrIfTZsUb4tc7o3fHKdBXc++XO0NtzkMOIDOGECgQkStPYpsIeE4
	28rf8lioM+cGe+RePfLJlOv9YZ2ZHrzqBTDRPlrs3glVLim/QDRKoReJJwkWzFDx7INVvqZEGT0
	9mQgF0NRXeS/T8qBm+OTNfOzPMDLfnCI7tWkDQm0OwiO0+kXoK1IB8+zwsQPt/KV2LbFjfHj/JI
	wWsBJHO1G7Zx2MwS6FIWig1Y1mxEgNtCIMDLYZ6VYg5a+at53h+1a25AmsgTSDPbGznZYgvF9lh
	VykxNtuXIJGtFlz21IqAiGegMr/HGPjH9SMxwViakCrvKa+P8CrHcSnXAltGNZ4kDG5clf/AWLr
	a+490BzpF6r7ln++ZMWtvHdwllVxIMfre2bB7xj8llVRi6wHxZ4rtcdIjOwRGwka9+KN4CsuzTK
	9IN9sExl5g3d65Zc10gh5ph+uRpcuS38ygD50lpPxqfc0M8uASqJkn72o0aaZ6kckt+0orKp3AL
	7ofEC8KNqWc2JMmTf+MGbIXYb62ljZGdf3bJ+u4sYkYRWrCu/lSwr7ri15C1T5/cLorlfwn8Odf
	IL8PdQMB/L8RT1g=
X-Received: by 2002:a05:7022:297:20b0:196:82a:b80f with SMTP id a92af1059eb24-199374f3409mr4222106c88.45.1792900994550;
        Sat, 24 Oct 2026 21:03:14 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.221.76.40])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a32ff780sm11635283c88.22.2026.10.24.21.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 21:03:14 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Kenneth Feng <kenneth.feng@amd.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andre Eikmeyer <dev@deq.rocks>,
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS)
Subject: [PATCH 08/13] platform/apple-gmux: Add documentation about iMacs
Date: Sat, 24 Oct 2026 23:59:44 -0400
Message-ID: <20261025040046.1602-9-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
References: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
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

Add documentation about iMacs

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index dda281f2f..9f0e9ecbf 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -453,6 +453,11 @@ static const struct backlight_ops gmux_bl_ops = {
  * switch the panel and the external DP connector and allocates a framebuffer
  * for the selected GPU.
  *
+ * There is iGPU present on iMac's aswell, and we can enable it using apple-set-os.
+ * But there arent any display lines going from the iGPU to the display. iGPU is only
+ * used for offloading then, it makes sense as iMac's display are massive (4K or 5K).
+ * A integrated GPU won't be able to handle that.
+ *
  * .. _US 8,687,007 B2: https://pimg-fpiw.uspto.gov/fdd/07/870/086/0.pdf
  * .. _NXP CBTL06141:   https://www.nxp.com/documents/data_sheet/CBTL06141.pdf
  * .. _NXP CBTL06142:   https://www.nxp.com/documents/data_sheet/CBTL06141.pdf
-- 
2.55.0

