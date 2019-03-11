Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421AAC10F0B
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 13:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145E62230D
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 13:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="pBtieKAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfCKNbh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:31:37 -0400
Received: from mta-01.yadro.com ([89.207.88.251]:50954 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbfCKNbg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 09:31:36 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 9F6AB419ED;
        Mon, 11 Mar 2019 13:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1552311093; x=1554125494; bh=2YSqpqAp7RereidNxrz9EwHm+jdyZfSmbhy
        QTmFWZz4=; b=pBtieKAH1ePQi9Lvjq2H4QrxcTyHuS1RjjXzNZPbBSO8CLTE7BE
        NUiVfpiuAQiRnrGRCzAzVHwhI63qXb4aVI4CaJz3GQ8TyJQTJqiB9tEgpkHvVZ81
        v9FAav89QEgCjAkXBvO58abT5PtTpDJzBOXeDGp8eNE2Nw1WYPX7D+qk=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id z03ACO5LPSsC; Mon, 11 Mar 2019 16:31:33 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 61CA441988;
        Mon, 11 Mar 2019 16:31:31 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 11
 Mar 2019 16:31:30 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH RFC v4 05/21] PCI: hotplug: Add a flag for the movable BARs feature
Date:   Mon, 11 Mar 2019 16:31:06 +0300
Message-ID: <20190311133122.11417-6-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
References: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If a new PCIe device has been hot-plugged between the two active ones
without big enough gap between their BARs, these BARs should be moved
if their drivers support this feature. The drivers should be notified
and paused during the procedure:

1)                 dev 8 (new)
                       |
                       v
.. |  dev 3  |  dev 3  |  dev 5  |  dev 7  |
.. |  BAR 0  |  BAR 1  |  BAR 0  |  BAR 0  |

2)                             dev 8
                                 |
                                 v
.. |  dev 3  |  dev 3  | -->           --> |  dev 5  |  dev 7  |
.. |  BAR 0  |  BAR 1  | -->           --> |  BAR 0  |  BAR 0  |

 3)

.. |  dev 3  |  dev 3  |  dev 8  |  dev 8  |  dev 5  |  dev 7  |
.. |  BAR 0  |  BAR 1  |  BAR 0  |  BAR 1  |  BAR 0  |  BAR 0  |

Thus, prior reservation of memory regions by BIOS/bootloader/firmware
is not required anymore for the PCIe hotplug.

The PCI_MOVABLE_BARS flag is set by the platform is this feature is
supported and tested, but can be overridden by the following command
line option:
    pcie_movable_bars={ off | force }

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 .../admin-guide/kernel-parameters.txt         |  7 ++++++
 drivers/pci/pci.c                             | 24 +++++++++++++++++++
 include/linux/pci.h                           |  2 ++
 3 files changed, 33 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2b8ee90bb644..d40eaf993f80 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3417,6 +3417,13 @@
 		nomsi	Do not use MSI for native PCIe PME signaling (this makes
 			all PCIe root ports use INTx for all services).
 
+	pcie_movable_bars=[PCIE]
+			Override the movable BARs support detection:
+		off
+			Disable even if supported by the platform
+		force
+			Enable even if not explicitly declared as supported
+
 	pcmv=		[HW,PCMCIA] BadgePAD 4
 
 	pd_ignore_unused
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 69898fe5255e..4dac49a887ec 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -139,6 +139,30 @@ static int __init pcie_port_pm_setup(char *str)
 }
 __setup("pcie_port_pm=", pcie_port_pm_setup);
 
+static bool pcie_movable_bars_off;
+static bool pcie_movable_bars_force;
+static int __init pcie_movable_bars_setup(char *str)
+{
+	if (!strcmp(str, "off"))
+		pcie_movable_bars_off = true;
+	else if (!strcmp(str, "force"))
+		pcie_movable_bars_force = true;
+	return 1;
+}
+__setup("pcie_movable_bars=", pcie_movable_bars_setup);
+
+bool pci_movable_bars_enabled(void)
+{
+	if (pcie_movable_bars_off)
+		return false;
+
+	if (pcie_movable_bars_force)
+		return true;
+
+	return pci_has_flag(PCI_MOVABLE_BARS);
+}
+EXPORT_SYMBOL(pci_movable_bars_enabled);
+
 /* Time to wait after a reset for device to become responsive */
 #define PCIE_RESET_READY_POLL_MS 60000
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index cb2760a31fe2..cbe661aff9f5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -866,6 +866,7 @@ enum {
 	PCI_ENABLE_PROC_DOMAINS	= 0x00000010,	/* Enable domains in /proc */
 	PCI_COMPAT_DOMAIN_0	= 0x00000020,	/* ... except domain 0 */
 	PCI_SCAN_ALL_PCIE_DEVS	= 0x00000040,	/* Scan all, not just dev 0 */
+	PCI_MOVABLE_BARS	= 0x00000080,	/* Runtime BAR reassign after hotplug */
 };
 
 /* These external functions are only available when PCI support is enabled */
@@ -1345,6 +1346,7 @@ unsigned char pci_bus_max_busnr(struct pci_bus *bus);
 void pci_setup_bridge(struct pci_bus *bus);
 resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 					 unsigned long type);
+bool pci_movable_bars_enabled(void);
 
 #define PCI_VGA_STATE_CHANGE_BRIDGE (1 << 0)
 #define PCI_VGA_STATE_CHANGE_DECODES (1 << 1)
-- 
2.20.1

