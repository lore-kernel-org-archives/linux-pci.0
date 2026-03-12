Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B17226F28D;
	Thu, 12 Mar 2026 22:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773355641; cv=none; b=Um3KkO49zZQNWS4mr/wQm8mCgVw7Evl3pM2IKLbbD7dDMA/7rNysu719cdRHXIwzeitKavunmC58b+9S95jfaOdStEZqsUbsUBqCDJSEuzAGncwqpji8jnAQfOywA6m1W+eta1aW48NYj7bZz5Fgz6dxxzdhfEi6ozF0pzo9wYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773355641; c=relaxed/simple;
	bh=eSRVGxuuN65OCTYTkaZlWTnJzrz8GuDGMGuuxQYwpXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DRDAa1FoNkU1LQl3W74jZORC5pwA+f5jvLmr165j5F/59YTe6adtXOj9IwmgujT5oBFvemteeIsND8pY7QxaSbqnBa1a+UDVybWKKHDobxnelM9foOYynSL1pP3H6YZW1pdVw9blpCEq0eLw8XOyfk5YmUpOF9Yk2hn1L07OYac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agfR5tvA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agfR5tvA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089F5C4CEF7;
	Thu, 12 Mar 2026 22:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773355641;
	bh=eSRVGxuuN65OCTYTkaZlWTnJzrz8GuDGMGuuxQYwpXY=;
	h=From:To:Cc:Subject:Date:From;
	b=agfR5tvAl1psz8c532po41FmiR7NzYlfJcv+GudtssrCm+npR+0HjD/Kds2uqxaTx
	 0v3dVX9tavgMqXMIYLvL1dSoU+HGCFtLgNXIoPJIGzsFRepE9FsBA1FVOMs/AN8o1t
	 NE9iJradG2jAg12smYZYA09+Mr0h9ezKQsE2jx4SyROOlBKT7MBgw7L+00Hho4Mle/
	 5/dx9wh6iKH1FjAK2OHbPRu+r2p2ITBW7zg0g6xgUq4Pwk1YjeI5oCJROcnH4v3mmr
	 uUN1ZsuwIaAXBKnHuhH2C25m0xJBVDVEP0rKJlUM1n67abM28HboRlC4lwuCV/br5G
	 ZhMzFBOTtN4oQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Simon Richter <Simon.Richter@hogyros.de>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2] PCI/VGA: Move pci_set_vga_state() to vgaarb.c
Date: Thu, 12 Mar 2026 17:47:13 -0500
Message-ID: <20260312224713.1305228-1-bhelgaas@google.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_set_vga_state() is only used in vgaarb.c.  Move it from pci.c to
vgaarb.c, make it static, and remove the declaration from
include/linux/pci.h.

pci_register_set_vga_state(), which registers an arch-specific function to
change the VGA routing, stays in pci.c so it is available even if vgaarb.c
is not compiled.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c    | 57 ++------------------------------------------
 drivers/pci/pci.h    |  3 +++
 drivers/pci/vgaarb.c | 53 ++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h  |  3 ---
 4 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8479c2e1f74f..a8ee33e65797 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6141,8 +6141,8 @@ void __init pci_register_set_vga_state(arch_set_vga_state_t func)
 	arch_set_vga_state = func;	/* NULL disables */
 }
 
-static int pci_set_vga_state_arch(struct pci_dev *dev, bool decode,
-				  unsigned int command_bits, u32 flags)
+int pci_set_vga_state_arch(struct pci_dev *dev, bool decode,
+			   unsigned int command_bits, u32 flags)
 {
 	if (arch_set_vga_state)
 		return arch_set_vga_state(dev, decode, command_bits,
@@ -6150,59 +6150,6 @@ static int pci_set_vga_state_arch(struct pci_dev *dev, bool decode,
 	return 0;
 }
 
-/**
- * pci_set_vga_state - set VGA decode state on device and parents if requested
- * @dev: the PCI device
- * @decode: true = enable decoding, false = disable decoding
- * @command_bits: PCI_COMMAND_IO and/or PCI_COMMAND_MEMORY
- * @flags: traverse ancestors and change bridges
- * CHANGE_BRIDGE_ONLY / CHANGE_BRIDGE
- */
-int pci_set_vga_state(struct pci_dev *dev, bool decode,
-		      unsigned int command_bits, u32 flags)
-{
-	struct pci_bus *bus;
-	struct pci_dev *bridge;
-	u16 cmd;
-	int rc;
-
-	WARN_ON((flags & PCI_VGA_STATE_CHANGE_DECODES) && (command_bits & ~(PCI_COMMAND_IO|PCI_COMMAND_MEMORY)));
-
-	/* ARCH specific VGA enables */
-	rc = pci_set_vga_state_arch(dev, decode, command_bits, flags);
-	if (rc)
-		return rc;
-
-	if (flags & PCI_VGA_STATE_CHANGE_DECODES) {
-		pci_read_config_word(dev, PCI_COMMAND, &cmd);
-		if (decode)
-			cmd |= command_bits;
-		else
-			cmd &= ~command_bits;
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-	}
-
-	if (!(flags & PCI_VGA_STATE_CHANGE_BRIDGE))
-		return 0;
-
-	bus = dev->bus;
-	while (bus) {
-		bridge = bus->self;
-		if (bridge) {
-			pci_read_config_word(bridge, PCI_BRIDGE_CONTROL,
-					     &cmd);
-			if (decode)
-				cmd |= PCI_BRIDGE_CTL_VGA;
-			else
-				cmd &= ~PCI_BRIDGE_CTL_VGA;
-			pci_write_config_word(bridge, PCI_BRIDGE_CONTROL,
-					      cmd);
-		}
-		bus = bus->parent;
-	}
-	return 0;
-}
-
 #ifdef CONFIG_ACPI
 bool pci_pr3_present(struct pci_dev *pdev)
 {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 13d998fbacce..0fb8f78ddf32 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -110,6 +110,9 @@ struct pcie_tlp_log;
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 
+int pci_set_vga_state_arch(struct pci_dev *dev, bool decode, unsigned int
+			   command, u32 flags);
+
 extern struct mutex pci_rescan_remove_lock;
 
 bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index d9383bf541e7..8b37c206f941 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -207,6 +207,59 @@ static void vga_check_first_use(void)
 	}
 }
 
+/**
+ * pci_set_vga_state - set VGA decode state on device and parents if requested
+ * @dev: the PCI device
+ * @decode: true = enable decoding, false = disable decoding
+ * @command_bits: PCI_COMMAND_IO and/or PCI_COMMAND_MEMORY
+ * @flags: traverse ancestors and change bridges
+ * CHANGE_BRIDGE_ONLY / CHANGE_BRIDGE
+ */
+static int pci_set_vga_state(struct pci_dev *dev, bool decode,
+			     unsigned int command_bits, u32 flags)
+{
+	struct pci_bus *bus;
+	struct pci_dev *bridge;
+	u16 cmd;
+	int rc;
+
+	WARN_ON((flags & PCI_VGA_STATE_CHANGE_DECODES) && (command_bits & ~(PCI_COMMAND_IO|PCI_COMMAND_MEMORY)));
+
+	/* ARCH specific VGA enables */
+	rc = pci_set_vga_state_arch(dev, decode, command_bits, flags);
+	if (rc)
+		return rc;
+
+	if (flags & PCI_VGA_STATE_CHANGE_DECODES) {
+		pci_read_config_word(dev, PCI_COMMAND, &cmd);
+		if (decode)
+			cmd |= command_bits;
+		else
+			cmd &= ~command_bits;
+		pci_write_config_word(dev, PCI_COMMAND, cmd);
+	}
+
+	if (!(flags & PCI_VGA_STATE_CHANGE_BRIDGE))
+		return 0;
+
+	bus = dev->bus;
+	while (bus) {
+		bridge = bus->self;
+		if (bridge) {
+			pci_read_config_word(bridge, PCI_BRIDGE_CONTROL,
+					     &cmd);
+			if (decode)
+				cmd |= PCI_BRIDGE_CTL_VGA;
+			else
+				cmd &= ~PCI_BRIDGE_CTL_VGA;
+			pci_write_config_word(bridge, PCI_BRIDGE_CONTROL,
+					      cmd);
+		}
+		bus = bus->parent;
+	}
+	return 0;
+}
+
 static struct vga_device *__vga_tryget(struct vga_device *vgadev,
 				       unsigned int rsrc)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1c270f1d5123..bc102aa43f2e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1720,9 +1720,6 @@ resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 #define PCI_VGA_STATE_CHANGE_BRIDGE (1 << 0)
 #define PCI_VGA_STATE_CHANGE_DECODES (1 << 1)
 
-int pci_set_vga_state(struct pci_dev *pdev, bool decode,
-		      unsigned int command_bits, u32 flags);
-
 /*
  * Virtual interrupts allow for more interrupts to be allocated
  * than the device has interrupts for. These are not programmed
-- 
2.51.0

