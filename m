Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0636F31282F;
	Fri, 11 Sep 2026 12:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789129809; cv=none; b=tSJuBgo0yPpTE01QwfFwEHDL7YRHqWUF9z4NKwlkAPs4bjgy4FRol0E6RC0Z+FyqLKMoAyH7yORP4u5Y6C3Uw1PAZG9y0xPTCNPRE5cewmDjmo5DqqLjNZdWmg1d6AJ5YXiUPiBJXliX3/UKi8i+98yOyg3M6eSCJ6/s9HYx4vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789129809; c=relaxed/simple;
	bh=MoCJ6xcjiR21RrAJBnK4huR+J1dRKWSeef/TOmR4fYQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HpE24k/IXuiyLcmLxtUcOHgThAdH0IJbuKMgWLjD4JYR6CpI7OUgGriY4LNGz7Uisp+oG8QTiZ4H7MRuTTSrsH6OIfqXlYQ65aeqZwKYMvcrCSpai4vNhA5uNfiqV821bbnmAoW7gzTxgQx4kzQwUs3meFdI1JdYQRYPbDapya8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=goybNU4J; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="goybNU4J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789129805; x=1820665805;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=76//lFNoD73PWgho8H4Yagi2iOr5lIAS/w2o2f0iL7E=;
  b=goybNU4JXvSARFdDDoeSkR31fh8TqnFEZYMN9WW1upRdaX5lIhWnYBi9
   PSH0812p8jfEogtjAhNaY9XgDfjtWbghBvNL2LM8ULzGvVxaTWSsd4Ogi
   MHzsJOXeWu7rbqsqBdBbUi6tFskMbwboLhWarQu7/KEmTOyybTAH2FKOz
   7rTY6bVm7RuXEpzVS9gSLghiaIfpDfLRdPZR6YK5U7MlYRBaXnsnqBs4h
   qwaaiXFwZg8D3t+P60vTU3Qcyc/nzIUBDWY0d4fdMGd350jiA2BzqNHjx
   1MRUPNK2JUew2CceGu1P0WwLrl+n/pnDTOAgRPCd7a6lInVpaaJr6jlJW
   Q==;
X-CSE-ConnectionGUID: ZRF+sWN8SxyaluaZFeHopg==
X-CSE-MsgGUID: pjbUDy3lSES4SHUcYAZPSA==
X-IronPort-AV: E=Sophos;i="6.27,97,1787011200"; 
   d="scan'208";a="28293784"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 12:30:03 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:15106]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.198:2525] with esmtp (Farcaster)
 id 0ebb7c56-e5f4-4c1a-a205-8c4760150ebb; Fri, 11 Sep 2026 12:30:03 +0000 (UTC)
X-Farcaster-Flow-ID: 0ebb7c56-e5f4-4c1a-a205-8c4760150ebb
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Fri, 11 Sep 2026 12:30:02 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Fri, 11 Sep 2026
 12:30:00 +0000
From: Pavol Sakac <sakacpav@amazon.de>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Matlack
	<dmatlack@google.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>, Kees Cook <kees@kernel.org>, Madhavan Srinivasan
	<maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
	<npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, Niklas Schnelle <schnelle@linux.ibm.com>,
	Benjamin Block <bblock@linux.ibm.com>, Lukas Wunner <lukas@wunner.de>, "Ionut
 Nechita" <ionut.nechita@windriver.com>, <nh-open-source@amazon.com>
Subject: [RFC PATCH 3/8] PCI/PM: Convert pci_bridge_d3_update() recursion to iteration
Date: Fri, 11 Sep 2026 14:29:58 +0200
Message-ID: <20260911122958.88717-1-sakacpav@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911-vfopt-s1-v1-0-693271dc0226@amazon.de>
References: <20260911-vfopt-s1-v1-0-693271dc0226@amazon.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA003.ant.amazon.com (10.13.139.86) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

pci_bridge_d3_update() propagates a bridge_d3 change to upstream bridges
by tail recursion: when a bridge's bridge_d3 value changes, the function
calls itself with that bridge as the new device.

Convert the tail recursion into an iterative loop. Each level recomputes
"remove" and d3cold_ok exactly as the recursive call did for its own
device, and the early returns become loop exits. No functional change
intended.

An upcoming change serializes this update with a mutex; the iterative
form lets that mutex be taken once per external call instead of once per
bridge level.

Assisted-by: LLM
Signed-off-by: Pavol Sakac <sakacpav@amazon.de>
---
 drivers/pci/pci.c | 67 +++++++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2879a6be5f8..c62a315c0b4c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3104,46 +3104,49 @@ static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
  */
 void pci_bridge_d3_update(struct pci_dev *dev)
 {
-	bool remove = !device_is_registered(&dev->dev);
 	struct pci_dev *bridge;
-	bool d3cold_ok = true;
 
-	bridge = pci_upstream_bridge(dev);
-	if (!bridge || !pci_bridge_d3_possible(bridge))
-		return;
+	while ((bridge = pci_upstream_bridge(dev)) &&
+	       pci_bridge_d3_possible(bridge)) {
+		bool remove = !device_is_registered(&dev->dev);
+		bool d3cold_ok = true;
 
-	/*
-	 * If D3 is currently allowed for the bridge, removing one of its
-	 * children won't change that.
-	 */
-	if (remove && bridge->bridge_d3)
-		return;
+		/*
+		 * If D3 is currently allowed for the bridge, removing one of
+		 * its children won't change that.
+		 */
+		if (remove && bridge->bridge_d3)
+			break;
 
-	/*
-	 * If D3 is currently allowed for the bridge and a child is added or
-	 * changed, disallowance of D3 can only be caused by that child, so
-	 * we only need to check that single device, not any of its siblings.
-	 *
-	 * If D3 is currently not allowed for the bridge, checking the device
-	 * first may allow us to skip checking its siblings.
-	 */
-	if (!remove)
-		pci_dev_check_d3cold(dev, &d3cold_ok);
+		/*
+		 * If D3 is currently allowed for the bridge and a child is
+		 * added or changed, disallowance of D3 can only be caused by
+		 * that child, so we only need to check that single device,
+		 * not any of its siblings.
+		 *
+		 * If D3 is currently not allowed for the bridge, checking the
+		 * device first may allow us to skip checking its siblings.
+		 */
+		if (!remove)
+			pci_dev_check_d3cold(dev, &d3cold_ok);
 
-	/*
-	 * If D3 is currently not allowed for the bridge, this may be caused
-	 * either by the device being changed/removed or any of its siblings,
-	 * so we need to go through all children to find out if one of them
-	 * continues to block D3.
-	 */
-	if (d3cold_ok && !bridge->bridge_d3)
-		pci_walk_bus(bridge->subordinate, pci_dev_check_d3cold,
-			     &d3cold_ok);
+		/*
+		 * If D3 is currently not allowed for the bridge, this may be
+		 * caused either by the device being changed/removed or any of
+		 * its siblings, so we need to go through all children to find
+		 * out if one of them continues to block D3.
+		 */
+		if (d3cold_ok && !bridge->bridge_d3)
+			pci_walk_bus(bridge->subordinate, pci_dev_check_d3cold,
+				     &d3cold_ok);
+
+		if (bridge->bridge_d3 == d3cold_ok)
+			break;
 
-	if (bridge->bridge_d3 != d3cold_ok) {
 		bridge->bridge_d3 = d3cold_ok;
+
 		/* Propagate change to upstream bridges */
-		pci_bridge_d3_update(bridge);
+		dev = bridge;
 	}
 }
 
-- 
2.47.3

