Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADAD3A6F10
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 10:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773743434; cv=none; b=fydrLEkHLwMmoSt4I1LncW0lp/IVtkO6C3ldjtxRIjryDZhw5nfZm/uSBXiRWmD+r/IxKtZdq+HvWVVlaDlEGtpSb+MAdwKJWAf7HMZiUxzcQePSuRbHf9LscARMKUBUMytgZlFXCwLKGPzH/nixEh6C4nyigYIFEVnU0lfmzE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773743434; c=relaxed/simple;
	bh=xHvZaQnIxQuQrsMBH+rgNaS/khHlKZ3A5ns3b/goJac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:Cc; b=hO51tduPDgHj+BAO3cQP9UnEdFruaT7Ex+firDGJ1pJZRQ2IrLFYNnSzsO713BRX9blHBnAdDKO9s8cvRvob2fMUackd/ERflle8R31ObVDWaL4bokJISObOtW4R7FV3wLMq91PbYFro3+eUD1ORSZIVBpDsMMr92tToXQyMQgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=Q3BX2dRF; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="Q3BX2dRF"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=5550c006e3=fe@dev.tdt.de>)
	id 1w2RQC-00C6wx-28
	for linux-pci@vger.kernel.org; Tue, 17 Mar 2026 11:13:08 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1w2RQB-000ww9-MR
	for linux-pci@vger.kernel.org; Tue, 17 Mar 2026 11:13:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1773742387;
	bh=d3JsyvacRp05aVA8XXv2SfPeY76Tg+WNbGdXggM6Igo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q3BX2dRF9EZsCaHcYoZ7w1y6sA4CMfcUloiApS2sC+sxZj2sBSPDfcfAutN5tMuL6
	 LoSm+tZRxfHxzGcnxNmTpbNGRKVD+LrCjWa8eZs6wdjYgPFqNAhip3S8obszF32Phh
	 ZT1T3w3PDXgdJi02uFnx27J9UakZ7i/vlGuy8C8xVacI9/kq7+QAZMs9Iu8y4Lf+gX
	 ekSg24/iMiABs5amguI9C7Yz5ZbrOotC9JNljeQuVvKfr1YLG7ZIj0Ev+6xfiFowFa
	 Vpoz7ru3ffDIx/m3Yf0GmlKhPOFj6g1Ag5S6udwh0gHTqPtPsRDCcJacLTynqUB/UO
	 1oaS0KaD/yfuw==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 1E4CF240042
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 11:13:07 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 1680F24004F;
	Tue, 17 Mar 2026 11:13:07 +0100 (CET)
Received: from [10.2.3.40] (unknown [10.2.3.40])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id ED2D4237A2;
	Tue, 17 Mar 2026 11:13:06 +0100 (CET)
From: Florian Eckert <fe@dev.tdt.de>
Date: Tue, 17 Mar 2026 11:12:51 +0100
Subject: [PATCH 3/5] PCI: intel-gw: Add start_link callback function
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260317-pcie-intel-gw-v1-3-7fe13726ad4f@dev.tdt.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773742386; l=2024;
 i=fe@dev.tdt.de; s=20260205; h=from:subject:message-id;
 bh=xHvZaQnIxQuQrsMBH+rgNaS/khHlKZ3A5ns3b/goJac=;
 b=OmCnVkGoDtIzcMHc2vawo5oqcRpmF+OUmjhOr+as1jhioLj/a2fmmtjSAId9xpHuFdkbO+lwX
 x8X1mcIZe4KAodBnX8x3QPvBv+3OOXi50KsK6j5H0gSsDK9J0ppphKO
X-Developer-Key: i=fe@dev.tdt.de; a=ed25519;
 pk=q7Pvv3Au2sAVRhBz5UF7ZqUPNxUwXQ78Jdqu8E6Negk=
X-purgate-ID: 151534::1773742388-ED51C769-52A16117/0/0
X-purgate: clean
X-purgate-type: clean

The pcie-intel-gw driver has no start_link callback function. This commit
adds the missing callback function so that the driver works again and does
not abort with an error during probing.

Fixes: c5097b9869a1 ("Revert "PCI: dwc: Wait for link up only if link is started"")
Fixes: da56a1bfbab5 ("PCI: dwc: Wait for link up only if link is started")
Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 drivers/pci/controller/dwc/pcie-intel-gw.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index 6110a8adb8732dbbd5e9e2db68a0606ccf032ae1..6bd25f8da605032bfdb97596fb3a1f6a03e88bfc 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -285,6 +285,16 @@ static void intel_pcie_turn_off(struct intel_pcie *pcie)
 	pcie_rc_cfg_wr_mask(pcie, PCI_COMMAND, PCI_COMMAND_MEMORY, 0);
 }
 
+static int intel_pcie_start_link(struct dw_pcie *pci)
+{
+	struct intel_pcie *pcie = dev_get_drvdata(pci->dev);
+
+	intel_pcie_device_rst_deassert(pcie);
+	intel_pcie_ltssm_enable(pcie);
+
+	return 0;
+}
+
 static int intel_pcie_host_setup(struct intel_pcie *pcie)
 {
 	int ret;
@@ -310,20 +320,8 @@ static int intel_pcie_host_setup(struct intel_pcie *pcie)
 	intel_pcie_ltssm_disable(pcie);
 	intel_pcie_link_setup(pcie);
 	intel_pcie_init_n_fts(pci);
-
-	ret = dw_pcie_setup_rc(&pci->pp);
-	if (ret)
-		goto phy_err;
-
 	dw_pcie_upconfig_setup(pci);
 
-	intel_pcie_device_rst_deassert(pcie);
-	intel_pcie_ltssm_enable(pcie);
-
-	ret = dw_pcie_wait_for_link(pci);
-	if (ret)
-		goto phy_err;
-
 	intel_pcie_core_irq_enable(pcie);
 
 	return 0;
@@ -386,6 +384,7 @@ static int intel_pcie_rc_init(struct dw_pcie_rp *pp)
 }
 
 static const struct dw_pcie_ops intel_pcie_ops = {
+	.start_link = intel_pcie_start_link,
 };
 
 static const struct dw_pcie_host_ops intel_pcie_dw_ops = {

-- 
2.47.3

