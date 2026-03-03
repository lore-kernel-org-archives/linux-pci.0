Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A760D1946DA
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772523423; cv=none; b=Xt1iSOYVpogWZt9nGgXyyxyBwsLQVfc4R9S5Ozi9ZymaWK4Mpds/SBzuNuk1Kij8zWb0eKHG84kXWNY/3LADnM4Q5CtQ7ems63lnWyy35QsG+qE3IQSHusy5Oneij5TwY/NuKSgcGr6opRubiQRrV5ZWkwevqet2t+qt7kqE2m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772523423; c=relaxed/simple;
	bh=YRswPjxUKHV7keveoX58mYtoPIQVF8XUmJT3sD6BLKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PQd6zrTkO4sfZdND/BipH0fwko1F+tjnDqfYI8snFVSRwMFVkInG8JNqzJycCpQnHSRiImYk7Qh3NAHUYy1g5ExqVZyTHiSyamw96LnqIiEoazoE0Tk5hZkywnBVpWccFzMs8XnF0oWLxd5lEY2YE06XPxaT6Jgz/6JQH67btVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnDzeAMS; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnDzeAMS"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c7059b9df33so2023613a12.0
        for <linux-pci@vger.kernel.org>; Mon, 02 Mar 2026 23:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772523422; x=1773128222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gZT08cilywIB/UqdHwvbWD0YlWn4Qyu6dmZNA1GgN5s=;
        b=OnDzeAMSEb/xYLD8TNUHfiuQQMI/6ObOMPSiLi1L8tj/0u+W7pwPyfCb28hxwKVoSs
         AvQdo7tyeZr+6rUNtSBAth9WkaKKIC5mknS1jAkU4dEPWUnQQBG19xFn0iruCec1VSLg
         5BRAzFvTXgkjleBPp8w1d5xKn7G9PeRxyIPxIg0aJxrUs5kYz//k3AbaRL1sP044WNmi
         BtjtUmMgA/K+99M4UWuUt2IBK/30ZfNeas6wdMiljspNxxylUW7w4LPq+LMH5HPquV9f
         8duuMJZZu5wLg2sHLeBoIOFW2vsjhyKQMBFW5BCKNE/Xu+S7z95C/lorP9XnkYc+ETEU
         6sdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772523422; x=1773128222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZT08cilywIB/UqdHwvbWD0YlWn4Qyu6dmZNA1GgN5s=;
        b=LU4Ene16YdQToIFAg/jPYCkfab4zrWMS7coUzixeH85mhTJsqgb/wO1A/ffdNt+hRV
         Xqyo3EdJ/J0Z9F3ypVXxlTuFY+3f9taqfhTfYR0YcxDnO1AYxqWCdAYeYYz9try6g5Wn
         CHoyNnkXlzZxNgjxbCcQdTLDK1ww9Kgk1PMLs2JLpVqPlg9trTQexpTaWSGE9T8SSBM6
         YKxLbk0twwzCWWTDKyay1bkfm9L79o3PH5v5jIOFkymeVRw8l+E1fv0dawlsNfhiZTWj
         kwqZJfya5Zdx14YUeeCCuNJnVlmUSiJm8jlS+E/sKSrzMB2Rz13hHw9Oj8GPn0rcQCju
         9TfQ==
X-Gm-Message-State: AOJu0YzKN3ybgXkMUFeBCQ0AYiiwTCvWqoRVbzc8/klWcThKIt4UX9WZ
	nXPRXc+QpsOp+/qcQ7fq1Fn8Ya9ipSsdWC2GX1By0aYJDDL1OTtrvR5Y
X-Gm-Gg: ATEYQzzeSjAy9fcalXTtMeLNcb0tJ1lQxuJTd+KGfHr2gDby0ifBPXyESf29Ipp+Oom
	nILJ5+SIxzWNY/6amrGDnk04PVgWLnzYdublgm+pXeMUga7+TPXrfA7Nz46wxb5A6irad3K85vs
	tfFgXsRPZMknN6dK6xn0yUAV2oxEDvnS74PithKxp2Rhc5mE9z9Z3oY9vpYKvu3w+IzebzIVNne
	Pb1rQsfTJCrrdeVUsMgIRZ4tjdEOCGAuHDBmEytDS/T1hxuuiwMB1vmgTuR17P737RyqGMvcayN
	cMEJ6RTMNDsvoLSSxN2HkDrHJzbY5B194EWU+PiLBlCh64BzAmpm9gYTZKqST2VjCm+jWjMZ5ix
	R5Sxk9rdPawhITyIyPixsr5KiqV6G1jA1yvE8ZfAh+Pmm9mubFYIJIKBFcbew70G9VPke5mSjD3
	tgGSOuZX2EQd+YgGN2wdBFxepqMfnpF0ZQA0GQFoCYYBTQT2bcjQFisQ==
X-Received: by 2002:a17:90a:d2cb:b0:356:7025:56c7 with SMTP id 98e67ed59e1d1-3599ce29becmr1253422a91.5.1772523421989;
        Mon, 02 Mar 2026 23:37:01 -0800 (PST)
Received: from ZC-202510311500 ([61.185.217.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a01aa09sm17975114b3a.48.2026.03.02.23.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 23:37:01 -0800 (PST)
From: hechushiguitu666@gmail.com
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"haoyu.lu" <hechushiguitu666@gmail.com>
Subject: [PATCH] PCI: probe: Fix spacing around operators
Date: Tue,  3 Mar 2026 15:36:54 +0800
Message-ID: <20260303073655.2047-1-hechushiguitu666@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "haoyu.lu" <hechushiguitu666@gmail.com>

Fix checkpatch.pl warnings for missing spaces around operators:

- size-1 -> size - 1

- PCI_BRIDGE_RESOURCES+i -> PCI_BRIDGE_RESOURCES + i

- 60*1000 -> 60 * 1000

Signed-off-by: haoyu.lu <hechushiguitu666@gmail.com>
---
 drivers/pci/probe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index bccc7a4bdd79..e54fa8a9f377 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -119,7 +119,7 @@ static u64 pci_size(u64 base, u64 maxbase, u64 mask)
 	 * Get the lowest of them to find the decode size, and from that
 	 * the extent.
 	 */
-	size = size & ~(size-1);
+	size = size & ~(size - 1);
 
 	/*
 	 * base == maxbase can be valid only if the BAR has already been
@@ -594,7 +594,7 @@ void pci_read_bridge_bases(struct pci_bus *child)
 
 	pci_bus_remove_resources(child);
 	for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++)
-		child->resource[i] = &dev->resource[PCI_BRIDGE_RESOURCES+i];
+		child->resource[i] = &dev->resource[PCI_BRIDGE_RESOURCES + i];
 
 	pci_read_bridge_io(child->self,
 			   child->resource[PCI_BUS_BRIDGE_IO_WINDOW], false);
@@ -2600,7 +2600,7 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
 	struct pci_dev *dev;
 	u32 l;
 
-	if (!pci_bus_read_dev_vendor_id(bus, devfn, &l, 60*1000))
+	if (!pci_bus_read_dev_vendor_id(bus, devfn, &l, 60 * 1000))
 		return NULL;
 
 	dev = pci_alloc_dev(bus);
-- 
2.53.0.windows.1

