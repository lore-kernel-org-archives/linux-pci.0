Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793230619;
	b=3ldmpsSpM4VeFo/+J4yQRI1VCmWLEfPr/AHWkNOQ9cTVZ93SWS0T0UPSHOfrgsvZrIv6
	 nONbJQiL+/buZEVv+1byiJU7ap9r5kCddgn6ENIMRlK7EAiz+Scdgk4UlOXfHvJeK7GLD
	 KdHSU0mAFZnv3s0tW4lzYBue7BNeMAQ7l//97zSKxTjtIGPa6TzpAgax4xwp2bRBOQ1tr
	 rN56x4g+ttn+EyJLTKs4hhm3A/DkuQO12JJzshXOKHzEAeRXeh17yrQhIzaX5Dyxn8O+9
	 HAFVat+e3lCPK0FywhPZ5ofPT/FeyyuaMNyA2PyYCPw+4IjBEYbgyImxREeg9g1rhjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793230619;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=P5uccmtD7uHPZQe6RVP+drkPGR4BqjMdb1TsK1mrYKs=;
	b=q/UgHA4xdeKAxZYeTWEDFdCy6VlQYOyKwH7cczU2tRqZ4L63Y9YuRlr9aCexJbF4HtKD
	 XOthv7iSIAKUxERDEX5RPWMphezaKYNRdgOZMCIAeBmRYO/4BFkcj2C4WRvX3SKKnJWpG
	 ZRCPDe0yYdrQYE7toQPs6J1e6zIJVWOE6/OavymVjZ39Z1RsUH5jU7iHsc8aqitFuibbm
	 gamfOF1FDOCebto9exdcESSbSiQvFEBfG4vqKaY2qPdrnQjtmzHIvcZd4nAxZcTza0hVj
	 9rrSXvSR4eOTIihwLP9mi2Ov2mhXuSww1MYngNTDmaJ5pZnuErfKjDFxIpY0szHnLsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--digonzal.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DqTpdMrh;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EA9606A31C
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 23:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28EA9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--digonzal.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DqTpdMrh
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36a223755e4so4944348eec.0
        for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 16:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793230618; x=1793835418; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P5uccmtD7uHPZQe6RVP+drkPGR4BqjMdb1TsK1mrYKs=;
        b=DqTpdMrhb0gEPsgQr3kzA70KsY5CM5R4tu7PrqohQzszSTeM3bkQ/YFraJl0UiZi9T
         qcGIBxV8DUMeyw9zh+Pm9fAIEV0e3tO6beBRPBwiqv2cekESp9sheTY+a27bEhbEb+rd
         W7SEJ+jFRjRMjJow8yQ/mZa7fka+pyW24D8gpn+TlPmE8+nTIrtf3mSVtLnyyr/lR6R1
         vP0+QJaG4Vby/ZMWeNaldKqfMJcNrrnWVQhj3t/ZzFCMf2vLmVYyQb3c0ihP7Gk+KQuj
         Wxe8RRBlPbk7zx7GB0+4bN2vuebAZZbFZU4exzNhilpa5kZ5invRJ8mEBrIffYgkMj1P
         rMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793230618; x=1793835418;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P5uccmtD7uHPZQe6RVP+drkPGR4BqjMdb1TsK1mrYKs=;
        b=22rFe+dX9N5jipYgG60Hl1PkQtNLkFFN8SSKnXehrVL9QTx/HBEjCynLOAxKOA2V5R
         V89AIsHjseP+1BaYRjP8F/eG5wBS8pbmTe3/mnwLxy6cylZ9gVcVvOAf3jr/ni6POPdT
         Jw/Ld7Fs5aDrc2V6wJQfeU/35FfqSCpBWKy9M9mLtxjA4mpecLvD31sDiwUmxN/0VL1J
         5+jmjdgVMNSxYcC/luZm73zGA7TdlnioPlqrCHCskyDRTU1swU6SUIMiMnsG3ye5Eun+
         jEDqRCfC0HKmE6NURl+cnqk2c8aiGvNB2Wt9wthiOk57bg6s8NL1dPhTjekYNH5FawB9
         dsJg==
X-Forwarded-Encrypted: i=1; AKwUvBxRYS/eD58uQAUEVmrsmnhDaiH4UHjUp3M4F3hO9oOhVCzQBTiplxTAKy+nMOw6DnpD7t3wm8TxCJ8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKILj6NnJ3yunQ752E062eNjBBeMTM7RrTng4c6TIrIw0boIC4P
	H82/Jy07p57G1DXqj8OHoIOxQAGrETAS2WwJKZB3ikdlN5OfXGxeoFsYcc5r8M82+Ui7bC0TxiZ
	o9L/jIQgD3rIxYw==
X-Received: from dycui21.prod.google.com ([2002:a05:693c:6015:b0:353:7f27:8a45])
 (user=digonzal job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:60c6:b0:369:fd32:79fe with SMTP id 5a478bee46e88-36a203cd26cmr5864269eec.17.1793230617856;
 Wed, 28 Oct 2026 16:36:57 -0700 (PDT)
Date: Wed, 28 Oct 2026 23:36:51 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261028233651.960835-1-digonzal@google.com>
Subject: [PATCH v2] PCI/ATS: Disable ATS when ACS TB is set upstream
From: Danny Gonzalez <digonzal@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Decotigny <decot@google.com>, Sheena Mohan <sheenamo@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Danny Gonzalez <digonzal@google.com>
Content-Type: text/plain; charset="UTF-8"

Enabling ATS allows an endpoint to cache translations and initiate DMA
requests with Translated addresses, which an upstream bridge with ACS
Translation Blocking (PCI_ACS_TB) set will block as ACS Violations.
Because pci_enable_acs() preserves existing PCI_ACS_CTRL bits (e.g., from
firmware, a kexec kernel, or "pci=config_acs=") without relaxing them,
PCI_ACS_TB may remain set on upstream bridges.

Add pci_ats_check_acs() and call it from pci_dma_configure() after
pci_enable_acs() to walk upstream bridges and clear dev->ats_cap if any
bridge has PCI_ACS_TB enabled, leaving the endpoint to use Untranslated
addresses.

Tested by booting a machine with an endpoint advertising the ATS Capability
behind a Root Port with PCI_ACS_TB set; verified ATS is disabled and the
system boots cleanly.

Signed-off-by: Danny Gonzalez <digonzal@google.com>
---

v2 (based on sashiko review):
 - Move the upstream ACS TB check from pci_ats_supported() into
   pci_ats_check_acs() called after pci_enable_acs()
 - Use pci_acs_enabled() instead of reading PCI_ACS_CTRL directly

 drivers/pci/ats.c        | 20 ++++++++++++++++++++
 drivers/pci/pci-driver.c |  1 +
 drivers/pci/pci.h        |  2 ++
 3 files changed, 23 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 9cb23780093d..0395612f3987 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -31,6 +31,26 @@ void pci_ats_init(struct pci_dev *dev)
 	dev->ats_cap = pos;
 }
 
+void pci_ats_check_acs(struct pci_dev *dev)
+{
+	struct pci_dev *bridge;
+
+	if (!dev->ats_cap || dev->is_virtfn || dev->ats_stu)
+		return;
+
+	/* Do not allow ATS if any upstream bridge blocks translation */
+	for (bridge = pci_upstream_bridge(dev); bridge;
+	     bridge = pci_upstream_bridge(bridge)) {
+		if ((bridge->acs_capabilities & PCI_ACS_TB) &&
+		    pci_acs_enabled(bridge, PCI_ACS_TB)) {
+			pci_warn_once(dev, "ATS disabled: upstream bridge %s has ACS Translation Blocking enabled\n",
+				 pci_name(bridge));
+			dev->ats_cap = 0;
+			return;
+		}
+	}
+}
+
 /**
  * pci_ats_supported - check if the device can use ATS
  * @dev: the PCI device
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index e16aa59dd7ac..9a1856def5bd 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1713,6 +1713,7 @@ static int pci_dma_configure(struct device *dev)
 	 * quirks.
 	 */
 	pci_enable_acs(to_pci_dev(dev));
+	pci_ats_check_acs(to_pci_dev(dev));
 
 	pci_put_host_bridge_device(bridge);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ba3c3fddddc2..cf2c93761d81 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -961,9 +961,11 @@ static inline void pcie_walk_rcec(struct pci_dev *rcec,
 #ifdef CONFIG_PCI_ATS
 /* Address Translation Service */
 void pci_ats_init(struct pci_dev *dev);
+void pci_ats_check_acs(struct pci_dev *dev);
 void pci_restore_ats_state(struct pci_dev *dev);
 #else
 static inline void pci_ats_init(struct pci_dev *d) { }
+static inline void pci_ats_check_acs(struct pci_dev *d) { }
 static inline void pci_restore_ats_state(struct pci_dev *dev) { }
 #endif /* CONFIG_PCI_ATS */
 
-- 
2.56.0.313.g2479322e68-goog

