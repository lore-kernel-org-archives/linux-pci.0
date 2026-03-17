Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C778D3644AD
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773743475; cv=none; b=p27ZNpKXq1cIXJb2U0VQIDpNnJeeIlBk6krUOfhf8a2PdzX913KHfz1br44KwjmaSH+x5fO7V9AlpPqLQcxaV8Xauhm5uL6Fyh3wI6+XOU3Qa6fICEXaLLcq9aicKx/oYPETFNYBwtEmRCiWbHCeQLOKsYYaV1LHrIJDQ7ZMWI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773743475; c=relaxed/simple;
	bh=/5XdcWs9Sna5pLSadXumBpJ0yehC4Lc92ylmU89t9Zg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:Cc; b=bVLEzojuLVWtVIAwFTuGPI6L4YrJZDM26wJCo7oZLLZq3kD+et+d4nvyPEXVHAGe1oGxdBIVzenbLg5RyiDrdBgZ3DvCAxgUJZylzAjGz/8uk1ZF6dUBkH9gfCcBdJt4mMIaWxZ0EqH6a0gRtdQbgyuugatdwqCXM+EvlOq4aT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=Ti2FtIcC; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="Ti2FtIcC"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=5550c006e3=fe@dev.tdt.de>)
	id 1w2RQB-00C6wb-QN
	for linux-pci@vger.kernel.org; Tue, 17 Mar 2026 11:13:07 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1w2RQB-00GDXB-EK
	for linux-pci@vger.kernel.org; Tue, 17 Mar 2026 11:13:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1773742387;
	bh=6pEAYrxZ4cSiwtyBA08AwFeNdb6zPp3VxBpv8lwPFAo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ti2FtIcCOY1cBC+9gzS+sfCsRNHBWlQsi4quLTRV+8V3rJQhCNgRr6wSbXxVxQ7Um
	 F8AkjfK1MLk01zk4nnInSZcWqTwudcH4VlOvY28TIbKLAR5Ykal5E+bTjv5wk8XwS3
	 K+aHSxdjr9kd/3FUHVG7bvQSm34GosjJGikW0m9vQnadnM13n+5bLFZXqvgJsIjeyK
	 CTw4t8kZL8a+XmWhqrn3SkKOeZ9VdhSb7do/A/NX33d8v6oe6+028kdaVf8FsATDFa
	 gX53Ggo77kAKTw4Ak6WEsSSlW4bEcdcPRTQJ13RNa7l8c6+YBS85+Rgk0mr0tNgSRR
	 OIzwXBknRsEtg==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 0A05D240047
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 11:13:07 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id EEFF8240046;
	Tue, 17 Mar 2026 11:13:06 +0100 (CET)
Received: from [10.2.3.40] (unknown [10.2.3.40])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id D1DD923715;
	Tue, 17 Mar 2026 11:13:06 +0100 (CET)
From: Florian Eckert <fe@dev.tdt.de>
Date: Tue, 17 Mar 2026 11:12:50 +0100
Subject: [PATCH 2/5] PCI: intel-gw: Enable clock before phy init
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260317-pcie-intel-gw-v1-2-7fe13726ad4f@dev.tdt.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773742386; l=1956;
 i=fe@dev.tdt.de; s=20260205; h=from:subject:message-id;
 bh=/5XdcWs9Sna5pLSadXumBpJ0yehC4Lc92ylmU89t9Zg=;
 b=GInB9Gd/tgUDu/RPQSGxvyI5O8y2tvkJSeul+z+JaRKzPGXkikhdXO7ixq6sXauXseKK49pax
 SZmdFJSTD5cCMYxgCurMPUaLBYenEanftSAhmnOat+Md2br1bs6t3Ux
X-Developer-Key: i=fe@dev.tdt.de; a=ed25519;
 pk=q7Pvv3Au2sAVRhBz5UF7ZqUPNxUwXQ78Jdqu8E6Negk=
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1773742387-EDD1D769-48DBEB0E/0/0

To ensure that the boot sequence is correct, the dwc pcie core clock must
be switched on before phy init call.

This changes are based on patched kernel sources of the MaxLinear SDK,
which can be found at https://github.com/maxlinear/linux

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 drivers/pci/controller/dwc/pcie-intel-gw.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index 3a85bd0ef1b7f9414ce19fe56d82a78e34e9b648..6110a8adb8732dbbd5e9e2db68a0606ccf032ae1 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -292,13 +292,9 @@ static int intel_pcie_host_setup(struct intel_pcie *pcie)
 
 	intel_pcie_core_rst_assert(pcie);
 	intel_pcie_device_rst_assert(pcie);
-
-	ret = phy_init(pcie->phy);
-	if (ret)
-		return ret;
-
 	intel_pcie_core_rst_deassert(pcie);
 
+	/* Controller clock must be provided earlier than PHY */
 	ret = clk_prepare_enable(pcie->core_clk);
 	if (ret) {
 		dev_err(pcie->pci.dev, "Core clock enable failed: %d\n", ret);
@@ -307,13 +303,17 @@ static int intel_pcie_host_setup(struct intel_pcie *pcie)
 
 	pci->atu_base = pci->dbi_base + 0xC0000;
 
+	ret = phy_init(pcie->phy);
+	if (ret)
+		goto phy_err;
+
 	intel_pcie_ltssm_disable(pcie);
 	intel_pcie_link_setup(pcie);
 	intel_pcie_init_n_fts(pci);
 
 	ret = dw_pcie_setup_rc(&pci->pp);
 	if (ret)
-		goto app_init_err;
+		goto phy_err;
 
 	dw_pcie_upconfig_setup(pci);
 
@@ -322,13 +322,13 @@ static int intel_pcie_host_setup(struct intel_pcie *pcie)
 
 	ret = dw_pcie_wait_for_link(pci);
 	if (ret)
-		goto app_init_err;
+		goto phy_err;
 
 	intel_pcie_core_irq_enable(pcie);
 
 	return 0;
 
-app_init_err:
+phy_err:
 	clk_disable_unprepare(pcie->core_clk);
 clk_err:
 	intel_pcie_core_rst_assert(pcie);

-- 
2.47.3

