Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394683CEBAD;
	Wed,  1 Apr 2026 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775035917; cv=none; b=c1pLKo51VtYTblEziJennBIfSJcPFZFyfUVf0TAK9irNFEO7Y5dlxnCYFg/52ox0QdOA8mv7a6OU4uT9MMmCxWiJC/M+aMWEYET60ybM6InXDjcvK0NMSp1dAOmnEuYpFhEKO1d1mPFoS3hcgQUpqAMYa6HESiNkp5LSM3mX4dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775035917; c=relaxed/simple;
	bh=coHmsdtqcsW+dKyhuAd7vn7jGgDFbg9jYRqHLyenC9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:Cc; b=PndI7CifZV9S0qHtZqaxGpA1nj+8YWmQuNlvOqY9tpWROre0s8xHcn847DdMpRHHjJWLu9edzIiabDtNrQYyXvjIKlq5hkcRIpNVoQDDqfBATJaHFm4BBODAQPgtHBzQlBbEyhO43pyFzOw2+Hw7/c5rNGoqTYl79BNONovQ5DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=pkp8mrrb; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="pkp8mrrb"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=65659f006e=fe@dev.tdt.de>)
	id 1w7rvM-001SzK-Le; Wed, 01 Apr 2026 11:31:44 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1w7rvM-003a8t-42; Wed, 01 Apr 2026 11:31:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1775035903;
	bh=eTw8E3ezVzDUqc+dP4JdW7vl/OP8CGUQKxaL+SejZ2g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pkp8mrrbEocjtIIeeWx7LvW2p+rex33JmWAdUFFo2Xt6lo1MxFHgGG8A39m2kRM8Z
	 G+8bbTmNnSNh5Bd3OuhomSHK72YxqDkP7Od4Sjow88G9xHyRzbBqbYa02ksqe9bDS/
	 A/1LKyHbCpeRWlvxX5MehNNieWSQEvyK2tFV+LcvHEccc4tAQwsbu0Ytz7flX2aUUE
	 BGFU8wYR79A6aV+NKGqldlNDXDZvWQNganaZrCFD6cQTxxTnveuYEpKWVk4dUH/Fp4
	 0e5BPY9cRrNkUo2uOirRcxWxsuprJh+iEDd4hhYRyOkiLmMeOgaM9k6cIBkRwGEfgC
	 Q0eUubrw0UUIw==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id A3A8824004F;
	Wed,  1 Apr 2026 11:31:43 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 97FCB240046;
	Wed,  1 Apr 2026 11:31:43 +0200 (CEST)
Received: from [10.2.3.40] (unknown [10.2.3.40])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 792D023C6F;
	Wed,  1 Apr 2026 11:31:43 +0200 (CEST)
From: Florian Eckert <fe@dev.tdt.de>
Date: Wed, 01 Apr 2026 11:31:40 +0200
Subject: [PATCH v3 4/7] PCI: intel-gw: Enable clock before phy init
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260401-pcie-intel-gw-v3-4-63b008c5b7b2@dev.tdt.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775035902; l=2080;
 i=fe@dev.tdt.de; s=20260205; h=from:subject:message-id;
 bh=coHmsdtqcsW+dKyhuAd7vn7jGgDFbg9jYRqHLyenC9w=;
 b=upmlMIqhxzzCBzYMxjiufaXeChhcEK6DMbp8eW3nyfpQ7M1+fzt4eU9xZ55SaDbLFN01wVifK
 9ljfiAJ+60WDY/2pEJ2kFQYvV3VVXGr3Yh4tS/9zZvC+foq3A8n9Hzb
X-Developer-Key: i=fe@dev.tdt.de; a=ed25519;
 pk=q7Pvv3Au2sAVRhBz5UF7ZqUPNxUwXQ78Jdqu8E6Negk=
X-purgate-ID: 151534::1775035904-3D7CA233-2D4E2C4D/0/0
X-purgate: clean
X-purgate-type: clean

To ensure that the boot sequence is correct, the dwc pcie core clock must
be switched on before phy init call [1]. This changes are based on patched
kernel sources of the MaxLinear SDK.

[1] https://github.com/maxlinear/linux/blob/updk_9.1.90/drivers/pci/controller/dwc/pcie-intel-gw.c#L544

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 drivers/pci/controller/dwc/pcie-intel-gw.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index e88b8243cc41c607c39e4d58c4dcd8c8c082e8b0..6d9499d954674a26a74bff56b7fb5759767424c0 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -291,13 +291,9 @@ static int intel_pcie_host_setup(struct intel_pcie *pcie)
 
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
@@ -306,13 +302,17 @@ static int intel_pcie_host_setup(struct intel_pcie *pcie)
 
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
+		goto err;
 
 	dw_pcie_upconfig_setup(pci);
 
@@ -321,17 +321,18 @@ static int intel_pcie_host_setup(struct intel_pcie *pcie)
 
 	ret = dw_pcie_wait_for_link(pci);
 	if (ret)
-		goto app_init_err;
+		goto err;
 
 	intel_pcie_core_irq_enable(pcie);
 
 	return 0;
 
-app_init_err:
+err:
+	phy_exit(pcie->phy);
+phy_err:
 	clk_disable_unprepare(pcie->core_clk);
 clk_err:
 	intel_pcie_core_rst_assert(pcie);
-	phy_exit(pcie->phy);
 
 	return ret;
 }

-- 
2.47.3

