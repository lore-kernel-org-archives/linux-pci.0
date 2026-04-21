Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1852C1A6824
	for <linux-pci@vger.kernel.org>; Tue, 21 Apr 2026 01:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776734466; cv=none; b=KtHa8bKFsjwG242cxeY5WRAS62rN40WZ4d9DGX75DsfSNsG0SNBzxUTKX8xH5yII5VYotcLDC1Eo/XFWtL1oawA4iFww6x0cUDVwrUvRFFFfr1dKwz10YA3D4DyvOQ1P4U94OEjtdJM8qdj36sEzx4mwNF2tDXH2p4gER6sVdHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776734466; c=relaxed/simple;
	bh=vRCSbqHXwyn9w0QgeLkMbQIo4v+alkRVoWv3vOxbJqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mXPDHh/3fTd013oR+3HvfBuClq9uqgFi/xraaD6PCADuHY3iI9rLnt1j42wq/kmZkTupJQaKekNj1UZHlMDfik/X4yIt2XMiNBBOGGnZCBQIvE/loIybEj5E4f0ZYipLJgi6G5Em5WIu+bsSA7g0vQltlKOq08c6JkFib2rRERo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qkrfcZHA; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qkrfcZHA"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8a4b8c3a30bso44014916d6.3
        for <linux-pci@vger.kernel.org>; Mon, 20 Apr 2026 18:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776734464; x=1777339264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hEOtQ4G+O2Nb1ePWGM6JmoZNeLxsvMXbczlW0oI7404=;
        b=qkrfcZHA7il892KK6iTwB5Af9JBz31HA4aj4AYEkgJqG08+9tjOYZW0KPsgl9o05EW
         WeHWHzqPjUPvVh+VNfD8iphFw1+xJF9M/z8+84m21bPgy4F9tFuGvSil17rU4rjGMCWe
         YP9Hwn3H0wHA5f7NtTmTNQgrsVlllkGpXtZdxmX5Q1FBbT4Z6kE2CGAsGQoOt1Hwyj9k
         NgjMGEpDytKAbBMw/kG4Sx++fdZ3lOqAmcodkI9enY0pKt1dpUo9FqCC8rky+ZTfrQ7/
         eBQe6JpipgFFKX9Fr2DmGd0FqC9beSxNdIN7c8b327OjZhOBHOrkntVM9nOxCqxMKvOE
         Um4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776734464; x=1777339264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEOtQ4G+O2Nb1ePWGM6JmoZNeLxsvMXbczlW0oI7404=;
        b=gFcCC/7qeJlAvBzswb7yKTUmiJHbEGnTq0U87/1rzwvwYkB+c2kIVUQdtFSvzpFWl7
         loobM12NxW15crjftraG6WIl97+Pln8kxP5BYF+KgXKJv7s7ijxZrtuX4HhM/zMjKxnq
         zgUdEeowh430ttTvpBj9q6pU7XD+0Zgy3R9ETjYmF8FqOcgf5J4tKEoDNYeSFFdYtohY
         B19KtZ5M/HpWvI9AOSYGKYzhFNV5Yf31HpZj516riVgXbBb0ETzbOBUgkYPZTNmrVQ9D
         +BzhnNTylTPhT5SWsX23rTNz/vlB+jf5Sygjd0WytwUNp5Pex/mnd4FWG2Q0Z7S+/wEA
         48LQ==
X-Forwarded-Encrypted: i=1; AFNElJ+H7IhTb1pSgRsV5jUb3vXTWUfdAwIt3aOKaR1o44ZDmWzPODPw026m3Ev1vJ+Ec9sKKrYxpjA7XR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdT9Ir2PKId67G8k+u3F7w4X4Jhp4S6JBTGVf4IE33HSN5oTyF
	fdRo9JU85Tlrure2oYXxqpc4MjlkvLf0gCjtD7Ox1hWnI6agm6iEBhva
X-Gm-Gg: AeBDiesQwT3A2uOfVT1vc5ODdwZsuisTENPxQ0vNhA+IcqbyD7xfQ79DVUl5H8u55FJ
	z/yX43unDY8W+6lEakiwB3q3iYPZnkKG4fm/PzWT8XXG2C+bXzDteX2tlTL4vAzUURd251B6bsl
	0R6k33RzELz/GFS8m/qsE96l2sU7N+m3Jm1i7BJQiMv1h9PWMJUyi4ZefbenlDGEBE6K0hj9/g2
	gsKEaEJ6ohNshN/aO6S99K5E0PARbKpCzNDSQrTKX7+CyjSsQCK3/8+YJLQWRyca/0S9B65rbVl
	sluW3s/bXG6I7NAdsDdfppZofsznXwb+59x9T8v6FQctgWpYgwR1cSvmgDVP9hKXA+quQnIJ7pk
	iuXWEBnidBQdWgJYYER3sYZ9X8sUMJVDbZ7+aSGbSwp9M55Mi4cedr+ljSSyznD20FnnvIk3lhi
	MqJFLdlFWxeLA1dF5ywXL8F3VP4qO/9lgOupIKzH0C/R6liW/RZ88sO6XTb2SVw7Ul050=
X-Received: by 2002:a05:6214:4517:b0:8ac:a8df:639b with SMTP id 6a1803df08f44-8b0281f5138mr280164806d6.39.1776734464029;
        Mon, 20 Apr 2026 18:21:04 -0700 (PDT)
Received: from josh-ThinkPad-L14-Gen-3.. ([76.78.141.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae61332sm86911256d6.24.2026.04.20.18.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 18:21:03 -0700 (PDT)
From: josh ziegler <joshziegler76@gmail.com>
To: bhelgaas@google.com,
	corbet@lwn.net
Cc: skhan@linuxfoundation.org,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	josh ziegler <joshziegler76@gmail.com>
Subject: [PATCH] docs: fix typos in Documentation/PCI/
Date: Mon, 20 Apr 2026 21:20:59 -0400
Message-ID: <20260421012059.251492-1-joshziegler76@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix "chose" -> "choose" in pci.rst
Fix "result an" -> "result in an" in pciebus-howto.rst

Signed-off-by: josh ziegler <joshziegler76@gmail.com>
---
 Documentation/PCI/pci.rst           | 2 +-
 Documentation/PCI/pciebus-howto.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/PCI/pci.rst b/Documentation/PCI/pci.rst
index f4d2662871ab..be35e9a1ee75 100644
--- a/Documentation/PCI/pci.rst
+++ b/Documentation/PCI/pci.rst
@@ -338,7 +338,7 @@ the PCI_IRQ_MSI and PCI_IRQ_MSIX flags will fail, so try to always
 specify PCI_IRQ_INTX as well.
 
 Drivers that have different interrupt handlers for MSI/MSI-X and
-legacy INTx should chose the right one based on the msi_enabled
+legacy INTx should choose the right one based on the msi_enabled
 and msix_enabled flags in the pci_dev structure after calling
 pci_alloc_irq_vectors.
 
diff --git a/Documentation/PCI/pciebus-howto.rst b/Documentation/PCI/pciebus-howto.rst
index 375d9ce171f6..9cc133ccdeec 100644
--- a/Documentation/PCI/pciebus-howto.rst
+++ b/Documentation/PCI/pciebus-howto.rst
@@ -97,7 +97,7 @@ register its service with the PCI Express Port Bus driver (see
 section 5.2.1 & 5.2.2). It is important that a service driver
 initializes the pcie_port_service_driver data structure, included in
 header file /include/linux/pcieport_if.h, before calling these APIs.
-Failure to do so will result an identity mismatch, which prevents
+Failure to do so will result in an identity mismatch, which prevents
 the PCI Express Port Bus driver from loading a service driver.
 
 pcie_port_service_register
-- 
2.43.0

