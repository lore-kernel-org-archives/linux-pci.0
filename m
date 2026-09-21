Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81729498904
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000521; cv=none; b=ehCT/xn0MtVjjRfttQ7I92V3865dlutCKC+ZqJfNhFzNk/+va/Af4SUBk9GH7QZbpTCxbdmJeEmF9vszX5qi09KPDQxWAVGZ3env53TlT6GK8S3qRaOUVqBhXUd/fsyhYyPp/HpMyqkHFIVi5BQbVq8Ay70eIxbAmROs1i3Imrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000521; c=relaxed/simple;
	bh=lyIz+1l5b3G3/JlMz/Ffg83kJuwv+dOtA5fodcHyDDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GtjJ/o9jsam/zuJUXggofYYFN+ZPGXFrDC8LnuDlQe7xP0co0iRsC4wGJvjlDRfFvU8PfRuW/SeA53K5frB30NiCM51wXHooL1rATkTaRveTXiESbOSj5bymaQyfrNEuRmTNbbDHAh4+Hfqgt2wijoU40MbbhGJ7Mror/sT/zVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGpj+Uw2; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGpj+Uw2"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747f05ffdso21620115ad.1
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 07:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790000520; x=1790605320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4qptzRTLzEX4ORnvKTYYJwd+9jdXwoH4m16aZtajA1I=;
        b=NGpj+Uw2uMlKIAfFtyVX3rF35jjGJS+jT/ZC5VD29xJEW5OLs+7894zJeac/GJ8GNs
         InpD5kSLqJVOaHwZ4iDBePUwO100C2uAhh72nR5RuVuyMf2YxIH54R8tqjyZJnIz+rn0
         Tgw+qhPFcqS2yiC++khpSay+pcoDubw3F84OtJppeD+fF/vW8GL3EzQR5OkRZObjQQIr
         77nS8kkOwEOIDXEbJFQsxTlVy4kk8oHGUA9xofxjf9BjvSx+4wE9SJtusI0EzUDsv1wJ
         TwGYrPGXyy97OMLiK5WBj2nOjKEy6Rave7sOLsW7Q5fNwKXM4N4S0pNd7RbQ5iHCfquz
         NpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790000520; x=1790605320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4qptzRTLzEX4ORnvKTYYJwd+9jdXwoH4m16aZtajA1I=;
        b=iOhvH6pdtPFSzSL6kB5jDIVinVx91KGo81Ia7QrotbvJTwzjIo84X6wnZJcaRz4FYX
         dCZPm0hU6O4ACDiZoiXiAxqdv2tygGIH0pCJvdXmcRYSTyxbN63eoyK/NQzw68KATGhc
         r9SG9H5c8Rk3LxWRqgtJ0qXEIbsCRZeDcmlfWAJD9M2IawDUC4m24tTx4OT/jyUPdcV2
         U56Ob+vuKLJTMU1Z35DrPNrAkLK1LCzyzeCb2WcFZaYhzBJh/uYleJXEJuuymhsqRnbZ
         pxHXGHYT6iRSbUFvouwqgn3UkHV0/GYVQc+bRm+CP/+nxHVa0iAvRLhcD08iBn6TcOKw
         Ws1w==
X-Forwarded-Encrypted: i=1; AKwUvBxyDtmbbblGW69G2R7dBmhlboETpGmzIOrhHR4RnqLdppT/yNCQipyi/Vg/vKyeVI35b12UqQrT0JE=@vger.kernel.org
X-Gm-Message-State: AFuF++mqxnL52sYy7tgZJkwpF32vi/XaTU/ExtKCSt7F7XKES3i4bImh
	KbJKNRUR3Jhg/w1smRBNc2SX683ZydtWgqXsNDAIEAIalJbjN/ThNEwV
X-Gm-Gg: AYBFou0cBei24mi8GAHwz5PAKcMv9C4/yl6HqpCvajnVlfaZsXWSUvkpvPSwKsVD6xT
	fL8s4sPIISDC80+2+3QR82EfQ9y4AHcwWLkgqulxGAaGYLLjWenf0YSKixKkz4TXwRawsqqWN5l
	tl+YmXa2YrPDw2X+neCpL6jBdYj8rVfk1+ylm7pgj8g5FuR7pWbnqf9pGbhGZpuFJlc4uf7ntgE
	aecNIeFqEqB7rP9z1C366RTIUOKPUSkE2VoRn6bo7aE/GJKgK6t7daOWNvCvu7HcsmR7PRqzOu5
	i6KzZln9LjjfqPXI0KD01Bl1QQa2MDCWpkXeNomxUXrBzo3Ia65jNbOQzet7coWfxrk/aqSuLBR
	x7JZiW6hdUs2XIxUTVqHozn49kc5zGnkpX9ExJa5Nx4vp4yP6t8n3H9gRBpjxjuWTfC+vyS4Umx
	H5PAkl5Aip8FT6nYob8lgWZS4tXRlubBtO9KLE8FBOs5+zMdaK9nd30KAufxti7tqq
X-Received: by 2002:a17:903:13d0:b0:2dd:c100:80bd with SMTP id d9443c01a7336-2ddc10081cdmr113240275ad.56.1790000519755;
        Mon, 21 Sep 2026 07:21:59 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc179dbd5sm35130485ad.39.2026.09.21.07.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 07:21:58 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Koichiro Den <den@valinux.co.jp>,
	Yuho Choi <dbgh9129@gmail.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] PCI: keystone: fix endpoint teardown on remove
Date: Mon, 21 Sep 2026 22:21:47 +0800
Message-ID: <20260921142147.435953-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ks_pcie_probe() initializes the DesignWare PCIe endpoint with
dw_pcie_ep_init() and notifies the endpoint framework after the
endpoint registers have been initialized. However, the remove path
does not perform the corresponding endpoint teardown.

This leaves the EPC initialization state and resources allocated by
the DesignWare endpoint core active after the driver is removed.

Make dw_pcie_ep_deinit() notify the endpoint framework when endpoint
initialization has completed, so controller drivers do not need to
duplicate the notification before endpoint teardown. Keep the
notification conditional since dw_pcie_ep_deinit() is also used on
error paths before pci_epc_init_notify() has been called.

Remove the now redundant explicit notification from the STM32 endpoint
driver.

Cache the controller mode in struct keystone_pcie and use it during
removal to deinitialize the endpoint before runtime PM and the PHYs are
disabled.

Fixes: 23284ad677a9 ("PCI: keystone: Add support for PCIe EP in AM654x Platforms")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Cache the PCIe mode in struct keystone_pcie instead of looking up the
    match data again during removal.
  - Move pci_epc_deinit_notify() into dw_pcie_ep_deinit() to avoid
    duplicating the notification in controller drivers.
  - Remove the now redundant explicit deinit notification from the STM32
    endpoint driver.

 drivers/pci/controller/dwc/pci-keystone.c       | 6 ++++++
 drivers/pci/controller/dwc/pcie-designware-ep.c | 3 +++
 drivers/pci/controller/dwc/pcie-stm32-ep.c      | 1 -
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 602516239a57..59f7b2e152a2 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -121,6 +121,7 @@ struct ks_pcie_of_data {
 
 struct keystone_pcie {
 	struct dw_pcie		*pci;
+	enum dw_pcie_device_mode mode;
 	/* PCI Device ID */
 	u32			device_id;
 	int			intx_host_irqs[PCI_NUM_INTX];
@@ -1226,6 +1227,7 @@ static int ks_pcie_probe(struct platform_device *pdev)
 
 	ks_pcie->np = np;
 	ks_pcie->pci = pci;
+	ks_pcie->mode = mode;
 	ks_pcie->link = link;
 	ks_pcie->num_lanes = num_lanes;
 	ks_pcie->phy = phy;
@@ -1349,9 +1351,13 @@ static void ks_pcie_remove(struct platform_device *pdev)
 {
 	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
 	struct device_link **link = ks_pcie->link;
+	struct dw_pcie *pci = ks_pcie->pci;
 	int num_lanes = ks_pcie->num_lanes;
 	struct device *dev = &pdev->dev;
 
+	if (ks_pcie->mode == DW_PCIE_EP_TYPE)
+		dw_pcie_ep_deinit(&pci->ep);
+
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
 	ks_pcie_disable_phy(ks_pcie);
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index de8ee3db4360..b785e098f759 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -1188,6 +1188,9 @@ void dw_pcie_ep_deinit(struct dw_pcie_ep *ep)
 {
 	struct pci_epc *epc = ep->epc;
 
+	if (epc->init_complete)
+		pci_epc_deinit_notify(epc);
+
 	dw_pcie_ep_cleanup(ep);
 
 	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
diff --git a/drivers/pci/controller/dwc/pcie-stm32-ep.c b/drivers/pci/controller/dwc/pcie-stm32-ep.c
index a7988dff1045..1cb31bd76da5 100644
--- a/drivers/pci/controller/dwc/pcie-stm32-ep.c
+++ b/drivers/pci/controller/dwc/pcie-stm32-ep.c
@@ -304,7 +304,6 @@ static void stm32_pcie_remove(struct platform_device *pdev)
 
 	dw_pcie_stop_link(pci);
 
-	pci_epc_deinit_notify(ep->epc);
 	dw_pcie_ep_deinit(ep);
 
 	stm32_pcie_disable_resources(stm32_pcie);
-- 
2.43.0

