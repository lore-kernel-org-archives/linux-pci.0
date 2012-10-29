Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog110.obsmtp.com ([207.126.144.129]:35001 "EHLO
	eu1sys200aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751661Ab2J2HCL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Oct 2012 03:02:11 -0400
From: Pratyush Anand <pratyush.anand@st.com>
To: <arnd@arndb.de>, <shiraz.hashim@st.com>, <viresh.linux@gmail.com>
Cc: <spear-devel@list.st.com>, <linux-pci@vger.kernel.org>,
	<devicetree-discuss@lists.ozlabs.org>, <olof@lixom.net>,
	Pratyush Anand <pratyush.anand@st.com>
Subject: [PATCH 02/15] arm: Call pcie_bus_configure_settings for pcie devices
Date: Mon, 29 Oct 2012 12:31:16 +0530
Message-ID: <6eff165d5aee88370855ff1cb9be2ff4be4ef50c.1351492562.git.pratyush.anand@st.com>
In-Reply-To: <cover.1351492562.git.pratyush.anand@st.com>
References: <cover.1351492562.git.pratyush.anand@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There could be some device which will work only after adjusting their
"Max Packet Size" and/or "Max Read Request Size".

This modification will only  be effective if proper 'pci=' bootargs is
passed.

Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
---
 arch/arm/kernel/bios32.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 2555250..62d603f 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -490,6 +490,18 @@ void __init pci_common_init(struct hw_pci *hw)
 		struct pci_bus *bus = sys->bus;
 
 		if (!pci_has_flag(PCI_PROBE_ONLY)) {
+			struct pci_bus *child;
+
+			/*
+			 * Set MPS and readrq size
+			 */
+			list_for_each_entry(child, &bus->children, node) {
+				struct pci_dev *self = child->self;
+				if (!self)
+					continue;
+				pcie_bus_configure_settings(child,
+						self->pcie_mpss);
+			}
 			/*
 			 * Size the bridge windows.
 			 */
-- 
1.7.5.4

