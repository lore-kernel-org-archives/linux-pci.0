Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52953DDDD7
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 07:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785139154; cv=none; b=dykTFstvqgMBNzVl1SOI6nJs8CFvx1oE5tXbo6Zc6FY9k8PqXU6TSGxH4YSo4qLqbybPMRDQOyR5JCJxFXyG1h2Y6igOMOk8st42Cwb9u+aJg9tkNNEiXgN3QtoTHO3qe6VlNecQsrZEQushz/cTb3kNHq6wxf+DInRJzTZ/bSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785139154; c=relaxed/simple;
	bh=EbnUXDEiH4aXd7svurft8q4vb7XSEmBoWUkT4ZL4rnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FrxNYXn7spyVVaOV5kRr6b7ChB4vi8ZX3VLVzEZ/Plo25Jzhs6Uk8MqhuoSndtIRhX8B1HS1CLKXabXBziqgdA29fBps0JW0FvP4ZxDzCkaACsccjV3XPNpPGsV3tpPBi0ZIaP1vVKmcGB7rA/l1PW4ef6DAOfXFzNHB9A3smWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I084IXkL; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I084IXkL"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cf41bab353so32551225ad.0
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 00:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785139152; x=1785743952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wvZrTTp8XTspOh3eFR2KOmNstM1K6wskKfXxNBZ4/oE=;
        b=I084IXkLP5zUliNOTmTG6s9/FJfNWSc8isX4eGGRUal/ycL4lI1UbJzE8WGKklQrM1
         1jsaQ/PnE0Utxy/yZ/E2h09I5C9z3dvzAezdc1YTOiZOcATzRlXA6OnVaSBNpx+DyFNd
         06J7OsPg6qBW0vGAPFlgN8qjfPu4KEnAvvB6vbAloDMeBf67UGG2xowDU5Uc98dimNAk
         PjZS9WDp3jXYwLhvbxbLhOl6Rdz2c7B39kxj9RlaGejKPAwSghYFEfZEn0d6/0H4m6fw
         MiAWOtuU9WP7C8gtTzuUux9nsLYEyWjdDpHuCoRe+sV0TntiJXnjcYt+pfVbWlCY5FzZ
         F1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785139152; x=1785743952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wvZrTTp8XTspOh3eFR2KOmNstM1K6wskKfXxNBZ4/oE=;
        b=STXECj1FxaSvM+7ibXtSYC+dNW++Mlc6dHSagsYvsbmxx+6Q+jVcwSLaeKjiGh9eXf
         afCObFs2yoenC9i880gQks5JcoQ1v05asExigEkCtQilgnSaAKjXkmr/WK82G9hra9m8
         jDVgcT4QVP6yM4xhR2t2DpkZoA9KHVRqEn7i4ZiOz0u9JMSZ0ALocrZ5WYWfwvm5SMhg
         nS0l7HUHziVbLyCnunpIH/jkt0SijGiYkaOXNXHhtPMfpqnvN4yOjIcxARqkMXDtZEcM
         37Q/rtW3hbDB1OKIRDQTEbyh/iZtfrcK7AgM8jgDMmAu2P5b7e7qv3CxVDSaQCLzDflO
         9eGg==
X-Forwarded-Encrypted: i=1; AHgh+RrRdgId8lgySzNPLl+hU9J84SDeajJxC11/hnJcMRAuG2ysw8cBcxb7yIzZkHWCd/EatY71U3DcKwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc/FXwIB0wks78YmIyQG6JcbtOjlqcCobEv0J+vU5bzNNNw5Vx
	sm3zKZjeBpnWrYte/0QCobNDPObmGmy7b4hF2uWji8dNAofz+wAtKr0E
X-Gm-Gg: AR+sD12f+iq76wrFMZ6SFsl6lUObORilikULbtNkcnUZoaUtkIUPOlv0n8ccm4Xs2TF
	rJbSRTw6cw558ogRNqOx9QeV8TOKCVnpYITamGSugJan3G9ZR3rx1f/ulgYenGo7cRHFklR5rKo
	xQiZkqxaOBtNx9yuGHsMFC55ExlA0uqpMuEPSGxh53gYDcGYb5MCC7mLmu+20e+is92A4jldJPA
	ExjLNnBWB6OAWgfytfzydiic/fHGMXQtvF9E5tl9xL/hnDKOAX1Pqgq8U/EE6qT3/9Gkd2HKRRX
	/E8MuoBT0ne9dWNWe3K+egcTgnDz2GBpjG/fYh9twh/MsxHYdVxfMWI1ZfU5CWUodanAg9S6b3z
	qG9vxGbeik2fTVOMZfhrrmUazBPGfwba0/3LjDCnkfU147n5A5hB31KbLdVKHEKQ1qZEYdvFPLy
	nCH3xgNkiOBdfnRWQrGylnqA==
X-Received: by 2002:a05:6a20:9e49:b0:3c3:a4f4:c5c1 with SMTP id adf61e73a8af0-3c67e102104mr7113538637.60.1785139151974;
        Mon, 27 Jul 2026 00:59:11 -0700 (PDT)
Received: from kernel ([103.219.206.53])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc548f5dsm34056767eec.17.2026.07.27.00.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 00:59:11 -0700 (PDT)
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: bhelgass@google.com
Cc: robh@kernel.org,
	gregkh@linuxfoundation.org,
	skhan@linuxfoundation.org,
	jkoolstra@xs4all.nl,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
Subject: [PATCH] PCI: Fix unmasked value in pci_generic_config_write32()
Date: Mon, 27 Jul 2026 13:28:52 +0530
Message-ID: <20260727075852.4688-1-raizudeen.kerneldev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When writing less than 4 bytes, pci_generic_config_write32() uses a
read-modify-write sequence to protect adjacent bytes. The code comment
states the goal is to "merge in the <size> bits we intend to write".

However the code does not mask the incoming 'val' before shifting it.
Since the function 'pci_generic_config_write32()' accepts a 'u32', a
caller could pass a value with extra bits set outside the intended write
size, those extra bits will shift into the adjacent bytes and corrupt them.

Fix this my masking 'val' before the shift so only the target bytes are
written. This makes the code do what the comment says and matches the
read function, pci_generic_config_read32().

Fixes: 1f94a94f67e10 ("PCI: Add generic config accessors")
Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
---
 drivers/pci/access.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index b123da16b63b..47b38d01694c 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -176,7 +176,7 @@ int pci_generic_config_write32(struct pci_bus *bus, unsigned int devfn,
 
 	mask = ~(((1 << (size * 8)) - 1) << ((where & 0x3) * 8));
 	tmp = readl(addr) & mask;
-	tmp |= val << ((where & 0x3) * 8);
+	tmp |= (val & ((1 << (size * 8)) - 1)) << ((where & 0x3) * 8);
 	writel(tmp, addr);
 
 	return PCIBIOS_SUCCESSFUL;
-- 
2.53.0

