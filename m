Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.133.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795718130;
	b=YE8vvGGzqR4U7cmocDhPa/26gPMhMQwNf1CYIEVDzwwxXChy1msQuvnHJOXG+vDSnSB0
	 q2VhVbGT2eRxV2I7HDyAiPcUdD935GMBqa+tPJDnABCaqBRToOs4KdgtA8QE0Gwalo4Ks
	 KpHNUB7ZYuR3mC3fr5ctoNNTfTOQh1K/ESBLCcSgYH7+2BLUl4SipjqPncETW17OA3FZ7
	 c6cDM1A+AU5jfwuBOyji3OX33SnV61SyQj710L49CEFidwfeJ/N+dPdUVJwEINHa+n2On
	 xUhx1LvNeK/5lQLL/IejQVERdJBjldnoLmKj5WUaigCmGUlOr0XmTOUd+IFEe5cyHzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795718130;
	h=DMARC-Filter:Received:Received:Message-Id:From:Date:Subject:To:Cc;
	bh=T8gL3R5Of4fh7/JSzNbmIkuPBYVFqpMyrpx8pK3ARFw=;
	b=BGWLvleXFkThn7CULkXG4TH5SB8FvRuTzFTQhz60vV4BI1MObbranIkH4CuZtJdRYT91
	 Ndy+/lcoNj3MZPwC0i9KVv1FfzKJzC98PHEgSvO5Iq6o37ZbOYRsefLgipnyGFCbnMw4k
	 ysm2KdMOAxsAuo/u0RA4TnQyV40Q1oCTbA1/2b0XoUUevWNogT/Iux7m1d3EPj+PJ/Uv2
	 1gak8W8M7L7n/DYFz8fi03qb+F47bVrCprlL1hnKHdcJxiAQR3k1rBrcVRN71hxej4faT
	 TB6MyOIxIMB4Jrpt9CH96ULvs151tb2wa3zRBf8lnTCOBd3CkSDY8GYJ+o3oLfw1x4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=144.76.133.104
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3A5606A32A
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 18:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E3A5606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 1DEE4DAA;
	Thu, 26 Nov 2026 19:35:21 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D77516028ECD; Thu, 26 Nov 2026 19:35:20 +0100 (CET)
Message-Id: <1ddc35c51b5317988bbf235c467a9534218c6ea4.1795717157.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Thu, 26 Nov 2026 19:35:00 +0100
Subject: [PATCH] PCI/AER: Check error status registers if Error Source ID is
 zero
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Keith Busch <kbusch@kernel.org>, Maciej Grochowski <Maciej.Grochowski@sony.com>, Yazen Ghannam <yazen.ghannam@amd.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Since commit 6d69eeae8966 ("PCI/AER: Check validity of Error Source ID
register"), the AER driver checks whether the Error Source ID register
contains either the ID of the Root Port (or RCEC) itself, or of a device
subordinate to the Root Port (or associated with the RCEC).

If this check succeeds, the Error Source ID register is assumed to contain
a valid value and is not double-checked by reading error status registers.

However per PCIe r7.1 sec 2.2.9.1, devices may send Completions with a
zero Completer ID "prior to the initial device Configuration Write
Request".  Similarly, CXL r4.0 sec 8.1.5.1 states that a Component may
generate a CREDIT_RTN IP2PM message with a zero bus number after reset,
which can fail ACS Source Validation and trigger an ACS Violation Error.

On ARM platforms, there is often a Root Port at address 0000:00:00.0,
which makes it impossible to discern whether a zero Error Source ID refers
to the Root Port or to an uninitialized device downstream.

For this reason, always double-check error status registers if the Error
Source ID is zero.

Fixes: 6d69eeae8966 ("PCI/AER: Check validity of Error Source ID register")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
base-commit: 6d69eeae8966bc3bea0facbd550f45ef9de41cc4
 
This fixes a commit queued on pci/aer.  It can either be folded into
that commit or applied on top of pci/aer, whichever is preferred.
 
 drivers/pci/pcie/aer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 1973b6e..24b014b 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1158,6 +1158,10 @@ static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
 
 static bool source_id_valid(struct pci_dev *root, u16 id)
 {
+	/* ID is zero prior to initial device config (PCIe r7.1 sec 2.2.9.1) */
+	if (id == 0)
+		return true;
+
 	/* The Root Port or RCEC can itself be a valid Error Source */
 	if (pci_dev_id(root) == id)
 		return true;
@@ -1186,7 +1190,7 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
 	u16 reg16;
 
 	/* Some Root Ports report an invalid Error Source ID */
-	if (e_info->id_valid &&
+	if (e_info->id && e_info->id_valid &&
 	    !(dev->bus->bus_flags & PCI_BUS_FLAGS_NO_AERSID)) {
 		/* Device ID match? */
 		if (e_info->id == pci_dev_id(dev))
-- 
2.53.0

