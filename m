Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513572;
	b=GPKatWzourUTgI1eqwFUmdDqgQEOHm4/a9Dxwo+QJWuNGj1W56tQXADG/0kh9VsBZTWR
	 xrrZd49JOn/Wa0CGVPzKuMYXvDTA4owbj4S403DinyRqkY468EQ4zY4GDN8s1nTgqqtoy
	 vrY5pHCUYuw1WyT+k+Uy/NLSHLnWdlJE6lhDW1aNKhCVYvc9YBQIGtQx5VG4uSrRo6rfE
	 YKBo1Mh2VLxY8ITMVKmefOhG+f34rwaFcRD4QBKU5RhnpuZLr1lsy/MNBNG8s85J2cXss
	 ZqQ/Att1HuayIamU6DBOMzihb91s5usIfqJKENLZM99NwqdOYZY9LlXsnttjqxWo6ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513572;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=Atyl0L6xFHCl5JPWP52B33t/L6s6DNfyIvXPWrTkJfA=;
	b=K2mRJ1u5B/y2T0diA16s3rIkDIgAEZOUiZwN+M0RyUm4vQyui8Si9JFfzmC7Nh2A1aHj
	 ug+qrGKFTUppKNw/vomfIoFyN4lCJOo/Jcmyn079WeeWwHlpPS/LPGnQdr9YCwB3Onj/O
	 J6sVKXEQFbvbvFmp6KHmxSNomkdD1oc3+cx8iDtPDvQb17bbuesJQFVSay/bf/Eh9O371
	 uihJ/7ly79owpsJAJc1BMya69wtGGI2M3fBUQmFw9LSfCSpvCzuIe4pMVSkHAiVBjVvy8
	 65IYXCgW6XW/wWtNWu8DC1Dl5pRBa3F0TKAPSM0UsLp0YQpmEsi/EJgq1Aiesoe3YyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DnDPJZho;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57592606B79A;
	Tue, 24 Nov 2026 09:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DnDPJZho
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52A51F000D1;
	Tue, 24 Nov 2026 09:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795513571;
	bh=Atyl0L6xFHCl5JPWP52B33t/L6s6DNfyIvXPWrTkJfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DnDPJZhoJrUjPNnt+UtXvXFRtcls2CVb0C0q4CF2ztro4uBquJE76Q+WbtO2sqiT8
	 y42eJ9iN3lEyPbdn1aYM5fX0PxbJo/HRpRhvTjXClhIoaLqLELPNBVe4iHvi+UlQ79
	 70pk0kgfNFqdZ8J5IxUPIQIxNhj2Ji9XQDT3QBDHyjlLo9uyaH57CzstlAX1CfJD+4
	 JQ7Gcyn7N8A3gOWr6bC8HQqLPzupoxhn1Wvb8ZDBbV7qB3XgitWvTCTCrP96Bng9DR
	 vbf6GOZftX+4DloRAiUMsfbClVk5J3nspQN4ABgX612t3AYUiuZZJPIJpF8MNGVlw6
	 geY+hRNohn6PQ==
From: Leon Romanovsky <leon@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Chris Lu <chris.lu@mediatek.com>,
	Mans Rullgard <mans@mansr.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Cornelia Huck <cornelia.huck@de.ibm.com>,
	Andrew Morton <akpm@osdl.org>,
	Jeff Garzik <jeff@garzik.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	Dan Williams <djbw@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-input@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pci@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-coco@lists.linux.dev,
	Alexey Kardashevskiy <aik@amd.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-sound@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v4 28/33] PCI: Use device trust for platform restrictions
Date: Tue, 24 Nov 2026 11:43:59 +0200
Message-ID: <20261124-device-trust-core-v4-28-037eb0d17b1f@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124-device-trust-core-v4-0-037eb0d17b1f@nvidia.com>
References: <20261124-device-trust-core-v4-0-037eb0d17b1f@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

PCI topology already identifies devices that need restricted operation.
Generic trust policy must inherit that classification so authorization
and PCI restrictions use the same policy.

Resolve discovery-time restrictions from the requested policy, since active
trust is established only before driver setup. Retain the untrusted flag
for IOMMU consumers until their conversion. The initial target is
confidential computing guests without an IOMMU; synchronizing later
authorization with IOMMU domains and ATS remains follow-up work.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../driver-api/driver-model/device-trust.rst          | 10 +++++-----
 drivers/pci/ats.c                                     |  4 ++--
 drivers/pci/pci.c                                     |  5 +++--
 drivers/pci/probe.c                                   | 19 +++++++++----------
 drivers/pci/quirks.c                                  |  7 ++++---
 include/linux/device.h                                |  5 +++++
 include/linux/pci.h                                   | 10 ++++++++++
 7 files changed, 38 insertions(+), 22 deletions(-)

diff --git a/Documentation/driver-api/driver-model/device-trust.rst b/Documentation/driver-api/driver-model/device-trust.rst
index b93426b58852d..3c6babdba80e9 100644
--- a/Documentation/driver-api/driver-model/device-trust.rst
+++ b/Documentation/driver-api/driver-model/device-trust.rst
@@ -246,11 +246,11 @@ Adversarial policy does not require an IOMMU. Without an IOMMU group, or
 with IOMMU support compiled out, binding uses the platform's normal DMA
 configuration. Adversarial policy alone does not provide DMA isolation.
 
-Device trust admission does not change DMA handling, IOMMU domain selection,
-or ATS permission according to active trust. Those remain governed by existing
-bus and platform mechanisms. Integrating them with admission is separate
-work. A setup failure after commitment leaves the chosen mode fixed; it
-cannot fall back to unrestricted.
+The initial target is confidential computing guests without an IOMMU.
+On systems with an IOMMU, policy changes after discovery are not yet
+synchronized with domain selection or ATS configuration. That integration
+is follow-up work. A setup failure after commitment leaves the chosen mode
+fixed; it cannot fall back to unrestricted.
 
 Drivers that manage DMA themselves must provide their own containment.
 Drivers that do not use DMA need no domain.
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 9cb23780093dd..c8c96acc26343 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -21,7 +21,7 @@ void pci_ats_init(struct pci_dev *dev)
 {
 	int pos;
 
-	if (pci_ats_disabled())
+	if (pci_ats_disabled() || pci_dev_default_is_restricted(dev))
 		return;
 
 	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ATS);
@@ -40,7 +40,7 @@ void pci_ats_init(struct pci_dev *dev)
  */
 bool pci_ats_supported(struct pci_dev *dev)
 {
-	if (!dev->ats_cap || dev->untrusted)
+	if (!dev->ats_cap)
 		return false;
 
 	if (dev->is_virtfn)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c6f2aba81443..a60701bdece4c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1016,8 +1016,9 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
 	/* Upstream Forwarding */
 	caps->ctrl |= (dev->acs_capabilities & PCI_ACS_UF);
 
-	/* Enable Translation Blocking for external devices and noats */
-	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
+	/* Enable Translation Blocking when ATS is unavailable or restricted. */
+	if (pci_ats_disabled() || dev->external_facing ||
+	    pci_dev_default_is_restricted(dev))
 		caps->ctrl |= (dev->acs_capabilities & PCI_ACS_TB);
 }
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9a178e0e5f7f4..606ab8a3aa8ed 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1738,24 +1738,21 @@ static void set_pcie_cxl(struct pci_dev *dev)
 
 }
 
-static void set_pcie_untrusted(struct pci_dev *dev)
+static void pci_set_default_trust_policy(struct pci_dev *dev)
 {
 	struct pci_dev *parent = pci_upstream_bridge(dev);
 
 	if (!parent)
 		return;
-	/*
-	 * If the upstream bridge is untrusted we treat this device as
-	 * untrusted as well.
-	 */
-	if (parent->untrusted) {
-		dev->untrusted = true;
+
+	if (device_policy_is_adversarial(&parent->dev)) {
+		dev->dev.trust_policy = DEVICE_TRUST_POLICY_ADVERSARIAL;
 		return;
 	}
 
 	if (arch_pci_dev_is_removable(dev)) {
-		pci_dbg(dev, "marking as untrusted\n");
-		dev->untrusted = true;
+		pci_dbg(dev, "setting adversarial trust policy\n");
+		dev->dev.trust_policy = DEVICE_TRUST_POLICY_ADVERSARIAL;
 	}
 }
 
@@ -2082,7 +2079,9 @@ int pci_setup_device(struct pci_dev *dev)
 
 	set_pcie_cxl(dev);
 
-	set_pcie_untrusted(dev);
+	pci_set_default_trust_policy(dev);
+	dev->untrusted = device_policy_is_adversarial(&dev->dev);
+	device_trust_init(&dev->dev);
 
 	/* "Unknown power state" */
 	dev->current_state = PCI_UNKNOWN;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7f1f47ea2ee41..1afad28d1b5e0 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5525,8 +5525,8 @@ static void pci_quirk_enable_intel_rp_mpc_acs(struct pci_dev *dev)
  * Currently this quirk does the equivalent of
  * PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF
  *
- * TODO: This quirk also needs to do equivalent of PCI_ACS_TB,
- * if dev->external_facing || dev->untrusted
+ * TODO: This quirk also needs to do the equivalent of PCI_ACS_TB when the
+ * device is external-facing or ATS is restricted by trust policy.
  */
 static int pci_quirk_enable_intel_pch_acs(struct pci_dev *dev)
 {
@@ -5567,7 +5567,8 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 	ctrl |= (cap & PCI_ACS_CR);
 	ctrl |= (cap & PCI_ACS_UF);
 
-	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
+	if (pci_ats_disabled() || dev->external_facing ||
+	    pci_dev_default_is_restricted(dev))
 		ctrl |= (cap & PCI_ACS_TB);
 
 	pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
diff --git a/include/linux/device.h b/include/linux/device.h
index 2914b7191d342..5c86e7a19e47b 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -933,6 +933,11 @@ static inline bool device_iommu_mapped(struct device *dev)
 	return (dev->iommu_group != NULL);
 }
 
+static inline bool device_policy_is_adversarial(const struct device *dev)
+{
+	return READ_ONCE(dev->trust_policy) == DEVICE_TRUST_POLICY_ADVERSARIAL;
+}
+
 static inline bool device_policy_is_blocked(const struct device *dev)
 {
 	return READ_ONCE(dev->trust_policy) == DEVICE_TRUST_POLICY_BLOCKED;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index aa3765a20a96c..5da9f7fabf1e5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -616,6 +616,16 @@ static inline struct pci_dev *to_pci_dev(const struct device *dev)
 {
 	return container_of(dev, struct pci_dev, dev);
 }
+
+static inline bool
+pci_dev_default_is_restricted(const struct pci_dev *pdev)
+{
+	enum device_trust_policy policy = READ_ONCE(pdev->dev.trust_policy);
+
+	return policy == DEVICE_TRUST_POLICY_BLOCKED ||
+	       policy == DEVICE_TRUST_POLICY_ADVERSARIAL;
+}
+
 #define for_each_pci_dev(d) while ((d = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)
 #define for_each_pci_dev_reverse(d) \
 	while ((d = pci_get_device_reverse(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)

-- 
2.56.1

