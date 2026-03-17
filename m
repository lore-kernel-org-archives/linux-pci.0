Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344AB3A63F8
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 10:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773743437; cv=none; b=rEx+jYIBN6AaLkkfrTFCtOotV40meQtOSrKGwezTsLIB1QZXm0bO4FkWCwMqL3KsBDgxgX04yD6MI77hoRIc0nEq1zqHz8PO6wrYEsqp5kXZBTnEVWjcQMmN58K9dVygRr6ClzfBFkqb+Qjs9llVIlBz8gztoHYK+K/vZSuXhWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773743437; c=relaxed/simple;
	bh=kmkLIZHjhUEmlXZEil2V+s0kDT0h08LGh+sl+iDQ3Mg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:Cc; b=quHVriTB65bXFmPWDYtAKkAXR8muT8jnGyoANQeWk5dQ359Y5gq4sMFxqbob4CYekOkCIEOJbQFxndTps0HrnuMP/jqFSHAZFBqyjJAUg3TMUpkEjJvvTvABuS+/gwT76xtEESF/gFPc9ozz63c8sXrHdtHYLCRsFcgYFgolQ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=hLI9X+Jl; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="hLI9X+Jl"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=5550c006e3=fe@dev.tdt.de>)
	id 1w2RQC-00C6wz-3Z
	for linux-pci@vger.kernel.org; Tue, 17 Mar 2026 11:13:08 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1w2RQB-00G1HB-OK
	for linux-pci@vger.kernel.org; Tue, 17 Mar 2026 11:13:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1773742387;
	bh=omyRy/ftDGmf0KnvkIOI4hdXpwxtXhtFfVSJa7RPKHk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hLI9X+JlnsXv+d2p0R7dymvTwufZm0vPLWfxPjYUZbY5GQpsCkhPjdhy3K37HI1dM
	 3Dwhrn3enwTENUaJ+PnhFqbjhYYxupMYr9PdmkKtqCddJcg20fQDmq4rDNWLo/3JLA
	 vOmsC9o3Y+M93KRwdOZI1cw4vcmmnzREn6qDF3CmiyXxB6hGwLveZnW35XnL4awFSF
	 ormY0jLSrfqsv5C40fN7sbOnN+aSYidGZ6QnGskr2S+ebwMwm1lfF4bh1FiCwL2odR
	 jlr3CwBUWdFm6BXhubtfM3oJsmJ0xca3UhpLvp0gXsfVtZ4Pt+tcBijediMgi4XA02
	 oUlRtAyr+Ag4w==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 31FEF240051
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 11:13:07 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 2E2D1240050;
	Tue, 17 Mar 2026 11:13:07 +0100 (CET)
Received: from [10.2.3.40] (unknown [10.2.3.40])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 1538623715;
	Tue, 17 Mar 2026 11:13:07 +0100 (CET)
From: Florian Eckert <fe@dev.tdt.de>
Date: Tue, 17 Mar 2026 11:12:52 +0100
Subject: [PATCH 4/5] PCI: intel-gw: Remove atu base assignment
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260317-pcie-intel-gw-v1-4-7fe13726ad4f@dev.tdt.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773742386; l=1254;
 i=fe@dev.tdt.de; s=20260205; h=from:subject:message-id;
 bh=kmkLIZHjhUEmlXZEil2V+s0kDT0h08LGh+sl+iDQ3Mg=;
 b=8hTae6K5juxr2UzLW8L/d1DqAAqbJlDrGoY3NYCB1f2a+t5uZFx7gTkBrUgHEe4pGnpeQiwCq
 dZ7vnXxqxXcDQAUSYW44nF89LNQKkjOjmDfzOZWUs1jH+YDH+XvV7LN
X-Developer-Key: i=fe@dev.tdt.de; a=ed25519;
 pk=q7Pvv3Au2sAVRhBz5UF7ZqUPNxUwXQ78Jdqu8E6Negk=
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1773742388-06D1F769-6AB1F215/0/0

In the current implementation, only one PCIe bridge is recognised. This
change removes the assignment of the ATU base address during host setup.
Instead, the ATU base address is read from the device tree. To do this,
the 'atu' range of the DTS entry must be changed for PCIe.

Old DTS entry for PCIe:
reg = <0xd1000000 0x1000>,
	<0xd3000000 0x20000>,
	<0xd0c41000.0x1000>;
reg-names = "dbi", "config", "app";

New DTS entry for PCIe
reg = <0xd1000000 0x1000>,
	<0xd10c0000 0x1000>,
	<0xd3000000 0x20000>,
	<0xd0c41000.0x1000>;
reg-names = "dbi", "atu", "config", "app";

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 drivers/pci/controller/dwc/pcie-intel-gw.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index 6bd25f8da605032bfdb97596fb3a1f6a03e88bfc..cec972d5aa9107d4708338bd7349415a31f0e688 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -311,8 +311,6 @@ static int intel_pcie_host_setup(struct intel_pcie *pcie)
 		goto clk_err;
 	}
 
-	pci->atu_base = pci->dbi_base + 0xC0000;
-
 	ret = phy_init(pcie->phy);
 	if (ret)
 		goto phy_err;

-- 
2.47.3

