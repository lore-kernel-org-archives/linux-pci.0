Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F37C37F325
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 04:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788408060; cv=none; b=cT/cUCyLna98qQGL8ZgzsIQNxXr6iM378EiZ3cqfEfNptKRymnSv327ScJ1ifaG2eVB34XGaq5NdAC83/RePVMhJX596Odl1pGu8tQJnfBuTzU2kRb9gKKyKwo4LDOI5AHZOlXtM6hiXzDZhpGAhWA0tBBZ1YUJ22ar+Zgycxz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788408060; c=relaxed/simple;
	bh=TnImqjW8TcInoI3ORtw+3Y6VYINgKHJTYPIbwbTyVzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NHkFvzM6JVUHJE4vFHw8OGM2tOhICMZjOPc1jgRO1QBqRednrBb1kxqxbW1vbzkSYgVBpmo7Fvlnk2Fi/4wNGe0nyTyhDbDFZUHAPsXeBfeSHKYgRBECB5qgAKOJFGxO5XrmBHVdgaThfpyNnGFjjyv58cyiBu3oIYtrFlaugNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrxKBmD1; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrxKBmD1"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d942c7cc2fso15759685ad.3
        for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2026 21:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788408059; x=1789012859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iKQr7/qeF4NbbcRbpSyy8OQJWHUjQqXu07B0Cb4xDE8=;
        b=BrxKBmD1EDCsSuShG2xaFFRLsmKFqrBgxK3cUbc1uhO9OUAMW4AFKQ4YFNWLJfPxXr
         GcuKX/2xREr+LsUkTCZfrlAElL38dXvmm3yDLNsHveMFwj2Yxlxf3NgVsz2bFJDDbUNY
         lyQNKqEfI9M8fZ03CcKp6kzk+mHl9vjfrzjcaNMpb76lsKIzPxXcBREt5jGEVr/EIU0X
         H3WUTRzFpuuzj7dDjJMTQp35M7eTGelRM7zsLM0pqMu3ogVLweTVHlxfX54qxnbxbRLZ
         0S1OoAtVYR3SszKNPAUm0bSqP10BQkZ5jRxIjfxXRtUtcWEJwfSV2O6sVw9+QZXc2rhs
         NeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788408059; x=1789012859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iKQr7/qeF4NbbcRbpSyy8OQJWHUjQqXu07B0Cb4xDE8=;
        b=SPlPPDv+Yq+uWDQwYB7nJ2lTT2xfy8A1sHUfbXb7KeHNbmidS65JcKC2vPs7a5CvLE
         xbJTJp5TJ+BRhV/q6iIahVy04g02odD2xP3yYxjqxZsF02emaezI49nbPtiN2tCFZOyR
         YRjK7ISCnCr7fKX5a27VV5LQfpkvncuUTmQVkgKodjgn3R6kN+j0VEfEtD5wUIOX8nAO
         AW+t6vCGzWNpLuYBIBrXeTvKyI9sDSlVSOyOaviogdPkbaj+KJQb2qrLojfPNZszT9P7
         Hmf1UsMCxjbJ5FYKuVGH9Y+HpJO+xjBwSWJd9+y/UQnMDIRccvGY203rWEXjT7UkCofk
         NLlA==
X-Forwarded-Encrypted: i=1; AKwUvByd+6eUC70RPuqKhkjGrGQyqwsN5FuchUcox1Mgmn0ZPYGiCU4iiPCZccbkPuZ7Noubc96nQ8cFdJg=@vger.kernel.org
X-Gm-Message-State: AFuF++nIhLtnqx922PgeTcBsxGjIRDE+aNCijvuil34Ld/ZpIcULzu/P
	fz+JoNMXtfWOEjt1X2Q9MOMWRiRCwgPEvHAAG3naeHj6mGAleHQYNq0A
X-Gm-Gg: AYBFou21qwFkWMK9DcRUK9I6CMbL76DclBdtKnGZfzNkVnlF4FiSpGNQtwFtiI7HN2b
	dtS0PMo0dPBXR1Kh4NI1nLvXW9zqVH3UkMYXxq7QYa7E77bDsrv4pssjEIBbaXBzUOVLBhI7Ypb
	rBlRG4ASjv9j/mMdssenE8+3gd4Y23kT8GIcu45PMewtvZFuce0ABH1V5JZKPoa/OEB3F/K5FGh
	MIouEUaeClbYKPpRozbkFrBhYLZI0eAoWOzDgVusmaNkU0W1tfqSxkgi7gjBTPnPGoNJRkPHOW/
	qXOozX/gvzBnoN6fESJsB08su9En1v20rl/F0txv5OWyd0+mE9T4hoI/VDp+dogvBkOe6ZDGYCu
	4CvaeocVZQjIhz344lkKL0r1C5ugNUGjtO7iLK0IgANOpYUcjgemEjxI2IPXks3ZT0oQdJ3qjQp
	w95w88WJz8K6dSqTWnlvlzt2ay1kEGvKaLYvbBcQOQ0nrFtbUZ9fobPT6QKh1pz52rttNPXo1zD
	WvAyOf8N/9Z7WMKOg==
X-Received: by 2002:a17:90a:d2c7:b0:398:9c39:520f with SMTP id 98e67ed59e1d1-39aee084513mr15049410a91.15.1788408058395;
        Wed, 02 Sep 2026 21:00:58 -0700 (PDT)
Received: from kernel ([45.251.35.126])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3325534c324sm2597713eec.5.2026.09.02.21.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 21:00:57 -0700 (PDT)
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: bhelgaas@google.com,
	alex@shazbot.org
Cc: skhan@linuxfoundation.org,
	jkoolstra@xs4all.nl,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
Subject: [PATCH v2] PCI: quirks: Fix out-of-bounds MMIO read in nvme_disable_and_flr()
Date: Thu,  3 Sep 2026 09:30:49 +0530
Message-ID: <20260903040049.5460-1-raizudeen.kerneldev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In nvme_disable_and_flr(), the PCI bar is mapped using
NVME_REG_CC + sizeof(cfg) which is (0x14 + 4 = 0x18 bytes)

However, the function later reads the controller status from
NVME_REG_CSTS - offset 0x1C, which is outside the mapped 0x18 byte
boundary. Reading past the mapped MMIO region is undefined behavior and
can return invalid data.

Fix this by increasing the mapping size to include NVME_REG_CSTS.

Fixes: ffb0863426eb9 ("PCI: Disable Samsung SM961/PM961 NVMe before FLR")
Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
---
Changes in v2:
- Changed the commit message to avoid overstating the risk as pointed
  out by Alex Williamson, to be more accurate about the actual behavior.

 drivers/pci/quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b09f27f7846f..ed03892cc960 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4090,7 +4090,7 @@ static int nvme_disable_and_flr(struct pci_dev *dev, bool probe)
 	if (probe)
 		return 0;
 
-	bar = pci_iomap(dev, 0, NVME_REG_CC + sizeof(cfg));
+	bar = pci_iomap(dev, 0, NVME_REG_CSTS + sizeof(cfg));
 	if (!bar)
 		return -ENOTTY;
 
-- 
2.53.0

