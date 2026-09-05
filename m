Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5874A0910
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788612285; cv=none; b=bNp+61f1ygmYkCfIP3V3tqceKJexSPAXl37sWzFLzf9LeIchVKuY6v36GPtgE24uMnqhaee2WSThkmKLiTXZz6XynykH7XSZh810l0T9/LbWpWHG5vfKJF0dcXQEeLbueCUSWjpyXzuYr+fyV60oN3/v8CqMidj4orPoietsP5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788612285; c=relaxed/simple;
	bh=6f5p//qeeEhJiLT6hla2lNz47zEGEWS2WmSvXXHcHig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dZOfXTlhAsSwM5TeFplLxVq9qXU95uxyKamu8D2Gxn5xLVXC6Xp+e04Xc3tcV5DPxPAU8qUCxmJBxWsiF/o93zkeKsubWzhexRGYGAYRyzLxzQrxFqdtAATGr3HcQePrZXmNVub0ndTdAnQ7+F3iUQZHcFQ3+A3MVEeCBKli6Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzBSFuhs; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzBSFuhs"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d560775ca2so14371475ad.1
        for <linux-pci@vger.kernel.org>; Sat, 05 Sep 2026 05:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788612280; x=1789217080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sCkeW/rlDEZbQRwhNQlqYVSLXnulFlxF+aDVtk4kLrI=;
        b=jzBSFuhsbkrPCo505JQz3G+xdlugkLc+IBPvSy0XsIfFSJd/c8mRnEylKYpvF/ZV+K
         iQUQvk2s2tPlR5qay3SW81SyUF3LUWrPBD3BL+8kQzuMGyi+PCzUPb2ziwy44odAhWxJ
         KTAOHC2ufuge6vYiRCOS/R/oyBcXjCrVSqvelyemGLd9ZIkupmKYvwNzB5GYnZNZPujQ
         Hjn7VrXRaVdL0DKmXwRFpiet0mtZDoEHvKcaCOFkF1M4dpc5T65ijaEJtaFuAXazWNgX
         EnDpoQPToYSNlZENI5dBX7MQGfVkGX5FExIrLz0LfI9EpCnPlAHcMuO4m31CgfjJ6jSx
         hELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788612280; x=1789217080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sCkeW/rlDEZbQRwhNQlqYVSLXnulFlxF+aDVtk4kLrI=;
        b=FjoNXCLaguS0+8xJwbVpik/V5UIAuNt2wX3SIh7qPZLdRu4QCb/+VflSKZpMp/v0l0
         jZAekON7xfVsL+Ug9TW7zcWqYkLXpT7Z4OVIdJ6l8ztIFj7ZZV8hB7jYkQ+Frb5Mz3qm
         f/Uzx567wO+SB0eayuz8jUobx9HRgXk8oAIZXlSvGxw7J7ecQtD3s3GAuGSfx0qsdxsY
         on9mnEBHyFHv0J9AueVI2ZiOdM8UUFAmpY8XSiGvdl9K42KvnTbtSF4eYcnxT7hBfJxB
         C2HNoof9TCqolefHWUzej4Fp7PPWN/5NEYC+uhSShheiU21uxVkrMWXkWCiyrQ/ycgOp
         8XNQ==
X-Forwarded-Encrypted: i=1; AKwUvBwvXBZynIFVJr6ePb//JAJ7XtNS+J/7s22ZmPTSjBSwZ37kq0gMhwADkx9Jy5rTS1m2P6U2gS3AAPk=@vger.kernel.org
X-Gm-Message-State: AFuF++mh3Nl/iMXXK5jgi6tkYKgAmpUHbaLo65VUACS6DMg4KVuD6geG
	ZdvGxo2oZwccKXez1kptbWTYWBvRTfGXta4mXZx7ZKZNzq4wc/wIxfHJCe9VuL2S
X-Gm-Gg: AYBFou0x2WWc6n/OdSQOjDIfNVnp9VvfAYWP69EGM4oqqVaCKHJAwzlicqKh7FiZi8P
	0MkoMdPey98fMCo7h1+FebxJ88p6E8HaS0+duO+cQWg3+seWNAOiwg+/2c3SUtIW62Uod61vtkH
	aSQVwgRksVgcuaaqJ5yFLGeX9ajGUXDk8hGcnAWDZ5U9J//SEWLpbGj2XKgD6Wwb+1OqeEMZdTl
	Mude71iDmCLYRgBZM0SkiIM/rBaZzJd562Q9DztTmOyTPmsgTw4Hh9qEz94Ip49O6ZrFJ+cpRXw
	so1UIH9Q4+z8Cxayb9IEoaBPbKmzBcnH+wo7HrI2x23v0eDiQhGxZbmJ/mUv+L4molb+BWEw87C
	1s4ml8BxTGq8kxybZWKxY0myVe1HqgbKO7A9uTZe7XlcOJ4bwkMm+1eqe+cs7dyb560FEtM+aDj
	vEj54ZrYSV6RUzkBvNbG93wNStgN4d/9qolRmb7RKoOk6XoamD05CQWw2DDItdKUZcIHQOkvHQj
	TuzXHN83Ix0ANWQGwv0paDeJiHWC3+z
X-Received: by 2002:a17:902:e805:b0:2db:3b35:1ac6 with SMTP id d9443c01a7336-2db3b351c2emr5928535ad.5.1788612279984;
        Sat, 05 Sep 2026 05:44:39 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3346ea43377sm11740417eec.3.2026.09.05.05.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 05:44:39 -0700 (PDT)
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
Subject: [PATCH v7 1/3] interconnect: mediatek: fix Makefile typo for mt8196
Date: Sat,  5 Sep 2026 09:44:32 -0300
Message-ID: <20260905124434.6163-1-breno3011alves@gmail.com>
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

