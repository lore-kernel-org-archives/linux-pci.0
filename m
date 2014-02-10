Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:36967 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752214AbaBJIwr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Feb 2014 03:52:47 -0500
From: Mohit Kumar <mohit.kumar@st.com>
To: <arnd@arndb.de>
Cc: Mohit Kumar <mohit.kumar@st.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH V5 8/8] MAINTAINERS: Add ST SPEAr13xx PCIe driver maintainer
Date: Mon, 10 Feb 2014 14:21:59 +0530
Message-ID: <61242f305b3e7173bece431f200f488bfc8908be.1391871170.git.pratyush.anand@st.com>
In-Reply-To: <cover.1391871170.git.pratyush.anand@st.com>
References: <cover.1391871170.git.pratyush.anand@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add Mohit Kumar as maintainer for ST SPEAr13xx PCIe driver.

Signed-off-by: Mohit Kumar <mohit.kumar@st.com>
Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
Acked-by: Jingoo Han <jg1.han@samsung.com>
Cc: linux-pci@vger.kernel.org
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b2cf5cf..ebdca89 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6596,6 +6596,12 @@ L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	drivers/pci/host/*designware*
 
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
1.8.1.2

