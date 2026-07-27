Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B186F339872
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 08:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785139613; cv=none; b=RFSHXyfHfqPy7ntROZRoR75TT9nvP0aGE1UngwP16binsRopHnoe6Nx+iEsdDeYVhVGB8aGX7ZX+mUHgB8Ko8Uiu+uZhLmcjFWK2yLPCB5tpHUDtcMduIrf6JvI9FA3RzMUl6L0z0qe/eA+j0qdVRohPPP8N9NuDLg6ekWEglr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785139613; c=relaxed/simple;
	bh=EbnUXDEiH4aXd7svurft8q4vb7XSEmBoWUkT4ZL4rnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O8QxUAD3FvsHuiQOZU7c+APiCk0cRiXdPo/TxbvKwPqYDBUEC5+jG4E4j4rLdyf+DnrBTBFORvhM13jgApfF/KGx2P7V0jqjiHIf8yodVWk6rx9yTaMSpRGeX7gSuRYXp5sRfbJHTpKk7Jut7JJ671SrzFBClPh3UQ6Kv8+y814=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k69UFn9t; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k69UFn9t"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca2fad0ae38so1691145a12.3
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 01:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785139612; x=1785744412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wvZrTTp8XTspOh3eFR2KOmNstM1K6wskKfXxNBZ4/oE=;
        b=k69UFn9tSr0ZveQ3f/c5tFEAZVc1gqdsPxLCT56gVMETZHXpkzLmopYdOnivz3YHK5
         tNkvs0tAWruVVsA1sDhRS9dinQStjsN/zQNfCMifTvGKYSu7b6VHuso0ik+tZOmNh80q
         de3WmGmGUxW7xwQWN+SbsKEPNWy5RMYNmNc6xuznQzoHSU6EfWzFW/OWnSrjWu9AiY6p
         ymLp2YhyBA0wsCyiHhUqlEMS/OC+1awuvZkAm5Pp6qqMhiUdwVG8ULMhkBupXZsJEv9Z
         tKzXmYfnpK12DuDBn/AfZGvgQgMs3eoH5J4SErOFjz3N4s1uSiiDngE3z5i3pJoz8kKc
         OiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785139612; x=1785744412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wvZrTTp8XTspOh3eFR2KOmNstM1K6wskKfXxNBZ4/oE=;
        b=phXpPG53HnsKOh+KJPR35ATSLuhwO4faMa0VZ9XUPiHRpE50X/vCpHg0B1S9wdQ7WD
         bvk4xfy5x0hIzeXO1WG/ZETTvu4dxPsnrDqK1Yx2rO19LgQDyPXofnvpF8URDShK/y+6
         b2HuUMlNmUkR3lPUiXq14VyFE4FOLM5AOp80nljYk+jaIGInFhMxPqG30JsmQprk5DfU
         qgCe81C0ZvAE9fF2FOSCjodZZhoLIbTqdrRXrRtflG0cYrAbpccTQzzjUVQzb2fpBjhA
         dQNH/vLs6eDx+ABWwa16FqPmL1HUJLliZeJ2hHbEj5ZAJkT0F2sdihVRKPuedYAwZcsP
         u34Q==
X-Forwarded-Encrypted: i=1; AHgh+RoVdupTbwixJmmuS5nQ2tVQEvhAvpqnVroZTVFZjqHD0bvrkntYXNPUgXpMpMorWP817+HePE2iXV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmXTtZ0odfI8vjcjsOgnbMMZ2mi3WhXqk7nD2JzmIaKrRghoIM
	bbwDQbzxRZLxj+eSjRFD+nBkjvFuNI4B5G4/xJ2DiZdIQaui0dihmgMD
X-Gm-Gg: AR+sD11LxcKz/1xkbGMmcVj7L3gNdb8KO7lGjN7klcfgH2Y2e1yYcg0M/eWyrNhaKuT
	pdVYpaxNxrG7yfDyLBrUQoA3CfYLSaL6Kpq+cXccb3rXpGcr6xxKwcASZ/AelRmT+ejRiwyPd2z
	fPUpstge3oY85EzDnJJDISepSc/b63HARqi/abMLOsXoIzL29o27pqc9m04A6D7J+bW+tnm8Pe6
	OHzPeBQiv0DCukU0yDQ1GomTynUu7/JIrpP6bbQizFTbgjRkF2I8gGl/lHqDFEXJ8eVxpTdKZYv
	QbXKXl5nZinm2bAAlopM9WYKzZTcZV360R21HrxUVOTs27ydpG4Hwsnf1d1xj6qTTPg5qyqpYam
	I9b55VuHyuvyWw1Hn+j91oBDntfkAcZ8jvBXBPRhoz/I90OuuA3R0jTb2X1KIn/FLADs2I9Wh1y
	uwnUxn6isaJbsTN4UT8CIqnw==
X-Received: by 2002:a05:6a20:a11b:b0:3c6:61b9:917c with SMTP id adf61e73a8af0-3c67dae9646mr6747557637.11.1785139611907;
        Mon, 27 Jul 2026 01:06:51 -0700 (PDT)
Received: from kernel ([103.219.206.53])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d2eb01aa0sm40129390c88.3.2026.07.27.01.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 01:06:51 -0700 (PDT)
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: bhelgaas@google.com
Cc: robh@kernel.org,
	gregkh@linuxfoundation.org,
	skhan@linuxfoundation.org,
	jkoolstra@xs4all.nl,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
Subject: [PATCH] PCI: Fix unmasked value in pci_generic_config_write32()
Date: Mon, 27 Jul 2026 13:36:43 +0530
Message-ID: <20260727080643.4949-1-raizudeen.kerneldev@gmail.com>
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

