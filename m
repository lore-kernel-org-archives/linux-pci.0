Received: from mail-m12810.netease.com (mail-m12810.netease.com [103.209.128.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93B832ED58
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.209.128.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866942; cv=none; b=JcnhLnlG0K2v9j2QiDZlfI87Noei/saYYb89qX/4JGAmwMckl30KCUaqPe4Yx+CQpsYfsJ5UhB1rIapQngewMVnvYBcZrQ/7LGeR+8eNqf+3Toh2o5AKbbf97G2sAUg6lfpbozwDxc6YQEQFsfGiANvWymUDNtAftdKIavQPPRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866942; c=relaxed/simple;
	bh=M9dfM7kM0B2QF8u0K8XsEcdcBR/TFNQvo9bdDteonbY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=oUEqRiZ5InJiu8eTjZEtSqA7eNN7FEDzwNOj/JHP0ZSYfhAM/b2Ck27GodlOmRiiK78giQELyQ6HLRuzhIQFBBGRP+CG97nUzwpTDQKfdpKSuNYxQTDnUcx9n/eW/+96y+qS4N4JJYXq6I3Mgwto5UVQmXM4Q+Jv45bd4XlTGhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=FOJn001k; arc=none smtp.client-ip=103.209.128.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="FOJn001k"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34b404682;
	Tue, 24 Feb 2026 00:00:02 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: vaibhaavram.tl@microchip.com,
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 36/37] misc: microchip: pci1xxxx: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Mon, 23 Feb 2026 23:59:59 +0800
Message-Id: <1771862399-91250-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9c8b3aa45209cckunma21ec8c19882f3
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhlMS1ZDSh9OSU5DHUJPSk5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=FOJn001kgrsdwpdu3/hjw4o6lYwngSiWZib1MK05D/qrTXpnlR1OBTVqvSwYwQOtHzsdGceeDxpuD3rnaVvUF9Xvs7DR5AmIOJIlBQmroxxPDwMgESZDxs52bqwiIFHXSM8yHzRicSvjWgi5Wjhwvlkts5Q10Jkhz/82mKZaF0c=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=ZgDE1wFTFiECq/zQqzXr8g+8KwWlhlhXp5fG1CepAfA=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

pcim_enable_device() no longer automatically manages IRQ vectors via devres.
Drivers must now manually call pci_free_irq_vectors() for cleanup. Alternatively,
pcim_alloc_irq_vectors() should be used.

To: vaibhaavram.tl@microchip.com
To: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
index 34c9be4..ef8446f 100644
--- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
+++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
@@ -86,7 +86,7 @@ static int gp_aux_bus_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	aux_bus->aux_device_wrapper[1]->gp_aux_data.region_start = pci_resource_start(pdev, 0);
 	aux_bus->aux_device_wrapper[1]->gp_aux_data.region_length = pci_resource_end(pdev, 0);
 
-	retval = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+	retval = pcim_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
 
 	if (retval < 0)
 		goto err_aux_dev_init_1;
-- 
2.7.4

