Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893099;
	b=H0cAiY8svziqkXWrKt0JhiTrp8Eai1y3BHMDto5+ma5Dl2vDAXDa6BMFmgMyUyWGhRB0
	 uT3XTKIn6oCFANRk4VNzYbOjjUxl2gyaoUWVpqmd8W6HcT0+AQ86gFe1RpoP45ETFEvPO
	 q/4MUiyAZ6m3ndSnUV3+9i5MaLEUqexd9gjrMYQdcIvcY8GEGZQpQiH8jn1cU5vNOxuWX
	 2f6C8CGyfMEmNuGWGD1QB9WuTp8/uV9i9XPDOrUAcu0dplQLCqZUQIO4DmfjTIW+czhuP
	 A3T8VLoKDAo/zkZMrNJr9nAzoUufLnST31zgG6etc5MhHLlx3D4Nad+VS8IEzRGeiKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893099;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kMmLw1uV3pi5LHCM/RrGDzfVn6ZouZUFYmo7ssjRepg=;
	b=wjWPU2z0UOGWMJDEpHCxbRCMunwbn7FhQXOhuTZ0zjk2ETiAGtzWr58lDorfvng4Xm5J
	 UiIHrBXCJXTRpyHsw0WtBYJqYFuzy4EmB9OYVb6VJ1Fzg2WCVhWspp+lgtNLmr/vWrbzZ
	 d/JclRRhYV6ZBg8Fm8uYBE2CTEzE5MP5eqqknOKUMVaxgMZwlTwnyARqoHsBY+p/SdsQu
	 HUVHFTIRTnETFn95nSLtXyva9mtina5m2f1y9gbzusSQtu2LvUXtfNUgH3vINWI7w7NRR
	 WYU3cQQoa8miWH6lzu7Ut3sjlOg7SR+ucO21HvepgbwB+pjL1h96oCppg0G7ynsMpow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=riscstar.com;
	spf=pass smtp.mailfrom=riscstar.com;
	dkim=pass header.d=riscstar.com header.i=@riscstar.com header.a=rsa-sha256 header.s=google header.b="rc/4YD7e";
	arc=none smtp.remote-ip=209.85.167.172
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B89606D837
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 15:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10B89606D837
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=riscstar.com header.i=@riscstar.com header.a=rsa-sha256 header.s=google header.b=rc/4YD7e
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4f699fe49b3so1551485b6e.3
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 07:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar.com; s=google; t=1793893098; x=1794497898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kMmLw1uV3pi5LHCM/RrGDzfVn6ZouZUFYmo7ssjRepg=;
        b=rc/4YD7elRf8QKX5iwQ8IUuHIZusLwUV2o4sNNdW4s0HNwQ01lqT3h893zn6tXKjhJ
         XA81KkfHJrmP95yV4izBztGVksflY8dSf7yJEMtBMq/ttMjvjd6zf96Wl8sVKOgVRRpY
         egWLtYKOlZJu++EXC/GtNXkNuZ7+ehkxxQ2ARBbOq1uuzL1HUh0KhCwDUqPsBdshrVZp
         VKGnhissG60qptdbeaqye2M1qu4Rv1eSnxi4bnCT9CIp/pFddtXFU67TU/x212qU9D4e
         ysYeiI9ox61gymqgFnAml4lciugGvfXpHbQOlQWm2tcTvWiXmIRONvIe0C8+UMtekU7P
         WJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793893098; x=1794497898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kMmLw1uV3pi5LHCM/RrGDzfVn6ZouZUFYmo7ssjRepg=;
        b=klFLMgqovX0vzzQyxqSRFSSk5EIOpyRqs/49dlDy9UB67WAJjb4no/hE4xtOwog3TU
         WrBdL70oBsFXVuhAGaVbio2kJynTzFeH+ejqrTdw5sbwb5eZbUEcpSHpcteFnbwRPJf/
         Y7yMTvAAbm8SHTdJws9WBd8PJptH95ss/LfBke3Q8AXLl8cR5uvRPzTDJs9ZSEpalxPI
         LHNxtT93IUfw1TgIluDyEALP4c76KTdWgmJK/Zz4AFZ3ZF43/fabM8Gm0Es+3bu7oC/X
         pehRYg44xRUwVkshJO70VPQ0xz85V3EEMRxJkSuapSj+8N9N5Fq2/txWABsPYXXb5uCa
         j7uQ==
X-Forwarded-Encrypted: i=1; AKwUvBxT6G1tgCIferaa0iIzYYBm3pn+zbrTemGUNvcAxGB1Trmti8uyIKgTTFDPnsB5bM9FkN0KfodNzcA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9AD0CWK9ZtJnTFAfhCkEchZLN2W/umR+NF9mRBjPB4oxZxYAj5
	4+Qh6jskwRdZlPPX13w4uNSUHWxbHQyi+dSM2bqaxqVRouFcv46UD862AIsZRHSzlvk4Ls7kyVI
	jQfR5iWU=
X-Gm-Gg: AYBFou0CCxKZFmZmwyAOmWJvAa03oFN/rMazaAp6rEclaJwEo8L7M41g/mWG6DZ82v+
	PaTUxSilojIxjkLzbO+h7B9GtLJ+WcgGRCRLEyonamnnW7VFlnXMQPE8Dx95W8rs/hrSDj9fdTA
	DJ4orBGlqYGnzdWwrYKplhyb2SGAwAfuz30IRwr0EyoJsMkXJFPbjqWoM43Kf/M00AwKDrirW40
	bAm9YXD5xIinAMG2TZ28HNf6qm9Gs4/uq8aTvWA4ZFzzMI0ZkfWoYHevnyvyKOqkZWrOsAcjXwf
	gQkcSGhlLRUmy+qRNfsEG/aJPu/p6mspQvygkVLa92d0AxFV4mZa50pQFVChtRiEJngEg3fPPWI
	Noj65L9Q0KY4U2PFTI22Y03rQ8JDHDAvtDWWcF6a9JkwtTycQUctMMgRWpa/rOnvbAXuGELPeCh
	2NVIYb/jaywTN/ImtU1rVfg1+nOi5QpcTUeJaCgxpItsmE5aKl3Z60ZV+BX+mM+hnrJ1UQ4Rj/c
	2XZcVmo9Ylm1ln5Ygwcfbtd9xHanC6CeD7U4GHFLpz4LeOmJqQ6+QQyCDtdBGFC4nVDtMV+k8X1
	r+L2CpX5vBj1Wi1/T8+6W/u0GceuWYZUww==
X-Received: by 2002:a05:6808:1b2a:b0:4f5:20:d847 with SMTP id 5614622812f47-567ad7310femr3867051b6e.36.1793893097926;
        Thu, 05 Nov 2026 07:38:17 -0800 (PST)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9ef6e3bsm4435329b6e.5.2026.11.05.07.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:38:17 -0800 (PST)
From: Alex Elder <elder@riscstar.com>
To: bhelgaas@google.com,
	robh@kernel.org
Cc: herve.codina@bootlin.com,
	daniel@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/4] PCI: of: don't zero flags in of_pci_get_addr_flags()
Date: Thu,  5 Nov 2026 09:38:00 -0600
Message-ID: <20261105153801.435566-4-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105153801.435566-1-elder@riscstar.com>
References: <20261105153801.435566-1-elder@riscstar.com>
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

The flags variable whose address is passed to of_pci_get_addr_flags()
is zeroed before assigning a value to it.  Skip the zeroing and just
assign it instead.

Reviewed-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/pci/of_property.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index 6236dfaaae628..702675672fbc5 100644
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

