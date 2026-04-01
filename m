Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399093CF046;
	Wed,  1 Apr 2026 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775035918; cv=none; b=HetohPlnfm3km/DRFnb8hrUJTNpKkHZCpRes5KnLKzv2q68P4sig4s+A2URYQGS7EzOnJa9QROxCnWqfHODMBzoG5GHdg1rj06row0KT3fXUzv5++MfNK8ybFbwr9hO9qDppjokS+UrrFiWyWVbSCutdA9z+UTPpOgROKHxLIsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775035918; c=relaxed/simple;
	bh=1QhwwO0tMMhb5/PF/9cK8bvzkNyUt/Wf2sydrtsZXUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:Cc; b=oGOOmUPToeVunW7atHh7VXP2dmkONOGH5HEkbWY2BSFfRFBNcfQHgY7OkdfkC524u1tUCBDNyEMxqZLhhQ4jRfYLv9ERo6sorQfPYVvhznj5Q0DaMUyhjTLBO0/B54U3lITEKd3m8M4+BZadAIpLSiERLZu+ON3YJNUYb4cLbq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=gOwDpT4q; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="gOwDpT4q"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=65659f006e=fe@dev.tdt.de>)
	id 1w7rvM-001Szr-PT; Wed, 01 Apr 2026 11:31:44 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1w7rvM-00CBEM-7W; Wed, 01 Apr 2026 11:31:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1775035903;
	bh=3A2J+2MFklTaE6h9BZznlvghg/HLXg4vKOLkKJTaKbc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gOwDpT4qmA/i4sziFVLw/dUcUMkyGbY5MvhMTnFBSqctDw1rKckGyyuazrHPysRFq
	 Jum4m8g/jW/f1VT9S9DfkgHxTKMpRO8saVKIXpv3gGrVzm1uL2CjdayAtQbLih6qXI
	 uJd8snCMnj1M2JugfKlOjbLkL+i5NCdl3qc6LESKrvgo+7OnyKAw5HWMLSBk75OPwN
	 ch/ZfVDWkL+bc6C65IkUa3ISVrUFSLO96/+H7MeSFgQ8FVigcPWy9bReGMC58PxG3h
	 U0ExqbKsoHuvrrJ4iY/rT74BBOVoFcEYdzwSXJEXCbQ4I6Wc6cduNQxWBiUHBiKdk6
	 5+5BhNsAQ145g==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id C62E6240046;
	Wed,  1 Apr 2026 11:31:43 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id BB256240041;
	Wed,  1 Apr 2026 11:31:43 +0200 (CEST)
Received: from [10.2.3.40] (unknown [10.2.3.40])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 956B123C7E;
	Wed,  1 Apr 2026 11:31:43 +0200 (CEST)
From: Florian Eckert <fe@dev.tdt.de>
Date: Wed, 01 Apr 2026 11:31:41 +0200
Subject: [PATCH v3 5/7] PCI: intel-gw: Add start_link callback function
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260401-pcie-intel-gw-v3-5-63b008c5b7b2@dev.tdt.de>
References: <20260401-pcie-intel-gw-v3-0-63b008c5b7b2@dev.tdt.de>
In-Reply-To: <20260401-pcie-intel-gw-v3-0-63b008c5b7b2@dev.tdt.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775035902; l=3153;
 i=fe@dev.tdt.de; s=20260205; h=from:subject:message-id;
 bh=1QhwwO0tMMhb5/PF/9cK8bvzkNyUt/Wf2sydrtsZXUc=;
 b=R0SlFWwKBmTvsj+uWe29f0bFOcUZ3aaui1f4slpL69Yzhec/iV1C5JcYguj/tAZlOBzsHgrGw
 7AuOwZbgUEwDlrkbIPmFBCUa9PP2Xb0GGRi17WpPBktl8qKpFNldbfH
X-Developer-Key: i=fe@dev.tdt.de; a=ed25519;
 pk=q7Pvv3Au2sAVRhBz5UF7ZqUPNxUwXQ78Jdqu8E6Negk=
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1775035904-4B7CE233-00E17F81/0/0

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
 drivers/pci/controller/dwc/pcie-intel-gw.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index 6d9499d954674a26a74bff56b7fb5759767424c0..afd933050c92ee31c477e0b1738ab1136bdcfbf6 100644
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
@@ -310,25 +320,12 @@ static int intel_pcie_host_setup(struct intel_pcie *pcie)
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
 
-err:
-	phy_exit(pcie->phy);
 phy_err:
 	clk_disable_unprepare(pcie->core_clk);
 clk_err:
@@ -386,6 +383,7 @@ static int intel_pcie_rc_init(struct dw_pcie_rp *pp)
 }
 
 static const struct dw_pcie_ops intel_pcie_ops = {
+	.start_link = intel_pcie_start_link,
 };
 
 static const struct dw_pcie_host_ops intel_pcie_dw_ops = {

-- 
2.47.3

