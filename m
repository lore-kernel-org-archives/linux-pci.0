Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B05233A005
	for <linux-pci@vger.kernel.org>; Wed, 11 Feb 2026 17:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770832585; cv=none; b=M8/v2tqwy4X1NpPaAToQX3fv24klrLH2jrnx+iU1xDGm9HBajPB90uXFjCRmiq4GgXwx6yerylEprNMc2a7kuU7NvgICTlqhRzBAFF/flaOcY3FsWXJ7KxAmnec82OSXzjvU0Z1NcU8WVpR6RrlUGdq5bq5bvR6RM1K5VbNrT8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770832585; c=relaxed/simple;
	bh=l6dFfnknKlo3J3IT+NMTAKey/KbCXRZbP1BSgY2mYok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fbHPmMooZNorzgCgH64QJXdtMbIJZhHdhVM4bIF88RQPqSg8fhrcNS/kzK0JT4/ZrTG6DAqsc/ncHPAh4KnvgDgPEXxJoBlHS652ANTgB7fDAoTdlcLTnSK/K3q72wnUf1LZmXRlcAoZaebvM7g9b2/6jJ3eR44QJCqAAh8QwQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stON7iwI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stON7iwI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534BAC19423;
	Wed, 11 Feb 2026 17:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770832585;
	bh=l6dFfnknKlo3J3IT+NMTAKey/KbCXRZbP1BSgY2mYok=;
	h=From:To:Cc:Subject:Date:From;
	b=stON7iwIPcqmuJruMECDJrY4zPrlRMxJOGw6NyUr7vELYmzXhp/pZ7j9rp289lNR9
	 szQKJR+8xSM3F6AFbY2j/cBQjfRTkIrSxzkQgXKzMh7+9apiJLQUXywNUbSYTTtD2e
	 bcHy8OSE/XPuRUw2DwZPnIDOPPOOpVQeyhgV8dGlcVcSHltxFTRIYI1xwUzlxZqGf8
	 Xv0cD2WDWQmJk4IYFG8mzHsaetpMpTggVLV1SrKHAPF1oFWPSSOzpg46vHIRDeUTLk
	 cS7FdcY2nUgw0OCVeGqVvEtyupMGsN5AmtUA5PnR+uPbgmx2wF9q56ywsO+LpwBfz/
	 2ct7f54LoSyPg==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Koichiro Den <den@valinux.co.jp>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: dwc: ep: Flush before unmap in dw_pcie_ep_raise_msix_irq()
Date: Wed, 11 Feb 2026 18:55:41 +0100
Message-ID: <20260211175540.105677-2-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2276; i=cassel@kernel.org; h=from:subject; bh=l6dFfnknKlo3J3IT+NMTAKey/KbCXRZbP1BSgY2mYok=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJ7Ds1R4JRfJXkjvmOJTuokcd4bs9YuOT3zZcQtDvXyS 9I33LvXd5SyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAikb8ZGY417HlQEr/hsjbn tQ0TPh44ddKhvfm2wndppiBmSdv7MncYGaZkmU/Xb+13+ZJqtPr/8R8bLv2WiHnleKDmCVegcF6 uDhsA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

When running e.g. fio with a larger queue depth against nvmet-pci-epf we
get IOMMU errors on the host, e.g.:

arm-smmu-v3 fc900000.iommu:      0x0000010000000010
arm-smmu-v3 fc900000.iommu:      0x0000020000000000
arm-smmu-v3 fc900000.iommu:      0x000000090000f040
arm-smmu-v3 fc900000.iommu:      0x0000000000000000
arm-smmu-v3 fc900000.iommu: event: F_TRANSLATION client: 0000:01:00.0 sid: 0x100 ssid: 0x0 iova: 0x90000f040 ipa: 0x0
arm-smmu-v3 fc900000.iommu: unpriv data write s1 "Input address caused fault" stag: 0x0

The reason for this is that the writel() is immediately followed by a call
to unmap(), which will tear down the outbound address translation.

PCI writes are posted, i.e. don't wait for a completion. Thus, when the
writel() returns, might not have completed yet, and could even still be
buffered in the PCI bridge, at the time unmap() is called.

Flush the write by performing a read() of the same address, to ensure that
the write has reached the destination before calling unmap().

This will add some latency, but that is certainly preferred over corrupting
the host memory.

The same problem was solved for dw_pcie_ep_raise_msi_irq(), in commit
8719c64e76bf ("PCI: dwc: ep: Cache MSI outbound iATU mapping"), however
there it was solved by dedicating an outbound iATU only for MSI. For MSI-X,
we can't do the same, as each vector can have a different msg_addr, and
because the msg_addr is allowed to be changed while the vector is masked.

Fixes: beb4641a787d ("PCI: dwc: Add MSI-X callbacks handler")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 5d8024d5e5c6..aef41f0218a3 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -1005,6 +1005,9 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 
 	writel(msg_data, ep->msi_mem + offset);
 
+	/* flush posted write before unmap */
+	readl(ep->msi_mem + offset);
+
 	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
 
 	return 0;
-- 
2.53.0

