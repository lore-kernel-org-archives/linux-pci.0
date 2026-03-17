Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA43390C83
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 10:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773743417; cv=none; b=KQvg91eRM0TaKIPlCss2CP1VWo1iK/nAG7Sj+hVlBeGfcGHLmXgurLtFDzG6wKh4Ef48GxjHK5WkIUV5SyqZdVG8bsJuR+rv4OKOyL5vnTrHCCTCbBA/UKWfPCUXhMZVmqPHTSe09ZsySLHJDjwWJzxE3atqMk7szu+MItReYa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773743417; c=relaxed/simple;
	bh=L7/6sMYHc0GEz2JA0DgwY3YGvI5J/optX5e71uVbJEk=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:Cc; b=r3Co2hDyUcmJZtPJBDv0r4CGFoaxPRIuYRVWlJMMCpn6rHGZNvsceZ4W/U8pQcoVYeICYOLJd5pV+FJhq5hbB6wvjAPzMtn1kz4al0AN7dWubY8mO7+3XsxJme8kgkPZ4qcPzkpq99hAUgtgd58+8Uq8HGH7OEjZQ39lTvLKZbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=ZNJuhlOS; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="ZNJuhlOS"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=5550c006e3=fe@dev.tdt.de>)
	id 1w2RQB-00C6wO-Nc
	for linux-pci@vger.kernel.org; Tue, 17 Mar 2026 11:13:07 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1w2RQB-00C6wA-8o
	for linux-pci@vger.kernel.org; Tue, 17 Mar 2026 11:13:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1773742386;
	bh=Y+D5AefA8SrDQj8UW5viR7emCUI8CO3PFaNJb1cmf/o=;
	h=From:Subject:Date:To:Cc:From;
	b=ZNJuhlOSAdEJ6SUrYPJJDA0fb0cUwqS3Fr8d7X4uDxmEe8OzxpPYTvqrMjKcJFmH5
	 27LQyrTwofvjq5xe/BkzaeNbYycj+09vBcNA7TEKCdmWUW7DOOIqQp2i7hPgR+R0E4
	 GmAX9i6jgSYFlB6fkCheRpptqPehzMbahA+efmCbeX2LKjEea4/zD2qQ3bLl5DEE++
	 txUCTgk/wFyMVfrmGZv6WkP38GXq7SxRlDGDST0FrjpbsbUhhAFnbQUH6ti7jhVP4e
	 3M+S4DBpUsQ0fm9XmtB7NODQ08UjZwtjOjepP2xNOOos6YqeKKhChwX4wp63OtMr8t
	 3+5A2XW9vhLlQ==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id CB7AC240041
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 11:13:06 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id BD843240036;
	Tue, 17 Mar 2026 11:13:06 +0100 (CET)
Received: from [10.2.3.40] (unknown [10.2.3.40])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 9E61323715;
	Tue, 17 Mar 2026 11:13:06 +0100 (CET)
From: Florian Eckert <fe@dev.tdt.de>
Subject: [PATCH 0/5] PCI: intel-gw: Fixes to make the driver working again
Date: Tue, 17 Mar 2026 11:12:48 +0100
Message-ID: <20260317-pcie-intel-gw-v1-0-7fe13726ad4f@dev.tdt.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACApuWkC/x2MQQqAIBAAvyJ7TnCVivpKdAhbbSEsNCoQ/550n
 IGZDIkiU4JRZIh0c+IjVMBGgN2W4EnyWhm00p0y2MvTcnXhol36R7ZqUBrRuIEQanNGcvz+v2k
 u5QPOXPjYXwAAAA==
X-Change-ID: 20260317-pcie-intel-gw-50902113f9e1
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773742386; l=1080;
 i=fe@dev.tdt.de; s=20260205; h=from:subject:message-id;
 bh=L7/6sMYHc0GEz2JA0DgwY3YGvI5J/optX5e71uVbJEk=;
 b=eG/1SIpiI4dApD9Fu6SXyv6SXJ6ye88UeRvBtFZDq4nzBPyDrrg8a0+c3lwGR7fjWO8knikux
 rH6l10nXsvsBCdArew9up3y7BzykWNB4W3Mh6X9xbyP4jrHK5+QbRgS
X-Developer-Key: i=fe@dev.tdt.de; a=ed25519;
 pk=q7Pvv3Au2sAVRhBz5UF7ZqUPNxUwXQ78Jdqu8E6Negk=
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1773742387-07518769-26ACE0C4/0/0

This patch series fixes the 'intel-gw' driver to work again with the
current pcie framework. The following changes are:

* Move interrupt 'enable' to its own function to improve readability.
* Enable clock for the PHY before PHY init call.
* Add missing 'start_link' callback that was added to the PCIe dwc
  framework.
* Read ATU base assignment from the DTS rather than specifying it in the
  source.
* Remove unused preprocessor define.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
Florian Eckert (5):
      PCI: intel-gw: Move interrupt enable to own function
      PCI: intel-gw: Enable clock before phy init
      PCI: intel-gw: Add start_link callback function
      PCI: intel-gw: Remove atu base assignment
      PCI: intel-gw: Remove unused define

 drivers/pci/controller/dwc/pcie-intel-gw.c | 47 +++++++++++++++---------------
 1 file changed, 24 insertions(+), 23 deletions(-)
---
base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
change-id: 20260317-pcie-intel-gw-50902113f9e1

Best regards,
-- 
Florian Eckert <fe@dev.tdt.de>

