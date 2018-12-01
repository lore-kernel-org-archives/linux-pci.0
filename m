Return-Path: <SRS0=IfUz=OK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E934C04EB9
	for <linux-pci@archiver.kernel.org>; Sat,  1 Dec 2018 20:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C0A2148E
	for <linux-pci@archiver.kernel.org>; Sat,  1 Dec 2018 20:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qxo7u8RC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C0A2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725746AbeLBHzK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 2 Dec 2018 02:55:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:52840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725726AbeLBHzK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 2 Dec 2018 02:55:10 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.87.65.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 397B221473;
        Sat,  1 Dec 2018 20:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543696907;
        bh=Lxa+tqGCpYkV+x0N9nXY11IdiWx9UetACQJABYQl8QA=;
        h=From:To:Cc:Subject:Date:From;
        b=Qxo7u8RCKFft8BpOSYtLk3H7DJdS73aOy5xPj03GVwAkrAkYDCa2XrZB4xfdJzZNf
         d/U0n+87Fg9U85Bdzu9Z5eEbAlyVRymScT86WC4u1tejLnf0Rvr/DbkjjPerhshOHe
         IcC07ZljC5osOJ/Qh1rQ3wRwgmb7AK9H+hU7io3A=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1 1/2] PCI: Stub out read/write/raw/find functions
Date:   Sat,  1 Dec 2018 20:41:35 +0000
Message-Id: <20181201204137.1786-1-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Need stub functions in order to be able to compile ACPI without PCI
support.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 include/linux/pci.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 11c71c4ecf75..15407f469d41 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -682,10 +682,22 @@ struct pci_ops {
  * ACPI needs to be able to access PCI config space before we've done a
  * PCI bus scan and created pci_bus structures.
  */
+#ifdef CONFIG_PCI
 int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
 		 int reg, int len, u32 *val);
 int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
 		  int reg, int len, u32 val);
+#else
+static inline int raw_pci_read(unsigned int domain, unsigned int bus,
+			       unsigned int devfn, int reg, int len, u32 *val)
+{
+	*val = 0;
+	return -EINVAL;
+}
+static inline int raw_pci_write(unsigned int domain, unsigned int bus,
+				unsigned int devfn, int reg, int len, u32 val)
+{ return -EINVAL; }
+#endif
 
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 typedef u64 pci_bus_addr_t;
@@ -1599,7 +1611,27 @@ pci_release_mem_regions(struct pci_dev *pdev)
 }
 
 #else /* CONFIG_PCI is not enabled */
+static inline int pci_bus_read_config_byte(struct pci_bus *bus,
+		unsigned int devfn, int where, u8 *val)
+{ return -EINVAL; }
 
+static inline int pci_bus_read_config_word(struct pci_bus *bus,
+		unsigned int devfn, int where, u16 *val)
+{ return -EINVAL; }
+static inline int pci_bus_read_config_dword(struct pci_bus *bus,
+		unsigned int devfn, int where, u32 *val)
+{ return -EINVAL; }
+static inline int pci_bus_write_config_byte(struct pci_bus *bus,
+		unsigned int devfn, int where, u8 val)
+{ return -EINVAL; }
+static inline int pci_bus_write_config_word(struct pci_bus *bus,
+		unsigned int devfn, int where, u16 val)
+{ return -EINVAL; }
+static inline int pci_bus_write_config_dword(struct pci_bus *bus,
+		unsigned int devfn, int where, u32 val)
+{ return -EINVAL; }
+static inline struct pci_bus *pci_find_bus(int domain, int busnr)
+{ return NULL; }
 static inline void pci_set_flags(int flags) { }
 static inline void pci_add_flags(int flags) { }
 static inline void pci_clear_flags(int flags) { }
-- 
2.19.0

