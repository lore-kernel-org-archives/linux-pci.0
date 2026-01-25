Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4373233F4;
	Sun, 25 Jan 2026 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769352306; cv=none; b=MWn2eO4pVdjcDwz6e+PePdBU6Tb23M3jfnzHa6d5w3lYvmsNJFpE+M973ZysavSN+Q/42QASvc0neLVTIk6v7SRb4lQ+MwNwO9vprYgicQGVxU9TKJQHh+cimFR6PvIhsqvTSfhW9Bwb9Zg+X4pN2uWj4COG3IrqR65/L5ikENU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769352306; c=relaxed/simple;
	bh=fYFGfUrN9ZS8RfgpDJ2xduMlAYjoRpkfKBhiR0eVrp4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oH9Ih1gW8DSGr6UCB0cJmOLv34GKsjTpgxo5gf4pQFWiILB4ZMXt3BknK0zsxM/rr0poJ6G2ZKiU0OBGfrR6W8XNxNeB1MypI3dPnKhBxs8BAJA1u3eb3J5tHFWe05AUWozUhjUxEQxFmfc90XIHSPrvwJBWAwXnIQaTgXH8S3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.223])
	by APP-03 (Coremail) with SMTP id rQCowAAXNt1lLHZpzeStBg--.35060S2;
	Sun, 25 Jan 2026 22:44:53 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: bhelgaas@google.com,
	tglx@linutronix.de,
	jgross@suse.com,
	hans.zhang@cixtech.com,
	himanshu.madhani@oracle.com,
	roger.pau@citrix.com,
	chrisl@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Subject: [PATCH] PCI/MSI: add iounmap in msix_capability_init()
Date: Sun, 25 Jan 2026 22:44:52 +0800
Message-Id: <20260125144452.2103812-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAXNt1lLHZpzeStBg--.35060S2
X-Coremail-Antispam: 1UD129KBjvdXoWruryUuF4kWry8ur48GrWktFb_yoWDuFb_ur
	nYvr9xGr4DKF18Ga4jyr13Zryjk34rWF4xuws2qFyayasrZrs8AFWqvr1ktFykur43AryU
	G39rJw15ur1xJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
	Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiDAgSE2l1qZug7QAAsm

In msix_capability_init(), if msix_setup_interrupts()
fails, call iounmap() to release the memory allocated
by msix_map_region().

Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
 drivers/pci/msi/msi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 34d664139f48..e010ecd9f90d 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -737,7 +737,7 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 
 	ret = msix_setup_interrupts(dev, entries, nvec, affd);
 	if (ret)
-		goto out_disable;
+		goto out_unmap;
 
 	/* Disable INTX */
 	pci_intx_for_msi(dev, 0);
@@ -758,6 +758,8 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 	pcibios_free_irq(dev);
 	return 0;
 
+out_unmap:
+	iounmap(dev->msix_base);
 out_disable:
 	dev->msix_enabled = 0;
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL | PCI_MSIX_FLAGS_ENABLE, 0);
-- 
2.25.1

