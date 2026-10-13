Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4D451C057
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791908748; cv=none; b=LpncMdWJJjgCX0emq/y1P+vxHKE2G+6E5EkLTolF0MN/iBvhgGna8NxpaFrm+riEpr88aHkIzLzGjm4G10x5as0PwpICp0AlSwRgvfJPrqCbFaaNmbCdkGHLiqIRTyJXskGT0Tsnfd7G8jxxVDzERr9q+g5v1g5rSS3GO9969qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791908748; c=relaxed/simple;
	bh=pRK/S9Ha9T/f2Rc2+jytr6ZJUdBm0CMIFhq8yvVR348=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I0BxBmfD5IlKM9rMR12MwQ46P7NqHKEa4GeYp+38wPDqAkLneWfaKnGhOAPogUxis27u1CS6Oxttopdq7HLBu5vZNUwDJbNJmql6t7Qpk1u48j4xlHVays/23sGn9mz8/kwGtfh38I2o3twSCB1ox8d9XYNYlJshIWwfw7amn5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EgXBda1P; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EgXBda1P"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e827b3a6b4so46955355ad.2
        for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 09:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791908744; x=1792513544; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xeOaWY8G0RyJWpiIZt4rGXklqrMOz8YRWSRZ+Jyg5IA=;
        b=EgXBda1P31pDucPHDAHr1wJzOKOZv1E39m5Zvu+zRgeFMWiXR7VIxB5D5X+FBWszsa
         eg4k2TwssATwWmrh9cAt4ldn2MgBPYtW+POmEcLe9AGCIK87Qj0eCqCI1pky6a0yLlWE
         fL99iQHkx/qB1Uri2wD+Wc/cT4FXQ/agMeL0xTAS7GwLmamK4o1q51RTkn+nInihGo5l
         63R2mi6sEIE3b4+pHyHdkkH6bIkZ//r4StKu9+yprPcjWlu3z540tWSOYnAoC2pEKM0z
         yV4GROVz24Atc1elL5w8B4bQ2y7VlUs2sJlW6J9iswZWFckdPiMKbOgMREOq+gnMU1yV
         iC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791908744; x=1792513544;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xeOaWY8G0RyJWpiIZt4rGXklqrMOz8YRWSRZ+Jyg5IA=;
        b=P8kHiq9eucyz9AMfoRRY8YzoKOy926jwEfrZQC5NCZZlXxqAyady4Uiax/DriLLMe1
         v00gQ8C8++iBSJtKG5Ofn3WnAS8Ds6sNT0B4tCG4nt68TGminLAXeIZjFFF3RZwe9p24
         bmcpvnS1ewceYgSki4iAH5c3c/tJ49/PdmIhaGTEeKrADFdFsMFm48tE0dQAdaVfoIf0
         0XBwik/4NYAkWARWGqJR4DMx4X7tsTzYf3UyBw8e9icLKp+92qsbPQQ1NsdGN69v+g5B
         WGaq2fyyw0quvZiltNLg29W3+C0D3GZlXY2gJTpf7oMvk0OXX+hOssI0/mODURKAkFpa
         Q87Q==
X-Forwarded-Encrypted: i=1; AKwUvBzJMJ2EdRp4+d3aox2DV30HjGxlVqrkmdcA8T0Tw7OySmxiSq05opAjfqAJ7CKMX5zjq2ZaqoU0jLY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLDLK2UDwL1Wk6YEPuwyTSH33pc4WqvMtRcfM3FXVtkzI8inh05
	IUgZiCAUcGuAaxHbRRvXlC8oRGiJYpwW7YaIZ3D0R259WVq46NBXnJ93qn1pGtd5Uy3FbL9B2bh
	bfwYrhLJugdPFcA==
X-Received: from pllt11.prod.google.com ([2002:a17:902:dccb:b0:2e5:b835:73c5])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:41d2:b0:2e4:cc75:2707 with SMTP id d9443c01a7336-2e84280e7a2mr118758025ad.7.1791908743529;
 Tue, 13 Oct 2026 09:25:43 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:25:23 +0000
In-Reply-To: <20261013162529.1928093-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013162529.1928093-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013162529.1928093-8-dmatlack@google.com>
Subject: [PATCH v10 07/13] PCI: Refactor matching logic for pci_dev_acs_ops
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

Refactor the logic to match devices to pci_dev_acs_ops by factoring out
the device matching loop into its own routine, pci_dev_acs_ops_get().
This eliminates duplicate code between pci_dev_specific_enable_acs() and
pci_dev_specific_disable_acs_redir(), and will also be used in a
subsequent commit to check if a device requires device-specific
enable_acs() during a Live Update.

No functional change intended.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/quirks.c | 51 ++++++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index de9bbccda21f..7aee30734303 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5377,9 +5377,6 @@ static void pci_quirk_enable_intel_rp_mpc_acs(struct pci_dev *dev)
  */
 static int pci_quirk_enable_intel_pch_acs(struct pci_dev *dev)
 {
-	if (!pci_quirk_intel_pch_acs_match(dev))
-		return -ENOTTY;
-
 	if (pci_quirk_enable_intel_lpc_acs(dev)) {
 		pci_warn(dev, "Failed to enable Intel PCH ACS quirk\n");
 		return 0;
@@ -5399,9 +5396,6 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 	int pos;
 	u32 cap, ctrl;
 
-	if (!pci_quirk_intel_spt_pch_acs_match(dev))
-		return -ENOTTY;
-
 	pos = dev->acs_cap;
 	if (!pos)
 		return -ENOTTY;
@@ -5429,9 +5423,6 @@ static int pci_quirk_disable_intel_spt_pch_acs_redir(struct pci_dev *dev)
 	int pos;
 	u32 cap, ctrl;
 
-	if (!pci_quirk_intel_spt_pch_acs_match(dev))
-		return -ENOTTY;
-
 	pos = dev->acs_cap;
 	if (!pos)
 		return -ENOTTY;
@@ -5451,56 +5442,56 @@ static int pci_quirk_disable_intel_spt_pch_acs_redir(struct pci_dev *dev)
 static const struct pci_dev_acs_ops {
 	u16 vendor;
 	u16 device;
+	bool (*match)(struct pci_dev *dev);
 	int (*enable_acs)(struct pci_dev *dev);
 	int (*disable_acs_redir)(struct pci_dev *dev);
 } pci_dev_acs_ops[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
+	    .match = pci_quirk_intel_pch_acs_match,
 	    .enable_acs = pci_quirk_enable_intel_pch_acs,
 	},
 	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
+	    .match = pci_quirk_intel_spt_pch_acs_match,
 	    .enable_acs = pci_quirk_enable_intel_spt_pch_acs,
 	    .disable_acs_redir = pci_quirk_disable_intel_spt_pch_acs_redir,
 	},
 };
 
-int pci_dev_specific_enable_acs(struct pci_dev *dev)
+static const struct pci_dev_acs_ops *pci_dev_acs_ops_get(struct pci_dev *dev)
 {
 	const struct pci_dev_acs_ops *p;
-	int i, ret;
+	int i;
 
 	for (i = 0; i < ARRAY_SIZE(pci_dev_acs_ops); i++) {
 		p = &pci_dev_acs_ops[i];
 		if ((p->vendor == dev->vendor ||
 		     p->vendor == (u16)PCI_ANY_ID) &&
 		    (p->device == dev->device ||
-		     p->device == (u16)PCI_ANY_ID) &&
-		    p->enable_acs) {
-			ret = p->enable_acs(dev);
-			if (ret >= 0)
-				return ret;
+		     p->device == (u16)PCI_ANY_ID)) {
+			if (!p->match || p->match(dev))
+				return p;
 		}
 	}
 
+	return NULL;
+}
+
+int pci_dev_specific_enable_acs(struct pci_dev *dev)
+{
+	const struct pci_dev_acs_ops *p = pci_dev_acs_ops_get(dev);
+
+	if (p && p->enable_acs)
+		return p->enable_acs(dev);
+
 	return -ENOTTY;
 }
 
 int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
 {
-	const struct pci_dev_acs_ops *p;
-	int i, ret;
+	const struct pci_dev_acs_ops *p = pci_dev_acs_ops_get(dev);
 
-	for (i = 0; i < ARRAY_SIZE(pci_dev_acs_ops); i++) {
-		p = &pci_dev_acs_ops[i];
-		if ((p->vendor == dev->vendor ||
-		     p->vendor == (u16)PCI_ANY_ID) &&
-		    (p->device == dev->device ||
-		     p->device == (u16)PCI_ANY_ID) &&
-		    p->disable_acs_redir) {
-			ret = p->disable_acs_redir(dev);
-			if (ret >= 0)
-				return ret;
-		}
-	}
+	if (p && p->disable_acs_redir)
+		return p->disable_acs_redir(dev);
 
 	return -ENOTTY;
 }
-- 
2.56.0.385.gd3acb90ef8-goog

