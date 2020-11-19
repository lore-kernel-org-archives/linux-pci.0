Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B49C64E7C
	for <linux-pci@archiver.kernel.org>; Thu, 19 Nov 2020 09:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA86E246D1
	for <linux-pci@archiver.kernel.org>; Thu, 19 Nov 2020 09:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="T9Ub142q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgKSJUM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 19 Nov 2020 04:20:12 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:60932 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726775AbgKSJUC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Nov 2020 04:20:02 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 57587C00D3;
        Thu, 19 Nov 2020 09:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1605777601; bh=xjFl0ry1f4kLV7eWV2SxeXcHKekFmdWi7FGEn+fooAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=T9Ub142qNBOEI8oeGn3R1JchqL9Fw7omVrCZs8iRY9lEkYJ//r/Xhq85SbW4Xhixa
         brokZbVEyhYs/u1PyXUCgaKR0d0aEhkg3u41+vaLYYqYFncJl2QMWosX8OpMvaH1M9
         J4LTWKnDxyif36NZ6kkU1rTNO4Vey4CdERx8XVLKvbaESOy0WSrMbh4xe3JGTZNklJ
         a0l72RlkvhZFS4U8uEqUGGoOYuQmhxOeo2iPC8VlbhI/o8/Wk+2g+D2/Z8JIGgSPPH
         vp1N8ntxjX6+IaDytpkLY2CDYBcnHpFo3Z2unLv1GnJP6Du6/hksDWn+VSWAFt8QGL
         Cmd6XkKbIaIQg==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 148BBA005E;
        Thu, 19 Nov 2020 09:20:00 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] Documentation: misc-devices: Add Documentation for dw-xdata-pcie driver
Date:   Thu, 19 Nov 2020 10:19:41 +0100
Message-Id: <b2c70f26a023c00fa03afec404791415c9566775.1605777306.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1605777306.git.gustavo.pimentel@synopsys.com>
References: <cover.1605777306.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1605777306.git.gustavo.pimentel@synopsys.com>
References: <cover.1605777306.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Documentation for dw-xdata-pcie driver.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 Documentation/misc-devices/dw-xdata-pcie.rst | 40 ++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/misc-devices/dw-xdata-pcie.rst

diff --git a/Documentation/misc-devices/dw-xdata-pcie.rst b/Documentation/misc-devices/dw-xdata-pcie.rst
new file mode 100644
index 00000000..3af9fad
--- /dev/null
+++ b/Documentation/misc-devices/dw-xdata-pcie.rst
@@ -0,0 +1,40 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================================================================
+Driver for Synopsys DesignWare PCIe traffic generator (also known as xData)
+===========================================================================
+
+This driver should be used as a host-side (Root Complex) driver and Synopsys
+DesignWare prototype that includes this IP.
+
+The "dw-xdata-pcie" driver can be used to enable/disable PCIe traffic
+generator in either direction (mutual exclusion) besides allowing the
+PCIe link performance analysis.
+
+The interaction with this driver is done through the module parameter and
+can be changed in runtime. The driver outputs the requested command state
+information to /var/log/kern.log or dmesg.
+
+Request write TLPs traffic generation - Root Complex to Endpoint direction
+- Command:
+	echo 1 > /sys/kernel/dw-xdata-pcie/write
+
+Get write TLPs traffic link throughput
+- Command:
+        cat /sys/kernel/dw-xdata-pcie/write
+- Output example:
+	204 MB/s
+
+Request read TLPs traffic generation - Endpoint to Root Complex direction:
+- Command:
+	echo 1 > /sys/kernel/dw-xdata-pcie/read
+
+Get read TLPs traffic link throughput
+- Command:
+        cat /sys/kernel/dw-xdata-pcie/read
+- Output example:
+	199 MB/s
+
+Request to stop any current TLP transfer:
+- Command:
+	echo 1 > /sys/kernel/dw-xdata-pcie/stop
-- 
2.7.4

