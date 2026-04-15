Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35953CE4B3;
	Wed, 15 Apr 2026 08:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241057; cv=none; b=IzojBuohAjonoW7f2rBtBWjPU4ILEluSQ0YXVk1Oo5FAw1rF1ClfAQW9yh9H8zHmeWfPv04YWBRfRB/tPToHdoOH35oSJirLiuhdYEsaOnDp9UmDKyU7kjjWiEUmiwQH8DgdHUEXc9BpxGgBKLQyWOtcNXtUcHcI2q3uq7fbjLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241057; c=relaxed/simple;
	bh=OCOPR7qYQ86i9LLtRG/G6UnUj18IRRl3gvRDhTM5HQ8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:Cc; b=HtSNYDdujR1TCoc3gDVpmFY3EP4ZfoP0w6ZE78b3bbxtUo8OnU/yfgSZdrDEqulX1AF6xy5bKQBaL0DxxdhJiP1aTTOgZK9j8xyaGlxRQ3yiJA9MWwd6SRtfKM7arsrv1Fw+RMFUNBafa+ExkWk7HhOGVD0myFdaYIduQJVneec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=FwI/FfcL; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="FwI/FfcL"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=657992536b=fe@dev.tdt.de>)
	id 1wCvC5-003sbh-Ol; Wed, 15 Apr 2026 10:01:53 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1wCvC5-002VkX-6o; Wed, 15 Apr 2026 10:01:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1776240112;
	bh=mc8zG+qkZb9BnIMx17ueKa8W0mDeIUy9mCPiLflmD1A=;
	h=From:Subject:Date:To:Cc:From;
	b=FwI/FfcL+lqca/3hGb8hu+YYBPen46CLfcyRKaWRtQm+j8NobQP9EHOOShu3ybtak
	 6Kk8WklkfSLcJVGx9/6eSWUYB+oXTdOlg+/YQPcWuqPJcCfnSOjX5RVkUaCi6CG4rU
	 cZVSeUqeoUJ3NDM597mAAW+FHINLzUiQE3QRckitztQVKuTvsCU6QoxLzG924toFE4
	 OoEdPzi/fOjk6x0E6tqgqCOQF5Fqv4G8PoTXNqasnKOrTXQfNj2x+lKZgd5fTamldr
	 VFRU8rxcTPP43ATi4mvQDQlUY4OWA70YSQSScuH9TbD/CuE01wbzsy0NZQR2yN4vwq
	 uIicQhYKhpQCQ==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id AB534240042;
	Wed, 15 Apr 2026 10:01:52 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 974C6240040;
	Wed, 15 Apr 2026 10:01:52 +0200 (CEST)
Received: from [10.2.3.40] (unknown [10.2.3.40])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id F293124001;
	Wed, 15 Apr 2026 10:01:51 +0200 (CEST)
From: Florian Eckert <fe@dev.tdt.de>
Subject: [PATCH v4 0/7] PCI: intel-gw: Fixes to make the driver working
 again
Date: Wed, 15 Apr 2026 10:01:46 +0200 (CEST)
Message-ID: <20260415-pcie-intel-gw-v4-0-ad45d2418c8e@dev.tdt.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOpF32kC/3XM0Q6CIBiG4VtpHIf7AQXtqPtoHaj8KFtTB4xqz
 nsPPalsHX7f9rwz8egsenI6zMRhtN6OQxr58UDavh46pFanTThwCYIpOrU2fUPAG+3utIAKOGP
 CVMhIMpNDYx9b73JNu7c+jO655SNb33+lyChQZZAJxWWtc3PWGLOgQ6aRrKnIP7iAPeeJl40GJ
 aSqeVX+cPHmObA9F4lL0QCUbdGohn/xZVleheIr9CkBAAA=
X-Change-ID: 20260317-pcie-intel-gw-50902113f9e1
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776240111; l=2895;
 i=fe@dev.tdt.de; s=20260205; h=from:subject:message-id;
 bh=OCOPR7qYQ86i9LLtRG/G6UnUj18IRRl3gvRDhTM5HQ8=;
 b=3sl2U8fR2DoW0OCmRmD9z/jZMuL/tF//nC02A8Et7Uhw5TbUNquUfUuScAbP4un+8LZpnKbUv
 F/XaveZPSKKAOvOnVdJUdmLgH95h3QeYpameqF4V4JWXXJSFXa9ez5M
X-Developer-Key: i=fe@dev.tdt.de; a=ed25519;
 pk=q7Pvv3Au2sAVRhBz5UF7ZqUPNxUwXQ78Jdqu8E6Negk=
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1776240113-5615A19A-7DF273C6/0/0

This series fixes and improve the 'intel-gw' driver to work again with
the current dwc pcie framework. The following changes are:

* Move interrupt 'enable' to its own function to improve readability,
  and add additional register writes just as the Maxlinear kernel does in
  their SDK.
* Enable clock for the PHY before PHY init call.
* Add missing 'start_link' callback. That was added to the PCIe dwc
  framework.
* Move ATU base address assignment to the probe function and also add the
  the possibility to read it from the devicetree by dwc core.
* Update devicetree documentation for intel-gw-pcie.yaml
* Remove unused preprocessor define.
* Mark driver as orphaned as the maitainer's email no longer works

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
Changes in v4:
- Add 'atu' to the end of the resource definition to ensure backwords
  compatibility.
- Updated the commit description to explain why the MaxLinear SDK is used
  as a reference.
- Remove 'Rahul Tanwar <rtanwar@maxlinear.com>' out of the loop, as the email
  address is no longer valid and is being rejected.
- Link to v3: https://lore.kernel.org/r/20260401-pcie-intel-gw-v3-0-63b008c5b7b2@dev.tdt.de

Changes in v3:
- Update commit messages.
- Correct the sample code for dt bindings by adding the missing quotation
  marks. Add 'minItems: 3' to avoid ABI issues.
- Move driver atu base assignment to probe function and keep backward
  compatibility.
- Link to v2: https://lore.kernel.org/r/20260330-pcie-intel-gw-v2-0-8bd07367a298@dev.tdt.de

Changes in v2:
- Added additional information to the commit descriptions
- Add additional patch to mark driver as orphaned as the maintainer's
  email no longer works.
- Fix wrong error path for enable clock before phy init.
- Add new patch to update the devicetree documentation for the 'atu'
  resource
- Add additional recipients responsible for documenting the dervicetree
  bindings.
- Link to v1: https://lore.kernel.org/r/20260317-pcie-intel-gw-v1-0-7fe13726ad4f@dev.tdt.de

---
Florian Eckert (7):
      MAINTAINERS: Remove bouncing intel-gw maintainer
      PCI: intel-gw: Remove unused define
      PCI: intel-gw: Move interrupt enable to own function
      PCI: intel-gw: Enable clock before phy init
      PCI: intel-gw: Add start_link callback function
      PCI: intel-gw: Move driver atu base assignment to probe function
      dt-bindings: PCI: intel,lgm-pcie: Add atu resource

 .../devicetree/bindings/pci/intel-gw-pcie.yaml     |  8 ++-
 MAINTAINERS                                        |  3 +-
 drivers/pci/controller/dwc/pcie-intel-gw.c         | 73 +++++++++++++++-------
 3 files changed, 57 insertions(+), 27 deletions(-)
---
base-commit: 028ef9c96e96197026887c0f092424679298aae8
change-id: 20260317-pcie-intel-gw-50902113f9e1

Best regards,
-- 
Florian Eckert <fe@dev.tdt.de>

