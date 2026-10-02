Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0EE4772A6;
	Fri,  2 Oct 2026 09:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932242; cv=none; b=K53KFdEfs9vQJnRRFWP0YWoZy9Lh+Ny9h8UC48Pc7ZFk5kTpqm6Iny9K4HjAwI4AQcJ6GPMvIFKIyYZu0GPN32gILE5iA9d/uCT4VJnIFJ7GA2t6ZwCLCzQnfZxz4gyGx8a/opHpIbJhBL8F7hMrh3/rP5IYCouN4uIvcSvFPnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932242; c=relaxed/simple;
	bh=IOoyh7Sz3IKqWFafM2t3tJv+ZlbBaMgvgPEDNfD1MsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8f6PzyYAx9Cd96jgXaMgurnkueiqImK+Rl5/N4wNIePSL0Gj5gauKxHCQXKBuw5az1V8DuhpOrjdGEfHRfteBiFHUvuvl5AGbJovkYxvG9MndJoE4IX/qQlfkUhB2/Bo6zMi9+FG8gc6KEtee5Zhb0PQtURST6j0EAi/IG9VQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Tbo9pPKW; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Tbo9pPKW"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hx30Y25MYzKmjD;
	Fri, 02 Oct 2026 11:10:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790932237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rhV7HJufFbJ/wpQzxnnkX6Ran2RY+CfLFMSbxqUujIs=;
	b=Tbo9pPKWZqoOk5Am3XNXmNbtFJXr+FZb3Do06CvVZmGZVO3br9y9jtdOlWaIGYfHtuVkSI
	vx4QGfWnYMI+0dgjfm+GiJz0/Ra4mgsUca53oC/cu0qMFo+q8eTkQ5Ft0VOzfBF/48p5MH
	usf5ofTboD6gD9zritRRODvEC2GVHSdMSWGDhcSnvQJT95J+XNg7YsdlCJ+11B4em0yHF2
	gmvNTSYCMadxws3njoJf1RVHSynvR0lC1Ov3Ozx1mWrffAkqhs1g+OLv0CPAHAGv2FOIB3
	D+KhnPFDTt38bsF9k12DZxiPd5oSo/uMv+mh4e/vfUL11TB9VNcwRAoRhTAK0Q==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v2 2/2] PCI: Set RCB only when the Root Port has it set
Date: Fri,  2 Oct 2026 11:10:29 +0200
Message-ID: <20261002091029.2225203-3-stefan.roese@mailbox.org>
In-Reply-To: <20261002091029.2225203-1-stefan.roese@mailbox.org>
References: <20261002091029.2225203-1-stefan.roese@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 1dq34n5m9nwunyfw3itmw4gjptnfgcjp
X-MBO-RS-ID: 9a33db97d794d9ced78

pci_configure_rcb() read-modify-writes Link Control of every endpoint
at enumeration, also when RCB is clear in the Root Port and there is
nothing to set. Not writing a register that has nothing to change is
justified on its own, but the write-back of the other Link Control bits
also has side effects on some devices: the Renesas uPD720201 xHCI
(1912:0014) comes out of reset with ASPM L0s and L1 enabled and stops
clearing them itself once Link Control has been written. On a link
whose Root Port supports no ASPM, the previous patch clears them, but
it does not run with pcie_aspm=off or CONFIG_PCIEASPM=n. There the
first access to the xHCI BAR runs into completion timeouts that hang
the system.

RCB may only be set in an endpoint if it is set in the Root Port, so
there is no need to ever clear it here; an endpoint with RCB set
below a Root Port without it is a firmware configuration error. Only
set RCB, and only when the Root Port has it set.

Fixes: 1a6845aaa6de ("PCI: Initialize RCB from pci_configure_device()")
Cc: stable@vger.kernel.org
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Stefan Roese <stefan.roese@mailbox.org>
---
Changes in v2:
- Replace "PCI: Write RCB only when it changes" (v1 1/2) with the
  set-only variant suggested by Bjorn: never clear RCB, set it only
  when the Root Port has it set
- Now patch 2/2, still with Fixes: and stable, because with
  pcie_aspm=off or CONFIG_PCIEASPM=n patch 1 never runs and only
  avoiding the Link Control write prevents the hang
---
 drivers/pci/probe.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 721daf5c5184..0d05536216fb 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2448,10 +2448,9 @@ static void pci_configure_rcb(struct pci_dev *dev)
 		return;
 
 	pcie_capability_read_word(rp, PCI_EXP_LNKCTL, &rp_lnkctl);
-	pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_RCB,
-					   (rp_lnkctl & PCI_EXP_LNKCTL_RCB) ?
-					   PCI_EXP_LNKCTL_RCB : 0);
+	if (rp_lnkctl & PCI_EXP_LNKCTL_RCB)
+		pcie_capability_set_word(dev, PCI_EXP_LNKCTL,
+					 PCI_EXP_LNKCTL_RCB);
 }
 
 static void pci_configure_device(struct pci_dev *dev)
-- 
2.56.0

