Return-Path: <SRS0=zNOM=TJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C01C04AB2
	for <linux-pci@archiver.kernel.org>; Thu,  9 May 2019 14:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68EA1217F4
	for <linux-pci@archiver.kernel.org>; Thu,  9 May 2019 14:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557411320;
	bh=+Tqx2ZsfBXHVTC3F05yip1KSyHDoGe7vb2iNS1EXLDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D6Aqa3jeseV/9G8w+XcytwU2Rrg/WWGXXEBweFKmIjxB4isCTEyHvvS+w+ksBM4wt
	 HsmjRRgWEnJt1AklWOplcLyFaGVPLk4+GPpN7SwgwigJug8w3Vx4ZF6g0ARnCSi6na
	 PXsthyeuQaYOnuw9KNfTUN5zpy5hu6WydriwrG+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfEIOPT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 9 May 2019 10:15:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbfEIOPS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 May 2019 10:15:18 -0400
Received: from localhost (50-81-63-4.client.mchsi.com [50.81.63.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EEE221479;
        Thu,  9 May 2019 14:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557411317;
        bh=+Tqx2ZsfBXHVTC3F05yip1KSyHDoGe7vb2iNS1EXLDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ze8QwqqiEz+4nflRXNep7RAlibxWIhyy3R93IdBkCQkps9bjinpVBz7MTNblguEKH
         SFPkI2KSrMCrzbqRta5Li7Be6FJRVUHIRufRJa86FbK8iHwtSyA4xSpkOPQsC7oyAI
         ri8gf3ajPQRpsuRNzoI/FxtjTf+H9eXtf6Ry7Mas=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frederick Lawler <fred@fredlawl.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 08/10] PCI: pciehp: Remove unused dbg/err/info/warn() wrappers
Date:   Thu,  9 May 2019 09:14:54 -0500
Message-Id: <20190509141456.223614-9-helgaas@kernel.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190509141456.223614-1-helgaas@kernel.org>
References: <20190509141456.223614-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frederick Lawler <fred@fredlawl.com>

Replace the last uses of dbg() with the equivalent pr_debug(), then remove
unused dbg(), err(), info(), and warn() wrappers.

Link: https://lore.kernel.org/lkml/20190503035946.23608-9-fred@fredlawl.com
Signed-off-by: Frederick Lawler <fred@fredlawl.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp.h      | 9 ---------
 drivers/pci/hotplug/pciehp_core.c | 4 ++--
 drivers/pci/hotplug/pciehp_hpc.c  | 2 +-
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 2f0295b48d5d..c206fd9cd3d7 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -34,15 +34,6 @@ extern int pciehp_poll_time;
  * Set CONFIG_DYNAMIC_DEBUG=y and boot with 'dyndbg="file pciehp* +p"' to
  * enable debug messages.
  */
-#define dbg(format, arg...)						\
-	pr_debug(format, ## arg);
-#define err(format, arg...)						\
-	pr_err(format, ## arg)
-#define info(format, arg...)						\
-	pr_info(format, ## arg)
-#define warn(format, arg...)						\
-	pr_warn(format, ## arg)
-
 #define ctrl_dbg(ctrl, format, arg...)					\
 	pci_dbg(ctrl->pcie->port, format, ## arg)
 #define ctrl_err(ctrl, format, arg...)					\
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index b85b22880c50..1643e9aa261c 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -328,9 +328,9 @@ int __init pcie_hp_init(void)
 	int retval = 0;
 
 	retval = pcie_port_service_register(&hpdriver_portdrv);
-	dbg("pcie_port_service_register = %d\n", retval);
+	pr_debug("pcie_port_service_register = %d\n", retval);
 	if (retval)
-		dbg("Failure to register service\n");
+		pr_debug("Failure to register service\n");
 
 	return retval;
 }
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 913c7e66504f..9ce93b1034bd 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -235,7 +235,7 @@ static bool pci_bus_check_dev(struct pci_bus *bus, int devfn)
 	} while (delay > 0);
 
 	if (count > 1)
-		dbg("pci %04x:%02x:%02x.%d id reading try %d times with interval %d ms to get %08x\n",
+		pr_debug("pci %04x:%02x:%02x.%d id reading try %d times with interval %d ms to get %08x\n",
 			pci_domain_nr(bus), bus->number, PCI_SLOT(devfn),
 			PCI_FUNC(devfn), count, step, l);
 
-- 
2.21.0.1020.gf2820cf01a-goog

