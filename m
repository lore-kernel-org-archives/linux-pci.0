Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A964DE70A;
	Fri, 25 Sep 2026 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351965; cv=none; b=tRU4LBrUbiZZp3WyF3ittgW4WsWBWlwtRcEW82yu481vdgmUI260ivFfreVEkaUeaDTtlv+2TG5V65z0o9JeLun54W8YMOImvM+rlSD1GqEu9j9/GW2u92MRLsL+itQbBg+kQbOZ2BBvax2oi88Ou/tP4ssBuIAJW6dKHVeN6+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351965; c=relaxed/simple;
	bh=079ONZL6JAM81xucisExl6+sr1WkRVRWxPso+QgDe/k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qbO813/TSvJDA7Db0RyE7jalIxavJ8fTbyEl0pe5/BTIizjT/j8hBypfcvvuV8WTp1UbEeiSaKs/16bHmnQXJpMqVi0+QGT0UIFcILuMp2l/gCQfneLWmAjJuqGfm3HUAdvBwE52M1UzsYGSJ7nu9bbQ01KU7JzL0Ywt1b4Koeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=U5ZdmO3k; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="U5ZdmO3k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=4o
	/JXh8XCXb3+GVJ+gABbwKLmtE6NlUjFigWALOO+wc=; b=U5ZdmO3kwNs3toHSj9
	Wb/RnNKwjgpdKaoewBLZG5h+90bwZ6HyDIqvzmiu4xIReJkOkzrKHjS5dRAqYjOG
	KMM+xORjCqKPNQotv8QsXsOEcjtbSxkf0Wk8TRsW4leJyDBykqE4ZmWg6k9gGxDD
	Uw5g+VE2d6wjndY9sQOiOQE6g=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDXv0M5mrZqtLriAg--.22716S2;
	Fri, 25 Sep 2026 23:58:50 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pavel Machek <pavel@suse.cz>,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH] ACPI: PCI: link: clear driver_data before free
Date: Fri, 25 Sep 2026 23:58:46 +0800
Message-Id: <20260925155846.2381956-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXv0M5mrZqtLriAg--.22716S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw17ur1xJFyfZFyUXFy7KFg_yoWfWFb_uF
	9Yqr1xWw15Cw4rJw1xuF4fZryYkw1fWrs3WF4IqayfCr1furZavFsxXwn2yryDGa1UCF9x
	W3WayFWrZr13CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUU0zuPUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzhr8N2q2mjo7GQAA3B

acpi_pci_link_remove() frees the link object without clearing the ACPI
device's driver_data pointer. The ACPI device survives hot-removal and
can later be retrieved by acpi_fetch_acpi_dev(), leaving callers with a
dangling pointer.

Clear driver_data before freeing the link.

Fixes: db89b4f0dbab ("ACPI: catch calls of acpi_driver_data on pointer of wrong type")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/acpi/pci_link.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index e6ed13aee48d..84bfcdf242dd 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -787,6 +787,7 @@ static void acpi_pci_link_remove(struct acpi_device *device)
 	list_del(&link->list);
 	mutex_unlock(&acpi_link_lock);
 
+	device->driver_data = NULL;
 	kfree(link);
 }
 
-- 
2.34.1

