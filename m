Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27233FCB37
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 22:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790288691; cv=none; b=S9ws9KBcUH3IK6aNY157oZaFqGL1HXrguKdpY3iJFZwQvngIyY7FsobFbrQo66wTQhaT8JCE3TImtok4cqMw55ncn1HEHGRqqCmZiK3UUH1a2NA6yrC+JXmEPvYVJ1a6gXKIp7j64SfLA5exsXJpqZT1a8wIgRKC6TvYM+QzJwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790288691; c=relaxed/simple;
	bh=ucLMqZ1UiBxVGeoeiorG+3ar2kSDUn+x16bRZmYSIRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VlC5nz9yJl7E0eyczZ7qXbBBxCBmNLjo/ThEtifT15+6A/LAMri0kCPuh6ox5XfleGka3jC5AyPfVzQsnL9d2JurTLh3Xod+qhdzpsOqeBWt7bNdady5V95iSltZ0DcyyqNy5hNRTrpkoHKwGtykex1uMOFFS+YIm1JLuNLgDDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=bSVxXmnN; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="bSVxXmnN"
Received: by mail-qk2-f42.google.com with SMTP id af79cd13be357-93be29bb454so41998185a.1
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 15:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1790288689; x=1790893489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X4YnIQUduM9WqwnHXJR5IBSgzIzuiNO0FPLqtzOsUaQ=;
        b=bSVxXmnNxYxEUypEfFbSDgxaAsb3mpfXI9FsJmpdofVWTJPjrYaChdGFynmk8t1t1I
         N8+Msknm37AQWsi8TnGnSGOqLK8CFTds8fVPCx3SRdngr2MoPX4asEcjF7xtF5wNu5hl
         UPMhpoTKKG7sY2lnADUwtSImOq/sW4KdphwzNUqXqINlG7CXxdGdhQW1NBtKEMqTtbCZ
         RcSUqL7MgfbRnHYov/OvMimrUrtzSSENr7I2UZWLsd+N1hmQNfNgwIo6vAvafiTIW9vU
         j2TQ1S+Fa7/X+z6wbJQJDo1EZ2UOHiFAJtpHRhCvpULO8dQABotyMH45Bvyq8hy6Hd4t
         q9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790288689; x=1790893489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X4YnIQUduM9WqwnHXJR5IBSgzIzuiNO0FPLqtzOsUaQ=;
        b=mCd5ZXuJ9TFIhArcn/d0y6V7epEfzNZh4iyw+OanUKQkuQxxDqm0T4nOcE/Ad9cVgb
         iZTMX/vpXy8uW2t0rz5gFH7rjYpy5smzZsZSHPkMwmhCJ7fWIndHsMyEfzn0qrFwZwfj
         UvxTDgEGq6VCE+S2sW0+IQMREp0n/xybFPh+v+nGLmhRDdeCWTdk/olQh+AVnzpuLmKa
         Moa+xIXi2tskOgOPM2DKp27T0noK/8BvFXT0H3vus+AAN/lS+Fky3/+5Ri8gVLWlnLv6
         XNpkiGWvN0quvSJRxedCeYJzK4i9Jp/QRvlezB01vxcmsjj6O0E1VqL4ybOzk3CzGV8Y
         QghA==
X-Forwarded-Encrypted: i=1; AKwUvBxo11n9WJmc+FiN6RxaGedaTTADqHPPTx038SNt+elo8FkuCk+39kGniXaEn54szdEB+pMSEQ5zWyg=@vger.kernel.org
X-Gm-Message-State: AFuF++kfi91G5P8RMbzsTgMtOGX1r0X5W/0mP9b64eUc7ibphcbtgkFy
	Pdw0+Pts9PzEKcJPOgl+o5xxXAmISq1iPlhDgd6AC2QUzRdOYEqKhCjX1xU4AIgez3U=
X-Gm-Gg: AYBFou12JE4rdVeERxMv9g2Xey33pcHdDxVVtsFUp05HLj91ds7BuBiPuHEPXVRjG0f
	sL0JbXS9RM26Jiz17d6cGrsL3yWtCcV4J1CmGglwkCNgwsG40I/0rv1vhkcdg6kEcJo8kpH+3aS
	GP0AxspMkU7SMkO0sf0x/yYptZWij03UtYAAbsaw6iAJRQscgdQJcP7FkL+PG6xrFwjkRpxeiWo
	+qSFuPLz02s5lWOrB156qYFS/lhDeNL5WQ5TZxSG5hJtqa9W4/xOsXq+1VfN+wttOHufhLwEk4O
	vjwY32UoDm1dz2gMwVjH+67gkNdlJIShF/CUvnAJAs2bzvPEin/cBJUHRW1fy8ERRGkfx34Mm0d
	WdJOcp5UEdNjjKx04i4b+nlcUSOrOVzh0WuS6xunv9EPvXxM0bGhfKswNIU2yQvXfgk8sMCD+9f
	MhsZ3LZ7Bivf4541RseggvmD73ImuNF96a28XoBCLlp5gHzmjoNsheDR6ubDTEh+nWMX3fwoawq
	g8=
X-Received: by 2002:a05:620a:3711:b0:93b:e578:5838 with SMTP id af79cd13be357-93c43b86652mr142688685a.12.1790288688837;
        Thu, 24 Sep 2026 15:24:48 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91430eaf5basm3516496d6.44.2026.09.24.15.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:24:48 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: bhelgaas@google.com
Cc: lizhi.hou@amd.com,
	herve.codina@bootlin.com,
	andrea.porta@suse.com,
	daniel@riscstar.com,
	mohdayaa@qti.qualcomm.com,
	lbiancon@qti.qualcomm.com,
	mani@kernel.org,
	robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] PCI: of: make a flags argument optional
Date: Thu, 24 Sep 2026 17:24:41 -0500
Message-ID: <20260924222444.1351466-2-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924222444.1351466-1-elder@riscstar.com>
References: <20260924222444.1351466-1-elder@riscstar.com>
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
index 1e5d7dde467b8..a6c0cca986bdc 100644
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

