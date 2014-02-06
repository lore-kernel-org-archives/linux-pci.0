Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog103.obsmtp.com ([207.126.144.115]:58885 "EHLO
	eu1sys200aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754760AbaBFEpd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Feb 2014 23:45:33 -0500
From: Pratyush Anand <pratyush.anand@st.com>
To: <arnd@arndb.de>
Cc: Mohit Kumar <mohit.kumar@st.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH V4 8/8] MAINTAINERS: Add ST SPEAr13xx PCIe driver maintainer
Date: Thu, 6 Feb 2014 10:14:55 +0530
Message-ID: <4050bae76224d5a984d8c6701641e8b729050319.1391661589.git.pratyush.anand@st.com>
In-Reply-To: <cover.1391661589.git.pratyush.anand@st.com>
References: <cover.1391661589.git.pratyush.anand@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Mohit Kumar <mohit.kumar@st.com>

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

