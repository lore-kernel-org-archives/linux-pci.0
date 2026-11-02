Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793601551;
	b=Nbt3AXkrgeZQzOkK1YO56b44ZaoyHtYJtrgsXkYeLuPc4HkYVKRBo9+H0L2PaGa/jS9p
	 hw8g9Zp0hyWCdOuDSJlu91pkfsq/nYLqTQ089B1UevXo9KLeHSYgrBkitgYMNWNred980
	 QZpkxHmfRDWRfwYiTg+as5x1+hBh98VUnCvhz0s7rEjL8/t2nQ1KvxizyTIuZFU6ckFFZ
	 iMkuOuWteb/ZdilMSSEgXa9UNhAOg4AL3qix3DC+IZlztnH+LX5U6/ZUNGLLjuY7sTMbl
	 Oa/KXmUn+mfMcCOZmLfZ0UkV3KeHXPaSRciYtT9KJqC+PnVcyDogLpO0TpRBKu7xzBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793601551;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=oXMGI5x877HPU4R/ZXY44qHq3rugmj3SbYie57HtULE=;
	b=lBGjRUxmILLvB51fW/pJD7DQjvpKEmn7/GeuLZ/0MyZ7aERRVvK0zWq3QWsE6KMTBmnN
	 syc5166veJL8G1Mw2geM4CY/olFBU7nRRQR/d2OuK7D1LN6Ixh/RLxYDPEcGDhxBda23c
	 1VfjK17vgl/H1T5NsUfWqIzpnS4SKHrbyRQYRj3yLbzvH7fCzJfPvmYI0MOyUuZsfKJdE
	 SVAl0zmAG23ZYaxYEonUAYf6ghHHvFxb3jIABLXc2/k0kQSrpD88QzMHC3J7kJpDs4vU+
	 y7iLbtgmf/qXIWCdGEKDFQQjXPsmnkt0s8E5X5XdHmWTPYtb0bUYK4Wyr04SHXz9qHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Eh27tT63;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D151A606A327;
	Mon,  2 Nov 2026 06:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D151A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Eh27tT63
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=oX
	MGI5x877HPU4R/ZXY44qHq3rugmj3SbYie57HtULE=; b=Eh27tT63y3d6oncU4z
	bAMYOQmTDZs0QFJxp3OyOMyzwn1JJIyJPP7DbzRboli04gfbQ1081aQxHYt6byHc
	ho8fKfceAwFHypqTLJJlQyWekXrE17cG4Yft6pcEFWeYdUJNXUdecLdScusunkyc
	ZQWzfGIvsvTN6pwyvZU9wPzdw=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wBHtprxL+hq5ucpEg--.6411S2;
	Mon, 02 Nov 2026 14:38:42 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	jonathanh@nvidia.com,
	thierry.reding@kernel.org
Cc: robh@kernel.org,
	linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH] PCI: dwc: tegra194: Clear event counter masks before programming
Date: Mon,  2 Nov 2026 14:38:35 +0800
Message-ID: <20261102063835.3831940-1-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
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
X-CM-TRANSID:_____wBHtprxL+hq5ucpEg--.6411S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AryktF1UKF48AF17Gw1DGFg_yoW8Wr4rpa
	y3tw4YkF4jqF4a93W7A3W8uw15ZrnFyrWkZ395Ww1IvF43ur9FqFWIg3y5ta1xA3yIqr17
	K3yYv34xur45G3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piJ3ktUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BLcgGroL-IZ6QAA3N

When programming the RAS-DES event counter control register, the code only
cleared the event-selection field before OR-ing in the new group, event,
and enable values. This leaves stale bits in the group-select and enable
fields from prior writes.

Clear all three field masks before programming the register so that stale
bits are not preserved across updates.

No functional change intended beyond ensuring the register is rewritten
without carrying over previous field values.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 26e2ac5c5869..7a0aca54667c 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -623,7 +623,9 @@ static inline u32 event_counter_prog(struct tegra_pcie_dw *pcie, u32 event)
 
 	val = dw_pcie_readl_dbi(&pcie->pci, pcie->ras_des_cap +
 				RAS_DES_EVENT_COUNTER_CONTROL);
-	val &= ~EVENT_COUNTER_EVENT_SEL_MASK;
+	val &= ~(EVENT_COUNTER_EVENT_SEL_MASK |
+		 EVENT_COUNTER_GROUP_SEL_MASK |
+		 EVENT_COUNTER_ENABLE_MASK);
 	val |= FIELD_PREP(EVENT_COUNTER_GROUP_SEL_MASK, EVENT_COUNTER_GROUP_5);
 	val |= FIELD_PREP(EVENT_COUNTER_EVENT_SEL_MASK, event);
 	val |= FIELD_PREP(EVENT_COUNTER_ENABLE_MASK, EVENT_COUNTER_ENABLE_ALL);

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

