Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229653C1D5C
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788616913; cv=none; b=KpLzySlS1pFcH4R5Vm11vvcAXgv71KGgaAAjceD8E5Vs928ITNoEigqO/fMW54CwkwHvX9SrIkwyUQQK17u2q90jppXr8CgIRf1hCL2+d+ziUr82HUUXTvNJHPlKn8cNnJQbb68nmBxgWkYRp1LqgDK11XPXPvW3JXkAGe8J3KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788616913; c=relaxed/simple;
	bh=6f5p//qeeEhJiLT6hla2lNz47zEGEWS2WmSvXXHcHig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QF6HT/2qehYn19JhC2PNSW0xxk+BQxMPlsXPearROD10yYodWjBxMip5Sajgxhx+2qSi9MlWEkIVA8dqLAXpj9HqPiUWiFLnidvHxa4Xspl2MAJXlMfE1SouRt6M+Cp5/Uf0/87ugyEGydP4T4E7hrenkoXDbAXsej5vX18hF3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZpV17zU; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZpV17zU"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5c7bf03c4d0so1632854e0c.0
        for <linux-pci@vger.kernel.org>; Sat, 05 Sep 2026 07:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788616883; x=1789221683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sCkeW/rlDEZbQRwhNQlqYVSLXnulFlxF+aDVtk4kLrI=;
        b=MZpV17zU6O8ZzOYCM6mSh6Pc5bMWELB+jnQuQi5HQCi6EKwnfgmZ0AEBpaSpAQDW8S
         16IVmCmWPcQCQ7FUoAc2mjdXI6Vun4CESOtgp7TZ/BbzPL1ysQvKYMFBk+jIWWhuCbdj
         gBI6DgINw00GjdIA9p44lmwqHYK57/id3xwbTs5uCy8v4cZNIxLxiIv0AMx2XLjAnH3C
         Ea+l+j6WgNoLX1w28TuRU6e+lpGdTNOmLFjggreQG9OFR3L71bhcUPSJ4VvBiNxuPuvq
         ddKBGzFKZUmonKqMeFOYYTi1Tw6vtCRVa1cj6NAo3DraG3ex8OCKO8Q8YmVB4pM+sOEV
         hYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788616883; x=1789221683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sCkeW/rlDEZbQRwhNQlqYVSLXnulFlxF+aDVtk4kLrI=;
        b=SztspTnhmu29O8kyyCcheqXhVtEMoRhiRFvXUYgwEHbMBLqiqXPcxImpCuYRzFfy0g
         nSXntgBIwERDOAzmaZFvn7uyeKG4InHNpnOdeVlByCTPMdXegHcrR/7/B98KfH+9i5X7
         Ty0wLwmswXHoX/gBVcMWfJpARO/sl8Ct9nP+gyfMNI5oPJnsTov9IS+Z/OhC+fgxgRBg
         r3HN3cjX6X12t80Hut/s5B4CCjXwwGF0g27iGGVxNFXyl5tdm+I+5lciK0fSpG/NOhSD
         95uwtaj29ePWwmsGjGKHsYf6o4IXE1I7f6mifGI/D3y9tM1dmuXdKCxGia4X18+s2+Ma
         8uuw==
X-Forwarded-Encrypted: i=1; AKwUvBz1lAaT0WR0YlcHC/iVo9yJkmcHD4dgIiTQmQgtlJWx2GwBURjUZ7cqUuKAMRCKeUFE39QsibxKkek=@vger.kernel.org
X-Gm-Message-State: AFuF++luEiPSDdagZgMp3jePb8k/zJAxlkwdGGO96z60+6Ru26REoqun
	PV8dyF8WSm/i0jxpRROnTkTR1x0DktNn3OgoT1Xj1E8/L0dP/wOVXaDI
X-Gm-Gg: AYBFou1hpNP7YwCu3iR0xInVzJhMg9KB10xHCapjzwyeBKeMykVtLefgeRCvIQjVg02
	6iyhsoCDxdfa1o/6HSROx//tsSWhwmFvUGO1AZfODcijPYKE8OvSb/eBPQFbBZn9jucF3sqrDrc
	A/uCB+Zq7gG1GwHbpzr7G4PA9JJ7RiqHRZZYgj7j7lr4FSnxoOakh9UJxAs2sHs4WzPMoEBpfyX
	ruVIu2AyzGY5No7u2z/wR5NTFw5toXUafhcVd7dVs454LrDvaIz8kIZ1Y9CB6M+dFOGCUMPwjXQ
	UMZbL/PMjxFIwjVlEiGNIkKlygrM89UPYVkMkyx1qMGNs0KlbyV9BXUNDjHuRzppFEKUW4CZzjo
	+SLTUris+BOD7zbPAJEDEst64PiuGA9ud/KOBYPrv5ux+jfnFxA2w710U+5O1oH1aPwyA1UdYQD
	bS9uNePgzmJdmRph1GFKPR6LhFDA+H3Au9DXH6u4rgk135YW79Kp2jGTgQzkcC10R21q6EbiKV3
	rHraVs2pDphSdOwmR0JwL+daVuOIhq6
X-Received: by 2002:a05:6102:1484:b0:785:1d9c:633c with SMTP id ada2fe7eead31-78a4a8436b7mr5213627137.7.1788616882765;
        Sat, 05 Sep 2026 07:01:22 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9808ee4d743sm3706877241.9.2026.09.05.07.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 07:01:20 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: gregkh@linuxfoundation.org
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	linux-clk@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: [PATCH v11 1/3] interconnect: mediatek: fix Makefile typo for mt8196
Date: Sat,  5 Sep 2026 11:01:11 -0300
Message-ID: <20260905140113.21638-1-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct a copy-paste typo in the MediaTek interconnect Makefile that
mapped mt8196.o to CONFIG_INTERCONNECT_MTK_MT8195 instead of MT8196.

Assisted-by: OpenCode AI
Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
---
 drivers/interconnect/mediatek/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/mediatek/Makefile b/drivers/interconnect/mediatek/Makefile
index 6bd656668..64170ab16 100644
--- a/drivers/interconnect/mediatek/Makefile
+++ b/drivers/interconnect/mediatek/Makefile
@@ -3,4 +3,4 @@
 obj-$(CONFIG_INTERCONNECT_MTK_DVFSRC_EMI) += icc-emi.o
 obj-$(CONFIG_INTERCONNECT_MTK_MT8183) += mt8183.o
 obj-$(CONFIG_INTERCONNECT_MTK_MT8195) += mt8195.o
-obj-$(CONFIG_INTERCONNECT_MTK_MT8195) += mt8196.o
+obj-$(CONFIG_INTERCONNECT_MTK_MT8196) += mt8196.o
-- 
2.43.0

