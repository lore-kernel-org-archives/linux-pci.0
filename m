Received: from mail-m81135.netease.com (mail-m81135.netease.com [47.88.81.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846DE36CDE3;
	Mon, 23 Feb 2026 21:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.88.81.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771882348; cv=none; b=KZoYW+NuA/Po66+RWP1OAelk3Y0Rq6tQMHvnoe2pQ1Z8hIluO46frb8VsPBG0DVbTJ8tLlYPikEQMTB4qIyaofvl/Y5yO50MFlVVRlQX+kscYE0iyDC/wMFmBpWss1IwzWWTH2Iz9BV6EB/+5mY036ZHwtCpLOflV8RKFi/bfM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771882348; c=relaxed/simple;
	bh=X0yoJZuT7xjH5wBkLm3JVPjVdS31FZTdK07HJ6YpbCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=aGT0BcFl59Hi8rcm4EATEPWzSe8P629ofdIMf1i2rbp9cilbQ1zFrdT0wZ71wIA+tLM6wH6ahSHmMQ2Ikz9DqAe/7YC6JkjclYJpOieQ+VUIyGsq93QvbwYzAIluJ34jHr94Hj0oAhtHPnsbOs1dJSRKCAhEAU5jLsL/+6ifY9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=OoRvQR09; arc=none smtp.client-ip=47.88.81.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="OoRvQR09"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34b40453c;
	Mon, 23 Feb 2026 23:49:32 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 14/37] serial: 8250_mid: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Mon, 23 Feb 2026 23:49:18 +0800
Message-Id: <1771861758-87458-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9c8b31061f09cckunm674146da98781a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0lIQlZNSkpCTR1CGU8eTxpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0
	xVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=OoRvQR09/OjTEBMj1MuIP710sOtWu1MFtyhnKP51dUkF4DulNwDKdvemC+wY/h1QWzU9RQIjYxvU6PSGEuJqM2u7JfKvKSEtgBLOYOd6WOL9UgCsX8KKf9I+H2btjBBktfTiZsQGu4Lz2tvYgtJRVUmxaQVvdH/Kdc1ki9i6DKU=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=qnb/sQc/YHkI/kZw6WGyai5I/38LWua9U1mFjVrUjOg=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

pcim_enable_device() no longer automatically manages IRQ vectors via devres.
Drivers must now manually call pci_free_irq_vectors() for cleanup. Alternatively,
pcim_alloc_irq_vectors() should be used.

To: Andy Shevchenko <andy@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/tty/serial/8250/8250_mid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
index 8ec0386..3ad9213 100644
--- a/drivers/tty/serial/8250/8250_mid.c
+++ b/drivers/tty/serial/8250/8250_mid.c
@@ -172,7 +172,7 @@ static int dnv_setup(struct mid8250 *mid, struct uart_port *p)
 
 	pci_set_master(pdev);
 
-	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+	ret = pcim_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
 	if (ret < 0)
 		return ret;
 
-- 
2.7.4

