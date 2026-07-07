Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1F03FD121;
	Tue,  7 Jul 2026 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783426395; cv=none; b=SS1pXqI0+ZFjtplKGzgCKkjJ/YwovJzitbtLbUMfUDwxNg4XdJ/pTBUzq0GmEu0ZM7DKWdcPBiMvWR5rS7xgMgNbUuokte4/M59Gb4mHjme75w/AvR0cpar69NyUN9kMlDdvHEo2nsJhMCSOty1PSa73MztgufjN6yQnz0eVgLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783426395; c=relaxed/simple;
	bh=iM/ITSzEjuuTnsAsuu2IRTw4GsnoxQTq+5wqGHC7Z5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YB2R/z9XWh8XAeSuSLXEuvZB9VwgzKk2/TuIbBOl5obrlPr0x1LL+l0rh9BsL1Q9PqtJZSyjyl2Q+FtSQUOY8nFL0VeZHi6Jot8AZInHzoqRa+vjSSkyHX5lOtZdjHpn+E72H/0ei4eCvZTk7cAxXb+s/FBeHbbbw5bqEB1hi2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LVr/OK96; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LVr/OK96"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783426384; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZazC41qgP28ya/4IG3D9ZyNZ1aQYNlbRht3eBUU3JMQ=;
	b=LVr/OK96W4/77kZq6MbsuiFiQ1R3fEqSuS54MgqETMfP3ShDgBCfAf3yXkY3F200/NY5M25MaiV+HrYocZIhPFsAdT0PqIjPPTJblqfCL1hbe+HRtU8P9Vb6hTOqtOiPAtk2p6gulxByeRN5pP5iH3Whz0YyCtPO4cbFVpiyrDw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X6dZr4z_1783426379;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X6dZr4z_1783426379 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Jul 2026 20:13:03 +0800
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
Subject: [PATCH] ACPI: PCI: Clear driver_data on all error paths in acpi_pci_root_add()
Date: Tue,  7 Jul 2026 20:12:58 +0800
Message-ID: <20260707121258.11640-1-cp0613@linux.alibaba.com>
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
driver_data on attach failure, so a later acpi_pci_find_root() call
may dereference this dangling pointer.

Move the NULL assignment to the shared end: label so every error path
clears driver_data before freeing root.

Fixes: db89b4f0dbab ("ACPI: catch calls of acpi_driver_data on pointer of wrong type")
Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260526025118.38935-1-cp0613@linux.alibaba.com
Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 drivers/acpi/pci_root.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 4c06c3ffd0cb..f6cddd11075c 100644
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
-- 
2.50.1

