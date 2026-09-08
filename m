Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFC4498916
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 21:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788903309; cv=none; b=aG3IZRUNEiRGw1loYLdipKzDbhiZ7yC8IJG0+/V9QkeOsM9pIivTQuucIoNuzk1edmWlbifRwgE2krx7zUKhy6w1r4aWIC7wnX5cwmAeIe0SfWGj92ppJ7m3AABj86YNonLsJHeb9/Wo/yWc0Q7Mi34r8Ifdf9I94d+m1huVJbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788903309; c=relaxed/simple;
	bh=QDjh/o/EJT+5EmtaVLbTs0ss1hLQGrJ710TUSyqfmVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ih8xkVRm9zpysa2sQ9bQIrnXhc6iVxiLwSAaFMsXT2D/+umoVnSQ4ZIrv7SBofgI0p4aVZ6+U3MXgUAqAgp+n6hYxJ2uG5fY2odTd+F+msTndzLk6BRU7bJq4ezeAes+LjjeA0ogF+8S2nkcD0qVvYHeAQPj2/bsM2wfVDh5P9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=st4aBEsH; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="st4aBEsH"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-936c02e58dfso434195585a.3
        for <linux-pci@vger.kernel.org>; Tue, 08 Sep 2026 14:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788903306; x=1789508106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tf53B7+IQ/UMJpYYTrZ14GDqT88z18YWAe/D6JaHkeo=;
        b=st4aBEsHW7i1NfrLpMpkF3zLFb85kFQ/MnrejqSG3m4k/uJ/LPk0R34waRnZZMw1gv
         X7zTxflbU4AVGMQz7jBItBUR9y22FLl+PH5gE7JOB+WAhRXggCwJqZ4+VuU3cVBq8cCW
         lcMiChGLgRe4wTMWvpA1O5e1PqD189DDWX7QX6IuCen/dEIhN9MMf6MQbqrRys/k0Jn8
         rctfaqkhMvmU8C4fxGZ/kz2OgNk1LBqxw9oiihcd9sRSTPg4VTtbxQmkZ8vooThenANl
         Hsr7us/93ShDkNmicoc9AuI3BI86Z6q06hprFv2kAoD56fdGO8lQdgVfeHSeTKqBUvKm
         qMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788903306; x=1789508106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tf53B7+IQ/UMJpYYTrZ14GDqT88z18YWAe/D6JaHkeo=;
        b=IyvRxWe1OsWD0CtV9AjFCIrnAQlR0kRnA3DPw6A4Znr+eL1gF9z+1tOOwPj5H4fcTj
         xCIw3FCN5SvDhGscPDRUGrGU+c7hysWjwCV/w46yeLXvE0vz+xS71FgM6rLg4Y6lhxst
         6ogfss11y5leiHcjRMk+0hIjYIvAfij0jRT946vS9WYkwpYjsSuTVd0LzZjuvtk14vhF
         uLzoFHmvYL66zQ/pZH5fkjBTcKuDpxFBQy22YAmm03Cla2nOagunnHU5e2SxAqtfrHNm
         tJh0qmfLwX9Fc3dGgEScFyR4OkJSAthSCZdxj/j9maP4S23jbKK+4ZxfBO4RA5xKg6YE
         QWoQ==
X-Forwarded-Encrypted: i=1; AKwUvBxw6uqio5dC+U3qScdQ9NfnRWFYlFreGSTOlgHZBhRYH2jJ8FuBglS/jvdfmQ0bb/V5ng9ey9GSqZo=@vger.kernel.org
X-Gm-Message-State: AFuF++lxKmplU09h84hNzv9vnqPszziGmyeGckvaTJmVmAmMUJ1BYHiN
	ZbmcByltvtZ5HkIs7Kztrgx16Etie6IgdH9uLJmoBm+9zGLjyWnKVVi9P5FPFnAsies=
X-Gm-Gg: AYBFou1Hz3ouEmYR2oduFdjp4RO057RQm72BDcplJkNUurK2YE/fCLwqn0qKyNHJd8I
	Ht440I8aro1FRDH2QC3mQ1W10n0q64vGulYh6Hx/l4QZdao+4fB3ZYNxVa3qmUzEEm/l19+b6uX
	4gVCT3pMmsNUeCfPujShG5hEWi2wdBDBQFYAsIytWk+PJisZgFaC0/TDJFV32dsgJ/3btuPGUSE
	p6EE+9rTIKhAO6MJLWvHjnTxm3KZs+sP4WdQSmvu6m5SarE5v6Cf8rdz1/D4LRUPePDJcQkUTcS
	TTqV3gxVXTScTsw6exmVNWt8W+jFIRZyJvRUPbwOEURWdMRA2dXyn9gTFQ/OYud4JvpTRhFJQIo
	GZXYazd0uULqYbOUTM8taJWeBYqiBztzylUl3faOGfa5IGDweDyY/QuprX1xOxLQgvmUHJzJDyV
	my1L7ws/QpdFDbVmhSvxObjz+gwN8BRVzR3ApaVNpMtSGluiIJg8RTSZMNHRU+9lnN3dZ3KbzQF
	fk=
X-Received: by 2002:a05:620a:710d:b0:939:8ecf:6025 with SMTP id af79cd13be357-9398ecf60bcmr2757377685a.20.1788903306440;
        Tue, 08 Sep 2026 14:35:06 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397f9f0734sm1250497885a.4.2026.09.08.14.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 14:35:06 -0700 (PDT)
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
Subject: [PATCH v5 3/4] PCI: of: don't zero flags in of_pci_get_addr_flags()
Date: Tue,  8 Sep 2026 16:34:57 -0500
Message-ID: <20260908213459.2519059-4-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908213459.2519059-1-elder@riscstar.com>
References: <20260908213459.2519059-1-elder@riscstar.com>
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

