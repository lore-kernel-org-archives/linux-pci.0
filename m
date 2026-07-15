Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304A2318146;
	Wed, 15 Jul 2026 13:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123466; cv=none; b=gznYBh+Km/FQ0lJEIU9MWEwJzUN167egATgcryxh1xT+yKSWIpG+fAg7w2NQHEuWN5mHYMRKDS8x+o4ojcoy0DHZ+PY5mOwX8Zch092x7NQ2O/FFEexhc2bV7FQVC7dVNPguU6kl+3lHoap/d5+L6nXE/xgEIiOJ+WB7yETBq30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123466; c=relaxed/simple;
	bh=yVPu+v4eu+FtmW2BJhtT2HnTF/4rtlnxAw47e1uQHt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m5YePq/e1wyYt3o9KpiUEN/G6E1huFbQE6L3wH+OsRI17bwWzxmaiNSjQ/bZriBEYfzgMZyrRqWrr/zWTa6pzB2OOKmPdnotN6QhM8mkfnBCwEDjmha7MtwKEFccg93GQQBaRHeLiUWFl+qwiYjUmsg5mFVlAE2aTJUaQ97SGlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SOygZPlS; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SOygZPlS"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784123457; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Fwk18ZVaJuZjtdI8rsnkibEOaBD0EA3WuV7h7bqt7bE=;
	b=SOygZPlSviF/yN4py39RfJ/Sap8BKd/MijHBm3sxfWqnEgSle2xLyT+3r+AwKPqi1r3nAVijTORbeGHvTijTy2QmS2T0rB5W7XFt+TC0fRVuYwgH2lz/MacoYRaMvAGs6kWXfDxxwL27l6JbPSyb+k6bjip0LdHv8KMdicTKiWM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X79YChn_1784123449;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X79YChn_1784123449 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Jul 2026 21:50:56 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: dave.jiang@intel.com,
	alison.schofield@intel.com,
	bhelgaas@google.com,
	rafael@kernel.org,
	lenb@kernel.org,
	guoren@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sashiko AI review <sashiko-bot@kernel.org>
Subject: [PATCH v2] ACPI: PCI: Clear driver_data on all paths that free the acpi_pci_root
Date: Wed, 15 Jul 2026 21:50:48 +0800
Message-ID: <20260715135048.3278-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acpi_pci_root_add() assigns the freshly allocated root to
device->driver_data before dmar_device_add() and pci_acpi_scan_root().
Both failure paths reach the end: label where root is kfree()'d, but
only the pci_acpi_scan_root() path clears driver_data first.

When dmar_device_add() fails during a hot-add, root is freed while
device->driver_data still points at it.  The ACPI core does not clear
driver_data on attach failure, so a later acpi_pci_find_root() call may
dereference this dangling pointer.

acpi_pci_root_remove() has the same problem: it frees root without
clearing device->driver_data, leaving a dangling pointer behind after
the root bridge is removed.

Move the NULL assignment to the shared end: label so every error path in
acpi_pci_root_add() clears driver_data before freeing root, and clear it
in acpi_pci_root_remove() as well, so the object is never left reachable
through driver_data after being freed.

Fixes: db89b4f0dbab ("ACPI: catch calls of acpi_driver_data on pointer of wrong type")
Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260526025118.38935-1-cp0613@linux.alibaba.com
Link: https://sashiko.dev/#/patchset/20260707121258.11640-1-cp0613@linux.alibaba.com
Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
Changes in v2:
 - Also clear device->driver_data in acpi_pci_root_remove() before
   kfree(root), so the remove path no longer leaves a dangling pointer
   (Sashiko AI review).

 drivers/acpi/pci_root.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 4c06c3ffd0cb..408ba12362a7 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -725,7 +725,6 @@ static int acpi_pci_root_add(struct acpi_device *device,
 		dev_err(&device->dev,
 			"Bus %04x:%02x not present in PCI namespace\n",
 			root->segment, (unsigned int)root->secondary.start);
-		device->driver_data = NULL;
 		result = -ENODEV;
 		goto remove_dmar;
 	}
@@ -765,6 +764,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
 	if (hotadd)
 		dmar_device_remove(handle);
 end:
+	device->driver_data = NULL;
 	kfree(root);
 	return result;
 }
@@ -788,6 +788,7 @@ static void acpi_pci_root_remove(struct acpi_device *device)
 
 	pci_unlock_rescan_remove();
 
+	device->driver_data = NULL;
 	kfree(root);
 }
 
-- 
2.50.1

