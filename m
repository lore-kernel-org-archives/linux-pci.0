Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.133.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983773;
	b=BS3NHDQwMMsDE2Tl1BDYZzJrpc+jM/opaPefAgqBKJIe6PoyieSB1mgosW34EJIEf8cU
	 UwKDbXBEjBj26oO5+3dfI8P2dJKrmASoSXD/vItLCIykCTRNQvF13AwrTitg0E68LCcN2
	 0ICudbuT71QwzzJ8Do518G/lTfHOoni+l+2mXAsEX0br9RJ9preRyZiyQBYeguXfkkJnx
	 0ad392V5LVw6zuIk5ip2AEiiyBoKWBSbwT5LTyFrzuYpr+x+kScXmsR21hS8tux/zEXhW
	 8Y5aQPFefehZ3bHzN4zg2jiWIZkY9oM1OTmdmkUUdtG1xWxJxqckuPClNJGXwPQIkow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983773;
	h=DMARC-Filter:Received:Received:Message-ID:In-Reply-To:References:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 To:Cc;
	bh=/Yp8dsMl6Lf3ocZHFO0ONl5/mkfgVoOZEOxzvn6eqRk=;
	b=ZvZtyZbloHE4QSxKleNdWxmaBbB9fSlzmIbNza7V8XHJ/Is5zMTD4vER1x0o+VR/B6yk
	 KOY3tWJTMkwZR5p1L4uRz192E63N4Xw1436Ng9BSHEqKOVQgZ6ABIeBg1CrtrNy2Nqy3r
	 fYCitlMfKMTP7VELzcEHI5ygMoNLl3E5IaSUeaSm3/815P9h1fpPjP6axp6TxstWDvjAX
	 MMdmsmMjUYx0T/xOASkHxCMsJRDOj51rFxArXCqcUtoWO8aZu3nozvP3TQ7f3jzLkDDh6
	 6p4XHH7y9WaePkO8w/oAaeGZ92ktUmNB7JJK926FHlIMFDaWI7NZzxafVXkGudOrBFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=144.76.133.104
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF08F606A326
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 16:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF08F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 87D916934;
	Fri, 06 Nov 2026 17:49:23 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 458AA602EB8B; Fri,  6 Nov 2026 17:49:23 +0100 (CET)
Message-ID: <7fb629b44a64b5b7ce0359346a61dc7d32359ca4.1793982724.git.lukas@wunner.de>
In-Reply-To: <cover.1793982724.git.lukas@wunner.de>
References: <cover.1793982724.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 6 Nov 2026 17:38:01 +0100
Subject: [PATCH v2 1/2] PCI/AER: Avoid NULL pointer deref on search for Error
 Source
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Alex Deucher <alexander.deucher@amd.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Keith Busch <kbusch@kernel.org>, Maciej Grochowski <Maciej.Grochowski@sony.com>, Ilpo Jaervinen <ilpo.jarvinen@linux.intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>

A Root Port's subordinate bus may be NULL if the PCI core runs out of bus
numbers on enumeration.  Yet when the AER driver searches for the source
of an Error Message, it dereferences the subordinate pointer without
checking for NULL.  Fix it.

Fixes: 28eb27cf0839 ("PCI AER: support invalid error source IDs")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
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

