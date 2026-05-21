Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041F637FF71;
	Thu, 21 May 2026 16:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380352; cv=none; b=BvpHPoq6lRpxVif1w+KNruheX3iOShIWppdhPBzFxjzlQmkp1syeNEnq/KXCpHRq5mDdk0GjGibop7gpC0RoNLBlr9xySkt1WJW0q2Feo9xYHZGgBWfmaZ9T0DQ3LnNMsxOXx+e5j2vkpLy3njZCH2euVlLRE2fgu4gGU1sUm3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380352; c=relaxed/simple;
	bh=5CHU3yx6qfE1oS5BC9ElF6de4AIdZKfT+JE5fvNTR1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=boj5ZpuUmkNmMzBwTz9vCayYSACJ6mEEbyNKjxR0+xs3+q9FZfd13oX/OOHnW2Kzw9Om8G1RIPoA03biXhm8XQ12LO80xFg9L6H0fWQuE+KL/0dzc2EICWM774SYUtYd5ESB0fxb6NlQGGcLvzMU+FVCzAL8BfpgKZGD7ax++2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pq2rTN0c; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pq2rTN0c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=iK
	wKFzDAytf+csTRK6GSV33LenJNn4LbjnlQ+KFQt2g=; b=pq2rTN0cDiyO0fNndl
	VjU7GewzttI7ET6j/Ie2cX9nm2sJd3Rco8XlUV10N0IboqKdTLsrA/RLRCkHQYky
	XX3mxb25yJAbf/GBHdaiBLKkCNluoURVz1u7uJLGfn4ibv/nI5a6AgiSwKrNdVDX
	3dFlhvjvXBlGxo0MTmtKbjGFs=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAHIxNdMA9qlLe2Cg--.39182S3;
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
Subject: [PATCH 9/9] PCI: plda: Protect root bus removal with rescan lock
Date: Fri, 22 May 2026 00:18:22 +0800
Message-Id: <20260521161822.132996-10-18255117159@163.com>
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
X-CM-TRANSID:_____wAHIxNdMA9qlLe2Cg--.39182S3
X-Coremail-Antispam: 1Uf129KBjvdXoWruw48Ar18ZFW5KFWUCw4Uurg_yoWfXrc_ur
	nxKFW8CrWDCF9xKFs2yrs0yr98AayIgr1jqayrtFy3J3W3urn5Xr9ayrnxXF1DCw1UXry2
	yw1DCr4YqrW2vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRX2-n3UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7B+BJWoPMF+OXQAA3O

Add missing lock acquisition in plda_pcie_host_deinit() before
stopping/removing the root bus.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/plda/pcie-plda-host.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
index 3c2f68383010..f9a34f323ad8 100644
--- a/drivers/pci/controller/plda/pcie-plda-host.c
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -640,8 +640,10 @@ EXPORT_SYMBOL_GPL(plda_pcie_host_init);
 
 void plda_pcie_host_deinit(struct plda_pcie_rp *port)
 {
+	pci_lock_rescan_remove();
 	pci_stop_root_bus(port->bridge->bus);
 	pci_remove_root_bus(port->bridge->bus);
+	pci_unlock_rescan_remove();
 
 	plda_pcie_irq_domain_deinit(port);
 
-- 
2.34.1

