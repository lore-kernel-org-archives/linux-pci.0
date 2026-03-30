Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A563B27CA;
	Mon, 30 Mar 2026 09:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774861658; cv=none; b=t6jDzjNK/Hm0faHPOvVqajhAG/VgZUYNRnGz3lABIsCL048gYAXeZqvk2edu8VBmzKoJs9RcdSSlwIY9NGxwMBky99Kf64XR+AONnq0nNIgcjqK1KRaE55HP/3iqPzsqLk3SicojgJmRgdy1LS8uVr5XcjvbjOQT+ZQvbE0aUuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774861658; c=relaxed/simple;
	bh=kV1x/p8n2gNW/1XlpGwWYQrKNSFJXbcxq7jcYJjHsbQ=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:Cc; b=nvx67Xh5ACyrhLMqB6Wtax3QmSHXCFu0XLZhFBHFmXVAXSwOburBYhuOsMcCRgNT7JGbrMqQjaqu9BpBrSFi8C0Y2SEJEn6Vq4wxLqtWArbaSFYVgP2R1+nzbwpqw8IyWdZPKdezuqlALd7NFTn60SspdlDYLu7B17oIxdY24hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=kc7dYnMD; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="kc7dYnMD"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=65635f912b=fe@dev.tdt.de>)
	id 1w78ap-008YcU-QI; Mon, 30 Mar 2026 11:07:31 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1w78ap-00Axko-6T; Mon, 30 Mar 2026 11:07:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1774861650;
	bh=7pM4hlhtYfXww5JQG6DsXa/+dbsmLcxeWYuej1fsOP8=;
	h=From:Subject:Date:To:Cc:From;
	b=kc7dYnMD3WSxhWU2qdkzSnqx1XMVbUU/8qgXmOz6HXZ+ZxuJTV19S/gB/CZTEreSE
	 ucYrgEgNjwgvsF5Sm30Wv3DU8mAc+sZ1c5HoZVPAtGbgH1VrIoNqWbmUZnZM6qjlo/
	 rrBKGcsTI6l0YkBQ0/FElz0W8Zgqbk06gUt82ft1nRzNhqjJMDfXkoKwtEXyZpOYn0
	 OrfFJAxL3eJYu/6X6ukOhxkCc7EdOwWR7BHuOVnRbRdLzdclVMVWv0ngRkVQVzQlao
	 +LRlZ+SjJblKUYnIttGmYH7B1I6iqdvaVmqlHVcyN24Wejv42KkQCOMJm+Sp8f0zLw
	 0mXkGknv7kVuw==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id B02F6240041;
	Mon, 30 Mar 2026 11:07:30 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 9D1A5240036;
	Mon, 30 Mar 2026 11:07:30 +0200 (CEST)
Received: from [10.2.3.40] (unknown [10.2.3.40])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 565362040A;
	Mon, 30 Mar 2026 11:07:30 +0200 (CEST)
From: Florian Eckert <fe@dev.tdt.de>
Subject: [PATCH v2 0/7] PCI: intel-gw: Fixes to make the driver working
 again
Date: Mon, 30 Mar 2026 11:07:10 +0200
Message-ID: <20260330-pcie-intel-gw-v2-0-8bd07367a298@dev.tdt.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD49ymkC/3WMQQrDIBAAvxL2XIOrbSQ95R8lhxDXZKGYoGJbg
 n+vzb3HGZg5IFJginBvDgiUOfLmK6hLA/M6+YUE28qgpOqkRiP2mavziZ5ieYmb7KVC1K4nhNr
 sgRy/z99jrLxyTFv4nPuMP/vvlFFIYRyhNqqb7NUNlnKbbGotwVhK+QK+QSlgqwAAAA==
X-Change-ID: 20260317-pcie-intel-gw-50902113f9e1
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774861650; l=1997;
 i=fe@dev.tdt.de; s=20260205; h=from:subject:message-id;
 bh=kV1x/p8n2gNW/1XlpGwWYQrKNSFJXbcxq7jcYJjHsbQ=;
 b=BRDgttkR6UdS5jPjRXbvxOwTYIFgn3p5D7/HCL3fsZWg1av9vvPRQcOT+kZhKlUV/TZbvMUuX
 VL5GF/NONAOAxrUmvEbz7hmDNwRpAQZvm7zeu0KsJO2SJwfw5Zh3RCQ
X-Developer-Key: i=fe@dev.tdt.de; a=ed25519;
 pk=q7Pvv3Au2sAVRhBz5UF7ZqUPNxUwXQ78Jdqu8E6Negk=
X-purgate: clean
X-purgate-ID: 151534::1774861651-052C8842-63FB2240/0/0
X-purgate-type: clean

This patch series fixes the 'intel-gw' driver to work again with the
current pcie framework. The following changes are:

* Move interrupt 'enable' to its own function to improve readability,
  and add additinal register writes just as the Maxlinear kernel does in
  their SDK.
* Enable clock for the PHY before PHY init call.
* Add missing 'start_link' callback that was added to the PCIe dwc
  framework.
* Read ATU base assignment from the DTS rather than specifying it in the
  source of the driver.
* Remove unused preprocessor define.
* Mark driver as orphaned as the maitainer's email no longer works

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
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
      PCI: intel-gw: Remove unused define
      PCI: intel-gw: Move interrupt enable to own function
      PCI: intel-gw: Enable clock before phy init
      PCI: intel-gw: Add start_link callback function
      PCI: intel-gw: Remove atu base assignment
      dt-bindings: PCI: intel,lgm-pcie: Make atu resource mandatory
      MAINTAINERS: Remove bouncing intel-gw maintainer

 .../devicetree/bindings/pci/intel-gw-pcie.yaml     |  5 ++-
 MAINTAINERS                                        |  3 +-
 drivers/pci/controller/dwc/pcie-intel-gw.c         | 49 ++++++++++++----------
 3 files changed, 31 insertions(+), 26 deletions(-)
---
base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
change-id: 20260317-pcie-intel-gw-50902113f9e1

Best regards,
-- 
Florian Eckert <fe@dev.tdt.de>

