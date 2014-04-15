Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:57081 "EHLO
	mx08-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750960AbaDOLuv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Apr 2014 07:50:51 -0400
From: Mohit Kumar <mohit.kumar@st.com>
To: <spear-devel@list.st.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Cc: Pratyush Anand <pratyush.anand@st.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Viresh Kumar <viresh.linux@gmail.com>
Subject: [PATCH V8 6/9] SPEAr13XX: Add binding information for PCIe controller
Date: Tue, 15 Apr 2014 17:19:48 +0530
Message-ID: <6d35ffd2873453be8ccba8a53062f1830e367e5f.1397555158.git.mohit.kumar@st.com>
In-Reply-To: <cover.1397555158.git.mohit.kumar@st.com>
References: <cover.1397555158.git.mohit.kumar@st.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Pratyush Anand <pratyush.anand@st.com>

SPEAr13XX uses designware PCIe controller. This patch adds information
for the PCIe binding properties which are specific to SPEAr13XX SoC
series.

Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: Mohit Kumar <mohit.kumar@st.com>
Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: spear-devel@list.st.com
Cc: devicetree@vger.kernel.org
---
 .../devicetree/bindings/pci/spear13xx-pcie.txt     |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/spear13xx-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/spear13xx-pcie.txt b/Documentation/devicetree/bindings/pci/spear13xx-pcie.txt
new file mode 100644
index 0000000..49ea76d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/spear13xx-pcie.txt
@@ -0,0 +1,14 @@
+SPEAr13XX PCIe DT detail:
+================================
+
+SPEAr13XX uses synopsis designware PCIe controller and ST MiPHY as phy
+controller.
+
+Required properties:
+- compatible : should be "st,spear1340-pcie", "snps,dw-pcie".
+- phys		    : phandle to phy node associated with pcie controller
+- phy-names	    : must be "pcie-phy"
+- All other definitions as per generic PCI bindings
+
+ Optional properties:
+- st,pcie-is-gen1 indicates that forced gen1 initialization is needed.
-- 
1.7.0.1

