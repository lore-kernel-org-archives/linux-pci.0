Received: from mta0.migadu.com (out-234.mta0.migadu.com [91.218.175.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2321F496D43
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 21:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790111346; cv=none; b=VA3GhAil3Is55qe/49w/YgjdVMEbiZ+53oo11vibr+71xhEnYaBL7FVBGsqbRC6C5TKA12w4TFjqd7MAO3ctefWp9lt42wD5YOx+uD4eeWfMZucORIp+yg+9dGJG62Tp8UEXLOBU78AGNshRFfrNKVMEnNq7AxYryfyDJdAYKJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790111346; c=relaxed/simple;
	bh=mwU7r2R0iXancqDMVbrNZC/D/wd+eK8OiPSqY0f/ZZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g32CR6i90dK+hdLAbCwdDXb9tNahob/TYQQYnEcibUTiTH4WtyA6E2BQKEV8pHPrlTjbXipBo/vDiOwQclfWNf7hT5X2l67qPvPShxobZfBoRhRVklN0SaGHjoKsqY5ZIExQMMFopf4L3KopyO/JXUsJuMUanPSp+qPnZxEoefw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gML+ek9Q; arc=none smtp.client-ip=91.218.175.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gML+ek9Q"
X-Envelope-To: linux-pci@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mwU7r2R0iXancqDMVbrNZC/D/wd+eK8OiPSqY0f/ZZ8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790111324; v=1; x=1790716124;
 b=gML+ek9QH1tqN4jTqppHLRjEkMzm03TC1HkkMBAsxCo+A7RjPSBeBGVvg8AgZeUeNOsA/PH0
 5Z7HAXIOt6/CyMGpXRjl1Rq5rTj1Eoju3BPfjYQKelT8oCTPggHkjEMEDSXdkixGQhSscNOuh65
 UW0ZdEy/YPhfB+H25oPPQrXc=
X-Envelope-To: linux-pci@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a0710456afc2675d;
	Tue, 22 Sep 2026 21:08:44 +0000
X-Mizu-Trace-ID: a0710456afc2675d
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Fuad Tabba <tabba@google.com>
Subject: [PATCH] PCI: iproc: Use __free(device_node) in iproc_pcie_msi_enable()
Date: Tue, 22 Sep 2026 22:08:39 +0100
Message-Id: <20260922210839.3765444-1-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Declare msi_node with __free(device_node) and drop the out_put_node
label and its goto: the scoped cleanup puts the MSI controller node on
every return, as the label did.

No functional change intended.

Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Link: https://lore.kernel.org/linux-pci/61488ddc-b346-4ba3-b32a-e972a3bd75a4@mailbox.org/
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 drivers/pci/controller/pcie-iproc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index afb3aa38ac6bb..b4f4e6e1d4b41 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -1338,7 +1338,7 @@ static int iproc_pcie_msi_steer(struct iproc_pcie *pcie,
 
 static int iproc_pcie_msi_enable(struct iproc_pcie *pcie)
 {
-	struct device_node *msi_node = NULL;
+	struct device_node *msi_node __free(device_node) = NULL;
 	int ret;
 
 	/*
@@ -1357,18 +1357,14 @@ static int iproc_pcie_msi_enable(struct iproc_pcie *pcie)
 	if (pcie->need_msi_steer) {
 		ret = iproc_pcie_msi_steer(pcie, msi_node);
 		if (ret)
-			goto out_put_node;
+			return ret;
 	}
 
 	/*
 	 * If another MSI controller is being used, the call below should fail
 	 * but that is okay
 	 */
-	ret = iproc_msi_init(pcie, msi_node);
-
-out_put_node:
-	of_node_put(msi_node);
-	return ret;
+	return iproc_msi_init(pcie, msi_node);
 }
 
 static void iproc_pcie_msi_disable(struct iproc_pcie *pcie)

base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
-- 
2.39.5

