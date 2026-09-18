Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823DA451996;
	Fri, 18 Sep 2026 19:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789761343; cv=none; b=mfSEkIxHtSoLQKNkyTq02IC8v+yXCnmHqePUIDSrRk7stPxnHEd0e/JBbxOvqxHAOF6O9YV9c12t4EEMxCewJvYvPS8zEry8UmbHNJ8r5ZRhLlO1LyeUUmQxJMnFztj/YZzINcvd+CwrcXA73HKx4zdPIG+iTIvhaq46cIqiN7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789761343; c=relaxed/simple;
	bh=UHunDqPdEFSKYOMnpEy5f2kp6PBW3L9UHE8MUW3I2G8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OwcIQN0bUyF0Ece2/nWAVk9EdlDgTmMUMt/zqyHJ0Y/LNIdFluObqWz+SCH8X8R2mdcS926v356u6vfqDFmX6xOixuWbkySVrleDDxsdxOrWxITLOd2rceB4kZoxD7cnRqc4UttC5yDvc2HjLszF5ZcIlI++DJxz7R1K0G8ofAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzDYyFTw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzDYyFTw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5B41F000FF;
	Fri, 18 Sep 2026 19:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789761342;
	bh=XFTSfce6uRZiBVefoXaSKf4aWAfla8JofKn6hY0ShWQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=GzDYyFTwlwGh97c7Y5tuTpaJPPfOJFgJGMeMzZbC4RjtQ1PcbPSAUz6xAiXyxC/6g
	 EePcj3HqJZZvgzdIxZqDA02O2u7gigDhHDj0/pEBidetisu5anXRrozGZ8A8PCHvb0
	 elBnNoNzJ/w3Y4KKwfKsO4zK3YlJUFcxWOCrCHnzX5ceBLnxzFYOOUu48fWZNv4+Kg
	 UuWVbPaR4h/jJyqu+4lRTzyQnyM29G8jvXLw7IJAxW14Ms2UzEA9KGo9ooeb7RmzLU
	 KRzSHD2vdFpX8ywQ6sdAbCQJt1hKRvk9TdW4ZnR529ZEkYYCae+WMUc3LFIBqgBGkX
	 MKQJGOX1gp8Cg==
Date: Fri, 18 Sep 2026 14:55:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Angel J <iamanaws@httpd.dev>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, robh@kernel.org,
	herve.codina@bootlin.com, lizhi.hou@amd.com, andrea.porta@suse.com,
	florian.fainelli@broadcom.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org
Subject: [PATCH v3] PCI: of_property: Omit bus properties without a
 subordinate bus
Message-ID: <20260918195540.GA1187209@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916145045.GA922158@bhelgaas>

Author: Angel J <iamanaws@httpd.dev>

PCI: of_property: Omit bus properties without a subordinate bus

A bridge (a device with a Type 1 header) may not have a secondary bus
allocated (pdev->subordinate), e.g., if there are no available bus numbers
or the bridge secondary/subordinate bus numbers are not writable.

The dynamic OF helpers of_pci_prop_bus_range() and of_pci_prop_intr_map()
dereference pdev->subordinate without checking it.  When
CONFIG_PCI_DYNAMIC_OF_NODES is enabled, this can cause a NULL pointer
dereference and early boot hang.

Generate 'bus-range' and 'interrupt-map' properties only when a subordinate
bus exists.  Keep the node and its remaining properties for bridges without
one.

The problem was latent since 407d1a51921e ("PCI: Create device tree node
for bridge"), but wasn't reachable until 1f340724419e ("PCI: of: Create
device tree PCI host bridge node"), which appeared in v6.15.  Before
1f340724419e, of_pci_make_dev_node() returned early because the parent OF
node was missing.

Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
Signed-off-by: Angel J <iamanaws@httpd.dev>
[bhelgaas: move pdev->subordinate test to callees, commit log]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org	# v6.6+
Link: https://patch.msgid.link/20260912043106.10715-1-iamanaws@httpd.dev
---
Changes in v3:
- Move pdev->subordinate tests to of_pci_prop_bus_range() and
  of_pci_prop_intr_map()

Changes in v2
(https://lore.kernel.org/all/20260912043106.10715-1-iamanaws@httpd.dev):
- Keep the dynamic OF node and skip only bus-range and interrupt-map
  when no subordinate bus exists, following review of v1.
- Tested on Linux 6.18.44 with the v1 guard removed.

v1
(https://lore.kernel.org/all/20260911230420.26244-1-iamanaws@httpd.dev)

diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index 75a358f73e69..1500740cc55d 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -95,9 +95,13 @@ static int of_pci_prop_bus_range(struct pci_dev *pdev,
 				 struct of_changeset *ocs,
 				 struct device_node *np)
 {
-	u32 bus_range[] = { pdev->subordinate->busn_res.start,
-			    pdev->subordinate->busn_res.end };
+	u32 bus_range[2];
 
+	if (!pdev->subordinate)
+		return 0;
+
+	bus_range[0] = pdev->subordinate->busn_res.start;
+	bus_range[1] = pdev->subordinate->busn_res.end;
 	return of_changeset_add_prop_u32_array(ocs, np, "bus-range", bus_range,
 					       ARRAY_SIZE(bus_range));
 }
@@ -220,6 +224,9 @@ static int of_pci_prop_intr_map(struct pci_dev *pdev, struct of_changeset *ocs,
 	int ret;
 	u8 pin;
 
+	if (!pdev->subordinate)
+		return 0;
+
 	pnode = pci_device_to_OF_node(pdev->bus->self);
 	if (!pnode)
 		pnode = pci_bus_to_OF_node(pdev->bus);
