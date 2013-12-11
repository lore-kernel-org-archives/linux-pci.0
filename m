Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:46221 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751368Ab3LKJj7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2013 04:39:59 -0500
From: Mohit Kumar <mohit.kumar@st.com>
To: <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Cc: Mohit Kumar <mohit.kumar@st.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 11/12] MAINTAINERS: Add ST SPEAr13xx PCIe driver maintainer
Date: Wed, 11 Dec 2013 15:08:36 +0530
Message-ID: <0f924b2ad771dd5c3486c81ed524a3f6e7d813b9.1386752447.git.mohit.kumar@st.com>
In-Reply-To: <cover.1386752447.git.mohit.kumar@st.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
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

