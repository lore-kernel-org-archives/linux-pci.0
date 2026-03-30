Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364693B27D3;
	Mon, 30 Mar 2026 09:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774861659; cv=none; b=bKdvvczLtC3vr3N36zizLGwETO6Bb5pFBBq30YxU5I6fhsPZFS1+V3lHuOVZSP7EzPMWpenoZECQvA42rZtZaR6F3gFvIx/jMLU8hviagTd+zsupqac6F2sxFanFfkbxi2HX1fdzc5nJSgWsLna+MF4krbgORAJap/aJyjJLMxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774861659; c=relaxed/simple;
	bh=e55VB0sOSl+JSPzr6ZYodo7iAcDR8KlkDnHRQ4PcMVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:Cc; b=jsKw0FAWPR+z71ikxJNr3O0rxMl2wb9heXWlem43tHkIdglTO/gfySPf5qLZRsgmDuVs8bY8/+p+XmtgMUFkLDgXBp6YAmCp9cvnjatugTB4SQGfb3Gd313bpaWYeWLk9cJPPSrFA8HJOuy9QrOe0i3/t1bYKARkkO1aD+F4ILI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=axZyibhz; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="axZyibhz"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=65635f912b=fe@dev.tdt.de>)
	id 1w78aq-008YdX-5D; Mon, 30 Mar 2026 11:07:32 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1w78ap-009iaI-Jq; Mon, 30 Mar 2026 11:07:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1774861651;
	bh=m+/djrkgilb4aSqNgXkCDE4sf4r1b8wwgRVEYUv5Q00=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=axZyibhznQD0z1wIFU65AWimUJ1U3QbLt5GxJ/ENDBbTuMEqB5CbPvQl7o0oNO9ks
	 U0plnpdOLKXyJId1P71aMSHMUn6JrPKUMtGBaIPAOoXlWSMDxTiMZNUUOhyvph1M7p
	 8WaT6drBoU+pv1sMGFHfqqBBdgwyWqgE95ro/JsFmzlxFvbszM/Dh2hTsbgm/WUk1b
	 Nkje//32iLyA+LPQ4fAJyFnAGXYPQRDQtu52qc8QrjtKaAvBdvUGvWFv+k1R8HnMvK
	 EgxrwThE5hGnFhqNJpQnLPaZZjGL+PGbD0TORnvPzqv+pBc3xJzXX3HU01XmqW8ixb
	 mtrduscsCao3A==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 3462F240051;
	Mon, 30 Mar 2026 11:07:31 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 2B60A240050;
	Mon, 30 Mar 2026 11:07:31 +0200 (CEST)
Received: from [10.2.3.40] (unknown [10.2.3.40])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 05A3B2040A;
	Mon, 30 Mar 2026 11:07:31 +0200 (CEST)
From: Florian Eckert <fe@dev.tdt.de>
Date: Mon, 30 Mar 2026 11:07:14 +0200
Subject: [PATCH v2 4/7] PCI: intel-gw: Add start_link callback function
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260330-pcie-intel-gw-v2-4-8bd07367a298@dev.tdt.de>
References: <20260330-pcie-intel-gw-v2-0-8bd07367a298@dev.tdt.de>
In-Reply-To: <20260330-pcie-intel-gw-v2-0-8bd07367a298@dev.tdt.de>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Sajid Dalvi <sdalvi@google.com>,
	Ajay Agarwal <ajayagarwal@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rahul Tanwar <rtanwar@maxlinear.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Florian Eckert <fe@dev.tdt.de>,
	Eckert.Florian@googlemail.com, ms@dev.tdt.de
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774861650; l=3052;
 i=fe@dev.tdt.de; s=20260205; h=from:subject:message-id;
 bh=e55VB0sOSl+JSPzr6ZYodo7iAcDR8KlkDnHRQ4PcMVk=;
 b=VkjBonXUhPvt5S5XDvblpL/gtoaP1nwAGJeUlXaTe9uYErZGn5MRGJ6P0XwSJfTh6fTkOm2bh
 W+BlfVSHfolBvSPpaqUk9bwYzMSvJxxuXgkayOe2nSCzRq/+QlGgWLi
X-Developer-Key: i=fe@dev.tdt.de; a=ed25519;
 pk=q7Pvv3Au2sAVRhBz5UF7ZqUPNxUwXQ78Jdqu8E6Negk=
X-purgate: clean
X-purgate-ID: 151534::1774861652-C7C23842-48C85DE9/0/0
X-purgate-type: clean

The pcie-intel-gw driver has no start_link callback function. This commit
adds the missing callback function so that the driver works again and does
not abort with the following error messages during probing.

[    2.512015] intel-gw-pcie d1000000.pcie: host bridge /soc/pcie@d1000000 ranges:
[    2.517868] intel-gw-pcie d1000000.pcie:      MEM 0x00dc000000..0x00ddffffff -> 0x00dc000000
[    2.528450] intel-combo-phy d0c00000.combo-phy: Set combo mode: combophy[1]: mode: PCIe single lane mode
[    2.551619] intel-gw-pcie d1000000.pcie: No outbound iATU found
[    2.556060] intel-gw-pcie d1000000.pcie: Cannot initialize host
[    2.561901] intel-gw-pcie d1000000.pcie: probe with driver intel-gw-pcie failed with error -22
[    2.571041] intel-gw-pcie c1100000.pcie: host bridge /soc/pcie@c1100000 ranges:
[    2.577736] intel-gw-pcie c1100000.pcie:      MEM 0x00ce000000..0x00cfffffff -> 0x00ce000000
[    2.588299] intel-combo-phy c0c00000.combo-phy: Set combo mode: combophy[3]: mode: PCIe single lane mode
[    2.611471] intel-gw-pcie c1100000.pcie: No outbound iATU found
[    2.615934] intel-gw-pcie c1100000.pcie: Cannot initialize host
[    2.621759] intel-gw-pcie c1100000.pcie: probe with driver intel-gw-pcie failed with error -22

Fixes: c5097b9869a1 ("Revert "PCI: dwc: Wait for link up only if link is started"")
Fixes: da56a1bfbab5 ("PCI: dwc: Wait for link up only if link is started")
Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 drivers/pci/controller/dwc/pcie-intel-gw.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index 6d9499d954674a26a74bff56b7fb5759767424c0..24c463781f1e31d5617a5ff81bdbce563ed5a1d0 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -284,6 +284,16 @@ static void intel_pcie_turn_off(struct intel_pcie *pcie)
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
@@ -310,19 +320,8 @@ static int intel_pcie_host_setup(struct intel_pcie *pcie)
 	intel_pcie_link_setup(pcie);
 	intel_pcie_init_n_fts(pci);
 
-	ret = dw_pcie_setup_rc(&pci->pp);
-	if (ret)
-		goto err;
-
 	dw_pcie_upconfig_setup(pci);
 
-	intel_pcie_device_rst_deassert(pcie);
-	intel_pcie_ltssm_enable(pcie);
-
-	ret = dw_pcie_wait_for_link(pci);
-	if (ret)
-		goto err;
-
 	intel_pcie_core_irq_enable(pcie);
 
 	return 0;
@@ -386,6 +385,7 @@ static int intel_pcie_rc_init(struct dw_pcie_rp *pp)
 }
 
 static const struct dw_pcie_ops intel_pcie_ops = {
+	.start_link = intel_pcie_start_link,
 };
 
 static const struct dw_pcie_host_ops intel_pcie_dw_ops = {

-- 
2.47.3

