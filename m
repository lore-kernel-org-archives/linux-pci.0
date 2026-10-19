Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792445485;
	b=RnrK/PwBEJxnQ9VOImOs+wT6/H0Oy58tmt5zChZGC4tPWxNJyv2r+AXyegfpHVmQoLrg
	 yiVcbsUWKAfsrX1oiIpJpnJGLrTWEkdN1LcI+wIkgivByHSxrKEkoWrorvGgt6F9f1x31
	 pa+0dKuariiHUg/1Ji1wUm6K1JWZM2l9Rs1S213OqS4xfOnD9woOcxh61CWE9eH6nRqpI
	 TuvqVP12PzBgo7iJEc5SSzshA7DDOBcj10QOoVqL/kFjT08+vT8GEuVzfNi2RrdXO9xni
	 gqGCDJhpKWLa/XXAF69Mn80sGobZGg2+iCmtBB+wzJfUjXLlPFyxnfSIMHmb2FILBLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792445485;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=OlOiZMSQAlq56d5O025wMJ9SWaeJFCSne26CemMgHno=;
	b=HBAR2FhkAD4zh/udTZi3XNATCYdENbZ3D86dl+tMzGcOVI1G1lleuouLuxhxM5PT4Hx3
	 7gKwCS1kA3pFpPibqP3KhgrFCvwyUdvD0NNMo4D9XOlawS2PKfQD3jiPdQH992SSV36g5
	 8mYTewCRxj4IYnuU0biFFXiM3cloKzjR2xDZOqbYa01rCQKcGwW9J6z6j/bTgmDDy4nf2
	 50rlTUdwTIDFMfrA3H1aZnxaydaQyqAowxfId6+1j4wWMOR7f/PIHLitd4HhbuidrEYmd
	 W2KxPHVq0K27FImJ+6kxwRtGPDbCrGuYj18dh9mahkxjXDxyJpeZNhwkFUS9H6cfVEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=cRVrNlCF;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FC4606A32D
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 21:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92FC4606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=cRVrNlCF
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e8ad8c5f80so40418555ad.0
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 14:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792445484; x=1793050284; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OlOiZMSQAlq56d5O025wMJ9SWaeJFCSne26CemMgHno=;
        b=cRVrNlCF9w/4azGXpmG9dwZuRXxSnQTSYK1LT3QO69unTOKZnx3YicN4/TwXs/Cox8
         vDBR/+QohvszWXvUxx8fuoL05UU6h4TEpVotDQeG2x3vRtGzK0hdKNOIlG70IsSPkkrC
         sUl2hdcOiv9zTd5zvBKZ+hm5P4cVcAMMQLrf/GImmSjTJrZk6q26qXqGP6SocFlgQ0JR
         1D1DzAv2LnBH6FKBUCGJGdsyHrJBqqzu6k78x4WU3fiB1QvU2XVJnIp4w8GXnatzrYm6
         DPP3femYI/qGSVOvkSALLf+3Qn/XX+HD0WeCA0dmSgr7ESz4g/nx0KDzxpOV4ONuYKqe
         blFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792445484; x=1793050284;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OlOiZMSQAlq56d5O025wMJ9SWaeJFCSne26CemMgHno=;
        b=e6TNdgw/yAWnoFYJqebPZFGsrtCUKGVfYvc+24y6/gTAOfsWQ4GhNnlu9+1seiFRM3
         jdNkKaqfNPrik91FGLheg/nvYuLoFELMqd3vSurCRmCs3L/3dtI4Y5w3U3++scTaGGzU
         wfTFaEo35jyIt6HX/Y/XFqCMd+f820oUXz/0hdFikJLh4v5YLDHsmpYsqVbm79Z0Q+Pb
         yLlA6Skj6uqljzIfLF7wK5A/q76B0aEjdJVp7kXlDQnzjgih0XfFkxwIe9I47eZtV8H7
         wfWr9F/aaIR8mSC26MFGvoVulLZzfoPEzo+c3g68E97rluR0BuaPMwGfOPjUA/wPubgN
         bP1g==
X-Forwarded-Encrypted: i=1; AKwUvBwU9n62iTnWH+WCDGX3OTxREVBwiCmFP//XaJExWq3zN4eMb04ExNQzzKcvItU4AXvBqxEdFNubWRI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIX4KkqyJ7M2J9ge4E8We+G02+nhe0wiJzO//X7vcYRD914fTb1
	1BkmifAqQSSBusAZktM7CekbcPAef1n4drtw5cYtBFEvqjiPzhNAPGCGBSNbHuSo+x+IEzcVWc/
	KKg9XqnX0KQJAYQ==
X-Received: from pllx8.prod.google.com ([2002:a17:902:7c08:b0:2e8:31af:11b0])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f607:b0:2e9:8505:5471 with SMTP id d9443c01a7336-2e9a68343d5mr79186475ad.7.1792445483766;
 Mon, 19 Oct 2026 14:31:23 -0700 (PDT)
Date: Mon, 19 Oct 2026 21:30:47 +0000
In-Reply-To: <20261019213054.3157159-1-dmatlack@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261019213054.3157159-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261019213054.3157159-4-dmatlack@google.com>
Subject: [PATCH 03/10] PCI: Factor out bridge window probing from pci_read_bridge_windows()
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	David Matlack <dmatlack@google.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Logan Gunthorpe <logang@deltatee.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Move the code that determines which windows a bridge implements, which
requires temporarily writing to the window registers, out of
pci_read_bridge_windows() and into a new helper,
pci_probe_bridge_windows(). Probe all windows before reading any of
them.

A subsequent commit will obtain which windows are implemented by bridges
preserved across Live Update from the previous kernel instead of probing
them, since probing can temporarily disable windows.

No functional change intended.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/probe.c | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 3cb2e481eddf..473e4389ffae 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -520,19 +520,14 @@ static void pci_read_bridge_mmio_pref(struct pci_dev *dev, struct resource *res,
 	}
 }
 
-static void pci_read_bridge_windows(struct pci_dev *bridge)
+/*
+ * Determine which windows @bridge implements. This requires temporarily
+ * writing to the window registers of windows that read as zero.
+ */
+static void pci_probe_bridge_windows(struct pci_dev *bridge)
 {
-	u32 buses;
 	u16 io;
 	u32 pmem, tmp;
-	struct resource res;
-
-	pci_read_config_dword(bridge, PCI_PRIMARY_BUS, &buses);
-	res.flags = IORESOURCE_BUS;
-	res.start = FIELD_GET(PCI_SECONDARY_BUS_MASK, buses);
-	res.end = FIELD_GET(PCI_SUBORDINATE_BUS_MASK, buses);
-	pci_info(bridge, "PCI bridge to %pR%s\n", &res,
-		 bridge->transparent ? " (subtractive decode)" : "");
 
 	pci_read_config_word(bridge, PCI_IO_BASE, &io);
 	if (!io) {
@@ -540,12 +535,8 @@ static void pci_read_bridge_windows(struct pci_dev *bridge)
 		pci_read_config_word(bridge, PCI_IO_BASE, &io);
 		pci_write_config_word(bridge, PCI_IO_BASE, 0x0);
 	}
-	if (io) {
+	if (io)
 		bridge->io_window = 1;
-		pci_read_bridge_io(bridge, &res, true);
-	}
-
-	pci_read_bridge_mmio(bridge, &res, true);
 
 	/*
 	 * DECchip 21050 pass 2 errata: the bridge may miss an address
@@ -582,8 +573,29 @@ static void pci_read_bridge_windows(struct pci_dev *bridge)
 		if (tmp)
 			bridge->pref_64_window = 1;
 	}
+}
+
+static void pci_read_bridge_windows(struct pci_dev *bridge)
+{
+	u32 buses;
+	struct resource res;
+
+	pci_read_config_dword(bridge, PCI_PRIMARY_BUS, &buses);
+	res.flags = IORESOURCE_BUS;
+	res.start = FIELD_GET(PCI_SECONDARY_BUS_MASK, buses);
+	res.end = FIELD_GET(PCI_SUBORDINATE_BUS_MASK, buses);
+	pci_info(bridge, "PCI bridge to %pR%s\n", &res,
+		 bridge->transparent ? " (subtractive decode)" : "");
+
+	pci_probe_bridge_windows(bridge);
+
+	if (bridge->io_window)
+		pci_read_bridge_io(bridge, &res, true);
+
+	pci_read_bridge_mmio(bridge, &res, true);
 
-	pci_read_bridge_mmio_pref(bridge, &res, true);
+	if (bridge->pref_window)
+		pci_read_bridge_mmio_pref(bridge, &res, true);
 }
 
 void pci_read_bridge_bases(struct pci_bus *child)
-- 
2.56.0.212.g129ede20d9-goog

