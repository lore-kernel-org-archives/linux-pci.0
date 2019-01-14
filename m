Return-Path: <SRS0=hqs4=PW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6A9C43387
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 21:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2306206B7
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 21:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547501750;
	bh=2w7+vAZ6yFF4JF79s2c+ecaXQ+eVfw30Us2S0VtqQ5s=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Qi+jjr0bciFBLjOdi5v/dj/1MbdZ0tb2tBOEonB8naZr+WbYvTVqfVHzsoLTUCEHu
	 0sBT7koXgdkzr3x1XvR8zTX4NET238zVBDr+X+nMYGs3afulH8Lvd7x5gVEPcp6eMy
	 tQxi7QhXPJLlxBclMK2mAFez7Z5+Zlq4sE4bM/nc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfANVfs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Jan 2019 16:35:48 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38792 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfANVfs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jan 2019 16:35:48 -0500
Received: by mail-ot1-f65.google.com with SMTP id e12so550895otl.5;
        Mon, 14 Jan 2019 13:35:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VFxSfBlIpfXhHdapMQNXFs7zylQd4xivQd76Us4yDW4=;
        b=YmX3H4al8s+40YuwQUNRM/A6t2cfrS/fpSID1Dj6sKDeyRuFlobygjQuyL+Z2byer6
         dfny/4+K/qaQ8p9UDlnHYHXFFEHcu2GBmnaJBPb6t4wdg/CQzkAAoDLwJ74VVEmGbCPI
         q6i57lfYJVDEeebzqu2Wxkgbndnpc2nIyfUcyGGgVrSPTihmdp5SMW5N1RFZhGoghq/b
         U8q+gTr67TiBk1V5UD3ZSA8G/Rwer5yDTtVr4dD8Ue9C5RmWnk2+MDFRv2Z2zmJx9pES
         OGD9RLUUTzmMTRynb0bPBHEK+7pUj4jvpUtr8k0SBWbaArATzXgISjeYL0JhuTLvcd9R
         P9IA==
X-Gm-Message-State: AJcUukeXH+LRwG/x+J59BVZ8ZrrjrjWsUD+3ncR0nEBPz4i7joY0HvS6
        EyH04SNuaxVVIcuYlodSfwFFN5Q=
X-Google-Smtp-Source: ALg8bN7lkWxJBaJEgP3xVUCf4mNaiMoKN52W8mdNS1iFAQcxzUpUmfeRPluMWdqHSiOjMiupOIOODg==
X-Received: by 2002:a9d:6191:: with SMTP id g17mr359317otk.56.1547501747476;
        Mon, 14 Jan 2019 13:35:47 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id p129sm649701oif.17.2019.01.14.13.35.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 14 Jan 2019 13:35:46 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Fix PCI kconfig menu organization
Date:   Mon, 14 Jan 2019 15:35:46 -0600
Message-Id: <20190114213546.9921-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

After commit eb01d42a7778 ("PCI: consolidate PCI config entry in
drivers/pci"), all the PCI kconfig options appear below "PCI support"
rather than within a sub-menu. This is because menuconfig expects all
kconfig entries to be enclosed in an if/endif section. Add the missing
if/endif.

With this, "depends on PCI" is redundant in the sub-menu  entries and
can be removed.

Fixes: eb01d42a7778 ("PCI: consolidate PCI config entry in drivers/pci")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/Kconfig | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 4310c7a4212e..2ab92409210a 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -21,13 +21,14 @@ menuconfig PCI
 	  support for PCI-X and the foundations for PCI Express support.
 	  Say 'Y' here unless you know what you are doing.
 
+if PCI
+
 config PCI_DOMAINS
 	bool
 	depends on PCI
 
 config PCI_DOMAINS_GENERIC
 	bool
-	depends on PCI
 	select PCI_DOMAINS
 
 config PCI_SYSCALL
@@ -37,7 +38,6 @@ source "drivers/pci/pcie/Kconfig"
 
 config PCI_MSI
 	bool "Message Signaled Interrupts (MSI and MSI-X)"
-	depends on PCI
 	select GENERIC_MSI_IRQ
 	help
 	   This allows device drivers to enable MSI (Message Signaled
@@ -59,7 +59,6 @@ config PCI_MSI_IRQ_DOMAIN
 config PCI_QUIRKS
 	default y
 	bool "Enable PCI quirk workarounds" if EXPERT
-	depends on PCI
 	help
 	  This enables workarounds for various PCI chipset bugs/quirks.
 	  Disable this only if your target machine is unaffected by PCI
@@ -67,7 +66,7 @@ config PCI_QUIRKS
 
 config PCI_DEBUG
 	bool "PCI Debugging"
-	depends on PCI && DEBUG_KERNEL
+	depends on DEBUG_KERNEL
 	help
 	  Say Y here if you want the PCI core to produce a bunch of debug
 	  messages to the system log.  Select this if you are having a
@@ -77,7 +76,6 @@ config PCI_DEBUG
 
 config PCI_REALLOC_ENABLE_AUTO
 	bool "Enable PCI resource re-allocation detection"
-	depends on PCI
 	depends on PCI_IOV
 	help
 	  Say Y here if you want the PCI core to detect if PCI resource
@@ -90,7 +88,6 @@ config PCI_REALLOC_ENABLE_AUTO
 
 config PCI_STUB
 	tristate "PCI Stub driver"
-	depends on PCI
 	help
 	  Say Y or M here if you want be able to reserve a PCI device
 	  when it is going to be assigned to a guest operating system.
@@ -99,7 +96,6 @@ config PCI_STUB
 
 config PCI_PF_STUB
 	tristate "PCI PF Stub driver"
-	depends on PCI
 	depends on PCI_IOV
 	help
 	  Say Y or M here if you want to enable support for devices that
@@ -111,7 +107,7 @@ config PCI_PF_STUB
 
 config XEN_PCIDEV_FRONTEND
         tristate "Xen PCI Frontend"
-        depends on PCI && X86 && XEN
+        depends on X86 && XEN
         select PCI_XEN
 	select XEN_XENBUS_FRONTEND
         default y
@@ -133,7 +129,6 @@ config PCI_BRIDGE_EMUL
 
 config PCI_IOV
 	bool "PCI IOV support"
-	depends on PCI
 	select PCI_ATS
 	help
 	  I/O Virtualization is a PCI feature supported by some devices
@@ -144,7 +139,6 @@ config PCI_IOV
 
 config PCI_PRI
 	bool "PCI PRI support"
-	depends on PCI
 	select PCI_ATS
 	help
 	  PRI is the PCI Page Request Interface. It allows PCI devices that are
@@ -154,7 +148,6 @@ config PCI_PRI
 
 config PCI_PASID
 	bool "PCI PASID support"
-	depends on PCI
 	select PCI_ATS
 	help
 	  Process Address Space Identifiers (PASIDs) can be used by PCI devices
@@ -167,7 +160,7 @@ config PCI_PASID
 
 config PCI_P2PDMA
 	bool "PCI peer-to-peer transfer support"
-	depends on PCI && ZONE_DEVICE
+	depends on ZONE_DEVICE
 	select GENERIC_ALLOCATOR
 	help
 	  Enableѕ drivers to do PCI peer-to-peer transactions to and from
@@ -184,12 +177,11 @@ config PCI_P2PDMA
 
 config PCI_LABEL
 	def_bool y if (DMI || ACPI)
-	depends on PCI
 	select NLS
 
 config PCI_HYPERV
         tristate "Hyper-V PCI Frontend"
-        depends on PCI && X86 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && X86_64
+        depends on X86 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && X86_64
         help
           The PCI device frontend driver allows the kernel to import arbitrary
           PCI devices from a PCI backend to support PCI driver domains.
@@ -198,3 +190,5 @@ source "drivers/pci/hotplug/Kconfig"
 source "drivers/pci/controller/Kconfig"
 source "drivers/pci/endpoint/Kconfig"
 source "drivers/pci/switch/Kconfig"
+
+endif
-- 
2.19.1

