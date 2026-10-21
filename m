Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.193
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792603388;
	b=0OUfttNcrNhz63U4soenLJeVnOA9yDUsredotU9WMLrK8vORgsfzhvcr75mOAJ+UFxs3
	 4dwJTTbR9HDzYcNLYNze9XI9rHNdquJ1w3fFqZhebZv25tLFgKoDF5wo2riwy+64fYVgG
	 W3CYQgtDc+/EvEKZwfUQY7Qr5ms67X6EmMIkFhmZPiXKlYrwHhvxT6vTqdVAFVd+GyZHS
	 YqYRulpEZF2Z5dtPXSOjhHkujdRBtCryzFG1am2RFcR8mAwhGqjPewcmUihhF1e+ZS3HF
	 6Ugdq5lhUMy7rg30aAEkbozu+LB1BR+VRJ2SrLM5U501+luKWG0JpYlNG1xkXSOzhTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792603388;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=TOJ16XUg6eE1K14QnduWV2MPYO1jo/9YTRDZbFyERD0=;
	b=Pqm7tnhJA3VJP+l7couD65f3/+q879Zlq6Tc+A/CS4PPhXlUZ+W83itGo9xjx2q+VNyJ
	 B5agh+20rLw3/hv5FyPenZ5z7IY8yQXVN88AMwVClx8Sn3qFGo0rYJCAV1C6kSyxy4pj6
	 Jvd15FXLqRtJZwbG/VRJriQZN0dlsWv+9dNFOBzvVJqV5JcE6VnXILasYlY2kucBgFLgR
	 dVy+mX7R3Riuawj3h/bSsQn3hmMIFn05YPOV6J23LSKM1sd7dwJNVnYswy/VYufm1GPSI
	 mXSNtOEUR25B2BXjWqTgmRHXi6XK+8wHfoyD0Jct+PkJdc7nH6B5I6JDSEwL8yJZOsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Sc3li7px;
	arc=none smtp.remote-ip=91.218.175.193
Received: from mta0.migadu.com (out-193.mta0.migadu.com [91.218.175.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7CB606A31B
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 17:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F7CB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Sc3li7px
X-Envelope-To: linux-pci@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=bp4shnOQ9u3ewOpbvMQE3hJPs45HWfqzfiCPIYJD8gk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792603385; v=1; x=1793208185;
 b=Sc3li7pxo10gvRU2zvNc5BWAjRCsWNY2vnk2DWdz9r77E6dtKi66htSvBFbardtFPfxI3+Ba
 Y9Z8ZWrTcYs2bwDfKvs84640fKvpytAWJ32E2IBATcTBn3vZv0WdQ3ZxoQHAYcUgVGjUUY+k2CL
 RXVIymrb7/QgT6aG56GVsGtU=
X-Envelope-To: linux-pci@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 322f1b2b0bdb5508;
	Wed, 21 Oct 2026 17:23:05 +0000
X-Mizu-Trace-ID: 322f1b2b0bdb5508
X-Migadu-Flow: FLOW_OUT
From: Aditya Garg <aditya.garg@linux.dev>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: iommu@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Jason Perlow <jperlow@gmail.com>
Subject: [PATCH] wifi: brcmfmac: map msgbuf RX packet IDs bidirectional
Date: Wed, 21 Oct 2026 22:52:38 +0530
Message-ID: <20261021172238.10004-1-aditya.garg@linux.dev>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Perlow <jperlow@gmail.com>

Commit f0ba5fd51ff2 ("wifi: brcmfmac: Set DMA direction for msgbuf
packet IDs") maps the RX packet ID buffers DMA_FROM_DEVICE. The
BCM4364 firmware also reads posted RX buffers, so with VT-d
translation enabled every such read faults ("PTE Read access is not
set") and the firmware crashes and resets in a loop.

Map the RX pool DMA_BIDIRECTIONAL again, as before that commit. TX
keeps DMA_TO_DEVICE.

Fixes: f0ba5fd51ff2 ("wifi: brcmfmac: Set DMA direction for msgbuf packet IDs")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Perlow <jperlow@gmail.com>
Signed-off-by: Aditya Garg <aditya.garg@linux.dev>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c
index 069ba70..ff47d48 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c
@@ -1639,7 +1639,7 @@ int brcmf_proto_msgbuf_attach(struct brcmf_pub *drvr)
 	if (!msgbuf->tx_pktids)
 		goto fail;
 	msgbuf->rx_pktids = brcmf_msgbuf_init_pktids(NR_RX_PKTIDS,
-						     DMA_FROM_DEVICE);
+						     DMA_BIDIRECTIONAL);
 	if (!msgbuf->rx_pktids)
 		goto fail;
 
-- 
2.53.0

