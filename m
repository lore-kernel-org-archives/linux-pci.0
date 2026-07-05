Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662D0363089;
	Sun,  5 Jul 2026 22:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783289322; cv=none; b=p+wqAHpM8ojyCC3bqWO2Cs3w2hLfHBvGzD1QoUoK9tfHB0wkZ/uHazqpoe14413VX3O85qcZ3AicPWfMbWWukes1t42WZ6ASvwbLISc7DEtu02p5wXI6IPYEUtghWHU7OV+gWQ69s4gmlpuFgv6O8Dp/Aa5PAPKwSd3RvlQQiic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783289322; c=relaxed/simple;
	bh=+HNqPWVqubCeSOKv/foAEgfrMqZalETm9S3ZqNTqq9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ryW01f5NLUCh1EehZ783HYsG3o1yAfcqGVA/mM+tPxr/400FpC38O1B6rQQmGe86MIFgcKrJoW/mBGOEc24T9lGIYctcRdRlt6wsvkN5R/jAKRd42TGtzKvHKV4n0PsIIl3woG7J2gW2P1BJUPA7Kc0pPErH+9oF7vECgGZLLzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQ7VpEDt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQ7VpEDt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E366F1F000E9;
	Sun,  5 Jul 2026 22:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783289321;
	bh=n8UEdTfsV3O4My9Q0QmDdxEASFKYa/om2nhy1shBYsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CQ7VpEDt0HTHy6+NZpTLIHpeeJGrx3ki9USgabrzUjbu5NyYYDN/8yVgb1IIhsvMr
	 xQl1+1H1ViyV0Klj4YJynaAXXAA6NosBVwzzSf2NSFAk3fZFlSNCvx7RH0GxWG3X5m
	 2mDkRDHRc8N/knwJLys6Qccuyvc4oB1LUZOIkFDYnn5FQ6YnBVHMWTQexPp7ge+eNZ
	 eRCoQHurSYy2aYOmEL11LQQxx5L9+eYA5d6Pv/uZKqEm09093KE2X58UaSCpsAFvHI
	 8i1L2UZtLsQXO0a5KwnfJI/tIUN0ihyRLF3eCFvfvaZRowRu2YpRfjnaFqfH8nzc7g
	 409IKCOXBdAmQ==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2D1BEF40068;
	Sun,  5 Jul 2026 18:08:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 05 Jul 2026 18:08:40 -0400
X-ME-Sender: <xms:6NVKahrPmtyyNRcu4gkdv0_CHk5YPXjg1J3FYXTTIvLJrt5x7Q8UcQ>
    <xme:6NVKapoB9lTOkhDLtY7Kwvc7c6Fvm1YWzEbX6saAvIqrS4ACPnqb_H5FFd80w9nwq
    8DfwWkNym-EIs8HxjwC5ithZI71oNW7EESrkTKWZB9x6ReKkF7BYbI>
X-ME-Received: <xmr:6NVKapBz58spJU7Xk5L5n5jWR_Y62RnKPpipJQuIKZhY9jQnn3R0skv2nt7tiFEzF3wvgGK_QKpvtDTVTXRLaaPTgqP9Jds17RY>
X-ME-Proxy-Cause: dmFkZTGpBMVXMziOYuSwMiAis5OuqxlXHM20m/6baqWe6+day3+aoWAAdkil6iT3ZtYGpg
    eXsJNX8oh86LLjTj4ueRdxvzJbg+ainjqIoLkEgMVJsMhpM+XykKcKvFsunfjcA3W/RJJk
    nvJwRyuGFKOjiJjYzgSKGmv+bXG67hfJJHUOUFkA8dCeSjJ+HjnF3l4GMc9E/0BGlbBtwX
    UOq8rMniCdJcDBVfy/HYBKzWYX1daj+FueB91Spki96cpT+lcDbdVt8UsrEPoxmYK220Sc
    h8ZYwiegxKLc18hFtNyYJa1cK8XIR3wg29pgNvNEPyiNCITstRnIIsLyIfDPpNJdksRot/
    NE5f6AeIqgqCGoA5Kng2yFp9gsZhxstFtpiLLwiXdBjHmw3UXKoagNo8fvPftvLeuP66iA
    fHcowqHJEtJsJWzMznX7/OmcSx+Qve/lKE8Pe0bMQKg0Hx+oBaUKHTPRbO0S0NMWIMc2jq
    3pEa+Xu1ga9pbwwl1j2hG8+GNTtM92jVZq4ML7HLIYweV7Msghj0XeDMXUP7QSss8cN2ro
    fjXue4HDjYG9bft1Yp3ZBbogCyy1D1yHVjQ42sRwVUqnsWucetJWB0BL5ET+TMv6qOwNzQ
    0EE8zA624SFxOwFiEfPhGujVdnirB84EuZSHQw4vXbORoQVPAsJoFm3cerHw
X-ME-Proxy: <xmx:6NVKavukke4KFzMuQ9QeVR1ujwVby5G4JmSDgQTzlUkzPYiZT7ii1w>
    <xmx:6NVKagKDG7kTupR6cybYLWTnT4N9zYDkYyOZF8J-R4deKDAht5gAkg>
    <xmx:6NVKauYZu2xDnwxSMyPMbIvfNFoB-lZZQDMTOm3xOPkq5EqsH9LxqQ>
    <xmx:6NVKaqDuRLDVZQq-7EnCgUJ0fN0XZme_az9ui9EFJU8vgIfuBtlOnw>
    <xmx:6NVKagYtIq5dM2Oqho87z3mucJ9MnU-y0bplP4SFU0wDfoWST8Od6vFg>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 18:08:39 -0400 (EDT)
From: Dan Williams <djbw@kernel.org>
To: linux-coco@lists.linux.dev
Cc: linux-pci@vger.kernel.org,
	driver-core@lists.linux.dev,
	ankita@nvidia.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 13/15] PCI, device core: Add private memory access for DEVICE_TRUST_TCB
Date: Sun,  5 Jul 2026 15:08:17 -0700
Message-ID: <20260705220819.2472765-14-djbw@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260705220819.2472765-1-djbw@kernel.org>
References: <20260705220819.2472765-1-djbw@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A device that wants to access private memory needs to have its trust
elevated to DEVICE_TRUST_TCB. That trust is established either at compile
time (unlikely), the bus knows the device is within the TCB to start (some
paravisor setups), or the device is dynamically added to the TCB in
coordination with a TSM driver (primary TDISP use case) and the trust is
elevated by driver match.

When a PCI device is associated with a TSM for security services the low
level TSM driver in the CC VM has the opportunity validate DMA access.
That validation happens at ->dma_configure() time when the device attaches
to a driver. The TSM driver is responsible for proving to the platform TSM
that the VM is enabling DMA with respect to the most recently generated
evidence. If that fails, driver attach fails.

When a PCI device is not associated with a TSM provider for security
services, but the device is trusted there are 3 options.

1/ Arch requires all DMA enable events to be acked by TSM driver

2/ Arch does not require, but admin policy is responsible for knowing which
   devices need TSM coordination to become active within the TCB.

3/ Device is approved by a paravisor to operate within the TCB, no TSM
   coordination required.

In cases 2 and 3 if the device needed TSM driver coordination, but the TSM
driver or association to the device is missing, it triggers hardware
errors. Those errors are a configuration error that the kernel does not
actively prevent.

Architectures still need to fixup force_dma_unencrypted() to call
device_tcb_trusted() to tell the DMA layer that TCB access is granted.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Dan Williams <djbw@kernel.org>
---
 drivers/base/Kconfig         | 19 ++++++++++++++++++-
 include/linux/device/trust.h |  4 ++++
 drivers/base/trust.c         |  8 ++++++++
 drivers/pci/pci-driver.c     | 25 ++++++++++++++++---------
 4 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index a4233bdf9804..3597b39ee0e3 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -304,7 +304,17 @@ config DEVICE_TRUST_AUTO
 	help
 	  Typical historical driver model, devices eagerly attempt to attach to
 	  a driver and deploy all available mechanisms to allow performant
-	  direct memory access.
+	  direct memory access. This trust level does not include TCB privileges.
+
+config DEVICE_TRUST_TCB
+	bool "TCB"
+	depends on EXPERT
+	help
+	  Devices are assumed to be within the Trusted Compute Boundary (TCB)
+	  with access to private TCB resources by default. This requires buses
+	  to have trust awareness and opt devices out of private operation,
+	  otherwise TCB integrity may fail the device's access or escalate to
+	  terminating the execution context (kill the CC VM).
 
 endchoice
 
@@ -330,6 +340,13 @@ config BUILTIN_DEVICE_TRUST_ADVERSARY
 	help
 	  Deploy mitigations in the IOMMU layer and driver to limit access.
 
+config BUILTIN_DEVICE_TRUST_TCB
+	bool "TCB"
+	depends on EXPERT
+	help
+	  Devices bound by built-in drivers are assumed to be within the
+	  Trusted Compute Boundary with access to private/encrypted memory.
+
 endchoice
 
 endmenu
diff --git a/include/linux/device/trust.h b/include/linux/device/trust.h
index 283d3196e5e6..24951f5c56ba 100644
--- a/include/linux/device/trust.h
+++ b/include/linux/device/trust.h
@@ -13,6 +13,7 @@
  * @DEVICE_TRUST_NONE: Blocked when idle, cannot bind
  * @DEVICE_TRUST_ADVERSARY: Blocked when idle, constrained when active.
  * @DEVICE_TRUST_AUTO: All typical privileges granted
+ * @DEVICE_TRUST_TCB: AUTO privileges + private/encrypted memory access
  *
  * Devices flagged as adversarial are the ones that can potentially
  * execute DMA attacks and similar. They are typically connected through
@@ -25,11 +26,13 @@ enum device_trust {
 	DEVICE_TRUST_NONE,
 	DEVICE_TRUST_ADVERSARY,
 	DEVICE_TRUST_AUTO,
+	DEVICE_TRUST_TCB,
 };
 
 #define DEVICE_DEFAULT_TRUST \
 	(IS_ENABLED(CONFIG_DEVICE_TRUST_NONE)      ? DEVICE_TRUST_NONE      : \
 	 IS_ENABLED(CONFIG_DEVICE_TRUST_ADVERSARY) ? DEVICE_TRUST_ADVERSARY : \
+	 IS_ENABLED(CONFIG_DEVICE_TRUST_TCB)       ? DEVICE_TRUST_TCB       : \
 	 DEVICE_TRUST_AUTO)
 
 struct device;
@@ -37,6 +40,7 @@ struct device_driver;
 
 #ifdef CONFIG_DEVICE_TRUST
 bool device_untrusted(struct device *dev);
+bool device_tcb_trusted(struct device *dev);
 void module_driver_trust(struct module *mod, const char *val);
 void module_driver_trust_init(struct module *mod, bool require_trust);
 #else
diff --git a/drivers/base/trust.c b/drivers/base/trust.c
index 8efbe5c51250..21d374affbba 100644
--- a/drivers/base/trust.c
+++ b/drivers/base/trust.c
@@ -23,11 +23,18 @@ bool device_untrusted(struct device *dev)
 	return dev->bus_trust && dev->bus_trust <= DEVICE_TRUST_ADVERSARY;
 }
 
+bool device_tcb_trusted(struct device *dev)
+{
+	return dev->p->trust >= DEVICE_TRUST_TCB;
+}
+
 /* Driver trust policy requires modules, builtin drivers always attach */
 static enum device_trust builtin_driver_trust(void)
 {
 	if (IS_ENABLED(CONFIG_BUILTIN_DEVICE_TRUST_ADVERSARY))
 		return DEVICE_TRUST_ADVERSARY;
+	else if (IS_ENABLED(CONFIG_BUILTIN_DEVICE_TRUST_TCB))
+		return DEVICE_TRUST_TCB;
 	return DEVICE_TRUST_AUTO;
 }
 
@@ -61,6 +68,7 @@ static const char * const device_trust_names[] = {
 	[DEVICE_TRUST_NONE]	 = "none",
 	[DEVICE_TRUST_ADVERSARY] = "adversary",
 	[DEVICE_TRUST_AUTO]	 = "auto",
+	[DEVICE_TRUST_TCB]	 = "tcb",
 };
 
 static enum device_trust device_trust_parse(const char *name)
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index f36778e62ac1..e6a4bc3ca9b0 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -19,6 +19,7 @@
 #include <linux/kexec.h>
 #include <linux/of_device.h>
 #include <linux/acpi.h>
+#include <linux/pci-tsm.h>
 #include <linux/dma-map-ops.h>
 #include <linux/iommu.h>
 #include "pci.h"
@@ -1668,10 +1669,11 @@ static int pci_bus_num_vf(struct device *dev)
 static int pci_dma_configure(struct device *dev)
 {
 	const struct device_driver *drv = READ_ONCE(dev->driver);
-	struct device *bridge;
+	struct pci_dev *pdev = to_pci_dev(dev);
 	int ret = 0;
 
-	bridge = pci_get_host_bridge_device(to_pci_dev(dev));
+	struct device *bridge __free(put_device) =
+		pci_get_host_bridge_device(pdev);
 
 	if (IS_ENABLED(CONFIG_OF) && bridge->parent &&
 	    bridge->parent->of_node) {
@@ -1688,16 +1690,21 @@ static int pci_dma_configure(struct device *dev)
 	 * the standard ACS capability but still support ACS via those
 	 * quirks.
 	 */
-	pci_enable_acs(to_pci_dev(dev));
-
-	pci_put_host_bridge_device(bridge);
+	pci_enable_acs(pdev);
 
 	/* @drv may not be valid when we're called from the IOMMU layer */
-	if (!ret && drv && !to_pci_driver(drv)->driver_managed_dma) {
+	if (ret || !drv)
+		return ret;
+
+	if (device_tcb_trusted(dev))
+		ret = pci_tsm_enable_dma(pdev);
+
+	if (!ret && !to_pci_driver(drv)->driver_managed_dma)
 		ret = iommu_device_use_default_domain(dev);
-		if (ret)
-			arch_teardown_dma_ops(dev);
-	}
+
+	/* undo {of,acpi}_dma_configure() */
+	if (ret)
+		arch_teardown_dma_ops(dev);
 
 	return ret;
 }
-- 
2.54.0

