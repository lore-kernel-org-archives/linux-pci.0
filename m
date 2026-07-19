Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141FF3BB661
	for <linux-pci@vger.kernel.org>; Sun, 19 Jul 2026 18:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784484252; cv=none; b=osaa91ycTf09LphnEiQ7TJ6HHNL+LpEIXHGJE2+Ahz4hEhD3xsU3DhZc2qNBuCBz07l0ggBwhzMvKwiCwrEN4EpFLZnGSjSQ8TOLVLQ2ccfu1RiShEaWYRxxq3mLLJK8AfOGh6QRE6ELRy/zc/FkZFWgBRMysHohzsWSyGVj0CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784484252; c=relaxed/simple;
	bh=V0Tae/rKozWhabyRfdu4QuNkEaB8DkFkgOcQe8o5wq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OW2lWwuuV0qH4xdxH7GG746C+XRVsUJ4PODHG5BUuRMp9dJD44FP6q31G0YXf1PUA7fGaomYcvZJnk+1cMDkIIyKYFpgbM7e/DdvFIbhXpG343EhGbBvGYwxI73IwZpohcrx19+AffLXzLwmqroaCk/4qOJ+ZGgURMcs2t14spE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfG43JtS; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfG43JtS"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso5402447a12.1
        for <linux-pci@vger.kernel.org>; Sun, 19 Jul 2026 11:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784484246; x=1785089046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uWQkBHme3djyDjtoGqM4G+GNxyywodyr8gsYJac/hfw=;
        b=FfG43JtSl6k2dkdJv1ue1j48FkxIOoBrilaiKruWxYFM28947LGwWga39sjiHmMDIJ
         TgWB5f/dZ/YajU65sC5pzoJMBx/NjJsBsQ7QhEwLeT99YAPnm4FgfBcgXMMTwp76pBuk
         A19zIh+9Fxg05n1+gVcE9ygTvcwo57pK/ul5J/Ll+Xqk+bhLzG4czKkx3fTsCPH+Hbwg
         tLwsoFBEx6MOv4OVTM8uqVvKAjtIp0ZOuNeYLfXBwvPFGaZHCLXiHWlGObp2EmJj92gI
         FXUwej9BaUvPlm371En4fqgIjkZjUcnbWYof5ME9Ppkq1pSjL6G/pqWjaDKT/tTl8GVZ
         svgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784484246; x=1785089046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uWQkBHme3djyDjtoGqM4G+GNxyywodyr8gsYJac/hfw=;
        b=WoRyUjk63pvipML0HkfbBb+1CGWY+c+DemChLBwqypVZJYAjvT/wOGNVcX9yDTgS06
         ASAjKcIJjipXKkkoLsuSlw0Ope441CFTjXq5viKbcQBuVoC12Crc6OZBGtIbUIngvS0C
         YQpduFqMNgkaUGomlk5QHx+wCNabidNF9XkP9vYboJYQ0tjNttBXskaEVr9lnpSbdopO
         BaWUIK6cni16p6sIATpxQYzKaEnA3eo3kXG4SPkqCN8cdGnfzC1v+H0hgsB/gG11u39N
         0FoOIaFkcM1fchs1HHu+u/c9F60uh0waVoiHPRC1IU9nAvxZXBweJWuLrrqs/YV8y1Ns
         J72g==
X-Forwarded-Encrypted: i=1; AHgh+RrC3SnclyrTK8hgXgkOA/IXlpdpj3XlQj5CBPMFAAIzdlod5RPPL9ruq49di0+t+aXJaUAS/WkbC3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8BHitm9xXZd+LEXURFpbMdhwRyNCdB9V9uhiwDwVTxmc6el7G
	HrkJqy0PPurGmekn4fVgPWSL2a8nXpvvH8ZUkFHdBVefojLkhIXi3jc=
X-Gm-Gg: AfdE7ck50mnylbL680QvJ6VdfNsWO+jxorY9DWOKAWT4iv7WWj0/Qu3uAPBQbU5Xduy
	PSe5Z+eGtGTzTtmxstniUeKC9GJdaiturdOn+OZMcSjn3rswyqyX7lsIo/dzB6xBSBN+uGxX9sx
	1S9JXR4kTkmudvQJ84aIRM4lJr3YzStKfBMQZ1CAjFjYNgMkEaxC0ibKugM+pmD3kJCn2Vilkus
	z8pQ8FBeECzvt3zkQcnHOHS72+6hWizATpl2l6DbiszMokhoSsUp7t49PGPBElRGpS5PuMAGWkZ
	gVSEdv4oaHSc9vONuWX0hL1N8ldUHU+W0exRG6GBn4qCp2bq29QobunOGxhOw3wOKchQOAUrwik
	JEq7A3WLL0E7L66do9uvW/SX04DoBI6JpalP0OwBY34V7blAY7OdrPx7MFdXd5gynDYQBJJqyGT
	gCllzt4TGVr8ohgaZgNxAnUoqAIod5IfN6T0yRK3XN
X-Received: by 2002:a05:6a20:1713:b0:3c3:8651:b302 with SMTP id adf61e73a8af0-3c3ad7ac447mr8585778637.28.1784484246013;
        Sun, 19 Jul 2026 11:04:06 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([106.194.66.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a02b7f2sm27967645eec.13.2026.07.19.11.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 11:04:05 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Andre Eikmeyer <andre@negmaster.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH 2/2] thunderbolt: Add device links for Apple T2 NHI
Date: Sun, 19 Jul 2026 14:03:04 -0400
Message-ID: <20260719180308.1398-3-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260719180308.1398-1-atharvatiwarilinuxdev@gmail.com>
References: <20260719180308.1398-1-atharvatiwarilinuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andre Eikmeyer <andre@negmaster.com>

Thunderbolt NHI on T2 Macs (2018-2020). The NHI and its
associated PCIe root ports all sit directly on the root complex
with no upstream port. Apple's ACPI tables name Thunderbolt root
ports as TRP0, TRP1, etc. Find them and create device links back
to the NHI so that PCIe tunnels can be re-established after sleep.

Co-developed-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

Signed-off-by: Andre Eikmeyer <andre@negmaster.com>
---
 drivers/thunderbolt/tb.c | 49 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index c69c323e6952..26529141573a 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2019, Intel Corporation
  */
 
+#include <linux/acpi.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
@@ -3310,6 +3311,54 @@ static bool tb_apple_add_links(struct tb_nhi *nhi)
 	if (!x86_apple_machine)
 		return false;
 
+	/* On T2 Macs. the root ports are stored in ACPI as TRP0,
+	 * TRP1, etc. Find them and create device links
+	 * so that PCIe tunnels can be re-established after
+	 * sleep.
+	 */
+	if (has_t2_chip) {
+		struct acpi_device *adev;
+		unsigned int slot, func;
+		const struct device_link *link;
+		const char *bid;
+
+		for (slot = 0; slot < 32; slot++) {
+			for (func = 0; func < 8; func++) {
+				pdev = pci_get_slot(nhi->pdev->bus, PCI_DEVFN(slot, func));
+				if (!pdev)
+					continue;
+
+				if (!pci_is_pcie(pdev) || pci_pcie_type(pdev) !=
+						PCI_EXP_TYPE_ROOT_PORT)
+					goto put_pdev;
+
+				adev = ACPI_COMPANION(&pdev->dev);
+				if (!adev)
+					goto put_pdev;
+
+				bid = acpi_device_bid(adev);
+				if (!bid || strncmp(bid, "TRP", 3) != 0)
+					goto put_pdev;
+
+				link = device_link_add(&pdev->dev, &nhi->pdev->dev,
+						DL_FLAG_AUTOREMOVE_SUPPLIER |
+						DL_FLAG_PM_RUNTIME);
+				if (link) {
+					dev_dbg(&nhi->pdev->dev, "created link from %s\n",
+						dev_name(&pdev->dev));
+					ret = true;
+				} else
+					dev_warn(&nhi->pdev->dev,
+						"device link creation from %s failed\n",
+						dev_name(&pdev->dev));
+
+put_pdev:
+	pci_dev_put(pdev);
+			}
+		}
+		return ret;
+	}
+
 	switch (nhi->pdev->device) {
 	case PCI_DEVICE_ID_INTEL_LIGHT_RIDGE:
 	case PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C:
-- 
2.43.0

