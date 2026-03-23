Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620DF29994B;
	Mon, 23 Mar 2026 07:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774249259; cv=none; b=bmoWlFYdanXZYOE9Td1EQzC7X90m//PVcfKplSN/GqCj846R8z7LXO5ozpDxpqtk7mtouNHL41Dh45hqyXq1a3fqfPkSdsSWezBxsPc4yK/dgqpi9meMRzIICtVRoI1Oklte/or1r3p9tGMXiKKqPQLsvXVJgTnGkIyKmrEXbwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774249259; c=relaxed/simple;
	bh=YH4DWVWEgztyUuYoCeNMjlqf6GO+QsfbVOkNkAB2JWY=;
	h=Message-Id:From:Date:Subject:To:Cc; b=J5GcQ3ZEGSKJE/FCrJW+2mFQvMvqtnQHHUYZqqDyi8rKuiTO7B0sKdUab3YEvVFsgt7tiytOR8qsd9aHRF6pNg4uQ+rVYmyDe3hoNBnvIUGP9+FBUtnV421Xstz0639OJ7KOJaLBQPYSO4aagbiHaef2FSdgZ2pWNfHLIzGzl24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 364E7C23;
	Mon, 23 Mar 2026 07:53:12 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 037C96020F68; Mon, 23 Mar 2026 07:53:11 +0100 (CET)
Message-Id: <bf826c41b4c1d255c7dcb16e266b52f774d944ed.1774246067.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Mon, 23 Mar 2026 07:52:39 +0100
Subject: [PATCH] Documentation: PCI: Document decoding of TLP Header in AER
 messages
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Maciej Grochowski <mx2pg@pm.me>, Kai-Heng Feng <kaihengf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The prefix/header of the TLP that caused an error is recorded by the Root
Complex and emitted to the kernel log in raw hex format.  Document the
existence and usage of tlp-tool, which allows decoding the TLP Header
into human-readable form.

The TLP Header hints at the root cause of an error, yet is often ignored
because of its seeming opaqueness.  Instead, PCIe errors are frequently
worked around by a change in the kernel without fully understanding the
actual source of the problem.  With more documentation on available tools
we'll hopefully come up with better solutions.

There are also wireshark dissectors for TLPs, but it seems they expect a
complete TLP, not just the header, and they cannot grok the hex format
emitted by the kernel directly.  tlp-tool appears to be the most cut and
dried solution out there.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Maciej Grochowski <mx2pg@pm.me>
---
We could also go one step further and point users to this tool
in a printk_once() message when the first error occurs.
For now, just amending the documentation is probably sufficient.

 Documentation/PCI/pcieaer-howto.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
index 3210c47..90fdfdd 100644
--- a/Documentation/PCI/pcieaer-howto.rst
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -85,6 +85,16 @@ In the example, 'Requester ID' means the ID of the device that sent
 the error message to the Root Port. Please refer to PCIe specs for other
 fields.
 
+The 'TLP Header' is the prefix/header of the TLP that caused the error
+in raw hex format. To decode the TLP Header into human-readable form
+one may use tlp-tool:
+
+https://github.com/mmpg-x86/tlp-tool
+
+Example usage::
+
+  curl -L https://git.kernel.org/linus/2ca1c94ce0b6 | rtlp-tool --aer
+
 AER Ratelimits
 --------------
 
-- 
2.51.0

