Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E132D2397;
	Mon, 30 Mar 2026 09:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774861658; cv=none; b=Hq7oK9xVDjrTx7f6hAyZIFJjWnbmeBYy5JTNX4zwEQ9THFa7wHJyb9tJ7sLpdZuTi61QjsSVNIKt37vhRaDtkoEz1u6F0IeZ5txdK2qX02hljo5Csz3nAw55NU01pBl40d3uCJ2l1ORf3h1XdEVBqnt1bfxKnYhyOCk1f5sivyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774861658; c=relaxed/simple;
	bh=TNKQcUOxp3IEx4/KXd1OG59UNOtH64WRIf6g/vY5agA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:Cc; b=Ld0TwtTVuazsqGqYwYDEU2ccoWhecf9TJPkpOwJ4WnyMR4aQecbj9uEGNL/U1CPImpnm/BrckFzLAiyKVOHNm/vdr84FrRcouP+RFWnqs3pjLW91pHuYzUENA0p+HOgUi/fEakiaO/khqlliX2ZQ8gglJY3NdKIXVbcmrmP+BEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=WAqNAn+d; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="WAqNAn+d"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=65635f912b=fe@dev.tdt.de>)
	id 1w78aq-008YfB-Ld; Mon, 30 Mar 2026 11:07:32 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1w78aq-00GTFS-43; Mon, 30 Mar 2026 11:07:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1774861651;
	bh=E2ZTfUj86mp0drWTHwRl8zkHJBvXCjXQAwVjq3aAu94=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WAqNAn+dFmHdlv6/Kbl2yXL1/PrYLN5oyTdyjMklTNMpY6iwJJWyHFfpiJwkxH9QN
	 A2tEQBq/KpBhDz1fuWNqxED7OWse2qRVR8l9wFnFHKb+typoioVdpn7ijpMFm1cn5i
	 9R6NUVCQEx6TGS3lHoztVu+TxQazshswGmqc/amoNbm9g0Q4ulxZlm7uixyIMlM3rG
	 DE7dikMKpCPKfbC39kK8qwvLYXEQ4ZCChT3L1FuZifHQ/gkkKo6J3cfHorlsnGsz1k
	 QC3ZB0n8OPbWIcpkMY0NQs08Ps+I6E/yo2pvB9/CYI60pb9v3NZlv0jbc4XCXwHNvS
	 7N5MUB8K4+Dqw==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id B2E6E240046;
	Mon, 30 Mar 2026 11:07:31 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id AA9F7240045;
	Mon, 30 Mar 2026 11:07:31 +0200 (CEST)
Received: from [10.2.3.40] (unknown [10.2.3.40])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 7F72020E49;
	Mon, 30 Mar 2026 11:07:31 +0200 (CEST)
From: Florian Eckert <fe@dev.tdt.de>
Date: Mon, 30 Mar 2026 11:07:17 +0200
Subject: [PATCH v2 7/7] MAINTAINERS: Remove bouncing intel-gw maintainer
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260330-pcie-intel-gw-v2-7-8bd07367a298@dev.tdt.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774861650; l=809;
 i=fe@dev.tdt.de; s=20260205; h=from:subject:message-id;
 bh=TNKQcUOxp3IEx4/KXd1OG59UNOtH64WRIf6g/vY5agA=;
 b=Ai4EcdTuvfoadf2/5hKFXz45gpxWf53pA0vgteDN6C0heygXcZD4+D9vlqn+/XioMS5vdF9sV
 0OSYzHuStAmDC4gjuvVpYRpVHz5KKPyGrnqF8ITjr0+8i5l46wqOSjz
X-Developer-Key: i=fe@dev.tdt.de; a=ed25519;
 pk=q7Pvv3Au2sAVRhBz5UF7ZqUPNxUwXQ78Jdqu8E6Negk=
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1774861652-06AC7842-4ED56781/0/0

The maintainer's email address has been bouncing for months. Mark the PCI
intel-gw driver as orphaned.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 96ea84948d76aff5e07579911d0f370ae13f481b..26f3b2e192fa9ef2e1c89d2310bebaa0a67dff00 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20505,9 +20505,8 @@ F:	Documentation/devicetree/bindings/pci/intel,keembay-pcie*
 F:	drivers/pci/controller/dwc/pcie-keembay.c
 
 PCIE DRIVER FOR INTEL LGM GW SOC
-M:	Chuanhua Lei <lchuanhua@maxlinear.com>
 L:	linux-pci@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
 F:	drivers/pci/controller/dwc/pcie-intel-gw.c
 

-- 
2.47.3

