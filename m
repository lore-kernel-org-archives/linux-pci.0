Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D01647604B
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 22:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785276637; cv=none; b=VHdJUC9ge4+INZ931NAKykzFxqZPOqi6dmW6oyc2kOw3vqJE34l9b2LCPwalqcWMhAGwGLkpVfXT+8N6HnxQd83VlA2bXmUn1hNqH6bEn8tY85M7x2W31YgV7mvWmX81jLhv7Ot+KbAGP73g+OIzdfK6M/+omAy/9tw1WZKzTHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785276637; c=relaxed/simple;
	bh=csbyjjA2KjKhgr5ujOtbJqKY6LzOTF83Qklit7gcOmg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IhleDf7XFhSNuT+tAITR3OAWRzxm/WHN/j/UoJ3FI+AijUtVh0N94hgtA+C3fDfiXG5+WRkr5KwrBhLrIleBJLB1Tt0sMx4wNYoO/7/9vR/73QnK2AE7c1M+gwN0d/ZXv5C0WHro55D58moHl7WJSRzV0DHeG31W3Bmjbp0tKxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rLY3UFdZ; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rLY3UFdZ"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d001671a54so6967315ad.2
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 15:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785276629; x=1785881429; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wIyl1z6VbEjbpTwDm7dyBOXwnjYP7h00s7jMGOKLSmY=;
        b=rLY3UFdZrM9yMKEzkWIfWyaTAaCxnh6JNyeYQzolF3ZKIh1XZfvdJ80Mvsefn4Ps/a
         YLTcqzmIzENAzRtMyTob8QlepxxWdbU03vZgxZnPo4NztgL7l4SAWqs/AxZ85hGwOoUP
         wW7IoojgBpX/RF7PpXigIOmTU5tml1bUuBGdI32ZmvKjngnVOuNOHAxL8Hhc6T3eU4Av
         VJw09N2bTym0Q5FT3p9FkUNTvC+QnTsoipz6M/5ReOeQPdHr9sxDRn0DYJsrFA/R8tKd
         lqN9IrvOFJFPVHrx6wMGy8fFtVKdZpohD3Qr9ZKnqRXEqqYB7y7Tf3Kp4vmQa0D/A8iJ
         Ia1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785276629; x=1785881429;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wIyl1z6VbEjbpTwDm7dyBOXwnjYP7h00s7jMGOKLSmY=;
        b=byYKO+Bbsh0r2m6ZE26tMm9Rz49xwyU6hquvTCdAvBUsaFj1CDNW/Lcuh+ncznWRBD
         F5YHdjIa963mzA/Qbj/6mZDLc1DjpG5hqorpaqMBHIZcAzdtknTmgEB5PIiw3gWBI9N7
         fVlJ79uJBD28Pr+JT1bpL1f4Sy+CbLCQuuYM8t1TqPVxbdceKIGoTYh99z9UoMz5kn47
         m6LPkFmQbjjosj2OyZqLEZb6bgV2gGvD1e0OUTNA68h8xxN3p1unAGxSx4TKrjhJmGIr
         vxJa1unhFmAi/+CsBlw30wSg8QvoveJd5mttJXi8uRg7ezzxKr44lvAHYww0lnAtwGfA
         EuNw==
X-Forwarded-Encrypted: i=1; AHgh+Rqq7WTZrDLy1I36ILzCT4pivfac13TKA3jQwlaeKVAplvdTA5S6+VXjlH1ZLmWm8QzE2tw1erLWGEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvok7Lx2kmMwDlZAomaltd+F4o1Hlx/3vmSbnqjmJS66GX2ous
	X7k2eueOnaDJi/R+htfnc3/w1fvZUJDGx33StCGASYF+kTmfcpoH+NEj8/MT/wwgd7rttHNPO9J
	U8yjekjWw1sS34g==
X-Received: from pgbcp14.prod.google.com ([2002:a05:6a02:400e:b0:c96:c217:cd27])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3993:b0:3c0:9c19:65a8 with SMTP id adf61e73a8af0-3c8ba62a17dmr5198004637.64.1785276628580;
 Tue, 28 Jul 2026 15:10:28 -0700 (PDT)
Date: Tue, 28 Jul 2026 22:10:03 +0000
In-Reply-To: <20260728221007.2098560-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728221007.2098560-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
Message-ID: <20260728221007.2098560-10-dmatlack@google.com>
Subject: [PATCH v8 09/12] PCI: liveupdate: Adopt ARI Forwarding Enable on
 preserved bridges
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
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

Adopt the ARI Forwarding Enable bit on preserved bridges and update
pci_dev->ari_enabled accordingly during a Live Update. This ensures that
the preserved devices on the bridge's secondary bus can be identified
with the same expanded 8-bit function number after a Live Update.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 30 ++++++++++++++++++++++++++++++
 drivers/pci/liveupdate.h |  6 ++++++
 drivers/pci/pci.c        |  8 +++++++-
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index fb602dd3933e..744513ee11ed 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -128,6 +128,10 @@
  *    way after Live Update and ensures that IOMMU groups do not change. Note
  *    that a device will use its adopted ACS controls for the lifetime of its
  *    struct pci_dev (i.e. even after pci_liveupdate_finish()).
+ *
+ *  * The PCI core adopts ARI Forwarding Enable on all bridges with downstream
+ *    preserved devices to ensure that all preserved devices on the bridge's
+ *    secondary bus are addressable after the Live Update.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -833,6 +837,32 @@ int pci_liveupdate_enable_adopted_acs_controls(struct pci_dev *dev)
 	return 0;
 }
 
+/**
+ * pci_liveupdate_adopt_ari() - Adopt ARI configuration
+ * @dev: The PCI device to adopt ARI configuration for
+ *
+ * For devices preserved across a Live Update, read the ARI state from
+ * hardware and adopt it. This ensures the device continues to use the ARI
+ * configuration established by the previous kernel.
+ *
+ * Return: 0 on success, or -EINVAL if the device was not preserved.
+ */
+int pci_liveupdate_adopt_ari(struct pci_dev *dev)
+{
+	u16 val;
+
+	guard(rwsem_read)(&pci_liveupdate.rwsem);
+
+	if (!dev->liveupdate.incoming)
+		return -EINVAL;
+
+	pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &val);
+
+	/* Safe to modify dev->ari_enabled bitfield during enumeration. */
+	dev->ari_enabled = !!(val & PCI_EXP_DEVCTL2_ARI);
+	return 0;
+}
+
 /**
  * pci_liveupdate_is_incoming() - Check if a device is incoming-preserved
  * @dev: The PCI device to check
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index ac5b8bf2edf5..ccc23031e99d 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -18,6 +18,7 @@ bool pci_liveupdate_preserve_bus_numbers(struct pci_bus *bus,
 void pci_liveupdate_scan_bridge_end(struct pci_dev *dev);
 void pci_liveupdate_cache_adopted_acs_controls(struct pci_dev *dev);
 int pci_liveupdate_enable_adopted_acs_controls(struct pci_dev *dev);
+int pci_liveupdate_adopt_ari(struct pci_dev *dev);
 #else
 static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
@@ -45,6 +46,11 @@ static inline int pci_liveupdate_enable_adopted_acs_controls(struct pci_dev *dev
 {
 	return -EINVAL;
 }
+
+static inline int pci_liveupdate_adopt_ari(struct pci_dev *dev)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif /* DRIVERS_PCI_LIVEUPDATE_H */
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 22001bdf4c97..6922f361a89e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3528,7 +3528,7 @@ void pci_configure_ari(struct pci_dev *dev)
 	u32 cap;
 	struct pci_dev *bridge;
 
-	if (pcie_ari_disabled || !pci_is_pcie(dev) || dev->devfn)
+	if (!pci_is_pcie(dev) || dev->devfn)
 		return;
 
 	bridge = dev->bus->self;
@@ -3539,6 +3539,12 @@ void pci_configure_ari(struct pci_dev *dev)
 	if (!(cap & PCI_EXP_DEVCAP2_ARI))
 		return;
 
+	if (!pci_liveupdate_adopt_ari(bridge))
+		return;
+
+	if (pcie_ari_disabled)
+		return;
+
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI)) {
 		pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
 					 PCI_EXP_DEVCTL2_ARI);
-- 
2.55.0.487.gaf234c4eb3-goog

