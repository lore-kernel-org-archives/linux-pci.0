Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B404D479860
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262191; cv=none; b=le3qnKasrrJ4h6Oe9/Zvy07Ixb5kZrQ/yXk/5UTMTkYZO1288rTryZ3gf+4CydYPW6ZIg16dqPBRz0iJIFfcOVxIdB53ttdBa2oPUgdPn4dDkD43AL1kGkiIJ/ztaAa0RHvM3AW/bLwSIAnvFhXp6VNo41jSe+Ob8FzKr5h/hvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262191; c=relaxed/simple;
	bh=QDjh/o/EJT+5EmtaVLbTs0ss1hLQGrJ710TUSyqfmVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9vHMYWCCXu4tBxnYjcp0IBGwiRTIOm3dlB/C0tZpsxvghrIWOasnRwS2dSIgbUKsHh8SmMW3fWwq6Ny+N2d4Ay+dL3MYaniErr/84326pn6NcssTBO2lBdTKIKf1/ZE1SdGqD4KRPnLp8IxB6tKUQ9/CyNZY4QyLBJvNLThBaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=aE5nwEB/; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="aE5nwEB/"
Received: by mail-vs2-f43.google.com with SMTP id ada2fe7eead31-78a53fe85easo753962137.1
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 08:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1790262188; x=1790866988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tf53B7+IQ/UMJpYYTrZ14GDqT88z18YWAe/D6JaHkeo=;
        b=aE5nwEB/bu+az2TRZJQsASHyKQUYmo+ibWi41LpV2y1W0O9SudI+NbqMnkSD3usw0x
         xUjP141b4TASjfCYMHqbI778zVPKtjq7L1IZ9NWzh/N8y/lXT7HUcHYQuqhAkXRF9P63
         MDUV5QBL9KO2PEN81suVOqQHKeKUv/IRdnKYTDpfulZ4zi83iXTsmykJO8uaMcnOQeIn
         cCm+UgSDmkbJa9q1O7eReLBYLQCO8zmm/5NWS37QCXoapZqY3ydkrv/RqN/NVcK6xrjN
         8sfjgh8/4INK50C8JiTycDr43Xnj7WTzPZXK3PufGm6//MhbL5M6HU7/5R1iR+tpGnWn
         Px1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790262188; x=1790866988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tf53B7+IQ/UMJpYYTrZ14GDqT88z18YWAe/D6JaHkeo=;
        b=HDo4e/nHaixo7ikgO59z6fNEWKrbjAOjxiKCBwf0+oc1Lfd2UySwsf1VPGpKctb0EU
         +QnRcneuNMez/euly2jJPhFXJoB6GIk0RupQ0poghF4Ln8jHfgzrbO3RkEmd4b7g2t4L
         HK002MYJ4vfoUeasifK6Ae3zJnbV9dScxUjz3berEYVRRErrjIzSg1v2qLawnfKKaYrb
         LTfT85YWGmfHk8j3rOBWdbW2waTzAHr+Poj+BIrVNwGFSuABQeeE4OnIeqRJFgeujYPH
         c9GI+JSfzm9TrGMHth6+uzS0AfKFI9dJqr38wxs+79nfn6CvpFVjZnD6NGpySx0wupOE
         JQww==
X-Forwarded-Encrypted: i=1; AKwUvBz4fLLpLvunZfBZyrGAJxcBQyr1ltpBX7giL4AICFQVkPk7OwAwsGq1qhA3FSQwaJ7Nc/9b7r91I/s=@vger.kernel.org
X-Gm-Message-State: AFuF++l4Q+DW/kaQ1aLuLMd6r4CDeh0GtXxDgfpcFcF66NHenjRhw5ut
	AfZcp/gudkGtx0Ya0bHaMWe0BV8+R7mhpeVBaGEDM/j0hPARg5Fv3Bvqa/myInZZ6Pw=
X-Gm-Gg: AYBFou2AbrCjYAcmIxQF4Vo7hTfsmw6VfpDMfoCgJAg74OkQsHJagPGrrqPH2236iqN
	lylAOmlsO7hVe3gCbFW21idknJWXkl+3PNdUKCnyFKXkGIJjE6X6J5Wo0QjX5hdaGmx1FmNuG0v
	wz4tstZaK/OLEbbaVQDheZIRaXEnH9p7zj5dQasl2Jr3cXUqDFswFVZ7L1I3YCQlsM04q6FZbwg
	CDZUtvq1khD85GKsZ2rmxfOboQI8l4hpJZsvqD0WB+w7Be+BuIAnGJa7NGGutWzRAz9ujdnvMaZ
	tzTOWLrVai6vp1UvEJtbIHSstFV0s8vWZXIn9zxwW5X584B2nq910JujXs8Z7l71lX7RpHkX93O
	tn8SDOl0c4ZhFxWVzoJ17FKKfa5YUD/9hd43nsuf9A3xD+KGlNsGf/AG5GoFpLGRXRApbkRRX4J
	wgJFGrdMHKEx+z+S9EZqKKwWTT13TDSy7OBtkDQcAs+96Z5NWU2+cH8NAhwvO0YR/dU1jGZ5U=
X-Received: by 2002:a05:6102:4b14:b0:79c:99ea:2c9a with SMTP id ada2fe7eead31-7af1cba3036mr1226812137.11.1790262150404;
        Thu, 24 Sep 2026 08:02:30 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9141e24e458sm18438236d6.21.2026.09.24.08.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:02:29 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: bhelgaas@google.com,
	robh@kernel.org,
	saravanak@kernel.org
Cc: herve.codina@bootlin.com,
	daniel@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/4] PCI: of: don't zero flags in of_pci_get_addr_flags()
Date: Thu, 24 Sep 2026 10:02:20 -0500
Message-ID: <20260924150222.1179235-4-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924150222.1179235-1-elder@riscstar.com>
References: <20260924150222.1179235-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The flags variable whose address is passed to of_pci_get_addr_flags()
is zeroed before assigning a value to it.  Skip the zeroing and just
assign it instead.

Reviewed-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/pci/of_property.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index 1caabbd4c18b5..1e5d7dde467b8 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -82,12 +82,10 @@ static int of_pci_get_addr_flags(const struct resource *res, u32 *flags)
 	else
 		return -EINVAL;
 
-	*flags = 0;
+	*flags = FIELD_PREP(OF_PCI_ADDR_FIELD_SS, ss);
 	if (res->flags & IORESOURCE_PREFETCH)
 		*flags |= OF_PCI_ADDR_FIELD_PREFETCH;
 
-	*flags |= FIELD_PREP(OF_PCI_ADDR_FIELD_SS, ss);
-
 	return 0;
 }
 
-- 
2.53.0

