Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574FF37883C;
	Wed, 12 Aug 2026 19:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564104; cv=none; b=Hgd+4xwfE90H1CE9t7+NdHKyNFFsemJvfujnx2hW0GXI61uonxPYPGWgnHSrIehgkP3rGgLdXAf6Mx5s0MZ2h49v9GSkaM//uqAG01iFJwHipLlxjSLi37yu/soPvUwLtQd5V21mPiTG6PfX/SwnJFqAkhmq/iMAeiu/enopyBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564104; c=relaxed/simple;
	bh=eK0nmsYz7nwwja2hraeTU4UTxGfmmbuz6jxL+xqwod4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOJ9HNOHDGiqVoMUZrC1LEjxr6g8wF0zWghALhD7srQwwbV+8RL4ZCxEu5qY11A428FhPY+E7PX+QidNCIqf/TiffuORP2ALc1wET3o3qYMHiTtCvRsbwmYEM1u/n/myBJl4BnG8UXPWK8wsbniNSB+vyoc0qZmlw1/GU40B8qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ie5Y06P2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ie5Y06P2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA7C1F00A3A;
	Wed, 12 Aug 2026 19:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786564103;
	bh=mUGrElscqJVzcBElPVbGKMWCk7y81TalOs/HuGxMTsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ie5Y06P21Vnxc+hzdh8WNdYUpGpZzSOQ6/xrp+W9en/KuiEnSJWiN8ho+5YO6xmGp
	 tz5KaHQ0m4KthMdtgIcRmbvH3QnOroPuEvrgefs7gIXTspixM1XF0OMawSsDhFm1f8
	 69jO9B3DDAAZEhEYc6068ipRXIN8DWAs3WOt8f8azXu3WJgxW/2pA/PqMV9BUdwgGP
	 6pUrorfwJTEPku8N/UMJhtzGBGxImNWVFbKF7yDTYZTLrteSBxFF2C93+rqF3fB9/V
	 Txp9cU3IBbqOldMc6tWIIx+tocWelce9YKRnJyIRgIM1M8kXdW3uJw4i8cgy86M6nz
	 xNQ4l+0chC92g==
From: Leon Romanovsky <leon@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	"Natu, Mahesh" <mahesh.natu@intel.com>
Subject: [PATCH RFC 3/7] PCI/P2PDMA: Authorize HMAT-described cross-host-bridge P2P
Date: Wed, 12 Aug 2026 22:47:40 +0300
Message-ID: <20260812-hmat-p2p-v1-3-75ac41380585@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812-hmat-p2p-v1-0-75ac41380585@nvidia.com>
References: <20260812-hmat-p2p-v1-0-75ac41380585@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

PCI P2PDMA rejects cross-host-bridge transactions unless the platform
matches hard-coded CPU or host-bridge knowledge. That excludes capable
systems, requires recurring kernel whitelist updates, and cannot represent
firmware-qualified directional paths.

Accept a reachable ordered HMAT path from requester to completer as
platform authorization. Missing entries, unreachable entries, and UIO-only
entries do not authorize ordinary DMA. The existing safety boundary remains
in force when firmware does not describe a usable ordered path.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/p2pdma.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 34929bc6efb6..dd300d2e9887 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -9,6 +9,7 @@
  */
 
 #define pr_fmt(fmt) "pci-p2pdma: " fmt
+#include <linux/acpi.h>
 #include <linux/ctype.h>
 #include <linux/dma-map-ops.h>
 #include <linux/pci-p2pdma.h>
@@ -733,6 +734,57 @@ static bool host_bridge_whitelist(struct pci_dev *a, struct pci_dev *b,
 	return false;
 }
 
+#ifdef CONFIG_ACPI
+static int pci_host_bridge_pxm(struct pci_dev *pdev)
+{
+	struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
+	struct acpi_device *adev;
+	const char *uid_str;
+	u32 uid;
+
+	adev = to_acpi_device_node(host->dev.fwnode);
+	if (!adev)
+		return -ENODEV;
+
+	uid_str = acpi_device_uid(adev);
+	if (!uid_str || kstrtou32(uid_str, 0, &uid))
+		return -ENODEV;
+
+	return acpi_get_genport_proximity_domain(uid);
+}
+#else
+static int pci_host_bridge_pxm(struct pci_dev *pdev)
+{
+	return -ENODEV;
+}
+#endif
+
+/*
+ * Check whether platform firmware describes, via an HMAT PCIe P2P Latency and
+ * Bandwidth Information Structure, a reachable ordered (non-UIO) P2P path from
+ * the client's host bridge to the provider's host bridge. When it does, the
+ * platform vouches for cross-host-bridge P2P even if the root complex is not
+ * in the static whitelist.
+ *
+ * The client is the requester of the P2P transactions and the provider is the
+ * completer, so the client's host bridge is the HMAT initiator and the
+ * provider's host bridge is the HMAT target. UIO-only paths are described by
+ * firmware but are not (yet) used to authorize ordered DMA.
+ */
+static bool host_bridge_hmat_p2p(struct pci_dev *provider, struct pci_dev *client)
+{
+	struct access_coordinate coord;
+	int init_pxm, targ_pxm;
+
+	init_pxm = pci_host_bridge_pxm(client);
+	targ_pxm = pci_host_bridge_pxm(provider);
+	if (init_pxm < 0 || targ_pxm < 0)
+		return false;
+
+	return acpi_get_p2p_coordinates(init_pxm, targ_pxm, HMAT_P2P_NON_UIO,
+					&coord) == 0;
+}
+
 static unsigned long map_types_idx(struct pci_dev *client)
 {
 	return (pci_domain_nr(client->bus) << 16) | pci_dev_id(client);
@@ -890,9 +942,10 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 
 map_through_host_bridge:
 	if (!cpu_supports_p2pdma() &&
+	    !host_bridge_hmat_p2p(provider, client) &&
 	    !host_bridge_whitelist(provider, client, verbose)) {
 		if (verbose)
-			pci_warn(client, "cannot be used for peer-to-peer DMA as the client and provider (%s) do not share an upstream bridge or whitelisted host bridge\n",
+			pci_warn(client, "cannot be used for peer-to-peer DMA as the client and provider (%s) do not share an upstream bridge, whitelisted host bridge, or HMAT-described P2P path\n",
 				 pci_name(provider));
 		map_type = PCI_P2PDMA_MAP_NOT_SUPPORTED;
 	}

-- 
2.55.0

