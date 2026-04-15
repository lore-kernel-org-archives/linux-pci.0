Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A9022CBE6;
	Wed, 15 Apr 2026 08:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241053; cv=none; b=LvjgkUYK+sg8F7qeRmE7HQgkv4Dl+WphrgFk50994CNMQwaGDGtPzhHnRtwgDYwtRe3RITRaT+uNetAHJPK2SapwmxQzyzm6NxqJbevGcSppSBdInPgZC4WNOoWgslgwoRwC9nCHGcvLsa4CvrzWEo377s+v9el2hC8niaRJ6GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241053; c=relaxed/simple;
	bh=xn9R5Y4c2FVuxWGJ+XDVZ0hhgrzdWZnr3TAJrrkBg1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:Cc; b=d8ND4mbkbpRsSbKaNq6kh65jMhPfSf251xovNcGO7X16jny9FRAK5eQI6C07n/2TTEhE+q9H6pGRXcaZfwH5bTpRmTvfNm5J52VA2hghbMswmbyg77Gn+Dw0+TpQ+fUam+v29chvSZvUPBx3cXmEo/DExpPsYouDHwY+jiKMS/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=qVELjG/A; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="qVELjG/A"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=657992536b=fe@dev.tdt.de>)
	id 1wCvC5-003sby-RB; Wed, 15 Apr 2026 10:01:53 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1wCvC5-00FgQP-AC; Wed, 15 Apr 2026 10:01:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1776240112;
	bh=dqCPK//hWZVdcc5L/u7Ya15VIfulvFBTzBi5FMRGLF0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qVELjG/AAGG5V9lc6cJkmATM5aX3aegjZMosxWN9484PmV1e+RSpKiKNCLK69NioN
	 I6xPPQtJW+pzQqXt7d815yjn2HbTF4lLIqpaZNOctE/sRqltlesI6eV99UrBZB2PNT
	 lQs/vPQ/3wgMWwIpJ35qsXNwO71u0frMt5D0VAgztuDSHzC6lTMRwTk94mEn9KXti/
	 hqrXU6YnyrjvENZKMZtwLx4C6mZ1no4x7WeA00UypcK/joskcIecuJwXpE37LNiGRy
	 8tgO4YWyne2/pl7NBy+xA5qh+1q9Dq48ICYYVrGmSnavBFwATCEkhoWaHNgNI18vCD
	 VCmykxxoS8s2g==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id D75E924004E;
	Wed, 15 Apr 2026 10:01:52 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id C52C0240046;
	Wed, 15 Apr 2026 10:01:52 +0200 (CEST)
Received: from [10.2.3.40] (unknown [10.2.3.40])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id ABD4023F30;
	Wed, 15 Apr 2026 10:01:52 +0200 (CEST)
From: Florian Eckert <fe@dev.tdt.de>
Date: Wed, 15 Apr 2026 10:01:48 +0200 (CEST)
Subject: [PATCH v4 2/7] PCI: intel-gw: Remove unused define
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260415-pcie-intel-gw-v4-2-ad45d2418c8e@dev.tdt.de>
References: <20260415-pcie-intel-gw-v4-0-ad45d2418c8e@dev.tdt.de>
In-Reply-To: <20260415-pcie-intel-gw-v4-0-ad45d2418c8e@dev.tdt.de>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Sajid Dalvi <sdalvi@google.com>,
	Ajay Agarwal <ajayagarwal@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Florian Eckert <fe@dev.tdt.de>,
	Eckert.Florian@googlemail.com, ms@dev.tdt.de
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776240111; l=814;
 i=fe@dev.tdt.de; s=20260205; h=from:subject:message-id;
 bh=xn9R5Y4c2FVuxWGJ+XDVZ0hhgrzdWZnr3TAJrrkBg1E=;
 b=30wXOiI8KcmHESyl9H/yuDXVFd2GzUoEDNdoss5l4AoHLR9luLObnEkIc3lsm58l7iNObn62n
 XTeyr7DHItIDSrCMw0GYQRdqsHEnmXKdfCwtZHBNdjiHnJeE7DF3XfP
X-Developer-Key: i=fe@dev.tdt.de; a=ed25519;
 pk=q7Pvv3Au2sAVRhBz5UF7ZqUPNxUwXQ78Jdqu8E6Negk=
X-purgate-ID: 151534::1776240113-5515C19A-8E439D5D/0/0
X-purgate-type: clean
X-purgate: clean

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

