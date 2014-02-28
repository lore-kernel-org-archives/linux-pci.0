Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:52155 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752356AbaB1Lzy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 28 Feb 2014 06:55:54 -0500
From: Mohit Kumar <mohit.kumar@st.com>
To: <arnd@arndb.de>
Cc: Mohit Kumar <mohit.kumar@st.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH V7 10/10] MAINTAINERS: Add ST SPEAr13xx PCIe driver maintainer
Date: Fri, 28 Feb 2014 17:25:03 +0530
Message-ID: <0274095453d14c848977441f303aab6b53a098cd.1393568715.git.mohit.kumar@st.com>
In-Reply-To: <cover.1393568715.git.mohit.kumar@st.com>
References: <cover.1393568715.git.mohit.kumar@st.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add Mohit Kumar as maintainer for ST SPEAr13xx PCIe driver.

Signed-off-by: Mohit Kumar <mohit.kumar@st.com>
Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
Acked-by: Jingoo Han <jg1.han@samsung.com>
Cc: linux-pci@vger.kernel.org
---
 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

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
1.7.0.1

