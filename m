Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D9843CEED;
	Thu, 30 Apr 2026 16:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566296; cv=none; b=g+1KtLVAsqUh4hT/me3IyJ5rPQ7AaahWYZMGrqHVd1I5tw+eQU4BxntuVYf7+/n7117yUDhLxJ3ImOpmvwTCNxFfQgd0aXwR67xsOs5evNgIJqBmQ5xhISc6uNuo6rbOReqlEqZcpQ5tIolIEJtzBkKlDvJql0/jEehgJY5eWLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566296; c=relaxed/simple;
	bh=nPMKN1Fe1bsfz1xlPQMcwLjyp7UGawQC2SNZYnNmcWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AIlH+0hmu4qCOcxYNruiJudN1zOuKGk4l7fXD/K4tMTzqa8cU+v++Me5QhEVlTHVUvYhgUbucZIuKW57cDrEb9BD2eZWMxy6qdP6H7PxUoQYkXkokyTtLRVe7AWZjBUfj8n5O62CIevR83JIN4Uag1xqAjekZsl2yYQzFyUDpjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XpecQ9vi; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XpecQ9vi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0K
	C3Cmy2ZLsYR50fE71ZJySGEQ83dgNo/ZzhAx1nNYw=; b=XpecQ9viQ8QcokLvA3
	8oMyq2YU93fmxuSwbkjNEVcqFccW8zZFXai1XdnRRQU+eQoTTZcpDNdthloKJ8R4
	aGtgBs5fAWTWwkxdYyL7Snvu3FJ4UuaaWrU85KFDSaEkvuMIcngx3wJMof2+wEyb
	l3BssOqUC+/6FMQnLxentGkxE=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAHJXM2gvNpY8PXCg--.48992S9;
	Fri, 01 May 2026 00:24:27 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	jingoohan1@gmail.com
Cc: robh@kernel.org,
	s32@nxp.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [RESEND PATCH 07/16] PCI/REBAR: Use FIELD_MODIFY()
Date: Fri,  1 May 2026 00:24:11 +0800
Message-Id: <20260430162420.42839-8-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430162420.42839-1-18255117159@163.com>
References: <20260430162420.42839-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHJXM2gvNpY8PXCg--.48992S9
X-Coremail-Antispam: 1Uf129KBjvJXoWrur17tw47JFWrXw1rAFWrKrg_yoW8JF1kpr
	Z5C3ZrGr18JFnrtr1DWa1jkwn0gaykX3srGF9Ik39xZF98twnFv39Ikas5Gr4rJFWkZr45
	CFn5try3uF98JaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRPUUUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwxsGqWnzgjtOTgAA3U

Use FIELD_MODIFY() to remove open-coded bit manipulation.
No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/rebar.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/rebar.c b/drivers/pci/rebar.c
index 39f8cf3b70d5..e3e0415fc29a 100644
--- a/drivers/pci/rebar.c
+++ b/drivers/pci/rebar.c
@@ -211,8 +211,7 @@ int pci_rebar_set_size(struct pci_dev *pdev, int bar, int size)
 		return pos;
 
 	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
-	ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
-	ctrl |= FIELD_PREP(PCI_REBAR_CTRL_BAR_SIZE, size);
+	FIELD_MODIFY(PCI_REBAR_CTRL_BAR_SIZE, &ctrl, size);
 	pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
 
 	if (pci_resource_is_iov(bar))
@@ -241,8 +240,7 @@ void pci_restore_rebar_state(struct pci_dev *pdev)
 		bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
 		res = pci_resource_n(pdev, bar_idx);
 		size = pci_rebar_bytes_to_size(resource_size(res));
-		ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
-		ctrl |= FIELD_PREP(PCI_REBAR_CTRL_BAR_SIZE, size);
+		FIELD_MODIFY(PCI_REBAR_CTRL_BAR_SIZE, &ctrl, size);
 		pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
 	}
 }
-- 
2.34.1

