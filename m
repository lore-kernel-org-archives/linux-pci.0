Received: from mail-m15578.qiye.163.com (mail-m15578.qiye.163.com [101.71.155.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E881138838B
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 06:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788416055; cv=none; b=VyshCBmXk54WzNiKRlGI4dQnp7rKjsyt9vIj6f/fIopA4gAN0AY6RO+9Sc3gOlnpS6iYIsAV6jRgcTY5y59nUqe+d3VMPXT3gHQVEZeFUJq6obxTYtTxdOxVwfIpfnRlnavoFnkg2GUT1S6zUef2mIO/zVWYPlkzk5eNoQYj4vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788416055; c=relaxed/simple;
	bh=gW/TGEaK4Zej3TNDBfSZKWn0bQzD5EsqQPAXTPcbFoM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=EDGl4t9Mbq762XTwI0UNvDksuINlPhl2ZDvVfiAkZRNMGX163qnOQrKUntOEsOg5eG+r0e9ux5fvDbYFgVTbdOHoz72uRaYFiEpWjn4OQHwPbrh+JnnHF5wm+GzLwSCCiG/PZ1J7TNVcHCGH0osMOvoM98TB+WwJM6zPY8cBnwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=B3NqRP/Y; arc=none smtp.client-ip=101.71.155.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="B3NqRP/Y"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c5849804;
	Thu, 3 Sep 2026 10:44:49 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-rockchip@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Peter Geis <pgwipeout@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 0/2] Two small INTx fixes for Rockchip's dwc based PCIe controller driver
Date: Thu,  3 Sep 2026 10:44:35 +0800
Message-Id: <1788403477-71491-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0aa0652797eb03a4kunm355d5a8763ea3
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGk5ITFYZQ09OThlPTE
	MdTElWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=B3NqRP/YTCVsrD0QwG9Yjcp55q0ZXA0MaThIV0VDjMlfVCgjM/JxQeqlA0PrO9MQpQsWf5K3XTf+LrE8BJZ+Je2iWTIu4lW1xazghyFU1grewapYcA/2z12U2Zp4g5nu0MVLMsKlcwXbGbR1YFCxgxyyJIIRd6HNUt75QLi5Oek=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=19kmhDirJCWxWqtbv39Qoz6DSKVcWfKitSAyHGY198s=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>


This small series fixes two INTx related issues in the Rockchip
DesignWare PCIe controller driver.

Note that patch 2 depends on b376b3ff9cb0 which is not yet in Linus'
tree, so this series is based on linux-next.



Shawn Lin (2):
  PCI: dw-rockchip: Bail out if the INTx irq domain creation fails
  PCI: dw-rockchip: Do not recreate the INTx irq domain on root port
    reset

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 41 +++++++++++++++++----------
 1 file changed, 26 insertions(+), 15 deletions(-)

-- 
2.7.4

