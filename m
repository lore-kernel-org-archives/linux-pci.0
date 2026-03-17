Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE5E369220
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 10:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773743461; cv=none; b=BiPcmsxd/QN8rR3ejjZH8RIfKz9AYkxnlf15BZMP0hS2H/ogS+lq3Ehxz215SyAS8O0JC9l5fL06EtUtYS4mRqQ6vF7ZC3YwY63JQl4VujCneFrLiORU8u21KGMx36TWb3sY21CMRDJ7CvkPjR09wGNgR67QvDVjpWHgAjdlpdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773743461; c=relaxed/simple;
	bh=x0G6kbp3HPUk+Ad9f2NmimHwiVEP6L9O7uku31wgrpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:Cc; b=NLPotaOfDf7mSg6rqdz74JhCETew+i35Mc4e9mCVrwhKeOv7iJegfamBZlI+/GRHv2S5+cpVSLyYafUSqntd0ui0M1sbHiNhEM9MOiFVDb7svxhiAYTwl+6NtsIZvWS5kELF7b6m5lI8dgXdWXeedWA3rHNp+JJE+7k2L3CfdvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=kpK5HHp0; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="kpK5HHp0"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=5550c006e3=fe@dev.tdt.de>)
	id 1w2RQB-00C6wW-PH
	for linux-pci@vger.kernel.org; Tue, 17 Mar 2026 11:13:07 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1w2RQB-007eQO-CJ
	for linux-pci@vger.kernel.org; Tue, 17 Mar 2026 11:13:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1773742387;
	bh=zg7zDCV4smsRlNBf4AysL3MRNisHZBZ6g50pqPBg2Cc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kpK5HHp0ZRWnffKtIEVl4U7riPagMcVn6Seqd/a9fZ71MYWn3U4jzXa1AUWVVlURD
	 8alSGb+BZSqbgCgq22p8ihX8Vjgt8izWMU+1iigJtD1HZYzHMhN6I3rbJ2c3iaTjLn
	 GHK5MBrXBWFpS7dzMvkNrxWz3KiDw85XfNUumTQJHlYrgC4iQWpcoolS4M5X1Ki9N6
	 1bgFdS4nfz6pyrzN6rrepw763kgWDStOKaWikGpVk4P2alTtw+s47ZX1UISQ+qJCZY
	 qwug9z61V9UeqXkjifEJWuvzGWCZMLzsszXkk2vqVlcEKGKjF4Wbt/hI5ZH6Wud1Ws
	 s2sg7Kv95JWpA==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id EB31B240045
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 11:13:06 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id D33C9240042;
	Tue, 17 Mar 2026 11:13:06 +0100 (CET)
Received: from [10.2.3.40] (unknown [10.2.3.40])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id B927B237A2;
	Tue, 17 Mar 2026 11:13:06 +0100 (CET)
From: Florian Eckert <fe@dev.tdt.de>
Date: Tue, 17 Mar 2026 11:12:49 +0100
Subject: [PATCH 1/5] PCI: intel-gw: Move interrupt enable to own function
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260317-pcie-intel-gw-v1-1-7fe13726ad4f@dev.tdt.de>
References: <20260317-pcie-intel-gw-v1-0-7fe13726ad4f@dev.tdt.de>
In-Reply-To: <20260317-pcie-intel-gw-v1-0-7fe13726ad4f@dev.tdt.de>
To: Chuanhua Lei <lchuanhua@maxlinear.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Sajid Dalvi <sdalvi@google.com>,
	Ajay Agarwal <ajayagarwal@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Florian Eckert <fe@dev.tdt.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773742386; l=1433;
 i=fe@dev.tdt.de; s=20260205; h=from:subject:message-id;
 bh=x0G6kbp3HPUk+Ad9f2NmimHwiVEP6L9O7uku31wgrpk=;
 b=lc0Wvl8sgOs/PsbxjJyrN1Y3aozSx5CPTx8DLq93DyQRSGetDxaL0vAjQyymOoMWZHFTX4nqS
 zew5Rr1x3MeDsCPNony/5UrTN/+RhgTDn1hakTj+oJc3La/mRjWT9KP
X-Developer-Key: i=fe@dev.tdt.de; a=ed25519;
 pk=q7Pvv3Au2sAVRhBz5UF7ZqUPNxUwXQ78Jdqu8E6Negk=
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1773742387-E551C769-7A1DA8B0/0/0

To improve the readability of the code, move the interrupt enable
instructions to a separate function. That is already done for the
disable interrupt instruction.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 drivers/pci/controller/dwc/pcie-intel-gw.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index c21906eced61896c8a8307dbd6b72d229f9a5c5f..3a85bd0ef1b7f9414ce19fe56d82a78e34e9b648 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -196,6 +196,13 @@ static void intel_pcie_device_rst_deassert(struct intel_pcie *pcie)
 	gpiod_set_value_cansleep(pcie->reset_gpio, 0);
 }
 
+static void intel_pcie_core_irq_enable(struct intel_pcie *pcie)
+{
+	pcie_app_wr(pcie, PCIE_APP_IRNEN, 0);
+	pcie_app_wr(pcie, PCIE_APP_IRNCR, PCIE_APP_IRN_INT);
+	pcie_app_wr(pcie, PCIE_APP_IRNEN, PCIE_APP_IRN_INT);
+}
+
 static void intel_pcie_core_irq_disable(struct intel_pcie *pcie)
 {
 	pcie_app_wr(pcie, PCIE_APP_IRNEN, 0);
@@ -317,9 +324,7 @@ static int intel_pcie_host_setup(struct intel_pcie *pcie)
 	if (ret)
 		goto app_init_err;
 
-	/* Enable integrated interrupts */
-	pcie_app_wr_mask(pcie, PCIE_APP_IRNEN, PCIE_APP_IRN_INT,
-			 PCIE_APP_IRN_INT);
+	intel_pcie_core_irq_enable(pcie);
 
 	return 0;
 

-- 
2.47.3

