Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=92.121.32.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583019;
	b=o31tMQNhW6cyJKIyyQD6RMppXRopLgCAceep6HLMbZO7KUSTipk5j9Fhy8B8NN24Gnbi
	 4+xqLaIOgVBl1MlwOTURt5yf8nv88gcctOMg+8TAHQzSCRr4Gd957P/YpLqk5V4jczoQa
	 KF16gLow4WiNobNRISjQchsMkiurxO+o7pdxqIvWeBCpvruvUfaBBJUugJ2gZFlNawkVT
	 3vdv5zxV0XcQMh2cQQCEh1+G2O+0R9TG7c6D34I8Zy2YPbxz6G/ZD5gqCK40a1KhQBWsc
	 BZulXtPpaHe9cppgt5AsPbTaTZdCUn/yP0LrSEduq94e37O4ZUiqyo0s2Q402eLGpZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583019;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uKib2WONiwyAn3NNdrBU0u8Y5Qax9KbCLC9NRfJsdxo=;
	b=wpe/yPQXu5mVXsxCqH+yQUl1kqHVCzjMXGwW83d6tZFz3wDzshF5mlmMWds0fhV6THdQ
	 NRutFEF9B5P1TapS6xtwL4UuSEQc/qQN5T/xraQuxzbm9nVPi3uYXTnwZKr4psAGmK7AN
	 sgkC0eXXQd48m3uD+2JTBcUMnkf+Awlkk+g6FME3kWZ6GgbZSxPc3psru9FOAxclbAdFL
	 y+uN4JA0JQaecF4QMpBZDDVt6RQhWb9C/x2NuyKjTevfDjtd62Alore0xUs0xoiIyCMmh
	 vM5V3ePoT8JvVnI1XTtvJHnx7+aXvUD0w/w1Y48q5T/WrFX8XbXw+hrfAxFjF8HhoMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=nselector2 header.b=catQyEcP;
	arc=none smtp.remote-ip=92.121.32.55
Received: from inva130.nxp.com (inva130.nxp.com [92.121.32.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97FD60A2628;
	Fri, 13 Nov 2026 15:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A97FD60A2628
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=nselector2 header.b=catQyEcP
Received: from localhost (localhost [127.0.0.1])
	by inva130.nxp.com (Postfix) with ESMTP id 8C6186088977;
	Fri, 13 Nov 2026 16:12:40 +0100 (CET)
X-Virus-Scanned: amavis at nxp.com
Received: from inva130.nxp.com ([127.0.0.1])
 by localhost (inva130.nxp.com [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IPz2I8BUYV7H; Fri, 13 Nov 2026 16:12:40 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva130.nxp.com (Postfix) with ESMTP id 2911F6049C64;
	Fri, 13 Nov 2026 16:02:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva130.nxp.com 2911F6049C64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com;
	s=nselector2; t=1794582165;
	bh=uKib2WONiwyAn3NNdrBU0u8Y5Qax9KbCLC9NRfJsdxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=catQyEcPB79HiDB/y4dFLPIWX0p6qKOiDp8w9qWBCLu4fXV3HY9g4J/ZSS1iXOyw2
	 ar8egmXkVV/8SrRKOTCvr0fTeoY2EUKMj3LQgFULDG92v4A6KluTDItpSelhbKQ3MN
	 wqmrN80aGhPP7xLX26CRr9pQ5rROYOFH6QtI7dklT3eDd+SPqIOvU0TO+ogaerQcgf
	 u58rQtxNGK8H92CDc4jVTRdJ1hmiC0qz4KlkcNXLGUXhq0lFqVNYUBEmurGWHlloFx
	 I3x56DMNvtQJVMIAcEn2jXKPsXpDdr7WrJ4+DiH01WXo8XhNoD2z+0P5ab50HSwGUn
	 mAju/KGy+E6CA==
Received: from lsv15141.swis.ro-buh01.nxp.com (lsv15141.swis.ro-buh01.nxp.com [10.162.246.138])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 3CBC2202B6;
	Fri, 13 Nov 2026 16:02:44 +0100 (CET)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: netdev@vger.kernel.org
Cc: s32@nxp.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 6/6] PCI: Create OF node for NXP ENETC pseudo-MAC functions
Date: Fri, 13 Nov 2026 17:02:37 +0200
Message-Id: <e256f380f2f1bc88752ee261101cc83ad84ebedd.1794581338.git.claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1794581338.git.claudiu.manoil@nxp.com>
References: <cover.1794581338.git.claudiu.manoil@nxp.com>
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
v4: none
v3: none
v2: none (reworded the overlay reference to match patch 1's fixed-link
    approach; no functional change)

 drivers/pci/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7f1f47ea2ee4..71f272d8a296 100644
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

