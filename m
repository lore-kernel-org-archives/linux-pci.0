Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595B2347520;
	Fri, 17 Apr 2026 08:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776414981; cv=none; b=u+8B1oApRyK5lTq1tGEny3L/Mld5eY+93n1PsqCpY+tgrqdDw/8+d3GSYsFmXK+BXoOyLABiqbGotLmDbv8SErF6xV+CIyiWuX32yg2lk+RZb7DsKD77Y8YswjUTBfEMHUyczmIK9NYLNQ0/1kJIKeADHban7hwsxZkFvxzq+Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776414981; c=relaxed/simple;
	bh=MQ0l0wvtSEfoCATLx4nlx33NhwoOEDLG+v/8QS6v2ow=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:Cc; b=bGruYNqdXJ8U6CuO480kYpFebQ1YhMFfYZbwv/7gRvWnpcTM8Zi4CE1lbLrG+PjJprfg65sAEVvb5B+80IqIdiKSrnoRxwknxQEK7WMnIVCuQB4QePI4Y3h8uAno70ZPJ6uRtJ9v6qQr0e4F5lynlwu1fbq4vtMKMT8siFRVVcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=FmBXZDu4; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="FmBXZDu4"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=75813159fe=fe@dev.tdt.de>)
	id 1wDegM-00Bg5u-QL; Fri, 17 Apr 2026 10:36:10 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1wDegM-00A0Nq-8J; Fri, 17 Apr 2026 10:36:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1776414969;
	bh=/nX3mnXGkgvCvk936+01D3PVH8vtU5ubaHOeYIoG1Gs=;
	h=From:Subject:Date:To:Cc:From;
	b=FmBXZDu42OgQGtr0+f/ayxZa8FahaBzwCYWP+OO/GE2BE+kwFUsLN6Lc3k/gcyY8q
	 iQ8XnipKWb7r43LsR//zHol+fhfE3QDWJkwymRjcs0RDWgg7Vfy3yuTElzAC9lO6xf
	 jmTXPV2XoBp35m0LTsjprDANtW3fFhr7aO6xwgsZ3I1xewMDPsUW6S5sgdccSHwd5m
	 rVs0ucre7Ra1VIonUdmwRbtVuEaKp7TKJVXl7/h9/OfXy0UrSvuS+ImPvoTDHi4hhe
	 /HtxHmUtYefEJSR99weOaCLKhXlsmMPpFRH1VK8oEvXrZz4AsO7RYFsevsPMxotAxI
	 fONUoRdoPE5zg==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id BDD31240042;
	Fri, 17 Apr 2026 10:36:09 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id AAFF7240040;
	Fri, 17 Apr 2026 10:36:09 +0200 (CEST)
Received: from [10.2.3.40] (unknown [10.2.3.40])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 1DE4D2425D;
	Fri, 17 Apr 2026 10:36:09 +0200 (CEST)
From: Florian Eckert <fe@dev.tdt.de>
Subject: [PATCH v5 0/7] PCI: intel-gw: Fixes to make the driver working
 again
Date: Fri, 17 Apr 2026 10:35:44 +0200 (CEST)
Message-ID: <20260417-pcie-intel-gw-v5-0-0a2b933fe04f@dev.tdt.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAODw4WkC/3XOwQrCMAzG8VeRnq0kabt2nnwP8bCtmRZkyjaqI
 nt3oxd14vEL/P7krgbuEw9qvbirnnMa0qmT4ZYL1Ryqbs86RdmKgAow6PW5SXLrRj7q/UU7KIE
 QTVsyKjHnntt0ffW2O9mHNIyn/vbKZ3xe/5UyatC+ZTSeiiradhM5r8Y4riKrZyrTBzcw5yQ81
 BG8KXxFZfjh5s0t4Jwb4YWpAULjal/TD7cfHN2cW+HytItkMTSBv/g0TQ9TJnlyaAEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776414969; l=3158;
 i=fe@dev.tdt.de; s=20260205; h=from:subject:message-id;
 bh=MQ0l0wvtSEfoCATLx4nlx33NhwoOEDLG+v/8QS6v2ow=;
 b=Vc1mwi+2r36IkQDXtgYt/QmGC89q15f4e9YLlHviJTalR1poXAHSlAbbKVNUibwx1KlgorhPK
 /m/+QTcFv0dCtIA79Rx084v6qb+q2lDwyrOnfzxN1f4Q+R6M6rTVJZ3
X-Developer-Key: i=fe@dev.tdt.de; a=ed25519;
 pk=q7Pvv3Au2sAVRhBz5UF7ZqUPNxUwXQ78Jdqu8E6Negk=
X-purgate-type: clean
X-purgate-ID: 151534::1776414970-1AEC7049-B87333E6/0/0
X-purgate: clean

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
Changes in v5:
- Also add the DTS 'minItems' option for 'reg-names'.
- Add missing quotation marks to the DTS example change to make the DTS
  bot hopefully happy.
- Link to v4: https://lore.kernel.org/r/20260415-pcie-intel-gw-v4-0-ad45d2418c8e@dev.tdt.de

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

 .../devicetree/bindings/pci/intel-gw-pcie.yaml     |  9 ++-
 MAINTAINERS                                        |  3 +-
 drivers/pci/controller/dwc/pcie-intel-gw.c         | 73 +++++++++++++++-------
 3 files changed, 58 insertions(+), 27 deletions(-)
---
base-commit: 028ef9c96e96197026887c0f092424679298aae8
change-id: 20260317-pcie-intel-gw-50902113f9e1

Best regards,
-- 
Florian Eckert <fe@dev.tdt.de>

