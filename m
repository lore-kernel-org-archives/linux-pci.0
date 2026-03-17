Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8323A6F1F
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 10:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773743442; cv=none; b=EUJ/5ngHCbZzKIYtm3eFGvk9vLzJd7VMOmgZYzFln74eUGYCWKNSg8McOJ/WCy64A1/cRp/BvaCcsSjm1kfTyl8zQ89HeRGaP9jQEyI5HsgzF7PdK9Dg451lJznF1wFLDH8pQh+Ve2W9Q6kK/FJOM5GtyPJ02VGRAn6ZdLAId2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773743442; c=relaxed/simple;
	bh=gMsrh+FO+Tt5RulC7LZYkBEK9IJgRRS3Rt+UL63UVS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:Cc; b=KYQyXo1qmBk8q3g4+DfjCQqyApdnPvGpgZoXJUFQIGEx+bp1gysweBVhfszC2EutpVkxnT0biLAzzMCPwqmCOhrRI6HXqiGIcqoCh+MC2q1qdjUPJMshU/BXwQAoKLXt/2EUfTfxNecckYck+OLazQx4AMLSGbDaOD1/tKDlNwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=WmkIUISM; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="WmkIUISM"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=5550c006e3=fe@dev.tdt.de>)
	id 1w2RQC-00C6wy-3V
	for linux-pci@vger.kernel.org; Tue, 17 Mar 2026 11:13:08 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1w2RQB-00FDNp-Nf
	for linux-pci@vger.kernel.org; Tue, 17 Mar 2026 11:13:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1773742387;
	bh=krlCo0bP9NXhSvCloj8W+cXNqpMUNFunGeueOA+AqwQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WmkIUISMR79UTrZaOGa/3v9lUs5ImAimz2E6XcA+utut86r4IHl1v/EGAzVMvMSZK
	 OYMFNhu9tRthqZXo7Y62WGTWftsghe8h4BXEf5jVBctFMFQbilB4waRFA6OixQOeCL
	 zQbu9eUpoMooEzJuuZgyJEQcCgzLeSgHxBcjV9+WVyrERGeDQRe3IOxBbgb7SRYBEd
	 oUXRE/NPodXq6oUjGRO+CSkpFcPiVPLVLIy3DPDpuhvxYUGP5p2uRx5U2+jIooTYty
	 oK5DLXTBbsuJyLfvQDMOAzfnGRJijkEaHgDIGdt2jXfuZoESZ6w6EyqWvmnK6lGBcO
	 oQfKr08wmyPNg==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 470CD24004F
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 11:13:07 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 42488240054;
	Tue, 17 Mar 2026 11:13:07 +0100 (CET)
Received: from [10.2.3.40] (unknown [10.2.3.40])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 2CAE3237A2;
	Tue, 17 Mar 2026 11:13:07 +0100 (CET)
From: Florian Eckert <fe@dev.tdt.de>
Date: Tue, 17 Mar 2026 11:12:53 +0100
Subject: [PATCH 5/5] PCI: intel-gw: Remove unused define
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260317-pcie-intel-gw-v1-5-7fe13726ad4f@dev.tdt.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773742386; l=814;
 i=fe@dev.tdt.de; s=20260205; h=from:subject:message-id;
 bh=gMsrh+FO+Tt5RulC7LZYkBEK9IJgRRS3Rt+UL63UVS0=;
 b=VlGqPx3Ojh4FA5U3Db+ZsTtTPeeMKFGbUkcQItDlRhWE0ThjwvsmsW+mufckmIJUI/lvtYhYC
 4MSoqpNT5m6Adylu+osn6p6HD7gDjdygV4alS5eZavHsJFYOasdX78i
X-Developer-Key: i=fe@dev.tdt.de; a=ed25519;
 pk=q7Pvv3Au2sAVRhBz5UF7ZqUPNxUwXQ78Jdqu8E6Negk=
X-purgate-ID: 151534::1773742388-E7518769-96291528/0/0
X-purgate: clean
X-purgate-type: clean

The C preprocessor define 'PCIE_APP_INTX_OFST' is not used in the sources
and can therefore be deleted.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 drivers/pci/controller/dwc/pcie-intel-gw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index cec972d5aa9107d4708338bd7349415a31f0e688..1a62d4aed9b495d6cfa31f0e1c92f2b4ac6b09f4 100644
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

