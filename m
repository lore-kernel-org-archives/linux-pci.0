Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5903498916
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 21:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788903307; cv=none; b=kXsPWd69NcAfk5v6CYqIhtMc2as9BUnyWk2MSYfTY78kKrsamB+1DtXP/UlXvwGFUYRgjzlzyjUCC7/4mX7mGtS4ltSKoT8pGbttGfcgCa+3f9KkxJdsfhw/cLv3zKXismCf6tJCIbANgTNgHGidDEdGvXXZ5fG+jretqyofXAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788903307; c=relaxed/simple;
	bh=LRZ8vmf7yVnDP8AHhwc+k+6VHYjhFocJjHx3TQ/DOkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IsmdKFin5uegFfCwT4fozuLO3gWibVTqYXdgaNUuH10voPbxNgdmnZ4Ry/Y+xu/+2th5saOLoDmzm3q1gQgOo9YiqHFWViCCuzIFwwga43SbBsJIS6S6Mpky8E9ltk4WoCry5eHjNzSMMWyeaH8kk/wHhCLYg7HYSxC7Wn42Abw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=WBw/Q616; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="WBw/Q616"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-90e8e70fa02so55733806d6.3
        for <linux-pci@vger.kernel.org>; Tue, 08 Sep 2026 14:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788903304; x=1789508104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OlXU1fYfQVNOpzWxYYTTBNzAHTPsq9zYyGkBJYPHark=;
        b=WBw/Q616nSnQpo3D+YhR6IwmFP6QLF2C721MeiAH4C/BgqiGBVMsjUIqMiMr9DYu4m
         rzEoCvldkH6dkV15IswfMJIXfbkcEX0TE+R2vtClZIKoiewx79xLemr+9oeLamQrqy7y
         jzLrt2+zONY8tRhoroIA4pnO1x7gy4zmr1QJ/0Tea8z4GroRvwDnDoYJa+ta44Oyy2hi
         rsffKmE7v1ClR1gLvMyl7TDVwE5ryNB4c0wX9aJX7/obtUyrqfWuOB73+FEOePoKDtFU
         RJVBGJMgyylmzDcg7rzLjmR6H1xaRxGbVgq49uBRlyCtrBJN0xdU5OlmwC9vC8rAfDp4
         2Giw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788903304; x=1789508104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OlXU1fYfQVNOpzWxYYTTBNzAHTPsq9zYyGkBJYPHark=;
        b=LL8pi1UHylETT8qnsUHFJWzwJvTNRUpOvF6vH6btJt/b8xPcd5+6nOn1z0O469rVo7
         7ZgfxJxjF/xOQy42Y1fZGThL0yWhjza4v2gf/y1OMfYIGVnyt8v8abcbb53pYPr5M4u/
         /OrbodmsCSP8Dr8SGTZA54liZ1A/ECNIrQZo8FXDaolWJoTLrmenZmbOlI/CEcozUxbJ
         F3g4DEgf0ptVoCZoNDc4Fd/KUM4bOE3Mj59dqO3xGFOS0SdHDW1Ef8abuAuUbXVTYzzG
         YkkUbc7lGiRfj8R8QqgHjwDoCa0c07tqlmUPCGzBxoHCq7WlP12ShS+lQiH+9tbIkOa6
         wnfQ==
X-Forwarded-Encrypted: i=1; AKwUvBy4Tf0ssQutQpsL6MfuA+2TZfR7sVzZaekBGuPKYU+zeaR92wdXhIIac7lyawQoIMJr02fbGKSHlwk=@vger.kernel.org
X-Gm-Message-State: AFuF++m3EMmZEb4BZ8L/gndLKsOY3Q74xxYjUgqJYt+s1Uq8s90NVs+Z
	bvnFGGBKUni4CFe/qIMDLlfUHsys+M3Y2FQzCRpNgoY3clAg0oEG0dCQv9DmQbYyGe4=
X-Gm-Gg: AYBFou1A5ncsZ2BLB7iivO7TazL+7TOtkUuDFNGTPoiDM4qdikiJo0JKLpclikXX4Dl
	v6pmQSDpEd5QEFwLDiksQFEhu3TgjfFVuwfI9trmoiyrHT4wda8h+edtUYGC/QODklkFMvA6+uU
	eIakmM0X/gKgCph2AgC6G/SCjoYcvZMMmgd132A1W9w+RYkfnJCGd4AuwZj//TVvLNOA/pFVhDG
	Huz73ObbW3IkbYdOeQA5XvJKfdTUiN9VWJe7Oq3w4Z4A7sGt+XRPqWlaABr+1nBzukyv6w5dYHA
	1Xs5/MFEJN/f/71hMGXl/oVE0X+a8g9Pw8+3h/cUQoTfagdvxvScEMa3CRHjx+o/fU7y9o7bJN1
	RhW7mvbwDlARixLtSqV1eZfZrNHtkFyz19PZWAyRnPYMDJ/3z/QjnqNn883LyIxZVSJrBdQjwMq
	Bs83+YRzffINrSKDb854G7UpRfqCi4j0F91CL3lsSSjBs8SxR3zPG92A0tnNtLjBPs
X-Received: by 2002:a05:620a:6989:b0:936:d833:6a35 with SMTP id af79cd13be357-93980133923mr3591761285a.0.1788903304149;
        Tue, 08 Sep 2026 14:35:04 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397f9f0734sm1250497885a.4.2026.09.08.14.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 14:35:03 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v5 1/4] PCI: of: avoid allocations in of_pci_prop_compatible()
Date: Tue,  8 Sep 2026 16:34:55 -0500
Message-ID: <20260908213459.2519059-2-elder@riscstar.com>
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

Three compatible strings are formatted in of_pci_prop_compatible().
Their sizes are known in advance, and the largest is 16 bytes.

Rather than dynamically allocating the space for those strings, just
set aside a buffer on the stack large enough to hold all three.

This avoids a problem that Sashiko pointed out, where an allocation
failure would cause subsequent crash because strlen() is called
unconditionally in of_changeset_add_prop_string_array().

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/sashiko-reviews/a647bd56-7dc8-4fec-9d96-834622054cdf@riscstar.com
Signed-off-by: Alex Elder <elder@riscstar.com>
---
v5:  - Made "bufp" have pointer type
     - Eliminated the unused local variable "i"

 drivers/pci/of_property.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index 75a358f73e694..d66c702218081 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -324,27 +324,36 @@ static int of_pci_prop_intr_map(struct pci_dev *pdev, struct of_changeset *ocs,
 	return ret;
 }
 
+/* The three compatible property strings have max sizes 12+1, 15+1, and 13+1 */
+#define PROP_SIZE	16	/* Max size of each compatible string */
 static int of_pci_prop_compatible(struct pci_dev *pdev,
 				  struct of_changeset *ocs,
 				  struct device_node *np)
 {
 	const char *compat_strs[PROP_COMPAT_NUM] = { 0 };
-	int i, ret;
+	char buf[PROP_COMPAT_NUM * PROP_SIZE] = { };
+	char *bufp = buf;
+	int ret;
 
-	compat_strs[PROP_COMPAT_PCI_VVVV_DDDD] =
-		kasprintf(GFP_KERNEL, "pci%x,%x", pdev->vendor, pdev->device);
-	compat_strs[PROP_COMPAT_PCICLASS_CCSSPP] =
-		kasprintf(GFP_KERNEL, "pciclass,%06x", pdev->class);
-	compat_strs[PROP_COMPAT_PCICLASS_CCSS] =
-		kasprintf(GFP_KERNEL, "pciclass,%04x", pdev->class >> 8);
+	ret = snprintf(bufp, PROP_SIZE, "pci%x,%x", pdev->vendor, pdev->device);
+	if (ret >= PROP_SIZE)
+		return -EINVAL;
+	compat_strs[PROP_COMPAT_PCI_VVVV_DDDD] = bufp;
+	bufp += ret + 1;
 
-	ret = of_changeset_add_prop_string_array(ocs, np, "compatible",
-						 compat_strs, PROP_COMPAT_NUM);
-	for (i = 0; i < PROP_COMPAT_NUM; i++)
-		kfree(compat_strs[i]);
+	ret = snprintf(bufp, PROP_SIZE, "pciclass,%06x", pdev->class);
+	if (ret >= PROP_SIZE)
+		return -EINVAL;
+	compat_strs[PROP_COMPAT_PCICLASS_CCSSPP] = bufp;
+	bufp += ret + 1;
 
-	return ret;
+	ret = snprintf(bufp, PROP_SIZE, "pciclass,%04x", pdev->class >> 8);
+	compat_strs[PROP_COMPAT_PCICLASS_CCSS] = bufp;
+
+	return of_changeset_add_prop_string_array(ocs, np, "compatible",
+						  compat_strs, PROP_COMPAT_NUM);
 }
+#undef PROP_SIZE
 
 int of_pci_add_properties(struct pci_dev *pdev, struct of_changeset *ocs,
 			  struct device_node *np)
-- 
2.53.0

