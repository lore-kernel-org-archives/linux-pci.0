Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445CC419305
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 19:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786131669; cv=none; b=kh4hr3GtxFUXDb/HB6ChWef2n26ep47HdBRTeorH4vG9Phi4iymyl4N/vZGSCXHdwFFNnOAsTOs8QidCDnY5aLisyIMsTFZwZjXiV1l/euzEw4l1n8DrIkKGU9bYaloof5b7jbhOIZF3s/5CtDrqaOpbCN3FE1JEc8GLHDy5FSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786131669; c=relaxed/simple;
	bh=3Jdw+CyC9X0d79MV1LbaD6UPSSq5mFOk7p6L7fDLBfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AERP4ulvNU/XrJ8BCMT9h8hberSmepSEShc4cU0Ag611iuSpd8dooXfmeDfCTEgey73EWCelba0CyYn+MoH2nayJKqcJOxZMm0IE9j/qmdmJgaZ7Ox7IHE+XbimetrpN6PKKsRsdg72eXfUdxOqN9+ed/FYmZ7vsGGKEITxp2LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=SrwJmC3v; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="SrwJmC3v"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e512a9a6bso178395585a.2
        for <linux-pci@vger.kernel.org>; Fri, 07 Aug 2026 12:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1786131667; x=1786736467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9BzvpIUyox01epeMSGpQoUeAfJbQUXyU3IcN4aSet1k=;
        b=SrwJmC3v4OcSq0HV0aH3Sj3t8lfjmybJyzHuKh1lcR+obSCHYa8DN5m9B3G8wjxvB+
         79/G4cnZYd1CZrI2WZhfnhdK4NsiOP0nbBr26xb9GEhNRFpq86a7MRjdJgp5t1s6PC/B
         nHs28ZgehCt5PX4eG9BTmDkR8VpWR7casy2OhNt9QJ52uoWanUx0dKl5MFct9GbpWc5u
         Z0GnX8l9MhivnpS684801Uh7ZPiKaXvAXVWDY3Syu2Uj0ELbX/aghryz7n3/Y6KTNdBg
         0lPSfKDZYE7fSR907cOvJvikRKambS1ZmYe9Bk4NxrPcE9R9YRrerKodJgjATi3IElTI
         WEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786131667; x=1786736467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9BzvpIUyox01epeMSGpQoUeAfJbQUXyU3IcN4aSet1k=;
        b=W81JH9XeIbAXEKJOiIdmyNzwp3qC6Svh+49gsYxP3jRUu7UXvt+LAOt80Nak/IOyqQ
         zWEa2t0lzARvJ1J8RDOF2iAKOsOUdgpMnMODBI35OKIF1RzT7nPseTmrNdQp0BnLfSja
         d3bLrIplwIAEUSUA/8laml81JfCHKXW566OxZJwvANatmf2xtNAtWUzYV1rTnMXYUdfU
         yDS397LTwrF1AIgjig2oCKQiDxWkuergAfUAsPgRTC1aL1o6V+Y5dzUdf+i+QDfQ0krv
         AqWV7ci77SvcmjCteaFmiY9wyqSFpWahI/tvUQagOg3eX31gGq4qbyIj03n1ZikuAEbX
         6ZVQ==
X-Forwarded-Encrypted: i=1; AHgh+RqtC/zpROoCCL/n16MrIi67Cx7h21escJZCOYXWnz2iN92xEpZqGO8VWXPLxM8Iy9DlRbCW5jmuwLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg7AN7cXX5Xuv0jEutsfsW4/Y1jw6W/kccRSaG9IAEmmLfV4Zh
	fZzCFyOfZrC2xYHYknuepe8XY1ieuyM/4DWdjjSCf/GEKv73rX/C+Ju6iQWImvnG7BQ=
X-Gm-Gg: AR+sD10MezG86hSY01FNa4OCCfSj4mOwFV+LXF2QJVHXS8h5DztJHLIuncD81CYftr4
	EqOrnN1Yx3sT/Ws3I7AwZCGjB2u7js7Pt4ZmyVfgchyHA/3/GPeM+sdbGEPnlGqhRWo5bkEsqH+
	VQZqUX60IZf06vmtoSysg7YQGz6lVi+471vWzugn9S1t8ImpUrmPYEgtwZXeKzwtukuV6jNfvRr
	UYCpu4Dc/9OjyZsBKFt5VMAL3iqTTzblZtFGd0tGoOJ/QwQede2XtJE4XM/9YkP3GWeHYiAodmG
	OocylT2mXf2cDoXoxpKpHdbmH27XLijYAPfbD2isKx0gpbFEOfS+emk/U1S39m6MOgRrhbNRWKm
	mHLVdCX5vRXw7khaqvvIHnMsTx0uKiNj/s9bN+Q7/iRKGB0SEGum9Xks4T+at4PKcp0bf00a3Q1
	WoLdqlj3/gHHXl0w4EsaWAxDPdOa+iPtGGHUSmjTe/0xqqiBLpI3lGLxMvvQV3N4G0mLGWwUh1F
	4o=
X-Received: by 2002:a05:620a:3d84:b0:92e:e376:cf97 with SMTP id af79cd13be357-936492cfa45mr1927632185a.44.1786131667145;
        Fri, 07 Aug 2026 12:41:07 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e03aeadsm219786585a.3.2026.08.07.12.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 12:41:06 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: bhelgaas@google.com,
	robh@kernel.org
Cc: daniel@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] PCI: of: make a flags argument optional
Date: Fri,  7 Aug 2026 14:40:57 -0500
Message-ID: <20260807194100.455599-4-elder@riscstar.com>
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

The address of a u32 object is passed to of_pci_get_addr_flags() so
it can be filled with the computed flags value.

Allow a null pointer to be passed, so that the validity of the
resource's flags can be checked without filling in the flags value.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/pci/of_property.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index 22fea1905a080..5e1820b8bb79b 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -82,9 +82,11 @@ static int of_pci_get_addr_flags(const struct resource *res, u32 *flags)
 	else
 		return -EINVAL;
 
-	*flags = FIELD_PREP(OF_PCI_ADDR_FIELD_SS, ss);
-	if (res->flags & IORESOURCE_PREFETCH)
-		*flags |= OF_PCI_ADDR_FIELD_PREFETCH;
+	if (flags) {
+		*flags = FIELD_PREP(OF_PCI_ADDR_FIELD_SS, ss);
+		if (res->flags & IORESOURCE_PREFETCH)
+			*flags |= OF_PCI_ADDR_FIELD_PREFETCH;
+	}
 
 	return 0;
 }
-- 
2.53.0

