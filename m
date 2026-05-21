Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B63337DAB3;
	Thu, 21 May 2026 16:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380342; cv=none; b=I12rwyO4Hf+hKBZI6c6vHK7Ovm7mOgG/Ek7wgEdnQ6TeO2yM5jTARqYllfEZHSPFTbIvRKxnJV4P9cUkmih0r7QdVq/TH0Bsl1q/8VcNALTFP1lMK9S7a35XLSFdRkAGOy5T6dgoa4mpd2pabk6UR8/8c/U94Dey+0FJN4lifxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380342; c=relaxed/simple;
	bh=Ng2Ilu0/PxGjx1ayQaZy98OPY/bKmPrHQCzlnPgVZA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aAiuDApeuDD/3oue/0WKS+oWhqJ1e+W11APrS6CzK0PMJSww4ijy11HsD9746eqR4dGu2mSluBQxrk3sELUo+uiU4YmFkc6j46+iiTGNkFg3MjvlgBBJK9a9grdJXd7XnXmHWnwg4KpZEkPuvg/rxgOGHKLyYg/h/YO+mexQb+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MgQiKx5V; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MgQiKx5V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=VM
	To4g59MM0Nx0eYoKXQNs/QDeQYQdyBp9H37Qs+2nk=; b=MgQiKx5V2T/Z/0OjjB
	aWdWtB8pIA1ogT2DVGdSbmAOMSEjAF0oq/C0+TGUC2Q3s1OI64YmY4OrHIWAbr93
	gNd+gpulRAJrH5zNKj2ctuq4PR1XkHHjAK/3P7qHYegVfFfDd2gpTodP2rzShdQO
	a0O/WIk1zjaAyccuKd8dKNkuc=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAHIxNdMA9qlLe2Cg--.39182S2;
	Fri, 22 May 2026 00:18:38 +0800 (CST)
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
Subject: [PATCH 8/9] PCI: vmd: Protect root bus removal with rescan lock
Date: Fri, 22 May 2026 00:18:21 +0800
Message-Id: <20260521161822.132996-9-18255117159@163.com>
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
X-CM-TRANSID:_____wAHIxNdMA9qlLe2Cg--.39182S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrWUGF45CrWruF4DKFyDWrg_yoWfArc_u3
	y5KF4fJFWUCF98KF1fKw4rXr90y3W5Xrn0gFyrt3WrAF17Kwn8WryUZwsrXryDW3ZIkry7
	tw1qyF98CryjyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRKApn3UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxB6BJWoPMF75iwAA3H

Hold pci_rescan_remove_global_lock while stopping and removing the VMD
root bus in vmd_remove() to prevent races with PCI rescan operations.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/vmd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index d4ae250d4bc6..9565567026cf 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -1056,9 +1056,11 @@ static void vmd_remove(struct pci_dev *dev)
 {
 	struct vmd_dev *vmd = pci_get_drvdata(dev);
 
+	pci_lock_rescan_remove();
 	pci_stop_root_bus(vmd->bus);
 	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
 	pci_remove_root_bus(vmd->bus);
+	pci_unlock_rescan_remove();
 	vmd_cleanup_srcu(vmd);
 	vmd_detach_resources(vmd);
 	vmd_remove_irq_domain(vmd);
-- 
2.34.1

