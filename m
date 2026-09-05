Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B334A0143
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 12:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788613038; cv=none; b=NKBN0DVx1+eTycso31evACc1me7Fy48a+jKM6rAjrQzeHVDhUdtCkNxU0pN5BoI7+cidydW9cqNbpxA4Lz4TQ092uYvUEn23DxRzzsjnwKXge9cgxzXKD46SRW1gNZdNbJN+XWExcAFAG7/g2xCC/4zVt+GQnFl9e+OOK+wkEAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788613038; c=relaxed/simple;
	bh=6f5p//qeeEhJiLT6hla2lNz47zEGEWS2WmSvXXHcHig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HYMayhH4sYQluylpP0UANmlH9NIycnDEtDY53Fuep/KpNVuA8KgIBmUFtr07NrY+0/kHJiVvLYPqSIXFDuNUdgYuSUb1APW8laN4VR0/HqCBKyF9RtuUMVFHVQ1q69FbIQmU5teNAjTd3LIq8z5jgqErS4uD0wNJ48sf5UaiAUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kL8ASA3Z; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kL8ASA3Z"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5bf5370d38fso768934e0c.2
        for <linux-pci@vger.kernel.org>; Sat, 05 Sep 2026 05:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788613036; x=1789217836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sCkeW/rlDEZbQRwhNQlqYVSLXnulFlxF+aDVtk4kLrI=;
        b=kL8ASA3ZzaDORw3JpnCIdBM1mjUHwetTUGXP1cwZET4VOCUvyFczdeNhMTX6ISdq58
         zN92li02djVah3SvxyGVjnc3hgWWk40ksdMDbqP7oYHDEyDNUuAvmNC/0bjRp3lCJojR
         v+Ec3RLj4vzkC/wJGT35ieS+N5mcTSO/4XYX3g3lw9i3m2bnSC+j8goSkZGDZ8ClqNST
         f1aotRGpCvbsMLJp5+pp0UVXapEnNrTWrGVPyn1pB+bo8eCesMhbAv7Rde8YW+CIRO1e
         IeyG5rs6guNZH92u2ieioeO5ytwQCMCfbFkc6+YSE7g/oGUjV+EWxwOOMx/Xgd7IGw3Q
         pUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788613036; x=1789217836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sCkeW/rlDEZbQRwhNQlqYVSLXnulFlxF+aDVtk4kLrI=;
        b=INqAVqI2UbbPuiFZohmL0RoviH22vqo54X13pJHDHCn9Ed5u01JNTlsTPxL8YaRNu/
         B9As36jFKmdybX0Ujx93ys4chgrvQf+eBEAqQNjuoDcum45DoKURdxOHaZP9BvAAuHwc
         UoB5r5IE9um+mswopm9fSvK7L6lGfFLmU0e22jOosGjzZhEaGUqsNWBeL7kV/kiIUTdF
         8NNd801IUKWOT8a1Tlru5qEp0cwM2S/OrE6ezzokkVac1pB/Bn/A3unbilKPZdEG5zbz
         8fSp6pk4kxFabvPcFMrD4JrPCxw2oSPyJqD1qHwWzRxCDnSyBdLfHylYK0X3CLQPF2XD
         a6gw==
X-Forwarded-Encrypted: i=1; AKwUvBzGHtYv5GIZ2vNgQfFRFlBoTx5sKSsaMsylkD6eY+7PYvjjXiCJWa3qr9q2q8XnKJwlNqz9f6tMNZw=@vger.kernel.org
X-Gm-Message-State: AFuF++nOUAoGfrUHtiocoB8sSfMS8LkzbXadlL85AVcBUMwQsIb40HIs
	fhw4KM2c8wdN8RO6SISVGBUaOht1CtusvXYXIYtsNF+2xnDNwVeJFk+D
X-Gm-Gg: AYBFou2Mzr8ha/YKthojasOG8EDh/E+FQKtxDNMGcmbY+UU0ZK5xvoIC81JpsusE4k/
	GlrOL4wKtqGl9vcCUjnU/Tn0bnFZEHI06fqRzmdX6Ur05XpwAYUYqaKYSfQ1Ok9kio35q9aXhDR
	5LRPinyy1z0xckB9uPh+VPAu8OiqjRu3ijCs4Ua+v3J4tAaUQ8myjZS8Pdog3sdOVnoqJtab0PU
	Paqauq+PD4E0/H78DAJ+SPdS2WluKLyR0bNb7rHBJuxmlfIfR/3UGd9lf+3VS/p/+QctFPi/MbP
	srfGdoN0iqUfUjpfO4t90wwChxKzqnj6jA46i4IeVN04pUtHsvIuFwWtybldcj6g1FcDw/WSzZH
	vKGiFgLjcz/ZVhreTymhltD+v7QdxPXVF3W9uJFGuvNq2l+u94boHnFu4ibo+UMVwvVQ7sU/MFw
	DSowx13J8Pc0m7PuMJzzkNCmpyLz3t0TZFmvXQh7AZDMJDlHu1eGopj+foJEzh83dTJXV0Db6bT
	u+0xeDjc8OM79ZFWf6HJIgR1Upce+RXeHQ9cItjqhA=
X-Received: by 2002:a05:6122:32cc:b0:5bd:aba5:3830 with SMTP id 71dfb90a1353d-5c7ed0c4c20mr6435898e0c.0.1788613035512;
        Sat, 05 Sep 2026 05:57:15 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7ec1ef7a5sm4349416e0c.5.2026.09.05.05.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 05:57:14 -0700 (PDT)
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
Subject: [PATCH v8 1/3] interconnect: mediatek: fix Makefile typo for mt8196
Date: Sat,  5 Sep 2026 09:57:04 -0300
Message-ID: <20260905125706.6550-1-breno3011alves@gmail.com>
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

