Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794672595;
	b=uqQdG7Lb1hgZX55+B9JFbYiYhrnMGCDxpkRav8claccvCH2bspS4dKHsz4Y4hnS3j9bW
	 TavtUISHnGNy4R4eRm6MDZz5MSegR09if256VNGJBoj8yP8XeF7SVboZfAWKD//ptoLOi
	 9Pi12X44fxPjfTFwAtWUkJWaZZ6Yll+E5VAn58dbTfomyZSizmoPV5kB4Pxp753RskkU8
	 qMvmc5aDZfT/ZEIouMiafsJavCAB7UwtbPlb4R04Mj3sg5/bDvESLKOYbhwYKYfrAKRmK
	 qoWBL3NQhABh67Z45dV4U9VjU/6sGDJpdPWmry9USGU6O9901eWZm/DEYtG4weoOsOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794672595;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Jd91Zwd/kmiwKW4+PLimd5fenaYkPvHETCW1wh847os=;
	b=Wt0DnNQCJ5y7SP25IxaAbD9M/yfB/oqAm13itTHfERQSHz2qXz44RJ0vb8qhxvf7Jyut
	 zinNttlpKwjcL5ByEItyM5tjKMMHeZbjKMHtePhC18Ajkg39h1c4EyoMeCPs1SeUHTGFU
	 kruxvhtGXi3QllyxCyTjZ1Yl67jdyZb1Iomd/Rew3p5UE5/EXGCD36XIR9g/oSrl3V0LB
	 2UdeoHCmD6JrAE1c3FL5q0btHeFZ8ZfDf6EiusJq2gy25ktkqow7jhj/u7wHqk/tDC5K2
	 t9k/9X1AnWOR9t8ch28UApZmFKws/Qrsscq499Vra9hsU/HBvPvBzndduYFKUEdYuQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ixFnXvAr;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A198606A330
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 16:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A198606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ixFnXvAr
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36f8cdd30beso2135531eec.1
        for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 08:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794672594; x=1795277394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jd91Zwd/kmiwKW4+PLimd5fenaYkPvHETCW1wh847os=;
        b=ixFnXvArZqS0nOjkIjfV31W+fUV9CVbdsukSilj8mL0nf75pnBQfkYbbeUnXS03uL1
         Ll0LVzsyivFQOIFTeOnzIrR9vhpgzYAlP3qGhyWVaAN5CGvBoC4vvKT07oI/FOtGKjqa
         UnrgtZ7bUQ3PU2yRRzK7NRoy4zWxkcESr2g8jVXu7/vguPSHcbCGX6vWkmF8/zG2e/Bs
         3WM2TlqMOJWqQOv0HQyB0xH84McuETFZLEXaTfc+U6c4hfIOPGNVzrjRw+bRdfqtBB7t
         cMMbxqGDDQcRSxEDoiO1AkMBt5b3kW6Yl3ZWJdBfA9Z1bB4eecyLwrwQJAaAHVWbxcAj
         nZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794672594; x=1795277394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jd91Zwd/kmiwKW4+PLimd5fenaYkPvHETCW1wh847os=;
        b=zMW1p9yJ82g8s+69qhhLqP8a1Zudj+tNHIIDQtnhEMEhXkJcVPQ0hsKYGrVJXgU6fb
         5HpYqaXr/LEoaMX6quHTcab8gkObxS9vW4UsXWU9JteG0zr5SNsyag9S3AwDLUylpVVP
         6KuvTLutVx1jq7/8DVKgxe9Sdm37h7N+oyxJubYmvZxFs+9N8Sld310uQ8rA8FsSWwDa
         uxkEl1N/kpa4B3QHimEj+5ddh+dBkP/MKO/ejvbDLzoV30tBITSIpG36soOBHLsUmqKV
         oEDlroae4xgaXqLknTa7urdzQdv2gUkkfpBLVBgCLsb7tiO8ANb9gRnXwZK3GI/DrMJB
         k25w==
X-Forwarded-Encrypted: i=1; AL+hErGB635lVeiyD6mE70HRMQ46UlVWFQ4HlJnVUERL4NvKOSEkFV27qJK5uovWe7eWF68uH+VD28IoQdU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8YLk7W5TvfDFJWNH7ar6dlPDAmZfnyZeIJgKE/0+SzDCna3iRA
	h7fbGM8m3Fcyqi0jhZTEPQQ53M8YTjpgnYOeCkK/+RvEDTSUTs4A5wQ=
X-Gm-Gg: AYBFou0dG3h3zJt/AlRIePVl6JKHouhd2rjSZDXwgSl9SwwGJ42eKd/UmYsH25nkAZb
	HDzyjTvfogaOjYAEwRTh5ZnHyKrs8eNYhLvCAdc+xyAwnCnfhYIkHlWiFNzam1uT9Sc+b1LDFCx
	Xk3Q7fzjcMfNOh0B+EnXTWd7L/r9/C+lGBYPW5lCissdlbRcQL16JC2s9spkVK2G4nQtMnTky/q
	SohyEQEzLA64qW7FuZTBhDJkQiRguZthkilWlHa8Sv5FWIrLZM5p3R32NRPyrJjUZa1jkJADiPO
	asRyz+d2BIvuQolvB55eEOwtKvvnOa1FTQN3JvV1KgPyJhXtonaOCBeOfxe/IcIGjzUISia237S
	oiXVfo5Z6a2WCjPw6Ze5PlC0biREKxtpqwAxQzAMWHQv3tXBd49ifl4ztGGwizMX0W+Mv25yFqa
	V7eHHB22GxxS1TWVrs7Plgzpdzw/SXjWu2dxibBaE6ZbD/rBl+cKqr2VZSfDcFB+RZOZZjDB4nj
	/4h48geWgc7qoxVkVKHcvKpfJFGyD47L+wMG8AmEXmM+m8Q52LTfRS8gTNZqhAvSFEagZF76P+X
	Q4pQY7mKPhm28N/HqWUQzEyxPmMZrhWWMy6BQnG64aHkSm+HrPtwAcMcFlmKLJWr3CC3dPEagTE
	cYdCcvfc/V8U=
X-Received: by 2002:a05:7301:4d16:b0:36a:1d6a:596b with SMTP id 5a478bee46e88-379675feb32mr5897107eec.29.1794672593531;
        Sat, 14 Nov 2026 08:09:53 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.127.108])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bb0919sm17567582eec.29.2026.11.14.08.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 08:09:53 -0800 (PST)
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
Subject: [PATCH v2 07/12] platform/apple-gmux: Add documentation about iMacs
Date: Sat, 14 Nov 2026 11:06:31 -0500
Message-ID: <20261114160731.3756-8-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114160731.3756-1-atharvatiwarilinuxdev@gmail.com>
References: <20261114160731.3756-1-atharvatiwarilinuxdev@gmail.com>
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
index a1b7a4709..4f5c98445 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -444,6 +444,11 @@ static const struct backlight_ops gmux_bl_ops = {
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

