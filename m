Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4152E1723;
	Tue, 26 Aug 2025 17:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756227843; cv=none; b=Xb4u6RKqmjJGHxHISxt6CsNGROyGnWItvWWsOr65hqo/tr0ZQOouKxyWhQIGYn5WVlxtNyrJINUEu/yir/TVm4+b+rbs7eDAK1+dMFduuYKRERweRCiCvR3v1IEiAbp3srgHDhFKrCSnJfq35fcCCfJjkrV8o2gbWxuLfBHr9AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756227843; c=relaxed/simple;
	bh=4SI0MJ5mgxVQkPAkeiebRKJQyIwK0f+4OTRw8yrlbwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ouwgdp3KuMtY5zHsGWbxeKQOvtumH2zDbcSaJ21lrovK5BRzUbm0FZZRC2FNImLKZ1lGo/LnJUbWqIm0AJ5VWCPcnnWsxrK443scsVBipigKUI5ybk0He/ymZpB9Wa9GgZ7BMwcz3bVXJ1zN71YzzmjNQxoCQeVZ63lTjck7vrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=b2+jd8If; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="b2+jd8If"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=nw
	yxpltjqOypW6UJIjeruKh1/jVz4ohv3HjBGe7Vdm4=; b=b2+jd8IfT7Z1JFajmQ
	NFf+n5lAESsSiu8ybAwY+PYHutfU8/1AJBO6wwCBNRHwHGQ/22Q1osG3UupVGung
	dfmWeJTpR66b8X01QT9RWYYYFQZ9meFvxuAWRk1cuWHbKoTzmcgVhRr/CVVGgHoZ
	pylr6TJRgOyG4jjYgn36g0WgI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAH5Svt6K1o9DIiEg--.25085S9;
	Wed, 27 Aug 2025 01:03:45 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hans Zhang <18255117159@163.com>
Subject: [PATCH v3 7/8] PCI: pciehp: Add macros for hotplug operation delays
Date: Wed, 27 Aug 2025 01:03:14 +0800
Message-Id: <20250826170315.721551-8-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250826170315.721551-1-18255117159@163.com>
References: <20250826170315.721551-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAH5Svt6K1o9DIiEg--.25085S9
X-Coremail-Antispam: 1Uf129KBjvJXoW7trWrZr1ruw17Ar4kJr4UCFg_yoW8JFW7p3
	yxArWUtF1rKrs8Cws5Za1DWr98CasxCrZrCrWUu3s3ZF97Aw4DA3WfKa4jqFy3ArW5Cr15
	WFWrAFy5Ja1UAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zM2NtgUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgC1o2it5y8lTQAAsJ

Add WAIT_PDS_TIMEOUT_MS and POLL_CMD_TIMEOUT_MS macros for hotplug
operation delays to improve code readability.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index bcc51b26d03d..15b09c6a8d6b 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -28,6 +28,9 @@
 #include "../pci.h"
 #include "pciehp.h"
 
+#define WAIT_PDS_TIMEOUT_MS	10
+#define POLL_CMD_TIMEOUT_MS	10
+
 static const struct dmi_system_id inband_presence_disabled_dmi_table[] = {
 	/*
 	 * Match all Dell systems, as some Dell systems have inband
@@ -103,7 +106,7 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
 			smp_mb();
 			return 1;
 		}
-		msleep(10);
+		msleep(POLL_CMD_TIMEOUT_MS);
 		timeout -= 10;
 	} while (timeout >= 0);
 	return 0;	/* timeout */
@@ -283,7 +286,7 @@ static void pcie_wait_for_presence(struct pci_dev *pdev)
 		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
 		if (slot_status & PCI_EXP_SLTSTA_PDS)
 			return;
-		msleep(10);
+		msleep(WAIT_PDS_TIMEOUT_MS);
 		timeout -= 10;
 	} while (timeout > 0);
 }
-- 
2.25.1

