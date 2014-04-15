Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Mohit Kumar <mohit.kumar@st.com>
To: <spear-devel@list.st.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Cc: Pratyush Anand <pratyush.anand@st.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Viresh Kumar <viresh.linux@gmail.com>,
	Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH V8 3/9] phy: SPEAr1310/40-miphy: Add binding information
Date: Tue, 15 Apr 2014 17:19:45 +0530
Message-ID: <323b13ad6a87e6650c00f6e566818fa2ede7be95.1397555158.git.mohit.kumar@st.com>
In-Reply-To: <cover.1397555158.git.mohit.kumar@st.com>
References: <cover.1397555158.git.mohit.kumar@st.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Pratyush Anand <pratyush.anand@st.com>

SPEAr1310/40 uses miphy for PCIe, SATA. This patch adds documentation
for the binding on the top of generic phy bindings.

Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: Mohit Kumar <mohit.kumar@st.com>
Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: spear-devel@list.st.com
Cc: devicetree@vger.kernel.org
---
 .../devicetree/bindings/phy/st-spear1310-miphy.txt |   12 ++++++++++++
 .../devicetree/bindings/phy/st-spear1340-miphy.txt |   11 +++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/st-spear1310-miphy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/st-spear1340-miphy.txt

diff --git a/Documentation/devicetree/bindings/phy/st-spear1310-miphy.txt b/Documentation/devicetree/bindings/phy/st-spear1310-miphy.txt
new file mode 100644
index 0000000..b9b281a
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/st-spear1310-miphy.txt
@@ -0,0 +1,12 @@
+ST SPEAr1310-miphy DT detail
+===================================
+
+SPEAr1310-miphy is a phy controller supporting PCIe and SATA.
+
+Required properties:
+- compatible : should be "st,spear1310-miphy"
+- reg : offset and length of the PHY register set.
+- misc: phandle for the syscon node to access misc registers
+- phy-id: Instance id of the phy.
+- #phy-cells : from the generic PHY bindings, must be 1.
+	- cell[1]: 0 if phy used for SATA, 1 for PCIe.
diff --git a/Documentation/devicetree/bindings/phy/st-spear1340-miphy.txt b/Documentation/devicetree/bindings/phy/st-spear1340-miphy.txt
new file mode 100644
index 0000000..7eb5335
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/st-spear1340-miphy.txt
@@ -0,0 +1,11 @@
+ST SPEAr1340-miphy DT detail
+===================================
+
+SPEAr1340-miphy is a phy controller supporting PCIe and SATA.
+
+Required properties:
+- compatible : should be "st,spear1340-miphy"
+- reg : offset and length of the PHY register set.
+- misc: phandle for the syscon node to access misc registers
+- #phy-cells : from the generic PHY bindings, must be 1.
+	- cell[1]: 0 if phy used for SATA, 1 for PCIe.
-- 
1.7.0.1

