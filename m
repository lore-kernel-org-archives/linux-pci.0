Received: from mta0.migadu.com (out-29.mta0.migadu.com [91.218.175.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6D4424668
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 18:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790186876; cv=none; b=QKP7hPs9H/2Mc+vvJkelXYaBtuuiD80JkeJXntWH2Xk2aRiD257IYOMR7mycH2C7FMGCQf76WRVArAZjFtX9s3kOX1BeZnMLT2PS9C+Jx4d7xF2w21oc4HWzgTGDuGEBiYWvb5XIBjOCjIagW8hrYSfAli+l8yk7zc7o3R9oJ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790186876; c=relaxed/simple;
	bh=bp0SnK46xnvz/q8fX5PdkYUTIaH6Zd0obLz2gE4r2gY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ClkIpWOb5pbNNUZe9fW8R65X0fRjSsxtMwQcGJ/pNv1poQjkz+b3xaDAtmdp2paMWPufKfqgPnM1spoTkc0rO6yiVsSGGlbN+GW540JJJ81IbEY8KjFLgpnSsjGsYatzk9gxpeUett17LH/DDTsDEf9xO4bb+fHfVtMTlhKxuuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u/W4NWyF; arc=none smtp.client-ip=91.218.175.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u/W4NWyF"
X-Envelope-To: linux-pci@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=bp0SnK46xnvz/q8fX5PdkYUTIaH6Zd0obLz2gE4r2gY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790186871; v=1; x=1790791671;
 b=u/W4NWyFrBL56Tt/9bzBEJDx/7TbwWqM+UwBDAZ9JblZPdkea7FnD+Bbbu9fzbsRzFJA0niu
 rjx3ZudkE+FksUD85x9WNW6/N8lYJZz5f8nTRM0jel9Y6s6tGPw7LWNE8W6GBn74GCYTKHmRacm
 /xGnNBQIVjW9fzFj9KlOyOkI=
X-Envelope-To: linux-pci@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a9800f2f57d37519;
	Wed, 23 Sep 2026 18:07:51 +0000
X-Mizu-Trace-ID: a9800f2f57d37519
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
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Fuad Tabba <tabba@google.com>
Subject: [PATCH v2] PCI: rcar-gen4: Fix device_node leak in rcar_gen4_pcie_host_msi_addr()
Date: Wed, 23 Sep 2026 19:07:49 +0100
Message-Id: <20260923180749.3906547-1-fuad.tabba@linux.dev>
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
Tested-by: Marek Vasut <marek.vasut+renesas@mailbox.org> # Retronix R-Car V4H Sparrow Hawk
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---

Notes:
    Changes since v1:
    - Declare msi_node immediately before of_msi_xlate() rather than at the
      top of the function, as Jonathan asked on the iproc conversion [1].
    - Kept Marek's Tested-by and Reviewed-by, since the generated code
      differs only in the stack offsets of msi_node and res.
    
    [1] https://lore.kernel.org/all/20260923093433.00006cab@oss.qualcomm.com/

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index fbe465a29068f..bb2fcfd6861ac 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -323,7 +323,6 @@ static struct rcar_gen4_pcie *rcar_gen4_pcie_alloc(struct platform_device *pdev)
 static int rcar_gen4_pcie_host_msi_addr(struct dw_pcie_rp *pp, u32 *msi_addr)
 {
 	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
-	struct device_node *msi_node = NULL;
 	struct device *dev = dw->dev;
 	struct resource res;
 	u64 addr;
@@ -333,6 +332,7 @@ static int rcar_gen4_pcie_host_msi_addr(struct dw_pcie_rp *pp, u32 *msi_addr)
 	 * Either the "msi-parent" or the "msi-map" phandle needs to exist
 	 * to obtain the MSI node.
 	 */
+	struct device_node *msi_node __free(device_node) = NULL;
 	of_msi_xlate(dev, &msi_node, 0);
 	if (!msi_node)
 		return -ENODEV;

base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
-- 
2.39.5

