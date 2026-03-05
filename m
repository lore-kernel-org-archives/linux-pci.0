Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC3D1A9FBC;
	Thu,  5 Mar 2026 00:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772670093; cv=none; b=Wz6ILNdiVE3XdqX6/3h7suhxWbupw4dWHx4R1A1GMpei2fY8ra1SFCXnDQDGZfgi9tV2htDVKEtWoL1t//TfIyeMw1jNAtVEqXaL2H5AmTv2Er4RIUunR24ZLIRhLhaKqJYkTqakCgBDJxxWdcbjwu5HxyzlUhsGgiACqNd/oTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772670093; c=relaxed/simple;
	bh=Y/zwWY/Bu62sL1coTTnjL2PErLO9XhMQ51sDezwLaOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Od9CcehnJGFpUXGmf0sD9hPWfoGW65eghhmkCQN5lnkG1NJ+VuJne1GbXXUsJSJj7zx33/4M+WkIXQmX+xMxzGhSddBXPMnlxxS+SMq1a7qrkzruDu3nVPnuN6qyMboaqqhlZ82XJSVQYkC7Ub2CyiX/oSbhq3hdw9wPY4qRV/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnfxuHhe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnfxuHhe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47BAC4CEF7;
	Thu,  5 Mar 2026 00:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772670092;
	bh=Y/zwWY/Bu62sL1coTTnjL2PErLO9XhMQ51sDezwLaOY=;
	h=From:To:Cc:Subject:Date:From;
	b=dnfxuHheooP1XTyhPOSs4YVjPaXcm7i7shxhddATM1kpTFnHAqpDRh3o7iCIdGBlr
	 sb3NrzuenNt/x0dV10tKMwXmW6LRuhabPWRbdSnJG3bDnvBR7NFZt8O1kXZwcGHu5/
	 x+XlQgrhtOvnrFonEeRzuIGweX4106WHC/Rkem6B/2W4tajGM8T5WNj9mZVGuOep5R
	 ydy4YYr42/C5VmNaaKs+H6SysMPD3PE69ckVbAmmCzfe3JNvx8UazgUNnrBG7ousDX
	 9+wuYck6XWA14xXjq/Cn6YHzeO83LKXdDiNhoS5hQSyNqF3LXrce9fld6bw4Y9by3p
	 LhrM08m3v1t7w==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: Remove warning about host bridge on unknown NUMA node
Date: Wed,  4 Mar 2026 18:21:28 -0600
Message-ID: <20260305002128.51147-1-bhelgaas@google.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ad5086108b9f ("PCI: Warn if no host bridge NUMA node info") added warnings
like this when there are multiple NUMA nodes and we discover a PCI host
bridge where no node is specified, e.g., there's no ACPI _PXM method or DT
"numa-node-id" property:

  pci_bus 0000:ff: Unknown NUMA node; performance will be reduced

The hope was that the message would encourage vendors to add NUMA node
information to their firmware or DTs, but that hasn't happened.  The
message just leads to bug reports that we can't do anything about.

In some cases BIOS has _PXM methods for some bridges but not others, which
suggests that the vendor thinks node information isn't useful to the OS,
e.g., maybe there are no real devices below the bridge.

Remove the warning message when the NUMA node is unknown.  If it is known,
include it in an existing message:

  PCI host bridge to bus 0000:00 NUMA node 0

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218951
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index bccc7a4bdd79..e3e81926a6f3 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -993,9 +993,9 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	LIST_HEAD(resources);
 	struct resource *res, *next_res;
 	bool bus_registered = false;
-	char addr[64], *fmt;
+	char numa[32], addr[64], *fmt;
 	const char *name;
-	int err;
+	int err, node;
 
 	bus = pci_alloc_bus(NULL);
 	if (!bus)
@@ -1071,13 +1071,17 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	/* Create legacy_io and legacy_mem files for this bus */
 	pci_create_legacy_files(bus);
 
+	numa[0] = '\0';
+	if (nr_node_ids > 1) {
+		node = pcibus_to_node(bus);
+		if (node != NUMA_NO_NODE)
+			snprintf(numa, sizeof(numa), " on NUMA node %u", node);
+	}
+
 	if (parent)
-		dev_info(parent, "PCI host bridge to bus %s\n", name);
+		dev_info(parent, "PCI host bridge to bus %s%s\n", name, numa);
 	else
-		pr_info("PCI host bridge to bus %s\n", name);
-
-	if (nr_node_ids > 1 && pcibus_to_node(bus) == NUMA_NO_NODE)
-		dev_warn(&bus->dev, "Unknown NUMA node; performance will be reduced\n");
+		pr_info("PCI host bridge to bus %s%s\n", name, numa);
 
 	/* Check if the boot configuration by FW needs to be preserved */
 	bridge->preserve_config = pci_preserve_config(bridge);
-- 
2.51.0

