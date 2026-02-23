Received: from mail-m49209.qiye.163.com (mail-m49209.qiye.163.com [45.254.49.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E371303A12;
	Mon, 23 Feb 2026 15:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861793; cv=none; b=RY6b7G7DKE7IRL5nF0FgQ7UQT6mm8JFrUltn7su8gYk8Raul+BldkQZMfgMXQzqwyiAQqSRuQPkQSCAnvdnG/1FLhuICoqJaxu++seRUZCuOq5/r3D895rxWnQ+2oXahlvajhHCjett/1azRMDprlU0brveCYJD9vPylgcWmgqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861793; c=relaxed/simple;
	bh=goy6qccWrfrm26MEI0DUVIDFJpTSIFPzPjcpceXTQlc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=aCctdGZ8isuwnc5gdzBY4BgjdRjO3CUdjq94WBuxqf/3IA569ALcxRYHjGddOXo9OLjPPm6Aeld1GgQtHF7jJQ4pG2PfWzxc3qwY5ACJkXgLao5sLeAh9juUkNqEhjpu88ooPO8MkLpBKpXughdBkJRIiqK7YmuGU0cgb3oEpJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=El0ky9iX; arc=none smtp.client-ip=45.254.49.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="El0ky9iX"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34b404540;
	Mon, 23 Feb 2026 23:49:46 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 15/37] serial: 8250_exar: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Mon, 23 Feb 2026 23:49:41 +0800
Message-Id: <1771861781-87513-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9c8b313ed409cckunmc2400f0698784b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR4eTVYeTB5JGU9KQh8fThlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEtKTE
	tVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=El0ky9iX8x68UVy554McMXcz6tilFF/CwnreGSj5XBNsCKX29TInJeRDvUnyi/wr7Ls9k+A+nNDaIFOZd5PZ6yIYecn7meepcIP5lPMKrkmprled8O/XhDjE+DE2cdO3cC+HrSeMNTnvhDVm8QggsL6RMIZqW7oo32uQVN//H+8=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=PyqxuTpz5PitswoYxwdPDat0fi7XyHSwOD91syj0474=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

pcim_enable_device() no longer automatically manages IRQ vectors via devres.
Drivers must now manually call pci_free_irq_vectors() for cleanup. Alternatively,
pcim_alloc_irq_vectors() should be used.

To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/tty/serial/8250/8250_exar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index c682c0d..bde4d3a 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -1478,7 +1478,7 @@ exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
 
 	pci_set_master(pcidev);
 
-	rc = pci_alloc_irq_vectors(pcidev, 1, 1, PCI_IRQ_ALL_TYPES);
+	rc = pcim_alloc_irq_vectors(pcidev, 1, 1, PCI_IRQ_ALL_TYPES);
 	if (rc < 0)
 		return rc;
 
-- 
2.7.4

