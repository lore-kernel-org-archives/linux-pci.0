Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39041426D0C
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788616914; cv=none; b=hRX/FQefCpgLm5FaZzNSXA8312pk6o9o3X6Ukp+lvi5SoWowutc9VoE9p+06Ew8niKEfjy1YJup991uJIZRAr4zVqTKadqbLx6a1UoA+zdJYXHM00mJsF0nla4vkwX5TWFfUUVVJLAaqNnzQu1izEt1OL7t/Ty5JdSbv0Lq5MAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788616914; c=relaxed/simple;
	bh=EizzPFcHBTIh2Y7GKphJQqpoh7RMlGuXmOyHqJPayZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6jcp/gOtOjLy91N2gLlN1+WZRyBcj92zB6d2WoydZCUmEVVgPCyN7vgxam8TFJgrguUYQgYYjKO3/7ktlGEozatogOKddyNHUM117ZpoWw4w2dX1pi1zlJN/Nhq5aqESlvTGQVl80xwr9h3EDIDDjQ1JpRlpRyIID9iL86Ydfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAWHDYpH; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAWHDYpH"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-777c2d69446so1503106137.2
        for <linux-pci@vger.kernel.org>; Sat, 05 Sep 2026 07:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788616889; x=1789221689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G1isrg7TbqEnfLRqiu7vL3P60u+Hz9D9A7/6IXKBZk8=;
        b=ZAWHDYpHOMJ2pb1rznJGqWziVaas9dmvZpinpC8dpdVqj28oQXoc8EcWh4t0vpBJzr
         OfhyVTe5DH/gmR5zTbIvGvTij3vy5znr4MnvveqiDbMkf1FnVpTTGTs6pPzlKhmqp3sz
         3YkwoIj1bZPG4c5xVmHJvjO423C0j8ygBV7y8w96COK+Mrg6bjL66EJZ8f6zhaipTXCA
         shq6D7fnizDyjnuKBYcpdih1sLm8oHZjgJYRBxZorjypAjnKdQNVQabQdDtTPlev5008
         KLDjEmNRmj3wxviz0WV5c0/pYxoL+Vd+BAWA+ZhPGQWWDpR2WZGmObxm4RgatpKhkaDT
         jmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788616889; x=1789221689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G1isrg7TbqEnfLRqiu7vL3P60u+Hz9D9A7/6IXKBZk8=;
        b=UDi2UipYsHq4cQyPAvjtVxaxSfs8zo/tZYxTYDcVHGVfPr1KFDPUUdA1yUIU2i/4J/
         WqC2cfWwLTdGJrqtWZO/vtdFAswV5oQw6F2Mt3IKo1cHGj1GhdQOAeWGksAKZAiMp4zD
         npWrOHrfgNlzhvBQofzqOF19H5Ho/V7OyMGmWrW6deanSOTfKPNentY8wzGulDJt8bmI
         pxS3PnjGi0w0R6JARn1eEwhnSSau1IJPhl92BaiUntiGV78OriB2CAOFM9nfYZfkMmpZ
         cxHQ1sPvyuQ1AgNtu1/o9j5/PIcAofmrOhAmzVrOy+a5O+mKIYWyryIfcMFAZFX7NGYu
         S0Fg==
X-Forwarded-Encrypted: i=1; AKwUvBz5MUsc/09uBtTJjp/Ld2rCEPWhEaew6wEGz/AzAH0eDkdMN0hkvWgtmtDMWld86PBtzrYqmSNDIIs=@vger.kernel.org
X-Gm-Message-State: AFuF++kNaIEJDR07R0j10CY4pD8WIuuylRWvuFPJAD5twNQDXPG78AXk
	uOG0eJfpPzVlYFyrpGamVj76Ddvs+ZcxpVYXa7IG1jDQZYTN92OqI9tk
X-Gm-Gg: AYBFou05iJVLAOoHW1J2hY1zqithUY7SH7Kw6a4peIqal6QGz7gOQQaqkORa815/719
	JbO85mDChAEbQwpX8gpjcZFNuHt14LfsBkoaxEnEY1tzY4OO5kIhJ04wC4i6AkpQL3ik4FQZzML
	g+y0u2MmIexTGo8Km23vaYB/JtPvYeRapZRzl0Vt2disDcUe60gY8IPFmG0tDntkycdAygj+Eoh
	qai+NS/t6e1hbcFgFsMK6iRwZz8PO6yvWU5NJ8nz+ND9alqVTA+6bD432w7CNZAoxwmh3e/brt/
	q4ZUAKlaZUNeCwlSsLWa3f7PzCcAzuAfvX6D0yIKQqefQhrQsjXjjEcXV7G/lpUflwVbyIsj/4h
	/4tovCmbHPIbeTJoTEfWo8z33v0lC7izPZosFmES1wqyopw2ZQ2ozn0INPM7BYDjuPRGnjyPtL1
	QAhp7xFFhI4u8FDf90XQCjNbbTaPlhyldP5BphkQV+i3dNaG9uUTt4zHgGQrGiCRYfn69pkU+M3
	UObL7xKHvY3lvyHYASrSHQmGhkaXliy
X-Received: by 2002:a05:6102:e0d:b0:789:5b58:e105 with SMTP id ada2fe7eead31-78a4a90fdd3mr5362480137.2.1788616888537;
        Sat, 05 Sep 2026 07:01:28 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9808ee4d743sm3706877241.9.2026.09.05.07.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 07:01:26 -0700 (PDT)
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
Subject: [PATCH v11 2/3] regulator: mtk-spmi: fix Makefile typo for mt6316
Date: Sat,  5 Sep 2026 11:01:12 -0300
Message-ID: <20260905140113.21638-2-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260905140113.21638-1-breno3011alves@gmail.com>
References: <20260905140113.21638-1-breno3011alves@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a Makefile typo that incorrectly placed the mt6316-regulator object
under the old CONFIG_REGULATOR_MT6315 configuration flag.

Assisted-by: OpenCode AI
Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
---
 drivers/regulator/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 5a764cec8..3a0db1be6 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -107,7 +107,7 @@ obj-$(CONFIG_REGULATOR_MP886X) += mp886x.o
 obj-$(CONFIG_REGULATOR_MPQ7920) += mpq7920.o
 obj-$(CONFIG_REGULATOR_MT6311) += mt6311-regulator.o
 obj-$(CONFIG_REGULATOR_MT6315) += mt6315-regulator.o
-obj-$(CONFIG_REGULATOR_MT6315)  += mt6316-regulator.o
+obj-$(CONFIG_REGULATOR_MT6316) += mt6316-regulator.o
 obj-$(CONFIG_REGULATOR_MT6323)	+= mt6323-regulator.o
 obj-$(CONFIG_REGULATOR_MT6331)	+= mt6331-regulator.o
 obj-$(CONFIG_REGULATOR_MT6332)	+= mt6332-regulator.o
-- 
2.43.0

