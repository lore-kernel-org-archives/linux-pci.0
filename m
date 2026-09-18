Received: from mta0.migadu.com (out-210.mta0.migadu.com [91.218.175.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50404233933
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 09:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722657; cv=none; b=D41SF0mbjHXfGrrJVWDZ3vBfYd4KpqJ/7PTdC53K9I0c2/bX1SCvc4GWsIietzNDYWjB5RbUA/fkowzgmVpmIn93xjNl9IkV3MCtvWTIgw8w0RVTOxsf+wG46XIfadPdnVxPbfGGJSSqYDCd+bxNZ1uXbOsN42wsJgsOI6mu8Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722657; c=relaxed/simple;
	bh=+nFT68k+iSfyrsDO8ToUvUVP7hpqu08StVXMHZ1pAfw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f09HYlLxRANChL6eudFKBmzCYuAjHW0YC3gs6W3foZTFAzLQ9cOIZlbq7D1wTHDvHlT4+w3N46+H5jvNreNNeSA5Q3bjSO3TEuyB8Bfc7B2k2M4U6+BeRZ1T4B0u5+GS4GzG+yxVbId2NyzRCa9g0TAon309FWumDp+jI2tgFtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s/1Tni4w; arc=none smtp.client-ip=91.218.175.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s/1Tni4w"
X-Envelope-To: linux-pci@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+nFT68k+iSfyrsDO8ToUvUVP7hpqu08StVXMHZ1pAfw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789722653; v=1; x=1790327453;
 b=s/1Tni4wHWDnmMz8qWqjWZ2khAAa3ZterOUZBnF3Q+ARgmnwtRQWR+6yFG4Y6O421P0zuO8l
 /Fs3vBPzPiXFsok5IGv+1479Llqv7n5Q9SkNlIyLwfSaOzyB91Rv32cL4b+P28ZzGlg+sew/hKE
 R5dL/QKR6L5kduhB/DCZDORU=
X-Envelope-To: linux-pci@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7623a7ca1f8127fa;
	Fri, 18 Sep 2026 09:10:53 +0000
X-Mizu-Trace-ID: 7623a7ca1f8127fa
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Fuad Tabba <tabba@google.com>
Subject: [PATCH] PCI: rcar-gen4: Fix device_node leak in rcar_gen4_pcie_host_msi_addr()
Date: Fri, 18 Sep 2026 10:10:52 +0100
Message-Id: <20260918091052.2825315-1-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rcar_gen4_pcie_host_msi_addr() calls of_msi_xlate() with *msi_np NULL,
so it receives the MSI controller node with a reference held, and every
return past the NULL check leaks that reference, the success path
included. Declare msi_node with __free(device_node) so it's put on
every return.

Fixes: 8d6af27c0a73 ("PCI: rcar-gen4: Configure AXIINTC if iMSI-RX is not used")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-pci/20260905213855.8D6671F00A3D@smtp.kernel.org/
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index fbe465a29068f..d61ce802b4614 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -323,7 +323,7 @@ static struct rcar_gen4_pcie *rcar_gen4_pcie_alloc(struct platform_device *pdev)
 static int rcar_gen4_pcie_host_msi_addr(struct dw_pcie_rp *pp, u32 *msi_addr)
 {
 	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
-	struct device_node *msi_node = NULL;
+	struct device_node *msi_node __free(device_node) = NULL;
 	struct device *dev = dw->dev;
 	struct resource res;
 	u64 addr;

base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
-- 
2.39.5

