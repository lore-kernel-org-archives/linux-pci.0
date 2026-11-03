Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=92.121.32.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714966;
	b=w8C5+GF2VeVbXlk/P9H6EHLfHGGSn3poeenlU0sqIYE+UKv12jvBImOKIikVNw+/SNX2
	 MRDoTsBHPYW22NCo5dAxoBWACgOUCBaJT0nQYA5P/qPKoNHpR4deIsVoWy2u839WB814n
	 sWsAk76l23205a1TljfITM8Zswz99A9DDx/CbAwY90OWldAJIM5FfCnwzB2gzrileW3VK
	 iMy66GBSH/avOiJT7Xwbu/CxGwbLW4XK9vYJq1laAYvKQnXa913kZFkR/iO1CtjdzUARM
	 7Vd/bvdZIi8mkxUr+oC3LsPR+dkTmEmX/KopgMEhIJy6HoYCaE4NIQGRk3R2BdlIGMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714966;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Crq93yTs/1mgPuKwU6cYk5IvUM0GBSs1yjc4BT1dQcM=;
	b=QZl5IzUS86N4t6M5XN1ityH/vd//ddmxHHtZsqiXrRcyM6T64plcUnS8fheKhRd6eOe4
	 8xsplweR00rJu2BAVYdO28QPXUa8WpKrLWb8Ayyg7aHmhntM66OXazSc9CQyd8PlI7eWp
	 EIwk6Ed2oXcsMvFTJOcOQ0UEECrksnjcl5jO/jRK3KPjw7ZbxcXCZmdfYvEcOq67X4yul
	 N0dP1BNNRMkyoehvO3Mz1l/WzL5ADXvxF+HwKUWoGCBXeWJ6QvFvczH4cA67ya2+Z04Pa
	 AiQvU6xYuJIbppTTDkg9mLz6Nn/SXpAYRsx+yXUmhzdBkilF8CWkeWXKirfUGz+nY5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=nselector2 header.b=VAw9n5BZ;
	arc=none smtp.remote-ip=92.121.32.54
Received: from inva129.nxp.com (inva129.nxp.com [92.121.32.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E9F606D835;
	Tue,  3 Nov 2026 14:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05E9F606D835
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=nselector2 header.b=VAw9n5BZ
Received: from localhost (localhost [127.0.0.1])
	by inva129.nxp.com (Postfix) with ESMTP id C002F600029F;
	Tue,  3 Nov 2026 15:09:18 +0100 (CET)
X-Virus-Scanned: amavis at nxp.com
Received: from inva129.nxp.com ([127.0.0.1])
 by localhost (inva129.nxp.com [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aG3tK7qrVom5; Tue,  3 Nov 2026 15:09:18 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva129.nxp.com (Postfix) with ESMTP id 44975600009F;
	Tue,  3 Nov 2026 15:09:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva129.nxp.com 44975600009F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com;
	s=nselector2; t=1793714958;
	bh=Crq93yTs/1mgPuKwU6cYk5IvUM0GBSs1yjc4BT1dQcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VAw9n5BZi/5XHZPBrRsOz0kKWN06rd8e73J2FKxlUc0H86vfORx+SwnBgnGjJRr5L
	 Vh60WzT1LM89YxU1TX2BkbQ78yt8apAfehoVlwK4A9ide2I9w0UVZ8QK/faK5t3oE8
	 c0wBobRUmbv5YzqbC5yQBnpWBzilB9afzz2/xKlVxR2eybqiPB0mZhgdVRiKu58/nB
	 iTXP45LT+a9NXIi1pJqqSTWY/X2uQJA+vA/O5uN2CtYIOpWAKQvhq7G9Wo8x8DvcYX
	 dMlPHwnOFmPvmCPgf8RIKTqC2bfMPJo/Wbe17Q6opeXb3ZRc5rEy3lb3hirzVa0xaJ
	 ZRfdpCv35ol9g==
Received: from lsv15141.swis.ro-buh01.nxp.com (lsv15141.swis.ro-buh01.nxp.com [10.162.246.138])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id BC92C202AF;
	Tue,  3 Nov 2026 15:09:17 +0100 (CET)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: netdev@vger.kernel.org
Cc: s32@nxp.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 5/5] PCI: Create OF node for NXP ENETC pseudo-MAC functions
Date: Tue,  3 Nov 2026 16:09:11 +0200
Message-Id: <e01cc93899ec6e774a568c72d1f38788f65c8577.1793712309.git.claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1793712309.git.claudiu.manoil@nxp.com>
References: <cover.1793712309.git.claudiu.manoil@nxp.com>
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

NXP ENETCv4 pseudo-MAC (PPM) ports can be probed as pure PCI endpoints,
without any "ethernet" node in the static device tree. The ENETC4 driver
describes their fixed link by attaching a fixed-link node to the PCI
function's own OF node, which requires that node to exist.

Request the PCI core to synthesize a per-function OF node for these
devices by registering of_pci_make_dev_node() as a final fixup, following
the existing precedent for the Xilinx, Red Hat and EFAR devices. The
helper is a no-op when the function already has a static OF node, so this
has no effect on platforms that describe ENETC via static DT. It only
takes effect when CONFIG_PCI_DYNAMIC_OF_NODES is enabled.

Both ENETC4 PCI device IDs are covered (0xe101 and 0xe110), since either
can be instantiated as a pseudo-MAC port on S32N79.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
v3: none
v2: none (reworded the overlay reference to match patch 1's fixed-link
    approach; no functional change)

 drivers/pci/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7f1f47ea2ee41..71f272d8a2965 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6563,6 +6563,8 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EFAR, 0x9660, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_TOSHIBA, 0x0220, of_pci_make_dev_node);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PHILIPS, 0xe101, of_pci_make_dev_node);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PHILIPS, 0xe110, of_pci_make_dev_node);
 
 /*
  * Devices known to require a longer delay before first config space access
-- 
2.34.1

