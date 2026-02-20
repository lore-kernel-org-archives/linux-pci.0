Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C427A1EB5F8;
	Fri, 20 Feb 2026 19:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771616989; cv=none; b=oMrXf41xUMNj3y6VqP3q564tWMhXcyVbXa9YiaPTBLGULZOtceawfgCUSkLismSpHpLP+fhmqH8r58pZrIt2FKRpgvc9AUQsL2t0V/29sAIxcBZpQK8SStt649rEOthOXhjoqsGFLxK3c3Y3jQAumkmirH5P8iYJ741ugJL4FzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771616989; c=relaxed/simple;
	bh=FLeh9KT77QVO8KBsdhAmfYanISfGz3CTr98KqSd+6ns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aTxHShIJ+Z6Ml0msisiJyudPXa5yyrxP2qJN23yFnSros4Piq1coUok6nQtDpl3uYpuH33R1p6phwbhmXzj24XEDPfk2pY6ar65G9+r1IIJl3LNXuw4Y8l9RD5OoZO8wF5PS8okJ+W3V8j2GR9Q3tVOGs3crUbk6PyeMLEYWkmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okPOgOgI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okPOgOgI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC7CC116C6;
	Fri, 20 Feb 2026 19:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771616989;
	bh=FLeh9KT77QVO8KBsdhAmfYanISfGz3CTr98KqSd+6ns=;
	h=From:To:Cc:Subject:Date:From;
	b=okPOgOgI2Rz9gQPe3RpWB5swncI/Yosj42/hsBY1Ov5VP4X/x8sOBn/ypj0Zs/Cfv
	 LuBmkmQ4JDn62ldarXD7+MIg6YpR+tHEk7FFPvWUnV6ty7CH8WbN5TR5WwY5l/8U/n
	 tNoyLc4vOS80tSB0o+hf6+pkG2XYCphgkTUNdwYliaADI8FJCNQh/HtazI4FDk3lI9
	 jNfHXAj9kHa0MLY0pt2U11RckNcps47fmZWSblVyzvkZWeQ3ZKvRULcGFvb9A0wsAq
	 SSudyazbTviVKJymXrR2CLQajb/jDB1iYSVgEub8qgK2ibRuv0hdaj2CxU4g2jsSqs
	 IXd5r910u8xlw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1] PCI/VGA: Move pci_set_vga_state() to vgaarb.c
Date: Fri, 20 Feb 2026 13:49:43 -0600
Message-ID: <20260220194943.3541702-1-bhelgaas@google.com>
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

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c    | 70 --------------------------------------------
 drivers/pci/vgaarb.c | 70 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h  |  3 --
 3 files changed, 70 insertions(+), 73 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f3244630bfd0..50935eef4d54 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6134,76 +6134,6 @@ int pci_select_bars(struct pci_dev *dev, unsigned long flags)
 }
 EXPORT_SYMBOL(pci_select_bars);
 
-/* Some architectures require additional programming to enable VGA */
-static arch_set_vga_state_t arch_set_vga_state;
-
-void __init pci_register_set_vga_state(arch_set_vga_state_t func)
-{
-	arch_set_vga_state = func;	/* NULL disables */
-}
-
-static int pci_set_vga_state_arch(struct pci_dev *dev, bool decode,
-				  unsigned int command_bits, u32 flags)
-{
-	if (arch_set_vga_state)
-		return arch_set_vga_state(dev, decode, command_bits,
-						flags);
-	return 0;
-}
-
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
diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 87143e235033..cdda530521ae 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -207,6 +207,76 @@ static void vga_check_first_use(void)
 	}
 }
 
+/* Some architectures require additional programming to enable VGA */
+static arch_set_vga_state_t arch_set_vga_state;
+
+void __init pci_register_set_vga_state(arch_set_vga_state_t func)
+{
+	arch_set_vga_state = func;	/* NULL disables */
+}
+
+static int pci_set_vga_state_arch(struct pci_dev *dev, bool decode,
+				  unsigned int command_bits, u32 flags)
+{
+	if (arch_set_vga_state)
+		return arch_set_vga_state(dev, decode, command_bits,
+						flags);
+	return 0;
+}
+
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
index edf792a79193..8e16c496606c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1714,9 +1714,6 @@ resource_size_t pcibios_window_alignment(struct pci_bus *bus,
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

