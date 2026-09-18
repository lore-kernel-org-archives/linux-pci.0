Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CB2492E26
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 20:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789762025; cv=none; b=ZNU3n9ex87rYV1Guzu0Sw34+p5r5eCTkWYooGjBClbIbrqbe7FjaO62M5sQb+MNdQkZOC1GTd7ReZBk6fwrPUemDMrSQmsRmOa/TiDiLiTKcvKsDQtvdhur2ykivXHNyJ5LdlVX+Lpxh0jQ/PIlphRbKACI36VsTlOyUHwVF/Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789762025; c=relaxed/simple;
	bh=Bzapy6bcJbixrqPHS2k7cavep+t2AZYH7zuQMqtEwjw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sSJhVavjZlCwnAHBZcoSrJpx65uc45ZXgPgtR9uqRFg+J29seDc0ErT4vWha3j2LRjn6CbiA0tJtdsYAaFomSg9Y5sv9+Ft2/oqvAP9RblzkSJSi/qZabZLS/Tc/yjdNJ+87dbxmdDwvMY+2B1p7KoCB9Kzvr8LHrEv8qffJfgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K7s81NnF; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K7s81NnF"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2dc92350888so18273775ad.3
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 13:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789762022; x=1790366822; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9BR71s6OXVqtI8pG8LyTaxh9Qe5FvWSAHHddp0nR9J8=;
        b=K7s81NnFcVOaUYwEZ3aobyEyUuH9Z51wNmk8TbQpytO4fLDRlRElvYqn63y3jn1LIj
         J3Jjsea+48QUP+D536Dm/uUSMtJvfqJYidsG2k248vgj5kWB6oRRmlwHnz1B4yA3f2QD
         aIfn6fnp625Jul1QRGojHLJv6lLaccPmRSFmCBjodsZsPZoAvo05Ns2YorJJn8YzeX0j
         1CiYuFvhg3mpzRUlijQMHQ9EXV9zukvmwOKFgV2X64Ju7wRHwsowP4g5B5PAXI72+PmM
         aFaJl0peBPOxWbi799mcVMVr8e8JAW3nTgLXEe+KjnUscV9NIoHcHaRl/9iWvpRwpva2
         /NtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789762022; x=1790366822;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9BR71s6OXVqtI8pG8LyTaxh9Qe5FvWSAHHddp0nR9J8=;
        b=wDSR1WWRBAOqCrDLtyqmk+SNJerQ9P+iGEikHCuFRDUmOjb78LQ1Yhf43OKwSHzgB4
         repd85HjynpnDPe1vTWJ+rpOiu5FpXVivK9hhH4i19slhmhNzbOe3cvYqVMDG7pFT+0S
         kV44ut9t6BZ30oLENwd+2rnT1IKah673lcuUDbxoVk/ePpJV0rr+IaxKumcTnHKha13b
         i7fUZNfnY6E40KnhzuN+eL6f2LD8m6AAmCf2UyqbMnLvXzZ7yqGmKCkxJOWTsC4RiwgM
         uOy1GxN8aUZTZmyozvcLdACnP6pbZugQHhhPBqbjAA6wUkC4ZBIIIfpmfG5f7U5qaBoB
         vBCw==
X-Forwarded-Encrypted: i=1; AKwUvByQLbwUjBmJkH7fma6PL4AIUPlonyv2Fu92OptOxRs5EIuA7lsMqVpz6Rjvg9cmJ3OtJWuvmhewvVc=@vger.kernel.org
X-Gm-Message-State: AFuF++kFuMhSc/xyYzQKOJXqvCYiLLDnWVXE4hFpUmTk09Ma/M84f6BL
	hZNa2I5atUXYkMw8Bu8PJq1rHbO9S4x+5q/5W2nYj/+EWLlldYEVA7J0DyUYzJE7c6nwh4eOMBo
	zfRr71vA3gsR/eQ==
X-Received: from pldv5.prod.google.com ([2002:a17:902:ca85:b0:2d9:e5f:1d26])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ab8f:b0:2dd:c100:a5ea with SMTP id d9443c01a7336-2ddc100a6aemr7241285ad.62.1789762021877;
 Fri, 18 Sep 2026 13:07:01 -0700 (PDT)
Date: Fri, 18 Sep 2026 20:06:36 +0000
In-Reply-To: <20260918200640.887030-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918200640.887030-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918200640.887030-11-dmatlack@google.com>
Subject: [PATCH v9 10/13] PCI: liveupdate: Adopt ARI Forwarding Enable on
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
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

Adopt the ARI Forwarding Enable bit on preserved bridges and update
pci_dev->ari_enabled accordingly during a Live Update. This ensures that
the preserved devices on the bridge's secondary bus can be identified
with the same expanded 8-bit function number after a Live Update.

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 30 ++++++++++++++++++++++++++++++
 drivers/pci/liveupdate.h |  6 ++++++
 drivers/pci/pci.c        |  8 +++++++-
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 0145399b3834..3c9a10a892fc 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -189,6 +189,10 @@
  *    way after Live Update and ensures that IOMMU groups do not change. Note
  *    that a device will use its adopted ACS controls for the lifetime of its
  *    struct pci_dev (i.e. even after pci_liveupdate_finish()).
+ *
+ *  * The PCI core adopts ARI Forwarding Enable on all bridges with downstream
+ *    preserved devices to ensure that all preserved devices on the bridge's
+ *    secondary bus are addressable after the Live Update.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -904,6 +908,32 @@ int pci_liveupdate_adopt_acs(struct pci_dev *dev)
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
index d4721ffcecb2..90b2754ecc0c 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -16,6 +16,7 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev);
 bool pci_liveupdate_preserve_bus_numbers(void);
 bool pci_liveupdate_refuse_bus_numbers(struct pci_bus *bus, struct pci_dev *dev);
 int pci_liveupdate_adopt_acs(struct pci_dev *dev);
+int pci_liveupdate_adopt_ari(struct pci_dev *dev);
 #else
 static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
@@ -40,6 +41,11 @@ static inline int pci_liveupdate_adopt_acs(struct pci_dev *dev)
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
index 47d8229115b8..0ae405b86b2f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3625,7 +3625,7 @@ void pci_configure_ari(struct pci_dev *dev)
 	u32 cap;
 	struct pci_dev *bridge;
 
-	if (pcie_ari_disabled || !pci_is_pcie(dev) || dev->devfn)
+	if (!pci_is_pcie(dev) || dev->devfn)
 		return;
 
 	bridge = dev->bus->self;
@@ -3636,6 +3636,12 @@ void pci_configure_ari(struct pci_dev *dev)
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
2.55.0.1082.g2b9226bbc0-goog

