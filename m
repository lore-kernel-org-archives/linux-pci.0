Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=204.191.154.188
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728588;
	b=Tt9aaIXugL8XTKq0OIPPxmeDd3OfYa+gwCe/UbJ2dbf26VOKOqyY32gzMKviCkJQN6fY
	 ezwwpjxKTC2t3TMKAeHWTRMEyKYr1LpqsP9m4g6o9dLQDgVqzgNeC2BCr1Y0THg+pTMS1
	 9nK5azpuzCQPK79yruw5K73D3V7nGDwACHRtIOQOoP/oZk6neUkIxUhTIuvaWt+F3u1eU
	 ewzeJUXlPw4dCbDZHFpQ0Dc7AhF5nWPU5meAvIYPk4Q2w0CrPrdlICGu6p1Gv9/1r83cv
	 fzHeusX4r9fF7P+UJQdQtQrFZmV6zVqdTnBDIc9jS7++h38DdbBYzv1fe9SYLMljHig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728588;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-SA-Exim-Connect-IP:X-SA-Exim-Rcpt-To:
	 X-SA-Exim-Mail-From:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
	 Subject:X-SA-Exim-Version:X-SA-Exim-Scanned;
	bh=RchtkJFTw36chOPxEtH6cIti46A9gaK+Fmpg6WmFwbs=;
	b=24WhdKeVMy/paU0AtA54C9oUtnIbWWBELHfWc6Pp4yheX9vJKWF33V7pWo8UI6lAmZiV
	 LVU08yDlKwBBiWnQPiNfGlaxAPubgX0bpwn7qFt1GrNVougKV0EYrh+wiO7Ty68yW7xxj
	 /Y7EXb0UZ6iF4FGi08w12bHFi1rImOc0UFuFcZFYlpyk28lYRSBVcjSLgHTKoFafDxhim
	 BxByDV2nkWf7yBcg6fI1kVwFomhsUxUM/YBSZckiIzqg8rhjCjJcicPG8tP5a9GXQBeA5
	 xH90QFm9NEA0klt/Ut+1ClNq34XrA8fLBJ8eIJ5ZD9O4i7/xVSifNEmf1WsRV5JUO/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deltatee.com;
	spf=pass smtp.mailfrom=deltatee.com;
	dkim=pass header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b=R3hSzes3;
	arc=none smtp.remote-ip=204.191.154.188
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC089606A32F;
	Tue,  3 Nov 2026 17:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC089606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b=R3hSzes3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=RchtkJFTw36chOPxEtH6cIti46A9gaK+Fmpg6WmFwbs=; b=R3hSzes3M+epkyGmmiHfAJp0he
	lHqbZQ1oEGu+smE5nf5Mvo5sNuEQWDN21WG/MXnp7WnU+p7kLxapHk1R07Exo42+FMRGinAKnVXjh
	9LwuFc+1g3UeQwF4ducboEv4eAXCBmy1pZDkxPpDVgPaV3S4Hxpfe+/n6C2Q7Lq3vCkfSBOCL0NYr
	R8ywmyBjdi0PTCbb7GmbT2vO2xhbMjVdxL12MuQiRapAvsf5siuhatRN5H/QyDNKYWh/k+M9P5JFd
	8Vjje1kgyWiK1AB/kEUrAPRnWgxpJwxZB9d+mHGdUfQUU2pBIq+uLyd039urqTJdmlHpMISc2kb+V
	RatMLWtQ==;
Received: from donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1xOIkE-000000093No-0887;
	Tue, 03 Nov 2026 11:56:26 -0600
Received: from logang by donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1xOIjx-000000021CV-1qMe;
	Tue, 03 Nov 2026 11:56:09 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Frank Li <Frank.li@nxp.com>,
	Kelvin Cao <kelvin.cao@microchip.com>,
	Logan Gunthorpe <logang@deltatee.com>
Date: Tue,  3 Nov 2026 11:52:07 -0600
Message-ID: <20261103175208.481170-2-logang@deltatee.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261103175208.481170-1-logang@deltatee.com>
References: <20261103175208.481170-1-logang@deltatee.com>
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
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, bhelgaas@google.com, Frank.li@nxp.com, kelvin.cao@microchip.com, logang@deltatee.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: [PATCH 1/2] dmaengine: switchtec-dma: Add Gen6 secure device IDs
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

Add the device IDs for the Gen6 PFXs and PSXs secure switches
(48XG6 and 64XG6) so switchtec-dma binds to their DMA functions.

Based-on-a-patch-by: Kelvin Cao <kelvin.cao@microchip.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/switchtec_dma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index a386c3a284e6..1af938bb40b3 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -1455,6 +1455,10 @@ static const struct pci_device_id switchtec_dma_pci_tbl[] = {
 	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5452), /* PSXA 52XG5 */
 	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5436), /* PSXA 36XG5 */
 	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5428), /* PSXA 28XG5 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x6064), /* PFXs 64XG6 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x6048), /* PFXs 48XG6 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x6164), /* PSXs 64XG6 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x6148), /* PSXs 48XG6 */
 	SW_ID(PCI_VENDOR_ID_EFAR,      0x1001), /* PCI1001 16XG4 */
 	SW_ID(PCI_VENDOR_ID_EFAR,      0x1002), /* PCI1002 16XG4 */
 	SW_ID(PCI_VENDOR_ID_EFAR,      0x1003), /* PCI1003 16XG4 */
-- 
2.47.3

