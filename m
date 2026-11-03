Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.223.78.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699348;
	b=4g1q9CChTBSoij66BELV5BV68Qmd6s81SsF9XRPeUkmqEy66CPUKiVgGxCQ52KcbeYAW
	 SNh4jj/SVmelKnEFDraAJKzs0cTSb1i6WkAqk7S0j6ANUuIR+veWpumh0aTA6LFI5m4Co
	 h9I7nD7EXybYcD8xNsLRvEA5mkWv1sVQ5NBOrC+yaJck/pqfOLINH+gQ7HrNOKf2Unvs2
	 snmduVRtGrRW2GndzZ8e2faZX/KWTgEwwCfAsfV18KntpkR4KFjaxPQB2F+KFMd3Ir4KG
	 fz3jiLjY2ybYY2PfR5AhaW9hsX/KTuLqlEL2L4g1TseWkB5c/ITwHdte1TqgXZwXiBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699348;
	h=DMARC-Filter:Received:Received:Message-ID:In-Reply-To:References:
	 From:Date:Subject:To:Cc;
	bh=/ox8YTThMfnvCpUAm/RezoHGpMO/i532LX4gPnwxXYw=;
	b=eZ6vRdTiVnaY6LVAW9jfcOlJ4VAGpH8JdwG/sUrYDw+XjT/HDEqjzt54pDMu++U27xSb
	 JIv/ERIYmUFCg7Ycq4E9PK45/mql1c2e44KXRDPdz2AQwwNf95oYBl1WA0T++dHOksvpl
	 5/AJp6i+P1iMxm1xZuJ6assWOIXHziqD7Ftg8khuEph9Ad+qp355KiScO0OKI7u7F94TG
	 94ODW3WNlEa4udEUK6Wy8pg3H/T8eiLuoWAYU4vevFBzJfphXTIWLSOJMDKtkeo5mElmt
	 dCG+PEG75hqPoyySh0heeo6HnE0rM6MC8THdUPrq393sFAuDJMd06GQ2UoNihFrWSVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=83.223.78.233
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446E7606A327
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 09:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 446E7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 5380910DC8;
	Tue, 03 Nov 2026 10:49:05 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 4319B600B02F; Tue,  3 Nov 2026 10:49:05 +0100 (CET)
Message-ID: <6de42407246d270c75126baa338761e6f21ab067.1793697480.git.lukas@wunner.de>
In-Reply-To: <cover.1793697480.git.lukas@wunner.de>
References: <cover.1793697480.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 3 Nov 2026 10:45:01 +0100
Subject: [PATCH 1/2] PCI/AER: Avoid NULL pointer deref on search for Error
 Source
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Alex Deucher <alexander.deucher@amd.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Keith Busch <kbusch@kernel.org>, Maciej Grochowski <Maciej.Grochowski@sony.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

A Root Port's subordinate bus may be NULL if the PCI core runs out of bus
numbers on enumeration.  Yet when the AER driver searches for the source
of an Error Message, it dereferences the subordinate pointer without
checking for NULL.  Fix it.

Fixes: 28eb27cf0839 ("PCI AER: support invalid error source IDs")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v2.6.31+
---
 drivers/pci/pcie/aer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index db4f607f889c..d492c7ce01e1 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1251,7 +1251,7 @@ static bool find_source_device(struct pci_dev *parent,
 
 	if (pci_pcie_type(parent) == PCI_EXP_TYPE_RC_EC)
 		pcie_walk_rcec(parent, find_device_iter, e_info);
-	else
+	else if (parent->subordinate)
 		pci_walk_bus(parent->subordinate, find_device_iter, e_info);
 
 	if (!e_info->error_dev_num)
-- 
2.53.0

