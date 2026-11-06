Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.223.78.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983121;
	b=VCTaqsSnEjmez2ec/XDgpq0eL0xVHlIjRAtVsPc2ZSxad5LvoxP+42HJ1UatcUnB8ock
	 FdbVqHFKoKjtcG3pRqtqcrwm26g43JeXfPjX6x4gBak6t/UjtSMU1xijvJR0PwQAm7aIO
	 Vc9N55wJ/lyPVNeMmKRKr7+3YwWwQuyBDd+736aIu5GCO3qAIXcD/36m5M0LgWEwC1U+b
	 VK7/UNk/N62Y24AVx7V119q/zrdgq8oBCpyrIprhzymQXVAsNqvwZ8hXTr/o9asiKyvEj
	 Vs4OpmgMVZrhoJhdrPlVbWDxcN42lr2WX2dyll7Q4aJTfzvJ+28fRXCpenymyn1HAgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983121;
	h=DMARC-Filter:Received:Received:Message-ID:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:To:Cc;
	bh=jic80HyoFLmRco4YMHbShYG6FvjsucGi0Amdp6g1OKI=;
	b=Ao8ufa5um7RGep+kaviis1/f7Nhcudf9kXDd2nVl0LyDKQC/mM3v1zuLkwx480h1DmHc
	 povENEmVop75phBm09lVBcya93S32YG+AmejyU0eR1OAnUqwJLBkbAd6bAaN9hYhm+LYm
	 7Gi4XTchZ13CUGU3k469clakMWbO9uRXDenda935CS6ueRUAeb8ZWXDhzm+1zsQv3ZRgQ
	 askGrn3HoK/MjBrUvOKeoNjpb9YzfMB1O2BDcYImQwMsr8sWDRWIOcVf7nSkvNnEwcyUD
	 oKf0V7csU8EZVKH4MctOg0oNRssdehR5P45uRUC5lfiGuMH1ZCciuucwnxOFRudZ4lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=83.223.78.233
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAC0606A329
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 16:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DAC0606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 6C81E1EE8;
	Fri, 06 Nov 2026 17:38:31 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 527E8602EB8B; Fri,  6 Nov 2026 17:38:31 +0100 (CET)
Message-ID: <cover.1793982724.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 6 Nov 2026 17:38:00 +0100
Subject: [PATCH v2 0/2] PCI/AER: Improve Error Source handling
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

While analyzing log output provided by Alex, I noticed that the AER driver
fails to find the error-signaling device if the Error Source ID register
contains an invalid, non-zero value.  Fix it (patch [2/2]).

While at it, fix a potential NULL pointer deref in that portion of the code
(patch [1/2]).

Changes versus v1 in patch [2/2]:
  Reorder a < b && b < c comparisons (Ilpo, Bjorn)
  Amend kernel-doc of find_source_device() (Sathya)
  s/subordinate/secondary/ in commit message (Bjorn)
  Document behavioral change in commit message (sashiko)

Link to v1:
  https://lore.kernel.org/r/cover.1793697480.git.lukas@wunner.de

Lukas Wunner (2):
  PCI/AER: Avoid NULL pointer deref on search for Error Source
  PCI/AER: Check validity of Error Source ID register

 drivers/pci/pci.h       |  7 ++++++-
 drivers/pci/pcie/aer.c  | 37 +++++++++++++++++++++++++++----------
 drivers/pci/pcie/rcec.c | 14 ++++++++++++++
 3 files changed, 47 insertions(+), 11 deletions(-)

-- 
2.53.0

