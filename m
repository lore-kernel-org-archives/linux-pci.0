Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44B73A783B;
	Mon, 30 Mar 2026 09:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774861658; cv=none; b=Y1ldEwUBxTickOlaQvnMkKNgjclrNo/vftzmNBcd6X60xWcOPmbcwRLK3jJ0s1gYoMcDmhjAHrGuUfkx8Un4DE+PJB+EB9AlaU34Z+L3vsuirqDusXeiuJ4t4NzNek7+HlW8hr8Rmj5drCTbvUHxDdzFaYPV0SEAjTrRM0Eqq9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774861658; c=relaxed/simple;
	bh=xn9R5Y4c2FVuxWGJ+XDVZ0hhgrzdWZnr3TAJrrkBg1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:Cc; b=RsKZ4bAaY8L7srHA9Ksqt3f+jnLVk9Q0wKsnhVYR2TpiqDOxTMwFMY4osttKf/Q+9ChEBtzmUloDkzLm7sMMRHED+zW9/O79T3A3UCxn+6QU4olnn4M8g7KLsPfw7DLTZPVjkUhkL3LOT2DkrN7OMtARaqt+hhJbgmHNfNsEpVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=SFLHwWLi; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="SFLHwWLi"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=65635f912b=fe@dev.tdt.de>)
	id 1w78ap-008YcW-QT; Mon, 30 Mar 2026 11:07:31 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1w78ap-001zkS-8Z; Mon, 30 Mar 2026 11:07:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1774861650;
	bh=dqCPK//hWZVdcc5L/u7Ya15VIfulvFBTzBi5FMRGLF0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SFLHwWLiFRB5SJLzUdu0l+RzPao/+783rGqSJYfjkXXfJgrRnaul+Q8aF+cfECPZY
	 iaTgD6vwepPo/v345Gs1HPwizgpy7BkdMgme51VcuTAHBTlrMhrpAY8SDyKDWBJgC8
	 znWsNKe7C0Db8r0O1E1Roi+kRJ7oZ4t3UGRVS4+Xxgd5X2oQvJp2omk7R3zee5oQgF
	 0VWNDESlRP8nrWkzFnYi1DUQhBED/r87/aZSW6g1pz7r/lhsgVt5xctFZ25fhyxjBH
	 gRqkUXZLF3xV3t7xBxMnOA3GBupznnuKg6EsTaTx7FU++6MlH3RdQTfvp7NV3tM9NG
	 K0Fvd0i1Af+3g==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id CF68D240036;
	Mon, 30 Mar 2026 11:07:30 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id B656F240042;
	Mon, 30 Mar 2026 11:07:30 +0200 (CEST)
Received: from [10.2.3.40] (unknown [10.2.3.40])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 9A07720E49;
	Mon, 30 Mar 2026 11:07:30 +0200 (CEST)
From: Florian Eckert <fe@dev.tdt.de>
Date: Mon, 30 Mar 2026 11:07:11 +0200
Subject: [PATCH v2 1/7] PCI: intel-gw: Remove unused define
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260330-pcie-intel-gw-v2-1-8bd07367a298@dev.tdt.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774861650; l=814;
 i=fe@dev.tdt.de; s=20260205; h=from:subject:message-id;
 bh=xn9R5Y4c2FVuxWGJ+XDVZ0hhgrzdWZnr3TAJrrkBg1E=;
 b=FHddLPDNO+kJIcVaelMDMt8m27z+6YGeOf3wn7zLgtR9c5k4XKhiMqOYgmPfXUqzmeH4AOIrI
 YRmjB13eGmaBJoKsyGgmgp3mTz3UKZ9E/CCTrlq6TASdbJ280mgBhFy
X-Developer-Key: i=fe@dev.tdt.de; a=ed25519;
 pk=q7Pvv3Au2sAVRhBz5UF7ZqUPNxUwXQ78Jdqu8E6Negk=
X-purgate: clean
X-purgate-ID: 151534::1774861651-EE6CD842-A28411D9/0/0
X-purgate-type: clean

The C preprocessor define 'PCIE_APP_INTX_OFST' is not used in the sources
and can therefore be deleted.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 drivers/pci/controller/dwc/pcie-intel-gw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index c21906eced61896c8a8307dbd6b72d229f9a5c5f..80d1607c46cbbb1e274b37a0bb9377a877678f5d 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -47,7 +47,6 @@
 #define PCIE_APP_IRN_INTD		BIT(16)
 #define PCIE_APP_IRN_MSG_LTR		BIT(18)
 #define PCIE_APP_IRN_SYS_ERR_RC		BIT(29)
-#define PCIE_APP_INTX_OFST		12
 
 #define PCIE_APP_IRN_INT \
 	(PCIE_APP_IRN_AER_REPORT | PCIE_APP_IRN_PME | \

-- 
2.47.3

