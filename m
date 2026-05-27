Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1788E23EAB2
	for <linux-pci@vger.kernel.org>; Wed, 27 May 2026 00:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779841869; cv=none; b=pQj6JE+GzQnM/GoZiEgMiXeuRnThmQC9Y5OXW6XhQm+eAe9wUXTR/jrUbe3Y+lF0Ucjql9+l+G3k6RsV+Dc9I8AH3xZrZuaopxPiDrLB2SS0q59s0/Fos1mMnU3m1YMnnjmq0CWjGxNZZmTlNo2LbRfEZp9Ie/KmRFDEYxZwej8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779841869; c=relaxed/simple;
	bh=56hZR2esecc8IXvQ6LfJWlb7Dw4Vo8ZEHwkjvgsTqBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WWD9BeA7xqnc1TCBc33ikdVLhp4kyb4HOi7INqUg9Q/jy8qSr5YEE4gFoOx3NR/oLioIKyCYgGhnNe14CYE5RsWUBFqR6hhbNsMVjeQ/VeujURC4uHbRNy2P6+MKt8MKi0xRe+leaguUlFHJomrvzHie11g3A4XjjkhNPMpx+04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r7v2v923; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7v2v923"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-837b39eb078so7722723b3a.2
        for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 17:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779841864; x=1780446664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/XFpz0HlR/MR311tqNY67oX2GF6bZeQSkrGf+Ws6Afw=;
        b=r7v2v923wf1FHQAR0uoS/VneFvUzHxyHlJDoonk1FA4ssc4gxkAzd+toCuR9LxXtAQ
         jYgsxuoy0AP9QLN3K5l8uzunAZbmwwoYAksTWMHMSP8QlZ002DeoR2IO5JGVd6B1gf+F
         clZHeqEdyWyDU4gxfJ+4RaqHIo4IsnRER2Ck6GdsxyZp789xM4Ly5/aeAQyQm46qfQ2X
         L/0Al9sQNW5Q9i/xfte6chcpZYajVNnQrp7gh8Q35obpWWE+aTq4/3D6CSZP5Lk7a4HR
         4/XfdrJSAzEUWCFQbk2cz0Py0kP4R9U79/yLA5/xsKQVKv1Tuf8Kpcg2QRe9/fYCYTsE
         bw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779841864; x=1780446664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/XFpz0HlR/MR311tqNY67oX2GF6bZeQSkrGf+Ws6Afw=;
        b=ksczaWsT4D06I1d+lDbsQQ9T7BFYd2R0/ElnxGuurXFe720q3a/l0vxsba9X6/WUJq
         mw+kX8b5nwUluCw6l1GEJFnb6XOadESwWegacfgzRviDOEcteKGEYmfovd6FF0sYgXz/
         f9Ib8GL7CZfl2WEgBLPq0Fx5Lz+dmgeLwHurBpB/xYwTWS3rcTFFI9wugyynH6m8OGPk
         qu49M57DEzuJ0LzF8aWQ+AiQeR23apB9b+ZfAkou1jCAxJ4BMynZnN1Eq4kqESdylpwD
         2EHbi4uvcdY53oYWsq03cc+4jY6bdyXrB/nsYSvikYBbGA0Oo0NxV3jXcFzpm3TrWu4F
         hFnQ==
X-Gm-Message-State: AOJu0YyXWw44MQwEO7BRWgY7bEW6kTizceD/N6gY3AlvjfCX9mPnUPfR
	aQplMF4Odjo/XluN2+XmZNFb9ErUvr2eH3OSvWb0zQtNVci1yq8EJXwXG5Uxrg==
X-Gm-Gg: Acq92OEmi3FuTp8aQAqADpDA+8mvCoqf4pwnD2xWDIz+HOYAfQ6rW7hBW/0a3w8g/lo
	mOk8zZJlQJoRc/um67o8fPptv5Rix3QVbVdIrCScJYLi9yg4+IK1MBJBbHXiLIZOdOrIyZL5J4T
	7Y1bxkBAswOd4FfHZrfsXcG/xfBmKVOEo1CqIwleL04HQHl64HdezUsHRIhE9MM+UAl776cTPfq
	SURfnW139H2kbwNsAxIISkiy9dpf1pnrv2D4KY8S9KtuxoMczSNFT6sT9gdOjQpIrVvE+H19Hfe
	aN6ttFRodvMgxrDlYpXnVctAkENgRvM9cVqlthcB+qeBfF7Aj8HMcIOGSEDsiugN0nAQFCGKURo
	TIwb0PE9XB2mYfWc+L6xI91JdeckB9rDAmP3PgE+J6bZpvkX0WLwpLslvhMLOM+hlriwzVuXUj8
	hV6CZn57Zk83iPxV+h04DbNwDnk7zFwUnE7uTM6V5w9S4e/guZR34Lab0C7nTYP41j6hYnksDqT
	TCdljtM7jUfXcn5XrqakAyFZyEPZgZA+W0=
X-Received: by 2002:a05:6a00:3003:b0:82c:d986:e917 with SMTP id d2e1a72fcca58-8415f56374bmr19768382b3a.22.1779841864209;
        Tue, 26 May 2026 17:31:04 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d70df178sm477219b3a.42.2026.05.26.17.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 17:31:03 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] PCI: hotplug: ibm: remove PCI_BIOS dependency
Date: Tue, 26 May 2026 17:30:46 -0700
Message-ID: <20260527003046.20031-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI_BIOS depends on 32-bit x86 so removed for that reason. The driver
can be built on 64-bit as well.

The remaining X86_IO_APIC symbol selects X86_32 || X86_64 so no need for
X86 which does the same thing.

Assisted-By: Claude:Sonnet-4.6
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/pci/hotplug/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index 3207860b52e4..891a81bac5e9 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -42,7 +42,7 @@ config HOTPLUG_PCI_COMPAQ_NVRAM
 
 config HOTPLUG_PCI_IBM
 	tristate "IBM PCI Hotplug driver"
-	depends on X86_IO_APIC && X86 && PCI_BIOS
+	depends on X86_IO_APIC
 	help
 	  Say Y here if you have a motherboard with a IBM PCI Hotplug
 	  controller.
-- 
2.54.0

