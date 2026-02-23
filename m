Received: from mail-m19731105.qiye.163.com (mail-m19731105.qiye.163.com [220.197.31.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF0B1EFFA1;
	Mon, 23 Feb 2026 16:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862789; cv=none; b=j/+tTVnnmnAkluLu41pTyONydZOuL1vaZukDotjJSEZ2yVhf36eAIZ52cFA6E53GZklcUU7afwvDehoTJyuJGNU3LYnXr6NXMKabUYtLgCZ/KKhJb1860xIp5lnW4z9yDIOMJuKFFb6L89JU8MtNubNMqbfQIGiOgLj0DfVSQKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862789; c=relaxed/simple;
	bh=Esie7xcoMylOfNRzCrDkUMrZzm3fjFxynP7Ruo4q6vQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hmdJo7wHCfYFlnO0rgx951k/yOu1KOcq6ONV3WSCnbApKvXFu3DQuYgKr+cqqjr0w4l+r3PIu4fAlbiMKvv1ZgeVzGpiFQpD/mfnC6yHKBVlxWZqh275KwKA7ITmLGRs8WXvuSl2fm6RPDIytMeO9k2JKQic4BIAxbZMgRm9LCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=goJ5v1Ur; arc=none smtp.client-ip=220.197.31.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="goJ5v1Ur"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34b404565;
	Mon, 23 Feb 2026 23:51:05 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Raag Jadav <raag.jadav@intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: platform-driver-x86@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 16/37] platform/x86/intel: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Mon, 23 Feb 2026 23:50:54 +0800
Message-Id: <1771861854-87838-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9c8b32720009cckunm2d986085987997
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkIYQ1ZJGk4dQ01OQxgZQk9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=goJ5v1UrSqYMk5e3LjWhqXfJ+pUI69/X9t4NYutBQGajh12xYACPi8qoFt7kDcdTmeQDhqJVoKg2z0BK5HzoC3iDvIX9HeM+XebrkEMONh4KecowUOvavBzgvx6nAiXaUk+TZtvrzDjJyTzUhjLvBnLGRc4gjopwsnhGsuJbKNQ=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=UdvKYkUzhrfzUok6eM1TIEx31WQdYNSN2+4X6rygYV8=;
	h=date:mime-version:subject:message-id:from;

pcim_enable_device() no longer automatically manages IRQ vectors via devres.
Drivers must now manually call pci_free_irq_vectors() for cleanup. Alternatively,
pcim_alloc_irq_vectors() should be used.

To: Raag Jadav <raag.jadav@intel.com>
To: Hans de Goede <hansg@kernel.org>
Cc: platform-driver-x86@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/platform/x86/intel/ehl_pse_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/ehl_pse_io.c b/drivers/platform/x86/intel/ehl_pse_io.c
index 861e148..d554ba9 100644
--- a/drivers/platform/x86/intel/ehl_pse_io.c
+++ b/drivers/platform/x86/intel/ehl_pse_io.c
@@ -56,7 +56,7 @@ static int ehl_pse_io_probe(struct pci_dev *pci, const struct pci_device_id *id)
 
 	pci_set_master(pci);
 
-	ret = pci_alloc_irq_vectors(pci, 2, 2, PCI_IRQ_MSI);
+	ret = pcim_alloc_irq_vectors(pci, 2, 2, PCI_IRQ_MSI);
 	if (ret < 0)
 		return ret;
 
-- 
2.7.4

