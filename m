Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF9D3C1D44
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 19:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786131668; cv=none; b=u0Mi59DU63oa9dWe1+JwYnidSnej/NhjhEoDarZQ38gYCNf8yiM9TBEtTuRjR4QfTYl8brpv7zfI3ItyARI6iIM8zlLP7E9HNOwRNZdHPCud3dqCdfRtw1+tvP/aZeefBGd3rOIz3sndzuDfiIPMXktttWeLX4mk/isy7wADoVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786131668; c=relaxed/simple;
	bh=BtmQtSAcOc1sMwXsSXHd/N0LJhsNzGr+XDlMMcgHhfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzHF4rQLJkMcubqj160jCChFS6ZR3qgTA2Tt0B1hvvLArdJDothvRsj90iZCR310qzRKHgYqrIb4Qy0rG9nFYsGhXUmo7OdXByxxLxBQI0cSP2my6H4EUZnsAeeXymKCutORMMTsrS6ePaVH1JtJj3/YOg5Sw+buFFc1nznoNk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=ITG1RMGL; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="ITG1RMGL"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e6c4a867cso256120985a.0
        for <linux-pci@vger.kernel.org>; Fri, 07 Aug 2026 12:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1786131666; x=1786736466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H/KJ6sckLCdEVJDbpdFqbeYqPNdthT6c5yyUBXrsMRU=;
        b=ITG1RMGLlJNcT4N6D+H2zBvMUKVBItYJwkylrVl3kCL5J/vmB0tct8n7JTnGCoU6sD
         6pZJ1W1Rjn27hSOxGg7C5i6QcLRzdNiCUAZQeN6FhDBjhX8EqksZ1Onbc20rJl2kObB3
         1blCGNJatFXKyjSvd2pOn2a6cPTI8+h+xqDZtFjrUzpqpKjAcYZAgXKJNrwwmcWlPVwn
         meU9FcJnReiMtNTfT2pv27Zrhh4PHPpGDgQNYlDagiIWgYVKHke/lGf/BVcw9Tt8WYnC
         zHzjBmfRv6/xPm+jYNRRrcwBuIzSj3TqWQN8H9C/worxVkrllDdj7j43kP8sgfiNtjS/
         wJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786131666; x=1786736466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H/KJ6sckLCdEVJDbpdFqbeYqPNdthT6c5yyUBXrsMRU=;
        b=Bx7pWmEos8JvIeR4hZfnbnuG/3RpA9NkT18QexwpWgKKWu0JV11oBfE0reitZENmkS
         XpDEw51wzOSnW8Snu1Vi+gnBl/sz2vgM47PJzRmxmv5BDiG0mDwSVb+UQgItY3bN9DD+
         grP+Chh+UuwLzCdUoBGHYWM0ql4GqWqal4SDYQ1VY7fJdiX1U8NJqCnawJAzxR5L5LK3
         TMkraalW29LEv2VCzTJHFnuaPfx1ixZGlzBwwNdS0AjuMaPysMsxn37/oE5stTE13vlZ
         cb7uWmX13Bbkb8RJvHgYAomY5jcLSdPrSN3nhflOxYbO1TEHdOU2/XWG0ARd0NshxKKa
         rVWQ==
X-Forwarded-Encrypted: i=1; AHgh+RqbJkiqjbBp2C6tDShxZ4/4kRFSvSKmAqyEUh1rQYODoJsIReZVdVKeRVgFIST2IDt5QLfPrIVCPLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YysdSTeTbvrhfVoooKoHeHGXDY/J5vU3MgWR2FMUHfApNiWwRUq
	dFEAfAtL23rYnbaax94y5miQH2qpoBFNuLNxWWIUBEotxLZFP84fLtZ9i+LLU1bpG3k=
X-Gm-Gg: AR+sD12FbUjlCfM9r3Ogom00p5hMEhBLTrDjmZ+dlcMdWc3Uz8JI3060bzE9+SQLaT3
	Kuu+3knA2wHAMcuWtkcCy3Ds9ivXBb1B5MEyCr0rtN7LUXn39bb8/01mNumVqasBkNNJGW0Vc+T
	WmxwU7w4sTqv/bJt1jSEpeZuJ8G8m1ctap6widQxtw6+ptql6AAqXPsuStSWVyiwRoAcagkH97K
	MuMLvs32P0hmjuP/sopba4+Gd3q7xmvDhJs4lP8JsrIW8bNlg6ndfvGUqqulhf71g5aqPPL8q6a
	Ux8vZOpbdeBDCsfzskmGbto6T7dW5615X9dXQaVURIKz6O/Iq7yU7/rTfKzKFfRDaKpyt/ty3XH
	60+PZpDF2bruVSE8ObtgJQ84PrMB4UI4trO//PdpvqSOmXvvQMIzC0F7EC8ZvxLEm9K6tK7bYw3
	K8+/dR4p2UP29nX+BgRo2LVRsR5xBzRQSWilGR3j0Dy+HeF6OB1gu9sS9D9LlzEA2X
X-Received: by 2002:a05:620a:690a:b0:915:5cbd:1d96 with SMTP id af79cd13be357-93671f1a852mr727400785a.33.1786131665987;
        Fri, 07 Aug 2026 12:41:05 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e03aeadsm219786585a.3.2026.08.07.12.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 12:41:05 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: bhelgaas@google.com,
	robh@kernel.org
Cc: daniel@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 2/4] PCI: of: don't zero flags in of_pci_get_addr_flags()
Date: Fri,  7 Aug 2026 14:40:56 -0500
Message-ID: <20260807194100.455599-3-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807194100.455599-1-elder@riscstar.com>
References: <20260807194100.455599-1-elder@riscstar.com>
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
index 505226b876c56..22fea1905a080 100644
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

