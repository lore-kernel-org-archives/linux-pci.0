Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog103.obsmtp.com ([207.126.144.115]:54264 "EHLO
	eu1sys200aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751648AbaAWKyv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jan 2014 05:54:51 -0500
From: Mohit Kumar <mohit.kumar@st.com>
Cc: Mohit Kumar <mohit.kumar@st.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Jingoo Han <jg1.han@samsung.com>, <linux-pci@vger.kernel.org>
Subject: [PATCH V2 8/8] MAINTAINERS: Add ST SPEAr13xx PCIe driver maintainer
Date: Thu, 23 Jan 2014 16:02:48 +0530
Message-ID: <490771f1b5102a9e46232967e5839d010f06478c.1390471111.git.mohit.kumar@st.com>
In-Reply-To: <cover.1390471111.git.mohit.kumar@st.com>
References: <cover.1390471111.git.mohit.kumar@st.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add Mohit Kumar as maintainer for ST SPEAr13xx PCIe driver.

Signed-off-by: Mohit Kumar <mohit.kumar@st.com>
Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: linux-pci@vger.kernel.org
---
 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8285ed4..fd03da6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6462,6 +6462,12 @@ L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	drivers/pci/host/pci-exynos.c
 
+PCIE DRIVER FOR ST SPEAR13XX
+M:	Mohit Kumar <mohit.kumar@st.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	drivers/pci/host/pcie-spear13xx.c
+
 PCMCIA SUBSYSTEM
 P:	Linux PCMCIA Team
 L:	linux-pcmcia@lists.infradead.org
-- 
1.7.0.1

