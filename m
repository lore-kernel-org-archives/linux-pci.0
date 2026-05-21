Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6E0385D79;
	Thu, 21 May 2026 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380342; cv=none; b=EKrwFNuD6yQ6oVAdqfhrPVzVLZZhX/TFOfKd3gPOV29weGQcWXIPyAY8b9AX3zyRM4VfAJwp2DTZemoVdurdMM34otCXjS74lv7YMCDUl6mebzSA72Gpd9gS8AaGVFfjBSBa11bPcuXCWNwHUz3CgcuNUIKhygqkwA15j7WiBSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380342; c=relaxed/simple;
	bh=Wp+mZ0cLqoFb5NNuPX3opeDKbMj7aZmQ0lEivAP1wFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ln1IeyiHQe+Fd7EvE0YSBjGTn5ZxePHzjznPZu4swqmQYl0Jr8RjGx7HxYBK3bEbG0y3QYKUbztjfJp/z2YqWnYDFaT4WqZ9rC0uA46/I1Gxq8OWVmm+I88ViYQ+Rtjvk7IuVwI5SY+BNh2vTQUDuBrGOocVQddEGY04lkzWy4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Y6A71kiA; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Y6A71kiA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=gA
	ZoFHGzcS6nhA22DK+JZuH7n9SYNkiXfyT3rOVUfp8=; b=Y6A71kiAaxjQhNj8mU
	A87hR8Dle20pb3+JcsOjlr01j+lKX56q5GL1ggo6QbOu1vC7+qlf0YpAXlg4jncL
	bTpiKcompebT0pSeauA6CGtsr1x5Bbl3hvTrPPfbUPn7KULcaqaAZf6LHKUwmwzl
	2Nk+D5sNTBFNV7o1UjpFlSnHw=
Received: from zhb.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDnN1dSMA9qXUWXEg--.45104S9;
	Fri, 22 May 2026 00:18:33 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org
Cc: robh@kernel.org,
	a-garg7@ti.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 7/9] PCI: rockchip: Protect root bus removal with rescan lock
Date: Fri, 22 May 2026 00:18:20 +0800
Message-Id: <20260521161822.132996-8-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260521161822.132996-1-18255117159@163.com>
References: <20260521161822.132996-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDnN1dSMA9qXUWXEg--.45104S9
X-Coremail-Antispam: 1Uf129KBjvdXoW7GryfWw4UAF1fAw1kGFWxJFb_yoWDCrcE9w
	nIgF18X3y8GF93K3WIy3ySgr90v3sFgF1Yka1FyFy3AFsIvrnYq3s3Z3WUJF18urnxAFyI
	kw1qvrWUGFyUAjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRAL0etUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xqAJGoPMFqH7wAA3y

In rockchip_pcie_remove(), use PCI rescan lock to serialize root bus
deletion against concurrent bus rescan operations.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index ee1822ca01db..d203c4876d30 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -1012,8 +1012,10 @@ static void rockchip_pcie_remove(struct platform_device *pdev)
 	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(rockchip);
 
+	pci_lock_rescan_remove();
 	pci_stop_root_bus(bridge->bus);
 	pci_remove_root_bus(bridge->bus);
+	pci_unlock_rescan_remove();
 	irq_domain_remove(rockchip->irq_domain);
 
 	rockchip_pcie_deinit_phys(rockchip);
-- 
2.34.1

