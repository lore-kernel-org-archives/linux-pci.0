Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F8334E741
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786069234; cv=none; b=o0rDc9hKJmS4dFaNiLHxh1dd5cA2fpVeqJsNjug4FAT8AMMnIXpblCHrAaiml0I0mJaUawrtAvYeFBqWjERqVeSVjOELOZstZs1f5Lvc4x80nh4w+W0ZVsBP+H52c6IjOKk/WBwCplbM2hG9Na1/r3lVwgpavgeHuyAuuV1C5Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786069234; c=relaxed/simple;
	bh=h1MzdJgOAM/MOC6isQo0ZaLtSJeBKGWSnhEaIAWY//E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bf9w49cQYnMiJRWTg8+GFrwxYvP7I5/JeO+339a5dZgJTt6pMZRU9xkxj0osduEXi/wuoeUXqK/sRStk/r5ZuBShxHmZY7Yq+KcJkFHpP4ZaLwslhzhBXIEbyoOadfjUu29HFW63UAPjFpPBYBvPvArDbMkN9LMraEO/pu50Q70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOiPZdWA; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOiPZdWA"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e50979c71so292798685a.3
        for <linux-pci@vger.kernel.org>; Thu, 06 Aug 2026 19:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786069231; x=1786674031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KlDcUi6Mtq/ORUIxn+E62FWD7G5m1bfySU7te1oKKA8=;
        b=iOiPZdWAXxGA8loH+D7FcczZPBBfmTeZo68Tm389A+yFGvqKXKXo1Uit0L2ncCCyMg
         EI9k+8C+9bUPHiW47Ddm1H8I5kLtuvGoO80jDJzQfcKR98w+8bVkbb1N1OYt24G7buo/
         1FyFGpyCNB+MDOyV1JL30fVXhGhz3dbbBTsAgT6YjVdCi12h1vSeUldZGTXsS1/RIas5
         czi5BvNoavCTCyVHz4sjYXQ8hoC9dmZHSxn3QiTNy2FDn201vZNGzBY8vBfULjDCHYbT
         NW6yGcKUqOHz/iQqls27FS44Lw72dkaUn3pblMQZz0XVCEYV2ElRSw3oDK6toaFTxD4g
         g04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786069231; x=1786674031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KlDcUi6Mtq/ORUIxn+E62FWD7G5m1bfySU7te1oKKA8=;
        b=TaSE74AM98vLdD98k4C6y0Mmu6DyAjfUFk4hmlyT5lMXQPKJkUUgg6TXn6HvEYsYWF
         fix8O+1D5W/31qWi4ZneC3SP4AQYoXHJB3Dj1S19i1RhrCjOlDt3S7iHQWJG/otZcOVn
         S2aZB7lZYmBsQgFHYczwuWoZGnbqHS2qPCGIUrDQ28WoUoXMgl1hQuMxJteRaXYp+dEu
         l3JPwWLeQrgk3VX120Pp0G7hDguduhcYTj4vrUpF5NLcJ8PZtDSYQngm+G30W4cqI29e
         jw04rfcJ4C9Q8+fNF2MoWsUIwAihHKRFh+WvMU0V4Ggv6FVPUZli+JMsYln6m5qYFt1c
         DRkA==
X-Gm-Message-State: AOJu0Yx5noWKzV9bbxDeilnIKizXwdPtTOV6Zv2ds3xwqxDYFa/syJLD
	BUKXPyqp9DiK5s6AUSxZakwsazUXkqMeNmPn8mET6tSahBuS6kgyohtT
X-Gm-Gg: AR+sD11dY/GUNAjUTDRR3dQdqiaxy2eq3tcSlwgvAFgL/5GKHW2OgQymO6Lt3k1u3/d
	H4izzgb+9lvad9X7tssQ1QS2s6bjI+7VqCM+ieIcXF8qMoC1AxfI0owQ77cKg4jy7422m4XtarL
	RcubHQ254/s2zYCjncMBZURoNXvOvatOHXU4hB5Mrl0RHpDFhOuVt0Q9AigIWJoeLxW8NiBN4ST
	k0cv4GiD6wEmTkUc5tRNzLUm6L2eipSrwvr7wOR+0zPprucQ5JhRoG2+vOO19uA/DrkjtWMsbQ7
	C+/dpboMRBP0tCp8Ij5DsSeXAK3HMkw2Hizeuy95tmasno+1nHignRFRaQ4XKDaEqU7UN1fNumY
	wvmbR95QIUS7bjiQnKnwConmJjAMGHk2NMiKq6WznLhe6psVqdy0shG0WZtN/p0hti/eXHOJKRi
	SGy8syJM2QYpVWXoZEtQRwv+ft5gRcQmn4BlEMUaObg/dSqLuGK2Ik94hxshPqoXG8UCqsS+u4A
	ydVm6buwB7XVQ951iNTYTP6n/6aWBQb4tSzqNCCCAmhpczzxy2q+gbTOqLP5/s=
X-Received: by 2002:a05:620a:43a3:b0:8cf:c513:349c with SMTP id af79cd13be357-93649056dfcmr2185188385a.9.1786069231192;
        Thu, 06 Aug 2026 19:20:31 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e22695bsm47665785a.25.2026.08.06.19.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 19:20:30 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] PCI: Release SR-IOV device reference on init failure
Date: Thu,  6 Aug 2026 22:20:25 -0400
Message-ID: <20260807022025.921764-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sriov_init() takes a reference on the sibling physical function stored in
pci_sriov->dev before computing the maximum VF bus usage. If
compute_max_vf_buses() fails, the failure path clears the SR-IOV state and
frees pci_sriov without releasing that reference. Since is_physfn is
cleared, pci_iov_release() cannot clean it up later.

Release the reference on the failure path when pci_sriov->dev is different
from the device being initialized, matching the cleanup in sriov_release().

Fixes: ea9a8854161d ("PCI: Set SR-IOV NumVFs to zero after enumeration")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 drivers/pci/iov.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index b0d24839c084..65c60f88a3d4 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -907,6 +907,8 @@ static int sriov_init(struct pci_dev *dev, int pos)
 fail_max_buses:
 	dev->sriov = NULL;
 	dev->is_physfn = 0;
+	if (iov->dev != dev)
+		pci_dev_put(iov->dev);
 failed:
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
 		res = &dev->resource[pci_resource_num_from_vf_bar(i)];
-- 
2.43.0

