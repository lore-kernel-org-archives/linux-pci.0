Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CEA33BBAF;
	Thu, 26 Mar 2026 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563216; cv=none; b=t2iXmVOQl2o+mlLsYajev6BWcXNj51WVVafPbQKpqzj3LAY6O5HUXUmlzsZG+CJZJoT520A4Mb9k+dvQ0oAWnSye7yTY4haNH/OKXQNrXMsxc6AyulGunKY6Yo1qIgH8zdEBc5ltbtLuHaHRAw4YYkUYt6Hk6lC/F1sBVFwZLD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563216; c=relaxed/simple;
	bh=BC2h89v1fE098rItLBk3R3hevS+LuWcLA/hkLEau6hY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yab/di13KlA+MzphKzB2rWQTzRA+V6tPK7OhTYrLmemT4YVUPProXQYEKDb6QABV0R4VOMTdHzRmNlz9Lf3YSL2zS2A658pXEwdxx+MMXNaQdqHbQ2xNNwe3JNb/+rhM0TpfJ4FetbBw1lRWHY+T39SGx79pFPl15z2D+VbXab0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNNYwcvL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNNYwcvL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A62C116C6;
	Thu, 26 Mar 2026 22:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774563216;
	bh=BC2h89v1fE098rItLBk3R3hevS+LuWcLA/hkLEau6hY=;
	h=From:To:Cc:Subject:Date:From;
	b=LNNYwcvLoDBf4pt2Bk8fiFkQ/uRMYE1dytl6K9OOmKnSjtUk7M039OVAJPAHpoNDG
	 G/Nkvfhb3LEGaFWczqKbamiULtcazorHaaG2wWpzHB8iLSPttRjPPbuQFchCsa4tm6
	 8eeLSDi3CvfLWgD9ZgwIws+ii/3TwXoSvrr/SgB8znF9rkzk2kQk/1LmAHUusvnBUB
	 6R9Qt+gEhAPqrHXOOFKVMscXnAq1XwP/UC+KQ8akh5cxa3fwFjl9fVdaotzC8QejtA
	 UzjY8PmO+TObv10LojKB7cn0mRGpxUTVEqGnsR8zsF21uMeJuSgo/UzA+ZclHGC8q8
	 pJzwIkQkq+dcg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Jim Quinlan <james.quinlan@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Hans Zhang <18255117159@163.com>,
	Niklas Cassel <cassel@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1] PCI: Remove MPS/MRRS Kconfig settings
Date: Thu, 26 Mar 2026 17:13:11 -0500
Message-ID: <20260326221311.1356180-1-bhelgaas@google.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts b0e85c3c8554 ("PCI: Add Kconfig options for MPS/MRRS
strategy"), which allowed build-time selection of the "off", "default",
"safe", "performance", or "peer2peer" strategies for MPS and MRRS
configuration.  These strategies can be selected at boot-time using the
"pci=pcie_bus_tune_*" kernel parameters.

Per the discussion mentioned below, these Kconfig options were added to
work around a hardware defect in a WiFi device used in a cable modem.  The
defect occurred only when the device was configured with MPS=128, and
Kconfig was a way to avoid that setting.  It was easier for the modem
vendor to use Kconfig and update the kernel image than to change the kernel
parameters.

Neither Kconfig nor kernel parameters are a complete solution because the
WiFi device may be used in other systems where it may be configured with
MPS=128 and be susceptible to the defect.

Remove the Kconfig settings to simplify the MPS code.  If we can identify
the WiFi device in question, we may be able to make a generic quirk to
avoid the problem on all system.

This is not a fix and should not be backported to previous kernels.

Link: https://lore.kernel.org/all/CA+-6iNzd0RJO0L021qz8CKrSviSst6QehY-QtJxz_-EVY0Hj0Q@mail.gmail.com
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/Kconfig | 62 ---------------------------------------------
 drivers/pci/pci.c   | 10 --------
 2 files changed, 72 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index e3f848ffb52a..f1330d219763 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -252,68 +252,6 @@ config PCI_DYNAMIC_OF_NODES
 	  Once this option is selected, the device tree nodes will be generated
 	  for all PCI bridges.
 
-choice
-	prompt "PCI Express hierarchy optimization setting"
-	default PCIE_BUS_DEFAULT
-	depends on PCI && EXPERT
-	help
-	  MPS (Max Payload Size) and MRRS (Max Read Request Size) are PCIe
-	  device parameters that affect performance and the ability to
-	  support hotplug and peer-to-peer DMA.
-
-	  The following choices set the MPS and MRRS optimization strategy
-	  at compile-time.  The choices are the same as those offered for
-	  the kernel command-line parameter 'pci', i.e.,
-	  'pci=pcie_bus_tune_off', 'pci=pcie_bus_safe',
-	  'pci=pcie_bus_perf', and 'pci=pcie_bus_peer2peer'.
-
-	  This is a compile-time setting and can be overridden by the above
-	  command-line parameters.  If unsure, choose PCIE_BUS_DEFAULT.
-
-config PCIE_BUS_TUNE_OFF
-	bool "Tune Off"
-	depends on PCI
-	help
-	  Use the BIOS defaults; don't touch MPS at all.  This is the same
-	  as booting with 'pci=pcie_bus_tune_off'.
-
-config PCIE_BUS_DEFAULT
-	bool "Default"
-	depends on PCI
-	help
-	  Default choice; ensure that the MPS matches upstream bridge.
-
-config PCIE_BUS_SAFE
-	bool "Safe"
-	depends on PCI
-	help
-	  Use largest MPS that boot-time devices support.  If you have a
-	  closed system with no possibility of adding new devices, this
-	  will use the largest MPS that's supported by all devices.  This
-	  is the same as booting with 'pci=pcie_bus_safe'.
-
-config PCIE_BUS_PERFORMANCE
-	bool "Performance"
-	depends on PCI
-	help
-	  Use MPS and MRRS for best performance.  Ensure that a given
-	  device's MPS is no larger than its parent MPS, which allows us to
-	  keep all switches/bridges to the max MPS supported by their
-	  parent.  This is the same as booting with 'pci=pcie_bus_perf'.
-
-config PCIE_BUS_PEER2PEER
-	bool "Peer2peer"
-	depends on PCI
-	help
-	  Set MPS = 128 for all devices.  MPS configuration effected by the
-	  other options could cause the MPS on one root port to be
-	  different than that of the MPS on another, which may cause
-	  hot-added devices or peer-to-peer DMA to fail.  Set MPS to the
-	  smallest possible value (128B) system-wide to avoid these issues.
-	  This is the same as booting with 'pci=pcie_bus_peer2peer'.
-
-endchoice
-
 config VGA_ARB
 	bool "VGA Arbitration" if EXPERT
 	default y
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8479c2e1f74f..274c6685344e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -120,17 +120,7 @@ unsigned long pci_hotplug_bus_size = DEFAULT_HOTPLUG_BUS_SIZE;
 
 
 /* PCIe MPS/MRRS strategy; can be overridden by kernel command-line param */
-#ifdef CONFIG_PCIE_BUS_TUNE_OFF
-enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_TUNE_OFF;
-#elif defined CONFIG_PCIE_BUS_SAFE
-enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_SAFE;
-#elif defined CONFIG_PCIE_BUS_PERFORMANCE
-enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_PERFORMANCE;
-#elif defined CONFIG_PCIE_BUS_PEER2PEER
-enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_PEER2PEER;
-#else
 enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_DEFAULT;
-#endif
 
 /*
  * The default CLS is used if arch didn't set CLS explicitly and not
-- 
2.51.0

