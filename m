Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F95C433F5
	for <linux-pci@archiver.kernel.org>; Tue, 22 Feb 2022 16:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbiBVQcn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 22 Feb 2022 11:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbiBVQcn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 11:32:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C41C6E8E7;
        Tue, 22 Feb 2022 08:32:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E51E260A55;
        Tue, 22 Feb 2022 16:32:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300F4C340EB;
        Tue, 22 Feb 2022 16:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645547537;
        bh=n4zs+rZb5Rlpi273Kls2o3HUlG6Pi72lTm7KhhiQ3to=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jBS+hSK7FvHzJ4KJJb6jBaOIQEK+f6qtFKHYv9nuUQH9ve9izvlgUKOKQjxkdm7LX
         KCIGQmVr/56Jd0jfstuBiQ3RMzogSOoayEoNCySFZKAq3lY3iMWqgjIqvf0DSCAn+f
         7XhH03EP7XiXjf9CGECc3s/jLdPGiWvILRYp3DKdMGJVPgVuW3/PKBYbWC/WUSQykt
         WAf1PiiBKmBK14hk4eNPfiBV1fIew2j4wueqal2AmEU4U9xPLoDUFiIY+7Ok0VBYvL
         oHGF9vLOWh76jNAIKuHiOVYg1Klmw8ApH+4V7FUAOZonRNTGlq4pa1gGKFszKoj0bV
         I0aOm901Uph8Q==
Received: by pali.im (Postfix)
        id 1537E2B5E; Tue, 22 Feb 2022 17:32:15 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Gregory Clement <gregory.clement@bootlin.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] PCI: Add PCI_EXP_SLTCTL_ASPL_DISABLE macro
Date:   Tue, 22 Feb 2022 17:31:53 +0100
Message-Id: <20220222163158.1666-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220222163158.1666-1-pali@kernel.org>
References: <20220222163158.1666-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add macro defining Auto Slot Power Limit Disable bit in Slot Control
Register.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 include/uapi/linux/pci_regs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index bee1a9ed6e66..108f8523fa04 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -616,6 +616,7 @@
 #define  PCI_EXP_SLTCTL_PWR_OFF        0x0400 /* Power Off */
 #define  PCI_EXP_SLTCTL_EIC	0x0800	/* Electromechanical Interlock Control */
 #define  PCI_EXP_SLTCTL_DLLSCE	0x1000	/* Data Link Layer State Changed Enable */
+#define  PCI_EXP_SLTCTL_ASPL_DISABLE	0x2000 /* Auto Slot Power Limit Disable */
 #define  PCI_EXP_SLTCTL_IBPD_DISABLE	0x4000 /* In-band PD disable */
 #define PCI_EXP_SLTSTA		0x1a	/* Slot Status */
 #define  PCI_EXP_SLTSTA_ABP	0x0001	/* Attention Button Pressed */
-- 
2.20.1

