Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.223.78.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699111;
	b=sf30WxcmJ9cqIxECZUgM1GKwF4KpmffTgkPo+q12C9/HBXWtIlscSh5iCTihzrkNvo/3
	 H/QV4+kVMB/a53pQyZqYVcfiJTlGrarIPN3dSI5tupPbiEiAE3x0Y496UY+GIWUAxVIyV
	 PcZY/a5/RhHf+e3O8iTNmeKBjaT0sJQr5e4Wo9xq7xfI6y74w9bscIu428ZVNTASwkoAa
	 Z2vHCDNXM09wYlR49W6CwJEdHVPJm3IF+jhJp4taDsGD3tD/9s4wJVj8yBk1VtWDCu79P
	 0tX2A1uxKnxnhF/jP8aiUDQwjH5qgqdEwREd0RASudmQ0HhI+iffDFYwwl1syrSJtdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699111;
	h=DMARC-Filter:Received:Received:Message-ID:From:Date:Subject:To:Cc;
	bh=DFR/PANMtbsevfEku4Z3pizYVHHbGGcn40b739MWAyg=;
	b=SKlEDz4TFKJous1GNVJVwIRj1Sgbj/eZz9hkU/IY7gMl8PGC72ePHZUnQeCHBLISuckg
	 YTwXZuDsbrIfMgjspUak6kRZpcp+WKqxCM5L5fg3d7A39M82TjePE7YgqeONRtVORRH3r
	 SdIGmj3ylxB342W4zhwOvPCFrspPfj099zAX87v/9nHTZKdk4/qiZ71nP/osZgyK0efY3
	 8lvrX326nEPmXuaI8x9pkNuzb1fAV8pFMW35OnoT7vjKND0ZGOBzLemfESqNS3f3+WLYX
	 PTYHKKnlqoWnLcE3DRtyr/aWHPvxEvLf3AyJnw+bCghyZ8K/bDHnlv4DHusboB+8XIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=83.223.78.233
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31FD606A331
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 09:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C31FD606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 7CB471EC8;
	Tue, 03 Nov 2026 10:45:06 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6DFA661C2345; Tue,  3 Nov 2026 10:45:06 +0100 (CET)
Message-ID: <cover.1793697480.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 3 Nov 2026 10:45:00 +0100
Subject: [PATCH 0/2] PCI/AER: Improve Error Source handling
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

While analyzing log output provided by Alex, I noticed that the AER driver
fails to find the error-signaling device if the Error Source ID register
contains an invalid, non-zero value.  Patch [2/2] fixes that.

Also, a potential NULL pointer deref caught my eye in that portion of the
code which is fixed by patch [1/2].  I believe this is hard to trigger,
but the kernel should still handle it gracefully.

Lukas Wunner (2):
  PCI/AER: Avoid NULL pointer deref on search for Error Source
  PCI/AER: Check validity of Error Source ID register

 drivers/pci/pci.h       |  7 ++++++-
 drivers/pci/pcie/aer.c  | 35 ++++++++++++++++++++++++++---------
 drivers/pci/pcie/rcec.c | 14 ++++++++++++++
 3 files changed, 46 insertions(+), 10 deletions(-)

-- 
2.53.0

