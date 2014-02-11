Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:49750 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750776AbaBKJbB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Feb 2014 04:31:01 -0500
From: Mohit Kumar <mohit.kumar@st.com>
To: <arnd@arndb.de>
Cc: Mohit Kumar <mohit.kumar@st.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH V6 12/12] MAINTAINERS: Add ST SPEAr13xx PCIe driver maintainer
Date: Tue, 11 Feb 2014 15:00:08 +0530
Message-ID: <94d33e34f15254833893fdecfd111fa0fdf772b5.1392109054.git.mohit.kumar@st.com>
In-Reply-To: <cover.1392109054.git.mohit.kumar@st.com>
References: <cover.1392109054.git.mohit.kumar@st.com>
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

