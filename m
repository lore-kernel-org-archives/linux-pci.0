Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AB41F2B8D;
	Wed, 15 Apr 2026 08:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241047; cv=none; b=Iz6FcTUSRDxm8GK/YAbKb8qG05trPsaYBMJNRDemOo9CPTMzwxtFAZwJaKw0teGJaqKWsfKVo6czTyyRtUR9eUr8WuqfHYhgxmF6yLkdiL5KmVVVsm1rTZg0/NX6u1o0oBIzLBpkDyptgWxWmD+M4OJay4TNOoCtSkPFYTYLYcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241047; c=relaxed/simple;
	bh=SDHu4CF6hiHHjw7wIYF2M+BZ1AnJr501zKLvFcrIIPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:Cc; b=fWZ2LygHYZCZP/Z4vPIoUOb9QlpbFVEZfSv2EXhghbDnVNJbKGLVIymmIM1MiQs+RWHW19WGcJSa7xkYdZ/ybHOhpL4XhAQfQb4TU2pxNY9uNBtaXNggSzW0geg2J+I4yVB5Avu4uA8ntuNWwJUz/k3vcwzXTIKClh67UXQWXoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=UuLOndoL; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="UuLOndoL"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=657992536b=fe@dev.tdt.de>)
	id 1wCvC5-003sbl-Pg; Wed, 15 Apr 2026 10:01:53 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1wCvC5-000FI6-99; Wed, 15 Apr 2026 10:01:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1776240112;
	bh=JqZmvXp+hLfJuRdo0qRIk/QxAIHQamNDzRshObedo7Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UuLOndoL2Wun9SH8+2lA3BbkEyAX3zmBvKD4cZkHhCI2pKWS6up1mF8kGllk7RrOV
	 3RNJK/dNhErzDjkdHe6I9bbEStj73AudXbyiSAZnDTjgBDLgKdoO+JL6L5htNtmUVM
	 +ECRI/MWLxxC06endHLHcIwqfSOTVrEkJbsj4xE4T+bVf13w/uC4VKEheYzhs6HDGj
	 yvNG1I25vEuwaoDFXo+ghTsxLNKRBKdt+sj+eY9c7ZVqIH70bsKdc6IkQIQVcSIN+b
	 Uasv4SonRXflWoWHD+iubcxoF6DKotLOg7q5Cbx2FSWnVQdU10mPIg01iRC9UT5Il2
	 faIFd37B91Avg==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id CB24B240047;
	Wed, 15 Apr 2026 10:01:52 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id AD752240045;
	Wed, 15 Apr 2026 10:01:52 +0200 (CEST)
Received: from [10.2.3.40] (unknown [10.2.3.40])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 8FEB724028;
	Wed, 15 Apr 2026 10:01:52 +0200 (CEST)
From: Florian Eckert <fe@dev.tdt.de>
Date: Wed, 15 Apr 2026 10:01:47 +0200 (CEST)
Subject: [PATCH v4 1/7] MAINTAINERS: Remove bouncing intel-gw maintainer
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260415-pcie-intel-gw-v4-1-ad45d2418c8e@dev.tdt.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776240111; l=809;
 i=fe@dev.tdt.de; s=20260205; h=from:subject:message-id;
 bh=SDHu4CF6hiHHjw7wIYF2M+BZ1AnJr501zKLvFcrIIPQ=;
 b=ZnlMONcsBYKLjUgojYYduutUgV39nY/QoNZKZMNL9q9YIHcqMXbjoIdjST8qNrjiA8nnTnpTa
 n+jiTBPUVyxDfyP+Nmthasw0/1VnYGTeLXUWxmapzqPE8EU/18DdOZT
X-Developer-Key: i=fe@dev.tdt.de; a=ed25519;
 pk=q7Pvv3Au2sAVRhBz5UF7ZqUPNxUwXQ78Jdqu8E6Negk=
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1776240113-2EC1419A-5196C29B/0/0

The maintainer's email address has been bouncing for months. Mark the PCI
intel-gw driver as orphaned.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d1cc0e12fe1f004da89b1aa339116908f642e894..725f333f265bef416b5144c56649cb6eae736e40 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20518,9 +20518,8 @@ F:	Documentation/devicetree/bindings/pci/intel,keembay-pcie*
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

