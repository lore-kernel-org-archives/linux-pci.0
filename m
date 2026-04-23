Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1783C343E
	for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 21:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776979422; cv=none; b=aDdj8pmzMB2jisu5NejAwHtbgn7bLCKhnvTqyrLfw0CvvlxL0y/H0fLKmfJKaE0LJqWnC59cA3B25M4EI6omA5c8r/4g05EN/4X2wnlwjGasBPU/TsbSZXzPckiME/BXaUuE/tteAAYM2evN/WCOzE13bperyToVFCKqfjKL8DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776979422; c=relaxed/simple;
	bh=85D2Ac3hBoG1dFzFVA37bHIGBGx9gipkQcKVvZXkhV0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ct60PuO+0J5ONqdCGYIjTB4+thrctGLo3A1MB3jdvKSeuhb+C/xL39rhUiVDldIv4lp9RfyDSyGbloStYFInAbAHc5d3zWZA8b74HaHIlM44KvKnMZQk0I7TKg7I+pm5fTtNWb2nyjygrA1pVCBoiENHV+3NFQLWdXBV8khHvjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WftHepeb; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WftHepeb"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b24af7ca99so96472715ad.1
        for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 14:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776979416; x=1777584216; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E/PZfm0ILlaeTWExhdrHJ+nS/9VkLe0d8hpRsDexX1A=;
        b=WftHepebeGrtlnGFv1eTN7gbQTxf65Be0pW2b6TIYxRpTxGkTQ+I0XcccEZXLPTcyz
         DPxyUxv8OsvX2MyW2vlljWc+Q3/fQFKhHAZqUjHvI0LPoTmYcLvLflgzq1ogKS6aaWf9
         g8v4Bm29KZf7+IUzwodjsRaNecxSXBmQMf4qJ7GD9n+cqkTn9j0Hw4AkHMdhwXcKK6Iv
         PmlVxQX3oD+GuMJG26POAs9yNa2X/P8LlaDwNz1B65ZOknndB0rUaG8iUpPWWyGRoJlY
         47amll8l/Exvo+UHTiy8s7J1NOO0PvD+aY7jz+eJacalsrMkWtE5XeQ5xJwTZp64Hv56
         XqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776979416; x=1777584216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/PZfm0ILlaeTWExhdrHJ+nS/9VkLe0d8hpRsDexX1A=;
        b=oKBpY0D2A2NTPYHbbcz8P+0f4xYNd92s2NyVR9r+XdhMIh73/0yba2UbhyvnGO0SDU
         mHYby3qR1Z2tybMXL80av+jcyOWnG3raiPHamGZVC8CiPx8nrB/LvX6SWMMNFHWDCepL
         ia7y1lM98j1wtQhdepp/7Zl/jlpATtuVtflja8EXNFdTGYmqNFKN/42fukxeExvcnja6
         oslWGp684mhE7LoowsCP5GCoKTQewuTGFKKnHrcmk+1B+9Gx6iSuqrhTS6YOXAll55Ri
         Y+JbCxh4irEkhmuEd9tPlzusvOwqYk3KmcmXgSC4mHT0fkqVOhJGWdg/2lR1gqOPWRZg
         Nmcg==
X-Forwarded-Encrypted: i=1; AFNElJ+EZugTvBtFyigMcxQrAVTmbqS6wSM1OvsDHgnmxjMm4rsriSh2dXQDbQU9ZLtUtoihmC0kwmkoMwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMrLLxQkFNOko7RPvfYx/lG55cXPJcP30+uEJ6Sf/CGya/l/J9
	dbuBOFDh7W3TzQDXc6+fru2tGaoYXJJ8yDPYPnhbRPrkZPjl5ghm8nxf+FU5f93ofaS88FluzJp
	u7rL+Vbgut8vhMA==
X-Received: from plav22.prod.google.com ([2002:a17:902:f0d6:b0:2b0:5380:49f1])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1a88:b0:2b2:5ec6:dcf6 with SMTP id d9443c01a7336-2b5f9e85f20mr294713095ad.8.1776979415642;
 Thu, 23 Apr 2026 14:23:35 -0700 (PDT)
Date: Thu, 23 Apr 2026 21:23:13 +0000
In-Reply-To: <20260423212316.3431746-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260423212316.3431746-10-dmatlack@google.com>
Subject: [PATCH v4 09/11] PCI: liveupdate: Inherit ARI Forwarding Enable on
 preserved bridges
From: David Matlack <dmatlack@google.com>
To: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

Inherit the ARI Forwarding Enable on preserved bridges and update
pci_dev->ari_enabled accordingly during a Live Update. This ensures that
the preserved devices on the bridge's secondary bus can be identified
with the same expanded 8-bit function number after a Live Update.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c |  4 ++++
 drivers/pci/pci.c        | 12 +++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 54a90ff02bdd..25c86cd4c173 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -128,6 +128,10 @@
  *  * The PCI core inherits all ACS flags enabled on incoming preserved devices
  *    rather than assigning new ones. This ensures that TLPs are routed the same
  *    way after Live Update and ensures that IOMMU groups do not change.
+ *
+ *  * The PCI core inherits ARI Forwarding Enable on all bridges with downstream
+ *    preserved devices to ensure that all preserved devices on the bridge's
+ *    secondary bus are addressable after the Live Update.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e615b7c3e430..b45539c55c7d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3498,8 +3498,9 @@ void pci_configure_ari(struct pci_dev *dev)
 {
 	u32 cap;
 	struct pci_dev *bridge;
+	u16 val = 0;
 
-	if (pcie_ari_disabled || !pci_is_pcie(dev) || dev->devfn)
+	if (!pci_is_pcie(dev) || dev->devfn)
 		return;
 
 	bridge = dev->bus->self;
@@ -3510,6 +3511,15 @@ void pci_configure_ari(struct pci_dev *dev)
 	if (!(cap & PCI_EXP_DEVCAP2_ARI))
 		return;
 
+	if (pci_liveupdate_incoming(bridge)) {
+		pcie_capability_read_word(bridge, PCI_EXP_DEVCTL2, &val);
+		bridge->ari_enabled = !!(val & PCI_EXP_DEVCTL2_ARI);
+		return;
+	}
+
+	if (pcie_ari_disabled)
+		return;
+
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI)) {
 		pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
 					 PCI_EXP_DEVCTL2_ARI);
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

